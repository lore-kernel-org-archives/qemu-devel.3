Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE7DEE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzV-0002Mu-Gm; Tue, 30 Dec 2025 16:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzJ-0001v0-96
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagzH-0002l8-Mu
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:40 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so108923115e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129037; x=1767733837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mUsD1NrQKJS1hhbZfGXfvt9Z6Ms3MhVNlf1j+nUs6zo=;
 b=PSGvvUIbD9LQOpFoacG7yiEkX4XQNQpaEa0HaHW8GzkbKYdz9T3oXrj7WIxiXQaX/o
 Kyq53Hhza+G04HND/XiSjsaBnovN0Jzbm0CyedYMopH+FblfsjGK0F8HgYe7SvJJfpzr
 w3wfwCWe4j0VzA5xq/ehnPhfrH6odppn857EXP1jPaUHA9UyvhUG/GqSSd179vnc4PCs
 EjpLnQZqVQIwA9U8tOPzD6CxWZfpHovuzBtvc8vkb64y+bla0rn34trEUwnV19jStrXH
 HPFrTfKU8++fpaVN171QJlM3NLVqdlVaEgq5oBuOQrU/PBmb/nueQEqe4bvTrLc5T6ao
 0MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129037; x=1767733837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mUsD1NrQKJS1hhbZfGXfvt9Z6Ms3MhVNlf1j+nUs6zo=;
 b=KgaIEu1dzcsqvz/csJV0YCuyKYmFHHDjMc/EuSB8kWqHY1wHhr0o3hfzFTOrdn2zlz
 1lWcBVInCjsOFpclaJQhHqRqRk5fANRqNunzEHewqPvhh1M/JlHkaIZz0LcIJyobK8JE
 /2KZjiRfpQGKTjaxBuT97wfMe/85SkmSXDSEJ6qDYyyHA1hId8vQ7nNBcEY6Zt3THVsd
 odHU/gpZ2lPy+70xeBkA5+XWx0ngfA5VPqa8qN9LAntEZMQ0XxNAjrjL44pNjFTgJMuG
 VoEzMynkDYZCzfGvARpOfZ9q4wM7b1yfn4uXFuccIrHCn2hsCam9cA5DKfbF/EYdglAd
 u4xQ==
X-Gm-Message-State: AOJu0Yw7yFA6hRS+TN/b83Nt6ksaGuzHwBb/uK4rM3ja0PQ/4+1NNJIh
 0JVRhzVHHQ6QRaj20oiihRqDPtKpv5PijEG0qYB6mQl9R7gxKUjtripiOTbOTMO5OE1Sc7anhQJ
 nfndSU6g=
X-Gm-Gg: AY/fxX56tCewKN7pnwIBbjXUpILxUCjqEQz3sHt9FU+0S4UNOOqHy/YaI5kMJ9l+kMU
 G3JuGpwBg/dwIyW3lHrhjkhwOjqFTsLTF++Q/d0tJ4I5ZNNpnNVwkIWboPZeAxeykKSxhIHfuza
 nCMBQt3B6KRle6DxpiU6I5TBuMZ23yMLqd9Y8u43AqltgwFjejGhOSVteJjG1ZSY3ZuNDm9DRkW
 DhfojLWMaqrYxlkUDzElkVlkgpNu06+ycBjKHI8K/pTnZ6MYXlI1gcNeo12NHuQMRoI5voMULvl
 rZ1KXSRXbPFBk2LjQrnlA6zlQ9lSLyFSZxb7aaBNFRX9B8ZeL/nxdi2PK757GFioIANRewjxdQu
 Z2q7lwubssf8ciFiAEoNJnfOfSiajf4Mj79osVqr6+GznuNLSpgBcakfVj2RROl/Q/J5tp3loYI
 57uDC3iUze5vcAVYnxs54UKIlJ5ulHU4TaTmKSpv5QjBFGaMqf2gXVxgRceJjm
X-Google-Smtp-Source: AGHT+IGF9dRmxN9jdO3HgRa9+cJlNfNFy3ys0DYLm8wF4wk0fCB2JheVWD/Uvdhun+oH5L/+h9c9yw==
X-Received: by 2002:a05:600c:4f4a:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47d1953b79dmr463595425e9.4.1767129037290; 
 Tue, 30 Dec 2025 13:10:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aa9971sm259124825e9.13.2025.12.30.13.10.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:10:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/34] system/memory: Allow restricting legacy ldst_phys() API
 usage
Date: Tue, 30 Dec 2025 22:07:46 +0100
Message-ID: <20251230210757.13803-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
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

Commit 500131154d6 ("exec.c: Add new address_space_ld*/st*
functions") added a new API to fix a shortcoming of the
ld/st*_phys() API, which does blind bus access, not reporting
failure (and it also allow to provide transaction attributes).

Later commit 42874d3a8c6 ("Switch non-CPU callers from ld/st*_phys
to address_space_ld/st*") automatically converted the legacy uses
to the new API, not precising transaction attributes
(MEMTXATTRS_UNSPECIFIED) and ignoring the transation result (passing
NULL pointer as MemTxResult).

While this is a faithful replacement, without any logical change,
we later realized better is to not use MEMTXATTRS_UNSPECIFIED or
NULL MemTxResult, and adapt each call site on a pair basis, looking
at the device model datasheet to do the correct behavior (which is
unlikely to ignore transaction failures).

Since this is quite some work, we defer that to device model
maintainers. Meanwhile we introduce a definition, to allow a
target which removed all legacy API call to prohibit further
legacy API uses, named "TARGET_NOT_USING_LEGACY_LDST_PHYS_API".

Since all targets should be able to check this definition, we
take care to not poison it.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224151351.86733-6-philmd@linaro.org>
---
 include/system/memory.h       | 2 ++
 scripts/make-config-poison.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index edef51a276d..0e8de527d36 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2855,10 +2855,12 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define ARG1_DECL    AddressSpace *as
 #include "system/memory_ldst.h.inc"
 
+#ifndef TARGET_NOT_USING_LEGACY_LDST_PHYS_API
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
 #include "system/memory_ldst_phys.h.inc"
+#endif
 
 struct MemoryRegionCache {
     uint8_t *ptr;
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 2b36907e239..937357b3531 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -10,6 +10,7 @@ exec sed -n \
   -e' /CONFIG_TCG/d' \
   -e '/CONFIG_USER_ONLY/d' \
   -e '/CONFIG_SOFTMMU/d' \
+  -e '/TARGET_NOT_USING_LEGACY_LDST_PHYS_API/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.52.0


