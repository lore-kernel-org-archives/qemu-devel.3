Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF881062897
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0JPo-0000ty-UH; Wed, 11 Mar 2026 09:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JPR-0000mp-By; Wed, 11 Mar 2026 09:15:33 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w0JPN-0000Mk-H5; Wed, 11 Mar 2026 09:15:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 15029C0209;
 Wed, 11 Mar 2026 16:15:27 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:d28::1:5])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MFGaO30AdeA0-5q90nciX; Wed, 11 Mar 2026 16:15:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773234926;
 bh=UA/R0WQkrgbt3pL8qQzjwpD0OPbLj/fizGAQeQVn4Gk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ecItJ24nPn4ugGBF2B7038+TGQbLwc/guKbqQRSge3zrAlwCwQ/9GRYkrtaBrjuTr
 5dTR0oupsNDsCVKbfF2QpdVUv6j6F0k2/JNLZGvCg4OtR73L3OD9VFdfBdH9wqhNtj
 hR6lWmZo7TcBko+iv7/4wSzcn3fnm1sDk8SoBlbg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 3/4] system/physmem.c: remove useless assertion of block
Date: Wed, 11 Mar 2026 18:15:21 +0500
Message-Id: <20260311131522.58600-4-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311131522.58600-1-heifetz@yandex-team.com>
References: <20260311131522.58600-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is useless to assert that block is not NULL because it is
already dereferenced in the first line of the function.

The assertion is also unnecessary because the function is called
in only two places, and `block` can't be NULL in either of them:
- In `migration/ram.c`, we have already dereferenced `block` in
  the code just before the call.
- In `system/memory.c`, we assert `mr->ram_block` before passing
  it to the function.

(We could split the declaration and initialization of oldsize,
but then we would need to remove the const qualifier. As the
assertion is useless anyway, removing the const qualifier seems
worse.)

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/physmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index b0311f45312..317b359ebe2 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2057,8 +2057,6 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
     const ram_addr_t oldsize = block->used_length;
     const ram_addr_t unaligned_size = newsize;
 
-    assert(block);
-
     newsize = TARGET_PAGE_ALIGN(newsize);
     newsize = REAL_HOST_PAGE_ALIGN(newsize);
 
-- 
2.34.1


