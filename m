Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4018AD5E125
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 11:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVSqZ-0006QU-WB; Tue, 16 Dec 2025 06:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVSqZ-0006Pv-1K
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 06:04:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVSqV-00068Q-KD
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 06:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765883039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UXkhHVaQ16EVx67U++BOb89fuZnjA6KIp6UiJ0se7J8=;
 b=J7c9eo0Vh7ILdDeT6RcCIE+WXgUT4BJuxo+GS4xPAxlHhPylaqDas+8vJMK4W0QuI2iJ0e
 TSoU49A1mFoV1oq7QESWZvyH/OGbLjgwoI1DfBlSw7esCITY/Z0hQvHoWXq0EI61Oi3Doo
 8Hpv5tEGXSrZWTraTogSs0xk2g8DQdw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-nNsJwD2EO9WJUj774tX5-Q-1; Tue, 16 Dec 2025 06:03:55 -0500
X-MC-Unique: nNsJwD2EO9WJUj774tX5-Q-1
X-Mimecast-MFC-AGG-ID: nNsJwD2EO9WJUj774tX5-Q_1765883034
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso54707915e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 03:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765883034; x=1766487834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UXkhHVaQ16EVx67U++BOb89fuZnjA6KIp6UiJ0se7J8=;
 b=DpNPq7ufJtb+hq2vBgreR3u5rLaa5l6UHdKJlrsF95UihXtuoSzQkVYvv0KFnnhLpR
 N23LZ9vvQwp0vdmJJPCUu0gPx/DqC58JFjSddlXYIMbpwjQXSt8QuTvQBIbd062A69L5
 vsFga+ezdnu8BIEk8JZLbDhQmsCvdHXQMw2swg8zPjMbX4uMyPMUL9145DZP8Nr5O2kh
 eH7RdHiCq3dbUokg0MG0AettVvbVYsfxYEaT+y0jFu6vmcFDLrI88LvThetCT7ueCXiy
 CtmkJc0TjdXjLweaL52HzBm5gec191W4DlfjDFM6R8iMJAgcDETcQ3rkkFMVUZ+GtkkV
 mnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765883034; x=1766487834;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXkhHVaQ16EVx67U++BOb89fuZnjA6KIp6UiJ0se7J8=;
 b=PFexKoiTm4N+GXXa5kGSCMfFNfr4spoqra4ButQ/8+p3IhU4RzVyhB7KZhg8xg01Y+
 mg8s5/JnH5Eceml0CgHzr5N4xX9tjMnGi4hX5OMNmiGHfMCR7yLl6ilL8SYqSf43pQS9
 oJzWVYAMWmGCXuQUeukXMVSo/qdTIx9lOFbwZVC/ohK/SjDW1JcPrJz5yuI0YvAuCf8Y
 c7UsYCJxgZY/xD4KJwydbyb60iCS+ruifxqeAJA0Xip1kS96IdlQQO/Otvx52LBjiX+O
 YcoUJxd+q6JeaZWCAc9EOU3yzhEXpQNwuEwd0dF37a4YP3tfAaRTBaWQ+01gPtgYB+B9
 DjGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7nhZH7BexVHguWO1zlvAr0+dLbrswORQMGfBYQGPqQpgkAdgncdA9bE1I/D9RfWCr8C/CbCbQ+Oe5@nongnu.org
X-Gm-Message-State: AOJu0Yzsu7a8XKjamdWPh1BOpqpU2zm4FteWietkFrOCRLNrJ8si1dP7
 vA7VUkLsk6sqZRjNHqQ4Fh4y0DnHbuJyTVDogn/cO5ajiA9rs2AAEkf4zxOPSZMzNdpUBiAZJOV
 /h99MIqpFuHxn6ye3CtqYFjTsWeL2pddoGw7E9zLSswVQI4XLU7OVcSYKW0S6ovAs
X-Gm-Gg: AY/fxX6d0/tto7FH7v2LPSjGmsdxtNf+Gz2sAG2VmwfSIaYQ3CPbFxv6+4AB9DAsDAw
 cSNxpCD/4aI9OTOhLkGLAXmVMpivs1SXFAXxKanPzSa4l6uzJnjheH9pZTP1RQdivzGb1rnm8sg
 kC0cD6VSGpkBBJaeHH0R0CGhaQci8Uce2rYhd2+NW3NZaOaa8tZ8fyOH6kUDtOR2qR29FTPqVtO
 UcEW6CYeohTCsnNLHXE4KoGwo5Res41SgHGcOyk8Xseq1O4hM7LkUqE9gU6hrVB9QJQYErzM72M
 oFzl81K6OpX2vdniuSaHvLbQe7DxVEktcYDuOIhdEnwxPfQ8hQqTNvvLsdzhgih9XJ4nuyfnbgg
 O3isBYf4=
X-Received: by 2002:a05:600c:1992:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-47a8f903ef8mr145685525e9.21.1765883034395; 
 Tue, 16 Dec 2025 03:03:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEZMDEE64f7nMCqxPNW1jXbSRA379gIqX/r800T3kodlBZDc1jxcdLb2x0p0HF7ZtRjLJpJQ==
X-Received: by 2002:a05:600c:1992:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-47a8f903ef8mr145685235e9.21.1765883034047; 
 Tue, 16 Dec 2025 03:03:54 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8d9c6fsm239407245e9.11.2025.12.16.03.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 03:03:53 -0800 (PST)
Message-ID: <a4318e31-504c-4a64-b845-416b09e6ca78@redhat.com>
Date: Tue, 16 Dec 2025 12:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] gdbstub: Fix const qualifier build errors with
 recent glibc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251215101937.281722-1-clg@redhat.com>
 <20251215101937.281722-5-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251215101937.281722-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/12/2025 11.19, Cédric Le Goater wrote:
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
> 
> ../gdbstub/user.c:322:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    322 |     pid_placeholder = strstr(path, "%d");
>        |                     ^
> Fix this by changing the type of the variables that store the result
> of these functions to 'const char *'.
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   gdbstub/user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 2e14ded3f01053d4d4a36426c509ce7a6b81cb67..e233c598165ca1b10a5f2a89c87136df9af636ca 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -317,7 +317,7 @@ static bool gdb_accept_socket(int gdb_fd)
>   static int gdbserver_open_socket(const char *path, Error **errp)
>   {
>       g_autoptr(GString) buf = g_string_new("");
> -    char *pid_placeholder;
> +    const char *pid_placeholder;
>   
>       pid_placeholder = strstr(path, "%d");
>       if (pid_placeholder != NULL) {

Reviewed-by: Thomas Huth <thuth@redhat.com>


