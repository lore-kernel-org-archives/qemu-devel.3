Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7BDC02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfOP-0004Zu-8Y; Tue, 14 Jan 2025 06:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNr-0004L1-Vw
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:47:00 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNp-0006en-Kb
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:58 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso37872245e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855216; x=1737460016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlXy29NBIjMy0Rkry+U475eKhew1JRy9bb9HkntANSQ=;
 b=vcPlaJayrxfpEIR9045x41G47YnosYVkn/th6ipYEfIPReh9r7Z88Z6p9jnPzfyeLK
 02rrqJnzIylJSxbk+Eh9H13b0b1zuSoTka5vtw/ge7mUCTQGrxOkANWxAUB3sBnmgFoT
 RIaFi0bxY2sbUjZS9m7PWkPRJoZgWtkfB0k1bROymj9RipVvoXh36pu5t+lynUCo8ghx
 pBm7LNPbr9tfixR0AdI/ToacWHaaHZXi596D0a1v943TAevz4NAgNaxT2Zb0P0ReBsHC
 WG9ChpmrCUliRiao8FrEn6VG61lOYlYOsacyWukdfOdVkle6/YKqrUaFEEGrL8Cxdrdt
 MiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855216; x=1737460016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlXy29NBIjMy0Rkry+U475eKhew1JRy9bb9HkntANSQ=;
 b=gnEQSr/E55Kgtr1eKaox0MJqEyGSDDSJeaF6QZWUCq/z3ifRw7U7yFDvMN8N0s6ulN
 L4hMRWff3BpT7n5Rtljc6Cc9OJPV3gM51xTp9y6IihinGC1ta3dPRJZWSmePPq6ZtFBA
 hfysaLPKE923s5sa3GnxSLEz3vgIQ3BHi9kCT/MsnTiWrat/d6n6tdQnXVEjlv75cBpr
 mV2qEjS5l9iyC9Jraqff0PXwT+kgGrjoKlgaqvHxXIL7wew4ceZS46Ov4YpiyfSII1wc
 oe8WeapKAANxvqPvbz0Y5kHy0FZps6cXDzfOhDfCy69ZRNBcsWOnGSPpbwjKE28hc/2m
 LNiw==
X-Gm-Message-State: AOJu0YwhkG/5tT2ECvJd9PYo/5GrWXBDGbazdJJraUTb4ScI0UVHVZwR
 TPNMC8/p8Prxdvioh2SBVX36yjznGsvGAF3ZzJJKkZPS71kj9sthGcbVN08BIF0=
X-Gm-Gg: ASbGnculVy0po9knjC1itRTd4Ds5jkwXi7RfHFnn0fxnqG5YBJdM2IFBIkZJsF+vmqE
 xUVtohecLKHlXRfBM9MB3zJvhC91DpAalizG5cuCkmX2JINbt99dQhENrJTfrhf9SGdKZ47E5Dp
 Vtu/cEJRdaM2iEhzUrHmmCM2ogyTeneHDi0FPe6y2i4sZJff/pLl+qqBc1LCQ8e3//vWNLa7Pp7
 qLR/EiqkFYiEh5xEUjMkLnIb1p/btSkh8PAvHXzvvusiMvVaeDqNoA=
X-Google-Smtp-Source: AGHT+IHgP+6HBHh6uDwG8QKhTqvCm7FzNbhJggUy3xFbODg6HBJy2dDXCDJ9Cio2bcEfS9RNitwEyQ==
X-Received: by 2002:a05:600c:4314:b0:434:a802:e9b2 with SMTP id
 5b1f17b1804b1-436eedef4damr146977385e9.4.1736855216226; 
 Tue, 14 Jan 2025 03:46:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89df1sm205860075e9.27.2025.01.14.03.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A122F5FBC0;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 30/37] include/exec: remove warning_printed from
 MemoryRegion
Date: Tue, 14 Jan 2025 11:38:14 +0000
Message-Id: <20250114113821.768750-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Since d197063fcf9 (memory: move unassigned_mem_ops to memory.c) this
field is unused.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 605687befa..3ee1901b52 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -784,7 +784,6 @@ struct MemoryRegion {
     bool terminates;
     bool ram_device;
     bool enabled;
-    bool warning_printed; /* For reservations */
     uint8_t vga_logging_count;
     MemoryRegion *alias;
     hwaddr alias_offset;
-- 
2.39.5


