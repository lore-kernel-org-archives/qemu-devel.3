Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD58C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeHk-0005WB-Pb; Mon, 26 Feb 2024 11:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHb-0005Vp-Vg
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:56:51 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHW-0007aN-Vz
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=qGzozfvyrFyaHAFm0qp6cbQu5Ext7ilnNDT8CZ5WezQ=; b=ZZfjv56mJvQc
 imRkKvmWF5vfw70NRG9UA8h/86hxqxurpeDA12gbJz/Hhev63qK4W1zEY5hqNmE/NCyftTuRmUWy2
 UUpOv2xqbelEJI1RnSm5oes/7F1gVqp7eEYc+NC5kKFNIGTOfNdk1v6svLHvh5PjLQEwyNhgbAf+C
 /fvxW+ccBIy0EdjwR3X1hESeUw2NklHjHeMmrr4WyVA89QyeEUNHcW0JrYl4r20L218hOho0xmj8s
 r+2Hv6uZfexDuPheXSCyYjJl24tQj3yOvTHg14p3YeDcu78h37hAqujDAxmHideOL41qCpBiOGuCi
 f3gLjn4bfA8codrr5knr7g==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1reeG2-001AD7-35;
 Mon, 26 Feb 2024 17:56:34 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, marcandre.lureau@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 0/7] qga/commands-posix: replace code duplicating commands
 with a helper
Date: Mon, 26 Feb 2024 18:56:35 +0200
Message-Id: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This series simply replaces repeating fork()/exec() pattern with a
separate helper to avoid code duplication.  It's easier to setup and use
than g_spawn_async_with_pipes() (which we'd need since some commands require
input).  While here, also make qmp_guest_get_fsinfo return more
straightforward values.

Andrey Drobyshev (7):
  qga/commands-posix: return fsinfo values directly as reported by
    statvfs
  qga: introduce ga_run_command() helper for guest cmd execution
  qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper
  qga/commands-posix: qmp_guest_set_time: use ga_run_command helper
  qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper
  qga/commands-posix: use ga_run_command helper when suspending via
    sysfs
  qga/commands-posix: qmp_guest_set_user_password: use ga_run_command
    helper

 qga/commands-posix.c | 402 +++++++++++++++++++------------------------
 qga/qapi-schema.json |  11 +-
 2 files changed, 181 insertions(+), 232 deletions(-)

-- 
2.39.3


