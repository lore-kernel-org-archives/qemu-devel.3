Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AF5C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 23:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzOlg-0005Bd-4R; Mon, 31 Mar 2025 19:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzOle-0005BS-4j
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:42:11 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzOlc-0002Pv-6r
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:42:09 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3014678689aso6978353a91.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743464526; x=1744069326; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDxhXR9uJalPi7kLhFptx/zx0EtrR/ilSk2IETwFG7M=;
 b=A5tS9Gg+N3lPamGUlOQqPyEjAdXDFbIKZ42EDoWcmjBXpjQM+/yKLXTK7VgEvf2d4v
 yZWexuuoJkd2KW3M9dydiQs4uqhInx7zVUIDvlr0GGyJmgUB1SMR9LjTGLPd3QDMQba9
 2zjSVwvJUtHIHI2okayS86KFhY8hyMhMbKh6MPVqtJ8USNswtuctUfiHgiYYeRUMGBoy
 zDIrojqwEom/a4y4gyggLE9nTJn7y8NAUMgpsku2Ari8mXOhW78OZqYgRfcKkDEQPLH0
 QppuxLbcU93Ohi1ZvWiMxM98/GfhtagMNa7foiDB65hFdw2RScwj2zRQINqYxzoFN54m
 6zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743464526; x=1744069326;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dDxhXR9uJalPi7kLhFptx/zx0EtrR/ilSk2IETwFG7M=;
 b=jhIWrCAiX7OVkKsv+CTPDEv4aQaED0dk/XbEAN03ntBDYcawfINuY+2DqI4VtNsp4M
 y3W4W8bB3NMPPABIbBTZdF2D8gNhVWjsViXdnfvR7qmkk72XKL1lY44hQlhmNOKUKeqi
 gtErD5HbCZYmknHjCPqhgs/UbAbxNAIZDU0CWjXY3unhvCd+DV395VzfNSJdDFJ2hK+e
 FwmWJ8zuWonksFFa7gg3nJ1Gb7VPs0mgy6t16jgpWsjw4EtoUEA3Zp/F1bg3y8CV57xj
 CO9B9tl2wsUEGEucH8hIHAVyPxruirx88XhHkJAPMc+/rdYsAsoPLb/R5JgicvzN4RcU
 FB3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX23zY2j6MrPCneHlMUMoMI1PYYaRRYEMLO5kEgD5K0lK2gv4rOpPQy2TE7hOF7XB43i4brgsAGijB/@nongnu.org
X-Gm-Message-State: AOJu0YyYCCEWklOV3ocOPk+EJYCnIx+FplolGrAFWBUu3eFf0iMnLop/
 TrHBugWfdnV0yt5IUj68sLN09hXsf6wiVRjsFljEYrkkBt+UCMTw
X-Gm-Gg: ASbGncslvMjaaJveQ6Lj81nJnSlV1onwFNvglUXDn3W89xe6G2DTQCCWWH29GsFOl2y
 M5WLlDefsJD7PlGecM1Jf2FO7xjxodeTk9htOmLr8wglffSpaZ1uUGM/UJl/C2+Hgv0fvq+I8a5
 ZPNGkucEYi8OOxJuD3NlJlCBB9aH3UsJZeLsv+UHICnsQEhF2Asc2hZXNsaEZT2qizZ1udwLwz8
 BJzZppMsqBl761VjK6IRHXsLyLKn9lon9PjWz2iqCS9EzwQD/rt3KWWEXzmmLjkQHWlwybfxvA4
 f9XxFFMMMmXPr5Th+Rt/VYX4UslyvULPtsBeGpY=
X-Google-Smtp-Source: AGHT+IGIMS4Ix+vR9ZgPtr0/IhYNSjUk6UTITxhnXk709InHno0aglxUK9PAifzAgXMwYqMfs8gpKg==
X-Received: by 2002:a17:90b:264e:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-30531fa16bbmr17868759a91.8.1743464526387; 
 Mon, 31 Mar 2025 16:42:06 -0700 (PDT)
Received: from localhost ([203.185.207.94]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dff0529sm11370385a91.16.2025.03.31.16.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 16:42:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 09:42:01 +1000
Message-Id: <D8UULC4ZS27K.2JYUFGLKD5Q8Q@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: <corey@minyard.net>
Cc: "Corey Minyard" <minyard@acm.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/3] ipmi/bmc-sim: Add 'Get Channel Info' command
X-Mailer: aerc 0.19.0
References: <20250331125724.607355-1-npiggin@gmail.com>
 <20250331125724.607355-4-npiggin@gmail.com>
 <Z-qX2R9o-kpby24z@mail.minyard.net>
In-Reply-To: <Z-qX2R9o-kpby24z@mail.minyard.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon Mar 31, 2025 at 11:25 PM AEST, Corey Minyard wrote:
> On Mon, Mar 31, 2025 at 10:57:24PM +1000, Nicholas Piggin wrote:
>> Linux issues this command when booting a powernv machine.
>
> This is good, just a couple of nits.
>
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  include/hw/ipmi/ipmi.h | 14 +++++++++++
>>  hw/ipmi/ipmi_bmc_sim.c | 56 ++++++++++++++++++++++++++++++++++++++++--
>>  hw/ipmi/ipmi_bt.c      |  2 ++
>>  hw/ipmi/ipmi_kcs.c     |  1 +
>>  4 files changed, 71 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
>> index 77a7213ed93..5f01a50cd86 100644
>> --- a/include/hw/ipmi/ipmi.h
>> +++ b/include/hw/ipmi/ipmi.h
>> @@ -41,6 +41,15 @@ enum ipmi_op {
>>      IPMI_SEND_NMI
>>  };
>> =20
>> +/* Channel properties */
>> +#define IPMI_CHANNEL_IPMB                0x00
>> +#define IPMI_CHANNEL_SYSTEM              0x0f
>> +#define IPMI_CH_MEDIUM_IPMB              0x01
>> +#define IPMI_CH_MEDIUM_SYSTEM            0x0c
>> +#define IPMI_CH_PROTOCOL_IPMB            0x01
>> +#define IPMI_CH_PROTOCOL_KCS             0x05
>> +#define IPMI_CH_PROTOCOL_BT_15           0x08
>
> I know it's picky, but could you spell out CHANNEL here?

