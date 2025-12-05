Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FAED2F7EA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 12:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRUk1-0001sU-1C; Fri, 05 Dec 2025 07:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRUjz-0001s2-95
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 07:16:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vRUjw-00089n-PO
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 07:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764937006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fbi83CqORd+m4M/eD+jAB9IZDk+cdyCDwmXyQfT8MeU=;
 b=WDHR6OG0gvFARfLPD02a6mnFwQCvnd2pbW8252YjCXcCeOrSL+WFzdxpYJf57E0jewb1kD
 cIZ6mmXUI3vvjBKiaTL6IL0ALob9p1x7ecR4BmYpD1NEUb670IHMiicXku35Na+IkPtWa4
 Z0flUwvsyD7bftG/4cL8osBmx152Bgc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-ENHPourHOxCpama5NI-R8Q-1; Fri,
 05 Dec 2025 07:16:44 -0500
X-MC-Unique: ENHPourHOxCpama5NI-R8Q-1
X-Mimecast-MFC-AGG-ID: ENHPourHOxCpama5NI-R8Q_1764937003
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67A50180035A; Fri,  5 Dec 2025 12:16:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFDDD196B8DA; Fri,  5 Dec 2025 12:16:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8CDC21E6A27; Fri, 05 Dec 2025 13:16:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 11/19] rust/qobject: add from/to JSON bindings for QObject
In-Reply-To: <21a2d5fb-0181-4ce8-8bea-a214c8eac2d7@redhat.com> (Paolo
 Bonzini's message of "Fri, 5 Dec 2025 12:09:58 +0100")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-12-pbonzini@redhat.com>
 <875xal5jnv.fsf@pond.sub.org>
 <21a2d5fb-0181-4ce8-8bea-a214c8eac2d7@redhat.com>
Date: Fri, 05 Dec 2025 13:16:39 +0100
Message-ID: <87cy4t3yzc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 12/5/25 11:04, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> These are used by tests.  However it could even be an idea to use
>>> serde_json + transcoding and get rid of the C version...
>> 
>> Tell me more!
>
> QEMU's JSON parser produces a QObject.  To obtain the same effect, we 
> can take JSON-string-to-serde deserialization (implemented by 
> serde_json) and attach it to serde-to-QObject serialization (the thing 
> in patch 5).  That results in a JSON-string-to-QObject function.
>
> Doing it in the other direction (QObject deserializer + JSON-string 
> serializer) produces a QObject-to-JSON-string function.

Yes.

> For a little more information see https://serde.rs/transcode.html.
>
> Note however that there is no support for push parsing, therefore this 
> would not replace the balanced-parentheses machinery in 
> qobject/json-streamer.c, and therefore QMP would still need a minimal lexer.

That push parser...  I never liked it.  First, it's half-assed: it's a
push lexer wed to a pull parser with parenthesis counting.  Second, why
complicated & half-assed when you can do simple & quarter-assed instead?
We could've required "exactly one complete JSON value per line", or some
expression separator such as an empty line.

> Grr... I just remembered about interpolation :/ so no, we still need a 
> parser for libqmp.c.

Right.

Interpolation lets us build QObjects from literal templates with
variable scalars or QObjects interpolated.  More concise and much easier
to read than the equivalend nest of constructor calls.  Drawback: chains
us to our own, bespoke JSON parser.

Out of curiosity: how would we do better than "nest of constructor
calls" in Rust?


