Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF857C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuor6-0002Z3-7M; Fri, 14 Aug 2026 06:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuoqy-0002YQ-Vs
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wuoqw-0001hm-SA
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786702169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hCu3A4xnVPyTC7ikwAf+iNwdTR50tVKGICObwM4zBD4=;
 b=CAXGt0CWwyx6e73PKbqaoSz6Ktpd9/Yrk1Yq+W2rxnbk9NZOXr0Uz8nOBlFrH5gtuxJBh1
 a/u+aMviTGu9uft4CClQ77x0JTZrtF8XSIQ9iQ0bqHbeD++O4dlHVul4hVcI08DywojUgm
 JpMht2aKPAm9PMHv6i3SnztsaK+QUzE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-679tElZ4PQibzdyyfnOkIQ-1; Fri,
 14 Aug 2026 06:09:20 -0400
X-MC-Unique: 679tElZ4PQibzdyyfnOkIQ-1
X-Mimecast-MFC-AGG-ID: 679tElZ4PQibzdyyfnOkIQ_1786702159
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AFC7180049D; Fri, 14 Aug 2026 10:09:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CCD3422; Fri, 14 Aug 2026 10:09:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/6] Functional test framework improvements & bug fixes
Date: Fri, 14 Aug 2026 12:09:11 +0200
Message-ID: <20260814100917.163448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

 Hi Richard!

The following changes since commit 539bc315538afe036a4b99088659aa82e3b489f2:

  Merge tag 'pull-loongarch-20260813' of https://github.com/bibo-mao/qemu into staging (2026-08-13 07:16:25 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-08-14

for you to fetch changes up to 4adfb431c0c3abd84909d1228b4954bfd68a1dbc:

  hw/i386/amd_iommu: Avoid undefined behavior in amdvi_setevent_bits() (2026-08-14 09:14:58 +0200)

----------------------------------------------------------------
* Some minor updates to the functional testing framework
* Fix a guest-triggerable abort() in the usb uas code
* Fix a guest-triggerable abort() in the vmxnet3 code
* Fix a undefined behavior problem in the amd_iommu code

----------------------------------------------------------------
Thomas Huth (3):
      hw/usb/dev-uas: Don't abort if guest provided an undersized buffer for status
      hw/net/vmxnet3: Do not abort if guest provides bad interrupt numbers
      hw/i386/amd_iommu: Avoid undefined behavior in amdvi_setevent_bits()

Vladimir Sementsov-Ogievskiy (3):
      tests/functional: add skipWithoutSudo() decorator
      tests/functional/qemu_test: drop *args argument from .get_vm()
      tests/testcase.py: passthrough monitor_address

 hw/i386/amd_iommu.c                      |  2 +-
 hw/net/vmxnet3.c                         | 34 ++++++++++++++++++++++++--------
 hw/usb/dev-uas.c                         | 19 ++++++++++++++++--
 tests/functional/migration.py            |  3 ++-
 tests/functional/qemu_test/decorators.py | 16 +++++++++++++++
 tests/functional/qemu_test/testcase.py   | 12 +++++------
 6 files changed, 67 insertions(+), 19 deletions(-)


