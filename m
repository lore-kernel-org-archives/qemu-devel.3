Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBDFCCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 08:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF76x-0002vy-Ro; Sat, 01 Nov 2025 04:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF76w-0002uL-1d
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:37:22 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF76u-0004W3-1c
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:37:21 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso640465066b.3
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761986238; x=1762591038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hu4oKRcNf1xHA05NbVx+93GNb20rM8wPuIyDYwsSbr4=;
 b=N1n/A3MBeDnrVRNTy5+R8jc538YOCkBG4HjTkKUoUprdjZJuRThhzqW7WDGtUUsFPO
 OP89BWIk87jEolNmk2ruQlCqIoFhVeeiPuqh4j3e2Bw7w82YhcxvJF4S2sdN4wNCULu+
 Dvcm0YFE1B7I9GkL7iD2+0dw8cSg49Q0w8uizcnxAYMbkVuY0ecA4ZYl/EGUe5dcGTIT
 Ae2Tz52KUUXNC0AMRyGmEMmAlFN8Ckuzmj6FPZAKfU2BbhZpSz5YlwI+UP0UVd6LKzR6
 JFaLBLM93sUuMaJ+DADQ+GZxng/cG5ly0GIRAJf+QvPvEXa9777QR9Hyzbx+cuah7i6h
 cXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761986238; x=1762591038;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hu4oKRcNf1xHA05NbVx+93GNb20rM8wPuIyDYwsSbr4=;
 b=QrAaP3LNLVf0MIn2MdvRsDl9QsSAD1mMZVq7UzBqumjlW+Ajd66WqEQwzvoojf5sIm
 Vcw3Ry3RfmsQu0hO96C5cNFusXOwZsE+837A0lCOmryjVeqgaMGvOMIzzyVwzYu4K/2A
 4HaOjCh42nU8mxzPspHjxiSYlOimQRL/CNeh4mzIDXtGWLHCoAkstH5YIRYHMMqLed0F
 hOVZR81ILXbd3XtoXXWDgd2npoje4HoXK3d+9fgSsse5NZWSTpoPZK8tOyatdazwbAxC
 w9QghRae1ZO/5jKWs3CnF5V0X5pdpLb01vHjAPGQrsdHt76l4mslw2DPgLgU2gjm1P0k
 dk6A==
X-Gm-Message-State: AOJu0Ywm/jgQJvyx+u7L0NeU4CeuhOcgniATy0qhpyQ8RSlQcXt69wXp
 rxTLJmDQ6hj4KHv4bKnigKzT448Xnnf6PWDifF5nhwLRrEKuFO4cbYJf/ltjWnCIjYeJ+QfIiO+
 pZIT+yPc=
X-Gm-Gg: ASbGncub+Diaa7MMAk77MT3tjt27MAezEgiqyYcKxDnHv0O5wUPfZceZMRXyDdjyfRK
 AnLw9RNoQLfohB1vkDRHtEunN71lv33EWV9agdLsOPSwSoVGYMOqllVg3taxgBgTdDZjF3+l1op
 HUHkxbcXSN/WiBwV7IjIblfHMiGhTkS3OLZ8ngUwfGxzy6UC3M3No6rCbdZVTcp8CWAP2tYX/+5
 gbjLj5a+tRW9vjxBfH0iLm1Aa/Hftx46fvWsiIhGq5thRIPB7wgB8Z+oDr0RR8bHZbCJseJqSbu
 FChFR9bEd2apu6vh214GlpA0Kj9SRz5bYLHvkhLXQi6HN3PSvo4oHNQKYXaN8g5tfuE/7sk6dSh
 nJYymulJoXRfcXXvM3TreRBVgtkUjCMOyNmmkEqbrXLo93pBYC2OVEt3Q/1BgUxBVw/J0LsIESv
 cY1qqrXCdCxkQJznlmzplJ+dil67rQcprSh5vSmywOnrd3EnDnWhU=
X-Google-Smtp-Source: AGHT+IHu3bk9MwLyD5fbllYN+n4GPHo3yNQRppb2RVUiOBSzxVQ+cy0y3Q68njGl0nRcK8ER0X+yCQ==
X-Received: by 2002:a17:906:dc8d:b0:b3c:896:abdc with SMTP id
 a640c23a62f3a-b707086a07emr621856766b.60.1761986237920; 
 Sat, 01 Nov 2025 01:37:17 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6407b438b05sm3545016a12.27.2025.11.01.01.37.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 01:37:17 -0700 (PDT)
Message-ID: <fd8e366a-60d2-433d-8782-5a88ccce2ddd@linaro.org>
Date: Sat, 1 Nov 2025 09:37:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] tcg/linux-user/test patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20251031115334.368165-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251031115334.368165-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
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

On 10/31/25 12:53, Richard Henderson wrote:
> The following changes since commit 3728de31925ae9658e2ce3d1ff9b63c83609f310:
> 
>    Merge tag 'single-binary-20251030' ofhttps://github.com/philmd/qemu into staging (2025-10-31 10:26:34 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-misc-20251031
> 
> for you to fetch changes up to 0db2de22fcbf90adafab9d9dd1fc8203c66bfa75:
> 
>    linux-user: permit sendto() with NULL buf and 0 len (2025-10-31 12:50:15 +0100)
> 
> ----------------------------------------------------------------
> linux-user: permit sendto() with NULL buf and 0 len
> tests/functional: Mark the MIPS replay tests as flaky
> tests/functional: Mark the MIPS Debian Wheezy tests as flaky
> accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
> tcg: Simplify extract2 usage in tcg_gen_shifti_i64

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

