Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB9606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dah1+VxD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNX2-0006Tb-Ks; Fri, 20 Nov 2026 07:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUNWQ-0006Bj-Cn
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUNWO-0006Bs-9y
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795176914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dOVqpFFeM1KSO6NHO+4k9Kd7nd6O+NcqTrGYCJ0MZ5I=;
 b=dah1+VxDf80JtBIoWEOmAEYalcpev/R866C1bNrybrXhrat+LbR3Lq8ToaPxqka1Cu9GSi
 DtzfLwWe8xHzBkyaeEKrI8gGXn0veEI4djjQkhuSFrjbBxkkS34sp6xodjv8u3ajPc38UC
 oFiHQvQlMl64s4I+AobzYPPGlOecZ+E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-r_FMa9KFPGmsub6zHsRFQg-1; Fri,
 20 Nov 2026 12:15:10 +0000
X-MC-Unique: r_FMa9KFPGmsub6zHsRFQg-1
X-Mimecast-MFC-AGG-ID: r_FMa9KFPGmsub6zHsRFQg_1795176907
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BA2718004AD; Fri, 20 Nov 2026 12:15:06 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C20430000E3; Fri, 20 Nov 2026 12:14:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 00/12] tests/functional: misc fixes to functional test suite
Date: Fri, 20 Nov 2026 12:14:46 +0000
Message-ID: <20261120121458.3723625-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first 4 patches fix failures to download a number of assets
whose URLs have been deleted, or moved, content regenerated, or
put behind anubis.

They will need to go to the pending 11.2 release and stable branches
too.

The remaining patches are bug fixes except for the very last
patch. Those can likely all wait until 12.0, but cherry-picking
some of them into stable would be reasonable if desired.

After this series is applied we have one unresolvable problem
with assets for MIPS, the yamon-bin-02.22.zip file hosted on
AWS is throwing an error about using the wrong endpoint, but
I can't figure out what the right one is (if any).

Daniel P. Berrangé (12):
  tests/functional: update to newer sunxi kernel package
  tests/functional: update sha digests for tuxrun kernels
  tests/functional: update URL to rs6000 firmware
  tests/functional: add Accept header when downloading assets
  tests/functional: check if we are served an Anubis challenge
  tests/functional: don't write timestamp unless successful
  tests/functional: delete tmp file on interrupt
  tests/functional: honour make jobs in precache
  tests/functional: don't display stack trace on download fail
  tests/functional: always raise AssetError when download fails
  tests/functional: only run pre-cache once per class
  tests/functional: optionally display download progress

 docs/devel/testing/functional.rst       |  6 ++
 tests/Makefile.include                  |  2 +-
 tests/functional/aarch64/test_tuxrun.py |  4 +-
 tests/functional/arm/test_bpim2u.py     | 19 +++---
 tests/functional/arm/test_cubieboard.py | 15 ++---
 tests/functional/arm/test_orangepi.py   | 19 +++---
 tests/functional/arm/test_replay.py     | 12 ++--
 tests/functional/ppc/test_40p.py        |  3 +-
 tests/functional/qemu_test/asset.py     | 83 ++++++++++++++++++++-----
 tests/functional/qemu_test/testcase.py  |  8 ++-
 tests/functional/s390x/test_tuxrun.py   |  4 +-
 tests/functional/x86_64/test_tuxrun.py  |  4 +-
 12 files changed, 123 insertions(+), 56 deletions(-)

-- 
2.56.1


