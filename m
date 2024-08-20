Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4DAC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 05:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgH7C-0004Kn-1L; Tue, 20 Aug 2024 01:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgH76-0004Jt-8m
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:09:00 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgH74-0007pW-8b
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:08:59 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5e97b8adbso2988047eaf.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 22:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724130536; x=1724735336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m8pbb/r1bOyueycmYSX+/V8MgQZDv5WNpLvf/pPlpEo=;
 b=xLXgKv9cCertAiwszrsc3flMQYWFaYit0FrRNzr39GsNp2pKd7oV9C35X3W2I9Q1/q
 CnZ5jibbzhNlraBimNyalSOgi2pZf1Brh1XPsrpFvUk4W70gtek/8W1I8Q9zW33tMPSA
 CngyE9UNXows62pjpBGSZLIOGtKyE9XO6cs2uVZeSG0Ubb3SuicC4n41GFwBukP5BB+q
 cWVJVVhKPocSXydLffh5EkZl9AWGK+2q7Ute5NEk0M4XnInw6q7doaWOKXjM4eZVxPmt
 ISZOoIX5p0GU/KgA84Ub/fnQTJQUze4OiI4k/T9nFxT9hYbZGSwDGdEM26ptcFfxdGDP
 jjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724130536; x=1724735336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m8pbb/r1bOyueycmYSX+/V8MgQZDv5WNpLvf/pPlpEo=;
 b=u7fKFaX2t6Q/6jsuYnvP+gEtuGQdCXd6dxfWhqQ/7uDVyEASW9YuyRcyDlFbWoZv+Q
 WQdR1HwIq8iNfWkpP3m7dtfbP7+ushWpLdUV1aLx/5mtY0HGGx6ToAbCz3Hv1/ZzSP6k
 MylYBPk+XEDXfcJcu3Foj3XQllFfOQe3Wx7sVNL7zWSB8/xyHfEXWlccyRJFh/bf8Rkf
 T6VV601gL6x4B8oltNCcSHjvibAns4OgmzfiJRVPh0ePQnN76Gfo8eyY/DEfWwyLNC4N
 nlTIl2zYo21R1qY69Fm4PDKzLd69sLneYfDb00BxH9csXjDS4N9UxGOf4O+VsFQvgxoi
 Ox9A==
X-Gm-Message-State: AOJu0Yxo2evGw1MNNxJYzHW+9/+y+mru9NjEmfnx+bbu0ROANg/Dij3u
 CLCzgTtriHgRR70LXbD2FJJESiLEZt9nU01THcXuanGHRricnyFB4QfQKBBhNFIXu5j//SFIKwF
 ZRWg=
X-Google-Smtp-Source: AGHT+IHS4OpmdvJvH94LKjuFEQ1vcY11p+O+mbDWhfR4sfdv2T1gkvCQ+vf0ou9tqaJBfEuLtQHogA==
X-Received: by 2002:a05:6871:42c6:b0:270:2c7:e19c with SMTP id
 586e51a60fabf-2701c095fd0mr16106514fac.0.1724130536380; 
 Mon, 19 Aug 2024 22:08:56 -0700 (PDT)
Received: from stoup.. ([203.30.3.188]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af416fbsm7382814b3a.207.2024.08.19.22.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 22:08:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	philmd@linaro.org,
	imp@bsdimp.com
Subject: [PATCH v2 0/2] *-user: Handle short reads in mmap_h_gt_g
Date: Tue, 20 Aug 2024 15:08:46 +1000
Message-ID: <20240820050848.165253-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

Changes for v2:
  - Handle short reads from the mmap_frag subroutine.
  - Update bsd-user as well.


r~


Richard Henderson (2):
  linux-user: Handle short reads in mmap_h_gt_g
  bsd-user: Handle short reads in mmap_h_gt_g

 bsd-user/mmap.c   | 38 ++++++++++++++++++++++++++++++++++++--
 linux-user/mmap.c | 44 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 74 insertions(+), 8 deletions(-)

-- 
2.43.0


