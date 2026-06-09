Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A90CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvas-00012O-44; Tue, 09 Jun 2026 08:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWvao-00011T-LH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWvam-0000YM-2j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781008203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoFYwybA10DFq3ugVnScCFTYt/rFymgVdzPwN+GTRCg=;
 b=eE22xJ5D0VoXlqFS3by+NwYjCRCw5dDeh7JkozsLxaOXNr/pfFIYGi+y9nwWTNBTqxXZJo
 ylof7+Hae8GR39/++23KJvy6nQEmKlFQNi42dM8mYtOlwdDxCyXBhPCazV9sIKShMQMXnR
 pDPsSNSAS2cEtbepvb6GLJlpn/v+rqY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-KdmLxhVqM_2F7iqLJ6SkrA-1; Tue, 09 Jun 2026 08:29:59 -0400
X-MC-Unique: KdmLxhVqM_2F7iqLJ6SkrA-1
X-Mimecast-MFC-AGG-ID: KdmLxhVqM_2F7iqLJ6SkrA_1781008199
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef93c359fso4466290f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781008199; x=1781612999; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DoFYwybA10DFq3ugVnScCFTYt/rFymgVdzPwN+GTRCg=;
 b=QxYfVLmDSZOqGqIO8TIvCS4uPt1MJCYD/uZNG54iTQtBobtJMlwSNJtfTWRvMRjPtu
 wENCtZtUqohHTZfOPrt2H+PUqZS7xbJjoneKdRTGs5YI9HUDQjTiGXolc2gdRWe9NSEs
 weRIqhlTdeMICR/VwzJm54Ys0T1bQDhQb2URLldQoc4IUZk9JKw/GX9XwXHAqbOKpv3C
 fwtMXiZ/4MtkCnTDvsfov85yatrnTf4ajlI+F7fAUREOxLlkE5hwQ9iaEypB2dm0opf1
 6piNqVZFKybkjdxxmfTxpPmotyyDTgwM9E1ktvLUzk5Gbb66p9NOM5ZrxVeE8DuwIqWQ
 VpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781008199; x=1781612999;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DoFYwybA10DFq3ugVnScCFTYt/rFymgVdzPwN+GTRCg=;
 b=OmtPX7N5RFV1uqL8q6evwM2KF1yIHC3m/vATB5DvuRJk88c9IAo5y8haE0HWt78N0e
 hCW9sOZfkU3fLRVoXZDg30hAsuL/qd5DdvRrdD34/a613yTzZ+/fb1c1/lZv83b2SA18
 j+/1Pnrv1GgfKXY1cRMHRwJRzsESVSISDRLSLxTCs6DgfKuEwdoYt9Hl3oOwPD5gVjEi
 QJLds9FA8laUeBLHpyPj6YqKoMzAdfFUNv4BzczwoUHvh/SKqRs5+Jvi1Q3lXQMqqBO2
 9iAC14NpXB2VG/TV5d7E49paeO0lnx4QRYers4JkA0Ry7FPdk5qDYrB37WOTUq329drL
 5bUQ==
X-Gm-Message-State: AOJu0YzdERuLMSo68n30+e65HUwP6hwL+6XaDYdOtBDAg8p2CWI9L/4P
 Dmt7TxBEDykWWOC6v+mPiNQ0HsGq1s8qr3lWkVOURTPWQaBZgZygDa+dkJlAbU27H6bhP/kvgCQ
 X4CMWN8kXYPHDttjQr6uhO3vIUYHDQLIbRW1NSNiaogkhuumAPSeAImFo
X-Gm-Gg: Acq92OHjZAMVwsjTz7c+JA3JKZSBi16FEj2i84y9qPOni3ZkoWxI+p1ainv8qFwPg4g
 UL7StqNtsmzJCQ8Xqj9SFg5jTTfi5OuVoAL8EAgbXvTN3btj2G2XBup6TXv8GNOsZMQsY6HyG/v
 XVxwmXzK1aRupprzgEwjLPbc0sZYgUxLUcnCUk10S7HnrXB24MZjAdZhUWmlgsMFMVStmUGAxtQ
 +O8nQB3/wlth0HCCHLXX/Ucse5mIzr2zci7t2LWK/ehVD2p/fPHVPlOxg7Ba8ik7MVahY5OfYyH
 3C2sT6Mu1f8/sJB/QnCZsx3EjeQQ9HPIkNlLyizyHdJ9HpiaMCQK8G+zrFxYC5AxqgJjuyx2bDc
 NSGDd5bYkpWeQRB3WoYNFsnvlGpffr5Del/LwlrqxKueELEz6Iq/wy3bzV72EONqKFPdeRsdjaQ
 DcGUTVUd7M3hPDceiEc091XPkB0Hc=
X-Received: by 2002:a05:600c:a117:b0:490:c2a3:23d0 with SMTP id
 5b1f17b1804b1-490c2a32441mr238715505e9.35.1781008198747; 
 Tue, 09 Jun 2026 05:29:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a117:b0:490:c2a3:23d0 with SMTP id
 5b1f17b1804b1-490c2a32441mr238714675e9.35.1781008198194; 
 Tue, 09 Jun 2026 05:29:58 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d2d11asm423031295e9.1.2026.06.09.05.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:29:57 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 09 Jun 2026 14:29:03 +0200
Subject: [PATCH v2 1/2] igvm: replace raw uint32_t with igvm library types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-igvm_optional-v2-1-b1f1f08dc40e@redhat.com>
References: <20260609-igvm_optional-v2-0-b1f1f08dc40e@redhat.com>
In-Reply-To: <20260609-igvm_optional-v2-0-b1f1f08dc40e@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use IgvmVariableHeaderType and IgvmHeaderSection in QIGVMHandler and
qigvm_handler() instead of plain uint32_t, so that each field's purpose
is clear from its type.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index c347d0c17e..8bb5750768 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -102,8 +102,8 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        Error **errp);
 
 struct QIGVMHandler {
-    uint32_t type;
-    uint32_t section;
+    IgvmVariableHeaderType type;
+    IgvmHeaderSection section;
     int (*handler)(QIgvm *ctx, const uint8_t *header_data, Error **errp);
 };
 
@@ -132,7 +132,7 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_madt },
 };
 
-static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
+static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType type, Error **errp)
 {
     size_t handler;
     IgvmHandle header_handle;

-- 
2.54.0


