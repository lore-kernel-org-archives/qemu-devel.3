Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4DECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoLY-0006Dy-CM; Tue, 28 Oct 2025 14:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoLG-0005wr-Ni
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:22:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoL5-0002mB-AF
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:22:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475c9881821so1220755e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761675745; x=1762280545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W84UIv/lTOoO7nPMc2XCHCkjsy4aJN+uqWbkHrcZ9FM=;
 b=caaGyTTpavepaS7GhXnulPvqJuDaMyYkgV5A43NAj5A44HJFsF9LC2W6MzOZyx1cAh
 5dRfusbJkIRP47a7ECBfbrySRcKJ8ptyuL2W3YVP31fMgazfEpcG/KPcDzCvoP1yc+bc
 ruDbS2XYBtcC3LhKfL7HnHXIzsIcs7XhXP+0PLn5xOARNYc6tum8Y7AGLwtJBCyrA57c
 BnPiuo3KYGZwLO5RFHLregi8EluDaF5/KBRYQdMsqGx95GWJOZqpv9MnDCm8vsaJX8cv
 nN5MahEKEC00Utl3QJ8lTk9R7wfr4+kRTX0Guqrlzp5EA+Nh9qZC7mBQpky7ZGsYaerr
 nY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675745; x=1762280545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W84UIv/lTOoO7nPMc2XCHCkjsy4aJN+uqWbkHrcZ9FM=;
 b=pyqjuZnvBHxkvcSX4dNBNF+1PqxTKhlq1GIA6P/0XXvKEWiLKj6kBJHuRWp/rMdgOR
 ZtuEF9tSQGbR4WzD2ozC+NpJODIf5dGCpG5QpkszU2iPymsGFKBtanlE43+nx5O1HzhQ
 jMS8EtRLzq5PK+nf9Huo9TFJ6YQJy0mGa82TVqdcRCdiunzsHsxNT5ZzRMU/km1nqLLr
 ypmD6ThzPBQTr5ZpReWECO93PmhQD2VB1rrhDpgsXnNxkQ3e2LfEACfDik4blX+H2V1s
 rcSw+xdkFfN61Zv/8NH6gkXuW3I/BKyuFlJDg0AqTvQOhCfrCopIR6soSIr4tWHCMC8j
 v0/g==
X-Gm-Message-State: AOJu0YzTYQgepSpdKT2Xl7O+XlIhznesUwTRO0BXaw3o/c0IRirWJgd4
 pz3fquG3gAxCCyFIHOy3jw29y0vzt7PpD4G4WvEX3hfWJ0PpzQBWYEzOIUwL+vaftjBapl1zFI1
 A3iWw024=
X-Gm-Gg: ASbGncsOEEOC5U26TE5rQLr+CR9+tk3zDIlmCju1s7RuZlSvlOXaoJotXqnmYzCH+KD
 ZixhOC3UznfPA3CdKf/cMVVRYNQy2effLGpvn5aR5gE5E9zSl1DeS8ZW1Ji+YRresIp9BMfOwye
 nRJtf7/iM873v/km+9zSAFakj7SYpnKe6nVLKM3FNNglUHcbyMM/aqh7o3BpUUwZU4e55PGe6CL
 DDq8wzM2/ovKOliEfU4sdZjdBzFAM9nkubK/9qeQtP2FDUJWVbCxsswHbdK/6J9Mgf3iFjMgu4m
 9etF8xuYS6SFceYVCrX1tzNN8OesaDZ0ziDBNvXwZ/Q68ZQ7uHXVNoSFq38m8+i/OIGfdKgDYn+
 ZwnzKdLh4yPCJKFVwG15gyiXz6oqhHwi3CFRd3g8F8IbK7UkzYR/GuAtmlyDYzCxyhYfdnPT43R
 kcoMYDkROttZcK0VunCZOrtZdLVBCcflr18+ZnpGOSmyRsyAdfSQ==
X-Google-Smtp-Source: AGHT+IHoIWA9q0RB9bwHfvDWf20UMqmMOg5jqKWauXSldNNnghGNAT3/AIE9q0U5PgZ4q/ePm3Vq2A==
X-Received: by 2002:a05:600c:8595:b0:475:d278:1ab8 with SMTP id
 5b1f17b1804b1-477180f3b38mr27235385e9.2.1761675745118; 
 Tue, 28 Oct 2025 11:22:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e196a4bsm6202165e9.6.2025.10.28.11.22.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:22:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 09/25] hw/s390x: Use memory_region_size()
Date: Tue, 28 Oct 2025 19:12:43 +0100
Message-ID: <20251028181300.41475-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

MemoryRegion::size is private data of MemoryRegion,
use the proper memory_region_size() getter to get it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-pci-inst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index a3bb5aa2216..5841dfc4fec 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -396,7 +396,7 @@ static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t offset,
     uint64_t subregion_size;
 
     QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
-        subregion_size = int128_get64(subregion->size);
+        subregion_size = memory_region_size(subregion);
         if ((offset >= subregion->addr) &&
             (offset + len) <= (subregion->addr + subregion_size)) {
             mr = subregion;
-- 
2.51.0


