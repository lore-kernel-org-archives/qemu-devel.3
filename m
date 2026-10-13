Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84703CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcgM-0000k0-8X; Tue, 13 Oct 2026 09:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGcgI-0000i0-Az
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGcgC-0006NB-RC
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791898591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hqw205tcyEYFdiYhcLQy20D/VtJK8t1E15WaZZqxH1c=;
 b=NJmJ1Jske+rcoYhK7krcUvq6oL1hSThnr51Dhqq72JAE/jQ/SsJFWFdCsauPq0EB0SogkM
 6XCxJVM6C5wOSB5dqqKvl+UhN8K6Ww/vWx+gup4Pu6l0e6TqGJEyyxoOBVW8Tb5O3nBeW+
 k3Cn95dZwnmwYJNI+sZzJMyjseJ9aAo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-UhTuj1XnNXaPgVQYrLLp1Q-1; Tue,
 13 Oct 2026 13:36:26 +0000
X-MC-Unique: UhTuj1XnNXaPgVQYrLLp1Q-1
X-Mimecast-MFC-AGG-ID: UhTuj1XnNXaPgVQYrLLp1Q_1791898585
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55FDD1956041; Tue, 13 Oct 2026 13:36:25 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8D51195604B; Tue, 13 Oct 2026 13:36:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/4] Revert obsolete & broken workaround for GNUTLS thread
 safety bug
Date: Tue, 13 Oct 2026 14:36:18 +0100
Message-ID: <20261013133622.993935-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

A year or so ago we introduced a workaround for a troubling GNUTLS
thread safety problem that hits when a bidirectional TLS channel
is used and "large" amounts of data are transferred triggering
re-keying under TLS 1.3.

Unfortunately that workaround turned out to not work, and since it
was close to final freeze we disabled it, rather than attempt last
minute changes.

Fast forward a year, and GNUTLS has shipped a fix itself and RHEL
at least has backported the fix to stable releases. A user who
is still affected can workaround it by disabling TLS 1.3, or
forcing use of a different cipher to avoid re-keying entirely.

Getting a viable workaround operating correctly in QEMU is going
to be challenging and fragile long term, so not worth spending
more time on.

Revert the broken workaround (which was already hardcoded to be
disabled at build time).

Daniel P. Berrangé (4):
  Revert "migration: activate TLS thread safety workaround"
  Revert "io: add support for activating TLS thread safety workaround"
  Revert "crypto: add tracing & warning about GNUTLS countermeasures"
  Revert "crypto: implement workaround for GNUTLS thread safety
    problems"

 crypto/tlssession.c         | 103 ++----------------------------------
 crypto/trace-events         |   1 -
 include/crypto/tlssession.h |  14 -----
 include/io/channel.h        |   1 -
 io/channel-tls.c            |   5 --
 meson.build                 |   9 ----
 migration/tls.c             |   9 ----
 7 files changed, 3 insertions(+), 139 deletions(-)

-- 
2.56.0


