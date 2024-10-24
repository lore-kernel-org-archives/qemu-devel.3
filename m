Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837D3D0BB6E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 08:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3tCC-0004Aj-By; Thu, 24 Oct 2024 04:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3tCA-0004A5-7D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3tC7-0000Pd-SB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729758462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6MidRvHej+PMvrA/vr4QwjVulo0khCSAl+FOEhlNIVI=;
 b=MBudUftnQk/6FZTbmlo6Sq4D2IzxPGkOmQ0GsT3lxoevcsUjgKEmoKweZElJyVPbZobUKs
 0KyTvq/zcQ447qdqwN/YR6G1Vo/GfVS4LMrm0I9XHymVHLPuzTFPCn8ZxR+WVVaC5LXHU4
 IPS98EFyh7za5ELIPfEqWT+l6adAh+s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-YmZz4k4hPvuqMnUcLkmU3g-1; Thu,
 24 Oct 2024 04:27:41 -0400
X-MC-Unique: YmZz4k4hPvuqMnUcLkmU3g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3BB81955D4A; Thu, 24 Oct 2024 08:27:39 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-239.str.redhat.com
 [10.33.192.239])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B00831956088; Thu, 24 Oct 2024 08:27:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Rob Landley <rob@landley.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 0/2] Re-enable the sh4eb target
Date: Thu, 24 Oct 2024 10:27:33 +0200
Message-ID: <20241024082735.42324-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

There are binaries available for sh4 running in big endian mode,
so the assumption that there is no usable machine for sh4eb was
wrong. Thus revert the patch that disabled sh4eb and add a proper
regression test for our CI.

Thomas Huth (2):
  Revert "Remove the unused sh4eb target"
  tests/functional: Add a test for sh4eb

 configs/devices/sh4eb-softmmu/default.mak |  3 +++
 configs/targets/sh4eb-softmmu.mak         |  2 ++
 qapi/machine.json                         |  2 +-
 tests/qtest/endianness-test.c             |  1 +
 tests/qtest/machine-none-test.c           |  1 +
 .gitlab-ci.d/buildtest.yml                |  2 +-
 .gitlab-ci.d/cirrus.yml                   |  2 +-
 .gitlab-ci.d/crossbuilds.yml              |  2 +-
 .travis.yml                               |  2 +-
 tests/functional/meson.build              |  3 +++
 tests/functional/test_sh4eb_r2d.py        | 33 +++++++++++++++++++++++
 tests/qemu-iotests/testenv.py             |  1 +
 tests/qtest/meson.build                   |  1 +
 13 files changed, 50 insertions(+), 5 deletions(-)
 create mode 100644 configs/devices/sh4eb-softmmu/default.mak
 create mode 100644 configs/targets/sh4eb-softmmu.mak
 create mode 100755 tests/functional/test_sh4eb_r2d.py

-- 
2.47.0


