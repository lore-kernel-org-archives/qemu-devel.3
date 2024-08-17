Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B08BC531DC
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 15:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfLIX-0000rF-CV; Sat, 17 Aug 2024 11:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sfLIJ-0000nc-3K
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 11:24:43 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sfLIF-0002f7-RT
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 11:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723908275; x=1724167475;
 bh=CjblmEfzsVbwpdJZH2WOVldzI90du0JNXBmu9Msc//o=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=FL1yPe4RO7U04tnjpcOqMRIuFtrxzYklX0Vwlbgqph+ETNUKeAqj1yBSNqBm/uglN
 ULdWLJc+XJye9CXk8JauGxErplFuputHwj8smv2q3Z4Nl/7OjZWOZHlaRvB2F/0lyw
 eXfkfRFCQRCrwpN5k4xi4pzUu/deuhexJ1iuT81nzxidtUYrG/ZDNkFpvKcePSKYAc
 am+FLep8tqZCmo+1YejPZ5WCXTDwD1ksUZb7qw4f5yLEgQaYNEOf0hV4nWdpayih9b
 EivUiuRZKTUNV5tIF3cKhDoONb5yrxuD54RLrsrE3QKY60qzduYVDV2ewvuj36NZzI
 /zRHXDs/7Dpiw==
Date: Sat, 17 Aug 2024 15:24:31 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Joelle van Dyne <j@getutm.app>
Subject: [PATCH-for-9.1 v3 0/2] hw/i386/pc: Fix vmport option handling
Message-ID: <IrhtgC0oPtusYG_0cOwVYOuOr0UpK0YLNYNtxDQ2_lqgtcVBzVr-gYNUzggvmO9tHdmf65aO8Zoab-ERkyQbtjx9u2VuHEYZ_3r0Wb25huw=@szczek.dev>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 26892783fb3aab3954f740c84248789866fab301
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=kamil@szczek.dev;
 helo=mail-4323.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Some time ago a new option to disable the built-in i8042 controller was
introduced (commit 4ccd5fe22feb95137d325f422016a6473541fe9f). This
however introduced a side-effect - disabling this controller resulted
in vmport's creation being omitted, regardless if it was enabled
implicitly or explicitly. This patch series aims to clean up vmport
option handling and introduces additional validation for these options.

Changelog:

v2 -> v3:
  - Move vmport=3Dauto -> vmport=3Don/off conversion to a shared code path
  - Reword documentation for the vmport option, "and/or" =3D> "or"

v1 -> v2:
  - Exit with a useful error message instead of issuing a warning

Kamil Szcz=C4=99k (2):
  hw/i386/pc: Unify vmport=3Dauto handling
  hw/i386/pc: Ensure vmport prerequisites are fulfilled

 hw/i386/pc.c      | 14 ++++++++++++--
 hw/i386/pc_piix.c |  5 -----
 hw/i386/pc_q35.c  |  5 -----
 qemu-options.hx   |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

--=20
2.45.0



