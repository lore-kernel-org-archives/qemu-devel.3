Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691BAC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gMs-00032U-90; Fri, 04 Apr 2025 08:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gMp-00032I-R2
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:41:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0gMn-0001Cx-RC
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:41:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1623006f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743770508; x=1744375308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckYbVXM5y/oHY3AyYUtbqJnHtUAg7+Xu4MIsacAMf/E=;
 b=tDN8cf5IdGsWqU31n3eB/q3f4JFE7JDYBJe2AlotSUxITTxOwOhL0FFbjKdOXtZcAJ
 XibZYV9WHzIDBZHhsWD2ibLAps1oiAia9b+mPd2sWlnkO+K4VLj95rVLRP9vgXwnRHXi
 Dd4JOb653VS5a6Mddk8xZwc2FJQbeRf1SFySRJFK+Dkv4nYGWobFOvbT7U45LQtqVpjY
 hXhl8NMepoIq3jXP5YOM0vzvufkqlnhpGnpnYV4knN6RZXWuXcaHq+FBzWTuPSAijcIl
 Cx5IVrPkAstjifJHxZBt+3q1J3pCP4ij+OL7GJyaOx+ayjEVbFo3gOFVV+PBxJ0RXHQw
 cMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743770508; x=1744375308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ckYbVXM5y/oHY3AyYUtbqJnHtUAg7+Xu4MIsacAMf/E=;
 b=Z/Pt3eqZyC7cNvXJ1cQkl7jC7DtnQkIr3OEjNatWjC8yWmx3RErvYCByNtAiBeMOx2
 zc0QEKoB7iT0dxUoq5/5I/EVOXGXCvgzC2JDyNayQK6y6PEflcs4zudXUN7Kh1KdUK4I
 T4uNn436AsbSxeDV1ismGniACC6ZpUvG463bRAlThFkSAEcdKr7rsQiBkAxAZun4nOdx
 dhrrwC7NL1bhirHXu/pfVUDpx5SqFWhovSb5iMgLZCbwTMfYlzjikl7dZSjJhV1xUkqu
 NgdqbP4zuhFoFEuNN3jbNp2+tMMY9+13aYs5ngf6hkID4nILbg3DGzBltm4fdVP17kdU
 vY6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcJVJtubl+mB6CFPEENod7Qxi48u42pxgyPEF9RyD9LRPIFvV5y1nXHOQFmHcjeLyO1aKul7WBIUa0@nongnu.org
X-Gm-Message-State: AOJu0YxL/pdRoi+xHSoaAorw2eX2ai1x3Zdt1jEgxvFFe2OXKYu0k99F
 jzDdu42AmekSPf+HoPV2fklzMmzgfaCY3x0VWeMLx45oOgCkj697NBvJCPLrsRG7xeJdpaUloNJ
 R
X-Gm-Gg: ASbGnctJKmpxQrd4Uc+ZTCWrvefJX0gex7v8rfRFHDT0xjpqVM9QMYFkRmp+Zw/ler9
 CoqQv0aRvB2BLrelWeCS2/yk/JHuq8JQpFZt9Rfl8qPvyJ2wxi8ZO+OcIN0ULD/wqn9ut8mLz67
 kuDJJEmNmIwO/wRbGbORkpcCnAJX9UcbNw804DEkWTfW4sSypESvk1IHeV2Hu5f+ZZeDlOjhF/L
 QiIedDYKZ6fpHmIZsn6nMkKzx1TgfsZzqlxppYgt5siYI91yFqEmkGlHd3pG3+ds34Pv9t0L4BB
 FqItj15YxfSXUbTdObZbmFfKKoEchkqFq+NK/4fJCpYjFFVg+aInFwhe1Mg1G7u5HGbpAcs6Zxu
 eruKFAfB7FKpz
X-Google-Smtp-Source: AGHT+IFE5N/OUkTIdMiyBkUd2ELV+/WMGowm9MzSUh7xjxzFvOzD0MCJ5owj0GzWN2Roi/axeqIC0A==
X-Received: by 2002:a05:6000:1843:b0:39a:ca05:54a9 with SMTP id
 ffacd0b85a97d-39d0de28a5amr2428828f8f.29.1743770507886; 
 Fri, 04 Apr 2025 05:41:47 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b69a8sm4241654f8f.49.2025.04.04.05.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 05:41:47 -0700 (PDT)
