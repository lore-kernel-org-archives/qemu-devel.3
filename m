Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B92606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=IQFL7i+f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Ex-0006mt-VD; Mon, 16 Nov 2026 15:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ew-0006iw-Ig; Mon, 16 Nov 2026 15:23:46 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Eu-0004Hq-0q; Mon, 16 Nov 2026 15:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860377; bh=stW+cyUQxD1X3Wc/PxzVbC6NMwk8q1CUoCJzErXArb8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IQFL7i+fzCC2RTbJSQV2/FK4ganJG612MVyM1UqL+n1yKXCnuAn4zWoDXeHqSEQzQ
 MJgOJuu3g3rnjcMjoFRp+T6wx9QsrOA+EEXXTBHMOUf+o/yDwqPuW0ygQ49kdhiRNf
 Otz/u3fzoOTVmuxj1+3i8b73yUkkfB8DSN4m/sh8Y+/44q0NXflE8vI4AgtdHUWl16
 JkeQObYpVlyeUPAWc9e2cEH8b2PEpCZJFkltpnMFDU2vAFW6dKEBc4W1I3xm4M901+
 R1bm0vXZiNOWRrAoU50o0kYKhNrrYcnKLP+7qMqWMggb0QUHDqM47U7elLDe4JIn1Y
 7YANFOzGIZVBg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 975361E7169;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 93A0545FB9E;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 84DAAB8E2C; Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 47/59] iotests/common.rc: add disk_usage function
Date: Mon, 16 Nov 2026 23:18:51 +0300
Message-ID: <20261116201922.534306-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Move the definition from iotests/250 to common.rc.  This is used to
detect real disk usage of sparse files.  In particular, we want to use
it for checking subclusters-based discards.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-ID: <20240913163942.423050-6-andrey.drobyshev@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250509204341.3553601-27-eblake@redhat.com>
(cherry picked from commit be9bac072ede6e6aa27079f59efcf17b56bd7b26)
(Mjt: subsequent tests will use this function)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
index af48f83abac..c0a0dbc0ff1 100755
--- a/tests/qemu-iotests/250
+++ b/tests/qemu-iotests/250
@@ -52,11 +52,6 @@ _unsupported_imgopts data_file
 # bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which might succeed
 # anyway.
 
-disk_usage()
-{
-    du --block-size=1 $1 | awk '{print $1}'
-}
-
 size=2100M
 
 _make_test_img -o "cluster_size=1M,preallocation=metadata" $size
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 95c12577dd4..237f746af88 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -140,6 +140,12 @@ _optstr_add()
     fi
 }
 
+# report real disk usage for sparse files
+disk_usage()
+{
+    du --block-size=1 "$1" | awk '{print $1}'
+}
+
 # Set the variables to the empty string to turn Valgrind off
 # for specific processes, e.g.
 # $ VALGRIND_QEMU_IO= ./check -qcow2 -valgrind 015
-- 
2.47.3


