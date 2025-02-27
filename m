Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E362C1B087
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnYwM-0008V0-6s; Thu, 27 Feb 2025 03:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnYwF-0008MN-Hu
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:08:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnYwC-0001fk-F5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740643687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XuUQYF53VJoGGVTIA3kMbsSXg7OB2NmsJ4NgUKwHE0Q=;
 b=gJqV8tG62qZyQyzEhUOZrvMdx5Lfs7uxCjwafcsYBpO+ZnOkqj/8K06LgeKR8F67xnQuLT
 ui8WWD2SqUCNWJe0a8vJOI2eMuYsjR1j9EkW2usgDJMdO0t63ghQd3ZB6woRTmE1Hp8noP
 8q4j6PdjvQoEo0WNZ0IEFkz0HRNQdPI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-Ks3wVPpQOV6v_LmTKuRUKA-1; Thu,
 27 Feb 2025 03:08:01 -0500
X-MC-Unique: Ks3wVPpQOV6v_LmTKuRUKA-1
X-Mimecast-MFC-AGG-ID: Ks3wVPpQOV6v_LmTKuRUKA_1740643680
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 956B31800877; Thu, 27 Feb 2025 08:08:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 268451944D02; Thu, 27 Feb 2025 08:08:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7215921E675F; Thu, 27 Feb 2025 09:07:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	jsnow@redhat.com
Subject: [PATCH 0/3] qapi: Clean up for Python 3.8
Date: Thu, 27 Feb 2025 09:07:54 +0100
Message-ID: <20250227080757.3978333-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The QAPI code generator code still contains a few minor oddities to
make it work with versions of Python we no longer support.  Bury them.

I'm leaving two things for later because I don't know what to do about
them:

* scripts/qapi/source.py has a "Replace with @dataclass in Python
  3.7+" comment.

* scripts/qapi/introspect.py has a "Python 3.6 does not offer
  TypedDict constructs" comment.

While there, fix a missing version bump in build dependency
documentation.

Markus Armbruster (3):
  docs/about/build-platforms: Correct minimum supported Python version
  qapi: Eliminate OrderedDict
  qapi/introspect: Use @dataclass to simplify

 docs/about/build-platforms.rst |  2 +-
 scripts/qapi/introspect.py     | 12 +++++-------
 scripts/qapi/parser.py         |  5 ++---
 scripts/qapi/schema.py         | 11 +++++------
 tests/qapi-schema/test-qapi.py | 11 +----------
 5 files changed, 14 insertions(+), 27 deletions(-)

-- 
2.48.1


