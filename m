Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E003C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 23:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO3iJ-0001HH-QK; Sun, 30 Jun 2024 19:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO3iI-0001H6-Gx
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 19:12:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO3i4-0006eh-DH
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 19:12:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fa55dbf2e7so11392905ad.2
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719789110; x=1720393910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XTksYQLNtNyBi0f0jiCbsaGNDPXhAUr/8Ik13uQ7cO8=;
 b=uqk4nLt7U4z83YRQmiYoJopErZdLZp1DaLxicjbn0Zv9cRH3m2yWdHODf4//iQaJxu
 lNYtPMMaxdvvdx0vf2NqD9rOHPJZdRGLq7ISSpu+1LVOd1uUOyCHo888nEpW0gXzyty1
 l5ft8FS54Z3/y7CNr/bcoXlpg3M5mNTz9M9Z1MuQm93+HjVsRW3Ghb1Pe3XCEvMTqtXV
 mxUkpNpoL/5P6VZ7qlcq//iQE3de62bH49L9hlOnReEa87jbfX21XoXUsryLoRwMQjKn
 YSzY3M6/znCi6xRM8h/dy99Eg9kE7CGim+3wd3B+mzUb6I6I4RZEHK6lgHh7tksJtnoS
 GYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719789110; x=1720393910;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XTksYQLNtNyBi0f0jiCbsaGNDPXhAUr/8Ik13uQ7cO8=;
 b=tS8I0MOQ5ISBECFBO+hXd5HgONpkHnwEv/jXZ/GruWqTT3ePyXwD/CSxQcg4t4W9c9
 Q4qTxYCDDg7wwFTNLTlvz6OczHefRWad44zgNFDG3PPhaQgnNpZRPZhwqsvnFO8d4HW2
 Pitm0ND4bvqoyZ5ITri1Sw88JI/kQ49Zqco9NEkpZQ8HzQ+MLzBgL4AF+QYh+oDx6+vq
 WlfhLf5xkrKvrlA1Joq6Ypzm5jj/EStabUJ1R+0z2pcpsZAYepArGAne7kf6pxOQRMdJ
 I9NUI6OCymlmgBCyeX2NQFp7mEfI5ZsyqnsdvtD6u7528ojqmrct6K8DaDBFhgh6LF5n
 t8Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLzSIZoPCFwZQYxIObyY0G4eBjYcN6PTEh2W0BHlsnqfx0krJp75yBvvo7fuLGBU+0z+88oWPhSCvtz1wlNb+sUXhZkWI=
X-Gm-Message-State: AOJu0YyXzu+mfad1b5t1sSCJOsCFYa26Ta8FbUt54g46uB5jS6QgdP8g
 PJgr+wJ9w7gZQTKlwM8s99zn3wC4jDxxibyJdfje5nr4GtQB3C/qVUv2KpIXWw4=
X-Google-Smtp-Source: AGHT+IFKkkRIGMFJBVK1CldloBOrE7rL2wjGCOHmZPSXurPgSh7iyC1UPrITWHm341nW412/o5a5uA==
X-Received: by 2002:a17:902:c94b:b0:1f9:8e2b:cf33 with SMTP id
 d9443c01a7336-1fadbc8ec2bmr20412485ad.26.1719789110350; 
 Sun, 30 Jun 2024 16:11:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15694ecsm51106915ad.226.2024.06.30.16.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jun 2024 16:11:49 -0700 (PDT)
Message-ID: <62f95d15-d8f9-4fd1-b97b-7c032f8261c3@linaro.org>
Date: Sun, 30 Jun 2024 16:11:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] ufs queue
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
References: <cover.1719719120.git.jeuk20.kim@samsung.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1719719120.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 6/29/24 20:52, Jeuk Kim wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> The following changes since commit 3665dd6bb9043bef181c91e2dce9e1efff47ed51:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-06-28 16:09:38 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git  tags/pull-ufs-20240630
> 
> for you to fetch changes up to e12b11f6f29272ee31ccde6b0db1a10139e87083:
> 
>    hw/ufs: Fix potential bugs in MMIO read|write (2024-06-30 12:44:32 +0900)
> 
> ----------------------------------------------------------------
> hw/ufs: fix coverity issue

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


