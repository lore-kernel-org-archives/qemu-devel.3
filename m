Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2845CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnn-0001e0-8E; Tue, 02 Sep 2025 09:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnS-0000w6-Hm
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnO-0004YD-Ie
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b7c56a987so17023685e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818687; x=1757423487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kGjnx8sa3UdmOsmMC3wulSKg+FS359C3SZlRz5oWwLk=;
 b=SouBM6u30/Pf1ne1Q8CrPhE8ywQ3r34Sp1V8ffx3nn1lWp2BShza1P4xNkQgkS51Zj
 3RX4TSh3iSlnLCavxQ2mh0CCSe9jI20/bItXpgjoJ4HgwxnZ4fxfaQZ+twjuMY7AZF5U
 JHkXvisIwt4cMbjeLtJUW23IlBVLfeE5159gKEi6HhbFA5omd2zdKsuAt0qs6+LrTE2q
 A827Rx4Zn6WTNKup2w19tNXCd9jWhEZITRc7nM1hm+EzoxK3fvrguMTN1tuqY7kkykxf
 VO0VhdHLMz2ow9fQDB9vd6Qx09MBNgQ2OCXX3+4KeRSQXhlc2zbcnDI/aiJ5hDg1Ykrx
 vyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818687; x=1757423487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGjnx8sa3UdmOsmMC3wulSKg+FS359C3SZlRz5oWwLk=;
 b=wJjKuDu9RFoZUjsyOjnlS5ki5YUTEO0Bp8tkLUGZpONQGbctUCLwlBoSTktza6sWD9
 rw5ICWvljqZhNAFVQZc+fORaaXFUgKfnTAf1++4MITb2VsE/3mbDtOuhddcBJM54ieGQ
 yfSHJKKsUKoe01VwCIEi1X+JV2GKHNS7XMgC650w57REdnW+yNNkZjYL9loCubZilrNC
 drTn1H8CzMGh9sBDk4zG/a0US26qPjE4oEBKUaAzC8hKGrD5txSip9lebQoEzPhPz7Pm
 d624mG/ZXll1Go8Osvz8lKrT99bXybpLvozbmaJD9VMHFQcMAkbutXId3VKGlyYuJV6l
 2ogg==
X-Gm-Message-State: AOJu0YzfiK6mmriAdXln18jOh1ELnFoQ+JpymKCg7/evNdOXr7JOpd39
 MQmxVU7d+meGzxZa4lMJ4q1XO35gJo9O2+LSxLmaw29WJDvcW72ll+AXpfNYUCXb1TkO4hJWUlB
 W0WCk
X-Gm-Gg: ASbGnculpuMwe5OevFKixP3tOewYr5RWLmpivFD+vsue1R3z4ijKv4R1iRDAxpixfCB
 0fIBj3OuXDdBpuzLHLLs8bv/SC2QXpAAcC3DBINvaFOMZsjKQH3L1bTrxlxvm6McBxav29qTl12
 6MCIOoChtpk4CEsacZSawvw75dpK7DMAqnpooKwYM2QE3EESJJvo8yv9OQQKOiaT/7eaVqdK0Xa
 H3Sy98+OanNxVkupgUDLG/FuUc7p2RTJ38da3GCBiZt+gu9A0q8khbFHBHJD1s+yqNrIEDEQ+zA
 Z3H33WNPCXIBlLvrEIxp8eXmG6eBp0mPr+xq7zXZ0Uhlmt7zDdfvK2QKq12H3tCe6JCxwcL4A6Y
 q5Vrf97GnzeGYYvZ3YmHzfmOOTRmLT82W7HRRE1+I9vo3X6o2LL8STmJHHEIQD09U/QWUaSzqhf
 dlyjTKq3mUdgE80tj5dA==
X-Google-Smtp-Source: AGHT+IGiN00Bd9Ei5ZwOe2F1UfbtRhm/C1Yw/ekp3qZveCcvRQH1UDLJ4dljFidO4SJai5eRJEPKQA==
X-Received: by 2002:a05:600c:1d1f:b0:45b:8f11:8e00 with SMTP id
 5b1f17b1804b1-45c055e1774mr3716675e9.37.1756818687350; 
 Tue, 02 Sep 2025 06:11:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b87abc740sm131778315e9.7.2025.09.02.06.11.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/39] elf: Add EF_MIPS_ARCH_ASE definitions
Date: Tue,  2 Sep 2025 15:09:52 +0200
Message-ID: <20250902131016.84968-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Include MIPS ASE ELF definitions from binutils:
https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=include/elf/mips.h;h=4fc190f404d828ded84e621bfcece5fa9f9c23c8;hb=HEAD#l210

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250814070650.78657-2-philmd@linaro.org>
---
 include/elf.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index e7259ec366f..bbfac055de4 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -56,6 +56,13 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_ARCH_32R6     0x90000000      /* MIPS32r6 code.  */
 #define EF_MIPS_ARCH_64R6     0xa0000000      /* MIPS64r6 code.  */
 
+/* MIPS Architectural Extensions. */
+#define EF_MIPS_ARCH_ASE      0x0f000000
+
+#define EF_MIPS_ARCH_ASE_MICROMIPS 0x02000000
+#define EF_MIPS_ARCH_ASE_M16  0x04000000
+#define EF_MIPS_ARCH_ASE_MDMX 0x08000000
+
 /* The ABI of a file. */
 #define EF_MIPS_ABI_O32       0x00001000      /* O32 ABI.  */
 #define EF_MIPS_ABI_O64       0x00002000      /* O32 extended for 64 bit.  */
-- 
2.51.0


