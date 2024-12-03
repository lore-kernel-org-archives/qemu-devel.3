Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F094E69E88
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIPyI-0004xS-UV; Tue, 03 Dec 2024 05:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIPyI-0004xI-3o
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:17:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIPyG-0000Xa-I9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733221051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kyImpjWVU91GFRyY5fLrG9WirxFc24S2U4xji0nzkjE=;
 b=K4yyNKvh8me+82ZMH2teooWmdBny5LlykwiL6zM9xguvlBIP9pvBdc1ESnFHnVjf0ugVV9
 84GJLhlXg8Mm6ILgqB6drojZSzKKAyMjo7cuSBebVcdOxFgt+Ea04zHqiVwGdIeDbXO1Xx
 GNMGlCMHUHjRM9hl/sMH53db3+L8ok4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-eZereUjMP8Ot4fd-GSpr1w-1; Tue, 03 Dec 2024 05:17:29 -0500
X-MC-Unique: eZereUjMP8Ot4fd-GSpr1w-1
X-Mimecast-MFC-AGG-ID: eZereUjMP8Ot4fd-GSpr1w
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b68b264f71so632687485a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 02:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733221049; x=1733825849;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyImpjWVU91GFRyY5fLrG9WirxFc24S2U4xji0nzkjE=;
 b=DFUg6y7uYawvXTvJslmTkZvfWP8x8m9AVgLwdP2/MlcXYvj58dpMApGt276y9k8tYY
 /fhnGm0bRQ9WKg9SO/mizztNLH4/CthICXRHU7TGUVj3s/tnwicnupjha56LkpuaxE1f
 Ini39w61DW71rl93U+ZEFhnAV2g0FIFhSDzwx/N8g8CfkhwPI+P9njiuwj3aPrV1I+u1
 CvHBvkEggBm2UT2bJCJvOfF/upndci49IKeLLxVeq3yNPMbYJZoYyUxowtqPLw6CCUOQ
 mJ/VATStQjRaheIrb3L4A287PF3x9TpMUSNp2GRsz5zUtBCoXGxxrjFuCiaLDcxijGub
 LU0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1O1UdiLqDZTc4a3agOlUZ8KjqxsmMjVG7N824bpuLJ+iXaMPp7UNCU8VT2tRBCnzmKVu2Ln4Dkx0A@nongnu.org
X-Gm-Message-State: AOJu0YwI2LqpcKzS6IK/jHCGjotYwHfLk1UPUdWLmH+JXR2J0oiiwkYb
 i3VMqPR7uD38jwb/bVXJgnqVTyoTu+A2j6FJ8V/kP6HWyVYE1hbHaLTIDUMzsZmdq5u09j9HIce
 eGnjQahGx/mjzHmFkq6DJO7Q1dp828PmXm4ERmjCndBrou4JqVyuF
X-Gm-Gg: ASbGncuRVNdpBbffhiA/1D5ATaVnNXUvsGx2jrPtCwTFs9/JxV4bLrHFAnQquxzxx0X
 GWZ6Fe5fPVIOhuvXOWhhINYZYEpcsuF+k2iYsvQgzkTCd2wnmKaXHRlpj+4AOqNJurp4grZxKKY
 sz6J6+LstcSTWnY2/tluoD/Bv2xhX3+WQJDgeol/aSC88UuGGpCj6XVAtbm5lwXr4LQMvL/wEcr
 o/UlYVc8EV8iqNwvmZ5lvWceN9aZxtJp4XAzVN6CjLtEACff69l9ZFXKn6KcExj4P49kKhwg3mE
 y7O8jA==
X-Received: by 2002:a05:620a:4801:b0:7b1:41d9:7b30 with SMTP id
 af79cd13be357-7b6a61d994emr361962485a.60.1733221047923; 
 Tue, 03 Dec 2024 02:17:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhcHn9vDp/TdsECpr9nQWKKmCOUGxf6ghLJVISiPLKrflB8zzu/7Ride9u6AyY3zJy3Iap4A==
X-Received: by 2002:a05:620a:4801:b0:7b1:41d9:7b30 with SMTP id
 af79cd13be357-7b6a61d994emr361947485a.60.1733221046179; 
 Tue, 03 Dec 2024 02:17:26 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-199.web.vodafone.de.
 [109.42.51.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b684946ec6sm496174585a.59.2024.12.03.02.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 02:17:25 -0800 (PST)
Message-ID: <9ba83ee7-979e-4287-9db2-0f7532eeb4c2@redhat.com>
Date: Tue, 3 Dec 2024 11:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] system: Select HVF by default when no other
 accelerator is available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241203094232.62232-1-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241203094232.62232-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/12/2024 10.42, Philippe Mathieu-Daudé wrote:
> When testing with a HVF-only binary, we get:
> 
>     3/12 qemu:func-quick+func-aarch64 / func-aarch64-version                                      ERROR            0.29s   exit status 1
>    stderr:
>    Traceback (most recent call last):
>      File "tests/functional/test_version.py", line 22, in test_qmp_human_info_version
>        self.vm.launch()
>      File "machine/machine.py", line 461, in launch
>        raise VMLaunchFailure(
>    qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to establish session: EOFError
>        Exit code: 1
>        Command: build/qemu-system-aarch64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine none -nodefaults
>        Output: qemu-system-aarch64: No accelerator selected and no default accelerator available
> 
> Fix by checking for HVF in configure_accelerators() and using
> it by default when no other accelerator is available.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v2 was https://lore.kernel.org/qemu-devel/20241203091036.59898-1-philmd@linaro.org/
> ---
>   system/vl.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/system/vl.c b/system/vl.c
> index 54998fdbc7e..2f855d83fbb 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2362,6 +2362,7 @@ static void configure_accelerators(const char *progname)
>               /* Select the default accelerator */
>               bool have_tcg = accel_find("tcg");
>               bool have_kvm = accel_find("kvm");
> +            bool have_hvf = accel_find("hvf");
>   
>               if (have_tcg && have_kvm) {
>                   if (g_str_has_suffix(progname, "kvm")) {
> @@ -2374,6 +2375,8 @@ static void configure_accelerators(const char *progname)
>                   accelerators = "kvm";
>               } else if (have_tcg) {
>                   accelerators = "tcg";
> +            } else if (have_hvf) {
> +                accelerators = "hvf";
>               } else {
>                   error_report("No accelerator selected and"
>                                " no default accelerator available");

Reviewed-by: Thomas Huth <thuth@redhat.com>


