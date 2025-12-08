Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BE9D3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXNy-0003C4-JN; Mon, 08 Dec 2025 04:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vSXNj-0002vJ-PL
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vSXNh-0001VN-9u
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765185488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpX8aO9f3s7HbUS05qZCDHuQ3lDCVKbYenQlHxGnjMw=;
 b=fN6uq0pexzuTiCk+7Vf0WYNUQMBkI+m+C28WauM0lP4n3DOCtzvh8kz/FuOpCYP615V+j3
 AdK+tdXKlLDFiTdjMSjRLXiMlNghMSsqZL129bYTPs+yLeG3OZBuyX9/tbiQ8bu+Zb6S9E
 xap+k/nIEkyAzrmZTX9SJ7OkICi4lbM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-r4fLaGgCP7-zBv-Va9NH8A-1; Mon,
 08 Dec 2025 04:18:02 -0500
X-MC-Unique: r4fLaGgCP7-zBv-Va9NH8A-1
X-Mimecast-MFC-AGG-ID: r4fLaGgCP7-zBv-Va9NH8A_1765185482
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C73C71955F27; Mon,  8 Dec 2025 09:18:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F27CA18005BD; Mon,  8 Dec 2025 09:18:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 33EAD21E6A27; Mon, 08 Dec 2025 10:17:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  "open list:Rust-related patc..."
 <qemu-rust@nongnu.org>
Subject: Re: [PATCH 11/19] rust/qobject: add from/to JSON bindings for QObject
In-Reply-To: <CABgObfYJiBZC6jx9wQGCubC8J6Gu0Hn9q+Zo_Dm1J8PcRJDNNw@mail.gmail.com>
 (Paolo Bonzini's message of "Mon, 8 Dec 2025 08:00:00 +0100")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-12-pbonzini@redhat.com>
 <875xal5jnv.fsf@pond.sub.org>
 <21a2d5fb-0181-4ce8-8bea-a214c8eac2d7@redhat.com>
 <87cy4t3yzc.fsf@pond.sub.org>
 <CABgObfYJiBZC6jx9wQGCubC8J6Gu0Hn9q+Zo_Dm1J8PcRJDNNw@mail.gmail.com>
Date: Mon, 08 Dec 2025 10:17:52 +0100
Message-ID: <87bjk9fi2n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il ven 5 dic 2025, 13:16 Markus Armbruster <armbru@redhat.com> ha scritto:
>
>> > Note however that there is no support for push parsing, therefore this
>> > would not replace the balanced-parentheses machinery in
>> > qobject/json-streamer.c, and therefore QMP would still need a minimal
>> > lexer.
>>
>> That push parser...  I never liked it.  First, it's half-assed: it's a
>> push lexer wed to a pull parser with parenthesis counting.  Second, why
>> complicated & half-assed when you can do simple & quarter-assed instead?
>> We could've required "exactly one complete JSON value per line", or some
>> expression separator such as an empty line.
>
> Hmm not sure I agree, actually I think I disagree. It seems simpler but it
> is also different.

Management applications would be just fine with the different interface.

Human users would be better off.  As is, a missing right parenthesis is
met with silence.  You can then input whatever you want, and get more
silence until you somehow close the last parenthesis.  Quite confusing
unless you already know.

> Push parsing is not rocket science. It would be easy to write a proper one,
> it's just that there is no real reason other than cleanliness.

Me not liking what we have, when what we have works, is no reason to
rewrite it.

Even the lousy usability for humans doesn't justify a rewrite.

>> > Grr... I just remembered about interpolation :/ so no, we still need a
>> > parser for libqmp.c.
>>
>> Right.
>>
>> Interpolation lets us build QObjects from literal templates with
>> variable scalars or QObjects interpolated.  More concise and much easier
>> to read than the equivalend nest of constructor calls.  Drawback: chains
>> us to our own, bespoke JSON parser.
>
> And also, for similar reasons of practicality, single quotes (which IIRC
> also became valid QMP, and that's less excusable).

Single quotes should've been restricted to internal use, just like
interpolation.

> But while it's a pity, we still get a lot from serde, namely making the
> automatic generation of visitor code for structs someone else's problem.
>
>> Out of curiosity: how would we do better than "nest of constructor
>> calls" in Rust?
>
> You'd do that with a quoting macro, i.e.
>
> qobject!({"command": cmd})
>
> where the macro compiles to the nest of constructor calls, like
> QObject::from_iter([(c"command", to_qobject(cmd))]).

Thanks!


