Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCDAC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzF9S-0000r6-6M; Mon, 31 Mar 2025 09:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzF9L-0000qY-AF
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:26:00 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzF9I-0006Le-4k
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:25:58 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2c7e5f7f0e3so1199519fac.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743427555; x=1744032355;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hc7M5T1RbeXSxeGRh3KQFlWKqApoAGTisYvoo/yzzD4=;
 b=AFIcSeTYlbRv1vLHIby9ZQfpFsR6jXUhsCWiZ9OPh2rDMQnfDf718B6YT35JgL8hzH
 is23Z8ryX6onPXh24j6Qeo/OphrCQ+9yorrhSk5Hn2oVRzWHaGeud7xGpPqtqXA34GRY
 bjis2P0+JjiFf5IkDTgMFkKv8PxKfxkNiC06hnaolGnAz0plyz0KHL2Z4LFYMc2v0f0N
 cYSCXkKGwEKwp7WNtziVw/EuHzm4hGi/hLC+mgW7L6vMWQ+IIibPW3d8+UmXdOvaKySn
 6KKi/2nBDM39/+goUjQuxPu/pp3tku0IL/2gCrPGhOMfXvDJ9WpHteZXYAU+g2fH/ooE
 xiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743427555; x=1744032355;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hc7M5T1RbeXSxeGRh3KQFlWKqApoAGTisYvoo/yzzD4=;
 b=SZ2SbIEy0mzQPo3R7PGwYrB4sC2B5fwg55g8J2MqyhvxAVDnvEgYfxPFtbfBVPxF1Z
 SdOQ6OXAnBqdhc5SP6ic0Cqknz6HoIY8aDWsH/9tcubgLP5kVrBl4Sbqd7UZOY5g30aY
 ODfwu4G1UI/klEzJGLlo+PlzcLZdaeF9sHusO8UA3NThSy3dI2ztj96YSDw5RfIUYX0E
 IUqlvqZOej9jHqOdO1RZUplHeiLZfnLKCiBtAUJn2oJ/3ni54uIHZL7GUd4Dy4pWyWnS
 BVUXm3CWJwQyWm+KfreH2I32kyCUU5DvJt1DeoachYtSt+cx2dkFXQtYD6RZ5cyv/tXs
 U2mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu/LB4uIpc0XYLJppowwaFX3paZMccoyayZpBGMze3J0S40xV2m8D6mxmNytl3Sdem6Sdt3gGhtZJG@nongnu.org
X-Gm-Message-State: AOJu0Yxfi753hyVQb3NT5ioZjqIwq6Z2/ATg+U8ShYCJ2Axqk5DPFB4b
 vNN1k6vP92Q0HOIW+8MBYSeuX3XithcTdgcsuurjtgZZVwk5pHnG32OWTkDgcApnaWOj56TFoS0
 B
X-Gm-Gg: ASbGncsrP5TgF1eXoX7XGeroW4iVd+1P8t2HVgYtEXKikPXfyEV6SnuPuDtBVmQ7IF1
 39geme3TBlGH7xruaRDPggUJnr8o2StYTF3nkHXkzWvHI8OOLviaBMY5RVtSoWWOyZnyEPJPafP
 PZ0E9pZfh5xH9t03YF3vTIrtahzCT9x9S0PZrq5xg6HTWBL3CtpEnHJbRX7Ai5ZJ6HnyLml310Z
 8EEY4QyYPSACACw3h24sTl7c9grZrO8muKb0mO1Yyz7vUMjmVM5o3ZvV0CqUuw6779P68ASQ+zh
 DegTjfHCOyW3imSHAKzaL82LY2PV5DvmVqjhZjVO1kDD+Odn
X-Google-Smtp-Source: AGHT+IHPc6xzfva5xOSpG5/wAryPHX7/iHPeLkv0aHM4Qr3phmwR8YXIHdzDNZLg/hU9cSK3i8XmHA==
X-Received: by 2002:a05:6870:5308:b0:2c3:1680:d1a9 with SMTP id
 586e51a60fabf-2cbcf576c76mr4993645fac.22.1743427554652; 
 Mon, 31 Mar 2025 06:25:54 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:da64:426e:c0da:b180])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a48d7efsm1834155fac.14.2025.03.31.06.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:25:52 -0700 (PDT)
