Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7470BCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cTk-0002N8-Rn; Tue, 14 Oct 2025 06:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8cTf-0002M2-De
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8cTY-0003RP-Ql
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760438508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3A0WX5MWMGHSL6zwX5a2tJWhQWuH/2f2cvzDwd00pU4=;
 b=I/TKc3tp9zPatdhWW0yeFalv0B2ihY6YgIivrC3cM1JSQVDofQxCXpJkCUpdaBgi9HNjp+
 9N2hseU24y+LqJAIzRsTQJE9oASMmbGAl2bbpJ1Fad+2YgR9MMds0mmGutxZF2JFeRUQG8
 o7Ug7Oi7DAiATU/ikYxb/73CAHdrTrI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-tc8upLupMda-LOMN1fGXJA-1; Tue,
 14 Oct 2025 06:41:46 -0400
X-MC-Unique: tc8upLupMda-LOMN1fGXJA-1
X-Mimecast-MFC-AGG-ID: tc8upLupMda-LOMN1fGXJA_1760438506
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94B57195410A; Tue, 14 Oct 2025 10:41:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1F42300018D; Tue, 14 Oct 2025 10:41:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] tests/qemu-iotests: Improve test detection for meson
Date: Tue, 14 Oct 2025 12:41:39 +0200
Message-ID: <20251014104142.1281028-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When running the test in thorough mode, we currently try to run a lot of
tests that are only skipped, which is somewhat annoying. This series
fixes the problems (see second patch), and add some more image formats
in the third patch (which should be fine now that the list of tests that
we try to execute is not that big anymore).

v2:
- Improve the detection mechanism in patch 2 by using regex statements
- Extend the comment in patch 2 a little bit, saying that the detection
  can fail in certain cases, e.g. when the "unsupported_fmt" and the
  "supported_fmt" statement are on the same line (which does not seem to
  be a problem with the current test cases right now, fortunately)

Thomas Huth (3):
  tests/qemu-iotests/184: Fix skip message for qemu-img without throttle
  tests/qemu-iotests: Improve the dry run list to speed up thorough
    testing
  tests/qemu-iotest: Add more image formats to the thorough testing

 tests/qemu-iotests/184         |  2 +-
 tests/qemu-iotests/check       | 42 +++++++++++++++++++++++++++++++---
 tests/qemu-iotests/meson.build |  3 +++
 3 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.51.0


