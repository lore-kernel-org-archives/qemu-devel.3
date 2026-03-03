Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66812EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOuR-00065W-Sm; Tue, 03 Mar 2026 07:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxOuQ-000653-Gx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:31:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxOuN-0006Dn-P6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772541086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybb11lRCy39saXn0SAVkvh1jiQvsVRtRXDy8hFM2Bmk=;
 b=aADCcXYAh/AFPZtWtb5UynkX1SwcNcyXyLJej6uzPiMPb1XpnSwPSMpoxdIShIh8lrTSkk
 72CB48177Q3+UL4fJ1rm76ljXSbgpcSXxL9JDgWlf9jWaIWIzweN9Ca/wwWGlDmprXKe8o
 WDNEd5Fe5HlsO/aBgZeATUhsbTh3dcA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-pKECtL6tMlS3QjefPaG09w-1; Tue,
 03 Mar 2026 07:31:24 -0500
X-MC-Unique: pKECtL6tMlS3QjefPaG09w-1
X-Mimecast-MFC-AGG-ID: pKECtL6tMlS3QjefPaG09w_1772541084
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEE5F1800282; Tue,  3 Mar 2026 12:31:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.30])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 790071956053; Tue,  3 Mar 2026 12:31:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0E67F21E692F; Tue, 03 Mar 2026 13:31:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
In-Reply-To: <3cd5ac78-1833-4671-a866-60a57f29c3c1@redhat.com> (Paolo
 Bonzini's message of "Tue, 3 Mar 2026 11:00:42 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com>
 <87jyw0khu2.fsf@pond.sub.org>
 <3cd5ac78-1833-4671-a866-60a57f29c3c1@redhat.com>
Date: Tue, 03 Mar 2026 13:31:21 +0100
Message-ID: <87v7fdm6w6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On 2/25/26 15:39, Markus Armbruster wrote:
>>> +def rs_name(name: str) -> str:
>>> +    """
>>> +    Map @name to a valid, possibly raw Rust identifier.
>>> +    """
>>> +    name = re.sub(r'[^A-Za-z0-9_]', '_', name)
>>> +    if name[0].isnumeric():
>> 
>> .isdigit()?  It's what c_name() uses...
>> 
>>> +        name = '_' + name
>> 
>> In review of v1, I pointed to "The Rust Reference"
>> 
>>         Identifiers starting with an underscore are typically used to
>>         indicate an identifier that is intentionally unused, and will
>>         silence the unused warning in rustc.
>> 
>>         https://doc.rust-lang.org/reference/identifiers.html
>> 
>> You replied "In this case it doesn't really matter: public items (such
>> as QAPI enum entries, or struct fields) do not raise the unused warning
>> anyway."
>> 
>> What gives us confidence rs_name() will only be used where it doesn't
>> really matter?
>
> The fact that all QAPI type definitions are (more or less by design) public.

Any particular reason not to use the same 'q_' prefix as in C?

>>> +    # avoid some clashes with the standard library
>>> +    if name in ('String',):
>>> +        name = 'Qapi' + name
>> 
>> This hides the unwise use of 'String' in qapi/net.json from Rust.  I'd
>> rather rename that one.
>
> Ok, BoxedString?

Works for me.

>>> +
>>> +    return name
>>> +
>>> +
>>> +def to_camel_case(value: str) -> str:
>>> +    return ''.join('_' + word if word[0].isdigit()
>>> +                   else word[:1].upper() + word[1:]
>>> +                   for word in filter(None, re.split("[-_]+", value)))
>> 
>> Please use r'...' for regular expressions always.
>> 
>> Why do you need filter()?
>
> To handle - or _ at the beginning or ending of a string, where an empty
> string would cause an IndexError in word[0].isdigit().

Got it, thanks.

>> This maps 'foo-0123-bar' to 'Foo_0123Bar'.  Intentional?  I'd kind of
>> expect 'Foo0123Bar'.
>
> Will fix (it is meant for 0123-45).  New version is:
>
>    def to_camel_case(value: str) -> str:
>        result = ''
>        for p in re.split(r'[-_]+', value):
>            if not p:
>                pass
>            elif p[0].isalpha() or (result and result[-1].isalpha()):
>                result += p[0].upper() + p[1:]
>            else:
>                result += '_' + p
>        return result

Maps '0123-45' to '_0123_45'.  Is the leading '_' intentional?

>>> +def mcgen(s: str, **kwds: object) -> str:
>>> +    s = mcgen_common(s, **kwds)
>>> +    return re.sub(r'(?: *\n)+', '\n', s)
>> 
>> This eats trailing spaces and blank lines.  The latter is a big hammer.
>> Without it, I see unwanted blank lines generated.  With it, I see wanted
>> blank lines eaten.  For instance:
>
> Ok, I can look into adding rstrip here and there.
>
>>> +        except FileNotFoundError:
>>> +            pass
>> 
>> This runs rustfmt to clean up the generated file.  Silently does nothing
>> if we don't have rustfmt.
>> 
>> Should we make rustfmt a hard requirement?  Please discuss this briefly
>> in the commit message.

I'm fine with not running rustfmt, and I'm fine with running it always
(makes it a hard requirement).  Running it sometimes feels like more
trouble than it's worth.

> It's unnecessary, but it does make the output look nicer.  If I add 
> rstrip, I don't need it.
>
>>> +    # Return the Rust type for common use
>> 
>> Are the uncommon uses?
>> 
>> There are for C types, and that's why we have both .c_type(),
>> .c_param_type(), nad .c_unboxed_type().
>
> Yes, Box<> and Vec<>.  They just don't deserve their own function unlike C.

I see.


