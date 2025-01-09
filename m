Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CF4E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVmUp-00043Z-Vo; Thu, 09 Jan 2025 01:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tVmUn-000432-VT
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:58:21 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tVmUl-0000TD-Da
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:58:21 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxG6x_c39nSnBgAA--.3896S3;
 Thu, 09 Jan 2025 14:58:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxXMV8c39nCtkaAA--.46678S3;
 Thu, 09 Jan 2025 14:58:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/6] hw/core/loader: Use ssize_t for efi zboot unpacker
Date: Thu,  9 Jan 2025 14:57:59 +0800
Message-Id: <20250109065804.1569654-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250109065804.1569654-1-maobibo@loongson.cn>
References: <20250109065804.1569654-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxXMV8c39nCtkaAA--.46678S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Convert to use sszie_t to represent size internally to avoid
large image overflowing the size.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/arm/boot.c       | 2 +-
 hw/core/loader.c    | 4 ++--
 include/hw/loader.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 68fe8654e6..b44bea8a82 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -857,7 +857,7 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
     uint64_t kernel_size = 0;
     uint8_t *buffer;
-    int size;
+    ssize_t size;
 
     /* On aarch64, it's the bootloader's job to uncompress the kernel. */
     size = load_image_gzipped_buffer(filename, LOAD_IMAGE_MAX_GUNZIP_BYTES,
diff --git a/hw/core/loader.c b/hw/core/loader.c
index c0407e2d0d..4dfdb027ee 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -886,11 +886,11 @@ struct linux_efi_zboot_header {
  *
  * If the image is not a Linux EFI zboot image, do nothing and return success.
  */
-ssize_t unpack_efi_zboot_image(uint8_t **buffer, int *size)
+ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size)
 {
     const struct linux_efi_zboot_header *header;
     uint8_t *data = NULL;
-    int ploff, plsize;
+    ssize_t ploff, plsize;
     ssize_t bytes;
 
     /* ignore if this is too small to be a EFI zboot image */
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 7f6d06b956..8985046be4 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -101,7 +101,7 @@ ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
  * Returns the size of the decompressed payload if decompression was performed
  * successfully.
  */
-ssize_t unpack_efi_zboot_image(uint8_t **buffer, int *size);
+ssize_t unpack_efi_zboot_image(uint8_t **buffer, ssize_t *size);
 
 #define ELF_LOAD_FAILED       -1
 #define ELF_LOAD_NOT_ELF      -2
-- 
2.43.5


