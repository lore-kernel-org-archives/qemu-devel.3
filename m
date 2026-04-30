Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C16CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV60-0004d2-Uh; Thu, 30 Apr 2026 13:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5v-0004bD-5N
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5t-0004CA-Ne
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kz2wfnUz1BOskTT/QiVT/TnOM7nwydx26ZqtDqu0C78=;
 b=LfFv25YR+mdvhVP0JTCFFBCJokGNCscpTRsd4QeLxZs7Gd7TXKDMCldeB/zFKSWBWlRSg2
 hKPj54b1LGXy9SaTztSBRfEwt2i6/R2R13+Pn8la2u26mFzP7bDWBoeeXvbs+ZASjmTpio
 LZp/6kooDedQ3cYLRayUC6Cs3EdxXpM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-rOFMT4RIOqaMM8s07gS-JA-1; Thu, 30 Apr 2026 13:22:28 -0400
X-MC-Unique: rOFMT4RIOqaMM8s07gS-JA-1
X-Mimecast-MFC-AGG-ID: rOFMT4RIOqaMM8s07gS-JA_1777569748
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b0312bb1dcso29573426d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569747; x=1778174547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz2wfnUz1BOskTT/QiVT/TnOM7nwydx26ZqtDqu0C78=;
 b=OqyxnTA8Ht72cRD/GWpAqrjFekh18XoZsZIEBjj/OOKOT2n/fikNG2PRn+ra0LgPb0
 FYRDxBs6bBZYJ63MJIUXOzqT9iUsVc7hYIWsGSJ0f/h5AGky8HoTIk+vA2pfrtJ5EiTJ
 HcyizPJ7wWjUdCd4TAoaIZqLFGVDc+1PZXZI6HeN0U/MEaHX4+2AHtH8WYry2rS9Yrio
 a+cEheCWUjKcb+pTMBfzzVlwg1+aBBpFr2dsehsh2EmdPRnEdLZEzmcjZVDCgQ84XPMM
 fJ/6jk0eJeaaOz5ASNDRTXAcqHUSBRCOQgN35Bb99PG/k6RppkBPUBuQLMnSJz8qcy+q
 tTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569747; x=1778174547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kz2wfnUz1BOskTT/QiVT/TnOM7nwydx26ZqtDqu0C78=;
 b=tHvZmX4t+ioetO459oLvsTBvoR2KH/ao4QBhM1zefwaCwZHSWF+r69rNT5tjvy1g9+
 iTJsigEv2ID9xAO1LAJysSQKXBWtvcWYKQrDqtWvsxUAC8Jo6PsuoQ1IFaykf8vK3ovW
 BHLrhyAesZ7eTWVkz1dLzJYsmlOPaRdjao/IEdREFMRAEn7uIy+ItHraKUgIzFE4cTro
 fGbEFm4cUO4dXmDm0aC7jEVXW2Z2DWHwb4dj98w+AGVYnsxc9t/wkj4BcA3hipe2CKUk
 2DKbuPfOgOzzLcNQ04ny7BnIUHSVB8xpVMOHYoQ6YZBwURUA3WeyKBrJlkVl0mrZs4+o
 3WAQ==
X-Gm-Message-State: AOJu0YyjmxGreYaxor0Jf6oD7tiPjejwhH/DJqQ/8FvSbUSUa4Sh004L
 TsgLKQjk5iXX2+AX4Vbci9g83ROAyZucKxCGcyufMeaYHrlpR0EzXY2pWWErzw/XfeiRgsWhbSX
 4IVlk0qRUJOwrEWQA55fZcUpmMUfGg+fZHy2c75ztSujochk5IjhbqR6bg+0TwF36w5g0V0QYwP
 zRzhlSGn+BLWIKsWAsJd9NA9cvB4QMIxW8VF5TVL/o
X-Gm-Gg: AeBDietWfisDQXtcYRATi20+250mSBqhenmt4ojdppKePPoz72cY/JomV5sJz7BT1CS
 qp6qCIgk7ccI4S5Ug5Xx5oiHVnQL/UPPTeGGraYOk7kGID6q6ciqffAXFBdgG1oxe6X1qfiwoG8
 8xGE3jdqYzEPHntEPQe8g33LFaW/hkizRYIKrRLBIejpOCWCSNNbsHPrS9MNrXlaY0VVE2NeyEK
 ZmAxes0G8lJuj8N49NE9H7Yuli5kLz4ygHgad07mqrgaKR9GC6Yfb73V1gtnaEXRwvc6ISm8hac
 boSk1UziRXb+ebcoLQ95ZldfRHwKJuPDXvqJ44hlO0H/ZlDTLLaY+GYBtmcRRk1iUfTa+wcTOx+
 kV+EH5Vf0QNcC8vtmfQMV3m12nlmI80oEF4xlWibvqddNT/+b0ZD0kvBQuqqOVUyUcA0DFm/VwW
 FGEsIfFYRRW4Be+ivKq6nogL0fadGJ9BjgTGs=
X-Received: by 2002:ad4:5d48:0:b0:89c:a2b2:8d44 with SMTP id
 6a1803df08f44-8b3fece427dmr57786376d6.39.1777569747341; 
 Thu, 30 Apr 2026 10:22:27 -0700 (PDT)
X-Received: by 2002:ad4:5d48:0:b0:89c:a2b2:8d44 with SMTP id
 6a1803df08f44-8b3fece427dmr57785406d6.39.1777569746519; 
 Thu, 30 Apr 2026 10:22:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff458289sm22496626d6.29.2026.04.30.10.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 05/58] kconfig: remove duplicate declaration of CONFIG_CXL
Date: Thu, 30 Apr 2026 19:21:11 +0200
Message-ID: <20260430172204.1006673-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Kconfig     | 1 -
 hw/cxl/Kconfig | 3 ---
 2 files changed, 4 deletions(-)
 delete mode 100644 hw/cxl/Kconfig

diff --git a/hw/Kconfig b/hw/Kconfig
index b3ed092f7a8..c109f5537b2 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -6,7 +6,6 @@ source audio/Kconfig
 source block/Kconfig
 source char/Kconfig
 source core/Kconfig
-source cxl/Kconfig
 source display/Kconfig
 source dma/Kconfig
 source fsi/Kconfig
diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
deleted file mode 100644
index 8e67519b161..00000000000
--- a/hw/cxl/Kconfig
+++ /dev/null
@@ -1,3 +0,0 @@
-config CXL
-    bool
-    default y if PCI_EXPRESS
-- 
2.54.0


