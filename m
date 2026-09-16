Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E5BC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6j2H-0004zu-PA; Wed, 16 Sep 2026 02:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tim.foerster@hetzner.com>)
 id 1x6j2E-0004zk-HN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 02:22:22 -0400
Received: from mail.hetzner.company ([2a01:4f8:d0a:203a::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tim.foerster@hetzner.com>)
 id 1x6j2B-00039P-Dd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 02:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hetzner.com
 ; s=lms2212; h=To:From:Subject:Cc:Message-Id:Date:Content-Type:
 Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=oo5HmiWHs7IS78Q/oqq8VMWuA47BIB2y85S3b4ZIULY=; b=ME8ynXZXiW9Ev8dQ5zQEpCIXZe
 7khZFkwiG4cgsQVs0ly3X0L8wUIzfx56cuAdVnwIApjwS217p1DH+sTOhTbsGUsW918BwBjUU+6HQ
 Kx8X6mhmKW/mKVNmsLqo1cHgFIiaAsRVgi/Ik3gJOYczlzGsqy7m2HPize1De7GEZIu6+HK6OdnQT
 AGCrp77lPx/tAXrfEl89nK0UilVAbLFu2nUkUc4sF0wMl8YaI3o/TvWXBgquUHsv2VoqGzD7iaoAo
 dVryNZaLQ2AhXt1YMRjWsQKSOZaATzrkWMUu5qUT+v6Z6x9tqzBgDw7H0FYNGFEMCUI2kooxTqUle
 veBXAs0w==;
Received: from [2a01:4f8:0:a52b:77ac:1d62:bf55:5140] (helo=localhost)
 by mail.hetzner.company with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.94.2) (envelope-from <tim.foerster@hetzner.com>)
 id 1x6j22-003Vou-J3; Wed, 16 Sep 2026 08:22:10 +0200
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 08:22:10 +0200
Message-Id: <DLGIW2X7905Z.1AXV42Q0QG1CM@hetzner.com>
Cc: "Jason Wang" <jasowangio@gmail.com>, "Markus Armbruster"
 <armbru@redhat.com>
Subject: QMP: exposing the host TAP interface name
To: <qemu-devel@nongnu.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
X-Authenticated-Sender: tim.foerster@hetzner.com
Received-SPF: pass client-ip=2a01:4f8:d0a:203a::1;
 envelope-from=tim.foerster@hetzner.com; helo=mail.hetzner.company
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Tim Foerster" <tim.foerster@hetzner.com>
From:  "Tim Foerster" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

I'd like to query the host TAP interface name of a network backend via QMP,=
 especially when the TAP FD is passed to QEMU using SCM_RIGHTS
and then assigned to a backend through fd=3D.

In my current setup, retrieving this information externally requires CAP_SY=
S_PTRACE. This gives the management process far more access
than needed and conflicts with the Landlock sandboxing I want to apply, due=
 to Landlock's ptrace restrictions [1].

QEMU already owns the FD, and tap_fd_get_ifname() can retrieve the name usi=
ng TUNGETIFF on Linux. For a TAP passed through fd=3D, x-query-
network currently reports the following (simplified):

{
  "name": "hostnet0",
  "type": "tap",
  "info-str": "fd=3D42"
}

I'd like to obtain the actual interface name in a structured field, regardl=
ess of how the TAP was created or passed to QEMU. For example:

{
  "name": "hostnet0",
  "type": "tap",
  "info-str": "fd=3D42",
  "data": {
    "ifname": "vnet7"
  }
}

Would extending x-query-network be the preferred approach? If so, would you=
 prefer a dedicated ifname field or a type-specific data object
selected by the existing type field?

Personally, I'd prefer an approach that is reasonably easy to backport down=
stream to older QEMU releases. Since x-query-network is
relatively new, extending it would also require bringing that command to re=
leases which don't have it yet, potentially increasing the
backporting effort.

A type-specific data object could also accommodate additional TAP propertie=
s later, such as multiqueue mode or vnet_hdr. However, those
are outside my current scope, I only need the interface name.

Is there an existing alternative I've missed?

Thanks!

[1] https://docs.kernel.org/userspace-api/landlock.html#ptrace-restrictions

