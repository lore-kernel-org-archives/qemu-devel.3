Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1131CC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojta-0003i5-Pg; Tue, 28 Jul 2026 11:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtY-0003ee-Kk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:04 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtW-0002lt-O5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so7444f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253141; x=1785857941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ocPifY/R3bwmKezKFKwv/i1fMHzlWhj+bCpqwVCgyZo=;
 b=kUkVMN7MBU0PfTgeGwoZTyYyMVsbbjDH4pzcINiemXWn9P9GS79CnQvYF5e5VyQfw+
 LHWntliWiCErI3EcyOmwzMPNIaKiW2yUCMlwBxquQt3+mV1YveMqeZ/gv8aPH4dhu68o
 USI+Kus5rw//UTrXty5GJMoeJhH3WjJ4Mmsm1/BuWGou2n5wXi0Mde7FbecY1MRpMCgX
 3iZy0cQZreHTWMyCt5STzsLFWIcMnjhqHCzte5CVkTg8ssUq/RP7PkYgv4M1bhqxzuiD
 zJWk5yMMqoBzvPTwKQKJ0LUmMm4UXCW/KQ5ZUEslw+4uwvA+v94qzTQ12WGfqQhYBHZ5
 6wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253141; x=1785857941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ocPifY/R3bwmKezKFKwv/i1fMHzlWhj+bCpqwVCgyZo=;
 b=XPFM6ZQHJ3LexPy5jmc5XC8lJrvlJq2EnGZHb5StylRQMppTBLZ87aVH0z9wpYZ3P7
 Msz4tXA2oyPhV6oJB96/5MnhS2drwRm39EaHQbRfNeYexTsNiUixjwa9SIT5I/vliJrM
 /tigMC8bUrccbQzw51wTLc6Na8Na9x0ldUv92gQM+4oHO8MzW4ut7hjp2ntcAOckL2l+
 K3nIokSYwcx96CAA0cfm1drVQbIcCcqxldvJRvNlfEC19BVyFTK8qmePVBAebZlSQnd4
 dkiOFV6b2wQegwMz4JKeYn1tfkRwLqceUgSHXxgXrs5mI3cZz9xT9LYYp+VYcpnCf70I
 61zg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQIP3Vy9TrD8LxZvESLLnrbdS9P9twCREmipN/rFzGflOHW+fk2LvVjZiPdkIg3bKIoHsRn/4CsZZL@nongnu.org
X-Gm-Message-State: AOJu0YyBsIL536v9cmv9RgftSbP3i2pOhGuDiYfiv0Mxt1zuDhv2my3E
 lk0WrlIgnEDGwxzwe78KiPPCGIANY7EmSlUdqll9JK/u9C4Xc49453VT/RJX4eFa320=
X-Gm-Gg: AR+sD11GecY3gIfu2a2g3ye7YJ2O3rQynAsQA4SLcZ4PyPH7cjSgiZAud6ARJ5HtTzc
 aRx6I0iXT8r4l9jETq+/gUJctu78zeZRF5HoTRIYVuOd2x3k9D4S0SdooGK/E4cUveB4Pj3COAV
 WX/VuhrLo3Ih0nfuK87QHZoB7TSaUTI0T5Axa0yEHxDQ9hw1Q1oB8biUIZ0FLulOMjx+rF/O4Y2
 JndLHzHHsV40LbyZzCk32Bko8QmjQaGLhACM5rQe6AN7ITw+BFtbiDgaoW0puDyfOk8aAfA91Xl
 wcIy8zVmuC6xHmInoGuu5zDK2QPJfVDWDDLEdmFUGF2H1tASGgKDE9cnTZIBsHykh15ivtpbow4
 50VBA0Pj0vtne2o8Tx2+hj/P5sF5y/X+SlL6AUc+jpWsNscIbPeL92GETgGXeHdSShLeXfEwdlg
 ==
