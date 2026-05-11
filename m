Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2368CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRen-0007FL-P4; Mon, 11 May 2026 10:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMReh-0007En-Ri
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMRec-0005oB-Sm
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778509840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OQrM2e3+zBFO+lv56kvCJ/3v5u7O3E6TijgyFVxGAnE=;
 b=P5tGMkaKeSFmV9w4EbxeYTzbcrq3nOugV9vBVlFnA40iKBuzUlC1BELhu59QyYsn9qtThA
 H3+qk6y7+iKiAoyorgVH4cnkJXkktycYvpAFXvzrjQ3/hDdgTDndZDD4r0yLx8JiQ4Mdtk
 8XP4CVb7d/dxF0M8UiCXoK5sUXq97X0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-VmsaIQvUNzOU2j3Mnvy_nw-1; Mon, 11 May 2026 10:30:39 -0400
X-MC-Unique: VmsaIQvUNzOU2j3Mnvy_nw-1
X-Mimecast-MFC-AGG-ID: VmsaIQvUNzOU2j3Mnvy_nw_1778509839
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eb82634cbeso928876385a.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778509838; x=1779114638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OQrM2e3+zBFO+lv56kvCJ/3v5u7O3E6TijgyFVxGAnE=;
 b=sNI+H60cglJlPvMFDa1FMhL0Q37lIGHkvtQsG8786ovY4xm9BKPTb3+q2y2118r9jc
 eUeSGEsisLWDOaf9S6+dwcuVnUmHuXfw2Bp2dRmLNyeuS6GAqcKeMxEjlzd597THhKpF
 akf/u0vKjylIvFJDsW44nMAhYh7LYRiJF+cYLn8Ie0ZZqHILS94fSS3nFdVWIe5VOq7c
 KQVkURCCIPltwINTqVZB4FIEhZDsFwWp5EybZ3Fm4s6Mv9MkSEIBrpNRO5NCwAY4EnJH
 4qmIPEIk3hN5ED5Ocl1mK96D+4MDoHvHfGVtmbEAK1/B4KfJAmRoybDkCMZw+yGBnz8s
 vF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778509838; x=1779114638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQrM2e3+zBFO+lv56kvCJ/3v5u7O3E6TijgyFVxGAnE=;
 b=gNtUQpo4xq3B/X0prIlDtFxzE9EwBvlkL2IW12bNs6L+NTJiihQOmLQIMsNi89sPy4
 FSOfnGqfdeog91EPvuSlD3f+z7R8EhfLZNS8ZI8bPnoEztZyKNPd9AcbNgsVNVL6r2js
 jCeEvJCG7T8+aBF9I1KXV49WBLUCLW0ZfxzwBNuf8RmtB2GahZESjSXdamZYdUlNwJbx
 P/Y7Qh0JQuanreEIcLgAy+diSzHoH3kzSM2Y8EdH3rl1kbsZBcKmaZWauLiM9eq8IfAR
 jjigK3xJ8n+3keA/2mxc43rd06vlSMUa5Dz+CpzJddqqmtVpiH5DehXkbXlWxTFvidXE
 IZdg==
X-Gm-Message-State: AOJu0Yyv0ylQ4nmHFwnfCzBDxtZca4nOHTcxflu9I59KDHs4uExT+9aJ
 v3IUxQrLyczes1GXBkaIRueCS1CC2ScKYCUbVD28OiD+TbQAypB4CYWPP0fH438YZ/yST4kub+Y
 KWA79FLR5WkSecCo4wbXTMDa3yNZDjkEJIGkuvwTICMdbQRQwFl1fk3E1VJoseLbMSi0/iKOD9x
 ZkgliZHlJ1K/Mpq/QdWH8m7hGgISoOTdjaVRe4TA==
X-Gm-Gg: Acq92OHShx2q4JcghWmzx0Xr4/9brTBpiqPUrtHXuv+nD7ez7TUam0AkDPLxxlS6af5
 NOF65uKJzfV+Z+m8lTNTkHTB/7XPzLrFKodAJT0ND/4fuV7bFpP1jp0l2pNnN8c+uJPHIaxAqfx
 4IVU0/fOkIxcA/JsTaWTPAgf+CfTlEHc6tLJtGWk1OcvUFoTtkbOB4GedPqh/rIbnjxNkWy1Fa9
 sScdKyngU9/npqaV73Nvuu9Qck1otx/d7RlxZOj8YydSKl6lDXzqYGBTkPqakdaBsn4HOSvooGn
 /31xNWcdvWCu/s63daErlXDwj23xTdX0KCxM5oLeY2duPPWz5VXZeKC+dwUTDr+ulyz7FPwuYf/
 VxIGHd2F2nxU3b8dMAvQ2vsY6NP14p4NsYMq6i17iV0iZ
X-Received: by 2002:a05:620a:1a19:b0:8e4:ebbb:b162 with SMTP id
 af79cd13be357-904d3eac012mr3323739585a.9.1778509835522; 
 Mon, 11 May 2026 07:30:35 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:8e4:ebbb:b162 with SMTP id
 af79cd13be357-904d3eac012mr3323624885a.9.1778509828209; 
 Mon, 11 May 2026 07:30:28 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b8d9ea06sm1060974385a.20.2026.05.11.07.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:30:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] MAINTAINERS: Update RDMA migration entry with M:
Date: Mon, 11 May 2026 10:30:26 -0400
Message-ID: <20260511143026.1296485-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We wanted to remove RDMA migration once but that didn't go further.  In
reality, with the help of Zhijian it's in Odd Fixes stage, even if we just
merged one new parameter for it, for performance improvements.

Markus pointed out we'd better have at least one M: for it to match
anything that is not orphaned.

Remove the X: for Migration entry for RDMA files, then it'll start to cover
RDMA migration again. Keep the separate entry so Zhijian can keep getting
copied, and copy the M:s over to say someone is collecting patches.
Logically these M:s aren't needed after removing X:, but make it clearer.

Link: https://lore.kernel.org/r/5326b854-fcea-4af6-a479-792888a94a4d@fujitsu.com
Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3d645953..c57ef413ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3758,11 +3758,11 @@ F: docs/devel/migration/
 F: qapi/migration.json
 F: tests/migration-stress/
 F: util/userfaultfd.c
-X: migration/rdma*
 
 RDMA Migration
+M: Peter Xu <peterx@redhat.com>
+M: Fabiano Rosas <farosas@suse.de>
 R: Li Zhijian <lizhijian@fujitsu.com>
-R: Peter Xu <peterx@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
 F: scripts/rdma-migration-helper.sh
-- 
2.53.0


