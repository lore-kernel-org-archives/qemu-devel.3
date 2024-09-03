Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33421CD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 09:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slPpb-00058g-Sd; Tue, 03 Sep 2024 05:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1slPpZ-00057s-AJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:28:09 -0400
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1slPpW-0004Tr-Sq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 05:28:09 -0400
Received: from juju-98d295-prod-launchpad-4.localdomain
 (appserver-3.lp.internal [10.131.215.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 362DD40F06
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2024 09:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1725355684;
 bh=5mT5D25fGnlTXPRC9AleRibYMHMBpi2hBh5N42OQz4o=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Subject:Message-Id;
 b=QgLkPnzdgESjH+8XtLZfnqTqEvSusVXbAXZtvQ2LQy6ETsvKqyrCHktsY8PLnrlK7
 nn4k1aKnD2DFcxlk3qB66Bgkqf1nT+pkHno9mlelfN+CJ6qBl7QLvBTOBYvqESfRYN
 ISMlxTCcnvQXmnxI5mT/kHD7Sg+YgHRyXVa3P5vbu0eFyOppHWhd9RwzGgJTWBbdk7
 NP8zsuEugtCFnwvU7Hd1P/JT1k1m/nVKyR8JRsPQshfl5PBqciI1Krhb6Kn36xnaf6
 veP90/k0gKPIFNUW3/yOWn0lQ9/k9Uyu+R9Ogel7NFYqYCQc0gDHLgsOX7wdKDUzy6
 GaYtcryZjWbuA==
Received: from [10.131.215.88] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-4.localdomain (Postfix) with ESMTP id EA0FC7E15A
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2024 09:28:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Sep 2024 09:27:37 -0000
From: Launchpad Bug Tracker <2078790@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mehmetbasaran
X-Launchpad-Bug-Reporter: Mehmet Basaran (mehmetbasaran)
X-Launchpad-Bug-Modifier: Mehmet Basaran (mehmetbasaran)
References: <172535521411.2600491.6207708752026464339.malonedeb@juju-98d295-prod-launchpad-3>
Subject: [Bug 2078790] [NEW] jammy qemu x86 int3: 0000 [#1] SMP NOPTI 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Message-Id: <172535565716.489434.15090322831079151743.launchpad@juju-98d295-prod-launchpad-4>
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1b1ed1ad2dbfc71ee62b5c5491c975135a771bf0";
 Instance="launchpad-appserver"
X-Launchpad-Hash: b188819e674bcf408636ac0cc60f67fd49b0af96
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 2078790 <2078790@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

You have been subscribed to a public bug:

jammy:linux-lowlatency-hwe-6.8 6.8.0-44.44.1~22.04.1 qemu-x86 QEMU
Standard PC (i440FX + PIIX, 1996)


Recently (2024.08.05), I have been seeing this issue with ADT:systemd:upstr=
eam-1/2 test in which kernel panics/prints a stack. I have seen this with j=
ammy:linux-lowlatency-hwe-6.8 and jammy:linux-ibm-6.8. Stack trace is diffe=
rent everytime because kernel receives an interrupt, drop what it is doing,=
 and crash when handling the interrupt.

I think this is an issue with qemu and not kernel. For jammy, we are
using qemu 6.2 and there are some fixes related to x86 interrupt
handling in 8.x
(https://lore.kernel.org/lkml/20230705215008.GD17440@redhat.com/T/). I
propose we create a launchpad bug and trace the issue. If I am correct,
we shouldn't see this in noble. And we should occasionally see this in
5.15 jammy kernels (and more frequently with lowlantecy kernels).


Meanwhile see comments below for some stack traces;

** Affects: qemu
     Importance: Undecided
         Status: New

--=20
jammy qemu x86 int3: 0000 [#1] SMP NOPTI=20
https://bugs.launchpad.net/bugs/2078790
You received this bug notification because you are a member of qemu-devel-m=
l, which is subscribed to QEMU.

