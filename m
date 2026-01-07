Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A76CCF6BF0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 06:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdMl6-0000a8-Dy; Wed, 07 Jan 2026 01:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=460c69f5f=Moritz.Haase@bmw.de>)
 id 1vdMl5-0000ZQ-4X
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 01:11:03 -0500
Received: from esa10.hc324-48.eu.iphmx.com ([207.54.69.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=460c69f5f=Moritz.Haase@bmw.de>)
 id 1vdMl1-0004Gu-UC
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 01:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
 t=1767766258; x=1799302258;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QXsXVScF2JkeKh0MHEMlURpnMBcBRK7NfOf1QO0FmJw=;
 b=ocfL4daToTY1OJkRPweRBNqU4Je7o6VHrp0R9vB6VLQvU6XI6jAYbIws
 v2LpK5Vs0OurF5hNPkEkFmWBxOjV9zti58nd6vbxZjIgOyQUJiFAgxdIm
 kLYHG53/XWe58Be9RfmoDsN6eFR6BFgizDD2LUOYU5DY205xgzBHxxeUc M=;
X-CSE-ConnectionGUID: TNloV3JwQ9mXNNifhpSKSg==
X-CSE-MsgGUID: JGaWH5/CSvmdafVZarxDXA==
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa10.hc324-48.eu.iphmx.com with ESMTP/TLS; 07 Jan 2026 07:10:52 +0100
Received: from unknown (HELO esabb2.muc) ([10.31.187.133]) by esagw6.muc with
 ESMTP/TLS; 07 Jan 2026 07:10:52 +0100
Received: from smucmp20g.bmwgroup.net (HELO smucmp20g.europe.bmw.corp)
 ([10.30.13.181]) by esabb2.muc with ESMTP/TLS; 07 Jan 2026 07:10:53 +0100
Received: from smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44) by
 smucmp20g.europe.bmw.corp (2a03:1e80:a15:58f::1:86) with Microsoft SMTP
 Server (version=TLS; Wed, 7 Jan 2026 07:10:53 +0100
Received: from q1054628.de-cci.bmwgroup.net (10.30.85.214) by
 smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44) with Microsoft SMTP
 Server (version=TLS; Wed, 7 Jan 2026 07:10:53 +0100
X-CSE-ConnectionGUID: NzLYBoAVTci2soMcE7bB2Q==
X-CSE-MsgGUID: kebYgPO4S6G/ddwiXpJY4Q==
X-CSE-ConnectionGUID: EGVgF60JSiKjlyDuw8ra9g==
X-CSE-MsgGUID: cExvMODxQrq8DU1rj619kQ==
From: Moritz Haase <Moritz.Haase@bmw.de>
To: <moritz.haase@bmw.de>
CC: <berrange@redhat.com>, <forumi0721@gmail.com>, <laurent@vivier.eu>,
 <mjt@tls.msk.ru>, <nghiant2710@gmail.com>, <petrosagg@resin.io>,
 <qemu-devel@nongnu.org>
Subject: Re: Re: [PATCH v5] linux-user: add option to intercept execve()
 syscalls
Date: Wed, 7 Jan 2026 07:10:20 +0100
Message-ID: <20260107061019.318024-2-Moritz.Haase@bmw.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223072835.850855-2-Moritz.Haase@bmw.de>
References: <20251223072835.850855-2-Moritz.Haase@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp17c.europe.bmw.corp (2a03:1e80:a15:58f::1:46) To
 smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44)
Received-SPF: pass client-ip=207.54.69.29;
 envelope-from=prvs=460c69f5f=Moritz.Haase@bmw.de;
 helo=esa10.hc324-48.eu.iphmx.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping

https://lore.kernel.org/qemu-devel/20251128090132.2977069-1-Moritz.Haase@bmw.de/

Regards,

Moritz

