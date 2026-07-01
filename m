Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904B0C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wenMp-0003UR-LZ; Wed, 01 Jul 2026 01:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wenMl-0003Ko-7f
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:20:07 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wenMj-0005w6-OH
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:20:06 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-37dedd62b90so107519a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782883204; x=1783488004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxxUFPOzE8l9ZSDN3CNthmxb/jce1JnhohMY6NH66MM=;
 b=oL5m1w0PdQOTHSS2DEscLQ0a17wtt04/nWguDaqPjitK9bmeXwuYgUdxu0KkMJcjOb
 yOFtNYtXxBrvgDR+C3Pjexmh706irYAPuyd32d+v0e9EnIx40o8EOM+hcsVD9dgCL5vy
 /070gbvCiSym2NErzJ9E4jiXDd8b6CK8Go8XMK2tJAeiGB4iwLio1fjO1e1DpOKcpulN
 9qd2ylJanGk/Qi0sACu4kNh5y/SfVhrTeGLVrWwOm1TGLa3eAFy95GVPYVeN1QrQ655t
 oCaNHXRmCdol+qkICP99sI4acspYkwo1PguN6ht92CxbbGRANgE0b+dqTNm/f5KWz8iN
 lqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782883204; x=1783488004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pxxUFPOzE8l9ZSDN3CNthmxb/jce1JnhohMY6NH66MM=;
 b=cnARADwJNyenVcDdth2TvvAzUcd8OWsHHiQX0ZGmBfq/KqCXRQMefcBEuMrWJBnimL
 Pc4eIFfSQg64JOJrWJ559BF/LHNkETENMT24hGNeYDLCBQB9yLd0QYlI/YyBgxU/JgW9
 PM5UmYiD7UbJ0Y0AgvNYxHedN2pHvMlnOXneOUzqeY4El0dQblHOJSik2KZMh6oxIz9U
 W/qmu1MzvlJG5gvGH5DJsRdiLnSvvOs6IJOncmvClWZ/5t0ovaHpkFy3w8k6P89z0Jwk
 uyg5w4tZz88QN08CBG8PHtWlpSbtYQga8DSZgCXhnhZw6Qm3OyVZZjehk9RsNQGjBpj+
 F/3g==
X-Gm-Message-State: AOJu0Yz9aEanhQ9VCTLJlH6CzOlbF1hV09nVpcmr1upfJ9RfaEeE0mmY
 TNwvZQmvTRQmGlCcSsup59m/Ro6gzYN6REAj5LJ852Jmx+u+hIJxPpsVqJYZRg==
X-Gm-Gg: AfdE7ckDkU2wGfPq3UQo/vnn7/p1KrRU9JF3e5tgNdIIv/P0IW3QjB1QwkjVXgk8rul
 ECxnyaBPKmsuMTLsTQ6I8CeDy1eDTSbwWMFB7ypFtmM6rjItCXZWNFt2e3qUF80NXhvv9D1GOCm
 Se+PC5r29Bb+5EGQFXPKD6F9YTItiutpEvpfH4McuFZUUzxK836N17jVoi3j2T5rQ1ZBG99+W0+
 FxLDyY1C5WB/RLDOLcfR8QBozX+kMSa90Wtp32PlTR3XZC/hzuO+TRWFY4o3n7oDkRAbHON4aoI
 qUZU8B9MVRvDyR7SsRqsrt1kbP/dvzCMW1Kgyg7SE0d6O9NYKlvTr/cYgZG58EiRMmB6w75T6Ja
 6tZy2ygrGk93uDBUxSlPwXBTwYwgclTbIdzAgVwhnZE8K1Zw2pXB5kkkUXT5TMyzcaPb40/TPJo
 N9i8DggyTPGPzEeVd3zA==
X-Received: by 2002:a17:90b:28cc:b0:37f:fd70:6790 with SMTP id
 98e67ed59e1d1-380aa18b1ecmr184417a91.9.1782883204010; 
 Tue, 30 Jun 2026 22:20:04 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095d4c263sm1098157a91.3.2026.06.30.22.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 22:20:03 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 2/2] hw/ufs: Populate cqe.task_tag for UFSHCI 4.1 tag decoding
Date: Wed,  1 Jul 2026 14:19:47 +0900
Message-ID: <20c03709b353d6c985bfa3174c4563d57ff47275.1782882742.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782882742.git.jeuk20.kim@samsung.com>
References: <cover.1782882742.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

In UFSHCI 4.1 the MCQ completion queue entry carries the request tag in
the cqe.task_tag field (DW5), whereas 4.0 hosts derive it from the UTP
command descriptor base address. The device reports version 4.1 in the VER
register but left task_tag/lun zero in the completion path, so a
4.1-compliant host reads tag 0 for every completion and cannot match it to
the outstanding request.

Add the task_tag/lun/iid fields to UfsCqEntry per the UFSHCI 4.1 CQE
layout and populate them from the request UPIU header.

For example, the Linux ufshcd_mcq_get_tag() uses cqe.task_tag for
version >= 4.1, so without this SCSI commands hung (e.g. INQUIRY to the
device W-LUN) while device-management commands still completed.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c        | 6 ++++++
 include/block/ufs.h | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index ee7eba6793..464fd465b3 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -520,6 +520,12 @@ static void ufs_mcq_process_cq(void *opaque)
         req->cqe.prdt_off = cpu_to_le16(prdt_off);
         req->cqe.status = status;
         req->cqe.error = 0;
+        /*
+         * From UFSHCI 4.1 the host derives the request tag from cqe.task_tag
+         * rather than decoding it from utp_addr.
+         */
+        req->cqe.task_tag = req->req_upiu.header.task_tag;
+        req->cqe.lun = req->req_upiu.header.lun;
 
         ret = ufs_addr_write(u, cq->addr + tail, &req->cqe, sizeof(req->cqe));
         if (ret) {
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 66e8f35c0e..d19b3c65ef 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -1333,7 +1333,11 @@ typedef struct QEMU_PACKED UfsCqEntry {
     uint8_t status;
     uint8_t error;
     uint16_t rsvd1;
-    uint32_t rsvd2[3];
+    uint8_t task_tag;
+    uint8_t lun;
+    uint8_t iid_ext_iid;
+    uint8_t rsvd2;
+    uint32_t rsvd3[2];
 } UfsCqEntry;
 
 static inline void _ufs_check_size(void)
-- 
2.43.0


