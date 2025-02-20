Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67619C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl3CN-00010g-O3; Thu, 20 Feb 2025 04:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl3CM-000109-An
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:50:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl3CK-0007K4-LC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740045023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z7+pPpQrNFjMQe0lY2pxq0g7UBTbyDuCU5NKWl0LCdU=;
 b=R4bq/EY6IHM+1xZmM2zmdWffNAZdqCG662cHbaKVsJRmY5/7FgDO+x1oCC5xc/zoLE1slg
 Kowr+gxroPzhPqYDqZM0kd+JRY2vT6zxeyn9UC7HclOlFjF6dM5mw+naCHXuaA+fWnJY/c
 kHcFxVrF2dstMsuwBdkrM17dRNOwN2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-VMl_S74QMSiNF36e3n85tQ-1; Thu, 20 Feb 2025 04:50:20 -0500
X-MC-Unique: VMl_S74QMSiNF36e3n85tQ-1
X-Mimecast-MFC-AGG-ID: VMl_S74QMSiNF36e3n85tQ_1740045019
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4398e841963so4670995e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740045019; x=1740649819;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z7+pPpQrNFjMQe0lY2pxq0g7UBTbyDuCU5NKWl0LCdU=;
 b=VlBvMfcG5M9athaL0bMU4A7AxUBtUWnhedvXcfhE/ib09Uaao71g/jua5txCy+lt55
 L8JUC2VwdTwDNouWPu3xunA9st/ylo17Xe4SIlBMUAHu0rGgDhtN6wRz51jSzuzA8osX
 teTnpFcn1Pk3sCnyYpOwwXkW2/lq8PBrgymGNuHq6FHXGt3eA9RcgPKOVjMWuGAmkVeC
 QIE/aHfauoM3LocGOXfDZbOlMv9b4C85XrCS7pFVfvgD0ROR5AjgtjWUUDPBtFnocOv6
 5XOpWKO0ZNmf7V7bFHZdBzYYDBs/X0K1HklrVOeaTpngZ6CEtQGydd2PdsCuQIX6OBjj
 NHlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVsuajm9lr2QjsDH/hnTMn4g3ZeFW09p5HYDI2xIDSWmqz7VkNHpoIt9ZXWPxnpiIhOmqWG2NiHmKY@nongnu.org
X-Gm-Message-State: AOJu0YziVqA5AIVUFnK6Iyg81rHBhNhtZ6NEMPJjvafclXInzTP6lOsX
 8cp3cRGx7RoqcnoTGcZY9acvlJjcuB6fJx9s7eNVPbQEqHOK5yBT5E4mKti99SmCy4irbIHbQT3
 zH4l5bp2HXsfmLDgCbyjhl6iH8lRfpnuVK7di4yI67ipOaxumFL3n
X-Gm-Gg: ASbGncsn/alC90xd3aqTSMK366WNV1oEGDORlqwcblKVZ5+Q961/SR/EqMgDSrUE2ev
 03joEU7zhmb8bAm/yVZnrdQgEFvRxNpe24/puz4YR3twXGJb14qRPDRzDAlM1WdWKEstc1kfZxD
 jHXqCbrsI2LcWmNjmfjeSVaDNQcCiw/E9gvHryygcng7w80JMm2FiSDQjB37cikxTQURXWJP1+g
 CABrAaFh2lAdWFvhMF4IFbC3Pi/dB+kEkUTTlraTDPOcmkKdyfupd5S/obHbl3rcQCwTSkp54S8
 Q6v9liikakU=
X-Received: by 2002:a05:600c:4fc8:b0:439:985b:17be with SMTP id
 5b1f17b1804b1-439985bb342mr73171545e9.9.1740045019056; 
 Thu, 20 Feb 2025 01:50:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTx4nhUGwdVJCUAVZ54TePQtMaFKOS/oaZ+0tlmKbmjXXAv0iYhy+tvHDk7ra2TvYk60i8pw==
X-Received: by 2002:a05:600c:4fc8:b0:439:985b:17be with SMTP id
 5b1f17b1804b1-439985bb342mr73171265e9.9.1740045018652; 
 Thu, 20 Feb 2025 01:50:18 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4123sm20692534f8f.17.2025.02.20.01.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 01:50:17 -0800 (PST)
Message-ID: <e514d6db-781d-4afe-b057-9046c70044dc@redhat.com>
Date: Thu, 20 Feb 2025 10:50:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Any plan for command line '-g' option (graphical resolution and
 depth)?
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <97e66ba5-488f-4246-b4d9-466d29a86dff@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <97e66ba5-488f-4246-b4d9-466d29a86dff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/20/25 10:20, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> QEMU provides the global '-g' CLI option:
> 
> $ qemu-system-foo --help
> 
>    -g WxH[xDEPTH]  Set the initial graphical resolution and depth
> 
> This option is used to pass resolution/depth information to guest
> firmwares in the machines defined in the following files:
> 
>    hw/ppc/mac_newworld.c
>    hw/ppc/mac_oldworld.c
>    hw/ppc/prep.c
>    hw/ppc/spapr.c
>    hw/sparc/sun4m.c
>    hw/sparc64/sun4u.c
> 
> Examples:
> 
> - hw/ppc/spapr.c:1102:
> 
>    _FDT(fdt_setprop_cell(fdt, c, "qemu,graphic-width", graphic_width));
> 
> - hw/sparc64/sun4u.c:716:
> 
>    fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_WIDTH, graphic_width);
> 
> 
> Obviously we have default values, which are different per architecture!
> Clearly these ought to be machine properties.

Yes, we should have an easy way for machine to allow, in addition to -M 
graphics=BOOLEAN, the structured property -M 
graphics.{width,height,depth,enabled}. Then '-g' can desugar to -M 
graphics.width=WW,graphics.height=HH,graphics.depth=BB.

> It is also used to set TYPE_NUBUS_MACFB properties in hw/m68k/q800.c.
> Here i suppose we could directly use '-global nubus-macfb.width=value'
> etc. although I'm not sure it is the recommended way.
>> Should we start deprecating '-g' as a whole?

Only if it's unused/useless.  If the option is useful it could also be 
used for EDID, for example (adding Gerd).

Global variables are hard to track, and the one-off nature of the option 
makes it hard to figure out (without looking at the code) which machine 
support it.

However, if the properties were available and introspectable via QOM, 
then it wouldn't matter if the -g sugar remains as an isolated "case 
QEMU_OPTION_g:" in system/vl.c.  For an example see -boot/-smp or 
-no-reboot/-no-shutdown.

Paolo


