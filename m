Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06776EF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 06:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voxqU-0000w2-1R; Sun, 08 Feb 2026 01:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1voxpn-0000Rg-Vm; Sun, 08 Feb 2026 00:59:56 -0500
Received: from mail-4317.protonmail.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1voxpm-0007Vp-Lz; Sun, 08 Feb 2026 00:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail3; t=1770530388; x=1770789588;
 bh=LHZqZzgOwh2kAijmgY5Qb41C5r1zRUYNLCfwaw141aI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=maZXDzAnLsLdQPlD/DN6tffhX2a/AKkTZddvOlEEqjpGBEwmOgprkKf5nm4oiPY8O
 TauUqV5jYS4KsFP6y9dl5VxGB65SjbjW/ZyKwBM3mIB88py9Vq2R8XKH4YzuGFUq72
 wdTCSapd2Nw2uP3+LyzyDZ2XWwIwhKpVUzqHD5yzWiO3gaqHUl4JdrAWUsdb29KrDy
 hOaVRzOMAY3gdjdju4v704E5ygwglMTh+96kL43IKsS8IJyPCaT/roUwIcqMlwCed/
 fsnQ6CZiLWlfDverXCNjI829CPooJ6Tl/lf+WxaoanmHfHkRccV7mmyq51yFQn7Bm0
 7JWRkct6f6QEg==
Date: Sun, 08 Feb 2026 05:59:45 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v5 5/5 qemu] Make copy_file_range non-static on GNU/Hurd
Message-ID: <20260208055858.2166524-6-damien@zamaudio.com>
In-Reply-To: <20260208055858.2166524-1-damien@zamaudio.com>
References: <20260208055858.2166524-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: bb873a593fddc65868e1436febfb423f5d5dcad0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=damien@zamaudio.com;
 helo=mail-4317.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

glibc has a stubs mechanism: a function can be declared in the
system headers, but only implemented as a stub that always fails with
ENOSYS, for example.  Therefore when implementing this function
we cannot use static.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8a3ba5eecb..b9a7786827 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2106,7 +2106,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaq=
ue)
 }
=20
 #ifndef HAVE_COPY_FILE_RANGE
-#ifndef EMSCRIPTEN
+#if !defined(EMSCRIPTEN) && !defined(__GNU__)
 static
 #endif
 ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
--=20
2.51.0



