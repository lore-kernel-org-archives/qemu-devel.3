Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFA9F531DB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCPWI-0002HB-1r; Mon, 13 Apr 2026 18:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPWE-0002Gs-Er
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:12:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPWC-0000aQ-Mj
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:12:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d04fc3bf2so2976421f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776118351; x=1776723151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2zcHNNSKvC8rWAGslRgprodHcm0VUiUbvnzD4QAf5lM=;
 b=M47JjwnMoKWwIRQ2QUmcwsat3B1n/LfflBhQFjzDXDHgk+jNyaumFAOfKy4hua81cN
 RxjVlnn6G++J3R6Lu82S9nBm3auD/gv5AjkNSODb2sLBlMCexfiIeH4cTheiDd1ROG/x
 zCWKVHun1yAqR+B56p2FP6D5ZNK1/HY/3r38akKqd5uF1YbexLU+CG6QtuyaQJuIJ6dd
 N+//iLAQjn+oRMjUcoasZUMNn9bkcbNK6pGOeXbjNLm1YVPgM/D+UWTOKxTJAaPx6/KI
 vRUrsmju5HUCOAuBGZ1/XlxFM+VfdO64Hz+eNb3fBLaGShOxxXN5Teu7ET6SfPPPoDuO
 DrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776118351; x=1776723151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2zcHNNSKvC8rWAGslRgprodHcm0VUiUbvnzD4QAf5lM=;
 b=V62y6ElkbXrj1n0Ev9GWmoW0f+6wtwxeS6f+byuCTTyiezTWUgYHwRkxN6aE7CuZ2M
 SG4//m4VQBTStg1af9DXXtmUo2T0VIp2JE8g9iMSx/afbSj/Q/638BvywT8NZR4+gQwR
 63w3eNF/iFfK1eP3LRxKEfXdFtE5pjg8mGiPUwWdTeL6XDPtTj3dBovIjJcS/2cahlJ0
 kT3q0HLpAMt57yf7lhAdpv+RiJAwaswPwLYVWZaoaQAgTc0cIyIbL7cMdsPGjbxADCYq
 udLucGSsBoL/z0/fGlv1nauC9P6mvyVWrN8DNQ+m2Isf6Byno2yusA2O/O82tCMOZSSS
 Yonw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MzjCZHJq7kQxQbb7JRke9AloC2t7/Mvwn0KwUvZ+QQj5iaiDzQSDDvdLjxe6CryA/Ki7WJa/jwen9@nongnu.org
X-Gm-Message-State: AOJu0Yx5N52tzHWiEyo0ajpOOjWW3+DG7tnBkvln+ileOV/7oR1PSLEE
 DHSKGHba6Vrp0Lv7Xfy6eCtgDF7jzA5dApT/pH0Kkj+4M13Heq6SYWciCUCZxAAylp4=
X-Gm-Gg: AeBDies+s9n58CFmSRvqk0RqOztK+D8DaQaH3rPAC3ih9qnvsMjaAfeVwvxVoS8Hgvo
 2fhgEYxASJyPZJrrpLYxe9ySQD/yyY/kEQBt4edjYuJjaN83o0e3NAqBnDmlFWWdd2JYBAMIVjY
 MiAAkAbFaaGc88lSlXuASVoKgAQcb5shGOxPQQ+nzIsE8nmSg75xetwqbKjM7wfkNPFYbCK9o+2
 cANRB+MByTH/pXZkGA8md0i2m+1oaMtY+mS9AP7DmP8HPpylZ5rFKQbVvjKVXD9QjNNnLZqFsa0
 ePUNPKkhCGWCM0lOPYiNjHIbFQXoC450Lr03MaaXAIG+LMJn+ySJkjMr2+WK/91BEZwY/gxUmH7
 J6MKPSF2DSwERKWh2ycpPWn0hXL+45P2aGyYt+Q95GB2QWm/lPeSDR0/CzeLTU09XE7xHYrDyBC
 FxJeGlDf0V5lBXgbxTMYkPeB6IRiCgyqjx1O8TYXxd5jHIPx82/hrptl1j24GgEEsvxsRmkD2VS
 Sk+
X-Received: by 2002:a05:6000:144e:b0:43d:c95b:c46f with SMTP id
 ffacd0b85a97d-43dc95bc595mr1669561f8f.38.1776118350912; 
 Mon, 13 Apr 2026 15:12:30 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5062fsm34937030f8f.31.2026.04.13.15.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:12:30 -0700 (PDT)
Message-ID: <86d2bfb2-6943-4030-822a-07637adfae9c@linaro.org>
Date: Tue, 14 Apr 2026 00:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] bsd-user: Conditionally use old system calls
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
 <20260413-syscall-nr-v1-3-f70408d042ea@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260413-syscall-nr-v1-3-f70408d042ea@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 13/4/26 17:31, Warner Losh wrote:
> sbrk and sstk have been deprecated in FreeBSD for a while now, only
> support them if the version of FreeBSD we're compiling on does. They've
> returned not supported for a while anyway, so no net change.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-mem.h            | 2 ++
>   bsd-user/freebsd/os-syscall.c | 4 ++++
>   bsd-user/freebsd/strace.list  | 4 ++++
>   3 files changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

