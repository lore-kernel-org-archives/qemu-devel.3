Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A498CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoQz-0006iB-Ul; Wed, 20 May 2026 17:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wPoQz-0006ht-0Y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:26:33 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wPoQx-0005YF-8d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=XoWZRsYYNHX8eSdwyaXQQ3dcEmwxLw7Jd/hWmTiLX2k=; b=Bsjb0q2Bv1ZA
 0At29JFNt/E7fy4ZtFTqZWWn50y5t3YTEl+F3YT6h/yZapjp9vmYbhnWMdpw1anYofJtHLjM+qma9
 zPjqEzR0cQZEq7ZgZ1/w4V5nE5ws68spoD/oW9KFlupH9lQknGMu/0dRaiwG8UIfvGWNanNGjaxq8
 +Nz/oAJDVv72VPm44rKio7pPFbHziVgFTtnmGJTLEvzIo8d5AGHXGc+cJxSeEfGBp+1/ks0zpPvPG
 IOoGlbNxGF7gVU8XOaUEJCmgRVlQcMf0grzTmCrf7x0S7qLNGlCshYRhSi3G2MmRasV2TK010eCw1
 ggjgEYBNsFCCuZR/oPk7Vw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8]
 helo=iris.astra-academy.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wPoNZ-003Cdo-2z;
 Wed, 20 May 2026 23:26:27 +0200
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] util/envlist: fix prefix-match in name lookup
Date: Wed, 20 May 2026 23:26:26 +0200
Message-ID: <20260520212628.479772-1-den@openvz.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A bug report against our downstream tree turned out to have its root
cause in plain mainstream code: envlist_unsetenv() does a prefix-match
lookup that drops the wrong entry when one stored name happens to be a
prefix of another. The downstream symptom is specific to our setup and
isn't interesting here -- the underlying lookup mistake is the part
worth fixing, and it is reachable from a normal qemu-user invocation
through the -U command-line option, so the fix belongs upstream.

Patch 1 fixes the lookup: each entry now stores its name length at
insertion time, and a tiny helper compares with explicit length
equality plus memcmp. envlist_setenv()'s self-search was accidentally
safe (it included the '=' byte in its strncmp window and that '='
served as a boundary) but is converted to the same helper so the name
boundary becomes a structural property of the entry rather than a
property of its byte layout. Without that, the two sites can easily
drift apart again.

Patch 2 backfils test coverage for util/envlist -- there was none --
in tests/unit/test-envlist. I verified that the regression case
(envlist_unsetenv("FOO") vs. a stored "FOOBAR=...") fails against the
pre-fix code and passes after the fix.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Denis V. Lunev (2):
  util/envlist: fix prefix-match in envlist_unsetenv() name lookup
  tests/unit: add test-envlist covering setenv/unsetenv name matching

 tests/unit/meson.build    |   1 +
 tests/unit/test-envlist.c | 196 ++++++++++++++++++++++++++++++++++++++
 util/envlist.c            |  19 +++-
 3 files changed, 212 insertions(+), 4 deletions(-)
 create mode 100644 tests/unit/test-envlist.c

-- 
2.51.0

