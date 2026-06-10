Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347CACD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXR-0007f6-Lr; Wed, 10 Jun 2026 12:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXO-0007aZ-20
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXM-0005TO-F9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45eec22fab7so3608120f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107935; x=1781712735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T91pk0gmi1pwKkfRCIUIQYRIgRBTfic+uUkQXwk6wK0=;
 b=VacK5dkENr2Ffb6VDnweToAMd3uyfgbrQ+wF0y4dLXVVY5lx5g/IvfXG29Gr0HE4Uw
 NUX0oQMZ8HEuPdUXV495bPN/JgvGEO+1umDJxtSwPIxIW9WeFwe1aXav/mx2De16zbwO
 +E/3rAtrek7PY1DqP/Cu6l5Sh3fUHQlqihsgVUeBf4XUVHu1NguYLASIVxItiq3Qqp0S
 Eoq489GcSZj3NDNwvteNVJ5GnIUSW7DayOX55E374heyxSF78E/7TDsTbGZIiVAuKBaq
 9eY/dX5f+945St2n15M+bI42GeBp+cLOnRaUbuFsZaDfD8IJBaP3uiIdSZVEAQWoZaT1
 qHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107935; x=1781712735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T91pk0gmi1pwKkfRCIUIQYRIgRBTfic+uUkQXwk6wK0=;
 b=aD/AFLklteZ4Q5O8K0JV4NmsvEbJWQLjVaIeOi7tu2FwsNoYgLvOCQto2Tx46pa250
 BzSnxod35jLNuq962Nv389tnVxtUiwHSNNP0fHXrUvdklZrpAimcdpBfgOqI2P02Hh6J
 yg4zvTPrSLQTP4hHah4txqW31OtUzju6q56k5dAw9o2HlohzR+4c1YEPeb031v3XscOr
 dOXiMRxQFJHAYiQWXu8DeQhz/uuLoZ0Sl10cLgA8jzEEtNbaNoTqYsHZsen8xcPOBFQE
 VGrNdJWkLOoY/7bW8+ToQKnNS4cWKXHh77HuKJH5qhlKszXOnVh9NXV+jBgqFOSParQL
 6u5Q==
X-Gm-Message-State: AOJu0YxvGHvXOejw6uY/us0wZcpVPp1ZiEdHIBBFcP9nAT/qM3tzKcej
 fjhcKWHZZ4AUYCw15k/tYWFYUewffBzwYqAoufPASu+KDhsE177ZYLg8rCGiGldolzX8mk9L3S7
 4623I
X-Gm-Gg: Acq92OFJDagkAA5ST4KwWs+GgHPCkNewn16yvYBbupFgKNS+qnEv5H5atXtDvSnx618
 TCA3a/L5jBkfhIdzPhB3oFQnDowYuR5slyYuP0eS/LP7DMRG+1NPnYgXom0Y+CZJzWYPI3a8rQC
 lOO5AZVuKvbu5b12VRdmYZ5sQf3w9EbFL+Qqc6fDHZ7fb6bgf+rPZYnaSC5+CK7loaabNWrZDsb
 34jqon0GyFhN5iTbqo0fB45ZjnWmgvnWVscHkzT18sd6CPESh+FMaEqlN8U8H+W/vlftwVhAO2X
 sS4el4sLNgUvE31zatlcXzTAyZrByAPMmWyFqjjQluzBr001SRtg+alktmIV3TfIRitqxPSzCC5
 h/qpguJbdj9H57IBUbdGT6gaCllOKxpV8/52sQHaqf3rSlpKrQN137UaY5gYhauCTaITGamWfIe
 EoFfi/AX/OYQJ4guQmzRfz3ygQxCiWCw3kv1ZmrpoyQQ6srckiNZeqw6P6Y9UIeif4oZR5Ifztm
 4p7H1bRZ84lkA7XR09QzZiCTXIzGLDVm6xkRriyaiw=
X-Received: by 2002:a5d:5e09:0:b0:460:194d:8df2 with SMTP id
 ffacd0b85a97d-460304eff44mr44357893f8f.3.1781107934745; 
 Wed, 10 Jun 2026 09:12:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/71] target/arm: add canonical tag check helper
Date: Wed, 10 Jun 2026 17:10:59 +0100
Message-ID: <20260610161202.2235298-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

Add a helper that checks whether mtx is active from MTEDESC. Refactored
an existing function to use it.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-7-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3b60e4a469..b91cde1795 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1665,6 +1665,12 @@ static inline bool tbi_or_mtx_check(uint32_t desc, int bit55)
     return desc & (mask << bit55);
 }
 
+/* Return whether or not the second nibble of a VA matches bit 55.  */
+static inline bool tag_is_canonical(int ptr_tag, int bit55)
+{
+    return ((ptr_tag + bit55) & 0xf) == 0;
+}
+
 /* Return true if tcma bits mean that the access is unchecked.  */
 static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
 {
@@ -1672,7 +1678,7 @@ static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
      * We had extracted bit55 and ptr_tag for other reasons, so fold
      * (ptr<59:55> == 00000 || ptr<59:55> == 11111) into a single test.
      */
-    bool match = ((ptr_tag + bit55) & 0xf) == 0;
+    bool match = tag_is_canonical(ptr_tag, bit55);
     bool tcma = (desc >> (R_MTEDESC_TCMA_SHIFT + bit55)) & 1;
     return tcma && match;
 }
-- 
2.43.0


