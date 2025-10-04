Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4858BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTE-0005o6-PL; Sat, 04 Oct 2025 03:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTD-0005jA-8s
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wT8-00050k-Rg
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso24489485e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562052; x=1760166852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kn3ukWPRXTU9XOgkWyKL8R/0UDy8p5Cp2DkZ+dzgvL8=;
 b=Jqedtth8paI7yMRqIYFwOxitx+qFFGikFIxl1rQAs7Z5E1oBEw55xxqTo55QwvH2i+
 lm+SjdEjxOFkAEKHtUmLf8MQzTGgX5EC2jG1f1FWoi+Zo2a3s7azYMSkANuSh1z7N51w
 5nDqj7ECP4JRG/NBoSuEowuDOaENKSy/70bJCXAfeHLF8YG4wV1dZiML1nzHRpqEdM5G
 smAl/gEw8Pl4D8nthYBFGU/2NrHRcN3NFV5SVq3zeU39ohGNxN0gQEo02CT026FdyjN9
 /cELodsAPlqjp0ljNAquXIB60Nz9/mwLBhUdq0XuvQqwerLS07xhDrXdMs1o14siUIvh
 ZLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562052; x=1760166852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kn3ukWPRXTU9XOgkWyKL8R/0UDy8p5Cp2DkZ+dzgvL8=;
 b=SihoXHg10+vvIo3x1DSQ81NiXtvkMVi07hq+0sesN6wxo0xoRFfB7bK0lZ5ruOFj1E
 0xVYNBiCq9YfAn6MzFNszj+BRJsbQY159ZwIi4YVATaOecOiN975mFmNJ+bqwfqeRRjZ
 /dkRs85Ngk2zHf29iCG3cmMBd+wDeQGJgAQJZgJ/jwU1ycjuuJwRsXhhQELpe6KPeVId
 qUHghFSPMIe+Pcz9vZJkHrm++Zp9xMaXU/ytlL++OgX76sRO9WDd42iuBGoTgHWaJb3Z
 59thqfhbsDf6T6CJBEmIa/BfAVB8RE8bQkbXmOdrQdZO4Kf9b1+1/fQ1HbumIG5hkAVb
 ZHqQ==
X-Gm-Message-State: AOJu0YwiXsnlmleV1PT2VG/PJ4nL4oAQdh4heiC/Cqhm4t+xHsNerBqr
 zwF6ItOsq4W4unMTzCU84ka8xhJ4YXmEsrMrybj5tKF1wAvi9O1wx3EEkiOxPPtBmuVwzUvsyw2
 /xwv0SYfOIA==
X-Gm-Gg: ASbGnctm5yavufh1B9AY4qlg3UqBR0mTaPT6iMUDpMElof3PozQM500dKrRcmHXhIfU
 28Ad9+6olvyKAC6RRfW/QC8mE/QfqpuZHolFeTd5K1JEzKxVr6y0PMR5aECAhsYexvda9zWqq3v
 8zYc3OkG65KndqUyDOQEyIUeyK+kW6HATR9513R7ze6/GNRlgp0SKcf763SweBRoIiHaxj2qW5G
 6hRi8+inokghMfoKFY1md6y7oeJQfKmSEusT1Dr1R5eiFjkfoiaNq1MrLWnCqMqVZ3y9I9z6zbN
 s3lWcUt6CPgMNZLnU3o42mNHgQ7TVGfvOXjIJa15DBxIG5/fHBXB0MnaiJrAf+LABBTecwrY/iq
 /+NGCF5nz6TpiVCZBnN0OZdUp6zc4sr/QGxjreiswDYltDsVTaQAbS/ejS+djQLIHnoM/51cer2
 tCA1rBSQvAOfQFO2jtWt/el5QH
X-Google-Smtp-Source: AGHT+IGfOT3CkMal8D1G08nRYXp7Yp7P8ieTcMeYgG5t2Hs0EFfYophtcL9tJXUKt3n/JL20WCPnIg==
X-Received: by 2002:a05:600c:1c28:b0:46e:6d5f:f73 with SMTP id
 5b1f17b1804b1-46e710f6c5cmr40138285e9.3.1759562051963; 
 Sat, 04 Oct 2025 00:14:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c40983asm97237745e9.3.2025.10.04.00.14.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/41] hw/s390x/sclp: Replace [cpu_physical_memory ->
 address_space]_r/w()
Date: Sat,  4 Oct 2025 09:12:39 +0200
Message-ID: <20251004071307.37521-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace by address_space_read()
and address_space_write().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20251002084203.63899-8-philmd@linaro.org>
---
 hw/s390x/sclp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 16057356b11..d7cb99482b2 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -304,6 +304,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
     SCCBHeader header;
     g_autofree SCCB *work_sccb = NULL;
+    AddressSpace *as = CPU(cpu)->as;
 
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -318,7 +319,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     }
 
     /* the header contains the actual length of the sccb */
-    cpu_physical_memory_read(sccb, &header, sizeof(SCCBHeader));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       &header, sizeof(SCCBHeader));
 
     /* Valid sccb sizes */
     if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
@@ -331,7 +333,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
      * the host has checked the values
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
-    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       work_sccb, be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -345,8 +348,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    cpu_physical_memory_write(sccb, work_sccb,
-                              be16_to_cpu(work_sccb->h.length));
+    address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                        work_sccb, be16_to_cpu(header.length));
 
     sclp_c->service_interrupt(sclp, sccb);
 
-- 
2.51.0