Date: Mon, 31 Mar 2025 08:25:45 -0500
From: Corey Minyard <corey@minyard.net>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] ipmi/bmc-sim: Add 'Get Channel Info' command
Message-ID: <Z-qX2R9o-kpby24z@mail.minyard.net>
References: <20250331125724.607355-1-npiggin@gmail.com>
 <20250331125724.607355-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331125724.607355-4-npiggin@gmail.com>
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=corey@minyard.net; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 31, 2025 at 10:57:24PM +1000, Nicholas Piggin wrote:
> Linux issues this command when booting a powernv machine.

This is good, just a couple of nits.

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/hw/ipmi/ipmi.h | 14 +++++++++++
>  hw/ipmi/ipmi_bmc_sim.c | 56 ++++++++++++++++++++++++++++++++++++++++--
>  hw/ipmi/ipmi_bt.c      |  2 ++
>  hw/ipmi/ipmi_kcs.c     |  1 +
>  4 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> index 77a7213ed93..5f01a50cd86 100644
> --- a/include/hw/ipmi/ipmi.h
> +++ b/include/hw/ipmi/ipmi.h
> @@ -41,6 +41,15 @@ enum ipmi_op {
>      IPMI_SEND_NMI
>  };
>  
> +/* Channel properties */
> +#define IPMI_CHANNEL_IPMB                0x00
> +#define IPMI_CHANNEL_SYSTEM              0x0f
> +#define IPMI_CH_MEDIUM_IPMB              0x01
> +#define IPMI_CH_MEDIUM_SYSTEM            0x0c
> +#define IPMI_CH_PROTOCOL_IPMB            0x01
> +#define IPMI_CH_PROTOCOL_KCS             0x05
> +#define IPMI_CH_PROTOCOL_BT_15           0x08

I know it's picky, but could you spell out CHANNEL here?

