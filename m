Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60367C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKvMf-0005BQ-B6; Fri, 30 May 2025 04:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMb-00057T-36
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uKvMX-0000sX-Pp
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748594712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9H+auuRyXtdUGXXh+5pwrUEG4tf8Si41EBllzDy1U8=;
 b=IJKU0GIAEUVrRejdOC6SA+vZ6rlFDF6haeLt6KsVMHkyeG3nehwn+wRhLLaLVOt/5KfyYO
 iwEyyZj2e2qLwrjKj62HTbdAEpfYDP5zSlXEJF7cnE3nqx2QVfga/v1z3V5j+RXcGDgtbo
 LrDoGbh7bStGMyBAIw1pf4BNq/A2UXk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-q2nE-Zp5OVuRz_2RNwdrpA-1; Fri, 30 May 2025 04:45:11 -0400
X-MC-Unique: q2nE-Zp5OVuRz_2RNwdrpA-1
X-Mimecast-MFC-AGG-ID: q2nE-Zp5OVuRz_2RNwdrpA_1748594710
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so429864f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748594710; x=1749199510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m9H+auuRyXtdUGXXh+5pwrUEG4tf8Si41EBllzDy1U8=;
 b=ZptemVPVyRWQvBr281qudTvtv5JAZEsvVxcqs7kJ2LJFZ86KRMT+SjwFVo4y5JM1Rj
 OBcLptoa8As5bkd/aiT5RWEmxCnbr8zfzFWCU7YLVDU/5eb1WGs4jkeoTa1BecF+EQIR
 iCswtJuMIQUuU7862/BT0Xz/uBg07UWI0kL/3oQcW9E9cEKAyEh/H1g51mNKRNfo+EEU
 PQlHWu8EAqlav9HQ4Ja+Y9/YrsaJwcJiUocH0Y4RFVE7WWdkqpjj2I3uBkO11TEuDS3+
 MZ9ytOKU6zDuPzB9e1asEitsq4POjBEiEDglRhEffZqA4G+vxtLO1MxF9n4qXnL2L4Us
 1bDw==
X-Gm-Message-State: AOJu0YzV3QPXl5HpbBOs9czCS4TKw1c25ZmhJ3gAsysIVYIVCyD60lIF
 nZwa0vHehBIEncXFH3eTkuCndMMDwi455RPETNnl3ewY2YPrN5PDtyKqmmp2Mn1LB+ulbV0AE0C
 rhKlSpGYpovXSJU5XBA/FAhk1tRjI7E2/1qjTCGDhclyEuV4JiKhgrUI9
X-Gm-Gg: ASbGncuKaBcnTly8cMxzzcTQXTg5pSCTENJBSrI3Kcm//MXxWMGySZJIOpz9/ehGKaY
 4DkTTQ5zw5O0cOkQSfEbyj7ujtZOs6RTguGrsAhf79aIxmtZDcK6Dy8qCP2plx9sIaulnAC1+09
 kQDKWRp4qXKFH1S2gbIZCD9umhIscwz/F8S2ztQVW0Cbl9pUIHNbAfNY8DiqwzhagpkLeX8DTZ7
 EMNcnNrznrt+gIyq5sChkSDgfd92EpNs2b+c+VfQw+v4IE6DA8yoqcfJAqVwn1xJ+EFqc/2je+9
 oFNbJ9JtHG4tR46snnWoEO4jje6P3FMQN1sOJKKZLxIrnjEJSO65XlLQo/DO0TrN1u320w==
X-Received: by 2002:a05:6000:2505:b0:3a4:cfbf:5199 with SMTP id
 ffacd0b85a97d-3a4f7a3c0ecmr1773513f8f.9.1748594710236; 
 Fri, 30 May 2025 01:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExVQi7zB78K2k9X0cH/WwccVl81a4DbZSF7w7dqdd6W4bNFSQDB42rYnGf04jLZuMU8DLczw==
X-Received: by 2002:a05:6000:2505:b0:3a4:cfbf:5199 with SMTP id
 ffacd0b85a97d-3a4f7a3c0ecmr1773486f8f.9.1748594709824; 
 Fri, 30 May 2025 01:45:09 -0700 (PDT)
