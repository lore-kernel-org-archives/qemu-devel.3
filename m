Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059B8C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmh-0005BB-T4; Wed, 23 Apr 2025 20:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmd-00058F-Gw
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:43 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kma-0004IM-9q
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so335560b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455778; x=1746060578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Et4hQDU8RZtHQwmfM7FlJplHHpRKrDTsE1B1A29z6gQ=;
 b=nkmCO/hjwltwx4W4bQxIyNBDzWdn+RYxGpprm6qGsAUvdG/GR5CrZ0CLvwF2Zq3ANX
 g34ZmI5EAdbsBpBlbc7SvHJtOGcn5MEjaCpFcj/QFxGqim6R/KQDWGaURQtTC/Gfsr7y
 iiFFcAF/Yy4nnPUK7dQu37Me1hMOOG1ociMJEGJ14UzdIfzhwoyEFu8TbXAYr+OseVcN
 biffyl7+l2CAPqkw5+g1dNT2K8Nf0s9++iy5BjnVjO1C/97GLzDVRzzdkqdL9GCZBUzV
 2y+HG3AoP8WAH91pxxx766zr3P/Tla4NqT2e97hUmkOvQxrf4dLMFX+jRo0uj1ZYD/4t
 JiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455778; x=1746060578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Et4hQDU8RZtHQwmfM7FlJplHHpRKrDTsE1B1A29z6gQ=;
 b=I1qEh4m4xD9H3PDws/nmDZg7n7Gv1m97BgkO7eaX0sTX02AFp2wSL2+H5shjTedZ/Q
 4La8zpkBL1mItxI48lW6QQv0xIDlWRV94K7L2CQM+HfqVJ2OZ9KMD1NbQyJGvL+vHsFg
 sxKboLPMc1aT94RO9dlUwbhH5QTd4hPMUTfJN6EzX9WNU/Fa8hi0eEkAoWwZjJi6GwdG
 H9ayxma+JHlF2byTBn8ADV4Q9Jo3EE0E0RxWKSF3fUj7Y7XXBFe/7HqYZkpMF49ivoCG
 gkRn0synHdUZTrryAnC8r8D/zTIGNfW7UXfnf8ICMvkyIJ0+sKx9Rut2mlQj01+Ef+nP
 m12w==
X-Gm-Message-State: AOJu0YxnrHf1Ezo4OphRZjgup7RwxUorNZhrgKZZ66kHwl3FroJ6zp3E
 zLPkOOc1CUAVsThF8ix2FU0RIkpgKRPR68MrNHrqoPVmsUJnK0RsFAP7cMPNfK9ksVJO95Ze5+b
 z
X-Gm-Gg: ASbGncvngB6AiIrb3sAGHizYscNI15NChWEQn6TYrbLL6GmEbMRBFZ7Jgwj+Vd05Uc2
 upxCGeMuNmAU6g8h+c4PBWOm/aEzzGIYuo9I9iplnCtAtwr1XUECt6k7D8oHFuobb69iv7hwG3Y
 MbGZjLpvzSAPOkfxq9xiGvrVmOFVkTz0iPsdbC4fMdjys8/wG+ZiaqYqladGe0jlksFwMf1JClD
 KQdsMyXGbRJdAL/gmAF93SkUA/iSKzym4FtWEdsmR/kM4mRXY0+P19BM5rnrLA1BFkT6NQEu/FZ
 mk+YV8dHFK1WoWj2JaP0//RPUiFaSHGFPuJQdj0o7xdhvb/xpYls5qBxprOyIk9aa9XgjjsefPY
 =
X-Google-Smtp-Source: AGHT+IHuqMjok47LKjI6hsF61nNqiVAeOpZRdZoTJ3Tet/WEPA2NkZRALEfDA08fqRRe4nyX3R92Dw==
X-Received: by 2002:a05:6a00:4485:b0:736:ab1e:b1ab with SMTP id
 d2e1a72fcca58-73e23ca5b8dmr1031887b3a.0.1745455778619; 
 Wed, 23 Apr 2025 17:49:38 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 005/148] exec/memory.h: make devend_memop "target defines"
 agnostic
Date: Wed, 23 Apr 2025 17:47:10 -0700
Message-ID: <20250424004934.598783-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Will allow to make system/memory.c common later.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-6-pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index cc5915033c..577f473446 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,25 +3138,17 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-#ifdef COMPILING_PER_TARGET
 /* enum device_endian to MemOp.  */
 static inline MemOp devend_memop(enum device_endian end)
 {
     QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
                       DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-    /* Swap if non-host endianness or native (target) endianness */
-    return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
-#else
-    const int non_host_endianness =
-        DEVICE_LITTLE_ENDIAN ^ DEVICE_BIG_ENDIAN ^ DEVICE_HOST_ENDIAN;
-
-    /* In this case, native (target) endianness needs no swap.  */
-    return (end == non_host_endianness) ? MO_BSWAP : 0;
-#endif
+    bool big_endian = (end == DEVICE_NATIVE_ENDIAN
+                       ? target_words_bigendian()
+                       : end == DEVICE_BIG_ENDIAN);
+    return big_endian ? MO_BE : MO_LE;
 }
-#endif /* COMPILING_PER_TARGET */
 
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
-- 
2.43.0


