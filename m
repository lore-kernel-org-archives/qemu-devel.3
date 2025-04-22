Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104C0C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIH-0002Pz-Uj; Tue, 22 Apr 2025 15:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIB-0002Mr-VJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:28 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JI9-00069J-8j
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:27 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso6026951a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350104; x=1745954904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmB2RGOlub2fPYdxrxTTavElj/U2fFDKgCMPXIFHMg4=;
 b=c0bOymHvbf75YEH7RSFbXbJ9DSrjdnwr16BbyYqoOcYaMtcZPL9SEiFLTpEouLeacv
 yGZLRoHXmYsuIIad0ytQQlic88e9YJnT3zdAxJcMLEE/UxSeV2fOf97NwC+g9uEga3Ra
 wxFsWuuRiyu0jUJrblMnMblMnxhhzUcXteEJJWBd6krddh5ZKvNhLVpFlYOHTKCSqMPy
 EcYBKTOsuaVhLqsUru6zvHZOOioqp3JPzpTkBNQNCumbec+1HsSFLA3DQ3s/z4gKYT2f
 lvL8R1P9rs3tgk3CydmX5RIh81Wx7PeFLoUHSDv9eTuOq4X1NW137GMJVkQA3yydFmmS
 nseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350104; x=1745954904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmB2RGOlub2fPYdxrxTTavElj/U2fFDKgCMPXIFHMg4=;
 b=NLIf3kG3rgCxO/pqDJuZE2dS8+RCicfC+XRRn5pHi0GJ3kTQ6HYIsS7qPurDjsPh4s
 FImx1eNBp5zcC/hp/i1G74TR5zZ4cizxJi5VAFe9SPtHepG7wzUlb/EP1ZSw5rAFRk3K
 IyL490yvCgPCJeefWpL4f0Y52oJCHloIKYsyKlF6He34E3hF8ZShCwhvODtjgpHPt22D
 gS4ScDWOQ5dl0ijvY/Aa+GbBULsqt6KygRIfuKlXLlVRWmvz2lDNh/LEefkT2u3jGwms
 Qiv2G2n2Wwxe0W/7D/nk4s/yjmClR3VpAXFH84ZLMi/aiA97wzI3gxUBaMElKmSu9cuZ
 sdTQ==
X-Gm-Message-State: AOJu0YxvM/ZNcw6xnDBN0hPCmi+iY681yFbY3hpgwNRI73JwyTj7L+iK
 GOyuDpEyoU+wh9rg4y+XxyHZn0OQwcnVLwCtBaQg+OHoOYxTuJBRO5oqqLYcIhSlEMpPWJHU5m6
 q
X-Gm-Gg: ASbGnctrhQi4eVboXHPLjNul3dTHrKAzZvzSBT08vdzgSyf93xUsy4tssy3RuRyyR9I
 ss/72DXbjI96osnxHTlmbBDlE84BIxGzm80jALQsQMPtZg68XH33Qa0GYhIqJQwvP3o5ewcyAOR
 LIdWht4tVHUxAoNtnDPdGbThYNMQlasJcV5cXpVgygiNKzhHZLn3BnsKinxKTq4kznQyxumvchu
 9XhiAUQip2yUmCO0JlRw0fMDkzvXB/cUyiapUMPQ0vlJxBprQoeSzSTfTF+rc1zuf4C6gMAif8H
 C6THkjlrfRP+RiHps+DU7m/+z9S8cjOIWs9Rjof8jPzyayhw6dYFdjmaAqy5ozi3qi/bblnfglM
 =
X-Google-Smtp-Source: AGHT+IEGtCa8No7gOZqUzSBnqKtLDYNYb3K08bWkrpXcoxABJB/+Xh1p4xseWjHoeORnzyRzudtEXQ==
X-Received: by 2002:a17:90b:4ecf:b0:2ff:62f3:5b31 with SMTP id
 98e67ed59e1d1-3087bcc8b16mr22971780a91.29.1745350103934; 
 Tue, 22 Apr 2025 12:28:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 005/147] exec/memory.h: make devend_memop "target defines"
 agnostic
Date: Tue, 22 Apr 2025 12:25:54 -0700
Message-ID: <20250422192819.302784-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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


