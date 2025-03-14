Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4554EC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 08:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt0qb-0000xm-3k; Fri, 14 Mar 2025 04:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt0qZ-0000xM-MW
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt0qX-0000mx-KK
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741942607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKsf7dpFZB1NLRetgmhmAwf6kqZ5Fz9dEA6RZHoxLkw=;
 b=Fp+hUwqB/Xstzs3LORxCBFedVemtROoz1gL7A372MmZcI9hXlJpM40330qNcc84wdwv1+H
 AT1mBCKlOWhzSAc45HHFs8yVFdm6lHz3+1KvBRTAfuFtn+E3B8w8j6SLvUO0+DhCmfVXsS
 nWkSO+N4tDJMWmBddIrmBiA1ldGM4V8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-Bx9BtSitPm-yea4bbtMnLg-1; Fri,
 14 Mar 2025 04:56:44 -0400
X-MC-Unique: Bx9BtSitPm-yea4bbtMnLg-1
X-Mimecast-MFC-AGG-ID: Bx9BtSitPm-yea4bbtMnLg_1741942603
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63FD719560BB; Fri, 14 Mar 2025 08:56:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01E571955BCB; Fri, 14 Mar 2025 08:56:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D17821E675F; Fri, 14 Mar 2025 09:56:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: bibo mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Remove unnecessary NULL pointer
 checking
In-Reply-To: <fc8a893c-9ff5-ad44-812a-66dd0f163269@loongson.cn> (bibo mao's
 message of "Fri, 14 Mar 2025 14:28:27 +0800")
References: <20250313091350.3770394-1-maobibo@loongson.cn>
 <20250313091350.3770394-3-maobibo@loongson.cn>
 <875xkdb4q5.fsf@pond.sub.org>
 <10c55e3e-22f5-285d-7e38-3a6a08089302@loongson.cn>
 <87v7scw4se.fsf@pond.sub.org>
 <fc8a893c-9ff5-ad44-812a-66dd0f163269@loongson.cn>
Date: Fri, 14 Mar 2025 09:56:37 +0100
Message-ID: <87a59ot2gq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

bibo mao <maobibo@loongson.cn> writes:

> The question how to use error_propagate() comparing with error_setg() since there is such API. :)

error_propagate() should be mostly avoided in new code.  It still exists
because plenty of old code uses it.  It can also be used to keep only
first of several errors, but that's rarely a good idea.

There's usage advice in include/qapi/error.h's big comment.  Relevant
parts for your convenience:

 * = Passing errors around =
 *
 * Errors get passed to the caller through the conventional @errp
 * parameter.
 *
 * Create a new error and pass it to the caller:
 *     error_setg(errp, "situation normal, all fouled up");
 *
 * Call a function, receive an error from it, and pass it to the caller
 * - when the function returns a value that indicates failure, say
 *   false:
 *     if (!foo(arg, errp)) {
 *         handle the error...
 *     }
 * - when it does not, say because it is a void function:
 *     ERRP_GUARD();
 *     foo(arg, errp);
 *     if (*errp) {
 *         handle the error...
 *     }
 * More on ERRP_GUARD() below.
 *
 * Code predating ERRP_GUARD() still exists, and looks like this:
 *     Error *err = NULL;
 *     foo(arg, &err);
 *     if (err) {
 *         handle the error...
 *         error_propagate(errp, err); // deprecated
 *     }
 * Avoid in new code.  Do *not* "optimize" it to
 *     foo(arg, errp);
 *     if (*errp) { // WRONG!
 *         handle the error...
 *     }
 * because errp may be NULL without the ERRP_GUARD() guard.
 *
 * But when all you do with the error is pass it on, please use
 *     foo(arg, errp);
 * for readability.
[...]
 * Pass an existing error to the caller:
 *     error_propagate(errp, err);
 * This is rarely needed.  When @err is a local variable, use of
 * ERRP_GUARD() commonly results in more readable code.
 *
 * Pass an existing error to the caller with the message modified:
 *     error_propagate_prepend(errp, err,
 *                             "Could not frobnicate '%s': ", name);
 * This is more concise than
 *     error_propagate(errp, err); // don't do this
 *     error_prepend(errp, "Could not frobnicate '%s': ", name);
 * and works even when @errp is &error_fatal.
 *
 * Receive and accumulate multiple errors (first one wins):
 *     Error *err = NULL, *local_err = NULL;
 *     foo(arg, &err);
 *     bar(arg, &local_err);
 *     error_propagate(&err, local_err);
 *     if (err) {
 *         handle the error...
 *     }
 *
 * Do *not* "optimize" this to
 *     Error *err = NULL;
 *     foo(arg, &err);
 *     bar(arg, &err); // WRONG!
 *     if (err) {
 *         handle the error...
 *     }
 * because this may pass a non-null err to bar().
 *
 * Likewise, do *not*
 *     Error *err = NULL;
 *     if (cond1) {
 *         error_setg(&err, ...);
 *     }
 *     if (cond2) {
 *         error_setg(&err, ...); // WRONG!
 *     }
 * because this may pass a non-null err to error_setg().

Questions?


