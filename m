Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6766ECCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEr65-0004vZ-22; Fri, 31 Oct 2025 11:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEr5v-0004uZ-V8
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEr5o-0001hj-6w
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761924662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4hkW8KIxpTK5sJE0bKpAJDcS63LNm/8FOO/0PrSV9v4=;
 b=fFaIwt7Q3F7WpRo2pXIhQZCFuLi0tMODqzsA8nEqCO4J0TLJUYeFk3SUGkfopbjinUgMb9
 5EboQwmO7EJA/iL1+/4jKXPy7wIQA7wOOfL69+K+JRe5IGxqew0fNNImZAq4WYStGdb+B+
 wYqEnrjLrcFfx7xbLC2/DTtSB0dngbY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-taG9RQeXPu2u3Rpm5Bm_aQ-1; Fri,
 31 Oct 2025 11:31:00 -0400
X-MC-Unique: taG9RQeXPu2u3Rpm5Bm_aQ-1
X-Mimecast-MFC-AGG-ID: taG9RQeXPu2u3Rpm5Bm_aQ_1761924659
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48E7B1800654; Fri, 31 Oct 2025 15:30:59 +0000 (UTC)
Received: from toolbx.lcy.redhat.com (dhcp-17-192.lcy.redhat.com
 [10.42.17.192])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C07CB19560A2; Fri, 31 Oct 2025 15:30:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/5] Bump min versions of crypto libs
Date: Fri, 31 Oct 2025 15:30:51 +0000
Message-ID: <20251031153056.296078-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

gnutls, libgcrypt and nettle can all have their min versions increased
based on our platform support matrix, enabling various bits of compat
logic to be dropped, as well as eliminating the last usage of in-tree
XTS code.

Daniel P. Berrangé (5):
  crypto: bump min gnutls to 3.7.5
  crypto: unconditionally enable gnutls XTS support
  crypto: bump min libgcrypt to 1.9.4
  crypto: bump min nettle to 3.7.3
  crypto: drop in-tree XTS cipher mode impl

 crypto/cipher-gnutls.c.inc     |   8 -
 crypto/cipher-nettle.c.inc     |  44 ---
 crypto/cipher.c                |   2 +-
 crypto/meson.build             |   5 +-
 crypto/xts.c                   | 250 ----------------
 include/crypto/xts.h           |  82 -----
 meson.build                    |  69 +----
 tests/unit/meson.build         |   3 -
 tests/unit/test-crypto-block.c |   3 +-
 tests/unit/test-crypto-xts.c   | 529 ---------------------------------
 10 files changed, 9 insertions(+), 986 deletions(-)
 delete mode 100644 crypto/xts.c
 delete mode 100644 include/crypto/xts.h
 delete mode 100644 tests/unit/test-crypto-xts.c

-- 
2.51.1


