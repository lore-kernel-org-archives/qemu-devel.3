Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDEAEA813E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq7Q-0007ik-Az; Tue, 10 Feb 2026 10:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpq7I-0007gP-Uw
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:57:32 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpq7H-0005hF-8y
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:57:32 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so3616457b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 07:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770739049; x=1771343849;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OryOIsgnjn5KJVJ6sSqfDKX8UkgRSIrSf/0s+oJzQsA=;
 b=f7UCLjDpCDGdUl8kHz77McOGKrwddxubUzMigQiFtMJxRKcXop8mDen43c/E9Di/82
 VAfTGt104jHWKhMq4VralAORwIvVIBSOs8TyYTJTDeCFx3aMC7mGbLXlWtG1+IqkrPin
 5Ymb9nN5cgJPYAzrXxlqZlw0ix7Hu3Fhup5CKGZPwLKyLhOTkRT5VRFXfb8JcgYABLS/
 y4mnH8kHrFnXTUg6V2PxUxyXnQukoxnkb7sdrwyFZo+9A/WMk75diWWe+1diSQjSX5U8
 mUb5H6YerNF2cMa3TuLsVPZiqGrgmdLCH9SeiXa90IhkyTzLCYlZftwSDPEveibxHWSm
 6Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739049; x=1771343849;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OryOIsgnjn5KJVJ6sSqfDKX8UkgRSIrSf/0s+oJzQsA=;
 b=K8qPPGl7nJBIl9UrVj95KmbnPuZMA+erOK96rUgKBxJAEckICsTg9Tzznf920Y3W6n
 gSgTRc3ISBhKKE2ZvEyotzsZW8F915NH4yysCgoCSznx13Lxv3GP0ddm466fp5v6PHLF
 j4CLxCyRz39tuk2iwMknFb6eA9j24BUk4V/E9kXU5rWyZ0rwU7x9ieRwLJ2fsx9ONjQU
 Tp7Si+EumNhZQlI05f1kA89U2RW3sSD6fWKxVV5wWiR2ve9y8hUOzhmpuVwQmVSb9zCN
 cZrjyFNzyhWn+cNWLKQ49vsnVycSYm0iYC0SVdIQ94H+gErOA/syBjx9yDZ96qNLpOL+
 8idw==
X-Gm-Message-State: AOJu0Yw9kgm+zLO+cAO1ZVT4vXu/A1qhhbDwuMf9PG7EAhC17ID80Fjc
 R1idDX0KnGP18JOWqPb3jQnbJzQfGEvyC6X64dVpCMVGVKWqjKr7jVzg5WaL/WbcgKDlyxqGyrN
 Cl5HT2fU=
X-Gm-Gg: AZuq6aJvU5oNoz8GzMsBrQcaWDPFGKHZFGulBi6rvRtmTaYQzKANM9/UqR0w3zg8tl1
 /2bCEmADTjR6IFSreYYVRoIf+HJFo315OkebB/1/ez4NU2ZoO+k+/Lar5XlYjJlrb2iBL48SskI
 S9DZB/60ZKng205QAuEsCx/6hhADTtDxlFEy9ufBUuu4CzjDZMC5gK0kZFeXQTd3S9VD1kMDM86
 we88czv41qDmK58zgs75PlGj9HulR8G/nyrOTWnxV9r1BK7WcwSXg8IafmuhagIUB7Z+miA0SpF
 RKfJZCulRr5Wp0np4fOAdK85MeSK2ywRxMuQMkzUlAy1+YwC/M0pFp1roQ/Zp1GX45h2eEQ7sp1
 V0fL0QxeKl8qNV8Deq6l8iy1OTEP2d7+40S3yMwvIqUE1IoaXF7L8gnl5ZANJhMcUYRDWD6hOSh
 ik30xDAbGQwQ==
X-Received: by 2002:a05:6830:6a9b:b0:7d1:94d0:e8f1 with SMTP id
 46e09a7af769-7d4644294d4mr8545728a34.15.1770738400584; 
 Tue, 10 Feb 2026 07:46:40 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464457a98sm9841679a34.0.2026.02.10.07.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:46:40 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 0/2] bsd-user: Remove netbsd and open support
Date: Tue, 10 Feb 2026 08:46:16 -0700
Message-Id: <20260210-bsd-user-rm-openbsd-netbsd-v2-0-3dd10091d359@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhSi2kC/32NwQ6CMBBEf4Xs2TVLUQKe/A/DAdqt7IGWtEg0h
 H+3JZ49Td4k82aDyEE4wq3YIPAqUbxLoE4F6LF3T0YxiUGRqklRjUM0+EojDBP6mV1mx0sOay6
 WbF9VqmVIgjmwlfchf3SJR4mLD5/jay1z+9OW9E+7lkjYDM1A9kpateaeWpnms/YTdPu+fwEmc
 jeTxQAAAA==
