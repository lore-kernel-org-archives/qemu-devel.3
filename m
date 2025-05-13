Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C02C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmUm-0003tY-3a; Tue, 13 May 2025 06:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmUk-0003so-Ag
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:04:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmUi-0007WG-88
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:04:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so58680215e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130655; x=1747735455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O26A2fBk0skF5B7osCNfgV1APu4SFdINbgcxdHAht7g=;
 b=Th6PmJ7NWLzI9wl5QRLPTBpGcrzf8LVi6rX94DkRo4HhBS/H4IUpKr41dadNGQHVBb
 s7Te49f+W7Nc6Z4+f/xr9wkgABSNvJmhDD4Ob3VE8impizvIMvrrIsAYCgAc+w27YqKp
 nz1sOBnyr/XSYZ7aj/t0nSGa1K8gFIfPLFPjWAdxHDOpuqfOPmcaoFatyDzr+5+h80kq
 MPsIwGLAyOixps4HDiVCCocTnBmIB9FaJDiHQJw1761OdCrCUjbH4OjNKHdzi2l70JHf
 xnVMnvC4slr2TXHqPpOW73TbtlpjsI+8zqSYwVebtVBvffUyAysWvDaaUDBXsWHOvZAg
 99Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130655; x=1747735455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O26A2fBk0skF5B7osCNfgV1APu4SFdINbgcxdHAht7g=;
 b=Elkik0f4ICWJxvnw1OXtUmp1Qo2jsN6svzOf1QgXYL+2bGrfFKxP5uJaFtYLYVWZ0b
 feIkFmJmbN+3ZiYQZYhxzTWUKorNXmkSFvHIyq6GyAA+35poEWzMvcAnVcx6rSQZrvn7
 bEdzdnZ6DD1R+tx91IgCJtNqMN7O5I4DZdc65985NRSdG40QVis2HmwYda35G9c70Omn
 fxl6GxEDWERy0MIDgS5A1oo5MN20915mhvrqq2J1AHKF1JWQitmg+c+cFeqbs/oYLjw/
 y6JxsgE6/VYw5kSADtbyq1PHUA+qZBhUzxfrg9r+WnJUm5MbUZE5HR+Uy2aOSqZwzPMI
 OW6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhMW9G20iY//koa/T0y4ItD7PZ4rTdJHmc6j3xiRvTe0AiL1lNWtIBjbTCVyXRYEkkf1U74RC4kqUR@nongnu.org
X-Gm-Message-State: AOJu0Yw8HAAhdsDrZAeyMV3geovGkUQ81c1FuiLyNUklyFCD6SeaDqna
 f5Fr+b4MTwY/aavNxUU6ihw1fOC+fUZylbX4++VDWck3GcPV2MYDF6euPVXvIII=
X-Gm-Gg: ASbGnctaJbJCKuiS+lfwVKgoCbBFT88KUj5QYyb4QLUumTQ6gsHeoCNuZF5DIJpCvPx
 6LglLG65yWqRbdsZbNVZV7Run8DhKlecbdC6LNCyhDhBh1+d3gwY80Nl4UrJYTkPnIWvIZdr1r/
 5EuGUl75eqTCO1N33FyPFhGMkwlI2KJGNxp6CUtdAJJFYNXsNDqnly78SsKQLt2DcCMXN+VBCIw
 vvMAd2somH2dgzwLjV3WcrnBABokZDuipCW6+0SGCkn66p1XrT1nr14YAfTADxHeVYawNAEOwZU
 VzXI8PlzOe5RDhtfyERn4dYydARxkMG9raAk6tFDWy3K7cZyySJwxCsqoIEy3yTGvZUUqaAohvY
 DytN/QgaiureuDZZ8qg==
X-Google-Smtp-Source: AGHT+IEHDHtezTiJB5tUD8EfZ22mA3DyFbXAC/zzCzkc+WrSz4sdpni0P2osv+urenM/NTyI6Pgh9w==
X-Received: by 2002:a05:600c:c10:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-442d6dd23a6mr103613275e9.28.1747130654605; 
 Tue, 13 May 2025 03:04:14 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebd6asm15839928f8f.35.2025.05.13.03.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:04:14 -0700 (PDT)
Message-ID: <7ab5b60a-a696-4133-97e9-ee37aed218f8@linaro.org>
Date: Tue, 13 May 2025 11:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/48] target/arm/helper: use vaddr instead of
 target_ulong for probe_access
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-15-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.h        | 2 +-
>   target/arm/tcg/op_helper.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


