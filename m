Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC29CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnL0-0007ZS-3b; Mon, 20 Oct 2025 06:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKv-0007WO-Dz
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:57 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKt-0000g1-BF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:57 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b3b3a6f4dd4so781890666b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956913; x=1761561713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdpnkMbbUpYrtLpkGWrMXiavm+tcMRwuxpmilKnsCCA=;
 b=Kb98qTObo78LlPgezIQ+zQFQLHFBtFAYShB/+IR4OKK5dV7crAwkVlf7FqNyrDlDTZ
 i0agl9YSScPSEog1H8SqgSJRTsnR6bVHXM1Cg13h7k504EOUKpJ0Q8JmWvaN/JvRIpq1
 okuSKTcRMWHCid9x9EGNpaHK2+Kgc59nw1heduZGqsOcs/WsGx3L6gfjADuTxfcMrx9s
 8zs8HY/ExstZzUIU28PidqNvNsQiDacnq0N+W/mjoaRTnXXwDrrqg9IKNT1PsgrZXTeT
 PLElMOeX3TcRrJnVEqMWVdf3ZNEgN948VcOSrwQ9VnhLxUxIB549qlhVVRnIzBVBBGa7
 rRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956913; x=1761561713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdpnkMbbUpYrtLpkGWrMXiavm+tcMRwuxpmilKnsCCA=;
 b=QJ1uq+K9vQZtwiG6EjUf2P7/DwPGrjYvVMqJRoUeyFUqO8NnOJF0X292cknyt9BKFq
 IoEco47TChwFee+Ufku1WW2h9iNwy5QXuMMVofxaBeifHlDtWdODRupqTKuoZxqqKpNQ
 k0Ob+ATzZRQ6zUNVkW/icWKVxsJTL8fExID1WtWBEfWo1YsMoeVIDuEMrorac9UVyfo+
 iccRarfSBfJdILrIlnjHfVooJwNhEYfwdaumXdNK1JmXChg1F+2uVOjQKTcT6VPa9O+W
 xgq4oDPu0HAm7JKgbtZN4+pHdS0D4Cd9eZh/cQYuRA5hl4ydqikP+6Z+izfsNK+8mi9z
 Qo+g==
X-Gm-Message-State: AOJu0Yw/1poSozjcZziaDnHnZqTYaT/5NTym9dlf2KfCKLrt4Em+SFpg
 kamOoD2tFm60HzVc2Zvtx+tHhmcx6hFV0UQQRsPew4/2DFueRcSzp6GC2eTctriNa8ZsvL88H4f
 IeMP4af0=
X-Gm-Gg: ASbGncu3FFiO4pUjA+lkVwBnmwW+lhFifsegCvBDwSDr2xvB0JF3StgtzrGukN27xnw
 pVZQlWRQjKPCizySAP0ajMPV0vDd4OqEM+7jNgfwsKyt5im/hWArWA6zikoxtuX/+AzT4mpIpgt
 kXJnKP6uEs9zxWQLzK+3ApoeLolaPgCpv5ADVfkQ6gwiU0fFoMkEjgV56WRLusaHra7yukGZXN+
 Guts4LCKeLLOBNeCmzvOckUDABoVegnzv1J5J2s0IVz3se8gozqFdh0WjGksX0G2ab1lqW0P8/u
 7wTGKFQ+wA6iWDZHLjjlQ6yOLp+Qi/9/hhxJWOu8QmZtsnzVYCsUHI5j7f+KRhMdkTSD6Cvk4yZ
 d1A5Z1H1IhptVy4TeVZnXTzgIs2IXPgeac6DsJbIhesFNcU4YcJLvvMZLS3I19068kqoHySW3PX
 kzqeYo8LFj+38=
X-Google-Smtp-Source: AGHT+IGPcKbhjk7sTWmD13E2n3JKvkcNRO1Xsan0ivp9dCNie+2dSpUFEnn2P87sh/KlCc/t5vRfxw==
X-Received: by 2002:a17:907:7b87:b0:b2d:d7ba:8e7b with SMTP id
 a640c23a62f3a-b647463a2d7mr1457036366b.23.1760956913116; 
 Mon, 20 Oct 2025 03:41:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65e83937a3sm757643366b.23.2025.10.20.03.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D67445F905;
 Mon, 20 Oct 2025 11:41:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 03/11] tests/tcg/multiarch/linux/linux-test: Don't try to test
 atime update
Date: Mon, 20 Oct 2025 11:41:41 +0100
Message-ID: <20251020104149.4034124-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The linux-test test includes an attempt to check the utime and stat
syscalls by setting the atime and mtime of a file to specific values,
and then calling stat() to check that the values read back correctly.

Unfortunately this is flaky, as it will fail if some other process
(for instance a virus scanner, backup program, etc) gets in and reads
the file between the utime() and stat() call, resulting in a host
syscall sequence like this:

utimensat(AT_FDCWD, "file2",
  [{tv_sec=1001, tv_nsec=0} /* 1970-01-01T01:16:41+0100 */,
   {tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */], 0) = 0
# successfully set atime to 1001 and mtime to 1000
statx(AT_FDCWD, "file2", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT,
  STATX_BASIC_STATS,
  {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
   stx_blksize=4096, stx_attributes=0, stx_nlink=1, stx_uid=32808,
   stx_gid=32808, stx_mode=S_IFREG|0600, stx_ino=21659016,
   stx_size=100, stx_blocks=8,
   stx_attributes_mask=STATX_ATTR_COMPRESSED|STATX_ATTR_IMMUTABLE|
         STATX_ATTR_APPEND|STATX_ATTR_NODUMP|STATX_ATTR_ENCRYPTED|
         STATX_ATTR_AUTOMOUNT|STATX_ATTR_MOUNT_ROOT|STATX_ATTR_VERITY|
         STATX_ATTR_DAX,
   stx_atime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
   stx_ctime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
   stx_mtime={tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */,
   stx_rdev_major=0, stx_rdev_minor=0, stx_dev_major=252,
   stx_dev_minor=0, stx_mnt_id=0x1f}) = 0
# but when we statx the file, we get back an mtime of 1000
# but an atime corresponding to when the other process read it

and which will cause the test program to fail with the error
message "stat time".

In theory we could defend against this by e.g.  operating on files in
a dummy loopback mount filesystem which we mounted as 'noatime', but
this isn't worth the hassle.  Just drop the check on atime.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251016150357.876415-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
index 64f57cb287e..bf6e0fda262 100644
--- a/tests/tcg/multiarch/linux/linux-test.c
+++ b/tests/tcg/multiarch/linux/linux-test.c
@@ -155,9 +155,14 @@ static void test_file(void)
         error("stat mode");
     if ((st.st_mode & 0777) != 0600)
         error("stat mode2");
-    if (st.st_atime != 1001 ||
-        st.st_mtime != 1000)
+    /*
+     * Only check mtime, not atime: other processes such as
+     * virus scanners might race with this test program and get
+     * in and update the atime, causing random failures.
+     */
+    if (st.st_mtime != 1000) {
         error("stat time");
+    }
 
     chk_error(stat(tmpdir, &st));
     if (!S_ISDIR(st.st_mode))
-- 
2.47.3