X-Received: by 2002:a05:6000:2905:b0:47f:87f5:ed32 with SMTP id
 ffacd0b85a97d-47fb1f1ee67mr3730714f8f.46.1785253140831; 
 Tue, 28 Jul 2026 08:39:00 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:39:00 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Feifan Qian <bea1e@proton.me>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 8/9] parallels: validate BAT capacity against advertised
 disk size
Date: Tue, 28 Jul 2026 17:38:48 +0200
Message-ID: <20260728153849.601939-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=den@openvz.org; helo=mail-wr1-x42a.google.com
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

parallels_open() copied nb_sectors, tracks, and bat_entries from the
image header without checking that the BAT actually covers the
advertised virtual disk size. An image whose header claims more
sectors than its BAT covers passes the generic block-layer bounds
check on open. A write into the gap between BAT coverage and the
advertised size then reaches allocate_clusters(), whose internal
assert(idx < s->bat_size && idx + to_allocate <= s->bat_size) aborts
the process instead of returning a normal I/O error.

Reject such images at open time by requiring
bat_size * tracks >= total_sectors, matching the invariant that
allocate_clusters() already assumes.

Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3804
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c                             |  6 ++++++
 tests/qemu-iotests/tests/parallels-checks     | 21 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out |  7 +++++++
 3 files changed, 34 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 8a7e8b4aba..93b5fa9dcd 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1328,6 +1328,12 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         return -EFBIG;
     }
 
+    if ((uint64_t)s->bat_size * s->tracks < bs->total_sectors) {
+        error_setg(errp, "Invalid image: Catalog size too small for "
+                   "advertised disk size");
+        return -EINVAL;
+    }
+
     size = bat_entry_off(s->bat_size);
     s->header_size = ROUND_UP(size, bdrv_opt_mem_align(bs->file->bs));
     s->header = qemu_try_blockalign(bs->file->bs, s->header_size);
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index abd119bc7b..d2a08049d9 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -225,6 +225,27 @@ echo "== an unallocated cluster still reads as zeroes =="
 # Clear image
 _make_test_img $SIZE
 
+echo "== TEST OVERSIZED VIRTUAL DISK CHECK =="
+
+BAT_ENTRIES_OFFSET=32
+NB_SECTORS_OFFSET=36
+
+TRACKS=$(peek_file_le $TEST_IMG $CLUSTER_SIZE_OFFSET 4)
+BAT_ENTRIES=$(peek_file_le $TEST_IMG $BAT_ENTRIES_OFFSET 4)
+COVERED_SECTORS=$((BAT_ENTRIES * TRACKS))
+
+echo "== advertise one more cluster than the BAT covers =="
+poke_file_le "$TEST_IMG" $NB_SECTORS_OFFSET 8 $((COVERED_SECTORS + TRACKS))
+
+echo "== open must fail cleanly instead of aborting =="
+_img_info
+
+echo "== write into the uncovered range must fail cleanly too =="
+{ $QEMU_IO -c "write -P 0x41 $((COVERED_SECTORS * 512)) $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+# Clear image
+_make_test_img $SIZE
+
 echo "== TEST BAT ENTRY POINTING OUTSIDE IMAGE =="
 
 echo "== corrupt image: point first cluster far outside the file =="
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 914616d023..c33f3852a8 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -141,6 +141,13 @@ virtual size: 4 MiB (4194304 bytes)
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST OVERSIZED VIRTUAL DISK CHECK ==
+== advertise one more cluster than the BAT covers ==
+== open must fail cleanly instead of aborting ==
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Invalid image: Catalog size too small for advertised disk size
+== write into the uncovered range must fail cleanly too ==
+qemu-io: can't open device TEST_DIR/t.parallels: Invalid image: Catalog size too small for advertised disk size
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == TEST BAT ENTRY POINTING OUTSIDE IMAGE ==
 == corrupt image: point first cluster far outside the file ==
 == read-only read must return zeroes, not an I/O error ==
-- 
2.53.0


