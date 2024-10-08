Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5996CEFC41
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJW-0007Tg-Rn; Tue, 08 Oct 2024 14:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0007Qr-R3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:00 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJL-0002S8-AZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b833f9b35so52365595ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413505; x=1729018305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOn9FQKnsFqqK8dvmrqts9k4e/ZA/rwyYeo2+pg72XQ=;
 b=YlVD4yWS0Adj4ke/Vz2TCJVjSDPbZ0DWWjhmUzhLIjGy28b9IgbUNpYfZChn4RAwSi
 nz/SF/NWB2EqXrwdKL3al0Rwo/Yp/2Xwdk1FJiry0ejWA3yM0iKPXwD1dl+pmRUhJuUB
 F9qaTOQ/b85hiKIlAV3P9vmPGGvH2eSHdfRqSP/kO9Q/oQu/3I391sxkw3hzDC2+nG58
 4FyPJqbpq0aE6q6jGTFkeM76LKPuVK0xQzhbgFOB+LItLAfLUR+sutzz5CuU3mlXiJkm
 eezbCt8U4v5WyDpAn+M0JtMmZLxav8iSvSB50lo9RDs8VrVVkMKehYYiwPTtpfxP6B0r
 XI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413505; x=1729018305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TOn9FQKnsFqqK8dvmrqts9k4e/ZA/rwyYeo2+pg72XQ=;
 b=QtnVdHj+//FGJN06mCeydEPhnA7HI0IoaK5K2haRyCl3s1q3mtGmZXL/9/itDFaeVC
 9bOqfWKBiJxdaXfkZwOy/Y3JnkItGNzzFPf7rAjhpHX/zVEcdKw+GvohRYXjbg8tioEr
 PDoJufADBDZQpJVaClpuTgQhhbS5YFCY5KGTIKo8GIKFP0pkGTHLoDm2pkHpXRmiVLF1
 6QfUpfBQboFcHZwgRjMvJR/OnUXXQywNSL1GnJGSMrEcIMyBJZrTtSj2d+U9kwT2gS19
 c8MWY1n/Ktk5402EScnCDcEbqYMQJecvAuVKRC6+J5ySlcIBI2xPoRCvo4ZDJBL15zEF
 kAAg==
X-Gm-Message-State: AOJu0YzvnDR/u6PXN1ncUVZdnPoEo2pfQ5+TbVJeSaOmWQ3K7iMkad1/
 XXSISp1AAyI32xTBuW5BaUMfoXd24LzDgVi9XuE5eBoQHT/svghCwiif7icvCCPvn0WznRZrLeM
 q
X-Google-Smtp-Source: AGHT+IFOv8diGM21FYv9YDwizxS5s028Hi+fU2TCwgadH+mZHg6bnJk/BU1A3/rPydAYDPtDqSLVPQ==
X-Received: by 2002:a17:903:2289:b0:20c:61f8:f45d with SMTP id
 d9443c01a7336-20c61f8f6admr6163045ad.22.1728413505243; 
 Tue, 08 Oct 2024 11:51:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 02/14] linux-user: Fix parse_elf_properties GNU0_MAGIC check
Date: Tue,  8 Oct 2024 11:51:29 -0700
Message-ID: <20241008185141.20057-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Comparing a string of 4 bytes only works in little-endian.

Adjust bulk bswap to only apply to the note payload.
Perform swapping of the note header manually; the magic
is defined so that it does not need a runtime swap.

Fixes: 83f990eb5adb ("linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2596
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/elfload.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0678c9d506..52c88a68a9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3121,11 +3121,11 @@ static bool parse_elf_properties(const ImageSource *src,
     }
 
     /*
-     * The contents of a valid PT_GNU_PROPERTY is a sequence
-     * of uint32_t -- swap them all now.
+     * The contents of a valid PT_GNU_PROPERTY is a sequence of uint32_t.
+     * Swap most of them now, beyond the header and namesz.
      */
 #ifdef BSWAP_NEEDED
-    for (int i = 0; i < n / 4; i++) {
+    for (int i = 4; i < n / 4; i++) {
         bswap32s(note.data + i);
     }
 #endif
@@ -3135,15 +3135,15 @@ static bool parse_elf_properties(const ImageSource *src,
      * immediately follows nhdr and is thus at the 4th word.  Further, all
      * of the inputs to the kernel's round_up are multiples of 4.
      */
-    if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
-        note.nhdr.n_namesz != NOTE_NAME_SZ ||
+    if (tswap32(note.nhdr.n_type) != NT_GNU_PROPERTY_TYPE_0 ||
+        tswap32(note.nhdr.n_namesz) != NOTE_NAME_SZ ||
         note.data[3] != GNU0_MAGIC) {
         error_setg(errp, "Invalid note in PT_GNU_PROPERTY");
         return false;
     }
     off = sizeof(note.nhdr) + NOTE_NAME_SZ;
 
-    datasz = note.nhdr.n_descsz + off;
+    datasz = tswap32(note.nhdr.n_descsz) + off;
     if (datasz > n) {
         error_setg(errp, "Invalid note size in PT_GNU_PROPERTY");
         return false;
-- 
2.43.0


