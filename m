Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74876FE5200
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDiy-0003qv-Mp; Fri, 24 Apr 2026 06:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGDix-0003qi-6K
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:25:27 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGDiv-0005gp-0L
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:25:26 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so4719975f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777026322; x=1777631122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/CGo2sn347om7Ka63CA0DzldVJCcZEYkxPkNNL8uf4=;
 b=BEVzZil4EQ88UFnt4cK9jGAUifso0woABgFUnamTlZ1oX1oZvwfZyGwnDG03c8Oinv
 73mudOkvw98+AxGQE+FRvezNpxO+e/SnSyyaDDLNPt/vnqSRHZfDxknkKXmtFTyPUMQM
 SHRNl+WtGAH13114Q040Mkzqko7ixPgjv3C7HL66wTs9/ild296LU9dbTqb7GrqDOcgD
 mzaa16S8S3K7SXzVJeoF9ABUWMls0n/Ni5HLQ5VL0QZ+sNhC1mHK8LnczObqMf/lgVIp
 9sZhJ3UHQS7z59xc67cwsI2qduVmuGrE/XDX0ImvziaIrdhcyIXSHDO55lmGKpuiOwHf
 Bbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026322; x=1777631122;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/CGo2sn347om7Ka63CA0DzldVJCcZEYkxPkNNL8uf4=;
 b=DOh+gJgQFcf54KxSN1fyaEW+8veOP/L1XbEnJpEOTnfffDSp6ezNZC6gdQBjbh55Af
 k2mi6n9NFgQwhJ/92qs7oBvHiZvU48DmPt7AvQZeO++dlN41GE5PqRUSSbjP7JzfxhVL
 A2HOiLrRNsBhMT+LNV1fMsQ/i/NemDddmyJ2chvJKU+4nFmm7b1zCPzXzfKi4+WClTkt
 zaaa2tVY3Vsrvxm2QKoITIo9XhsGf/vEqZk3Hb8AIipKoKAglVLa5HLg23sWPFppq4lv
 i6hAOlZE76R7KaCSPj13/bKFU/uxrKyldNk4RhF4Nx+W/twm8Wi/IUqkRGQh9lXA082H
 hK0Q==
X-Gm-Message-State: AOJu0YyuNPxOIO3Ls0Dki+wdBYkPbvzqao7Ye2+qUPMA2x7Q3OW4tlPl
 Q+4Tr+cZRVZzYtWpVdhIkF38e9ORn025GeTGTTYJ1cLj1Sqfkl/pcZvzUQ8Nkl9TvqNcOiCESLm
 jnEwxcK0=
X-Gm-Gg: AeBDiet31Q2dA78TQzrMWVigEHjrO3eIwP+OOzzUmfJkwQ6tjQqvaRl8v+JKCgRVQPK
 GutW9wYyTOctoV3N5kKg+ICmFSlIvjWEP+ZFAwxkHNqjVX9EdtKDsEieXcGGj1Av4zvDYG5TGCB
 AciODfpovlvZq8zdC1K0TtQyAdEEIoyuTS73+Zo6tyaFEZAfh8sPqOUKrdZ4Ho9AaSmGPerpI1e
 nNj13X+2rAsghAnEHeJZNud1pCpiwuOW+/MfO49ZocQV0Obg9YY4uWDBCimAE5vSSmiFuqbOaRO
 GiuFX5IjEBGlTSqMVeH7Nn4NipBoRRsvY4G3P8NWhkS1kbdhpNUDd1+FhK5/sdsvQarttNdk+yp
 ekrSWzAch8cVXBkhKKp37LRrSQev+YfaFhaUPyfPNq8yuI8mMV0PRJIK3DyNjEy7N3UbUdlpgXo
 idAFYcMtIApKpV7xK6QUbCGiJG3wkZnn9MVdhpGlcdwpJBAHcWfQtoB3hhrmwtsi1W62LNmmGAW
 dwl
X-Received: by 2002:a05:6000:24c3:b0:43d:7868:21db with SMTP id
 ffacd0b85a97d-43fe3dcc11amr48268683f8f.18.1777026322062; 
 Fri, 24 Apr 2026 03:25:22 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm55324629f8f.22.2026.04.24.03.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 03:25:21 -0700 (PDT)
Message-ID: <a5fe5e87-572d-4f2d-9dda-4cf139fc9220@linaro.org>
Date: Fri, 24 Apr 2026 12:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/microblaze: Compile it once
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 23/4/26 12:06, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (9):
>    tcg: Include missing 'tcg/tcg-op-common.h' header in 'tcg-op-mem.h'
>    target/microblaze: Fix endianness used to disassemble
>    target/microblaze: Replace translator_ldl_swap() ->
>      translator_ldl_end()
>    target/microblaze: Introduce common system/user meson source set
>    target/microblaze: Compile helper.c as common unit
>    target/microblaze: Compile op_helper.c as common unit
>    target/microblaze: Compile cpu.c as common unit
>    target/microblaze: Include missing cpu-mmu-index.h header in
>      translate.c
>    target/microblaze: Compile translate.c as common unit

Series queued, thanks.

