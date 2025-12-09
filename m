Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C0D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 08:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vStTv-00081a-KR; Tue, 09 Dec 2025 03:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1vStTu-000819-35
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:54:02 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1vStTs-000317-Js
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:54:01 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7ba55660769so4572306b3a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 00:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765270438; x=1765875238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rd49MfUtOmqGR2d648ZNYtGas6T44aQXd8eNnA7HoMw=;
 b=aop1AzcBIN9XT/AqSWHBC37KWlyUuCn0alWiULqty4d/F/7yNyTN3kUh7nTfxBaMXh
 +4AeHvZYBhvQ7MErpRso3ZevnY1x1jkwcVS05uSpVSI4tc6QdnIKhH+67wqaKl2Qxx7D
 TOEN+z44QTDalj+w6D+Au4ZDci5lbWIsxvWwrU1aztiqu7WwG3LtT7q6nCFcFHT2BbMG
 w+3xCUH6MYhaavBFghKHr+NEt7JNC5hmUtghBTKElWCWM96pQKkbrXT/Dd8ahhIx5hq6
 eX0ODClyDtCC62Vu9R+BjVuSUrUYztyfqWr9yrfg6l0cCR0BTG3UgNPuqdLl0kniby3t
 0L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765270438; x=1765875238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd49MfUtOmqGR2d648ZNYtGas6T44aQXd8eNnA7HoMw=;
 b=qTg2yjOfR12qLK1I9VPXthaAH3P18X8jJUZIUss/cTbqc0biR801vdVJD2uUi43TiE
 8sJOtgviZO+1Rh703NksKCxPxV5S2GvvBLHfNJisSRzJEQgefYtiqP7ARtFM33dXxae/
 TAnHD4T1iY+jruhLnkEYZOZEl5Sgz5/vvcKWgGqutr9v9n6GVpGiewlhYKS+0CQwsMYq
 qnq1cB1ziel1u1YhgS5oQwLJShkDrePhXUEYeTH7aC4+7xytrhNtZaJBxXzSLMH62W4y
 eLm15Jb5ZFm35nvyglmpXdwdzUOp8pi+nkkh57TIbRTTuy8gCHm51EecE7k+7oPTc5od
 scDQ==
X-Gm-Message-State: AOJu0YxkL46u5TdqzTEld63LGMt94Jn78TawhIYFsi4Sv8GqaT0Rm2vo
 kVvSV66bRVwlFNqiwbOZaFi0isjlbO2m1zb7gCWEe7tCjBQmIiax/rluNfxnkQ==
X-Gm-Gg: ASbGncteOEoLyOG1iu8wFTgrNkC/c7syp9CqasplhYJAP8xFnspOHAuuX8ZBMgwSFjQ
 1M40eeLE4CNsIFitOZFqgGa+6yqMgCy6K0YkQkkLojHJYxH8zc4HkdtFbF3QpPeYxKsQ85/ffLK
 NaBrkCXDjvVodIGPHg0214ZcokM3T5ruOBvq5mQNkO1ZMqd1bsgPtXVfbMnyQWwWvVDI3BG1cuj
 Dv0vp3Lf9BueaZehZgpQmVNvj0sntOUDvt+v7R6mLX9ba+fUuwv3S8SEZ+EfA5cCgi7EtORQowI
 hPVVq5WLzeTkXakw8JSUzsnyPu5fl2TenJmIixUrjnhfrcARB/14SXWYTxof84WWAR8tWRi5hAD
 cfm4l+vWA4qKcmtfbIZDFsp9c6GHyIMyQKQuL1pUaTP9MAQ+0hFjdiK/nFu6kebkINgIEJ9qMUp
 vkdtaTGppwY33+2drtSqHVnf0cEX87kjfy0tnYpJSWwro=
X-Google-Smtp-Source: AGHT+IEwf6WwErMremWEebV+7Cqzix6TTA/e37c/3SSiuLErEbQjyEF0cplw/5UP/RNmSvG/wL3gYQ==
X-Received: by 2002:a05:6a21:e081:b0:366:14b0:4b09 with SMTP id
 adf61e73a8af0-3661815064dmr10321506637.69.1765270437814; 
 Tue, 09 Dec 2025 00:53:57 -0800 (PST)
Received: from localhost.localdomain ([202.131.248.108])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bf6817397d0sm14330460a12.6.2025.12.09.00.53.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 00:53:56 -0800 (PST)
From: heropd <munkhuu0825@gmail.com>
To: qemu-devel@nongnu.org
Cc: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Subject: [PATCH V2] htif: reject invalid signature ranges (end <= begin)
Date: Tue,  9 Dec 2025 16:53:49 +0800
Message-ID: <20251209085349.61510-1-munkhuu0825@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=munkhuu0825@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

Prevents huge allocations and crashes caused by malformed HTIF signature
addresses.
Fixes: link to issue #3205

Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
---
 hw/char/riscv_htif.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index a78ea9b01c..aa205c84c0 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -170,6 +170,11 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                  * begin/end_signature symbols exist.
                  */
                 if (sig_file && begin_sig_addr && end_sig_addr) {
+                    if (end_sig_addr <= begin_sig_addr) {
+                        error_report("Invalid HTIF signature range: begin=0x%llx end=0x%llx",
+                                    begin_sig_addr, end_sig_addr);
+                        return;
+                    }
                     uint64_t sig_len = end_sig_addr - begin_sig_addr;
                     char *sig_data = g_malloc(sig_len);
                     dma_memory_read(&address_space_memory, begin_sig_addr,
-- 
2.50.1 (Apple Git-155)


