Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99BDC79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3atR-0005dh-Sq; Mon, 07 Sep 2026 11:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@gmail.com>)
 id 1x3ZbA-00078v-32
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:41:24 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alanosong@gmail.com>)
 id 1x3Zb8-0001o6-Fo
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:41:23 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-39675172593so2772394a91.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788788480; x=1789393280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F7P71AxZlqHBOffQ6QGIBANDNpaVt5SNMc7okXs8N+U=;
 b=afKyLjbMo6/lRdy5cxwI6FAuAzupyUoEggJHgtAjfS5xat6bCRHlSgFW5oVWFQIYAr
 RhDIvoYSlh/95C+7ElZTkPtbQN42BSclyILrEcQP3SCQ+xquZ0QbhN8YvhIjqZaCLZzF
 Qaj+7JQN2tN/6kV8vrzT91YsVfpjfpk9NZX5o3eP2xItVR+ZPS2AmK7PZdrobrd0Bl5r
 b0sMP9tKrJmShWVwNX7hvvhKsxYizRiNU2rwUY2LGpnSLS3pzEFa1CSB8FW1aP2hxkYK
 OVhljnop1oopL6rs5C2+dppA0K7zly60iro66OwZ2u4ILJIBdWkFI7nJGmBj9IRI6kJX
 aEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788788480; x=1789393280;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F7P71AxZlqHBOffQ6QGIBANDNpaVt5SNMc7okXs8N+U=;
 b=Zj1z2n56YUdNER3r7SlWfkyE95Z3hU2w2nrQJo0UIdJr81xF9rYtHGWhUWd2PRNVQ/
 vK7B4uoKwmfCnG+gGDo71Aluk4rZ/XEXw25hWbjH1huUpOLK/jldYx4pp76ZdkbXbV5o
 0oEYOpq0UYWkd0/Pf6Q3G14Rw96cX8IaYblia6g5pq6U6RVQ72dZVI/jjRffzJDdlqBF
 wegf/Z8tnCvncpZEzEz9uBG+OsHw2BPzfDNet9KtD2YpUffeLlqS9orHEIU08Ikbmh3w
 K7SQxw8t3q0WgWP1h10p5ipOkj4AvVLCTM0l/o7Q0MD7JnT1acvAtk4vKtwFtYjIEtwL
 9S8Q==
X-Gm-Message-State: AFuF++mPIPtdnHniYkVbGpYJFDUCwbudHquib9DHfzc2Zi3BEGmbIyoE
 ssP9Guysd/wXU0EKFskRac5lEdRxbzk5yoeUfzeNJu+OSpSFZ5lUyzrliCvJy7q1YUhtiVeGPkQ
 =
X-Gm-Gg: AYBFou1U/uuNLjJKLlgmEfEHhI+XqQyYJrCMHj9GX2TBInCu0jiAojlzS5AhIJ0vMVY
 6nTaeiv3nVr6DOGsoWJbqWKpPNVW6uhbQfXTA+9Vw3rBTL8tt7FB5XhAXJFTrxQ1ROWVlFqPg5J
 rCOXpmZOAuRlkOgGWC4xKK3sWnZHYdrnKJOMF6I7y6buwagaCieZWYETxMgZPAAgiP5BjG3gqU6
 nd1zWTnMmn5dfQqUF9Nacgy1bTHKnMCdbFrUXaFNbTs/1tzHuDLq1XnhHAp666EmYReoowYZr/S
 w5YaUE3ZPBE0f9WrGladvcsl56Nv8ex0JleTOGukRKIijfWzdKyZuEMFZm8UA7j/960jps9Epcw
 IIKkAikPH6NMUq8ou3UdNELWnqZCVeq1zqon49rEDHJYBvGJNfoRYzxLSRv7883Pyza/v881mAm
 w/bhtuokHEciYQpEP7XGs7FzNEopQiC1dhPfZIL3mH3tsFMck/B/Xg
X-Received: by 2002:a17:90b:17c2:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-39b25f1c5bdmr32652010a91.0.1788788480317; 
 Mon, 07 Sep 2026 06:41:20 -0700 (PDT)
Received: from alano.. ([240e:36f:15d2:6470:dbf:43a3:a2e8:d7bd])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08bcd243sm27989326a91.5.2026.09.07.06.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:41:19 -0700 (PDT)
From: Alano Song <alanosong@gmail.com>
X-Google-Original-From: Alano Song <AlanoSong@gmail.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, marcandre.lureau@gmail.com, philmd@oss.qualcomm.com,
 armbru@redhat.com, laurent@vivier.eu, atar4qemu@gmail.com,
 zhao1.liu@intel.com, marcandre.lureau@redhat.com
Subject: [PATCH v4 0/1] monitor: Refine 'info tlb' command
Date: Mon,  7 Sep 2026 21:41:14 +0800
Message-ID: <20260907134115.15193-1-AlanoSong@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alanosong@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Sep 2026 11:04:19 -0400
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

(Resending this patch to qemu-devel as the previous
two attempts received the following error:

rcpt handle timeout,last handle info:
Host nongnu.org(209.51.188.92) command RCPT TO
respond timeout or disconnected.

This time I am trying with my gmail account.
Apologies if you receive this more than once.)

======

When booting an i386 target, the 'info tlb' command
may walk the entire page table hierarchy and emit
an enormous amount of output. It will take dozens of
minutes to print all the info.
And the same situation also occurred on sparc32 and
m68k targets.
    
So this change do the following:
1) Add a address range argument to help user control
   the number of output items.
2) Add warning note in help message that such address
   range argument only supported on target i386,
   sparc32 and m68k.
3) Print ignore warning when user add such address
   range argument on other targets (sh4, sparc64,
   ppc and xtensa). Those targets only print limited
   tlb info.

V3: https://lore.kernel.org/qemu-devel/20260818132519.186010-1-AlanoSong@163.com/
V2: https://lore.kernel.org/qemu-devel/20260619125602.17077-1-AlanoSong@163.com/
V1: https://lore.kernel.org/qemu-devel/20260524124129.174254-1-AlanoSong@163.com/

Alano Song (1):
  monitor: Refine 'info tlb' command

 hmp-commands-info.hx      | 17 ++++++--
 target/i386/monitor.c     | 92 ++++++++++++++++++++++++++++-----------
 target/m68k/cpu.h         |  2 +-
 target/m68k/helper.c      | 55 +++++++++++++++--------
 target/m68k/monitor.c     | 15 ++++++-
 target/ppc/monitor.c      |  6 +++
 target/sh4/monitor.c      |  5 +++
 target/sparc/cpu.h        |  3 ++
 target/sparc/mmu_helper.c | 40 +++++++++++++----
 target/sparc/monitor.c    | 23 ++++++++++
 target/xtensa/monitor.c   |  6 +++
 11 files changed, 206 insertions(+), 58 deletions(-)

-- 
2.43.0


