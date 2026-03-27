Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9139410F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6EiH-0005pp-Tc; Fri, 27 Mar 2026 17:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EiG-0005es-7y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6EiE-0003pE-Na
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDlQX+UUc5AOH1czgnahPp+EQgUsIkyNsfGBa+IQYX8=;
 b=Pu2cZnHmnmbHxORuHNXI8wRusv/QEIM38sUUk+O+kUZK+oZyAtJQOL1jKsL5KmOan1Tm+z
 WrA97W2hdsYvNbFVd57LBcJzLhgOpnLURPGIb+70C/EoQRBQrRT7jPws3QGB4fSEZN9AW1
 NgZXa520n2WrI97kVwoV90NM7K9bB8s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-VfN28IY2Pwyfk1uKmHm-ag-1; Fri, 27 Mar 2026 17:27:24 -0400
X-MC-Unique: VfN28IY2Pwyfk1uKmHm-ag-1
X-Mimecast-MFC-AGG-ID: VfN28IY2Pwyfk1uKmHm-ag_1774646843
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439af7ba802so2183215f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646841; x=1775251641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDlQX+UUc5AOH1czgnahPp+EQgUsIkyNsfGBa+IQYX8=;
 b=mHNTS1vBt9WtJ5AD09HDQ/7YiQ6GIUyDVwkmE3unptZvrayuS1aJyjo/8ESVBTgxPt
 GmN0UvPxjhTHKNmO7m2zTOdp7GsB1Zq58V8KUN8FI+mtbxSrXQAN8gdHyCNv388mH/ub
 tWybnUEq723ab9oBv0qNU7wW7jG7aO6AEBtFuznd2zaNEoGEF3dc/wRCoBUpqHlO2AQ3
 NloJMzfnWZ5W2xg3/7ECol4JCAE3r5DxtTbUMwEcpHOqBZ83LDi0TdkNHOxt0ETeLNLi
 so5ZNCyRE7xx2ZXyAckjOYap39WvTfSsjErvc17ZMMoEQshsPOnPlFLbN9sKCSpIFbTW
 D/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646841; x=1775251641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RDlQX+UUc5AOH1czgnahPp+EQgUsIkyNsfGBa+IQYX8=;
 b=DpeJ3FHi9s5JhGLd/6SPiSBdlvGwiVrd/MXU/Yp8BbfQiUv4nWoOxBsYX4x77sFcbo
 VGfkWfNEYPdACGn2U5GUYEku5cinVt/siF3y5TGeHeCRD18i9Oj4KKib4asvoRoD0Gtz
 8uezfQdwUYWclXdZ5P7GXodiDo+saT59299EMldaJTciMa60U37YODALFwdg00fH2U6Q
 y4tc2iG8CgFAd21WUUJxWzqJeThTb1bXxgBLbddrfZ0C++VJ8j/GRoW9JkE4kGkdVSwj
 MUxdD6LOS0j4wYhAqPSCTwXCO0oY9I+OimQtQ1Tyf9cEBk8Mg2gGO2DRltPKJhseGnRN
 M1wg==
X-Gm-Message-State: AOJu0Ywhe5SU2oQd+z/DpBxbS6bvElL1fSdQT5ELxIKk6VbElIDr37XK
 WB01Z9eivUahSpy6OFDMNpgvIxMBsNJ9VR6Heqzi06ud2QVwnnhB0MHLCBrMjvHJbf1u5KFPwah
 DWS5OLpwDbR+r2zm6dAelFMsLTGkmuG/7ozQtuf5G+c7uRbhk97MWnA7Aux5KfSLc0aq7kNACuQ
 5oosHhjVSriBkIEdTF2O3ft1aSNTV4w4/nfTakyfPW
X-Gm-Gg: ATEYQzxXXiXeiHF9YKfl82dHshNLtJwh6LccYhFnbGcic1b2nqausZuSkJhbnX9cWvv
 7mBsS6UEUeroGJxygZaAGwM/irCSmOkk3jLG6Ra/uPwSGiI07GFHEOgEfBIz1upMyjkuig4/1/j
 rosS3H9TO/BlQy4VTf5Drz5onocK7UUQd97Z+YpADkrXRHN+uDl0rdtic6MUnbiWUMAJnyxTF9Q
 0C9bRtFJD1h9a3n7CYRyIpAlcnLww5vK9lQhs53FlS7D5pdw1btcKnYUoVk1195+BLUC4UgA3Jm
 BgLLtz0mpN/PqSorkCGrwWXTO4QjcmU1gaIJKGKC6ff9F2GC6pgBeS6R707RoiiQB3ZVAZvEbiI
 e9DcwEaMDWLEhAD88NGVcMwRpMJ4rn0idlSDdZoQVYztgKNW8kMVMa/deuBMZBMYvim/6VE8Pxm
 QlIBeEIZMkXlgORmVFdkLIKH8h
X-Received: by 2002:a05:6000:184f:b0:43b:9060:8829 with SMTP id
 ffacd0b85a97d-43b9e9d8c3cmr6728632f8f.10.1774646841316; 
 Fri, 27 Mar 2026 14:27:21 -0700 (PDT)
X-Received: by 2002:a05:6000:184f:b0:43b:9060:8829 with SMTP id
 ffacd0b85a97d-43b9e9d8c3cmr6728599f8f.10.1774646840763; 
 Fri, 27 Mar 2026 14:27:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf1db08e6sm1913655f8f.0.2026.03.27.14.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:27:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 14/16] ncr710: remove dead message in actions
Date: Fri, 27 Mar 2026 22:25:45 +0100
Message-ID: <20260327212547.460420-15-pbonzini@redhat.com>
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
 hw/scsi/ncr53c710.h | 2 --
 hw/scsi/ncr53c710.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 97f1bf5fe22..ee6980753d5 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -108,8 +108,6 @@ typedef enum {
 typedef enum {
     NCR710_MSG_ACTION_NONE = 0,
     NCR710_MSG_ACTION_DISCONNECT = 1,
-    NCR710_MSG_ACTION_DATA_OUT = 2,
-    NCR710_MSG_ACTION_DATA_IN = 3
 } NCR710MessageAction;
 
 typedef struct NCR710State NCR710State;
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 298e0317b70..ea114a0cb40 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1027,12 +1027,6 @@ static void ncr710_do_msgin(NCR710State *s)
     case NCR710_MSG_ACTION_DISCONNECT:
         s->sstat2 &= ~PHASE_MASK;
         break;
-    case NCR710_MSG_ACTION_DATA_OUT:
-        ncr710_set_phase(s, PHASE_DO);
-        break;
-    case NCR710_MSG_ACTION_DATA_IN:
-        ncr710_set_phase(s, PHASE_DI);
-        break;
     default:
         abort();
     }
-- 
2.53.0


