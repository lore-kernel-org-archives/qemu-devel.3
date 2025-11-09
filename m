Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 22:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIDZ4-0007jj-C2; Sun, 09 Nov 2025 17:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYx-0007cN-1C
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:07 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYv-0005t8-Jy
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 282C040C4C;
 Sun,  9 Nov 2025 22:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC81CC19422;
 Sun,  9 Nov 2025 22:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762726024;
 bh=xvnVTfvyk4KDq0NeFm7fXlGBh2QTyO3Ky2iuae7PUFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jPD94MULDotRstlrW6EHTmbL3Hu18+dAL0mIqZ8O6fDNFvxl8SF98+wF9UhxFkQ7A
 NZLFFaUXXgyHg8hDc7fWJg7Ukb31FxyfkcwDqKEtTrNNEQ1/QJzefjgimA7LqgoYok
 rwmAX8Rd2w2I85zCzHYDpwv1uEwWP6mIdymiVB1+vce88jP7yr6whFIQ4p7QDr26ZK
 8OyfZ5P6OJERJ/fuM+qGZQzuc+iIG2+E7TL+vQ7ZyIyaEK+pDJrPKqHTtfcA9gngkx
 JQ627p3opF/mu1N0Q/kehsBZjjyBu+tWxIwd4NiSuXVbxEKiekHRbZa+P5SWz5vp1O
 W0QhKSWRnSYPg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 4/7] i82596: Adding proper break-statement functionality in RX
 functions
Date: Sun,  9 Nov 2025 23:06:51 +0100
Message-ID: <20251109220654.46718-5-deller@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109220654.46718-1-deller@kernel.org>
References: <20251109220654.46718-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Fix coverty reported logic error CID 1642873.
The initial issue was the break statement exited out of the for loop
unconditionally.
Now, the break only happens if rfd is null, out_of_resources or
bytes_copied < payload_size.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/i82596.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index fb6b54fd71..af1abd4996 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -1092,6 +1092,7 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
                     rx_status |= RFD_STATUS_TRUNC | RFD_STATUS_NOBUFS;
                     i82596_record_error(s, RFD_STATUS_NOBUFS, false);
                     packet_completed = true;
+                    break;
                 } else {
                     hwaddr remaining_rbd = I596_NULL;
                     size_t rbd_bytes = i82596_rx_copy_to_rbds(
@@ -1118,17 +1119,18 @@ static ssize_t i82596_receive_packet(I82596State *s, const uint8_t *buf,
                         i82596_record_error(s, RFD_STATUS_NOBUFS, false);
                         rx_status |= RFD_STATUS_TRUNC | RFD_STATUS_NOBUFS;
                         packet_completed = true;
+                        break;
                     }
 
                     if (bytes_copied < payload_size) {
                         trace_i82596_rx_incomplete(bytes_copied, payload_size);
                         rx_status |= RFD_STATUS_TRUNC;
                         packet_completed = true;
+                        break;
                     }
                 }
             }
         }
-        break;
 
     } while (bytes_copied < payload_size);
 
-- 
2.51.1


