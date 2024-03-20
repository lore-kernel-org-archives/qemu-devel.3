Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A57AC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmydA-0007we-9W; Wed, 20 Mar 2024 12:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmycc-0007TF-IY
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:16:59 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmyca-0003so-GJ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
 :From; bh=Ybawgp3HB/lt6ntluJk4fefmKWRuTfu4uftbmnHrdyw=; b=pfT9rU6c04JSKfkQELd
 JqroWpxH/dIggoPUiQnCYke9NmK1oaxwzcdDNIJmcwNwTrfodK6hRLbDxC75xNRbg14VYfvQ+jdCO
 YMEUOhDLICysXXkEwJc5CM3H+Ap8CA1CzvGbNKJtR5HxpzS3NqkilQKDpdIJ7d45i7RjSn1WQcoPw
 NM+d30izrBk9HL2ZacAR42k6/oAZfkGW90oEVZy16gDAnPVhhnSuFfht9W0BJvPtZN9XeMVnEdMI0
 PGZ6EHc1AXZlb7wAr6jgDaUt1jEqs/aYoa1GOxA7TH2eJHcHztFQ4U648MxWbUCswN1ymfYN/1Aqn
 OgNNh/Ca7aWqGTw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rmyaM-006TNN-1M;
 Wed, 20 Mar 2024 17:16:37 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v4 0/7] qga/commands-posix: replace code duplicating commands
 with a helper
Date: Wed, 20 Mar 2024 18:16:41 +0200
Message-Id: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v3 -> v4:
  * Patch 1/7:
    - Replaced "since 8.3" with "since 9.0" as we're now at v9.0.0-rc0;
    - Renamed the field to 'total-bytes-privileged';
    - Got rid of the implementation details in the docs;
  * Patch 6/7: added g_autoptr macro to local error declaration.

v3: https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg04068.html

Andrey Drobyshev (7):
  qga: guest-get-fsinfo: add optional 'total-bytes-privileged' field
  qga: introduce ga_run_command() helper for guest cmd execution
  qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper
  qga/commands-posix: qmp_guest_set_time: use ga_run_command helper
  qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper
  qga/commands-posix: don't do fork()/exec() when suspending via sysfs
  qga/commands-posix: qmp_guest_set_user_password: use ga_run_command
    helper

 qga/commands-posix.c | 404 +++++++++++++++++++------------------------
 qga/commands-win32.c |   1 +
 qga/qapi-schema.json |   7 +-
 3 files changed, 187 insertions(+), 225 deletions(-)

-- 
2.39.3


