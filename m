Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FDAC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBdu-0001sE-NO; Mon, 29 Jun 2026 09:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weBdr-0001rp-4c
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weBdp-0000Gq-QU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782738193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AQa9YpTiiCgSL6Z10XvioxdNmK+zAR6lnl0bfVz5Hqc=;
 b=XPdyIozFuQRMwfDce9lA8rhFwmDfX0nKRfPfqleETA9tpiiEitVZ0FVAokEEN0vvgZP/ER
 xWsG4TEaPBT3NmiuYkeez3x4ID16k3zTXOPIT+fgfh8UVhBFQtNhxINnGtP1OZ3iRA8diG
 +qWGL5BsaY3Kagv7qXjCntmcit2XGwY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-ndQ1Bgg6Pg6BoSYI-5QGoA-1; Mon,
 29 Jun 2026 09:03:11 -0400
X-MC-Unique: ndQ1Bgg6Pg6BoSYI-5QGoA-1
X-Mimecast-MFC-AGG-ID: ndQ1Bgg6Pg6BoSYI-5QGoA_1782738190
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 928E81956044
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:03:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 502191800661
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:03:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB05021E6920; Mon, 29 Jun 2026 15:03:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/6] qobject: switch JSON parser to push
In-Reply-To: <20260626101727.1727389-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 26 Jun 2026 12:17:20 +0200")
References: <20260626101727.1727389-1-pbonzini@redhat.com>
Date: Mon, 29 Jun 2026 15:03:07 +0200
Message-ID: <877bnhts6s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> This rewrites the json-parser to use a push parser aka state machine.
> While push parsers are inherently more complex than recursive descent,
> the grammar for JSON is simple enough that the parser remains readable.
> There is therefore no need to use e.g. QEMU coroutines.
>
> Unlike the suggestion in commit 62815d85aed ("json: Redesign the callback
> to consume JSON values", 2018-08-24), I kept the json-streamer concept.
> It helps in handling input limits, it performs error recovery, and it
> converts the token-at-a-time push interface to callbacks---all things
> that are more easily done in a separate layer to keep the parser clean.
> However, there is no need anymore for it to store partial JSON objects
> in tokenized form, because the current state is stored in the push
> parser's stack.
>
> Another benefit is that QEMU can report the first parsing error
> immediately, without waiting for parentheses to be balanced or for a
> lexing error.  Error recovery then proceeds as before (i.e., the next
> parse still starts after balanced parentheses or a lexing error).
>
> On top of the benefits intrinsic in the push architecture, it so happens
> that it's really easy to add a location to JSON parsing errors now, so
> do that as well.
>
> The diffstat is unfavorable, but most of the new lines delta is really
> new comments explaining the grammar and state machines.

I found an unintentional, harmless limit change by one, and suggested a
few further comment tweaks.

With the limit change reverted or mentioned in the commit message,
series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

I volunteer to do the pull request, since I have another patch for
qobject/ queued up already.  I'd apply the changes I suggested, less
ones you disagree with.  Let me know!

[...]


