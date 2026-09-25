Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3703C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vmi-0000FE-94; Thu, 24 Sep 2026 22:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9vmX-0000CX-NC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:35:27 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9vmV-0000nm-3A
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:35:25 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469e25400so225611b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 19:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790303721; x=1790908521; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f+5VH8IgSfeMp+c9gHYFSXAJlGksosw1y2MpO0QWq9g=;
 b=IFDxaKR271hSA/f4msWavl8UPV0Be29BLfBX6HiiCed7sRcmKBwmIbjNf8Yw3OhDxL
 nlfueDJtd/i6OjHCqKPZVE/kjKHtZrhrkeh5b89hypRNl+IaVSbNYRYJ0uSasSS0DxrB
 bTMk36SbydYEanTHkbWy0HLOESCB34wTvphC6JIVu9p1WtuKCEYQVQGrB8BjAbh0UQlP
 kMByRghHsVdjIIui9c0gsGD8WKt3zv3LjKUW0Xco7vnK7DvkrQqAB1ZdqctNhnm6IOXS
 KK3ydtXPYXYTxmrIhIGb9yExEh+wEDy5Px5vnP00946gRXjvzetsBYkhZM/qkl1u+M/c
 iycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790303721; x=1790908521;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f+5VH8IgSfeMp+c9gHYFSXAJlGksosw1y2MpO0QWq9g=;
 b=1kTq0KUYpKeac68lgm7Ln8e5EECMpxWyscwKVlqFVd/lCq3u6zaOdzoVUMiC0HZnVT
 rKvGloUqtDpQe2D0V3Ie72DF/V7DjgRUMJezmxtAWD3KXHqw7avbtQDyqPfa2FMXMuDs
 8i0DbL2F1FetP+pTZKXNa/kwoa7iNL85bShFscfCyXGV3tuE0iJ3mEScBgP8pV7v4H/6
 i/oNW4gU++IzQIcwZxGU9wgV2JpmBJFpbAC0MEmL3TlPH5YkCdIVwZI540OVGg/cgEpS
 Iwd7zFZz/mHgTvZ5YMAd7S0X+Cms/JNu7i3P6a6YwpfrA9XZCayJECyNTgSb0LeNy/sb
 svkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCjVosq2tmIDKZzP43iv9FVq4j1w9xXoFlf9ART7A7VCewLbSIczTRTASH1r7KW3YCvHVwnO0wCsBR@nongnu.org
X-Gm-Message-State: AFuF++khnnMozGWGAUm3pxxP+ieVZwq2+u33wGR2UZztb6Qn1P/H/7Ls
 AcXJsc3+eJ9TLYcdFiitDOXMB4CZTM+Td2kS2zo6fDRadA2i/rtAs0vbU35qxVTLtv0=
X-Gm-Gg: AYBFou2KYBHB4+ilVQ9j+PJAxjB0K8CTILmMW9B07PLj//EEX+BjjiRdnPKu22s+gHY
 dQXFJnosOsi7LajsYtSLfbfH2ceLpTicqxz+qJSt8H9z0xpwYIttrAHEW9dsqKtviItuibfbFWE
 Gio4dvbB/ZuzC25Hl48dVzE8Z1ZuBQCOM7D/3YAWEMRAxbMXtKESluBZtgXtL2V+kfe7jK27VjD
 p9jBOaAN9GV2+Y+sP/M+zSpd/Az6WJqVL49OkCbqRws1z9jmZmY2namIH17VR0XES2KXD7TFGmz
 adr/UDx5FmenLHgrXw/wtjR8ppEfzXr8SBIMgrSGA0izaGX6SzYA2734RpcB6+D5u+Z35/RjiQM
 g+oJGa58qW44WO/A2XfM/qq5Rao4BeCny0PGNHlOPlDhcCJzWNWEDTRyPGzkzmE2k3jldnExqvH
 rv3RPFGHkHhRGidK+Cx3/ikXIcmQm8nGJuehRDB8BdvTDarpo5FGQTs2FqkC2Dt8uMG1eiy3Q1K
 SHqHHTuClcpADFUHIiBf7mZa8I/rM0IK/Cn5meC
X-Received: by 2002:a05:6a20:748f:b0:3dd:a196:30a5 with SMTP id
 adf61e73a8af0-3de0e9b3197mr3995069637.85.1790303721038; 
 Thu, 24 Sep 2026 19:35:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc78794381bsm468034a12.23.2026.09.24.19.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 19:35:20 -0700 (PDT)
Message-ID: <52fbb587-3406-47d2-887b-52f1cc634976@linaro.org>
Date: Thu, 24 Sep 2026 19:35:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/18] Misc target/ patches for 2026-09-24
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/24/26 08:23, Philippe Mathieu-Daudé wrote:
> The following changes since commit 942229961efea74b153c44c59188eb08375f10f1:
> 
>    Merge tag 'pull-tcg-20260923-v2' ofhttps://gitlab.com/rth7680/qemu into staging (2026-09-23 15:14:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/target-misc-20260924
> 
> for you to fetch changes up to cbbd4d74eb298e2b407018185a40cb813435527e:
> 
>    target/ppc: Stop vCPU thread before calling parent_unrealize (2026-09-24 17:22:06 +0200)
> 
> ----------------------------------------------------------------
> Misc target patches queue
> 
> - DOC: Improve SysemuCPUOps::has_work docstring
> - MIPS: Let TCG middle-end optimize MXU opcodes (not front-end)
> - S390x: Access S390CpuState atomically
> - ARM: Access halt/PSCI states atomically
> - X86: Access interrupt_request atomically
> - PPC: Fix double-free in ppc_cpu_unrealize()

Applied, thanks.

r~

