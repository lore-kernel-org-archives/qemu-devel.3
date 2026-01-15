Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E617D44C46
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgNoZ-0002YJ-U7; Thu, 15 Jan 2026 08:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgNoX-0002R3-Um
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:55:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgNoW-00050P-Bx
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768485303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93wgKnKmeOZilnfE5bsaANYa8+VZ81kU71KXmSuD97A=;
 b=GPzitpeUhezHanw08iv1HaulsTT19mH9NnKvY0PhmbS6WInY4M7atPAXzPDu8vRWPlkGPE
 lyjAxSAcvus4XZHiY9bRdY70oIjrnDYGIOMSRnnpRVi8DzfexyglhTO96pqUr4momvPYBm
 dYA58FRN384B/uxl/WdHtEGKz3JkZGU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-aBpARl1gMFCnMtE0jahjZQ-1; Thu, 15 Jan 2026 08:55:02 -0500
X-MC-Unique: aBpARl1gMFCnMtE0jahjZQ-1
X-Mimecast-MFC-AGG-ID: aBpARl1gMFCnMtE0jahjZQ_1768485301
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4801c1056c7so4686145e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768485300; x=1769090100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93wgKnKmeOZilnfE5bsaANYa8+VZ81kU71KXmSuD97A=;
 b=YlPYoU2MMPg1QS9NhEIp0c+EF6Z4PQM+ZNztrziM5AhEJP8Fwc5hPOiKnpE/6muaKZ
 zhwaHwYzCwBpgWc9ncGCmQXIij6PD5YUiCw5+WibC2+MXe1NcWKW25KGTnV8QUmVA+Pq
 y0suO24uGs0s/aRDmK3TmAJWEpUpGCx++nim5bbv6bufFvjzSwZuH/gzGpBrPs9B8208
 XRjUQ6cS6hUXDxxOSB47lDSj6r7qtkWM2m0Wer8TioBJvPDAd/g6TPw5D2bqqmgQHdo5
 2WvwU2OaqkMetPF9tWvCOzW7aSRhV1dJrk59V8CMDdcZ8NSstVS+LCVFN8KGFrN8t7GU
 whsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768485300; x=1769090100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93wgKnKmeOZilnfE5bsaANYa8+VZ81kU71KXmSuD97A=;
 b=OLVYGQpt2uTq3YvWnJYHZl5Jk3VvpUImYwBp5KwNKhHG7/Vh+7iQdohdsG78eiAZrB
 Bik3vqgBYd6L6HtiM9QqUOzYlLf063xMmLupbgCANkakvILajoOujAp/T+tWlPI3bm91
 AfTpV7zv+8lTEtIT2bTzADjXbqdZsQK+bMbcGYrUYuYTs14EO84cHJNbUS0Z1kAD+IaD
 mlofcoWMoruIyW50ypKDDv2/7h34ZEmo3oCtEHpZYSq0xZb4onWDTT+4hMfmW4Y5RM50
 1XNXO3Dhg85HuQz/7QLflxVp2xQMizILGQUwcZi0mrbvHF+8QRtnWKMSRTWZmfgMQrUR
 PRDA==
X-Gm-Message-State: AOJu0YwyKS86XZItnu/KFiZTg9Ri65Z+C8AzIiGN7lvOOe/sag/x9JfY
 r7cOhuVjpZ10eKlVAdC7Gt1Ea+L0lTisYhpbeTagWn+DOtFthWIkixNxXAwQz3vpXvQAOPOZEA2
 Q0QMvlbAJ/kwYAy/eKqX3s6JEveT7/QJH4HqZIM189F5EdmMJWREM9eRzviwpS7CvP0IGbKCj4c
 iVSXui8/F56H3hMPfY8SZBXDeeLqCCDE8HBefuYH3q
X-Gm-Gg: AY/fxX5gWBG3e9iUfPFdTbeqOpE8M1faTLmqjDfh49VXLUc3Qw+vjfLSbx903siWdNq
 qRIhePod/N0sgBlfi3TKw58QlMcNTbnIy5hvbI7Q+sBpc+kUjpqzhNkL7Ut9RPP6EXcigbHjQ6W
 HAmvsMKq/o2pTZ+pXaG2Tov5SzIfRxmYSxgg7jJeJpgmxRznMzNKY15BfB2GcqIqHlx11orT9I4
 lrjBULYi3x075O/9oRsmbIo+ImQtUQC+i43Xha3lgZ/Ak/EkxIbzf9i8MtPEJOr69IXa/UId2gG
 fkTQIh33p+AWWBowQi5lSS89cWaUwSIbft2PSX6gj5IOiZ6lriErydU5l/KpYNopr8al9Du/It6
 HijRfK6nbDxXoXHoP3OIGD/7N+gx/CY8Kh+qXqze6gctZFZrOORDVm7pO4g/FEbQxq1CbDX0oxR
 L+d0nbeu5o6GaIHQ==
X-Received: by 2002:a05:600c:4fd6:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-47ee338d74cmr78838955e9.36.1768485300352; 
 Thu, 15 Jan 2026 05:55:00 -0800 (PST)
X-Received: by 2002:a05:600c:4fd6:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-47ee338d74cmr78838735e9.36.1768485299963; 
 Thu, 15 Jan 2026 05:54:59 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428afd9csm48568825e9.6.2026.01.15.05.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 05:54:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 2/2] tcg: possibly convert deposit_z to shl+shr
Date: Thu, 15 Jan 2026 14:54:53 +0100
Message-ID: <20260115135453.140870-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115135453.140870-1-pbonzini@redhat.com>
References: <20260115135453.140870-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

extract and deposit_z are similar operations, only differing in
that extract shifts the operand right and deposit_z shifts it left.
Like extract, it is possible to implement deposit_z as either AND+SHL or
SHL+SHR.  Use tcg_op_imm_match to check whether the processor supports the
immediate that is needed for the mask, and if not fall back to two shifts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/tcg-op.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ccf66382623..e7d6702f9c4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -960,8 +960,18 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
             tcg_gen_extract_i32(ret, ret, 0, ofs + len);
             return;
         }
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-        tcg_gen_shli_i32(ret, ret, ofs);
+        /*
+         * Use TCG_TARGET_extract_valid to check for 8- and 16-bit extension
+         * opcodes, which tcg_gen_andi_i32 can produce.
+         */
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len) ||
+            tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, (1u << len) - 1)) {
+            tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+            tcg_gen_shli_i32(ret, ret, ofs);
+        } else {
+            tcg_gen_shli_i32(ret, arg, 32 - len);
+            tcg_gen_shri_i32(ret, ret, 32 - len - ofs);
+        }
     }
 }
 
@@ -2628,8 +2638,18 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
             tcg_gen_extract_i64(ret, ret, 0, ofs + len);
             return;
         }
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-        tcg_gen_shli_i64(ret, ret, ofs);
+        /*
+         * Use TCG_TARGET_extract_valid to check for 8-, 16- and 32-bit extension
+         * opcodes, which tcg_gen_andi_i64 can produce.
+         */
+        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len) ||
+	    tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, (1ull << len) - 1)) {
+            tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+            tcg_gen_shli_i64(ret, ret, ofs);
+        } else {
+            tcg_gen_shli_i64(ret, arg, 64 - len);
+            tcg_gen_shri_i64(ret, ret, 64 - len - ofs);
+        }
     }
 }
 
-- 
2.52.0


