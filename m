Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2F1CCA471
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 01:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5wxx-0005VA-Tq; Mon, 06 Oct 2025 21:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5wxu-0005Ud-Kf
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 21:58:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5wxr-00064O-9X
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 21:58:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so29059875e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 18:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759802285; x=1760407085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h+mEjJ4dN+093yekTE3GePAv6yz4mGPN5W5xcWoPneM=;
 b=ra1/9/l4FvOss3LaYSb/i6wVFQYOxz/PwjLwZFAHWT2EYIEXZHBXGcf2vkZydSYka+
 smCAjNO/O1Q1FF4jNRf84dJQacnGoj9JqS2HIA9pjpe22YvbXoyku2sM6amDbVmda25+
 XikSsfwXZvdPHA/F/+h07SPSJdDf3RhBxWEJF4g3FoQjxehbda+Mw2OkYxjMwkTX6vLW
 lvjlOXsOdTMh20JcemSMefdm1EtZSooYv5j42g0NX7nzh6I0aoYuczJoSj4rzx/4jkft
 sPwHJ8A/aQ2n3f6vq0/RtsZDi65mGphp4I7QeCgfWv24hgwIcfpY1M49Ww5L3gLdjtot
 pb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759802285; x=1760407085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h+mEjJ4dN+093yekTE3GePAv6yz4mGPN5W5xcWoPneM=;
 b=pncIxsV2XbGO77GKVFl7vhhZ9MO7uhqg5noN42VFaWVFUsoOTg+i4x936b+V562Bsv
 u/lDCGWiZQ1d1Zf7iqUUXFs3RkJJfQP2YYyNGqMV28wX0375Rjk9O4JY7fbL8VI324nF
 PkDeHY5a7ugGpkxF6zl2dNxNZ5Uz4uFB/XAPNc/86VtYxjO0cEH8LVEIZzm8JWjL9VRV
 MppCES6T3W/t0z+oAuJ9KaKAPN/8CO2Iyh2+18Ae2O7WeoJatXk6Abt8rePm0TbhsJyg
 HeILlrygVXuo4YXDcES9MyyJQjROCzo52lnnIqEATO4/mIqg7fx6mgn8pzduVkTf2g8P
 /izA==
X-Gm-Message-State: AOJu0YwWVqvYpPMCV70HPg3MTV7w1P6Hfart1Q6RoHVh+lDNGJPJtulZ
 C410WT1TBFWvrbMKV+PhcijWVzN1Xi0zWT8spEd3X+FvKAzlZRqGHWhNCDu0bTcCmj3of05rXaa
 WFnNmXa2T0A==
X-Gm-Gg: ASbGncurudgNDRb7LqqWaJur73dersSiIrRTMK+q/rcJxLDarrkYg+iTe+EONXTbBm/
 oApbC3QuAigeUm2YQeM7hYoGD/ugeZxafCU2f1uxyaF0MLGgWZSrH7UIyzCD48SJXZ3yvGraaFr
 LjXHPZSN/lNfwzo0Nx+KNrJgdsGd2NEdsHyaX9NDm15lErUaGCno0k+e+IMw0yO+JKZYp0Qwug5
 kMeM0asGtlY/ntLqD49tQ0vFQKw60NYjiWxCcLlTxDdNbbl+SIVGyHtMLDXZof+Yiqkq1s3Zdjw
 /zDDA/PuZVF2C9mbgXkRkrUwk4iQtA8QkKQ5whZTe7Kcb4P8uIe0V5CvC6jcRZQ2Kv3U44FPIPH
 8qsLu++YUUuhDLi652X94v40JRuh/qOdf2hVR8wMmcoq6biAwF1KC0yELI2sB8DV1juAgVkfiEB
 wKB5Cb9pKqJUAPassBBBwv5q0/
X-Google-Smtp-Source: AGHT+IFv937SnAh3S18snnbWHiXM+DebIej++ACzn92EN1cNeqGB/Wdq7uh8O6c5+GNFsaY7pS1D3A==
X-Received: by 2002:a05:600d:8395:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-46fa2ba597fmr5588475e9.16.1759802284782; 
 Mon, 06 Oct 2025 18:58:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e58asm179214855e9.7.2025.10.06.18.58.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Oct 2025 18:58:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] hw/s390x/sclp: Do not ignore address_space_read/write()
 errors
Date: Tue,  7 Oct 2025 03:58:01 +0200
Message-ID: <20251007015802.24748-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

If address_space_read() fails, return PGM_ADDRESSING. In the
unlikely case address_space_write() fails (we already checked
the address is readable), return PGM_PROTECTION.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20251007014958.19086-1-philmd@linaro.org>
---
 hw/s390x/sclp.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d7cb99482b2..8604cd305e5 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -305,6 +305,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     SCCBHeader header;
     g_autofree SCCB *work_sccb = NULL;
     AddressSpace *as = CPU(cpu)->as;
+    MemTxResult ret;
 
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -319,8 +320,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     }
 
     /* the header contains the actual length of the sccb */
-    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
-                       &header, sizeof(SCCBHeader));
+    ret = address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                             &header, sizeof(SCCBHeader));
+    if (ret != MEMTX_OK) {
+        return -PGM_ADDRESSING;
+    }
 
     /* Valid sccb sizes */
     if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
@@ -333,8 +337,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
      * the host has checked the values
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
-    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
-                       work_sccb, be16_to_cpu(header.length));
+    ret = address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                             work_sccb, be16_to_cpu(header.length));
+    if (ret != MEMTX_OK) {
+        return -PGM_ADDRESSING;
+    }
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -348,8 +355,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
-                        work_sccb, be16_to_cpu(header.length));
+    ret = address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                              work_sccb, be16_to_cpu(header.length));
+    if (ret != MEMTX_OK) {
+        return -PGM_PROTECTION;
+    }
 
     sclp_c->service_interrupt(sclp, sccb);
 
-- 
2.51.0


