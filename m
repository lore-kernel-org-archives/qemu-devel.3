Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8307DCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 22:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urOxt-0002AW-Kj; Wed, 27 Aug 2025 18:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urOxr-00029l-KX
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:49:59 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urOxp-00066N-SC
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:49:59 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b4bafe2e538so382346a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756334996; x=1756939796; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vl8qTt5GgClBwkr3QJuiFld49KJnqCcZ4pTpk0ixsqY=;
 b=bObI/YUshabOzw22RriewP2D8Xu6nkAOBdhcsT6C4A1+RjIixnVvJE24/WSxd+ISbB
 qSBZc8LPDTOQ60l2LhWgDG2jc6UvmDxXeeCQ9NxjH6h9TaELNy83nWtn6SVzttqTUV3K
 8cvVjJY/uMrnNWgXWmgzKrhxPAyWSfGFgObEuzC5Jww0qc8Rye0YL6U8Juw3wGMMciuE
 ewRKzEZwEOaZZ2ZHyG7wYLSgeyuKfig7Fqt6P8r3VBaW/fZc3AoJb8+Uxk2I3ITA2TPp
 fbKugP4SzHP3GkfNmrJ4w8ubhQbQRxJ+tdUcUT+zBgI9YC04+Htdx3UPhEDU6kL4JDqX
 GZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756334996; x=1756939796;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vl8qTt5GgClBwkr3QJuiFld49KJnqCcZ4pTpk0ixsqY=;
 b=lqVTDB4eTEQ6InBMGkV1+Efwg2kA/ubVWZlojwZmjEz4VYPgebUPlS8nGEKxiVckEr
 W6cFxKBQBVUXV16XS9wswjqj+a6DDF/Q2Lfxhqqpp6t6cf7M9ENzjMGn7fh1octw+AuS
 TRAZVTQcDzpdEaI6aZTmVzxHBJ4aQ7SQzyS3fOaaK2my5MkpuWRl1DVoqdoQco14y2pU
 8WLHKcuJatewyxetRC0P9czd183E6a7l5ZwlzVUne5beyF+TMeNFfw3QatLUzyJxPAE0
 MucLGNhe5MZu5nC66obstrNL4ccbkWXB7e3KnlIXke2xu7npXZO7sZUuJwXHHg9FODgK
 0/zw==
X-Gm-Message-State: AOJu0YyIKcoh+fvhGAhuBulnrWbokjJVEo4Ntk+AHD3Jo3MKo+nN7DFv
 Sq1yTGOsG5bGOr6A1MonfVIf/eUDZmfEfWTOc+NkF8W3JmZRLD3ciNqsbn11dWLCE+Y=
X-Gm-Gg: ASbGncuuqJwifa57UmO0SB0rvDPQpf49toChzsxslf0ISSJg70HQgDeB/EHUtb8vjRe
 O/cSHpIRx/LK9vTq6u4R0RLid+q3Q2hURfmSItrqqEa9d2ak+BefCx29yRp+LUOzgtMbMS4KRCX
 lIDeE9Qnm66R3NNjvmEGSYK3nJ2wMZJS/+l+29a0WYOqRlCez7NZiZ6UUhP/r8Jhd+DLQHTHopO
 g3k9+MKmFhgENJoA0mMwTSkt0OnWZ7bVFlpG+LLDx75IvYx6GqDAp0rURhFTecwJCRwM553nupR
 XS0VAyTm3uNL9x7HbDIKMobhSWja8c2uoHXP9+dDg2Qt0GHXN5Lf+bhl9l8yvZgMkUmkczxNG7B
 KM9kNXJyBeeBVsUbRKg6zPt+JCIzVl6/EOV8XIf5HFTsqhmo=
X-Google-Smtp-Source: AGHT+IFKwmuBvLSFhlhu3UWkqeFGNtKDfzxY4cCm+i5dF4/fU1hrPuC/B/vDb01LdPGJJxOk1JU7EQ==
X-Received: by 2002:a17:902:e745:b0:248:9429:363a with SMTP id
 d9443c01a7336-24894293a0dmr52550785ad.9.1756334996055; 
 Wed, 27 Aug 2025 15:49:56 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248da18a5c9sm796445ad.150.2025.08.27.15.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 15:49:55 -0700 (PDT)
Message-ID: <56800442-3962-43b9-9b87-1b899077a24b@linaro.org>
Date: Thu, 28 Aug 2025 08:49:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Failure for ./tests/functional/arm/test_realview.py
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

2025-08-27 21:55:08,729 - qemu-test - INFO - Downloading 
https://archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1-realview-vmlinux-initramfs.elf 
to 
/builds/qemu-project/qemu/functional-cache/download/d3a01037f33e7512d46d50975588d5c3a0e0cbf25f37afab44775c2a2be523e6...

This url is now stale, and is causing the functional-system-debian test to fail.
Do we have an alternate?


r~

