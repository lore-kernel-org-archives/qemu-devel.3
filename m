Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B97FC27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6eI-0001vQ-7L; Mon, 17 Jun 2024 03:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6eB-0001ug-5U
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:19:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6e9-0003YW-K1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:19:22 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35f275c7286so3630636f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608760; x=1719213560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tosoy+FeKPaOtHAoln09Q9INtZ+aN/UG3uTnYhXu0jU=;
 b=VCd/Liynhd5wUi2y4JCFzExdRMhYo3T++yUHcSbkP4bdnWMh7ro1eABIcEnuCeil73
 az2vCyLIoKKxyfKlCzMUw4EJfIEFG/R75GpaRaJEzebsTdmAVV+uDm4W0j6W2M5YlGTL
 iSF2K3s6nSpUAFpLZAG0GQMRld/ez80bsUZi8gFQgrAuNuGe3whqapyZIcvZD+n3loy0
 QM+RIMl8Q0040hQCerEJAmCzb/3RDH2edf/cA5OCNG8s576FuXHbcfOHL4fw2QxJYZzu
 nqA6JodrCT5omaNokJIfnYU243nYZqtvDcQWm4fKzDbLDkcWWJcWCeWBP+ut2ci7ebXT
 +CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608760; x=1719213560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tosoy+FeKPaOtHAoln09Q9INtZ+aN/UG3uTnYhXu0jU=;
 b=bs8ZIIQpbRQRRnnpAA+9jprEgVu5XBSTMwozPhvUMrgBhKqAe6fNPf7GIVLaUUx7/M
 ErZtYhJjrGrmE+fmQwra0PxCTvt5/VBSxgn4rVUacUWPF68CKEfejPqOoZRs/pSQQWiw
 AtS5gniTz0FpBAXSrsUCbMVvuRJi76nSpTv/A//855TkWpswcs1GioeuRFhz9fPcc1O+
 v9TVDoltlQBJ+DB8SDx32Uv1/VnFBaqdM524uePXrlY6XKoDVcxcjAq5i4Ek6a9ThcSw
 jKohOoVWANXLcoVWJCMIUn0dDix4FP3+tP54YwfefDG2pXjkmJVwGbyqqOxU5Q3PwbDU
 LhJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCJ4wsCCbBZShWB9kANkW3Bbd1kXcDqABgidF/oFNE+3NTAGVZScm9es2mngZ6gekOS7k7Hsr3MZJhSx6uu3KRrUC7sBo=
X-Gm-Message-State: AOJu0YwXq+djRjk7g4dgs03ui89AhDLZXITET5hsaELiLuzTZr0hlQXE
 slDmDo6yigohfECDdlIt7B8Hw3J8UfCYeS3h2oRpEHJn3ylO+gMoaeK3TY0AXq0=
X-Google-Smtp-Source: AGHT+IFIjLMEFpt8qU81fHsFnDEVi+p7kBPZkTO1Gn3MsRQKg+w7TvTOTb/+cBvbzcyxQiAmnNMShA==
X-Received: by 2002:a05:6000:1f8a:b0:360:9b83:2970 with SMTP id
 ffacd0b85a97d-3609b832b26mr413610f8f.68.1718608759920; 
 Mon, 17 Jun 2024 00:19:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2489sm11181335f8f.69.2024.06.17.00.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 00:19:19 -0700 (PDT)
Message-ID: <b9ed9c39-349d-4397-9b05-d7faa5b95fa2@linaro.org>
Date: Mon, 17 Jun 2024 09:19:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] os-posix: Expand setrlimit() syscall compatibility
To: Trent Huber <trentmhuber@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com
References: <20240614210638.5959-1-trentmhuber@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240614210638.5959-1-trentmhuber@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Trent,

On 14/6/24 23:06, Trent Huber wrote:
> Darwin uses a subtly different version of the setrlimit() syscall as
> described in the COMPATIBILITY section of the macOS man page. The value
> of the rlim_cur member has been adjusted accordingly for Darwin-based
> systems.
> 
> Signed-off-by: Trent Huber <trentmhuber@gmail.com>
> ---
> The previous version assumed OPEN_MAX was a constant defined on all
> POSIX systems--turns out it's only a macOS constant. This version adds
> preprocessing conditionals to maintain compatibility with Linux.
> 
>   os-posix.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/os-posix.c b/os-posix.c
> index a4284e2c07..43f9a43f3f 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -270,7 +270,11 @@ void os_setup_limits(void)
>           return;
>       }
>   
> +#ifdef CONFIG_DARWIN
> +    nofile.rlim_cur = OPEN_MAX < nofile.rlim_max ? OPEN_MAX : nofile.rlim_max;

Why open-code min()? (The man-page also suggests it).

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +#else
>       nofile.rlim_cur = nofile.rlim_max;
> +#endif
>   
>       if (setrlimit(RLIMIT_NOFILE, &nofile) < 0) {
>           warn_report("unable to set NOFILE limit: %s", strerror(errno));


