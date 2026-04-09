Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68A4EA3C55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 11:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAnxB-0006Gg-7l; Thu, 09 Apr 2026 07:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wAnx9-0006Fo-UN
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:53:43 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>) id 1wAnx7-0000Fi-Oq
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:53:43 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id EAAD420B7129;
 Thu,  9 Apr 2026 04:53:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAAD420B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775735620;
 bh=968+R5QinbpCMEGNp1o9WJBEA7Zubhh3wG4nw0uiz5U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KJ/69FkYLGBQbAY9zNUksU0eKSJW/rU/B7jj/92p7dHfZVWCz0P7L0tC6Au/unfKd
 3tt2BVlCsrJfuf8jkHmuVKI8WIzHIbth7WuXv2wZ396MLCbxvDQeVUxSLgr+j7v6Zq
 M/VXJc3e1mN6In/VOCJbSLWRyyXKjEDG9aIPV7os=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Thu, 09 Apr 2026 11:53:07 +0000
Subject: [PATCH 2/2] accel/mshv: return correct errno value from ioeventfd
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-fix_ioevent-v1-2-053b810ae6fb@linux.microsoft.com>
References: <20260409-fix_ioevent-v1-0-053b810ae6fb@linux.microsoft.com>
In-Reply-To: <20260409-fix_ioevent-v1-0-053b810ae6fb@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Returning the raw ioctl return value results in misleading error
message. Ensure that actual failure reason is propagated by returning
-errno for ioeventfd failure.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index e1a8d62f8d..58af674bd9 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -275,7 +275,12 @@ static int ioeventfd(int vm_fd, int event_fd, uint64_t addr, Datamatch dm,
         }
     }
 
-    return ioctl(vm_fd, MSHV_IOEVENTFD, &args);
+    int ret = ioctl(vm_fd, MSHV_IOEVENTFD, &args);
+    if (ret < 0) {
+        return -errno;
+    }
+
+    return ret;
 }
 
 static int unregister_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr,

-- 
2.45.4


