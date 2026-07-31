Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3C3C55172
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 22:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpvHe-00065Q-Td; Fri, 31 Jul 2026 18:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpvHb-00063c-Ed
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 18:00:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpvHY-0007SQ-W9
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 18:00:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so904940f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785535243; x=1786140043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uSiA6NHPpgPJGQnSafEN4vWcEnf8GiGHd436OL4FkHs=;
 b=N6f2YmUDfqrhQS1eOvmsIfKt+ne2dUPUemamY22gedF0hRgAd7bbKLjgeeJLBF8Vyd
 8+OYYk7F+gEjOLM+Ee+wcUvucVz8zUYiR61v6iQwI+h8DUTLLbFl1HBBoZa0szgn31vp
 3fN8zElFsTSd54h5DJ5GWVmOsiohbq4AqYT/oAPeCexhoFOvGYyRz8sM4cfrxmeaCloQ
 6Nfa0/fhNoyzzBOLeJGwSxMSF5psqNQpmwtXHmZwoTjVoKh3MdcED4ZdCiqWBpFqzSLy
 3DLOrQWe5kVBx/i9FEYb6IYgkf+WlE1oJvUmL1j6InKgnrcLxCqTQ79Kz61clVZXTI1Y
 F8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785535243; x=1786140043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uSiA6NHPpgPJGQnSafEN4vWcEnf8GiGHd436OL4FkHs=;
 b=ctttptrr/4r6z/n+vykCBW+MxAEb7Pf6R0ek1Z4pFNTmUb2TBJTL0bv7XuoRDvbbQ/
 ckFuYY7PoF7z93JE+/Iys6lZfSuOOyozNjTykvrLrUluxLMNV4cPRsIjO/mjDLYsLHS/
 0hLtxlEDlwblY+ZezrYUwCUdJO0UUVix5CPVQ76Rrqvyvc/GEOb4cGRLSIqtXld+5fZd
 g2ezSa8wl718Q36BXjfPKlXah/cfsN9joYf2OizsftgySVsYQk96e+y88mEUp4pwijDV
 b5RHXeSVqnKj+RGW9VKvx3djx0yWL+/9oWVcSPawtIe8kTIli4r0HRlwVjTgqz8KUOpO
 BwBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxUfx6YrkfHa/ztWYS6ie2S3b0DbP6Z952fPeHZ2uX89ApUpG1GJWsaj9PVguDcuYz3wHFYLUX1qgD@nongnu.org
X-Gm-Message-State: AOJu0YzG1pcfEGXrUSssbiOBHuVojDAOW8meoTaDPv1J9j3eeCidvqop
 FHZrxZanKLPeNYMdBz7wk9RcwE64MGGodZPQ5pDe8Yq9koI0PiD/BZe/bmUY+Pv2xx4=
X-Gm-Gg: AR+sD10ykzR/JNQsYWbi9iHBXHUHU37ySBJ4EgYrCZaPp0m5nNSWdqb7rZvoknWQKfq
 TWguCMdSmJqX/Av+vg6WEgtciZNirQOEXThedZktctBIBSqBmUL51ZF0GzvHoxR6qoasz/5JJnc
 n2a9/2pMvlv8atc4aau4UpkMo3ofbwRnIoFyqEpaZn1alQli49iYJqZzi6RYY9ryMKtHp4oDwSL
 HmVJXAx3Zd2VtlAWM3Fz0fl+9x7Fr1QvRk1iAuD3lofav2yH/CIX+D+k+CKYP6mak3jO6bqVVa0
 Jc91XK9c1TTeo2c2cdfOT7KILmnPTcUmGRDy4Xfiidu4WuKT1QSskmFsRFSjNwUbirkEOZ24ifx
 +vWsMbNTybdwgI0UUjcsiRMFjImvOd4PCKaoTFW7XFUaZ/prhMVq36H3mz+f/oizY+uvzLrgsPp
 99DyYDPIK5Co71P6FSn7cWY7iXyUwQNoRuXB2hUzixvRRDZaa2LNWOWQ3dJ1QAwmGx630=
X-Received: by 2002:adf:eac3:0:b0:47d:dfc6:b28b with SMTP id
 ffacd0b85a97d-47fd72e1887mr2042510f8f.30.1785535243383; 
 Fri, 31 Jul 2026 15:00:43 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1758:fc6:a5f8:a15f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2cf1sm9711152f8f.10.2026.07.31.15.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 15:00:43 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-stable@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/2] qcow2: do not clear the dirty bit when reopening a
 read-only node
Date: Sat,  1 Aug 2026 00:00:38 +0200
Message-ID: <20260731220039.1765584-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731220039.1765584-1-den@openvz.org>
References: <20260731220039.1765584-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qcow2_reopen_prepare() clears the dirty bit whenever the node is
reopened read-only, with an unguarded header write. A read-only node
can still be dirty, inherited from an earlier writable session, and it
holds no BLK_PERM_WRITE to resolve that. A read-only to read-only
reopen of a dirty image therefore fails outright:

  $ qemu-io -r -f qcow2 dirty.qcow2 <<< $'reopen -r\nquit'
  qemu-io: failed while preparing to reopen image 'dirty.qcow2'

Clear it only for a node that is writable now, the predicate
qcow2_do_open() already uses for the repair. bdrv_is_writable() also
excludes an inactive node, whose header must not be touched either.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/qcow2.c              |  8 +++++---
 tests/qemu-iotests/039     | 11 +++++++++++
 tests/qemu-iotests/039.out |  5 +++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7292dd036c..1543255eba 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2102,9 +2102,11 @@ qcow2_reopen_prepare(BDRVReopenState *state,BlockReopenQueue *queue,
             goto fail;
         }
 
-        ret = qcow2_mark_clean(state->bs);
-        if (ret < 0) {
-            goto fail;
+        if (bdrv_is_writable(state->bs)) {
+            ret = qcow2_mark_clean(state->bs);
+            if (ret < 0) {
+                goto fail;
+            }
         }
     }
 
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 94a8bfe754..a5be81bc4a 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -95,6 +95,17 @@ $QEMU_IMG info --image-opts \
 # The dirty bit must still be set: this open never wrote any guest data
 _qcow2_dump_header | grep incompatible_features
 
+echo
+echo "== Read-only reopen must not clear the dirty bit =="
+
+# Reopening a read-only node must not try to write the QCOW2 header either,
+# and must leave the dirty bit for whoever ends up repairing the image.
+$QEMU_IO -r -c "reopen -r" -c "read -P 0x5a 0 512" "$TEST_IMG" \
+    | _filter_qemu_io
+
+# The dirty bit must still be set
+_qcow2_dump_header | grep incompatible_features
+
 echo
 echo "== Repairing the image file must succeed =="
 
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index c66361128f..3c71e5a3dd 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -27,6 +27,11 @@ incompatible_features     [0]
 == Read-only open must not crash on close ==
 incompatible_features     [0]
 
+== Read-only reopen must not clear the dirty bit ==
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+incompatible_features     [0]
+
 == Repairing the image file must succeed ==
 ERROR cluster 5 refcount=0 reference=1
 Rebuilding refcount structure
-- 
2.53.0


