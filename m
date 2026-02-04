Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE9CEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniA0-0006kw-V9; Wed, 04 Feb 2026 14:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9z-0006kc-Dm
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9y-0007lu-2q
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s18vK9xXewEKiKTPHRSD0yzbqelRM/YB8pIVAnhGq/k=;
 b=dqgIEgQeAeZRXYFuTc+RRCK8I+ydMhLPbO17mk4FqZF4yIGKYx1R7eSI9OlWuBtLLe80Rz
 OKlqSa3yTvpfqBQiCzrppJmPK5Qn3DiiFrFjybHCy7fOcvHZj6Cb7jST8fOi6Uy2Rria/v
 CyXZTlmVnCvQF/IlQKARpAnBdyEfanA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-85o7qAniNRSpChL13iGwQQ-1; Wed, 04 Feb 2026 14:03:28 -0500
X-MC-Unique: 85o7qAniNRSpChL13iGwQQ-1
X-Mimecast-MFC-AGG-ID: 85o7qAniNRSpChL13iGwQQ_1770231807
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4801bceb317so1816025e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231807; x=1770836607; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s18vK9xXewEKiKTPHRSD0yzbqelRM/YB8pIVAnhGq/k=;
 b=uF3ElPnfj9fSy8Xj5XzcGSids7ju3t8NGJDlYISqQywAt9+Wbjy0wUtP+DfWMQEYfZ
 aap2O2Mqtws07eBGX+eVtfhgETYPwK4CAHVoxkQOGIyzXPACUIiPQkES1KhIbDCY5uIY
 PXUc0EqclUsiqgJwhCRvBJwUc/pq1iTdcDoQ0qnxMQCC+z3iZR0mZqmBe6yE7SUJn4jp
 cn73gl2d8Zo71loN9+4IbbIscCzgH1dAxmNfqScpS1YjvYYJqXQ1q0XqNJ5asUA6R9v2
 1Yu3mp55RfbGnvECYohdfnZtOTLV5RxLn9Y3994zAmYy4QX16qmR1K3nustOqCt/sRNk
 kgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231807; x=1770836607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s18vK9xXewEKiKTPHRSD0yzbqelRM/YB8pIVAnhGq/k=;
 b=SvvJbsLA7ZAkwErtwkUK5i0cWPXm0IDJvUWOHKKVmwGmagRuVOqEPP1edqG+djejcd
 Q+vb9Bhsqn219iyNjnskV4b9VGYHCiov/PMwvL17oUA735eZ5FlAw61Xd28o7ILtT/wm
 QxwHORjAFSa60dAvePd4cUY+6mtxLUUZq2sKrkWqnE8kAwHwjBUxKv+BOTe09qZYfKGU
 vpTglTxpfGLzQCcyzOz3k2UJUOrFh6vu78CMyoaHHayUbxj93rqkFg8OJaNedaSvI5j8
 4pY9c7J0ZzGLQl/DhzLrO0uRuOIZJKKCk1Ou9/mGXqeDukBghjGPCT5nOPjY8L0RMSuY
 xb2A==
X-Gm-Message-State: AOJu0Yz1NUBkOp1F34kutPyNx+G85IwUuoP6wPNoPhYcBnD0bWWqyiST
 pKcIi1TfsSnGqTZ6d61pVvzW4LnEz9zMe5CvpI8yO50Ytu06HLWPFyGmuu5Vr43YawbropJjztr
 YokuopAQ1nz/Nt2TxZ2tn1gJ/gAJ6yG75/Mnz0IBtwxphWPamscbQt/Q9KIwF56gmmKlCGUYDVY
 T6qc4XVktgrQoYjZiPLCz5LZF7WIR0zOpSZA==
X-Gm-Gg: AZuq6aI0a+Dd6YLd2g841qso+lWcRAmBrFIzUZrO+kwoheHradiza5q2Fshqr5u1+6l
 poYhgTk80kBWzHxBbNp2zAi3RTMdCAA8OAsLMWU82LtC0bHFAW3oRuq6pP2R7phDl/oB8bAXpHE
 s5h/09QUwOfiIbfIK+G794AqctN9ueGOB/5QFC2H6nZbUZ6LiVgLPaJtNElz/5Ro5SZbnZ9PdMP
 FjMFFzcgYZL0gq10nSqsOIax/t4au1lSaEVHyrYy+hgal28GyTGFDdzrX+bx0rxS7Zgabk36yvs
 RQI5TXBCHrrGhLlDc4uBAr8X33FhLTKJPpFScac3eTlj5qerMDtArN/kdX6zvQqjx4zA3tciBm8
 IjkDp4mWE/uafxy9d/a8ZTUcXamITgYKOvg==
X-Received: by 2002:a05:600c:848a:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-4830e930426mr55766135e9.12.1770231806690; 
 Wed, 04 Feb 2026 11:03:26 -0800 (PST)
X-Received: by 2002:a05:600c:848a:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-4830e930426mr55765535e9.12.1770231806153; 
 Wed, 04 Feb 2026 11:03:26 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d57009sm3188395e9.14.2026.02.04.11.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:25 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 15/51] pci: Block ATS requests when privileged mode is disabled
Message-ID: <462d06db2a1bbdf668701ac5654acb4b84d1a1cd.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251029105137.1097933-5-clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 9035caca92..90d6d71efd 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -3171,6 +3171,10 @@ ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
         return -EPERM;
     }
 
+    if (priv_req && !pcie_pasid_priv_enabled(dev)) {
+        return -EPERM;
+    }
+
     pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
     if (iommu_bus && iommu_bus->iommu_ops->ats_request_translation) {
         return iommu_bus->iommu_ops->ats_request_translation(bus,
-- 
MST


