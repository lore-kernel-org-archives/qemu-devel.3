Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2098BCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95lB-0007gy-6Y; Wed, 15 Oct 2025 13:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95l8-0007ga-OJ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95l5-0005Vt-3Z
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so5453075e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551070; x=1761155870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4fhoCLIyqRadUb5nIbhTUh8Lb6uUpWCjNs2kXoymgQ=;
 b=LVxFCi4CubaCM4BoZRM1/mVQhJeR4zPLE7q5XH3jXJzhiBufaYDPc2rBJVgK7tx6wX
 VOqu1wLeVm3SSxO5H4N0N8O9YfoPtdHrhMFY7Q+A6HL5nSII2D+Hj5IPyQy6SZXfDCQt
 8p/TooaWbmeBXEThbBxtnFZud6QGmWY2374tIiNmVOq+LOeSMnH+v0tlDdPJgObeudrV
 Mzg4quoufatohZaNXxq3XXNbG48YfqGVyy1KuwSsKEu6A5HfNzZ18uk2iiMJs9wrh5lE
 m8YNU5TJ05JPMbqkVR21G85Qmyf5K0VE708JMgSQurGKYXdIP+l4RCkYdzmpemCQBFnh
 gFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551070; x=1761155870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U4fhoCLIyqRadUb5nIbhTUh8Lb6uUpWCjNs2kXoymgQ=;
 b=guwPt7Gg5siInPh28Yhy8E6qojHZSWYB9vucznlUq2I+vDzPxm3gAw4Y0LV74VnA1f
 B9MkSy4SSrT4nR+5hpTciSZis1ZZjotH7ZXQdKAbfYlXxiTdS9TkdEefQWsyi/WE3Z+y
 KhR2k50o7DpO5XRTVCPbxNzjtlOyjnLgiYVJ5O0ArqHakbI7Pn+e93zkv2Ja50s9SL8U
 oY8K7TP0AQWLqzYAgzAWsWG/mAeh3Q6+TYZ6jlEPb2ESa76jWhrx/2WtO61oTGcf3jRI
 mX5gFd+FOCmUmDkoxvr7ybMiWz69fYqMMleD8iMk5NbmlDfoAp2r/SvvvhZZ45TkczYP
 ejsw==
X-Gm-Message-State: AOJu0YxvxJ3mxo38hTMv5Va/QEv2tON+1LJXi6vQWsshjr6+eoeRf+mx
 S/hN8bMUsUxK4UuA8KtfsuH/NdyCJ9ndDBeadLgBjyEDlSwczg36e6RhJgRgUd/ofcqHYIQJ4b/
 9GXtnOMvH7Q==
X-Gm-Gg: ASbGncvPcdQtHbeHP+q/NgjCqqj69e5vZP//9I97jCsjcZRMy4V1c25M0AyPZYASTvh
 5jwyW64oVvqbY8Vtb1Xazamvz5pzak2XY6lHZxzx7mrdsSVGVf6sUf0ADLF+d5NhQa50GDyB/bv
 rVBIyHZAyJ8FIq+pzpzzDn0H/zza2eGANyAi7wRSpKiE8MeeMPYYsO4RktnTXERm9bMwNoCu3ym
 gz7B8SywdcztAPWV9BOhT9TJYU/oSYfjDSnY9dpyOpYjxDquazzLiyx5a8NVJLEc4wR+PcfpBMw
 QyNzbM5zE7AqVpO1nfa9qepXo6iEnmhHAAoJJbSo3q2wlVg20vFO3jaDoNBkESljGdf8iIJCZW3
 N7kwqHVft6jA+Mrr7Le9jM8RMZb/2zx5bC3EnDF7wkQ13yxmZgfVv6z+6Pdyt3LDcGbJFaZm3Qs
 Ia+yqQzFD/DnGvbhz2OIEuxnQUwtPrxA==
X-Google-Smtp-Source: AGHT+IGMLdxDmgFJGj86jaPCx5isb+ag8PwEql7qNlwH9OMESXYvP3DqWMAC3Whu+8REx638s8H1Ow==
X-Received: by 2002:a05:600c:181d:b0:46e:7dbf:6cc2 with SMTP id
 5b1f17b1804b1-47109a22a51mr6727735e9.8.1760551070430; 
 Wed, 15 Oct 2025 10:57:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489197dsm317075475e9.10.2025.10.15.10.57.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 10:57:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] target/microblaze: Have do_load/store() take a TCG_i32
 address argument
Date: Wed, 15 Oct 2025 19:57:16 +0200
Message-ID: <20251015175717.93945-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015175717.93945-1-philmd@linaro.org>
References: <20251015175717.93945-1-philmd@linaro.org>
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

All callers of do_load() and do_store() pass a TCG_i32 address
type, have both functions take a TCG_i32.

Suggested-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 002f921e00f..0fc8faafd09 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -708,7 +708,7 @@ static inline MemOp mo_endian(DisasContext *dc)
     return dc->cfg->endi ? MO_LE : MO_BE;
 }
 
-static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
+static bool do_load(DisasContext *dc, int rd, TCG_i32 addr, MemOp mop,
                     int mem_index, bool rev)
 {
     MemOp size = mop & MO_SIZE;
@@ -726,7 +726,7 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
             mop ^= MO_BSWAP;
         }
         if (size < MO_32) {
-            tcg_gen_xori_tl(addr, addr, 3 - size);
+            tcg_gen_xori_i32(addr, addr, 3 - size);
         }
     }
 
@@ -868,7 +868,7 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     return true;
 }
 
-static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
+static bool do_store(DisasContext *dc, int rd, TCG_i32 addr, MemOp mop,
                      int mem_index, bool rev)
 {
     MemOp size = mop & MO_SIZE;
@@ -886,7 +886,7 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
             mop ^= MO_BSWAP;
         }
         if (size < MO_32) {
-            tcg_gen_xori_tl(addr, addr, 3 - size);
+            tcg_gen_xori_i32(addr, addr, 3 - size);
         }
     }
 
-- 
2.51.0


