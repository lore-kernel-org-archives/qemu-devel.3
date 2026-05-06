Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17657CD3436
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 11:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZz8-0000Cv-NM; Wed, 06 May 2026 07:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZz3-00008w-DC
 for qemu-devel@nongnu.org; Wed, 06 May 2026 07:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKZz0-0004Qs-Vz
 for qemu-devel@nongnu.org; Wed, 06 May 2026 07:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778065201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9WCfmuIDhIzTrXV3IX2R7j5DXkYdDYoWXzocuU2i+s=;
 b=FoQH2nJqlJcH/O2Xy9QlDLRgAG7kTxpkJ/8omc1UdBaDX0xKZ3zZ9WDKV5IcyAapGqcrdP
 WQ3uMK+MKLb8pwH6Ue5SJ8l0FvIiRU8xDhxNrnvQ0a1iw9WbHrC120UG0UMA9Dj5CQhZNn
 zx5x69Zl+sSepEGZ8q5xJOpRn+RE3Yg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-GuujLuNYMlucMjnMPIXebA-1; Wed,
 06 May 2026 06:59:59 -0400
X-MC-Unique: GuujLuNYMlucMjnMPIXebA-1
X-Mimecast-MFC-AGG-ID: GuujLuNYMlucMjnMPIXebA_1778065199
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8886195609D; Wed,  6 May 2026 10:59:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AC28180034E; Wed,  6 May 2026 10:59:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB12221E6A01; Wed, 06 May 2026 12:59:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
In-Reply-To: <87jyw0khu2.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 25 Feb 2026 15:39:49 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com>
 <87jyw0khu2.fsf@pond.sub.org>
Date: Wed, 06 May 2026 12:59:55 +0200
Message-ID: <87se84dcr8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

FYI, I just posted patches to get rid of QAPI type String:

    Subject: [PATCH 0/4] qapi/net: Some doc improvement and cleanup
    Date: Wed, 6 May 2026 12:54:17 +0200
    Message-ID: <20260506105421.2461117-1-armbru@redhat.com>
    https://lore.kernel.org/qemu-devel/20260506105421.2461117-1-armbru@redhat.com/


Markus Armbruster <armbru@redhat.com> writes:

[...]

>> +def rs_name(name: str) -> str:
>> +    """
>> +    Map @name to a valid, possibly raw Rust identifier.
>> +    """
>> +    name = re.sub(r'[^A-Za-z0-9_]', '_', name)
>> +    if name[0].isnumeric():
>
> .isdigit()?  It's what c_name() uses...
>
>> +        name = '_' + name
>
> In review of v1, I pointed to "The Rust Reference"
>
>        Identifiers starting with an underscore are typically used to
>        indicate an identifier that is intentionally unused, and will
>        silence the unused warning in rustc.
>
>        https://doc.rust-lang.org/reference/identifiers.html
>
> You replied "In this case it doesn't really matter: public items (such
> as QAPI enum entries, or struct fields) do not raise the unused warning
> anyway."
>
> What gives us confidence rs_name() will only be used where it doesn't
> really matter?
>
>> +    # based from the list:
>> +    # https://doc.rust-lang.org/reference/keywords.html
>> +    if name in ('Self', 'abstract', 'as', 'async',
>> +                'await', 'become', 'box', 'break',
>> +                'const', 'continue', 'crate', 'do',
>> +                'dyn', 'else', 'enum', 'extern',
>> +                'false', 'final', 'fn', 'for',
>> +                'if', 'impl', 'in', 'let',
>> +                'loop', 'macro', 'match', 'mod',
>> +                'move', 'mut', 'override', 'priv',
>> +                'pub', 'ref', 'return', 'self',
>> +                'static', 'struct', 'super', 'trait',
>> +                'true', 'try', 'type', 'typeof',
>> +                'union', 'unsafe', 'unsized', 'use',
>> +                'virtual', 'where', 'while', 'yield'):
>> +        name = 'r#' + name
>
> TIL...
>
>> +    # avoid some clashes with the standard library
>> +    if name in ('String',):
>> +        name = 'Qapi' + name
>
> This hides the unwise use of 'String' in qapi/net.json from Rust.  I'd
> rather rename that one.

[...]


