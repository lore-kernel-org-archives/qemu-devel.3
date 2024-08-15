Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA3DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seauR-0001zC-T8; Thu, 15 Aug 2024 09:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seauL-0001xy-Uu
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:52:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seauJ-0007Wj-7m
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:52:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37172a83a4bso426930f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723729967; x=1724334767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eSCVzhVBR4StelEvL55lkqBi3cGA1nPIyuOw4l2tGfs=;
 b=lpVWEe9mA6luiCWKBfASnUwaxpkFE5iNHV4aUDOTXd+aDe+lKv2oW+qPcY1FQO/xfT
 zsi83mufoTcXn1YBxalER9IBuyzm27+xYRyhVxMPzUds7sndOmKdl/w184RKMwMKovCK
 /+wzWdx1+cgN/6QEYHlYl/4T50obp70LXv8eWgBSxw8wHxKFL4aaSxBxdSwmw6jomexI
 dZczHs11zSs/SPHYmfB4x3H8oCxFr5XJWurqvYjRfBoMwfs3nhyUSue4TqvW+hCifjhG
 +qxGoXxlN23SsBWU+rkjHTLjPcfZFn3sOlQ+1B8f8DBUfZVin0EQLnWR3ZjkCBrSe5UH
 SOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723729967; x=1724334767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eSCVzhVBR4StelEvL55lkqBi3cGA1nPIyuOw4l2tGfs=;
 b=GsUWbISJt5VfSp5kkHgcsJkhj1NLQXw6/xYongLeoH7oULmKJNJae97kLqRfAq6rgm
 HER9+QBOL9nI4r2UvQhTTiB8MFlGt3rDWlOmGhcTK4Mr1XT/D6o++sXGfHmE2sNOu4bi
 4fgVx0x9GjKz64F/tfdmH5b4N6rot9biGvrNZPG587z/EtZ2kzY8atFUFeml0869WLbL
 Lbh2kwE2hR/gpqyXag+DjLRz3O34jpkiCG5C7NORpo9CSRh5HZAmtqM3LDlLIsgiNtmL
 IzJh/v6mnAjMXgsijylD1alIqh2pIix/4OKQoeeDzyZp5xjROH8zgFiIq8vL3Rak2zxz
 Tspw==
X-Gm-Message-State: AOJu0Yxus4pADFYg6E9ot4K/FrMVM1Nmh9a4Ma1tzdWYuBzjnsljmCv0
 c3gN5oaZbEfTJTrOzxBRYJxpkcGsVqrQ8ByjPm/ifgtzSyd14LyF03mwlf3mCvJphnDEIKd7Hqr
 z
X-Google-Smtp-Source: AGHT+IErz5cJjvXxAJG5OKH4h4n2FgqzJIWICgehqbTkMFpEas0qznu6c0Dnhn2pWA3ht6JCwqeasw==
X-Received: by 2002:a5d:5c85:0:b0:371:7dd1:efb with SMTP id
 ffacd0b85a97d-3717dd110e3mr2517548f8f.60.1723729967263; 
 Thu, 15 Aug 2024 06:52:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189897066sm1603659f8f.76.2024.08.15.06.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 06:52:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.2] hw/vfio/pci.c: Use correct type in
 trace_vfio_msix_early_setup()
Date: Thu, 15 Aug 2024 14:52:45 +0100
Message-Id: <20240815135245.3325267-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The tracepoint trace_vfio_msix_early_setup() uses "int" for the type
of the table_bar argument, but we use this to print a uint32_t.
Coverity warns that this means that we could end up treating it as a
negative number.

We only use this in printing the value in the tracepoint, so
mishandling it as a negative number would be harmless, but it's
better to use the right type in the tracepoint.  Use uint64_t to
match how we print the table_offset in the vfio_msix_relo()
tracepoint.

Resolves: Coverity CID 1547690
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/vfio/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 98bd4dccead..c475c273fd8 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -27,7 +27,7 @@ vfio_vga_read(uint64_t addr, int size, uint64_t data) " (0x%"PRIx64", %d) = 0x%"
 vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x, len=0x%x) 0x%x"
 vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
 vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
-vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries, bool noresize) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d, noresize %d"
+vfio_msix_early_setup(const char *name, int pos, int table_bar, uint64_t offset, int entries, bool noresize) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%"PRIx64", entries %d, noresize %d"
 vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
 vfio_check_pm_reset(const char *name) "%s Supports PM reset"
 vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"
-- 
2.34.1


