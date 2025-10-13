Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30577CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O4J-0006SA-Jy; Mon, 13 Oct 2025 15:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4D-0006Hb-NM
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4B-0001s4-Si
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso34348105e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383122; x=1760987922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ImXH8sypVIhpdMufqY4sc5FsVXIt9DpvDMKcR5HfhOE=;
 b=qKFpw6iVGiJ3hBCB7ZfIKnTZCeY/w+3qs3Rqm1yARNcnacLtUpaGSajeTsodjxIOtM
 SDV5pyoghadLjJKoo9Zq/SrDcw4MJZKOFPF7ChNH5QBDoDzfwp6RBcQgmdACYYOGEXRo
 tdVjK+AzRR+yKOG66Y16WlBaFT/U/4mSk/6/avsIR5/t4HCL6iuwBPUHLqYBQj9dZxtD
 NHWJW7hXCUKLmkvZSVAZO36qas1qR6ExAzC3Qgoe7CZQCRv8HgXQoVK4btrOks4K4za3
 nTDXaR/nZQxi1oQEc4LuT+4CrTbhoJOP7wPYg6Xoc3i730bm72kaQgxNNo13WS+If+Jk
 yDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383122; x=1760987922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImXH8sypVIhpdMufqY4sc5FsVXIt9DpvDMKcR5HfhOE=;
 b=KZX903SsDO8+FYBY/o0wPkjokgQJfENCNYVxYQJEGELh4ITSWNzrliJDXM1+iRTg4I
 QqNCBUkJyYSpXCcq1tcNUWClOcFl60eujhUhs/+eoh/yPSLyd4yNaMwDHtrvLfVroWmp
 /BKLsZ7EUjcW37kVhS4eOwKGAvP7ffC/7jydHT2/75U1Vc9RLUatkyEduAtA/jXOLLcZ
 d0TQvgZpP6wus8diSadTPrBf8pHmd5w9wyRYNoVNf7wBU7Xb66VFDISljIlVjobNwAH5
 5BzTS0IWD0XIUcfRqJSAeHhl0Gtp+FfE4RVBrL26OjaofkwhEz4iOYGU/ccDxdz8YGrj
 ENjQ==
X-Gm-Message-State: AOJu0YzzwCWMuqN8Yc8azPn6aroBI4MSHOGIeAmdnUgqvlhc+dE73TE0
 PJa8QObsYlY5Bvws/JAMQcN9W9IPZCVy9530KWbu7WecwqkU6t/MbA8LQ/nT4U5jy8fRVdzHBnS
 G7vNEQlqzkA==
X-Gm-Gg: ASbGncvOIpWrG9q69mEC16Qyy8dopjw/SRg7m4XWryvNeNAA+3FeOBbFA179z3Xcd+E
 ciwnIbXVdcbI3nqS+ym19JcK+4IAMzzTqijA9jCc2ya6WGgQx9C0uYUAV0NgGh8Id3lS6jVmMGf
 FGwboDU0H7virHYrBgpnzSwyQhfWlocwAFrtT3Bp0Y6jtZk6FvHlbDpGNYMnZGX7pp8N7KSPteL
 4YQyDQ0DX5en9DI80XFsfqOa+yh/Z7CRbt72scVEIQC21jb4dbDK4GU+1/o9XFYQkY/mXMdFL7n
 jQbiUIUz5AVhFez+GnMqZGwH6Wx5ip5plZb7YVz/koBeVZeE+NTglwFgldjMWsfTtKoBeX9C0Y+
 aSk+S7cZLynSDSGjdg1+fL5IWW4FVBsPUHNk1J4zJtF+hHlp+Utzr5aWPBYot7AE++4CYg4Tkjh
 aO4o5bIGl1oCizCl8yA+s=
X-Google-Smtp-Source: AGHT+IF5Eb+XA79eXZvnjcvCFm4yRMft5BmVXTBJOWG2i4nOd1dhHE6GO1wIG7DG69IC1V5EWULtmA==
X-Received: by 2002:a05:600d:18:b0:46f:b43a:aeed with SMTP id
 5b1f17b1804b1-46fb43aaf3cmr78144095e9.40.1760383121761; 
 Mon, 13 Oct 2025 12:18:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b9absm228450055e9.2.2025.10.13.12.18.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] hw/s390x/sclp: Do not ignore address_space_read/write()
 errors
Date: Mon, 13 Oct 2025 21:18:02 +0200
Message-ID: <20251013191807.84550-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

If address_space_read() fails, return PGM_ADDRESSING. In the
unlikely case address_space_write() fails (we already checked
the address is readable), return PGM_PROTECTION.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Message-Id: <20251007015802.24748-1-philmd@linaro.org>
---
 hw/s390x/sclp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 51e88ba8f12..8602a566a49 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -306,6 +306,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     g_autofree SCCB *work_sccb = NULL;
     AddressSpace *as = CPU(cpu)->as;
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    MemTxResult ret;
 
     /* first some basic checks on program checks */
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -320,7 +321,10 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     }
 
     /* the header contains the actual length of the sccb */
-    address_space_read(as, sccb, attrs, &header, sizeof(SCCBHeader));
+    ret = address_space_read(as, sccb, attrs, &header, sizeof(SCCBHeader));
+    if (ret != MEMTX_OK) {
+        return -PGM_ADDRESSING;
+    }
 
     /* Valid sccb sizes */
     if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
@@ -333,7 +337,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
      * the host has checked the values
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
-    address_space_read(as, sccb, attrs, work_sccb, be16_to_cpu(header.length));
+    ret = address_space_read(as, sccb, attrs,
+                            work_sccb, be16_to_cpu(header.length));
+    if (ret != MEMTX_OK) {
+        return -PGM_ADDRESSING;
+    }
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -347,7 +355,11 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    address_space_write(as, sccb, attrs, work_sccb, be16_to_cpu(header.length));
+    ret = address_space_write(as, sccb, attrs,
+                              work_sccb, be16_to_cpu(header.length));
+    if (ret != MEMTX_OK) {
+        return -PGM_PROTECTION;
+    }
 
     sclp_c->service_interrupt(sclp, sccb);
 
-- 
2.51.0


