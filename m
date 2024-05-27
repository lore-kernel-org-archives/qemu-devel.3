Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9816AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 02:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQBr-0006n8-3v; Sun, 26 May 2024 22:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBQBq-0006mn-1j
 for qemu-devel@nongnu.org; Sun, 26 May 2024 22:34:22 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBQBo-0005Sq-EY
 for qemu-devel@nongnu.org; Sun, 26 May 2024 22:34:21 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-24ca2f48031so950388fac.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 19:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716777258; x=1717382058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wuXLePSSD+HqyEqAHbhxxfJrfskmQU8ReRJbUWpgVLo=;
 b=HrRFMqLMvJDS8T1AKg9OwZkhSOJIR5f8LkSjuLcnjz0UN7XU6ILubPr+qU3+Mi0gy6
 +9XGH9rA3qHKWFX0r7doqfP7rMU8F3jASx0qBhYD/XMxN12O7Q+2RLbYtf9k/agK5g8A
 UGQ+mFlTYZR5JLHNHmaoS5wkKpOH9Dgi6LlunBtj9yWTQHOhVM9llMfH2YZ5Sse5X34c
 Prqbwie8DOwqS3//M4srI11pc6PouYghe5ZGYLoAo7VFPENM/jcBsXlebNUXl/WXGWtn
 iYX/d3YhhP6IEFciZ0Z5z4wQRI7wZ6qSr4Cx35H/Q1iM52wsmEr73vACgquu0urDRYwn
 DFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716777258; x=1717382058;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wuXLePSSD+HqyEqAHbhxxfJrfskmQU8ReRJbUWpgVLo=;
 b=eBFZ+Ez0HafKcH9uQCHsHhFwcD1c1PIPSfokgacwBnXnV/PxRAOKgoT2kaFQBypp1G
 iGMiQRyeVFHs87nBSw7JFURIP/g7BxyCy0lBLbWC2owNmWNzFi7lYMjHW9uFkR+QFElU
 JkymKLygO2Bw9rJqmfnixpvR++nT7/PQZDiY50CbUntHhSGeZ12RMg/7mBJ4MTvXFf0H
 D4GO5mdzFTeRNiYuR/crDAp60A+rIvLGkPcbeaJk1fbCBn5mKSOzIw+J0rLhIoRPc+aX
 d97kGFQP2yd4YRE1AUV0/zeltcwO87HEXoqZXa/LEVNpFWR6Bk4wqjcMrVqwceOZHhJb
 ELaQ==
X-Gm-Message-State: AOJu0YyUzvxAkG77iIfjaL80JoiNDlGCCpRog8aGnyUB1FDCwwe8XEEd
 C5Z4oRt91OPO5UMx9OGLJ2POEa69YT8ZHJWjp7yaSwg/lMTJ/IaFqemPT4i/z/aV1Z+BBAW7vMH
 W
X-Google-Smtp-Source: AGHT+IE+aJQym/Ub6vxfjZiExWpAeUIDGV+f5vS8o0xAWwjE+SvdHMxueSYlJgFkBW644qDnkRn04g==
X-Received: by 2002:a05:6870:84c2:b0:245:50bc:9927 with SMTP id
 586e51a60fabf-24ca12756b6mr8780254fac.15.1716777258432; 
 Sun, 26 May 2024 19:34:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd2d2240sm4120625b3a.175.2024.05.26.19.34.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 19:34:18 -0700 (PDT)
Message-ID: <c3c0599a-4bef-4696-9134-a082fbe9709e@linaro.org>
Date: Sun, 26 May 2024 19:34:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] linux-user patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240527005001.642825-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 5/26/24 17:49, Richard Henderson wrote:
> The following changes since commit 70581940cabcc51b329652becddfbc6a261b1b83:
> 
>    Merge tag 'pull-tcg-20240523' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-23 09:47:40 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-lu-20240526
> 
> for you to fetch changes up to 701890bdd09b289fd9cb852e714e91373088b0f3:
> 
>    target/i386: Pass host pointer and size to cpu_x86_{xsave,xrstor} (2024-05-26 15:49:58 -0700)
> 
> ----------------------------------------------------------------
> target/i386: Introduce X86Access and use for xsave and friends
> linux-user/i386: Fix allocation and alignment of fp state in signal frame

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


