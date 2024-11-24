Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0279EE66887
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 14:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFDWk-000188-Bo; Sun, 24 Nov 2024 09:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <retpolanne@posteo.net>)
 id 1tFDWf-00017s-SD
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 09:23:49 -0500
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <retpolanne@posteo.net>)
 id 1tFDWQ-0002bO-Ns
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 09:23:37 -0500
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 4D3C9240101
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 15:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1732458208; bh=2MJGTHtwie0rwB93olR2WoDlfQqyQr9af8HZtlELRSU=;
 h=Message-Id:To:Subject:From:Date:MIME-version:Content-type:
 Content-Transfer-Encoding:From;
 b=fPBbj6xCnYnEFvy3vO6WbeET/cQMYaxZZUywaWh/j7PThUJTS93INe/xGUeyZffZk
 YevAMLex2Ipcbyu6Tju7eV8AuuBsh7gKByQafdfJy1/EYW8V0cKH3aANnabud7VpZ6
 cdGObhZdmCcq6uMXBzT+GBTZCJ4J4dxEcu3D7qp9teYB5feKKnBZGRLa7QANCJnu3P
 L9fuOqGF3ShPG7+j7VANfRpQLQO1jDFv6Euzma8xoXDaO0GXJO3IJXZF0SytSAy9nL
 sv0WagX6ySDwP4PsxwdQlbczJjMuFSVHrsCiGHz2GBXW92Yi69L4jTUinm18c5zgNE
 kTIKFXy1cqqAA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4Xx9zz0DxCz6tn4
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 15:23:26 +0100 (CET)
Message-Id: <m2wmgsiudo.fsf@posteo.net>
To: qemu-devel@nongnu.org
Subject: Onboarding QEMU Firmware Configuration to other machines
From: Anne Macedo <retpolanne@posteo.net>
Date: Sun, 24 Nov 2024 14:22:29 +0000
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=retpolanne@posteo.net;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


Hello!

How should one port fw_cfg to other QEMU machines?

Context:

- I found a possible bug on the Debian builds for Raspberry Pi 4 that is
  only triggered when I try to launch it on QEMU;

- I wrote an issue on systemd (I thought it had something to do with
  logind) and they requested me to only fill bugs if they show up on the
  upstream.

- I tried baking systemd with mkosi – however, to test with mkosi and
  qemu, it uses fw_cfg [1] which seems specific to the virt machine on
  ARM.

- Opened an issue [2] and started working on that [3]

However, I still don't understand exactly how fw_cfg works. My current
understanding is that it is a device that, when connected some memory
mapping will happen on the guest so that it can access this memmap.

TL;DR which steps should I take to onboard fw_cfg to machines such as
raspi4b?

Thanks!
Anne


[1] https://github.com/systemd/mkosi/blob/6c33859a1b445e0bff19d9e7f28158140893a3e4/mkosi/config.py#L456

[2] https://gitlab.com/qemu-project/qemu/-/issues/2695

[3] https://gitlab.com/retpolanne/qemu/-/commit/86fca16555385c3685b7a1489a9cfaa255e148cf