Sure.

>> +
>>  #define IPMI_CC_INVALID_CMD                              0xc1
>>  #define IPMI_CC_COMMAND_INVALID_FOR_LUN                  0xc2
>>  #define IPMI_CC_TIMEOUT                                  0xc3
>> @@ -170,6 +179,11 @@ struct IPMIInterfaceClass {
>>       * Return the firmware info for a device.
>>       */
>>      void (*get_fwinfo)(struct IPMIInterface *s, IPMIFwInfo *info);
>> +
>> +    /*
>> +     * IPMI channel protocol type number.
>> +     */
>> +    uint8_t protocol;
>>  };
>> =20
>>  /*
>> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
>> index 8c3313aa65f..9198f854bd9 100644
>> --- a/hw/ipmi/ipmi_bmc_sim.c
>> +++ b/hw/ipmi/ipmi_bmc_sim.c
>> @@ -70,6 +70,7 @@
>>  #define IPMI_CMD_GET_MSG                  0x33
>>  #define IPMI_CMD_SEND_MSG                 0x34
>>  #define IPMI_CMD_READ_EVT_MSG_BUF         0x35
>> +#define IPMI_CMD_GET_CHANNEL_INFO         0x42
>> =20
>>  #define IPMI_NETFN_STORAGE            0x0a
>> =20
>> @@ -1033,8 +1034,8 @@ static void send_msg(IPMIBmcSim *ibs,
>>      uint8_t *buf;
>>      uint8_t netfn, rqLun, rsLun, rqSeq;
>> =20
>> -    if (cmd[2] !=3D 0) {
>> -        /* We only handle channel 0 with no options */
>> +    if (cmd[2] !=3D IPMI_CHANNEL_IPMB) {
>> +        /* We only handle channel 0h (IPMB) with no options */
>>          rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
>>          return;
>>      }
>> @@ -1232,6 +1233,56 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,
>>      }
>>  }
>> =20
>> +static void get_channel_info(IPMIBmcSim *ibs,
>> +                             uint8_t *cmd, unsigned int cmd_len,
>> +                             RspBuffer *rsp)
>> +{
>> +    IPMIInterface *s =3D ibs->parent.intf;
>> +    IPMIInterfaceClass *k =3D IPMI_INTERFACE_GET_CLASS(s);
>> +    uint8_t ch =3D cmd[1] & 0x0f;
>> +
>> +    /* Only define channel 0h (IPMB) and Fh (system interface) */
>> +
>> +    if (ch =3D=3D 0x0e) { /* "This channel" */
>> +        ch =3D IPMI_CHANNEL_SYSTEM;
>> +    }
>> +    rsp_buffer_push(rsp, ch);
>> +
>> +    if (ch !=3D IPMI_CHANNEL_IPMB && ch !=3D IPMI_CHANNEL_SYSTEM) {
>> +        /* Not supported */
>
> I think that an all zero response is a valid response.  I think you
> should return a IPMI_CC_INVALID_DATA_FIELD instead, right?

I can't remember, I dug the patch out from a while ago. I can't actually
see anywhere it is made clear in the spec, do you? I agree an invalid
error sounds better. I'll try to see how ipmi tools handles it.

>> +        int i;
>> +        for (i =3D 0; i < 8; i++) {
>> +            rsp_buffer_push(rsp, 0x00);
>> +        }
>> +        return;
>> +    }
>> +
>> +    if (ch =3D=3D IPMI_CHANNEL_IPMB) {
>> +        rsp_buffer_push(rsp, IPMI_CH_MEDIUM_IPMB);
>> +        rsp_buffer_push(rsp, IPMI_CH_PROTOCOL_IPMB);
>> +    } else { /* IPMI_CHANNEL_SYSTEM */
>> +        rsp_buffer_push(rsp, IPMI_CH_MEDIUM_SYSTEM);
>> +        rsp_buffer_push(rsp, k->protocol);
>> +    }
>> +
>> +    rsp_buffer_push(rsp, 0x00); /* Session-less */
>> +
>> +    /* IPMI Vendor ID */
>> +    rsp_buffer_push(rsp, 0xf2);
>> +    rsp_buffer_push(rsp, 0x1b);
>> +    rsp_buffer_push(rsp, 0x00);
>
> Where does this come from?

IPMI spec Get Channel Info Command, search "IPMI Enterprise Number"
From my reading, all channel info responses contain this.

>> +
>> +    if (ch =3D=3D IPMI_CHANNEL_SYSTEM) {
>> +        /* IRQ assigned by ACPI/PnP (XXX?) */
>> +        rsp_buffer_push(rsp, 0x60);
>> +        rsp_buffer_push(rsp, 0x60);
>
> The interrupt should be available.  For the isa versions there is a
> get_fwinfo function pointer that you can fetch this with.  For PCI it's
> more complicated, unfortunately.

These are for the two interrupts. QEMU seems to tie both to the
same line, I guess that's okay?

That interface looks good, but what I was concerned about is whether
that implies the irq is hard coded or whether the platform can assign
it, does it mean unassigned? I don't know a lot about irq routing or
what IPMI clients would use it for.

Anyhow I'll respin with changes.

Thanks,
Nick

