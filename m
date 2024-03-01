Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D487C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6h5-0003p5-TE; Fri, 01 Mar 2024 12:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6h3-0003nX-3O
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:29:09 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6gx-0005cz-Va
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=f5fHI1WZm9P8rsavhEHcpNgTmkQ137E2qketcbg3xBs=; b=c0Qr4KqKsBCz
 OnJVA6jbMdm9VNadpKV/jXShN4ShY3jau/U3skZPqr+jT7lGwWIFDfvk5fbrybvittHZqngXFbjvQ
 iF0WvTAd7RY2DcrRUruBGMfWirc3BTmEig2ANwJdleGJJvyYbGWtAkQICcoZehypmBz+izup5Difp
 rIcMOMEq7dPid31J8apcQhrobnDkyH45mtdjOdaxohIS1lVxbbKtGsuA91Bil5WC5XeyGGtq/1Hb2
 mU8AtYoRNRwB5LQMuOCtMejWhENyo5cYLw+C4uysogOcSL+o10mFs5uQPdGFUtnko81VqxZNbizol
 Y040cWn8YmRl7ZK9m+25YQ==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rg6fM-0022sZ-0Q;
 Fri, 01 Mar 2024 18:28:56 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 0/7] qga/commands-posix: replace code duplicating commands
 with a helper
Date: Fri,  1 Mar 2024 19:28:51 +0200
Message-Id: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
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

v1 --> v2:
 * Replace commit for guest-get-fsinfo: instead of reporting statvfs(3)
   values directly, keep the old ones but add an additional optional
   field 'total-bytes-root', only reported in POSIX.  Also tweak the
   fields description in qga/qapi-schema.json to document where the
   values come from.

v1: https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg05766.html

Andrey Drobyshev (7):
  qga: guest-get-fsinfo: add optional 'total-bytes-root' field
  qga: introduce ga_run_command() helper for guest cmd execution
  qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper
  qga/commands-posix: qmp_guest_set_time: use ga_run_command helper
  qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper
  qga/commands-posix: use ga_run_command helper when suspending via
    sysfs
  qga/commands-posix: qmp_guest_set_user_password: use ga_run_command
    helper

 qga/commands-posix.c | 389 +++++++++++++++++++------------------------
 qga/commands-win32.c |   1 +
 qga/qapi-schema.json |  12 +-
 3 files changed, 182 insertions(+), 220 deletions(-)

-- 
2.39.3


