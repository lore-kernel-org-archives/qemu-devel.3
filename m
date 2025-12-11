Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822DBD3E79D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTamT-0003NL-3n; Thu, 11 Dec 2025 02:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTamQ-0003J3-U9
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTamO-000444-Tp
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765436879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MYhwINcbGJ2rdXQEEkiwV3EExQYCS4iq4M2mf3a/QDE=;
 b=iA+oh/g+oe/1zOTMNZrlFGn0WoeulER6A3XDM/e53ynbF3TFOAletJ72+mxLuqp5RRF7K9
 KQJPxsKfixznTHh5vxVCB1aAyhlWXFJeb78EogNwp0/gOyFtu9FlARD4IixL+iAJRtqGvd
 h1XAiOuIZeK2+qha8SUYp5tTQf190r4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-_ljHldZQN1GrqjZr9LyJMg-1; Thu,
 11 Dec 2025 02:07:56 -0500
X-MC-Unique: _ljHldZQN1GrqjZr9LyJMg-1
X-Mimecast-MFC-AGG-ID: _ljHldZQN1GrqjZr9LyJMg_1765436875
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B61541956061; Thu, 11 Dec 2025 07:07:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AD811953984; Thu, 11 Dec 2025 07:07:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B4CAF21E6A27; Thu, 11 Dec 2025 08:07:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/19] rust/qobject: add Serialize implementation
In-Reply-To: <239ea6cb-de87-48b7-8ef0-71158bf5ae70@redhat.com> (Paolo
 Bonzini's message of "Wed, 10 Dec 2025 18:19:37 +0100")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-7-pbonzini@redhat.com>
 <87a4zx5kgm.fsf@pond.sub.org>
 <239ea6cb-de87-48b7-8ef0-71158bf5ae70@redhat.com>
Date: Thu, 11 Dec 2025 08:07:52 +0100
Message-ID: <87fr9h5wdz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 12/5/25 10:47, Markus Armbruster wrote:
>>> +        match_qobject! { (self) =>
>>> +            () => serializer.serialize_unit(),
>>> +            bool(b) => serializer.serialize_bool(b),
>>> +            i64(i) => serializer.serialize_i64(i),
>>> +            u64(u) => serializer.serialize_u64(u),
>>> +            f64(f) => serializer.serialize_f64(f),
>>> +            CStr(cstr) => cstr.to_str().map_or_else(
>>> +                |_| Err(ser::Error::custom("invalid UTF-8 in QString")),
>> 
>> Could this be a programming error?  Like flawed input validation?

qobject's JSON parser validates, see parse_string().

> Possibly, but given that you have to create a custom error type anyway, 
> I'd rather not special case this into the only abort (see the 
> "#![deny(clippy::unwrap_used)]" in patch 4).

We *should* abort on programming error.

.to_str() fails when its argument is invalid UTF-8.  It returns "an
error with details of where UTF-8 validation failed."[1]

Why are we replacing this error with a custom one?  I guess we add the
clue "in QString".  We also lose the details of where.  Feels like a
questionable trade.

Can we use .expect()?  It panics "if the value is an Err, with a panic
message including the passed message, and the content of the Err."[2]

If we decide this isn't a programming error (because QString may contain
arbitrary zero-terminated byte sequences[3]): can we combine all the
readily available information like .expect() does?


[1] https://doc.rust-lang.org/std/ffi/struct.CStr.html#method.to_str
[2] https://doc.rust-lang.org/std/result/enum.Result.html#method.expect
[3] Feels like a problematic idea to me.


