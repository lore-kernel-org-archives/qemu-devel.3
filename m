Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F99CF55811
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSsA-0007oD-TN; Wed, 22 Apr 2026 04:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSs8-0007mG-AL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSs6-0006qZ-Jl
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776846225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8NEPEdeDqv6cBxVai8+eNO3k8v0+/dffPW4ZrIwp1BU=;
 b=FP02ktdElANnzFpaX1XAPAUxyYyyI0PmMpO+1B8YEUXVZoaTo8KQrR3L//ou+s0joy4Quk
 tMu7ew9a3vxwdbd1hIuNyc8i6UKWkV77B34dwpc+JY/o5oo4lTadk1a7OVeVz5KzilAHz7
 QOxShowxhcwtdV2Dh3tMY9OD8hiWK38=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-RhAfUJp3NGWqurMdfvglAA-1; Wed, 22 Apr 2026 04:23:44 -0400
X-MC-Unique: RhAfUJp3NGWqurMdfvglAA-1
X-Mimecast-MFC-AGG-ID: RhAfUJp3NGWqurMdfvglAA_1776846223
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488d8deb75fso42108975e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776846223; x=1777451023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8NEPEdeDqv6cBxVai8+eNO3k8v0+/dffPW4ZrIwp1BU=;
 b=JW4MJ8eU/bFO2zZxmSJB/tpjd5Wx68UIWAJCro+hSFtwVge6zx5M2fI5u+Zyibgh1X
 gqUFNWjKBnHELsxRmFRCINsNZEkn239iUGZ+LuTb/kjxMkecATOfbqFmeWcj6hDakOt/
 1xgFtTbvm+Hgcl3yN+L1slJ27GL2K27aQ86Xyt5psPA4KP5p6mHwqcXxcq866oZ8DD4B
 YKJIZbpIl4NyBryTgZ4J4AlpTWpTfm0ywFite5hfVnxlZzaCi2KbZGAWh2LHSkunoQQO
 QmTh+4b4qgKPrrQpm0kXQ2K88l69thl/2xpTX8Ft61/EZOEn+53UW5a4fzLayLFas9TF
 gYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846223; x=1777451023;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NEPEdeDqv6cBxVai8+eNO3k8v0+/dffPW4ZrIwp1BU=;
 b=QgMtd5Fho/bzT6yUfiwmn8Lqw0E0KRx9+RRJE790Yjgn14ro9Si7CKGWpu9V7zYiZS
 UoReV3FMpOG7+N00wrRQL87k7+QOHX81ZFejUzIGckMCm2WOhG3/sMrWBQscE+IdzJzt
 Gs4acUiZpDWAF/vkJtUMtmzg2to2C3qNgJHeHCWBJIPFHUuhO1ZqSbMUtait4+ICB5R0
 /6MVfhPP2bP9Q14uM1rKDTfk5LwvwwnLDW5keJjENri3pqUf0I56Au1EtWjv0visoyfa
 KzfSLl+m3X5Lyyv1Ih8hhwsb8OQVP+v4Ej1JHYRP18S26dVuDiTec4ttFH3nupNew/4E
 IIew==
X-Forwarded-Encrypted: i=1;
 AFNElJ+W1Q/o+zxyXubDKeOIQTc++FDNzdNyAlByYlpLGO5eENWBUxKaneBgR54qSEfRoRx2j4Lbotcbv1Rr@nongnu.org
X-Gm-Message-State: AOJu0Yw5sCWAHbq4CQyh+kSwyE/V96XLmkZ8z04ek4hLJG9ywrYRRjsx
 fuNnYRGVYZceVkjG5HpTIR9xEaEFnMEqnDRy0W+MUi8Cam9sBnsv8IXNOSmFzpjwFgj/qriLyeS
 LsqOrplyzbD3bdKsembuFD57C8YpPp8+Mcg53t9aACGoP5kDcxelhAY8i
X-Gm-Gg: AeBDievsWKe0Eno2lyeKinU7gPBbfWOQzprm0Ctva9mOSt03BYQ0h6YAw/C3Rk/6jKr
 WmOkf8HTwBvpWX8AjzmC8kmhzvKPwcJWGGt2m/7j1BnE6JffFwPba8DeN13QrhQtrM517Epe5g1
 3QgYMBsZyk3wTbi4X3UoC/w1fGfOAg399rkw4Tzp92RCIhpi8tRIR0V523A2hsITsYNaBoCfPOJ
 57Ed7/59orM28BtrCPzT4aw6vxen1+dapgSjL/n8Bd8iM55xCHMYdsIJUBsuurnPRz/RBznGeDt
 hB3DBNahm0HRiV/M6T0QNG2zvmwATf6+6Ze1MLz3Lvr0hBNIdMaKcQzQXF78mIBs8R1GEBdVbFO
 59UVLBFVgpR/7Okpbhsvb/MMakH+oTA==
X-Received: by 2002:a05:600c:8b55:b0:48a:57e1:d8cc with SMTP id
 5b1f17b1804b1-48a57e1d8d4mr69970215e9.9.1776846223178; 
 Wed, 22 Apr 2026 01:23:43 -0700 (PDT)
X-Received: by 2002:a05:600c:8b55:b0:48a:57e1:d8cc with SMTP id
 5b1f17b1804b1-48a57e1d8d4mr69969635e9.9.1776846222679; 
 Wed, 22 Apr 2026 01:23:42 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm722666775e9.3.2026.04.22.01.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:23:42 -0700 (PDT)
Message-ID: <6470532f-6b1e-4f64-ba67-7775795d6919@redhat.com>
Date: Wed, 22 Apr 2026 10:23:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] MAINTAINERS: Remove PhilMD from firmware sections
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
References: <20260422080406.62638-1-philmd@linaro.org>
 <20260422080406.62638-10-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260422080406.62638-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/04/2026 10.04, Philippe Mathieu-Daudé wrote:
> I'm not paid to support this code. I haven't followed
> it neither, so be fair and just remove myself.
> Demote the status to 'Orphaned'.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Kashyap Chamarthy <kchamart@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5aceda193c2..242546498bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2846,9 +2846,8 @@ F: hw/usb/vt82c686-uhci-pci.c
>   F: include/hw/isa/vt82c686.h
>   
>   Firmware configuration (fw_cfg)
> -M: Philippe Mathieu-Daudé <philmd@linaro.org>
>   R: Gerd Hoffmann <kraxel@redhat.com>
> -S: Supported
> +S: Orphaned
>   F: docs/specs/fw_cfg.rst
>   F: hw/nvram/fw_cfg*.c
>   F: stubs/fw_cfg.c
> @@ -3969,7 +3968,6 @@ S: Odd fixes
>   F: docs/interop/firmware.json
>   
>   EDK2 Firmware
> -M: Philippe Mathieu-Daudé <philmd@linaro.org>
>   M: Gerd Hoffmann <kraxel@redhat.com>
>   S: Supported
>   F: hw/i386/*ovmf*

Reviewed-by: Thomas Huth <thuth@redhat.com>


