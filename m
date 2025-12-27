Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBEDE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQwL-0000sX-Jk; Sat, 27 Dec 2025 04:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwB-0000kY-Dl
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQw9-0007Kl-UZ
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUwtoIClAP7zN2ld+NydAiQdZPk655xB1d8oj28AgHs=;
 b=IqvkTyM+Wc7mLWS84Ej2iPWcOAZkTIZt6lwK/+fUZ9fPg3SJjraFmWAw7abUIPwaflJlNl
 /ndXYnuY2LQ/wCBttBJD/Y4ZsEYqjqn58EMlUOv3mlqI7PeyCUeoVodhRX18NMpe/sGTv5
 ajDW6hnaaAxds6+EffL1sTkMLv3r1pw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-QLq-gvSmP5-RsUPJTMPuaQ-1; Sat, 27 Dec 2025 04:50:11 -0500
X-MC-Unique: QLq-gvSmP5-RsUPJTMPuaQ-1
X-Mimecast-MFC-AGG-ID: QLq-gvSmP5-RsUPJTMPuaQ_1766829011
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso19457455e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829009; x=1767433809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUwtoIClAP7zN2ld+NydAiQdZPk655xB1d8oj28AgHs=;
 b=cZG5cfP2rHisO/oWZRScz/F4URuVquxLXXplDocRSIBomjNy+sxSyxd0RfSVfK+A8R
 TZiTx1Xl6vStjrmUG2U8LzoqOW8Scn9sb4vJUtldCrkAVBIkRZJENo8xIyzzSp2mAXSK
 F+ydmqvlTICkNwrov3ye2Whq10sIe3E+gzsDVGxoxjbhe7Dhv5hDEub8ogd4+uIQ/pzY
 7//pBcskIzCCTXPTv0HHj4pLjdDqduqjoWuUF7OT2TPC5jNwGdMGkJ6g2QzUSUQQRCZw
 gu3iMtuw7+aDfK7lxqCPbRkc8IJEAbyCojAE9GqVwXgJhcrZI/5MY/dkuCfZ4IUKYQmq
 bYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829009; x=1767433809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zUwtoIClAP7zN2ld+NydAiQdZPk655xB1d8oj28AgHs=;
 b=fkMEEJxniLCEsaqcBJfDIKH3OSdxU6irXcosflKrJkNmplWFLPGcpj7degwexLXEMW
 XyEQAyyBGb1yo5r6zZB1C0CqhWyeA3EsHpI2qZVwpW3iAoHZEucLfYWOVOl5ZD570424
 OCj63SCImFC5hUAaYbZm2yUg3VI3NDPA3LGntxL1QMrLM7sbLdBXNAfkJVttg1VbxX6J
 LOcPvRNY4YxERl70cU+RTN03Y/SH6u/rfS6D9TOkpqXigK4Ko0L4Enjx8WT/SjDlWWy/
 aRBLFs/YiXvptj6zGfKzuD5RfzG7JQVqnVmAt8iQByJ4z/L+k+b4LS6rykYJvx5qlY1/
 5EMA==
X-Gm-Message-State: AOJu0YwsK2ByU2x7HpkQr5ZmJatCsnV9ChunfjtnaL4o7yJGKtkZEKt3
 BdRt2IIw7Tq9w9TcAEap3z9frmrPy+FOSFoGPSccEBvzwt13ai1bGkplA4CSEFBTpo2y8xs7bGq
 loFbFnzRgjXWoqjBWms8O2F4SxCwYMTTHr18ieKXKft4iUkc2iMbgtx/ev4VWJXW5Ty/LJ4dAf1
 0XLdBb7i3rQHsMVkdmAWXoKHI4qutz9NfgpTIxQ/a0
X-Gm-Gg: AY/fxX4+iHPd/+16yBKhhmKF79Ksp1cfaU+ntciGgxLzC+3cWuL6kmExqh5qHMZhCfq
 puVHbefh4jtVLv2qK99AzoI43M9b1x/wx47NKu0/kbX6qE3g51zcWM/u7VE0G2ICFIddUzrkyQs
 ihP4SmFH/RDxcWGUwS8hH+eNjlsYVqFg26SHBiJQ/V9Kmi3JK1KwFWQFztQg9bssBS2w581Zf0R
 0dM/SaDWBrjc9g4CP5B7bSeK6KAhsqD9CR17ePhExx6WlVqUsgtTVvwwo5SsRmNmjYO6RVdLnxs
 b4H2PqxgkWBm0eI/s3bqT250h3lAPqbcsAvqGzyiKXf/+dxT21Ib3fLO6yRg8KzF1aWvQv+oBRF
 Hx5g79cwYsGu83uHUUEbODK6YHACcQ7CyHk7WxrYrCjsp8EI93Fbku24MzPIip7fUr+7mbw+pFJ
 vQcUUZErWnethOs2E=
X-Received: by 2002:a05:600c:5251:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-47d195a425bmr280359915e9.34.1766829009575; 
 Sat, 27 Dec 2025 01:50:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCo+BS7wftrSDLGYgiIVFFNnXSt1gd38ZN1R7VTxsGumcxQELrKWxPSSxvARQbmm8udhVB3g==
X-Received: by 2002:a05:600c:5251:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-47d195a425bmr280359645e9.34.1766829009131; 
 Sat, 27 Dec 2025 01:50:09 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa477bsm50144147f8f.36.2025.12.27.01.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 121/153] target/i386/tcg: move and expand misplaced comment
Date: Sat, 27 Dec 2025 10:47:26 +0100
Message-ID: <20251227094759.35658-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d2c024ea342..e7ffd3a9848 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1878,16 +1878,11 @@ static const X86OpEntry opcodes_root[256] = {
 #undef vex12
 #undef vex13
 
-/*
- * Decode the fixed part of the opcode and place the last
- * in b.
- */
 static void decode_root(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     *entry = opcodes_root[*b];
 }
 
-
 static int decode_modrm(DisasContext *s, CPUX86State *env,
                         X86DecodedInsn *decode, X86DecodedOp *op)
 {
@@ -2222,6 +2217,10 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
 {
     X86OpEntry *e = &decode->e;
 
+    /*
+     * Each step decodes part of the opcode and leaves the last not-fully-decoded
+     * byte in decode->b.  If the modrm byte is read, it is placed in s->modrm.
+     */
     decode_func(s, env, e, &decode->b);
     while (e->is_decode) {
         e->is_decode = false;
-- 
2.52.0


