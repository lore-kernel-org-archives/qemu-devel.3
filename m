Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DE5E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKAc-0003nb-RZ; Thu, 19 Dec 2024 12:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKAb-0003nD-6d
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:18:41 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOKAZ-00078N-LA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:18:40 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so621592f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734628718; x=1735233518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KfPiPUjFsumJS64yYOjiSxWoR/mhyFpiejP9o5sILiY=;
 b=u0PwwKgBJhnuzJRZXbKur4f8OdhL3mKWA6eu6QwVu7FW5OOfvD/vAEeqbipZ8oEmmN
 esCFDSKQdS7YCapimm4+f5skmjeIHKTfhxHrM60KtkAvN0pdRsyyMj8a3KI8Eb7s3DaU
 Stjj1gyRHRmBsqH5aBDuoEjstGamSAPvxYIvD2e/IAEY+ohCDBE48c5bnuvcPQWCqePm
 YJdEAzHwK89vqgk4Tjr7qoUJ2sDBhps8h1FtGwM8NAOnGToHLznEvYZaUt9+vm3G8gyY
 8hLGVCvpYJ0gqVkj1m6lWQMVZ0SHmdo+p7Sq5RQM/LHRD+S+7lnuzZBLLP4pV/qxMOCB
 G3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628718; x=1735233518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KfPiPUjFsumJS64yYOjiSxWoR/mhyFpiejP9o5sILiY=;
 b=a/P+0q3LjF38z7d0a91pYeLfRxMoo8fDClTZ/EOEnFbnnqbMIy51Jp1FxEm9873P5L
 70W8ve9xlCbSRP9L7vD9+L5edwdByz41yfZahdGjDve/JUCGLkRtxMfCESaYDYPh0uvB
 JZ2WfoAjSHkuuJoe9ulCMHWpChXekcLFIUfE+OxCUjXTzSPaLv53LRWDMpwgsQ01vDLe
 n7IDgO+FjsgHkJDyxBv7dJ1CmJAdxLooXyA6pMOFOswZ8pk2AF2dqqb+Jkt+NIUkZ0e5
 rflspDl/KiMJy9y4pwUTftF7igcATnhLy+gWdewvhuG8T9MSL9BApjPfshcsrtYyPuKx
 Ijwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4kT2dicLXvyMEg6wnOHxixV//fvBqF6mKgSSjp2M/z4LWE7lh4TVKzuk+d/mbvRP2AHi1512TDQKo@nongnu.org
X-Gm-Message-State: AOJu0YytiYCuZbYQ/LbOKSqdVANy78N6YK0c0hxw34Lo4PamKqagTJs+
 HjaVG6AsYC+yLBA2faNJWNcAoA0fvhNckpTkwjmTVW2Xd7Ah4rgHrzbNFkySwDnUB8hw1DRNQsR
 l
X-Gm-Gg: ASbGncspiXyKtfwooCvHhift1Gw+E4l9REBH2gJesRw8VIjU+kZTp5lkmm4lxd1deTW
 ag/qj0JTitlDoNaWi1SdGiOq2i0+SlQuJ1yzZ9VI+qGF1OYq45ouFMynLr2a2Qhrx9GBH5PE5lA
 R5IqPI0ihSgmeil2u7cwfg4zbG2B3FV6IgzdgB1NgKiZw3pzQwHDE0o4JLqAXhbJtnhaNBoXe8I
 0IPoBmz4FnksEZHrMfYOdBJ+kci7hWveFvhPaL9+ibYB15NRPCOqeW4HfvCaXb+0F+1Jh8=
X-Google-Smtp-Source: AGHT+IGnspWY8onnkoERMGhexwEqNpeVF/hycDgqWhUuKyhLkiYS6OVGt7XkStdP+EuCWbhyDXbq8w==
X-Received: by 2002:a5d:64cf:0:b0:385:f349:ffe7 with SMTP id
 ffacd0b85a97d-388e4d2f488mr8592777f8f.2.1734628718035; 
 Thu, 19 Dec 2024 09:18:38 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b11495sm57270105e9.19.2024.12.19.09.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:18:37 -0800 (PST)
Message-ID: <06465848-f7a3-4d36-add8-ae0230d34495@linaro.org>
Date: Thu, 19 Dec 2024 18:18:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] include: Header cleanups around "cpu.h"
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
References: <20241218155202.71931-1-philmd@linaro.org>
 <68eba002-1dc8-40f3-b1c7-72a6ad930a63@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <68eba002-1dc8-40f3-b1c7-72a6ad930a63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 18/12/24 17:42, Richard Henderson wrote:
> On 12/18/24 09:51, Philippe Mathieu-Daudé wrote:
>> Philippe Mathieu-Daudé (4):
>>    target/ppc: Include missing headers in mmu-hash[32,64].h
>>    tcg/tci: Include missing 'disas/dis-asm.h' header
>>    exec/ram_addr: Include missing 'exec/hwaddr.h' and 'exec/cpu-common.h'
>>    exec/cpu-all: Include 'cpu.h' earlier so MMU_USER_IDX is always
>>      defined
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Though, frankly these are hard to review in isolation.

Sorry for that. I'll send a PR with what I've already queued.
Next patches should be closer to the main tree.

Queuing patches 2-4.