Received: from localhost
 (p200300cfd700f320acd9b9a35df3ddfd.dip0.t-ipconnect.de.
 [2003:cf:d700:f320:acd9:b9a3:5df3:ddfd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c7adsm4144688f8f.26.2025.05.30.01.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:45:06 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 4/4] iotests/244: Add test cases for keep_data_file
Date: Fri, 30 May 2025 10:44:47 +0200
Message-ID: <20250530084448.192369-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530084448.192369-1-hreitz@redhat.com>
References: <20250530084448.192369-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add various test cases around keep_data_file to the existing data_file
test suite 244.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/244     | 71 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/244.out | 53 ++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index bb9cc6512f..ec81df8d6a 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -384,6 +384,77 @@ $QEMU_IMG compare --image-opts \
     "driver=raw,file.filename=$TEST_IMG.data"  \
     "file.filename=$TEST_IMG,backing.file.filename=$TEST_IMG.base"
 
+echo
+echo '=== keep_data_file tests ==='
+
+echo
+echo '--- Creating test data file ---'
+
+# Easiest way to create the raw data file without having to create and
+# access it manually
+_make_test_img -o "data_file=$TEST_IMG.data,data_file_raw=on" 1M
+# Values chosen by a fair random.org evaluation
+$QEMU_IO -c 'write -P 3 0 512k' -c 'write -P 96 512k 512k' "$TEST_IMG" |
+    _filter_qemu_io
+
+echo
+echo '--- Testing stand-alone option ---'
+
+# Cannot work, needs data file
+_make_test_img -o "keep_data_file=on" 1M
+
+# Invalid option value
+_make_test_img -o "keep_data_file=true" 1M
+
+# Should be the same as omitting
+_make_test_img -o "keep_data_file=off" 1M
+
+# No preallocation is OK when also specifying data_file_raw; otherwise, none of
+# the data file will be mapped, i.e. its contents will stay hidden, so
+# requesting its contents to be kept (but hidden) doesn't make much sense.
+#
+# Metadata preallocation is OK: It will not overwrite the data file's contents,
+# but ensure the contents are mapped and visible.
+#
+# Any data preallocation (like falloc) is not OK, as this would overwrite the
+# data file's contents despite keep_data_file requesting they should not be
+# overwritten.
+#
+# Note that all of these cases use the data file created above: This verifies
+# that when passing keep_data_file=on, the data file is always kept as-is (and
+# e.g. not deleted on error).
+for prealloc in off metadata falloc; do
+    # Without metadata preallocation, the data_file_raw flag is required so that
+    # the data file's contents are visible.
+    for data_file_raw in off on; do
+        echo
+        echo "--- Testing prealloc=$prealloc data_file_raw=$data_file_raw ---"
+
+        # Remove previously existing qcow2 (metadata) file
+        _cleanup_test_img
+
+        opts="data_file=$TEST_IMG.data,keep_data_file=on"
+        opts+=",preallocation=$prealloc"
+        opts+=",data_file_raw=$data_file_raw"
+
+        _make_test_img -o "$opts" 1M
+        if [ -f "$TEST_IMG" ]; then
+            $QEMU_IO -c 'read -P 3 0 512k' -c 'read -P 96 512k 512k' "$TEST_IMG" |
+                _filter_qemu_io
+        fi
+    done
+done
+
+echo
+echo '--- Testing non-existent data file ---'
+
+# Maybe a matter of taste whether this should fail or create the file, but
+# failing is simpler (= will always skip create) and seems safer (users may
+# expect the file to exist, and the error will warn them when it does not).
+_make_test_img \
+    -o "data_file=$TEST_IMG.doesnotexist,keep_data_file=on,data_file_raw=on" \
+    1M
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index f46cfe93f1..9fbfa82cd9 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -197,4 +197,57 @@ wrote 1048576/1048576 bytes at offset 0
 
 Comparing qcow2 image and raw data file:
 Images are identical.
+
+=== keep_data_file tests ===
+
+--- Creating test data file ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=on
+wrote 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- Testing stand-alone option ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 keep_data_file=on
+qemu-img: TEST_DIR/t.IMGFMT: Must not use 'keep_data_file=on' without 'data_file'
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 keep_data_file=true
+qemu-img: TEST_DIR/t.IMGFMT: Invalid value 'true' for 'keep_data_file': Must be 'on' or 'off'
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 keep_data_file=off
+
+--- Testing prealloc=off data_file_raw=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=off keep_data_file=on preallocation=off
+qemu-img: TEST_DIR/t.IMGFMT: 'keep_data_file=on' requires 'preallocation=metadata' or 'data_file_raw=on', or the file contents will not be visible
+
+--- Testing prealloc=off data_file_raw=on ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=on keep_data_file=on preallocation=off
+read 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- Testing prealloc=metadata data_file_raw=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=off keep_data_file=on preallocation=metadata
+read 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- Testing prealloc=metadata data_file_raw=on ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=on keep_data_file=on preallocation=metadata
+read 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- Testing prealloc=falloc data_file_raw=off ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=off keep_data_file=on preallocation=falloc
+qemu-img: TEST_DIR/t.IMGFMT: Preallocating more than only metadata would overwrite the external data file's content and is therefore incompatible with 'keep_data_file=on'
+
+--- Testing prealloc=falloc data_file_raw=on ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.data data_file_raw=on keep_data_file=on preallocation=falloc
+qemu-img: TEST_DIR/t.IMGFMT: Preallocating more than only metadata would overwrite the external data file's content and is therefore incompatible with 'keep_data_file=on'
+
+--- Testing non-existent data file ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 data_file=TEST_DIR/t.IMGFMT.doesnotexist data_file_raw=on keep_data_file=on
+qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.doesnotexist': No such file or directory
 *** done
-- 
2.49.0


