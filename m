Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D321C54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHuF-0005lq-U5; Wed, 28 Aug 2024 08:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sjHu9-0005Jb-Lp
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:36:07 -0400
Received: from internet2.beckhoff.com ([194.25.186.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sjHu5-0003AE-4q
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:36:04 -0400
Received: from 172.17.5.170 by INTERNET2.beckhoff.com (Tls12, Aes256, Sha384, 
 DiffieHellmanEllipticKey384); Wed, 28 Aug 2024 12:35:57 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1724848557; bh=dw5PZHWoP2rzADIQR+kXL/3fIW9nweVv3qfNfRdXkvc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 aulXHQteHcrI1BCGTPLKbUBPk2jciTXXqbuWVEaitvf8zBwHpD+AO7Oxy/c9qb1eJbNvpyl6ATzdSAtfiIChCA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1724848557; bh=dw5PZHWoP2rzADIQR+kXL/3fIW9nweVv3qfNfRdXkvc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 hWkMCfUKZVlC5WP/zF1rKcv3IKZaEF7Z3Xr2tla2SVCkAoP/M4WwqqrF6fiyGJwWR09/IuBZPpL7NOFh95MMvlkGlcXKKbKiicERMNDTrNEXeHrrMSTL2fe1xG13WP3TDiHHxsGpBkOOAPziUViPOGEShuK7x7ZuAewWHu7kLzCthgTCeY5/ooYAXVMYQW0+pZ8rV34w3cfbaezFaiL2AVMsnoi2zsipZVDhzHrTIunja/lxD2Hcibw264Ugl2abOl3MTBwZ5ZZ8Ami8Q8gC5Aupo/vz6/7QQVky29+DsnirSuWS0sVUI/yCRJgBh6iE9NTMBqkmtvknhRzErUZAcA==
Received: from corvink-nb.beckhoff.com (172.17.128.201) by ex04.beckhoff.com
 (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 14:35:55 +0200
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: <qemu-devel@nongnu.org>, <c.koehne@beckhoff.com>
CC: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: [PATCH v2 1/7] vfio/igd: return an invalid generation for unknown
 devices
Date: Wed, 28 Aug 2024 14:35:43 +0200
Message-ID: <20240828123549.83293-2-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828123549.83293-1-c.koehne@beckhoff.com>
References: <20240828123549.83293-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.128.201]
X-ClientProxiedBy: ex03.beckhoff.com (172.17.2.169) To ex04.beckhoff.com
 (172.17.5.170)
X-OLX-Disclaimer: EX04.BECKHOFF.COM
Received-SPF: pass client-ip=194.25.186.210;
 envelope-from=C.Koehne@beckhoff.com; helo=INTERNET2.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

=EF=BB=BFIntel changes it's specification quite often e.g. the location and=
 size
of the BDSM register has change for gen 11 devices and later. This
causes our emulation to fail on those devices. So, it's impossible for
us to use a suitable default value for unknown devices. Instead of
returning a random generation value and hoping that everthing works
fine, we should verify that different devices are working and add them
to our list of known devices.

Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index d320d032a7..650a323dda 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -90,7 +90,11 @@ static int igd_gen(VFIOPCIDevice *vdev)
         return 8;
     }
=20
-    return 8; /* Assume newer is compatible */
+    /*
+     * Unfortunately, Intel changes it's specification quite often. This m=
akes
+     * it impossible to use a suitable default value for unknown devices.
+     */
+    return -1;
 }
=20
 typedef struct VFIOIGDQuirk {
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




