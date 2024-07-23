Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFEFC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDCE-0003g8-UH; Tue, 23 Jul 2024 06:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCC-0003UE-Tc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCB-0001jQ-AX
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b1DVK7w17GPjd2vAQhHKtU0B8nNst/5eqxCLxdYr+cI=;
 b=i3GX1HB7tu+3OnPjXGKxg+gKrck0q7EohXOfKQoTSMR5/9C9aGTTx7YVog8MzsFpvryPt/
 CRIDLgGhvvGBui6Wrib+v98JGLR4QspjXwELpD5MAngvD3Wi10BXH1TTsgBV6D/fCVfQOk
 m5b0m/ihPNTGf5kxt3t9rrFVNhU2fBo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-izjAw0bnO_aiAP1cT9rKKw-1; Tue, 23 Jul 2024 06:56:36 -0400
X-MC-Unique: izjAw0bnO_aiAP1cT9rKKw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a77f48f2118so114452866b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732195; x=1722336995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1DVK7w17GPjd2vAQhHKtU0B8nNst/5eqxCLxdYr+cI=;
 b=S2CVHxuzpI7d6INg9Oe7KBxNCoJ9n8IVER+vdimkubbTswJ5xHU9HY47T0UmT7Haw6
 RXELq2CPXcPxEGpwkLDSB+x4DUOfjhwZul3jLOS3Ou8EnHVIRHyu2OjrhbU2MMdG4ZU8
 NG7Z31JmgRk4lO/+ME1VvpteeVPlLqr4Eehypyycxc10H3RtyA6URkL3qDCZGq1sQK1x
 x08grT8+Zx+i42f3u64QliPmsTa9Kjt3LKMf7gT2hely+Soi7/eOCeOrriThkr3qah8v
 nXTVRSMkKPOaC7duZvbXzfW/8z7K/hr8C9ot0qF3aro9Z7Oqtjf2o0OehXSXIN4NganK
 LQQg==
X-Gm-Message-State: AOJu0YzBkL+v4rWwNOl8/UDLFuBMoaXrUfANtdtMsdMXGkO5zaKMrmJ/
 jf5zVtSVAYcuCo/ooW3us07u6ND95qic2YpOC9nQeRAZOZ2x0Kw7QY1rXxka0LqRuKUMhdNHbp3
 /brxA2lyMkggOYEolVn6e7WR2OjHuc5Gxh5M9ZmtUeXn0Lv/Fx15cVFr/k9XdwLyuCJhLPhqUhS
 RPjbzUmEhKsksTELx2lH7GNhELVn9lZA==
X-Received: by 2002:a17:907:7282:b0:a7a:8a46:f613 with SMTP id
 a640c23a62f3a-a7a9435e5bcmr160969266b.26.1721732195034; 
 Tue, 23 Jul 2024 03:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2cGc4HmC1jkYl3tVsc6EFNcsxxNcYs8XGOgz+X8EBEMEx4tZlKp5tRu7/BV8q5mWHQ1rhmg==
X-Received: by 2002:a17:907:7282:b0:a7a:8a46:f613 with SMTP id
 a640c23a62f3a-a7a9435e5bcmr160966566b.26.1721732194567; 
 Tue, 23 Jul 2024 03:56:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a99524d1bsm55567866b.137.2024.07.23.03.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:56:34 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:56:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yi Liu <yi.l.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL v2 15/61] MAINTAINERS: Add myself as a VT-d reviewer
Message-ID: <e3f15732c479e6c4baa56af65f52d99fbfb5c417.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20240708032112.796339-1-yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7e9ced3e8..8ad64ff76b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3659,6 +3659,7 @@ F: tests/uefi-test-tools/
 VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
 R: Jason Wang <jasowang@redhat.com>
+R: Yi Liu <yi.l.liu@intel.com>
 S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
-- 
MST


