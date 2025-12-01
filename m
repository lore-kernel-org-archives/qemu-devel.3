Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A75DD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 12:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3Mk-0007o7-FO; Mon, 01 Dec 2025 07:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3Mg-0007jD-Ow
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:50:51 -0500
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([63.178.143.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3Me-0003ZH-Fb
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764593448; x=1796129448;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=GpvcrHoLLiCW8zGBZinEleXUqigeCd//NOhCARn/C6U=;
 b=FvQ/49MiXu7Pt4ZKrmqv4uB2Fehc5V70Jb/o85e8v3PPOZMQFjzrkok3
 qopNwoWsRuiiQm4pag5vca1RoEEnlavNziGLe7B9pEdj902q8OzGd28Ki
 wgCssnOtps9yhNg2Jiqcf9AwzBa5NFX8FOGT026kTrvVPQ9zDs65NGWcC
 AHWoZhc0TXx9U2jYV9/oVQV9wDUlj8FriE65zKVpwV2V7LWBAJhZyfYR4
 x9Rhf9dY3Nc0aF9gnC6M1aK/LbiKbc+6M5E4CLzWXhey5fP10u7DvvnjM
 x00aKuEUpvjUZqWe745S6fCjXZMdRx2h/RFVqpdLOww6jbeN/vYL5yzgY w==;
X-CSE-ConnectionGUID: lchPSLiMSzGAo1nB9rBOWQ==
X-CSE-MsgGUID: l7DBdsyYRs2puW5f/QC20A==
X-IronPort-AV: E=Sophos;i="6.20,240,1758585600"; 
   d="scan'208";a="5946528"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
 by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:50:25 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:27103]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.31.35:2525]
 with esmtp (Farcaster)
 id c9e37288-9386-4930-a215-6e6e56803d24; Mon, 1 Dec 2025 12:50:25 +0000 (UTC)
X-Farcaster-Flow-ID: c9e37288-9386-4930-a215-6e6e56803d24
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:50:25 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:50:24 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with
 mapi id 15.02.2562.029; Mon, 1 Dec 2025 12:50:24 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "Chalios, Babis" <bchalios@amazon.es>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: [RFC PATCH 0/4] vmclock: add support for VM generation counter and
 notifications
Thread-Topic: [RFC PATCH 0/4] vmclock: add support for VM generation counter
 and notifications
Thread-Index: AQHcYsEPTMhCf9QsoUSKU63ujcPAyQ==
Date: Mon, 1 Dec 2025 12:50:24 +0000
Message-ID: <20251201125023.18344-1-bchalios@amazon.es>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.247.161]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=63.178.143.178;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Latest specification of VMClock[1] adds support for VM generation counter=
=0A=
and notifications. VM generation counter is similar to disruption_marker=0A=
but it only changes when the guest has been loaded from a snapshot, not=0A=
on live migration. Its purpose is to notify the guest about snapshot=0A=
events and let it perform actions such as recreating UUIDs, resetting=0A=
network connections, reseeding entropy, etc.=0A=
=0A=
Moreover, the spec now describes a notification that the device can send=0A=
after updating the seq counter to a new even number.=0A=
=0A=
I have already sent the Linux changes to the mailing list here:=0A=
https://lore.kernel.org/lkml/20251127103159.19816-1-bchalios@amazon.es/T/#u=
=0A=
=0A=
[1] https://david.woodhou.se/VMClock.pdf=0A=
=0A=
Babis Chalios (4):=0A=
  acpi: fix acpi_send_gpe_event() to handle more events=0A=
  hw/acpi: add new fields in VMClock ABI=0A=
  hw/acpi: add VM generation counter field to VMClock=0A=
  hw/acpi: add ACPI notification to VMClock device=0A=
=0A=
 hw/acpi/core.c                               |  8 +++++-=0A=
 hw/acpi/vmclock.c                            | 28 +++++++++++++++++++-=0A=
 include/hw/acpi/acpi_dev_interface.h         |  1 +=0A=
 include/standard-headers/linux/vmclock-abi.h | 20 ++++++++++++++=0A=
 4 files changed, 55 insertions(+), 2 deletions(-)=0A=
=0A=
-- =0A=
2.34.1=0A=
=0A=

