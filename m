Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF8CC531DD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 01:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seOwi-000662-U2; Wed, 14 Aug 2024 21:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seOwK-0005y9-F6
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 21:06:14 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seOwH-0003Rp-R8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 21:06:07 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70ea2f25bfaso329911b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723683963; x=1724288763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UMhvtmjGzh0GIRv0GJrNVVQmQyP/LzI/8nQnc4cVW4Q=;
 b=yjO0LCyJTzzL2K5XFfk+EYrC2oTAdsYVsddvWeeRlZ6H6U8oT//ZPTjyojVjZFZHAR
 BRVL8l/JkRnGvSv+kAqNcCk42SHksw5PVjsyPpxfiiKvBNVzc+pES7LEMEQu+cE4j2uQ
 4ywslS8wc1zt+oZO+mmT5YqvUuhdRnnQ7ZeChU55ijLzhd/rm0ZVNwGbDI6CPJlKE7YC
 /pq3BdxzWpHN4igqo1wxeEnxCmT4zb4MrCcCLVO3XBbywrqUSH+qlSSnAXDi8Toq1D6V
 s7rqFSow7db1imEo/yVTvslsWjPK2E5Km6TTsScL8WUoz/jVonKKdirpwU7py0xpF0Uo
 fCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723683963; x=1724288763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMhvtmjGzh0GIRv0GJrNVVQmQyP/LzI/8nQnc4cVW4Q=;
 b=EyrgtGstdK++eQwi7tdiMStDyRVfphv4N5Aiokis0DJu5GdgbfX5c1aU+NJWfAZxQE
 T1p1xuAMU6tNbWj8yZpV4jtGZqxdPIMxK8NMGNaL68AsX6C1haO5YupknLLz/UkhO5mL
 Ps+NI/XKgcLnEBpjCpyr8uoVVmQ1foMSRsjPPnKJktMyxOYUBmBpS1gvbT1bJ5uYSzzC
 k+b4+iibQ208tXwLHQXtQlcUyEPlNbunPZkuTehDMLtaqn9ueDQg1yQ434PqGnUyjbXG
 4nmP84XlDi8TTwR3GqMi9SVAmmzG1UbtFiCuuZkPn/Bg+DXSDNl5R8PUp9wBv8Ociwp0
 15RA==
X-Gm-Message-State: AOJu0Yy0GUoJmEgmgifNwR2JGyQwg/Pw7XAdeKNELyyXyYc3i+QRESbj
 GqpIeFM1Nz9djboqRZyUG8J5Icby8YOU6Rq76kczvOA9cfeHC6LH/xSnzGGR6pUl3b4OErjTHjb
 8
X-Google-Smtp-Source: AGHT+IEQXnDex0g4WAhRiDmn10VE+ml5hHA8J5awL6CVQx1wQC2gKrZjwhHRSC0tBFr8Gx7JuyQPOQ==
X-Received: by 2002:a05:6a20:c703:b0:1c4:d4b2:ffe6 with SMTP id
 adf61e73a8af0-1c8eae85f93mr5858859637.19.1723683962090; 
 Wed, 14 Aug 2024 18:06:02 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1bd5asm179907b3a.177.2024.08.14.18.06.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 18:06:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] linux-user patch queue
Date: Thu, 15 Aug 2024 11:05:55 +1000
Message-ID: <20240815010556.535100-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

The following changes since commit c4d062885529a84928ddd260dab419b7d8dd4f90:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-08-15 07:41:16 +1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20240815

for you to fetch changes up to 3aefee3ec01e607529a9918e2978f365c5c3b5e9:

  linux-user: Preserve NULL hit in target_mmap subroutines (2024-08-15 11:03:47 +1000)

----------------------------------------------------------------
linux-user: Preserve NULL hit in target_mmap subroutines

----------------------------------------------------------------
Richard Henderson (1):
      linux-user: Preserve NULL hit in target_mmap subroutines

 linux-user/mmap.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

