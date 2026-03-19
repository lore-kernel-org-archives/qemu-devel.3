Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D003109023C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3F4R-0005YT-9V; Thu, 19 Mar 2026 11:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kniv@yandex-team.ru>)
 id 1w3F4M-0005Xm-So; Thu, 19 Mar 2026 11:13:55 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kniv@yandex-team.ru>)
 id 1w3F4J-0005pf-RY; Thu, 19 Mar 2026 11:13:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C6CCD8085B;
 Thu, 19 Mar 2026 18:13:42 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6bf:8080:4f::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8DQdxY2AnCg0-tCD6mHno; Thu, 19 Mar 2026 18:13:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773933222;
 bh=f8ELhRb2vJlVTX9AVLSMXRg5qJMoFg/Vlo1ReFnjj/4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=F4Ja7GAwP6X0u4XXrCl8sqgspol1Aj57QYX7AJ8tXhyWUt/Kw5I3vw8TQHblScnvF
 tT2uU3CuCreEugBIWQ1NDG65URbVSnKGdzOKyVcwA1BAb8o82lhyoePYu515+6t1Ka
 1Kh2KrcpFJuxWhZUHgxg3jlSsfhu0/QJ/qz6nFJQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Nikolay Kuratov <kniv@yandex-team.ru>
Subject: Re:[PATCH] qmp: Check vhost protocol features for NULL prior to
 dumping
Date: Thu, 19 Mar 2026 18:13:08 +0300
Message-Id: <20260319151308.2046986-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <871phfx6mb.fsf@pond.sub.org>
References: <871phfx6mb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=kniv@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> I fear this papers over the real bug.

Sorry, my bad. There is no such bug in upstream since
qmp_x_query_virtio_status() clearly did its job of setting
protocol_features well. So patch should be dropped.

Thank you for pointing to qapi part.

