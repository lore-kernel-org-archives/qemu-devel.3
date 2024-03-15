Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009D7C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6hi-0002e6-Oq; Fri, 15 Mar 2024 08:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6hF-0002EI-Od
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:30:02 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6h8-0006OS-OB
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
 :From; bh=j3D0KGA2LQ22vETxw3YoM8fyI2Xn/dRZxp+2hAueLew=; b=oc532/Lg6YaZLdyRRzd
 3TnIbyroSifcwEO8cJs/FK+JWRDIDm6Ry+xHpmz7Tt8B2UnE/YIY4ci53Pk84NtyH3d7i2ZnfBRvQ
 8xcro3Tdf9zQ5gM1j9EBbQWueZbAwqcP70D2wwruc68/zcOIdsYfvOfdlczkSVkUfJO/iwfdGdPWp
 PKpP5skWTAjj70JWzJae4v7M3yxp8BHGflWTN+vECD85Pm9io+ZUkrIMKEUoyhAB5N8SVLgjyhJ4d
 h3txkS1uAUgOeQNaYc2nQ/i/TSODu5XlXUmY4LcAqoCCD2XveAZ0HNm4DL2B0AM+Qi0X73QgbW9oe
 SaaQAYo8OkyPB7Q==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rl6f4-005Caf-2z;
 Fri, 15 Mar 2024 13:29:46 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 0/7] qga/commands-posix: replace code duplicating commands
 with a helper
Date: Fri, 15 Mar 2024 14:29:39 +0200
Message-Id: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
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

v2 -> v3:
  * Patch 2/7:
    - ga_pipe_read_str() helper now returns -errno in case of an error
      during read from pipe, so that the caller may use it to set
      error_setg_errno();
    - ga_pipe_read_str() allocates +1 additional byte to make the
      string read from pipe null-terminated on every iteration;
  * Patch 6/7: patch is rewritten to completely get rid of fork()/exec()
    when suspending via sysfs, it now simply uses g_file_set_contents()
    (suggested by Daniel);
  * Patch 7/7: cosmetic change: removed unneeded brackets in an
    expression.

v2: https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg00147.html

Andrey Drobyshev (7):
  qga: guest-get-fsinfo: add optional 'total-bytes-root' field
  qga: introduce ga_run_command() helper for guest cmd execution
  qga/commands-posix: qmp_guest_shutdown: use ga_run_command helper
  qga/commands-posix: qmp_guest_set_time: use ga_run_command helper
  qga/commands-posix: execute_fsfreeze_hook: use ga_run_command helper
  qga/commands-posix: don't do fork()/exec() when suspending via sysfs
  qga/commands-posix: qmp_guest_set_user_password: use ga_run_command
    helper

 qga/commands-posix.c | 404 +++++++++++++++++++------------------------
 qga/commands-win32.c |   1 +
 qga/qapi-schema.json |  12 +-
 3 files changed, 193 insertions(+), 224 deletions(-)

-- 
2.39.3


