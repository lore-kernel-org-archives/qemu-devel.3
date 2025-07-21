Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435A0C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYf-0003Ig-Gz; Mon, 21 Jul 2025 09:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYB-00009l-AM
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqY9-0005Hd-0k
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:26 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so2782017f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104443; x=1753709243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TkHO/JBZlINngYKtzqWQqivz7dVd5JZjQfrMD1ZECRc=;
 b=mwf19hHrENdlCdoFnJrF+pfmuIbyjvJxhCG4ZY9sssTk+oTzHMM9slcUAzCVkuXO4/
 8a4sEkNF0iJzi+tAbOAfVkfznlyfaNhM3xrOTY1agtH3i/eiNiYsOVYP4RrgHFmE2NJ9
 tTDCiyv+u/NEVsFotxS8EUn+PNlgIcI1c5sFCkIiknR+KXfSK62oWcHVwvsCA6xUPmk9
 26GvIY/f9wjj1xBNRmgNwGYbXS1ev8yHS4D0VUzd8aW7uczL+17v0W6I/x19A0tpPZ/U
 G0fnUuXJ+N6bXl2hT/dlmfsVbGwSISWkOpL1OHDmD8i7Ox8uqOX70omtG8KaDB1cSn+q
 8u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104443; x=1753709243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkHO/JBZlINngYKtzqWQqivz7dVd5JZjQfrMD1ZECRc=;
 b=w9ovvX2jXrW9FdZruXPGhyvCGhtKQ05tJvgQoabs8ynn9nogzkHHubkOHNfccGfOv3
 h14/zltmnF8CzvOTZakCIKNCvEPi5uTk3OMt0IMS7BL50os2XbwsDEu9+yzzSCJ3ZDiF
 leOqzx0ELaCcDGNZWk60d8KCJBU+o/8Xuykpji/8/mYUYjUdF8feQVRt3+BqKyZd7clk
 s0Gr5hEgKy0INLmX5pq9yTWYq5XZp/cg60jMPEopQuajb/dS/7CaJxi3XAhH+U/dX13m
 a8Q8hbxaBSFPU2uhg4I9iIPoYdXpW8UxKrvHBvYbLfr0hjMgbVZHRIEoDWz8RKswCarY
 wFvQ==
X-Gm-Message-State: AOJu0Yw0PXT0MWRXw42DO3t5NZUmx7ux/OPD9SacSv8Vvx8UQJ13tPHC
 V7R3GhAsRagFlLBPAloKHCySBocBzriNsj92lHI20N0Ed0MKcXBsXANnckRt3/3+BSpyA8OusNX
 hYnDB
X-Gm-Gg: ASbGncs+fLdjosQ7h0JygDE6L5nPnPHVq1LHqUOciRKFrVRdGpQIngaezWHbLuG1iJC
 eU2s3TvZ9pCd4FMbpUINV6ipNk8Y7ut52y0OwVoWWUEinOus6EzGhvYIeWQMwQ+Ug1e67sBupHt
 TS8iCaEckU5itD3NWk4c9KAG5Dn8W97sqP8qMyS+VTnkKG+2hXurKv0w1DORmuNwtBe/v2RVAqT
 yKCkVu2UWyzCUNDa4ZMDzx9AAUWd2MElo894NKRdqyDBaK6yw/KZsmcSzZI6Tf9lDMkiG0+txke
 MRPcz1YPqJT/z2rSiYMLFIXDFDDrrMTYhaN6/fewkoZ62ZIfhI05CU74Zvm2qQ6QJtBCm9Bnc33
 fkTzKxpIwtqkfHHU6Q7e1bWYF8pTu
X-Google-Smtp-Source: AGHT+IHvY2jLQjjc8824H5hIgCQ1vzw/z1EE94aVJ1qeMet7iDxcen7uMcVKj0+O4KE4gHOMjGE9lA==
X-Received: by 2002:a05:6000:2881:b0:3b7:590d:ac7d with SMTP id
 ffacd0b85a97d-3b7590dad1fmr4639886f8f.1.1753104442720; 
 Mon, 21 Jul 2025 06:27:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] hw/misc/ivshmem-pci: Improve error handling
Date: Mon, 21 Jul 2025 14:27:00 +0100
Message-ID: <20250721132718.2835729-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Coverity points out that the ivshmem-pci code has some error handling
cases where it incorrectly tries to use an invalid filedescriptor.
These generally happen because ivshmem_recv_msg() calls
qemu_chr_fe_get_msgfd(), which might return -1, but the code in
process_msg() generally assumes that the file descriptor was provided
when it was supposed to be. In particular:
 * the error case in process_msg() only needs to close the fd
   if one was provided
 * process_msg_shmem() should fail if no fd was provided

Coverity: CID 1508726
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20250711145012.1521936-1-peter.maydell@linaro.org
---
 hw/misc/ivshmem-pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 5a10bca633d..d47ae739d61 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -479,6 +479,11 @@ static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
     struct stat buf;
     size_t size;
 
+    if (fd < 0) {
+        error_setg(errp, "server didn't provide fd with shared memory message");
+        return;
+    }
+
     if (s->ivshmem_bar2) {
         error_setg(errp, "server sent unexpected shared memory message");
         close(fd);
@@ -553,7 +558,9 @@ static void process_msg(IVShmemState *s, int64_t msg, int fd, Error **errp)
 
     if (msg < -1 || msg > IVSHMEM_MAX_PEERS) {
         error_setg(errp, "server sent invalid message %" PRId64, msg);
-        close(fd);
+        if (fd >= 0) {
+            close(fd);
+        }
         return;
     }
 
-- 
2.43.0


