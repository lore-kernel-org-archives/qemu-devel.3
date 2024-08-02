Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A21C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 19:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZyAD-0001gy-R0; Fri, 02 Aug 2024 15:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZyAA-0001fw-GS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 15:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZyA8-0006PS-TZ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 15:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722627723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v2aMsjE6KOR9M1GKLOr+BWbompR2cdRM2HJ9/7Sa2Gg=;
 b=hJkgmRbrXvlQCH1HyDK8z4QWtSExXFrLcgxxlYWiXUwBQUvD7QSUJyh/HNasMPtpYBtGGZ
 JD2Fx9v3GxoLmBhNCBOHFgBBZxSgMRyUbDaYwFZK2FEl1RgvdfUg0cLRA4GLLF5iYzLn1l
 DqIun2r1I3Vno2JmhAul7/Ri8Wdg/bI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-IVawHfgOPCazxG-iFy0X7w-1; Fri,
 02 Aug 2024 15:42:00 -0400
X-MC-Unique: IVawHfgOPCazxG-iFy0X7w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E134B1956088; Fri,  2 Aug 2024 19:41:58 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9A8519560AA; Fri,  2 Aug 2024 19:41:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	rjones@redhat.com
Subject: [PATCH for-9.1 0/2] NBD: don't print raw server error text to terminal
Date: Fri,  2 Aug 2024 14:26:04 -0500
Message-ID: <20240802194156.2131519-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

I've requested a CVE from Red Hat, and hope to have an assigned number
soon.  Meanwhile, we can get review started, to make sure this is
ready to include in 9.1.  'qemu-img info' should never print untrusted
data in a way that might take over a user's terminal.

There are probably other spots where qemu-img info is printing
untrusted data (such as filenames), where we probably ought to use the
same sanitization tactics as shown here.  Identifying those spots
would be a useful part of this review, and may mean a v2 that is even
more extensive in the number of patches.

In patch 1, I created mod_utf8_sanitize_len(), with the intent that I
could sanitize just a prefix of a string without having to copy it
into a NUL-terminated buffer.  I didn't end up needing it in my
current version of patch 2 (since the code was already copying to a
NUL-terminated buffer for trace purposes), but we may find uses for
it; in fact, it raises the question of whether any of our trace_ calls
need to sanitize untrusted data (or whether we can rely on ALL trace
engines to be doing that on our behalf, already).

Eric Blake (2):
  util: Refactor json-writer's string sanitizer to be public
  qemu-img: CVE-XXX Sanitize untrusted output from NBD server

 include/qemu/unicode.h |  3 ++
 nbd/client.c           |  5 ++-
 qobject/json-writer.c  | 47 +----------------------
 util/unicode.c         | 84 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 47 deletions(-)

-- 
2.45.2