Message-ID: <438cb87a-cfa2-4392-92f4-bbb05f7a2ec2@linaro.org>
Date: Fri, 4 Apr 2025 14:41:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ipmi: Allow multiple BMC instances
To: corey@minyard.net, qemu-devel@nongnu.org
References: <Z-8ujYWA8yBATtYK@mail.minyard.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z-8ujYWA8yBATtYK@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Corey,

On 4/4/25 02:57, Corey Minyard wrote:
> Allow a system to have multiple BMC connections to the same BMC and
> multiple different BMCs.  This can happen on real systems, and is
> useful for testing the IPMI driver on Linux.
> 
> Signed-off-by: Corey Minyard <corey@minyard.net>
> ---
> I'm working on a fairly extensive test suite for IPMI, the Linux
> driver and qemu, and this is necessary for some driver tests.
> 
>   hw/ipmi/ipmi.c            | 1 +
>   hw/ipmi/ipmi_bmc_extern.c | 5 +++--
>   hw/ipmi/ipmi_bmc_sim.c    | 2 +-
>   include/hw/ipmi/ipmi.h    | 1 +
>   qemu-options.hx           | 9 ++++++++-
>   5 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> index fdeaa5269f..ffd972f78b 100644
> --- a/hw/ipmi/ipmi.c
> +++ b/hw/ipmi/ipmi.c
> @@ -110,6 +110,7 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc)
>   
>   static const Property ipmi_bmc_properties[] = {
>       DEFINE_PROP_UINT8("slave_addr",  IPMIBmc, slave_addr, 0x20),
> +    DEFINE_PROP_UINT8("instance",    IPMIBmc, instance, 0),

Can we use "id" instead of "instance"? The latter confuses me, but
maybe a matter of taste.

Preferably s/instance/id/:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   };
>   
>   static void bmc_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index d015500254..11c28d03ab 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -488,7 +488,8 @@ static const VMStateDescription vmstate_ipmi_bmc_extern = {
>   
>   static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
>   {
> -    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(dev);
> +    IPMIBmc *b = IPMI_BMC(dev);
> +    IPMIBmcExtern *ibe = IPMI_BMC_EXTERN(b);
>   
>       if (!qemu_chr_fe_backend_connected(&ibe->chr)) {
>           error_setg(errp, "IPMI external bmc requires chardev attribute");
> @@ -498,7 +499,7 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
>       qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
>                                chr_event, NULL, ibe, NULL, true);
>   
> -    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
> +    vmstate_register(NULL, b->instance, &vmstate_ipmi_bmc_extern, ibe);
>   }
>   
>   static void ipmi_bmc_extern_init(Object *obj)
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 6157ac7120..c1b39dbdc5 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -2188,7 +2188,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
>   
>       ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
>   
> -    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
> +    vmstate_register(NULL, b->instance, &vmstate_ipmi_sim, ibs);
>   }
>   
>   static const Property ipmi_sim_properties[] = {
> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> index 77a7213ed9..4436d70842 100644
> --- a/include/hw/ipmi/ipmi.h
> +++ b/include/hw/ipmi/ipmi.h
> @@ -183,6 +183,7 @@ struct IPMIBmc {
>       DeviceState parent;
>   
>       uint8_t slave_addr;
> +    uint8_t instance;
>   
>       IPMIInterface *intf;
>   };
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dc694a99a3..186433ac13 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1120,6 +1120,10 @@ SRST
>       ``slave_addr=val``
>           Define slave address to use for the BMC. The default is 0x20.
>   
> +    ``instance=val``
> +        For more than one BMC on the same system, each instance needs
> +	a unique number.  The default is 0.
> +
>       ``sdrfile=file``
>           file containing raw Sensor Data Records (SDR) data. The default
>           is none.
> @@ -1137,7 +1141,7 @@ SRST
>           is set, get "Get GUID" command to the BMC will return it.
>           Otherwise "Get GUID" will return an error.
>   
> -``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val]``
> +``-device ipmi-bmc-extern,id=id,chardev=id[,slave_addr=val][,instance=id]``
>       Add a connection to an external IPMI BMC simulator. Instead of
>       locally emulating the BMC like the above item, instead connect to an
>       external entity that provides the IPMI services.
> @@ -1151,6 +1155,9 @@ SRST
>       simulator running on a secure port on localhost, so neither the
>       simulator nor QEMU is exposed to any outside network.
>   
> +    You can have more than one external BMC connection with this, but
> +    you must set a unique instance for each BMC.
> +
>       See the "lanserv/README.vm" file in the OpenIPMI library for more
>       details on the external interface.
>   


