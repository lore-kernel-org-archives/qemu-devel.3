Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E811DCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 18:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rud8D-0005ED-Ie; Wed, 10 Apr 2024 14:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rud8B-0005E0-NF
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:57:11 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1rud89-0005NU-H6
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:57:11 -0400
Received: from juju-98d295-prod-launchpad-16.localdomain (scripts.lp.internal
 [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 409A040D7E
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1712775412;
 bh=/taGtnhwPVeJ8jB/9SN63GbQEkltlKVP394REHhNQNA=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=ZD/vswix9VA5tQU5ord8mEo0rXhCmyhhxbchhk01s9N5HeiIK5//Ic/HZTdtm2ZY0
 j1US+Ct5sx3Y0+eBly+0uXZbjssRNyLF43N7tFnJwSwKFYKFTuC1QfEXbMW3DWc/MC
 gnbrsdl+PmhtLMF+VV95B8JqXJqswAS7lgNF7GkVBrnsRriW2680TU/neANzq+5Yk6
 OVgo9MOVG7NthIrHytuPd5q3jcuIS6gLKAPUgMNh/kXEvezv/mXqIgJv1A47eGO3Lv
 7/zITG3lt9zptcfcSu+e6cDpj1U8neAOzrzjCdVjneW0w4GJuoSlHJl+juT6bmzlJc
 oTe9nfWqwg7wg==
Received: from [10.131.215.246] (localhost [127.0.0.1])
 by juju-98d295-prod-launchpad-16.localdomain (Postfix) with ESMTP id
 61006822E2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 18:55:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2024 18:47:36 -0000
From: Felipe Alencastro <1926249@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=charm-nova-compute; status=New; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajkavanagh falencastro paelzer
X-Launchpad-Bug-Reporter: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer=29?=
X-Launchpad-Bug-Modifier: Felipe Alencastro (falencastro)
References: <161950185235.16798.6764584356070146852.malonedeb@chaenomeles.canonical.com>
Message-Id: <171277485620.3488267.12063175722171766544.malone@juju-98d295-prod-launchpad-2>
Subject: [Bug 1926249] Re: postcopy migration fails in hirsute (solved)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="aec24aef7a9042c99ef3e238d8b0ca01df9e1a9f";
 Instance="launchpad-scripts"
X-Launchpad-Hash: ec46d22d33d7f624e4e38be2fa02c4bbff9d9ec5
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1926249 <1926249@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi @ajkavanagh, this affects focal-hwe, jammy and will affect any new
releases unless this sysctl is set to 1.

** No longer affects: charm-nova-compute

** Also affects: qemu
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Also affects: charm-nova-compute
   Importance: Undecided
       Status: New

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1926249

Title:
  postcopy migration fails in hirsute (solved)

Status in OpenStack Nova Compute Charm:
  New
Status in qemu package in Ubuntu:
  Invalid

Bug description:
  FYI: this is an intended change, can be overwritten via config and
  this bug is mostly to have something puzzled users can find via search
  engines to explain and solve their issue.

  postcopy migration can in some cases be very useful
  =3D> https://wiki.qemu.org/Features/PostCopyLiveMigration

  But with Hirsute kernel being 5.11 that now contains the following upstre=
am change
  =3D> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dd0d4730ac2

  Due to that postcopy migration will fail like:

  + lxc exec testkvm-focal-from -- virsh migrate --unsafe --live --postcopy=
 --postcopy-after-precopy kvmguest-focal-postcopy qemu+ssh://10.85.93.248/s=
ystem
  error: internal error: unable to execute QEMU command 'migrate-set-capabi=
lities': Postcopy is not supported

  This will also apply to e.g. a Focal-HWE kernel once on v5.11 or to
  Focal userspaces in a container under a Hirsute kernel (that is the
  example above).

  This was done for security reasons, if you want/need to re-enable un-limi=
ted userfault handling to be able to use postcopy again you'd want/need to =
set the control knob to one like:
  $ sudo sysctl -w "vm.unprivileged_userfaultfd=3D1"

To manage notifications about this bug go to:
https://bugs.launchpad.net/charm-nova-compute/+bug/1926249/+subscriptions


