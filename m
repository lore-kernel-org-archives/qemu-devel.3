Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA56C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhroX-0006fP-Si; Fri, 01 Aug 2025 11:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1uhrFz-0008Tl-Px
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1uhrFq-0000QE-P6
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754060464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EaW4z6pH2A7AGWyyg4rFylZ1OvKeQrkAV0IRhaxTnnA=;
 b=KseXmxy4CdHQ6qfKG++jH4Xp5nYYau7aiJBQP/lqwVrUKKbl+Ov089fE5GQytZm0my62Nk
 eJrnQgsxyUKowiyvrWOixGIaCPhq0VVEDs+0EqI6zSbJ30lFMu+Nqv7+W2ARdGd6+8uT9N
 /i2mvUWDohdSVm8uiLZGR4zRPk6FCoQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-VKpg3hxSMsaUzNBwn1uT0A-1; Fri, 01 Aug 2025 10:59:54 -0400
X-MC-Unique: VKpg3hxSMsaUzNBwn1uT0A-1
X-Mimecast-MFC-AGG-ID: VKpg3hxSMsaUzNBwn1uT0A_1754060393
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4588fb6854cso9446885e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060393; x=1754665193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EaW4z6pH2A7AGWyyg4rFylZ1OvKeQrkAV0IRhaxTnnA=;
 b=oP1R1ZHPZaTUHYSWvkKaC1P52febKJ82HBPvWcbZ73IBLcHRseK+p+dnjmdeAHjbNM
 9qaZ2gxD+qHlqYYDL0Zyiu7+oxwi77CAas7UgsXpgYvRryGGKYPsjgH0G/7DJ4ifyvtv
 R7kgZ6HlMr7BnSk4FrA2CNJCgWPBag5pC6twlXRFEEUHTUw7LcZ1YNA8UpIjfx5TLJyt
 sN2CkAaUmasQYNq/8zZTPgpH9UnI47Y2iox8YkJec2Prr5O5I4lP0ZKdXtoLT8MRQGQ0
 q+bag21TcC0EVEfOWwq1cWlqSemdFldU8Du53hQ1rPA6L51O+nGrg5IKNdDYO4mKhxGA
 4C8A==
X-Gm-Message-State: AOJu0Ywh6sCGvxs0s4qRp+37/Jj8LtRXxGmGDXslkIaUQfu+R/4aBDhK
 VN1cjRS2L2aZWjR6LShGapODp7QvYrq2E7TvFCfILu52CBoqJAL+uiCPaHdEy/ncemBqtKfroV0
 Hb+p7gXghiUs3otuEczNdlxVuHJxTszixYQ2tptZf0u3+nCI5c/WN4RAo
X-Gm-Gg: ASbGncsyX2SRC5e/smI4jF67TW+YZ9dgllHrtKGd5E8w5PXw5b/UeptH59PQQiDlaML
 CKm6JB+b9JPlO5Tr25z4vrU0/AscZEu1vlTshnYifobWo3UtNDFNWeFDDea1189eP4iaZ2ij6Oz
 8Rygqh9s0Zv0u4DNyb2uDQmMxA52H3nb3VdIh8M0kVgYvhGHkpJ7mySVbBx9it968SJqsQK2ZmO
 IScMjRJS+WqL5wQn8ii4X/1rmDoqTEp1lIw42S1t5OrCOoL7Eni54Uq0wSyOEgQGChVpvA9h7L4
 MQHwzqOPHr10gDDsledBtT+hOKge6jbGYvTYMbTQMS1ICM+J
X-Received: by 2002:a05:600c:1d98:b0:456:18cf:66b5 with SMTP id
 5b1f17b1804b1-45892bc58a1mr101675975e9.22.1754060393301; 
 Fri, 01 Aug 2025 07:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHygTdJHRX475Z44aiMZeHmh5KPq5DtHm9GoL6A5CjlEt7nJUVodHY2Ks/w3FlyOeEWeNS+Q==
X-Received: by 2002:a05:600c:1d98:b0:456:18cf:66b5 with SMTP id
 5b1f17b1804b1-45892bc58a1mr101675645e9.22.1754060392844; 
 Fri, 01 Aug 2025 07:59:52 -0700 (PDT)
Received: from wheatley.localdomain ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953f887asm109225805e9.29.2025.08.01.07.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:59:52 -0700 (PDT)
Received: from wheatley.pinto-pinecone.ts.net (wheatley.k8r.cz [127.0.0.1])
 by wheatley.localdomain (Postfix) with ESMTP id 2E0A1C5A9A3E;
 Fri, 01 Aug 2025 16:59:51 +0200 (CEST)
From: Martin Kletzander <mkletzan@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 2/2] tests/qemu-iotests: Indent expected error messages
Date: Fri,  1 Aug 2025 16:59:50 +0200
Message-ID: <f5be6d407c105fa199d10867f5de48bbd25c008c.1754060086.git.mkletzan@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754060086.git.mkletzan@redhat.com>
References: <cover.1754060086.git.mkletzan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mkletzan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Martin Kletzander <mkletzan@redhat.com>

When running all tests the expected "killed" messages are indented
differently than the actual ones, by three more spaces.  Change it so
that the messages match and tests pass.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
---
 tests/qemu-iotests/039.out | 10 +++++-----
 tests/qemu-iotests/061.out |  4 ++--
 tests/qemu-iotests/137.out |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index e52484d4be1b..87809c534ba3 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -11,7 +11,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     [0]
 ERROR cluster 5 refcount=0 reference=1
 ERROR OFLAG_COPIED data cluster: l2_entry=8000000000050000 refcount=0
@@ -46,7 +46,7 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     [0]
 ERROR cluster 5 refcount=0 reference=1
 Rebuilding refcount structure
@@ -60,7 +60,7 @@ incompatible_features     []
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     []
 No errors were found on the image.
 
@@ -79,7 +79,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     [0]
 ERROR cluster 5 refcount=0 reference=1
 ERROR OFLAG_COPIED data cluster: l2_entry=8000000000050000 refcount=0
@@ -89,7 +89,7 @@ Data may be corrupted, or further writes to the image may corrupt it.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 incompatible_features     []
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 24c33add7ce6..ae4c0d37bbbe 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -118,7 +118,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 magic                     0x514649fb
 version                   3
 backing_file_offset       0x0
@@ -304,7 +304,7 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 magic                     0x514649fb
 version                   3
 backing_file_offset       0x0
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index 86377c80cde6..f3b12fbb04b0 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -35,7 +35,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-./common.rc: Killed                  ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+./common.rc: Killed                     ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
 OK: Dirty bit not set
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
-- 
2.50.1


