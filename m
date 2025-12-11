Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E8CD3E79C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTb35-0001wy-28; Thu, 11 Dec 2025 02:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTb33-0001wB-9I
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTb31-0006kw-96
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765437910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tE5PY0BetNsc4otVFzIqb9k9pZiLPC1jdETfe0pWfgA=;
 b=BmH6I7xFhiQaRKbfpxp3va4J/I1T6L5KenC+mAqfRXG9HIcomqP0eJx4shY1vD6dC9o2+8
 jnN3NbRN2uptoGOX7rVp0fCnwLuvcylL/u2/a8QlweXF8qbDdIokECJ+yjDSxw1zpi/QPO
 0f3iOKotMCAjUIXw9Kn+6dGgmF0O8bw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-aUUXubzxPSqDU6_WSIhcsA-1; Thu,
 11 Dec 2025 02:25:08 -0500
X-MC-Unique: aUUXubzxPSqDU6_WSIhcsA-1
X-Mimecast-MFC-AGG-ID: aUUXubzxPSqDU6_WSIhcsA_1765437907
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6FCB18002C0; Thu, 11 Dec 2025 07:25:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8230C1953984; Thu, 11 Dec 2025 07:25:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA94F21E6A27; Thu, 11 Dec 2025 08:25:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com,  qemu-rust@nongnu.org
Subject: Re: [PATCH 14/19] scripts/qapi: generate high-level Rust bindings
In-Reply-To: <f8b03a16-d957-4968-a7c8-38fec0b01a88@redhat.com> (Paolo
 Bonzini's message of "Wed, 10 Dec 2025 15:38:51 +0100")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-15-pbonzini@redhat.com>
 <87v7ig3rc2.fsf@pond.sub.org>
 <f8b03a16-d957-4968-a7c8-38fec0b01a88@redhat.com>
Date: Thu, 11 Dec 2025 08:25:04 +0100
Message-ID: <87345h5vlb.fsf@pond.sub.org>
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/9/25 11:03, Markus Armbruster wrote:
>> * Why is util::qobject::QObject needed?
>> 
>> * NONE is an error value, not a valid QType.  Having such error values
>>    in enums isn't unusual in C.  What about idiomatic Rust?  Even if it's
>>    unusual there, we may elect to do it anyway, just to keep generated
>>    Rust closer to C.  But it should be a conscious decision, not a blind
>>    port from C to Rust.
>
> For QType we don't need to keep it closer, but actually ABI-compatible: 
> QType is defined by QAPI but is used (almost exclusively) by QObject. 
> We use the C version in the QObject bindings, for example:
>
>                  $($crate::bindings::QTYPE_QNULL => break $unit,)?

I see.  Worth a comment.

>> * "Default for QType" is NONE.  In C, it's zero bytes, which boils down
>>    to QTYPE_NONE.
>> 
>> * QTYPE__MAX is a bit of a headache in C.  It's not a valid enum value.
>>    We make it one only because we need to know the largest valid enum
>>    value, e.g. to size arrays, and the easiest way to get that value is
>>    adding an invalid one to the enum.  Same for all the other generated
>>    enums.  Could we avoid it in Rust?
>
> Yes, I think so.
>
>> * C has a file comment of the form
>> 
>>      /*
>>       * One-line description of the file's purpose
>>       *
>>       * Copyright lines
>>       *
>>       * License blurb
>>       */
>> 
>>    I think Rust could use such a comment, too.
>
> Ok.
>
>> * C has built-in types like QType in qapi-builtin-types.h, generated
>>    only with -b.  This is a somewhat crude way to let code generated for
>>    multiple schemas coexist: pass -b for exactly one of them.  If we
>>    generated code for built-in types unconditionally into qapi-types.h,
>>    the C compiler would choke on duplicate definitions.  Why is this not
>>    a problem with Rust?
>
> Because there's better namespacing, so it's okay to define the builtin 
> types in more than one place.  However, do we need at all the builtin 
> types in Rust?  QType is only defined in QAPI to have the nice enum 
> lookup tables, and we can get it via FFI bindings.  Lists, as you say 
> below, are not needed, and they are also a part of qapi-builtin-types.h.
>
> So I think Rust does not need built-in types at all, which I think 
> solves all your problems here (other than _MAX which can be removed).

Let's try this.

>> * The Rust version doesn't have deallocation boilerplate.  Deallocation
>>    just works there, I guess.
>> 
>> * The Rust version doesn't have the List type.  Lists just work there, I
>>    guess.
>
> Yep.
>
>> * The Rust version doesn't have the implicit type q_obj_my_command_arg,
>>    which is the arguments of my-command as a struct type.  C needs it for
>>    marshaling / unmarshaling with visitors.  Rust doesn't, because we use
>>    serde.  Correct?
>
> Commands are not supported at all yet.
>
> Paolo

Thanks!


