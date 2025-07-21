Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775B3C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 10:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udo27-0005U4-Ex; Mon, 21 Jul 2025 06:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udo1m-0005I0-8r
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udo1g-0001e4-SP
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 06:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753094741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A7IowdrjvCd7CjnhCeE1ikjgZZPxsox27eTj3IJLS3s=;
 b=TWc4Idexk6JtFxV/SIJ8lkpJqLl37vzDs/ovqSYvb6Jj+2ptrG6S80OqdO3CkXF/k1A3wD
 0RWjpek32Er0Hx45WFuV9VTzUViEPRjHJf/QJX0CO3CDQuTF0RiuhfQ4PeTnrQvDov91KH
 aEXmy62FwHPg7M2quW/hqBZM0fosfL8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-0pdF9AreOWaMRYu29vEEMA-1; Mon,
 21 Jul 2025 06:45:39 -0400
X-MC-Unique: 0pdF9AreOWaMRYu29vEEMA-1
X-Mimecast-MFC-AGG-ID: 0pdF9AreOWaMRYu29vEEMA_1753094739
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD3B219560A7
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 10:45:38 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDEB819560A1; Mon, 21 Jul 2025 10:45:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 0/4] Misc crypto & UI patches
Date: Mon, 21 Jul 2025 11:45:32 +0100
Message-ID: <20250721104536.2856423-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit c079d3a31e45093286c65f8ca5350beb3a4404a9:

  Merge tag 'pull-10.1-rc0-maintainer-140725-1' of https://gitlab.com/stsquad/qemu into staging (2025-07-15 00:12:07 -0400)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-next-pull-request

for you to fetch changes up to 6f7f3419cce86553dd239f10a5deb9ab872bd8c2:

  crypto: load all certificates in X509 CA file (2025-07-21 11:30:07 +0100)

----------------------------------------------------------------

* Fix endian defaults when no VNC pixel format message is set
* Add more trace events for VNC messages
* Fix checking of certificate loading
* Eliminate cert limit on loading CA certificates

----------------------------------------------------------------

Daniel P. Berrangé (2):
  ui: fix setting client_endian field defaults
  ui: add trace events for all client messages

Henry Kleynhans (1):
  crypto: load all certificates in X509 CA file

Peter Maydell (1):
  crypto/x509-utils: Check for error from gnutls_x509_crt_init()

 crypto/tlscredsx509.c | 23 +++++++++----------
 crypto/x509-utils.c   |  6 ++++-
 ui/trace-events       | 14 ++++++++++++
 ui/vnc.c              | 53 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 13 deletions(-)

-- 
2.50.1


