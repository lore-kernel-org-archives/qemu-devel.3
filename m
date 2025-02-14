Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D52C021A0
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 01:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tikum-0006am-K8; Thu, 13 Feb 2025 20:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikuk-0006aQ-Gl
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:46 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikuh-0004N0-P1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f6a47d617so26465505ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 17:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739498080; x=1740102880;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BI5k4Uv13wqigQAaQ4ocZOhdP/HOaYepWcvTctTSi0g=;
 b=D9pLHZKr982Ty131mdlzEZkscjbPG00dl1oQoy0/TAj+6XEa+JeWBZVF7ofdNHuach
 u/euhQ/srrcoua7tg0ayic7jYSS4NT0VJ0/aFRt/eTzcwUUMXSnC74oFdem/imUdp3h6
 t6UYmtrajGNxzkXdI7FMzVDwV9VMG54rNT3TrOdf/6gkNiA0dCFHpVPTYpsTUPgqks9y
 Ha/KuvsAink0PHrsfyyVhYFq/khSwZq9qt8V+mFy0n9gPmXmhseQp+frTnUdM5gvIGHy
 Ft3gOwWot4FGWQUaqdDOQBhrv0szj7j69PC8Tlhzfp+2NOo9fiOFHlqAqvx4MsKn/8wj
 l4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739498080; x=1740102880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BI5k4Uv13wqigQAaQ4ocZOhdP/HOaYepWcvTctTSi0g=;
 b=BafUenKZjkL9GEKeEqfBp/kFnmabEf9wLxK+pzWAAWrmolK4cwTNgesXbAF888/Kr6
 34fiON9eO6+zNC0StBtKggJ1Qfh6680lx5AraL0gqZRzIgMNi8QuI/6ZhbjospKKB9Ti
 7Gp+3fO7GapEgtqpNU4DO/V6TDCIncjJ8yiWDMcvTYBhKXxc5u4POP7rw0enbLQSmM5G
 91l5fz6L1Bu7eFhPRcumLGpLMQs8E3+HUPjj2GlvMYDi1M2TgIZLlQwChwEEKBtUNW9l
 Xun4AE+GiziniZ429MNlyyHLxec03uD/lz5k3YzggAb6CF0qlSaTalCOaPoWtIqk7cuW
 K7EQ==
X-Gm-Message-State: AOJu0Ywy4+euTldocDyp5eiDMzSsU70BLOIW7chLqSc8gsc/8MR1JZnu
 uNOUJWQjgCiREQ9golb0R+j2U2iSup1d292QoHXOKYG29M0j5wbRmz9unvFyfCpfGqozBGRrs1C
 8Jn0K6A==
X-Gm-Gg: ASbGnctlPXd0mLXmCQJL+ZzoxfoQfNg4oe/gkPuV71YcbPnktho27h63LeVnsV/rPND
 LZ3N1hghFwCpudmuOrDTF4eD1PCFp8mpriBiqojSJRcXdq97unwf27uUiAMTcNq1tCS+BAbHSk0
 lHmNDdETVQMUy3JWXak7CkS9BqxQR8TNOvFv2ysvfGdAZ4l9Qqia3K4Xa6DvDVxOnHarPKJ2TYo
 z/IOv+I6SPjrUWF5tG7UG/+VbfLjGk/3eaGbIDzNh6WmJw5Vw7sF48CKKSumHUUry8KQEPSSd92
 3kfgLrj2IqYboYxMVmZVM6frkdVbyebI4zg+Qd91
X-Google-Smtp-Source: AGHT+IHphhEoYNEHZNsQNGzb417B7zIpb8AsXZOJgPU/3NRY2FVMSxsv/56T6oRITVjo5wFVZsC4XQ==
X-Received: by 2002:a17:902:cec8:b0:216:69ca:7714 with SMTP id
 d9443c01a7336-220bbab3292mr159905015ad.11.1739498079866; 
 Thu, 13 Feb 2025 17:54:39 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d67fsm18831515ad.143.2025.02.13.17.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 17:54:39 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v4 0/4] Guestperf: miscellaneous refinement and enrichment
Date: Fri, 14 Feb 2025 09:53:32 +0800
Message-Id: <cover.1739497707.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Please review, thanks
Yong

v3:
1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by Daniel

v2:
1. Update the MAINTAINERS section suggested by Fabiano Rosas
2. Ensure the dependencies when build the initrd-stress.img suggested by Daniel
3. Fix some bugs

v1:
The previous patchset:
https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx.com/
does not made the necessary changes and tests for the upstream version.

This patchset works for that:
1. Move the guestperf to scripts directory suggested by Fabiano Rosas
2. Make initrd-stress.img built by default suggested by Fabiano Rosas
3. Make the necessary changes to adapt the latest multifd behavior
4. A nitpick for multifd migration
5. Support multifd compression option

Hyman Huang (4):
  guestperf: Support deferred migration for multifd
  guestperf: Nitpick the inconsistent parameters
  guestperf: Introduce multifd compression option
  guestperf: Add test result data into report

 .../migration-stress/guestperf/comparison.py  | 15 ++++++-
 tests/migration-stress/guestperf/engine.py    | 43 ++++++++++++++++---
 tests/migration-stress/guestperf/report.py    | 20 +++++++++
 tests/migration-stress/guestperf/scenario.py  |  7 ++-
 tests/migration-stress/guestperf/shell.py     |  3 ++
 5 files changed, 79 insertions(+), 9 deletions(-)

-- 
2.27.0


