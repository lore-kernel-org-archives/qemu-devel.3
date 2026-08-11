Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736CFC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtocf-0007w2-E3; Tue, 11 Aug 2026 11:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtocd-0007uP-LG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:35 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtocN-00048A-6R
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:35 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a063d211ebso4226408a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786462938; x=1787067738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xdgqlKtTotTQsDwD3eVNqnrjorchCaz1rInhMcHrFds=;
 b=gde3Uv1Ix7FPu54YnMz/e4fmtl/PmZ/vm1w1Id+bVrSYigXx19xPaIKxEabpLHVGHg
 yj0JRMB6cPudTHGPyXOCYaT+53GWmyS/1KEm/f64W56EBOTh1DwC9Ff16QwOjy6VWZEp
 JGkz2+FiIuWQ3iQYTlXoq3QidaJYdG6qnGpZR2S5TFeXnZxLgp1MSZ+5h+9aBg/SfIAK
 512DqXXvrZojAe0WPrWmv+6PCDrgMQTP6vCQAOapmPz2lcvSO8jpWXc+1plNN478MAN3
 CL/8I8YPD9OiRZXT9s0gHlrHkTaXKT+lK+HOlZ+8Hmyg0zRLwp7i6E2ktTIGnuFwpGfO
 Q9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786462938; x=1787067738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xdgqlKtTotTQsDwD3eVNqnrjorchCaz1rInhMcHrFds=;
 b=ZdXqH10AapYT/lriUe8oN9u3DaSLaEgUhWrvDVgjsEAYa3XAD9XQC7fPm9R9CZ9RQc
 273z+hQP8beWmUxuYxPYFhKziwK+SLg+tkL5kurVJHbKlJXvyICw5n7lKHCUAeN50tQZ
 f29P9qtVuZF83cINYZqqYiSNBhfogRSVf0ggPXXiWf0FwMZnFt7PmR6dKP71kOdbGFNh
 5/gh5OzjLjHHjHxpI7k0AgLr0Lph1cnm5F7mlfq9MySbOJ3DdCcfsN6EosLCxK3x+cV4
 sUzj6NHvtAR+aYxraO/tAOptgJ6RlK7MgthzPpDd4KdxbLDKjrNHQ8ratMlxTIw1vBXL
 g3Bw==
X-Gm-Message-State: AOJu0YzGYQkKqgQsko6x5+SeD08iFILCPxmyJtETXAWFgms4N4KzvJJ1
 l1p25Mb52cYHHrinXDDE/KfQmseO9o+adPYBF/HGYtbok5tsoTeg91BBIPX27ISZpTP4udgWj3V
 1/51w
X-Gm-Gg: AR+sD10/dpa08Xyx0U6FqLDdVArmofLo5H2/AR2vP2h5Lc9an6O22A/JV6io1DxomgA
 fdHlbZfV/J3ND1EPs1IHjQkaA+G4lXq56I8i7U4erWf75aWyyq++gMsVBGE0ea9dpVFolx37NDs
 foDqcH3jAHMod+JwEaIWabZTyIHqShrv+0gueJByRvwpgwgku+S5HXfgIzCYvDHaqH3oC9wJvZF
 WGVTfJRIfO4MPUn4LUZEA4jLurTlUA8dZHfjTryCsnkopJO27K+n1zGKguG39GPK3vjp1yftODW
 KuttmkbYEQVoCoJVwYYhdNIwRKHRY8NY7+j5mgcehE3yEYYjHPuy1aS6mfHUf81fDP8x0auazpD
 /EvT++eJk/2WlodYzQSbiWC8cawvva5oYfJgJAmENILNtAj1fEOa5kgW/xjftnzEY1d2JAK3xK+
 rDTcT1JUCWr74og6IXtVkhCYM8wvQJG1+CFBBgrwFOZOUMEo4q57kq1qb7
X-Received: by 2002:a17:906:7953:b0:c12:67d2:3d6b with SMTP id
 a640c23a62f3a-c20e616f45amr199720266b.11.1786462937637; 
 Tue, 11 Aug 2026 08:42:17 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362e34d4bsm841128a12.12.2026.08.11.08.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:42:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 1/4] qcow2: do not clear the dirty bit when reopening a
 read-only node
Date: Tue, 11 Aug 2026 17:42:10 +0200
Message-ID: <20260811154213.184947-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154213.184947-1-den@openvz.org>
References: <20260811154213.184947-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=den@openvz.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
---
 block/qcow2.c              |  8 +++++---
 tests/qemu-iotests/039     | 10 ++++++++++
 tests/qemu-iotests/039.out |  5 +++++
 3 files changed, 20 insertions(+), 3 deletions(-)

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
index 94a8bfe754..db52c580d1 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -95,6 +95,16 @@ $QEMU_IMG info --image-opts \
 # The dirty bit must still be set: this open never wrote any guest data
 _qcow2_dump_header | grep incompatible_features
 
+echo
+echo "== Read-only reopen must not clear the dirty bit =="
+
+# A read-only node cannot write the header, and must keep the dirty bit
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


