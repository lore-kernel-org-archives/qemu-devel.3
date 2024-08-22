Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB388C5472C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 11:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5v3-00081M-1t; Thu, 22 Aug 2024 07:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh5uz-000801-7v
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:23:53 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh5ux-00035H-1O
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:23:52 -0400
Received: from 172.17.5.170 by INTERNET2.beckhoff.com (Tls12, Aes256, Sha384, 
 DiffieHellmanEllipticKey384); Thu, 22 Aug 2024 11:18:47 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1724325527; bh=SIQ8IZoTgjG5XCKNZwP8U/frCFZkYbzedAxopWNYOsE=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 O5Zw9qMTR470IwICQliD0SixmelYL/4Mkl0AE9II8OynxFKlXT2wWL5/fxiOAFgj740AyT/OyVysZc4SnLh0Cg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1724325527; bh=SIQ8IZoTgjG5XCKNZwP8U/frCFZkYbzedAxopWNYOsE=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 s21goSICl+7BPDfjlIVZG0WUAJWEJW7nHZfVzYaDW/TyTJDNZI88Gcw/oTSX7hc7lS995O82M5ggb9ZE6b3X4mXhz45qUfF3y8+iEERmK180VtFFz9f1IkMBxSYLfSp228OspfZKoKPH593zoBHcb+KhEAlrPeNGeJ/ZvJfqNbFQHJQ7fm/hTd+YndQfdCo+IV35uMgL4DfMj8Wbq1zce2SmwYtv0jQT+aIz4W2jLyFRKUdgRTbz12QhNTTR6zy8inQBgp7qbbqgKd8fCrbCcX8gA+rBCuqVr7Tsc510L5dYe9M+9UdaS5n/1FiUaCpXESS911Vl8GSDsuazOAR8wQ==
Received: from corvink-nb.c.koehne.headscale.beckhoff.dev (172.17.61.20) by
 ex04.beckhoff.com (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 Aug
 2024 13:18:45 +0200
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: <qemu-devel@nongnu.org>
CC: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: [PATCH 0/7] vfio/igd: add passthrough support for IGDs of gen 11 and
 later
Date: Thu, 22 Aug 2024 13:08:25 +0200
Message-ID: <20240822111819.34306-1-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.61.20]
X-ClientProxiedBy: ex01.beckhoff.com (172.17.2.168) To ex04.beckhoff.com
 (172.17.5.170)
X-OLX-Disclaimer: EX04.BECKHOFF.COM
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

=EF=BB=BFHi,

Qemu has experimental support for GPU passthrough of Intels integrated grap=
hic
devices. Unfortunately, Intel has changed some bits for their gen 11 device=
s
and later. To support these devices, we have to account for those changes. =
This
patch series adds the missing bits on the Qemu side.

I've tested the patch series on an ElkhartLake and TigerLake device. On the
guest side, I've tested an EFI environment (GOP driver), a Linux guest and =
a
Windows VM. The driver of all guests are able to use the GPU and produce an
output on the connected display.

Corvin K=C3=B6hne (7):
  vfio/igd: return an invalid generation for unknown devices
  vfio/igd: support legacy mode for all known generations
  vfio/igd: use new BDSM register location and size for gen 11 and later
  vfio/igd: add new bar0 quirk to emulate BDSM mirror
  vfio/igd: add ID's for ElkhartLake and TigerLake
  vfio/igd: don't set stolen memory size to zero
  vfio/igd: correctly calculate stolen memory size for gen 9 and later

 hw/vfio/igd.c        | 184 +++++++++++++++++++++++++++++++++++++------
 hw/vfio/pci-quirks.c |   1 +
 hw/vfio/pci.h        |   1 +
 3 files changed, 160 insertions(+), 26 deletions(-)

--=20
2.46.0

This email contains confidential information. If you have received it in er=
ror, you must not read, use, copy or pass on this e-mail or its attachments=
. If you have received the e-mail in error, please inform me immediately by=
 reply e-mail and then delete this e-mail from your system. Thank you
=20
Diese E-Mail enth=C3=A4lt vertrauliche Informationen. Sollten Sie sie irrt=
=C3=BCmlich erhalten haben, d=C3=BCrfen Sie diese E-Mail oder ihre Anh=C3=
=A4nge nicht lesen, verwenden, kopieren oder weitergeben. Sollten Sie die M=
ail versehentlich erhalten haben, teilen Sie mir dies bitte umgehend per An=
twort-E-Mail mit und l=C3=B6schen Sie diese E-Mail dann aus Ihrem System. V=
ielen Dank

Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Bec=
khoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075




