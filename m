Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30DBC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kR5-0002Lq-0r; Thu, 10 Sep 2026 15:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQ5-0002F0-QI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:26:55 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kPP-0004cn-4D
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789068349; x=1789673149; i=deller@gmx.de;
 bh=yteRSq6bAtmx6S1tlzA8jfXoADGFrIcOO03+cDxnMiY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=YTfN17xwQJzXq1ajs9wMbddU4oDj51SdFZwqseT2iKMx4dMCfEGlhr8+voLgH7H4
 +s/zSITcYsiusFM6LZt2KsIecShoEm+lFP7IZujVwispZ2DS74JRO9BiaVySlanXb
 JeitjCL3wCY7CTz3lz5J7F2Y9VvuAHvoLf+QANdIha4sugRpdcMjQOm4rz+xIEdga
 XJRt2AFvX14gmXMR3hoBXHbX3RuX8GAieY2N/5i4psmqhWZuWbyLH2Io3Fz5CY7Yk
 2VAnomci6Rgrvn4jKEVfRXDCR5230SGmCxHQ278a3NWCpBH/cq98ALSD8O0wE59H7
 GZ7JnBfJ6vF2Fck3lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1x0wln2bmI-00H9je; Thu, 10
 Sep 2026 21:25:49 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 3/7] linux-user: madvise() on unmapped ranges should return
 ENOMEM
Date: Thu, 10 Sep 2026 21:25:40 +0200
Message-ID: <20260910192545.768850-4-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910192545.768850-1-deller@gmx.de>
References: <20260910192545.768850-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W1vRnlzHP9BbvFt4H3/UmSmAowRgs2W3s3SnhclGXZAE6GVXwME
 /gk27e8EJPM5FDVIciYG58rqtXLqgZKgryVyjXPdr0zHARmoRbuFAW7ZkOTTP85UAzLD2yK
 fz5TF9Ho8Ol/gar99cK3KoWbcoIeI5eEA5BCe9WqQNUCgzy97QcXWd0Q7DBf/wHGygm4sDk
 i4BgEKUU4KgF2CLKSJMaw==
UI-OutboundReport: notjunk:1;M01:P0:nDXGP+8A1OM=;CR5DoA2itjlQPAVhgIYwxgVRrcI
 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
 Vh1/
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Per madvise(2) and the Linux kernel implementation (madvise_walk_vmas),
madvise() must validate that the requested range is currently mapped
and return -ENOMEM if any page in the range is unmapped.

Add a page_check_range(start, len, PAGE_VALID) check for valid advice
values before proceeding with the advice actions. In addition, extend the
tcg multiarch test linux-madvise.c to test this behaviour.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4382
AI-used-for: importing and validating test case
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/mmap.c                         | 12 ++++++++++++
 tests/tcg/multiarch/linux/linux-madvise.c | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index cc0c2ee6c2..4066072ff4 100644
=2D-- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1307,6 +1307,16 @@ abi_long target_madvise(abi_ulong start, abi_ulong =
len_in, int advice)
      * though.
      */
     mmap_lock();
+
+    /*
+     * Whatever advice if the pages are not currently mapped, or are
+     * outside the address space of the process.
+     */
+    if (!page_check_range(start, len, PAGE_VALID)) {
+        ret =3D -TARGET_ENOMEM;
+        goto unlock;
+    }
+
     switch (advice) {
     case MADV_NORMAL:
     case MADV_RANDOM:
@@ -1358,6 +1368,8 @@ abi_long target_madvise(abi_ulong start, abi_ulong l=
en_in, int advice)
         ret =3D -EINVAL; /* not yet known advise */
         break;
     }
+
+ unlock:
     mmap_unlock();
=20
     return ret;
diff --git a/tests/tcg/multiarch/linux/linux-madvise.c b/tests/tcg/multiar=
ch/linux/linux-madvise.c
index 539fb3b772..ebb9666c91 100644
=2D-- a/tests/tcg/multiarch/linux/linux-madvise.c
+++ b/tests/tcg/multiarch/linux/linux-madvise.c
@@ -1,4 +1,5 @@
 #include <assert.h>
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/mman.h>
 #include <unistd.h>
@@ -63,10 +64,29 @@ static void test_file(void)
     assert(ret =3D=3D 0);
 }
=20
+static void test_unmapped(void)
+{
+    int pagesize =3D getpagesize();
+    void *page;
+    int ret;
+
+    page =3D mmap(NULL, pagesize, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE,=
 -1, 0);
+    assert(page !=3D MAP_FAILED);
+
+    ret =3D munmap(page, pagesize);
+    assert(ret =3D=3D 0);
+
+    errno =3D 0;
+    ret =3D madvise(page, pagesize, MADV_NORMAL);
+    assert(ret =3D=3D -1);
+    assert(errno =3D=3D ENOMEM);
+}
+
 int main(void)
 {
     test_anonymous();
     test_file();
+    test_unmapped();
=20
     return EXIT_SUCCESS;
 }
=2D-=20
2.55.0


