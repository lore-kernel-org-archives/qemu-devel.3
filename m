Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5CD107BCCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15wy-0006uk-NW; Fri, 13 Mar 2026 13:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69b43f80.v1-3d41f353656f42f1b44bd5db9d5811ec@bounce.vates.tech>)
 id 1w15wu-0006ta-60
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:05:20 -0400
Received: from mail134-15.atl141.mandrillapp.com ([198.2.134.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69b43f80.v1-3d41f353656f42f1b44bd5db9d5811ec@bounce.vates.tech>)
 id 1w15wq-0001Ly-4f
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1773420416; x=1773690416;
 bh=YVESgmaHRMpbf7+5tHUgQMMGFPJarDui+ShzAbAzOzM=;
 h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
 b=BRC6lsby6gFZ4a8xXvpuYAQHzKvFgNyR/cjJzmjMCocAY17z7n/pqkzpbWmzeY7iT
 JQKEhIjHDRGLwYUMnVSHlk7Gm9Nu8GE8T7i3M7iRr/1Y2y9jPteuYJizawLBvsvIy2
 94sMvbB47GELxFL4nGVBpn4KP8gi8lISSlYVIq1JmSr9nYbXVL3RaeY68HR0D5SUH0
 OPM9Kz74oU4FPAtNlpIlt/zmeGZ/b7FoJ2XmwKAYs3YqJcOPLTfiHHBkMoVM06r953
 K67YUEG6ACoDpWQ3NhWX8yTgmDIFOEpZ6YkZscJQxyNf9kRko4STGTmKUZy6juUkOo
 eaWZuGbJcY3rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1773420416; x=1773680916; i=thierry.escande@vates.tech;
 bh=YVESgmaHRMpbf7+5tHUgQMMGFPJarDui+ShzAbAzOzM=;
 h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
 b=IujO/Oye3h8RZR2kw8gwBbwpAYTcodSvj/J5aHf1R0naDYFbLmt+VMbYd+yCen+Nm
 Xq5QSQwlX9N5U/ubQi+weCDmXgjxBuBHTUv1XE3WsmOe1p8K//Kh+D2Nj0bmuI8LDm
 zaTIfaqNoKp3GoH+/lW0huJ4x41G4ZeuHDr/2YViOlhIxM0VfOC8goH6BKrgtFtlsA
 z1tFxMXWTTgYsLQlTNxOaRmxs5nuA9hGxkv5u16HIgLg6dF4MDpKfyzwU5mjP2a1zl
 DXeXJYX9dDswCum7OJWDn2zw/nk3YsI9BiKudTYoi7YvMu9Vf2JJeiPL9mzgHFaS5O
 xP4Sjruv0JKWQ==
Received: from pmta10.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail134-15.atl141.mandrillapp.com (Mailchimp) with ESMTP id
 4fXVkm36YNzPm0PqZ
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 16:46:56 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?[PATCH=200/4]=20Xen:=20Add=20Q35=20initial=20support=20for=20HVM=20guests?=
Received: from [37.26.189.201] by mandrillapp.com id
 3d41f353656f42f1b44bd5db9d5811ec; Fri, 13 Mar 2026 16:46:56 +0000
X-Mailer: git-send-email 2.51.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1773420415146
To: qemu-devel@nongnu.org
Cc: "Thierry Escande" <thierry.escande@vates.tech>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Anthony PERARD" <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Message-Id: <20260313164649.794591-1-thierry.escande@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.3d41f353656f42f1b44bd5db9d5811ec?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260313:md
Date: Fri, 13 Mar 2026 16:46:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.134.15;
 envelope-from=bounce-md_30504962.69b43f80.v1-3d41f353656f42f1b44bd5db9d5811ec@bounce.vates.tech;
 helo=mail134-15.atl141.mandrillapp.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch series introduces Q35 chipset support for Xen HVM guests. This is
based on the work from Alexey Gerasimenko (See patchset [1] for reference).

This series does not implement device passthrough as this will need more work
on the Xen side to support multiple PCI buses. Since Q35 chipset does not
support device hotplugging and with current Xen mechanism for device
passthrough, they have to be plugged to a new PCIe root port, i.e. not the PCI
bus 0.

As a first step for Q35 guests support, this series implements:
- Legacy interrupt routing for the ICH9 LPC bridge (i.e. not IOAPIC)
- Xen HVM machine initialization in pc_q35_init()
- Access to PCIe Extended Config Space
- Fix for incorrect values and usage for PCIEXBAR masks

The corresponding patchset for the Xen Project has been posted at [2].

[1] https://lore.kernel.org/xen-devel/cover.1520867740.git.x1917x@gmail.com/
[2] https://lore.kernel.org/xen-devel/20260313163455.790692-1-thierry.escande@vates.tech/

Alexey Gerasimenko (2):
  pc/xen: Xen Q35 support: provide IRQ handling for PCI devices
  q35: Fix incorrect values for PCIEXBAR masks

Thierry Escande (2):
  q35/xen: Add Xen support for Q35
  xen: Handle PCIe config space size in cpu_ioreq_config()

 hw/i386/pc_piix.c         |  2 --
 hw/i386/pc_q35.c          | 12 +++++++++++-
 hw/i386/xen/xen-hvm.c     | 38 ++++++++++++++++++++++++++++++++++++++
 hw/isa/lpc_ich9.c         | 16 +++++++++++++---
 hw/pci-host/q35.c         |  6 +++---
 hw/xen/xen-hvm-common.c   | 11 +++++++----
 include/hw/pci-host/q35.h |  4 ++--
 include/hw/xen/xen.h      |  5 +++++
 stubs/xen-hw-stub.c       |  4 ++++
 9 files changed, 83 insertions(+), 15 deletions(-)

-- 
2.51.0



--
Thierry Escande | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


