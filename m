Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CB2C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 19:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4OPn-0006ZB-GH; Wed, 09 Sep 2026 15:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1x4OPg-0006Yk-Ad
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 15:56:56 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1x4OPa-0004jv-Bw
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 15:56:56 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CD36B3F5FF
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2026 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788983806;
 bh=A6FQP+ZxmEQw+0kcPp6DLgOSvFCHgd8QtCIooPJAhJE=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc;
 b=ajPBMQt2nv975rjXkmJQH2/XxWPPj/bWrxzzlqxyhylm895BsBJsHRI7TY701zho9
 tKCN+HJvAIHsIFEyixFbuVgNKZRyKkavpxFUOmSPsX21TcYp8+Si6NePtFswJsZvd+
 L172SLKqWf1PW36/0j+noKcLblG7eIyMXsqS2CH+Sy96in1xi9Is5RnWSSBYJCmWsy
 aCRnf8vO2o9ETTMVf6yKSkpDQbnPyTP4oA+J8mR3mprq6quQoHoffQbuQvYY3FjlTu
 K5kqjbuA3h0KwLP1g7t6tNNGEvL+5MfRUk7zNiz3FggJar2PkMHnf2FsEKR/xH9n4X
 FeohAh8icxHh5ECKtsc4f5uvrZwHVZqNgvtxRujC3uoJ48G0gYsNXLLCgt9C2apqM6
 Gfxn1RvePbA3TWQE84uY3xWTv3o0D4TFmZP6HoaVdZq5rk9KMVjnmuLFsrzLr5yNyO
 Mxen0qIfztKnn8kDtgt4mwAmUlla9O8n3M46oV/GEE3+MsQlSYdQM8QNU/pfnNxrmP
 V9pqwoR2jwKkHd8td5sZ4S+wNwgzAuPqTXThrmo4NDDLW/l071/pohYeB9L59Tirc4
 s68Wlrr/S4leIrfR+BGNizu2fm1FAESmlENrJMxXGlTAOpqe2RkljDsKu3mOa+57na
 OO2ca/sK3t9SnxRLHuHp9SHc=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2db3734d06dso90228255ad.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 12:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788983805; x=1789588605;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A6FQP+ZxmEQw+0kcPp6DLgOSvFCHgd8QtCIooPJAhJE=;
 b=k/Ag59khyM6U8DTRisRjvwcL1EfvhAlMTeNg3Z0iBym0o5MNXKeV28ZMWXJ+6URPtK
 3U4ZdPt23FQi/8et9BVKiJRhaM4d5VEDkypSQNxgENoWSE59B4TTJOdRLsmt1KXHRKIt
 iFA8kS5afWvzG4w3aBH7fhV4u/ZvESKzG1VFptVIM4HFufhY97PYNwOydUZjSsqoch5c
 sJEHa18IlclBSRLaNbCFHfL7Ykgx1COqwRRM7t/Nl27qV/pnVm3vAkZ6MDJbbc1JlDPv
 O+KxQ/SdciuPfVmlWAQHwUh5Wd+HQ48yVA1HhPN5aRJj6ekYrujhZVUitzG6AzFDG4dG
 Q15w==
X-Gm-Message-State: AFuF++m1h2Cu27qAfFzNuzsS5+iItbCi/NcWmPHS0jTtSH3HuCREvbBm
 zl1AmaZUXgRJCgNwBO0416z9lrpm28ZLb9y0vugEnSv8kSStMd38YjUYozOJR4WENSqT2dM5Exc
 v4eMAsiZlAJQMzsWpo/+0mo3c0guTW6ooUdhwXS2vteGX5LwAiUGX27tvb9jEfzMjnRLRj8Xbax
 gtGLcPFVT3Ug==
X-Gm-Gg: AYBFou25MCyECXlQH1uHZs/5wODG1GD0kUUYQQFSBjnODaRmvQW74G4L4RsQEwhxeC8
 h2nW9tzkf0D8LGxMWmYNyg3u1bueoEBHlIqktJLpjpBJGVsMnP1Q5v5qggKBwYlZYiFeMfPl6sp
 VKMgfUrLPeSQi00EQcGtezSvEA2cQ1GTgEihVLDtiBYaTPIJ6v73kboUMccYrYuI1I/hDPkIYLJ
 gghnUJ0r6cYQOpHFdwBfcAyMTJu6wYxZz/qtHFSjNaXZdO6GFs2Ny65mpcGt4Vr+dFJ2uVTDMDJ
 VQN8AylozNtNt0/QNWiS/yltlFoSKco4bpFfQndT/161rFm4oIrSJieSl0pgbxB4LmHgWRB+OXr
 FWG8Cp2Oprf9OqC3S1x1JRplSpO5s6hqg5NPqMDxgJDdhckKulYLRog==
X-Received: by 2002:a17:90b:3c42:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39b260d2977mr54318179a91.4.1788983805338; 
 Wed, 09 Sep 2026 12:56:45 -0700 (PDT)
X-Received: by 2002:a17:90b:3c42:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39b260d2977mr54318147a91.4.1788983804913; 
 Wed, 09 Sep 2026 12:56:44 -0700 (PDT)
