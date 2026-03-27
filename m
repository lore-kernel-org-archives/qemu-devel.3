Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEF110F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EiW-0006pk-Cm; Fri, 27 Mar 2026 17:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EiV-0006pF-4h
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EiT-0003uT-Q3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kn3TlGxvri/ygLm6oWXfbfHTV18razK+0DgQDbp4zwI=;
 b=EJqXLSDFjcxmTdh6g7MR3EvTxehYVLH1Gnszy2Q1NWreMIZpsup+oLukx3qzy6LyOLKeH7
 mTIqC4EbQbOITmYPv3EYVkfMRlwaCfJ3w6mNXa6r/z6EWHilJIt11/XXDPMXspaNn2/3Fd
 HTgaNfM3XjuDKdhTSAPgCeSPUfPMmLU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-fysDzwhVP9ijGUCagEkUXg-1; Fri, 27 Mar 2026 17:27:37 -0400
X-MC-Unique: fysDzwhVP9ijGUCagEkUXg-1
X-Mimecast-MFC-AGG-ID: fysDzwhVP9ijGUCagEkUXg_1774646856
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b86de58d9so2133853f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646855; x=1775251655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kn3TlGxvri/ygLm6oWXfbfHTV18razK+0DgQDbp4zwI=;
 b=TTWhWo1echKEbAIqXF17DWA45LDlMmrogIqw8i1M8yBaeN5sQOcjTMA0y08ZvjlWa2
 3yLIXhD68AeQu5kj2TLzHp3oWcFPyXFACx6pF/E9rNE22LCwe9fIXqP33mZNQ2XLn2va
 nUGfVOERFyduU06/CI93+loYBuUIuohJyQi/3VrqeIwnTTDw7mBWs6HZ1ut1rPq0lyMf
 Au8rJsBsmD+N+QNguHul4vfMYSXki9KPfN5QZY1L2r+Iv4ov7OqfD0apwezMfruRD+DB
 zyPEfQo0uwRZWkkY48aXhljIML3zot9jxpdQ5v0HepIW/Fwe1ccTKDN5+E/w6FIp206m
 UmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646855; x=1775251655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kn3TlGxvri/ygLm6oWXfbfHTV18razK+0DgQDbp4zwI=;
 b=LUZ8JcScbwgNRPSvWy9eyj3Dap9yfxWX/aXTM+rfwp66FEaarUDF5t6Y/shgetiiZw
 LO7JVfQAAyIHQII9Q2A6s3Gw35DqzPtcEQxjvQAAveJRTJvxsp2tXqmnIc7uFTYc0VEI
 c+dL+bGpPX3jAcFC0aLyOYP/vXqfpGoDuH6q/cqZWuLUdWpUU2t9GBG0U9J+F+XJAtgx
 kgFPXXVVbHX5T4J1WdRGSBL+DF950N+4NypTRb9kfKHbToAqsyh0sYlfR5D5XtU5LgbV
 Ky1FVRNulM1Blx0NWJrfD5lOZ/j6ZZ2Y/vrD4yPL/MPyUTfOeRe+w8e/I//xBlDVDsMo
 nWsw==
X-Gm-Message-State: AOJu0YzGPDBTM3z5QsAq9ySvX1Zix8CPFUuAiOgi1cloJnfZ4CTHqwGs
 2Ht7FBClCAqB7kCx3S3ej6F4dD+cyX81D4k9AcKKK32fL+2LEOHzV5K//1lpDeNfJtOX8nNpr4e
 fdVGNg0YFwAuf/ELiOmV7NMuizBQdXFsmtqDCzRRDPaL8k9YJ0BBTUfLTwGxzKFk6SqDqv5ORDi
 rI+GHTlmi80iZvjuVzzCENg47RMv1H+Lbuuedroko4
X-Gm-Gg: ATEYQzyxRoZqyH4pd+lGXLKgRTmF2B0oahQ+Yhirz/Nkg/xemrkT0aYuH/eCRE2d8V2
 RPpOkHxkKUVh42K+jJec2jPNpenGnbjFlCVh+TS9r23SIOSAeCSPkGyWB2Aa5zfqhp7jeSiKcOl
 HX8jUnKML09dY5i1MmfyEgQVwGVCHvdkXWvBFufkZBO6ieB9lv/PO+38yFSfu+++27ytCb6we4p
 KQRlbV7C3JBdZjRTInNtqCSInFcbIng9/M09wx73Mp5fNaM8sOZE6PZgkMIrtVG1idG7KgF0C5T
 T33eW3ZTLdIAjXTHFykX2/2l5AwxQqBosViRn0j6iSsdwe8Zy3lsn7tYupH7MToGitERU3BlOUr
 e19ZbaClNotSyUna4qs7//Lvce1FC0RGS2hzETyX+y8/J6pXXzT0hBV3XuPzBhhmXqfRqkim2dw
 99doXwkFkyTBrvJgfob+Q+Drxl
X-Received: by 2002:a05:6000:2382:b0:43b:4757:cc5 with SMTP id
 ffacd0b85a97d-43b9e9e8e21mr6297921f8f.19.1774646855208; 
 Fri, 27 Mar 2026 14:27:35 -0700 (PDT)
X-Received: by 2002:a05:6000:2382:b0:43b:4757:cc5 with SMTP id
 ffacd0b85a97d-43b9e9e8e21mr6297897f8f.19.1774646854694; 
 Fri, 27 Mar 2026 14:27:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eb95fsm823760f8f.12.2026.03.27.14.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:27:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 16/16] ncr710: unify two conditionals
Date: Fri, 27 Mar 2026 22:25:47 +0100
Message-ID: <20260327212547.460420-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327212547.460420-1-pbonzini@redhat.com>
References: <20260327212547.460420-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index f7b1e153960..25a1018ab11 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -797,13 +797,10 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
     s->status = req->status;
     s->command_complete = NCR710_CMD_COMPLETE;
 
-    if (p) {
-        p->pending = 0;
-    }
-
     ncr710_set_phase(s, PHASE_ST);
 
     if (p) {
+        p->pending = 0;
         ncr710_request_orphan(s, p);
     }
 
-- 
2.53.0


