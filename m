Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC01D3C91A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLWc-0007Ip-UF; Wed, 10 Dec 2025 09:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTLWD-0007DO-BJ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTLW9-0003CJ-Pt
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765378211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VloBJ6nNIJ/u+vJJM5GLcChSzr76vTrdVTPXNM/9iqw=;
 b=Dskh0l65hfwgijAUV+F/J4RVLwtT/xKDw2wKkQDtcaUTTz/4CIFh8kLd+OxJK6uK7++pRX
 sRA5/bLS2kt5baQ6y4crd+EtyOl5b4fut6Vdhgqzz1y8t/WqWNL9S0CoZ2Hja3rivgY2JT
 K9hjN41dPeWgJfW+oQXa2P9cg6RSv3o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-gF420JAJNjKHiCiso7M-ww-1; Wed,
 10 Dec 2025 09:50:09 -0500
X-MC-Unique: gF420JAJNjKHiCiso7M-ww-1
X-Mimecast-MFC-AGG-ID: gF420JAJNjKHiCiso7M-ww_1765378208
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A4F019560BC; Wed, 10 Dec 2025 14:50:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 050D230001A5; Wed, 10 Dec 2025 14:50:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77D0721E6A27; Wed, 10 Dec 2025 15:50:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 00/19] rust: QObject and QAPI bindings
In-Reply-To: <525d2198-5d6f-43a0-88cd-78eae0042d27@redhat.com> (Paolo
 Bonzini's message of "Wed, 10 Dec 2025 15:12:35 +0100")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <87tsy52ftl.fsf@pond.sub.org> <87zf7s5h3k.fsf@pond.sub.org>
 <525d2198-5d6f-43a0-88cd-78eae0042d27@redhat.com>
Date: Wed, 10 Dec 2025 15:50:05 +0100
Message-ID: <878qfa8k82.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On 12/9/25 07:01, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>> 
>>> I applied, ran make, and it didn't create qapi-types.rs and
>>> test-qapi-types.rs for me.  What am I missing?
>> 
>> Looks like I have to run with -B qapi.backend.QAPIRsBackend.
>> 
>> -B is meant for out-of-tree backends.  Commit dde279925c9 explains:
>> 
>>      qapi: pluggable backend code generators
>>      
>>      The 'qapi.backend.QAPIBackend' class defines an API contract for code
>>      generators. The current generator is put into a new class
>>      'qapi.backend.QAPICBackend' and made to be the default impl.
>>      
>>      A custom generator can be requested using the '-k' arg which takes a
>>      fully qualified python class name
>>      
>>         qapi-gen.py -B the.python.module.QAPIMyBackend
>>      
>>      This allows out of tree code to use the QAPI generator infrastructure
>>      to create new language bindings for QAPI schemas. This has the caveat
>>      that the QAPI generator APIs are not guaranteed stable, so consumers
>>      of this feature may have to update their code to be compatible with
>>      future QEMU releases.
>> 
>> Using it for the in-tree Rust backend is fine for a prototype.
>> Mentioning it in a commit message or the cover letter would've saved me
>> some digging.
>
> Well, it wasn't intentional - right now it does this:
>
> test_qapi_rs_files = custom_target('QAPI Rust',
>    output: 'test-qapi-types.rs',
>    input: [ files(meson.project_source_root() + 
> '/tests/qapi-schema/qapi-schema-test.json') ],
>    command: [ qapi_gen, '-o', meson.current_build_dir(), '-b', 
> '@INPUT0@', '-B', 'qapi.backend.QAPIRsBackend', '-p', 'test-' ],
>    depend_files: [ qapi_inputs, qapi_gen_depends ])
>
> so "make rust/tests/test-qapi-types.rs" will work, and so will "make" if 
> you have --enable-rust.
>
> Let us know what you'd prefer and we'll switch.  Alternatively, 
> retconning -B's meaning so that it applies to Rust will work too. :)

Any particular reason *not* to generate Rust unconditionally along with
C?

To do it, stick gen_rs_types() into QAPICodeBackend.generate().  Then
the build runs qapi-gen at most once[*].



[*] Lie.  Sphinx runs the *frontend* another time.


