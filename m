Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B87EA3C59
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 11:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAnxA-0006GO-Fi; Thu, 09 Apr 2026 07:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wAnx8-0006FQ-TY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:53:42 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>) id 1wAnx7-0000B8-E4
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:53:42 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4A28820B7128;
 Thu,  9 Apr 2026 04:53:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A28820B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775735618;
 bh=Ot44HhIh9dSxBc7D1AE4ZKxrlj9NAmqllhNbYv2DtAs=;
 h=From:Subject:Date:To:Cc:From;
 b=bipTzVCQDFrDFiERIZyxne9qk9D/cfjpabqWI4B5Rah+v9Vd3td4y5WwogXvL+Ake
 XHphj+zTBs6WRp3bApPH9Wxzpwzrl+NaPTPW4d2eeTCtM041bjR6Y4nZd1ZjekwROv
 DKzY5W/ncoUi7vO9eP1NbOgYKKuySjE/aPvYS6FU=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Subject: [PATCH 0/2] Fix issues in accel/mshv ioeventfd handling
Date: Thu, 09 Apr 2026 11:53:05 +0000
Message-Id: <20260409-fix_ioevent-v1-0-053b810ae6fb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGT12kC/yXMyw5AMBCF4VeRWWtSdSleRURoB2NR0iIS6bsrl
 l9Ozn+DQ0vooI5usHiSo9UEJHEEau7NhIx0MAguCp7xio10dbTiiWZnmUhlmWshuZYQHpvFMH+
 1pv3tjmFBtb8J8P4B8lzJR28AAAA=
X-Change-ID: 20260409-fix_ioevent-423785d270d7
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

This series fixes two bugs in the MSHV accelerator's ioeventfd
implementation, discovered while booting arm64 EDK2 firmware with
MSHV accel.

---
Aastha Rawat (2):
      accel/mshv: fix ioeventfd deassignment to forward correct datamatch value
      accel/mshv: return correct errno value from ioeventfd failure

 accel/mshv/mshv-all.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)
---
base-commit: e29302cbe6ada855bb7f18854ad215533e15b2e9
change-id: 20260409-fix_ioevent-423785d270d7

Best regards,
--  
Aastha Rawat <aastharawat@linux.microsoft.com>


