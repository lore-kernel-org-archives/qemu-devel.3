Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A827ECEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHJK-0007xT-Hf; Tue, 18 Nov 2025 03:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLHJG-0007vz-Ji
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:43:35 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLHJE-0001B1-V2
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 03:43:34 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-43376624a8fso37932595ab.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 00:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763455409; x=1764060209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A4V4SxxKxwOVIE013IssYmsz6vyTSjgZDbd86tEb/6A=;
 b=Tx3KfR8YnHiMMIwIVP+4A7F+RQeOnY5duYNKHAxeGRVPPMaB7g42/Q/YVWlJGhdMbO
 TYbytmDIybVIeoz1qqFoCzLpD+U1h2wCOeKWRk48nN6/ZQ/VeXU0d+OI0ZLKtpCJO5R5
 LJDHkZgk/f3OuWx2ChYt+QQTg2LJ9GTi/4xRBc/c1kiVtfT7OZQ8pL/CzgSN49lW0DCq
 P+KjFlIZhJE+bV2CURUiCMhxBYnmThIWKJXX1qJPBzyLMit5MP2MicQniDtEPVlBdcm+
 JtFQVoaFBlL1coMxpqEC1RYlW05fJPjhMSxK2hP8kLr8hCUZ67GOD0RBic2i9sim4DXT
 NNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763455409; x=1764060209;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A4V4SxxKxwOVIE013IssYmsz6vyTSjgZDbd86tEb/6A=;
 b=I503zZaMg0Vce52uzYbrXj/hP7Dho0/mz7Fl7tO/HICcLNehvjhMcyp9cmeUq9+LAz
 lyD3aeWxLBaSsRVzxvKMsogk2z01Ov6xPOLdztTLNFMC0jFMaLbOxUfjaUpjv8Nb/Pjv
 yComKagpCJCxPPrPosa1j4w8Gl1mXdAowP4PBdZrsCr886KTHwoRO7hfX9GR6XJpd/it
 JoRUd60WzXzGPC6UcuO+rKc21e90dU8cBiSl1qyrM1KSlvuRNL37pKwPskEzR8fLGABQ
 7hg9jvI0tlzfZDSv2AtTZKWuGpmPIbUaj+6ZdQ51OO6oEK79VVh5jWdW/Q4Owds39X38
 NY+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoxPGdjBopX+4Fdi5NCOKLPUYn7n5/yxayiqk68A9UIx69wZJLF9pomPVQdka0m5QXzWm+eWjLLK6P@nongnu.org
X-Gm-Message-State: AOJu0Yxl937rMQYMz/8fJv4HZ1Pli0YPcY8WSakW5avmz7bXTp+2IWp4
 HriRv6bReKjvtrKwnjglQdMBAcbIPyR9XVJN9okuAZgDh0vRDTc8YTnZpNjdJEGQea4=
X-Gm-Gg: ASbGnctcOue3a3wbudB7ihmlEoGyO/p1AVz3FExDDGYs41UZ1hX7OxlinntG/LjJKvf
 rNfg71mL6GeDOaaJ/3CEeTF7oaL12SHO6msn/t+zmoVjSo2hMnAV8ylTD700wUUEyiz2kKrf/2J
 2norMmVYNFonVTuX5n+l7Uprg/FhFnejX57eAS81lph/4Svsgh+yMCIRD5T/PbN88cKkSZXCHrz
 3aSoM+FE5Y8sezhBxQgFstSjLQL2nMmepG1Iahf3mnCWVi29pkXMDN0DBTnAN2PYj7qFwktIObv
 3Gu2WZcivMVll/N7EUXqhOPgUjNb/5BCfNgSpwr8pcwkrFmszuaBCRCj5aXcPieTILdg5Izbwui
 i3yS7Xb8xB4lVPFBP9m/kPg61VcrXvCIp+2GcuXQ8oR3ovu44eIG2DpjpsJvAE8FGA872lPxjuE
 7ODbOoTzkXMlx/UOeWiWVrB6p1lj3536kTolsif7cNLiduqaRA5cf0XtfsUysNRTy5494Z0vQwt
 rhnVg==
X-Google-Smtp-Source: AGHT+IHBNU+j2pO/WoeWzqwMkVWI5aKYXSHTu9HA90PCZ5JfjPihvQhFohjpxdrFeymiRAhD1x67sA==
X-Received: by 2002:a92:c24c:0:b0:433:3564:66a5 with SMTP id
 e9e14a558f8ab-4348c8ece4amr201344565ab.14.1763455409539; 
 Tue, 18 Nov 2025 00:43:29 -0800 (PST)
Received: from [10.89.10.227] ([172.59.191.229])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-9490568d288sm281431239f.14.2025.11.18.00.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:43:29 -0800 (PST)
Message-ID: <b9007161-0161-447c-a04d-98f52e4002c3@linaro.org>
Date: Tue, 18 Nov 2025 09:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v3 0/2] docs: Update around MIPS/PPC host removal
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
References: <20251117171236.80472-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251117171236.80472-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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

On 11/17/25 18:12, Philippe Mathieu-Daudé wrote:
> Since v2:
> - Generic 32-bit host removal message (danpb)
> Since v1:
> - 11.0 -> 10.2
> 
> v0 Cover:
> - Clarify MIPS host removal
> - Mention PPC host was removed
> 
> Philippe Mathieu-Daudé (2):
>    docs: Correct release of MIPS deprecations / removals
>    docs: Mention 32-bit PPC host as removed
> 
>   docs/about/deprecated.rst       | 2 +-
>   docs/about/removed-features.rst | 7 ++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

