Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7B6606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=d/p9jOkL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTyH1-0006tY-9W; Thu, 19 Nov 2026 04:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTyGy-0006tN-DZ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:17:41 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTyGw-00042W-LW
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795079846; bh=+XHzo4b0Lkocbz+Hb2DhGcdwb7so3Fp4u97m+xmzbkQ=;
 h=From:To:Cc:Subject:Date:From;
 b=d/p9jOkL8PaObt0KdBk1k3qsVWivbZ2egTOHWaZT8u+GTV9XjFt1sXzhjOiHByPwK
 230PjWnMFDqj1uasa9j493c+OJQ5ZcqzHPYcZT3xcFCSG7afQyLnu875Ig+17iyBeV
 AKCnaU0SDM30mWK/gbG2+P7gqmf0kt2/kLnntLwQ=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 9E6B92016A;
 Thu, 19 Nov 2026 10:17:26 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F267E21E6A04; Thu, 19 Nov 2026 10:17:27 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Why device-list-properties?
Date: Thu, 19 Nov 2026 10:17:27 +0100
Message-ID: <87a4n5ch94.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As far as I can tell, device-list-properties can do nothing you can't do
with qom-list-properties.

Both take a QOM type name.

device-list-properties rejects types that aren't concrete subtypes of
"device".

device-list-properties filters out properties named "type", "realized",
"hotpluggable", "hotplugged", and "parent_bus".  These are precisely the
properties every device inherits from "device".

Why is that useful?

