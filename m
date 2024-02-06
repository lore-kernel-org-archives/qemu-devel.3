Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC5BC48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 06:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXF01-0003sT-4t; Tue, 06 Feb 2024 01:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXF00-0003sH-6A
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 01:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXEzy-0006Gq-L9
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 01:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707201121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vSP8zcu8lRvUs9SbQ0/Owadztv6fBofu6wok0VSyCrs=;
 b=W8xaxAc5213jEkTVjyUslxpBVRPLHm/DfQxnKvYaYg1s9XW7JWlCdLEvkslQLKX7Uduo6Y
 Owp2EYl2rsLxUBPFMv0fu2MUbQ6d3/MWApQJv1AjlQ8tjZl8norzw2fYyRp30/bPPuVZYq
 6cc8TUIO57RmDKNYG12fWoDAoVs8WfE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-nfva3CzzNvGOANDt9u_CPQ-1; Tue,
 06 Feb 2024 01:31:58 -0500
X-MC-Unique: nfva3CzzNvGOANDt9u_CPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F2411C0BB40;
 Tue,  6 Feb 2024 06:31:57 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 609921C060AF;
 Tue,  6 Feb 2024 06:31:53 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH 0/3] ci: Fixes on the recent cross-binary test case
Date: Tue,  6 Feb 2024 14:31:48 +0800
Message-ID: <20240206063151.215986-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Hi,

This small patchset updates the recent cross-binary test for migration on
a few things.

Patch 1 modifies the aarch64 test GIC version to 3 rather than "max",
paving way for enabling it, even if the CPU model is not yet ready.

Patch 2 removes the tag dependency of the new build-previous-qemu job, so
that in personal CI pipelines the job won't fail if the tag is missing, as
reported by Peter Maydell, and solution suggested by Dan.

Patch 3 updates the comment for aarch64 on the test to state the fact, and
what is missing.  Then we don't target it support for v9.0, but only until
we have a stable CPU model for aarch64 (if ever possible to support both
tcg and kvm).

Comments welcomed, thanks.

Peter Xu (3):
  tests/migration-test: Stick with gicv3 in aarch64 test
  ci: Remove tag dependency for build-previous-qemu
  ci: Update comment for migration-compat-aarch64

 tests/qtest/migration-test.c | 2 +-
 .gitlab-ci.d/buildtest.yml   | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.43.0


