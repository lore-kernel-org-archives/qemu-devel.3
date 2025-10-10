Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6527ECCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75Zr-0006d0-LG; Fri, 10 Oct 2025 01:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zq-0006cW-8B
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:02 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zm-0000R2-TS
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:01 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso964765f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 22:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760073712; x=1760678512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dkPBiJNXnSWqBCOZmrlfRJjTHIubzqAhRQ4khOG5q4=;
 b=bMEXp8/NjXIQPbV+OPtl7PP810Y0d3hz8IWtmZ8ogJrpeg9cgekQ36U1NU4yjLlQnJ
 Epy5LP4CkwcdsVTO43thHdF5prJ7/Q98EOApY6BTulIKH64P9SCyjeAswNpxSD37VDg4
 ihRYoIXW81UbpxkMhMFg1zLJJGvWPqsb3Ed+/6EPaUFVBEUDNjHRf3wiJhFa41f9heoX
 2wDl68wAXo8DdCHNSqj5glht8EuXzxCRVUUzAFQnyxJ3wUdFh8VSNqh0PqFmLZ02VCad
 tNECpqMdHu9Wd1UeaF+spBRgFl2Z6ylogq6BKteacMP04j79rkicMA9ifgOJD0Ml8ENq
 RYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760073712; x=1760678512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dkPBiJNXnSWqBCOZmrlfRJjTHIubzqAhRQ4khOG5q4=;
 b=fQuapVLiX2BUeWRQG2FPZ9cBfJ5hLxzoiZZyKT9hGdWGJ2aXO0AaeyfCL7dUZ2Y4Wp
 3vTn35YjZzChGZvkfwjJFsDgL9lHuqUpuYYDyVuAKui1moqTihdVQhWqTnkQH/woSB7f
 oyCjWub5SirVWT65q12ptCP1NcUPc2gWi5vUnxoRl8bjd2jjB7x53KXNc7pcWJizOm+6
 reLLRGAtpMd3Sl4NqPGUibDM92XzdCE+EvCg8CsnWpsAErpulB5YluuiTil7vJGikQW2
 NoG46WCE75AMonwMWw5JU+LRp2+UHUG/+jvh3MVbMjlmkvM/ZDL7Fw7n6rbzJqN/5Hke
 xoYg==
X-Gm-Message-State: AOJu0Ywhf9CiN9FZcfmWOAu45HSJJmvgLKagMUnvejxfY1g5BR0o0DuO
 RpMNWgvqXKlU0bKkh8Ta+BkJsPNyLNveOfOOBkMsP4NKmJ3wGgQxDC/MckcQUzSW08VHab021DF
 SVe97zv5GJg==
X-Gm-Gg: ASbGnctJtDe45E2R8xpt/bi3Uj4N/Xhi7euci6f47C5xEl2uCowL7g15IngpolLzzBz
 fFbiksKYUzk8WkRpne81OP979xbgY53Yhtb+mrZZrKC00pLsUYF8VBHpRo1vLEFa2te6A+Mmjh4
 Z7RsHGNoPIQl48F5JNpey+90vn3Y5wDb5H5Ok9SDp3L2DlVXXQYV5jJ5ZTD9kviMNcKzZSIbmA8
 WKj3N8IHQ3IpkaxiJCnmsNIMRuAGO0u4lxsrSK9dXNvlrDr4BE1NijVBOYuF6klw9F68drHxxyq
 PGzVqAzqmr9yFsOVltY81HsEhrBVeWQHsnNZcJjsLdNvJ+0+A+D/7QgdOMncBlS+PfHj8T0Lp+t
 ezTKlVKy03NapoVrpHYt/ZYRl1CUV0AsGWJ+J5tZdnpqUBZmo46JFmIb/s5be7z7zwQm5ZVbEqA
 N7Abi/2q1nHKX/Md/rL5ZJUmezdT1Gqg/pCos=
X-Google-Smtp-Source: AGHT+IFc9cBrDo5ZopAuiqv4MO4IniHXVg4g5ugNnliERcuu362/Vr0BsdKfwXKC5M4FAmQY/JGBKA==
X-Received: by 2002:a05:6000:186f:b0:425:7134:edd0 with SMTP id
 ffacd0b85a97d-42666abb2cemr5138081f8f.9.1760073712535; 
 Thu, 09 Oct 2025 22:21:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d447sm2346957f8f.9.2025.10.09.22.21.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 22:21:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/12] target/tricore: Replace target_ulong -> vaddr with
 tlb_fill() callees
Date: Fri, 10 Oct 2025 07:21:30 +0200
Message-ID: <20251010052141.42460-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010052141.42460-1-philmd@linaro.org>
References: <20251010052141.42460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

tlb_fill() provides a vaddr type since commit 68d6eee73c
("target/tricore: Convert to CPUClass::tlb_fill").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index e4c53d453dd..7574111c87d 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -35,7 +35,7 @@ enum {
 };
 
 static int get_physical_address(CPUTriCoreState *env, hwaddr *physical,
-                                int *prot, target_ulong address,
+                                int *prot, vaddr address,
                                 MMUAccessType access_type, int mmu_idx)
 {
     int ret = TLBRET_MATCH;
@@ -61,7 +61,7 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 }
 
 /* TODO: Add exception support */
-static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
+static void raise_mmu_exception(CPUTriCoreState *env, vaddr address,
                                 int rw, int tlb_error)
 {
 }
-- 
2.51.0


