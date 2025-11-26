Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A98FD0EE29
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 06:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO8mQ-0007yN-LN; Wed, 26 Nov 2025 01:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vO8lq-0007oT-Ff
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 01:12:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vO8lo-0005Fc-Ex
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 01:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764137568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mh30BpgoOOeMqskI3xdB9z+6gEc0Lnbk15ulaI4Z7Dg=;
 b=OEgx4YvClEbKlRfOmKdO4GQKysUrI2S+BB+I3RcBSaPLv2YGMDaDynI7hQIT3urpKZKbCH
 wnMOsaOJVTeW+DbfpsgvfryWR8ORQwcOINXDU9JmNSElbbwKV6ulB+TwjxmnsDEgRuMpxw
 mGA63DHih9w9w7NbBZVpW57w6CsFcdY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-hFkhvJi7NKSdU4ArV6dLqg-1; Wed,
 26 Nov 2025 01:12:43 -0500
X-MC-Unique: hFkhvJi7NKSdU4ArV6dLqg-1
X-Mimecast-MFC-AGG-ID: hFkhvJi7NKSdU4ArV6dLqg_1764137562
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D05791954B0B; Wed, 26 Nov 2025 06:12:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52046180047F; Wed, 26 Nov 2025 06:12:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D18E121E6A27; Wed, 26 Nov 2025 07:12:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,  qemu-devel@nongnu.org,  farosas@suse.de,
 peter.maydell@linaro.org
Subject: Should functions that free memory clear the pointer? (was: [PATCH]
 migration: Fix double-free on error path)
In-Reply-To: <aSYEO_S7FfAeZyHG@x1.local> (Peter Xu's message of "Tue, 25 Nov
 2025 14:32:11 -0500")
References: <20251125070554.2256181-1-armbru@redhat.com>
 <CAJ+F1CJ918Y9e=yTHFSqZo0QGmmD3aT6Zq+zxQ81t-gjKkUJPw@mail.gmail.com>
 <875xayxo6t.fsf@pond.sub.org> <aSXPhOV86fyaY53_@x1.local>
 <87ikeygd83.fsf@pond.sub.org> <aSYEO_S7FfAeZyHG@x1.local>
Date: Wed, 26 Nov 2025 07:12:38 +0100
Message-ID: <87wm3dfhk9.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Nov 25, 2025 at 07:48:44PM +0100, Markus Armbruster wrote:
>> My main argument remains this one: our deallocating functions don't work
>> that way.  For better or worse.
>> 
>> I don't want the Error API free differently.
>
> Yes, it's fair.
>
> IMHO, it's a matter of taste,

Depends on context.

Modula-2's DISPOSE takes the pointer by reference and clears it.  C's
free() takes it by value.  Matter of taste when these were designed.

But when one style has become overwhelmingly prevalent, it's no longer a
matter of taste.  This is arguably the case in C.

>                               and maybe that's also why I liked
> g_clear_pointer() but not everyone likes it.. said that, when we have
> g_clear_pointer() it also makes the current form more flexible, because we
> can apply g_clear_pointer() on top when we need a reset..

I'm no friend of g_clear_pointer().  I find

    g_clear_pointer(&ptr, free_frob);

a rather roundabout way to say

    free_frob(ptr);
    ptr = NULL;

Any C programmer will immediately understand the latter.  For the
former, you need to know one more little thing.  Yes, we can all get
used to these little things, but it's one more little thing new people
have to learn and internalize.  Even little things add up.

If an entire project gets into the habit of using it religiously, it may
reduce "forgot to zap the reference" bugs some.  Until then, it feels
like a net negative to me.

> I'll follow your advise on error reporting for migration.

Thank you!


