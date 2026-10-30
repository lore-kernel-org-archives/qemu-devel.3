Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D2606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqdClbsD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnQF-0002T3-BV; Fri, 30 Oct 2026 10:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQ3-0002RA-3k
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQ1-0002oX-Kt
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793369839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ePCK3Sdjo64qLjn3GPsfoCWUev7Z0qoodmaWyEPmPzU=;
 b=iqdClbsD54ze9Ivcwv3LZeXTRJbqIoTlt3F+vrPW+uSKGfxngOECHdtz0CAcMKmCj1uMOr
 rhVXzWGyIl+bGNOz5+nqyHQpVuxGiUUlan41bIjIICaruMQgeJqkbdtXrR6iSwQr7fBrFx
 tetjT/2aLjugqfmSFwy2ksATVoFcnN0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-z9E0FnqiMreigQdhDXQ1xg-1; Fri,
 30 Oct 2026 10:17:17 -0400
X-MC-Unique: z9E0FnqiMreigQdhDXQ1xg-1
X-Mimecast-MFC-AGG-ID: z9E0FnqiMreigQdhDXQ1xg_1793369836
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A381E18007F4; Fri, 30 Oct 2026 14:17:16 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D70101800480; Fri, 30 Oct 2026 14:17:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 0/8] qapi: last minute improvements/changes to -compat
 insecure-types
Date: Fri, 30 Oct 2026 14:17:05 +0000
Message-ID: <20261030141713.2841710-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This addresses various points raised by Markus about the current
impl/design, that would need to be addressed before this is
included in the release.

NB, the 'warn' option will repeatedly warn on every violation
which can be somewhat unpleasant. Figuring out a mechanism to
make it a one-time warning is an exercise for the future, given
limited time before release.

Changed in v2:

 * Expand docs to state 'warn' occurs repeatedly
 * Various docs rephrasing changes
 * Add error hint for security check

Daniel P. Berrangé (8):
  qapi: make 'CompatPolicy' the first arg in compat_policy_input_ok
  qapi: add 'warn' option to CompatPolicyInput
  qapi: rename 'insecure-types' to 'insecure-input'
  qapi: drop CompatPolicySecurity and use CompatPolicyInput
  qapi: rename compat_policy_check_security method
  qapi: reverse arg order in compat_policy_security_ok
  qemu-options: document -compat insecure-input parameter
  qapi: print a message before aborting for -compat violations

 docs/system/security.rst     |  2 +-
 include/qapi/compat-policy.h | 12 ++++----
 qapi/compat.json             | 27 +++++------------
 qapi/qapi-util.c             | 57 +++++++++++++++++++-----------------
 qapi/qapi-visit-core.c       |  4 +--
 qapi/qmp-dispatch.c          |  2 +-
 qapi/qobject-input-visitor.c |  2 +-
 qemu-options.hx              | 37 +++++++++++++++++++----
 qom/object.c                 |  8 ++---
 9 files changed, 85 insertions(+), 66 deletions(-)

-- 
2.56.0


