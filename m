Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B46C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTBM-0001SP-5d; Thu, 01 Aug 2024 06:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBI-0000hA-1l
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBG-0001p8-M5
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KzoSSfxzFy/AltDiDJD12Ne8GvrHuuX1y7PZ7HvTffU=;
 b=YrCksgqwa1Sv+P4rVk2yUuKc4ZvPd4Ko52ja3JR1cJna+8RSsxp2vIy3piP/pY1C6llzXh
 N5sixdAwZ3HkBk3EDI+aCzyvL71osfurXIhr2M7w/RplGY/1ZLAOX2gZdtdBNxXT/wGeFp
 434pbsaN1q9tUxXNepPjFuiEUxpS7KA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-AfM-eZEmNdajaST8dzTY-A-1; Thu, 01 Aug 2024 06:37:09 -0400
X-MC-Unique: AfM-eZEmNdajaST8dzTY-A-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a54b18f730so5761749a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508627; x=1723113427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzoSSfxzFy/AltDiDJD12Ne8GvrHuuX1y7PZ7HvTffU=;
 b=INtT9NmQSJRIEYIYFqGvarxUJVRd32Kn+itPm3ghUcR9FEzrymTTLjdzQ71A9xXXo7
 hy1qiX6tWTyNjpD8a0ZB2YmfVbNMk4SC5Id6oMEogtLILoQU1jTYsHp0BA/Z0tHZEwRC
 H3OrtLHoBTb6NbfU/8DJSQc1g9jsb/qkgyy2S8snC2x0dGzWCPhyJMLcHuuISAOu+T9w
 Z2NRUyiACJ0z60s4hnx+W+8PfiV+uz2i/5Fy+Vt5dGsCnu05CjpX+e7MZWg9pKn8UXrC
 c2rvRVXkBaMYi1bP1ljizJNP4fYB17Rgprb5tJzK8EybYgnK/4IgzJ/tVaY4CT22+Fo/
 5fFQ==
X-Gm-Message-State: AOJu0YwVxDOdpw65/mYk/vkyQYQCaj67bZHtij32e3JEk6Ikn6QqmU/X
 hhKyJaYePDgnAq4zxuzNOPtAQ5g74MRuiplnEBt93xwt6/RTGm3JiM4XJdUsJUSCTbpg0HxlZpV
 CYHXNxOkQDM+X7/w0dmy48V9b181gIAI7Fz+pJRdTmdzmdywYI1zZZEmF1RkRxJpU5whoMe5hqa
 /9zoru/QHdDf045pC3NhIynafYP9erXg==
X-Received: by 2002:a50:ed18:0:b0:5b6:d0f1:2947 with SMTP id
 4fb4d7f45d1cf-5b700aa032fmr1239339a12.34.1722508627198; 
 Thu, 01 Aug 2024 03:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIvThHvMtW5sJoSerW+OyivBrC7gPTnkY8H/LEcq9gqSmskBYGETWwhDA3yY/wwQgACj85yw==
X-Received: by 2002:a50:ed18:0:b0:5b6:d0f1:2947 with SMTP id
 4fb4d7f45d1cf-5b700aa032fmr1239307a12.34.1722508626463; 
 Thu, 01 Aug 2024 03:37:06 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590d81sm10070150a12.23.2024.08.01.03.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:37:03 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL 16/19] Revert "hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device"
Message-ID: <f1feffc4ef4b1c02daa5ce23fa8ad728c8ef7ce9.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This reverts commit 723c5b4628d047e43825a046c6ee517b82b88117.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f63182a03c..7cf9904c35 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,10 +1296,6 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
-    if (!pdev->enabled) {
-        return;
-    }
-
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;
-- 
MST


