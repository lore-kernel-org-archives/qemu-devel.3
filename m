Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F3C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJRZ-0004Q8-J7; Fri, 08 Aug 2025 05:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukJQz-0004FR-Vw
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukJQv-0001EI-5Y
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754645438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=RNVtMmtEhWjaj3E9cQhXUp9fC8VWxLmHirscOWFF744=;
 b=CUlT/zpPN6+ES1ryNDeiN8TE/o7RFNBtjik+iFg9ljXJMBwLo1aFWfj71bV5c8O7q8zu6R
 pO8DC3eEkbcCr9DmLsYnXFwg46rZkH2z+T4JzDh2vPz646v759S3/Qol+mGkUi8Q9Lsydc
 CEDi8Wb0sh8/s0aaHLTrmdMjNM2t8tc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-dFwufY40PVaSj5m6tvIrIA-1; Fri,
 08 Aug 2025 05:30:36 -0400
X-MC-Unique: dFwufY40PVaSj5m6tvIrIA-1
X-Mimecast-MFC-AGG-ID: dFwufY40PVaSj5m6tvIrIA_1754645435
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9368F180048E
 for <qemu-devel@nongnu.org>; Fri,  8 Aug 2025 09:30:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B4CE19560AD
 for <qemu-devel@nongnu.org>; Fri,  8 Aug 2025 09:30:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 424B621E6A27; Fri, 08 Aug 2025 11:30:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Abuse of warnings for unhandled errors and programming errors
Date: Fri, 08 Aug 2025 11:30:32 +0200
Message-ID: <87h5yijh3b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In "[PATCH 00/12] Error reporting cleanup, a fix, and &error_warn
removal", I challenged the use of warnings in a few places.  I think the
topic deserves a wider audience than the one a rather pedestrian cleanup
series draws.


To make my case, I need to start with errors.  We distinguish between
ordinary errors (for lack of a better word) and programming errors.

Ordinary errors are things like nonsensical user requests, unavailable
resources, and so forth.  A correct program is prepared for such
failures, detects them, and reports them to the user.  The user can then
fix their request, try again when resources are available, and so forth.

Tools for reporting ordinary errors are error_report(),
error_report_err(), &error_fatal, and friends.

Programming errors are bugs.  A developer needs to fix the program.
Unlike ordinary errors, programming errors are *unexpected*.

Programming errors are commonly not recoverable.  The proper tool for
unrecoverable ones is assertions.  &error_abort can be a convenient way
to assert "this can't fail".


On to warnings.

When some failure doesn't prevent satisfying some request, an ordinary
error can be misleading.  We make it a warning instead then.

What if it's a programming error we recover from?

Aside: trying to recover in a buggy program is risky, but that's not the
debate I want to have here.

How do we want such recoverable programming errors reported?

Warning?  We seem to be abusing warnings this way, and I hate it.  What
we have to report is a *bug*, and we should make that crystal clear.
"warning: FunctionYouNeverHeardAbout() failed" does not.  It could be
anything, and you likely need to look at the source to find out.

Ordinary error reporting with "internal error: " prefix, so the user
understands this is a bug, and all they can do about it is report it?

Log the bug somehow?

Thoughts?


Regardless of all that, beware of "this shouldn't fail, and if it does,
I don't know how to handle it / can't be bothered to handle it, so I
just spit out a warning and hope for the best."  Stop and *think*
whether it is a programming error or an ordinary error that is difficult
/ inconvenient / impossible to handle.  Then do the right thing if
practical.  If not, you're accepting a defect.  Make it locally obvious
that it's a defect, so it's at least a *known* defect, and the next guy
coming along won't have to guess.