Received: from [127.0.1.1] (r186-53-90-24.dialup.adsl.anteldata.net.uy.
 [186.53.90.24]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324356931sm72538799c88.4.2026.09.09.12.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 12:56:44 -0700 (PDT)
From: Jorge Merlino <jorge.merlino@canonical.com>
Date: Wed, 09 Sep 2026 16:56:22 -0300
Subject: [PATCH] block: add debug when block operations finish
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-debug-block-ops-b4-v1-1-2405f34ec068@canonical.com>
X-B4-Tracking: v=1; b=H4sIAOW5oWoC/x3MQQqAIBBA0avErBswCcmuEi0yxxoKDaUIxLsnL
 d/i/wyJIlOCsckQ6eHEwVd0bQPrvviNkG01SCGV0EKjJXNvaM6wHhiuhKZHq0g5vdhukA5qeEV
 y/P7TaS7lA4teBAtkAAAA
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Jorge Merlino <jorge.merlino@canonical.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2560;
 i=jorge.merlino@canonical.com; h=from:subject:message-id;
 bh=Sli1KvOs1VSZBBMouN88DGrf9cZVfuDM8svl21fSRVU=;
 b=owEBbQKS/ZANAwAKAbCmxgD4DSg7AcsmYgBqobn66azt6fWl74Tkelzfl6nT6qCXUX91hAsKN
 2Fv1sfq4/OJAjMEAAEKAB0WIQSX6BDfnZ5646Dykg6wpsYA+A0oOwUCaqG5+gAKCRCwpsYA+A0o
 Ow/JD/0R94+fIzLcQR+FIdul6dDJ3nTytV7lg9vTileJYQCuEjF4y53D9MGF+ysH5t4zpSpwqPs
 AEXVVZPaZSSJo3PnO4DNzurBYV+WpreUM6d2ANoUvp02ZjpYuosSOrvSxWlWitvug8uR0TliysL
 adBimIsSExJ+zyWn4IzCF2hrIHDWmrp+lDppKoK6f+N/aKUBAcIs1nkdMUb+piodeDq9B+koqL7
 xlc5z0qwmQdAA2ohv6WvpE572K6GZIQBt+ZMzuHD4+fZTx1GhrpSA6025BQzVlbPD+zR8C/S/nF
 pQIhhG4sFJLKflEFFlCC7kMQ+8XxxE/EYvBzUWbNSs+OBWeAWQixsaR1nwx7m70Zk/YquqQaX1Z
 pxiWAtQ67RZ3HFl6VZvPTLk3hBX+Gdx63hcpbFaq5FXJIWGdcxqasYk3k7DTIyfH2GVNV01rjOd
 Op2xVZX014ecZWGpQqunWr4ZiJBBC2FTparYBbysYRX5PRK9wZcO8vmIlFZK2SiS8HXLogTAPPj
 J2Trru0kBfEhlemzTvn1HAKi5NW6H3IvzgejZfKOVMkrAtnpumkXHPczidrwMbaXC6+aTS0rfTK
 fdbltN9whDAlu2fZXMtGKCg+CllYASoBqCyO6TjMdWni09J+YggbZOSDIKzYrE5IqJetlWPgtOT
 60a3+7onYPbiGTg==
X-Developer-Key: i=jorge.merlino@canonical.com; a=openpgp;
 fpr=EAEE4B9833141159D1CD846907F02065E74A8FC3
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=jorge.merlino@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Add new debug tracepoints when block read and write operations finish to
be able to measure latency.

Signed-off-by: Jorge Merlino <jorge.merlino@canonical.com>
---
This patch adds debug tracepoints when block read and write operations
finish. The log includes the parameters used when the operation was
initiated so that the start and finish messages can be easily
correlated. Also the return value of the operation is logged.

This can be used to analyze latency issues with block operations.
---
 block/block-backend.c | 2 ++
 block/trace-events    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 37ba7e9fc4..75d3cd1949 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1364,6 +1364,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = bdrv_co_preadv_part(blk->root, offset, bytes, qiov, qiov_offset,
                               flags);
+    trace_blk_co_preadv_done(blk, bs, offset, bytes, ret);
     bdrv_dec_in_flight(bs);
     return ret;
 }
@@ -1442,6 +1443,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = bdrv_co_pwritev_part(blk->root, offset, bytes, qiov, qiov_offset,
                                flags);
+    trace_blk_co_pwritev_done(blk, bs, offset, bytes, ret);
     bdrv_dec_in_flight(bs);
     return ret;
 }
diff --git a/block/trace-events b/block/trace-events
index 950c82d4b8..842c3fc809 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -7,6 +7,8 @@ bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 # block-backend.c
 blk_co_preadv(void *blk, void *bs, int64_t offset, int64_t bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " flags 0x%x"
 blk_co_pwritev(void *blk, void *bs, int64_t offset, int64_t bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " flags 0x%x"
+blk_co_preadv_done(void *blk, void *bs, int64_t offset, int64_t bytes, int ret) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " ret %d"
+blk_co_pwritev_done(void *blk, void *bs, int64_t offset, int64_t bytes, int ret) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " ret %d"
 blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 

---
base-commit: 1df256f5968e9f7c3c4533a1383b071c044a36d6
change-id: 20260909-debug-block-ops-b4-d6e6f9ad182f

Best regards,
-- 
Jorge Merlino <jorge.merlino@canonical.com>