> +
>  #define IPMI_CC_INVALID_CMD                              0xc1
>  #define IPMI_CC_COMMAND_INVALID_FOR_LUN                  0xc2
>  #define IPMI_CC_TIMEOUT                                  0xc3
> @@ -170,6 +179,11 @@ struct IPMIInterfaceClass {
>       * Return the firmware info for a device.
>       */
>      void (*get_fwinfo)(struct IPMIInterface *s, IPMIFwInfo *info);
> +
> +    /*
> +     * IPMI channel protocol type number.
> +     */
> +    uint8_t protocol;
>  };
>  
>  /*
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 8c3313aa65f..9198f854bd9 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -70,6 +70,7 @@
>  #define IPMI_CMD_GET_MSG                  0x33
>  #define IPMI_CMD_SEND_MSG                 0x34
>  #define IPMI_CMD_READ_EVT_MSG_BUF         0x35
> +#define IPMI_CMD_GET_CHANNEL_INFO         0x42
>  
>  #define IPMI_NETFN_STORAGE            0x0a
>  
> @@ -1033,8 +1034,8 @@ static void send_msg(IPMIBmcSim *ibs,
>      uint8_t *buf;
>      uint8_t netfn, rqLun, rsLun, rqSeq;
>  
> -    if (cmd[2] != 0) {
> -        /* We only handle channel 0 with no options */
> +    if (cmd[2] != IPMI_CHANNEL_IPMB) {
> +        /* We only handle channel 0h (IPMB) with no options */
>          rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
>          return;
>      }
> @@ -1232,6 +1233,56 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,
>      }
>  }
>  
> +static void get_channel_info(IPMIBmcSim *ibs,
> +                             uint8_t *cmd, unsigned int cmd_len,
> +                             RspBuffer *rsp)
> +{
> +    IPMIInterface *s = ibs->parent.intf;
> +    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
> +    uint8_t ch = cmd[1] & 0x0f;
> +
> +    /* Only define channel 0h (IPMB) and Fh (system interface) */
> +
> +    if (ch == 0x0e) { /* "This channel" */
> +        ch = IPMI_CHANNEL_SYSTEM;
> +    }
> +    rsp_buffer_push(rsp, ch);
> +
> +    if (ch != IPMI_CHANNEL_IPMB && ch != IPMI_CHANNEL_SYSTEM) {
> +        /* Not supported */

I think that an all zero response is a valid response.  I think you
should return a IPMI_CC_INVALID_DATA_FIELD instead, right?

> +        int i;
> +        for (i = 0; i < 8; i++) {
> +            rsp_buffer_push(rsp, 0x00);
> +        }
> +        return;
> +    }
> +
> +    if (ch == IPMI_CHANNEL_IPMB) {
> +        rsp_buffer_push(rsp, IPMI_CH_MEDIUM_IPMB);
> +        rsp_buffer_push(rsp, IPMI_CH_PROTOCOL_IPMB);
> +    } else { /* IPMI_CHANNEL_SYSTEM */
> +        rsp_buffer_push(rsp, IPMI_CH_MEDIUM_SYSTEM);
> +        rsp_buffer_push(rsp, k->protocol);
> +    }
> +
> +    rsp_buffer_push(rsp, 0x00); /* Session-less */
> +
> +    /* IPMI Vendor ID */
> +    rsp_buffer_push(rsp, 0xf2);
> +    rsp_buffer_push(rsp, 0x1b);
> +    rsp_buffer_push(rsp, 0x00);

Where does this come from?

> +
> +    if (ch == IPMI_CHANNEL_SYSTEM) {
> +        /* IRQ assigned by ACPI/PnP (XXX?) */
> +        rsp_buffer_push(rsp, 0x60);
> +        rsp_buffer_push(rsp, 0x60);

The interrupt should be available.  For the isa versions there is a
get_fwinfo function pointer that you can fetch this with.  For PCI it's
more complicated, unfortunately.

-corey

> +    } else {
> +        /* Reserved */
> +        rsp_buffer_push(rsp, 0x00);
> +        rsp_buffer_push(rsp, 0x00);
> +    }
> +}
> +
>  static void get_sdr_rep_info(IPMIBmcSim *ibs,
>                               uint8_t *cmd, unsigned int cmd_len,
>                               RspBuffer *rsp)
> @@ -2028,6 +2079,7 @@ static const IPMICmdHandler app_cmds[] = {
>      [IPMI_CMD_RESET_WATCHDOG_TIMER] = { reset_watchdog_timer },
>      [IPMI_CMD_SET_WATCHDOG_TIMER] = { set_watchdog_timer, 8 },
>      [IPMI_CMD_GET_WATCHDOG_TIMER] = { get_watchdog_timer },
> +    [IPMI_CMD_GET_CHANNEL_INFO] = { get_channel_info, 3 },
>  };
>  static const IPMINetfn app_netfn = {
>      .cmd_nums = ARRAY_SIZE(app_cmds),
> diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
> index 583fc64730c..d639c151c4d 100644
> --- a/hw/ipmi/ipmi_bt.c
> +++ b/hw/ipmi/ipmi_bt.c
> @@ -434,4 +434,6 @@ void ipmi_bt_class_init(IPMIInterfaceClass *iic)
>      iic->handle_if_event = ipmi_bt_handle_event;
>      iic->set_irq_enable = ipmi_bt_set_irq_enable;
>      iic->reset = ipmi_bt_handle_reset;
> +    /* BT System Interface Format, IPMI v1.5 */
> +    iic->protocol = IPMI_CH_PROTOCOL_BT_15;
>  }
> diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
> index c15977cab4c..8af7698286d 100644
> --- a/hw/ipmi/ipmi_kcs.c
> +++ b/hw/ipmi/ipmi_kcs.c
> @@ -420,4 +420,5 @@ void ipmi_kcs_class_init(IPMIInterfaceClass *iic)
>      iic->handle_rsp = ipmi_kcs_handle_rsp;
>      iic->handle_if_event = ipmi_kcs_handle_event;
>      iic->set_irq_enable = ipmi_kcs_set_irq_enable;
> +    iic->protocol = IPMI_CH_PROTOCOL_KCS;
>  }
> -- 
> 2.47.1
> 

