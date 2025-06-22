Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54571C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8fx-0005Wg-RR; Sat, 21 Jun 2025 20:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8fu-0005UX-KR
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:35:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8ft-00069h-2S
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:35:10 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23526264386so33732335ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750552507; x=1751157307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5FNA3J7UvZ+Wv6HJXq43YDhvLo+BkF89arIlkLIO7vo=;
 b=R5PCeUbcxGztmQNNGcApVpXEy04bBSXtpb6Iottqk7oSyoY3Vuv4aX+HRB8nVKRjgP
 uHa+LgJdPEEOhTGYuOFUE7MCMRdknHHxlstZig3vaGjdj8lm5ixcEpmX9NJGHnZWzBRa
 A7IEzskQsZqDK1tXIahT6qzLIWvSlYybHdnR/xKjnVdlES62ju30J4uM/JEgLYel/huY
 Xh+6vaJlv7RZYMxZodQvIi1ZaCevvta9SIbNLqRISGhUv622nvXs9GdnE5MQDrTsjRQX
 5pWD3naGVE/Tyz5xL5cI6dCd4j0H6JDZ7HB7rluRte5ssu5MDndZWvIJb81+Ngs61Ay6
 rFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750552507; x=1751157307;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5FNA3J7UvZ+Wv6HJXq43YDhvLo+BkF89arIlkLIO7vo=;
 b=W+6rvjfe4mrukZHLyMlArKvLd9D5mloJZvLv47sBb+dwf/04s08CueqitDqAgui87t
 +aKxa0aWKnfL5hrHW3Olez9zZ+y4ROFst2INATC7I1JUiEEkEW6usitUkSIRd41baRiL
 ElYKDOdldtlhEaq/SIJ5sdTNnrGPreXuHgccTMRVdIBrTEgx8tNJnh64JN6UDcDsySR8
 74tvwU53T1vn/Np3aG6WCoTxDyJsJIJKy+EMfOF7WDP5VjjSz9oHvRvRwtSFKGRFui5T
 +zixoxyxX7z8DYlszC0Ldf6cB1XvhyWTHFFCzZxqBQ+SLwbRsS6Y5JGULLujOZGFF5du
 6FQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH7vvSLUzv7O3O3IyUPf0NEHFv7gaycGI0LHkb+P7EHNl2wQp6naMnKVaA4S9TbXMRnd2dYJDiZh6s@nongnu.org
X-Gm-Message-State: AOJu0Yz5g1UOPlk1CfNo206Q8iDAuQhG24/SuAfXmriQTmEmpu4k/MFF
 dUrlkfnWasfXGD1Bzy+EoBz+xlb13msevFwqCQhzFsJWN88I/lMc8evVRlh3nCV3xKA=
X-Gm-Gg: ASbGnctD3ID5q0FPU7flav/sSkWmw1k0nV1J6qmZD3dhDxWGHz+/CN77tifk7rzN34O
 xywlql41dDJkrzvlD5ti3VYmiiDuVQztEoFjqTAIyK9LYcBUztydGqfPQBGjeanH1ebTprmOHGs
 QtBeRHxnucxBM6JGlvi7AsPAm9sYXhUk9g4vlJ7NJR+73K9qog2MPamPgxgev2EK8w8kkTorgpd
 o/y/AShLg/GpwW6cxqpUPwOQkw4WrpBGBMdm47WJ1qMkZyfdnbzT+X8mqi3XcNGae7i9QoI43h+
 S5FuvHPJypgK6iSbYqpvvmmy+jXb4juJYLqyYWLJ25+t2Q0FcK86fSId27m8cn81Dq9X4lZTdv3
 cHROdtXc19qJr3sVobfIcHqrH70Rxy9fSbjitS4M=
X-Google-Smtp-Source: AGHT+IGKx2qp2gbxLD2Z8yrHy9zwH5a8wc0QV34lIdHbO33fpNerzW6hPDMK673B3N9fzBOrvPHqxg==
X-Received: by 2002:a17:902:d48b:b0:235:c781:c305 with SMTP id
 d9443c01a7336-237d991825amr160510545ad.24.1750552507458; 
 Sat, 21 Jun 2025 17:35:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8674544sm48440535ad.167.2025.06.21.17.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:35:07 -0700 (PDT)
Message-ID: <c1b5c78f-6756-4831-99e8-ab1cfd3fd8cf@linaro.org>
Date: Sat, 21 Jun 2025 17:35:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/26] tests/functional: Restrict nexted Aarch64 Xen
 test to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-24-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/20/25 06:07, Philippe Mathieu-Daudé wrote:
> On macOS this test fails:
> 
>    qemu-system-aarch64: mach-virt: HVF does not support providing Virtualization extensions to the guest CPU
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_aarch64_xen.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/test_aarch64_xen.py
> index 339904221b0..261d796540d 100755
> --- a/tests/functional/test_aarch64_xen.py
> +++ b/tests/functional/test_aarch64_xen.py
> @@ -33,6 +33,7 @@ def launch_xen(self, xen_path):
>           """
>           Launch Xen with a dom0 guest kernel
>           """
> +        self.require_accelerator("tcg") # virtualization=on
>           self.set_machine('virt')
>           self.cpu = "cortex-a57"
>           self.kernel_path = self.ASSET_KERNEL.fetch()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