X-Change-ID: 20260206-bsd-user-rm-openbsd-netbsd-fd4f0fa3329e
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3161; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Zxnz60M39g3dcN41PhnzKhqeXiUbks7QQsV+o3OfaNM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpi1LfKVqUW7t0L+yPoWLqIGLtlH6nTu2TtXvGa
 n2VItRgGSOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYtS3wAKCRBsHNEofbAR
 ABzcEADStMeXQ0/4idUeqDx4ZyNtoDHlitlgCa6lSDcW604X5+dFzKRmmCwtcWUkIQ90pzetsCl
 dQ+oQAbV0t5o4qJnr9weFco6K7R9MgSXZHiR3OXDVYiRJEnRJoOugIAsamfECQJm8w7DQ4BLMGP
 a/imoX7aH8w5hK2pWiDGGjcfOKtFkziuQpZU9CohCt6qnRGnThMOxJhwE/2GiFo6Poj0HWcKqKP
 DalHEoKfYVnRELhcS0JGXGTr2vQnLMO27Wgzfin8AxNF5Q/G76eCYUVEv+0GxrX96bPJL87uAi8
 Kb4THNhrT8ELTtB+F+09Er8RfA1ilUog47fH2woh/QPFvAkEgSAGjqeToZ7DWtcl8yg68q0XCPx
 4o1k24UE77Jusq84uwULR4DFgyKKMWHsIWC2QOcvXe/rjH+8xcJw6+6JgITbP1ND4lpqnQiyJTb
 KbKiFKLjNpYJ+FmoRjbbrxb2rXwCnvFSalGyBwHA/2e5W6BmmN7nkHC2TWF5YjwSVjmee9Qn7J7
 vV+Sdmh0nbp4UZiTM5hc2u7HuC1hr9u2bUHQNuIvEIQynrPsN3adz6q56Dnnw/skd0hiCtpZtLC
 z+HaD6gMxDXtX8Wz3zPa09EXGfYa1dWyVrUtQnHYD8kTn/zKj/xhDnKaybTExlZGhPk/gim1ua8
 8w0OIqUtnGjGVCA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=imp@bsdimp.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

bsd-user switched to supporting a single BSD compiled in 2022. We've
only built on FreeBSD since 2021. The NetBSD and OpenBSD support in
bsd-user, even when a hacked meson was used, hasn't compiled in years
due to bitrot (the last time I tried it was early 2023, and it failed
then due to easily correctable reasons).

In 2018 I tried to connect with the NetBSD efforts to get bsd-user
working there, but they didn't get beyond a few emails. I contacated the
OpenBSD people and they said at that time they'd not used user-mode in
years. I'd kept the code in the tree on the off chance it would allow
this work to continue, but there's been nothing contributed to either
bsd-user/netbsd or bsd-user/openbsd since the initial import in 2008,
apart from the work I did with FreeBSD to separate the BSD-specific
requirements out in 2021. What's there now is so badly bitrotted it
would take a very large effort to make it work.

It's time to give up, at least with the current code. This series
deletes the netbsd and openbsd code in bsd-user. I do plan on still
trying to keep the bsd split, with some common code for the 4.4BSD
interfaces that are still around (not many: most system calls have
evolved independently since the late 90s). And I do remain open to
working with people to make netbsd and/or openbsd support in
bsd-user. As it stands now, there's code I'd like to merge from
the qemu-bsd-user fork that this code is in the way of.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Changes in v2:
- Drop build changes from this series
- Link to v1: https://lore.kernel.org/qemu-devel/20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com

---
Warner Losh (2):
      bsd-user: Remove the openbsd-specific code
      bsd-user: Remove NetBSD supprot

 bsd-user/netbsd/host-os.h            |  25 ---
 bsd-user/netbsd/os-strace.h          |   1 -
 bsd-user/netbsd/strace.list          | 145 --------------
 bsd-user/netbsd/syscall_nr.h         | 373 -----------------------------------
 bsd-user/netbsd/target_os_elf.h      | 148 --------------
 bsd-user/netbsd/target_os_siginfo.h  |  82 --------
 bsd-user/netbsd/target_os_signal.h   |  69 -------
 bsd-user/netbsd/target_os_stack.h    |  56 ------
 bsd-user/netbsd/target_os_thread.h   |  25 ---
 bsd-user/openbsd/host-os.h           |  25 ---
 bsd-user/openbsd/os-strace.h         |   1 -
 bsd-user/openbsd/strace.list         | 187 ------------------
 bsd-user/openbsd/syscall_nr.h        | 225 ---------------------
 bsd-user/openbsd/target_os_elf.h     | 148 --------------
 bsd-user/openbsd/target_os_siginfo.h |  82 --------
 bsd-user/openbsd/target_os_signal.h  |  69 -------
 bsd-user/openbsd/target_os_stack.h   |  56 ------
 bsd-user/openbsd/target_os_thread.h  |  25 ---
 bsd-user/qemu.h                      |  16 --
 bsd-user/strace.c                    |  34 ----
 bsd-user/syscall_defs.h              |  23 ---
 21 files changed, 1815 deletions(-)
---
base-commit: 0b91040d23dc8820724a60c811223b777f3bc6b7
change-id: 20260206-bsd-user-rm-openbsd-netbsd-fd4f0fa3329e

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


