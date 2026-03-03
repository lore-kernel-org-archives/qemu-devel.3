Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518B0EC0486
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMYh-0005Uc-7U; Tue, 03 Mar 2026 05:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vxMYe-0005Rr-Iv
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vxMYc-0003L4-CP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:00:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772532048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+I1VudMC+NxAe8pQ2YUQhe5nrqMg2fVzn96RL8BfTQ=;
 b=VRe6XAMFirNo8bum1kD6J5Kbm+RSLH7kVB5W0Z2VbVgouf2M7m2hvlkkxuwx93avQ2PtfP
 41AHinbUUbiBWuJb4fCAbsFOCVIuhzqXrRry78Q0nBcyQwf8bRkNN4oT4URpudJjPRMwK3
 lr042XPyo0QhVdFBAg+0lLDfiJSpbeQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-YeeS1SsANq6RU6hfj-Ezog-1; Tue, 03 Mar 2026 05:00:46 -0500
X-MC-Unique: YeeS1SsANq6RU6hfj-Ezog-1
X-Mimecast-MFC-AGG-ID: YeeS1SsANq6RU6hfj-Ezog_1772532046
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-660ae93b90dso242729a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772532046; x=1773136846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E+I1VudMC+NxAe8pQ2YUQhe5nrqMg2fVzn96RL8BfTQ=;
 b=mVVNr00Ge5Ea2V82mctpt8GcINmNTrMYGmjLptx3uuaLRtsF68ep4QwoxKid3IqcFb
 9bd8ZX0TkMVvKJujKBvMD7AuW4VKwdNJExlSXx0lVOuw4AuSg1h6yV8JgM1AQsuacGjv
 F5spDRYH+rWIhKXysZve0TWdt9sY3t1/x0g63YN6TrgkJmS3ZrKCieY9PuB34Q3oN7pt
 z5v6TLrEY785yRxwHqMJbqMK3j/pzvuOXas9QQfkDYPTF0Tlom6P1K1uMoFSeSAsiSWE
 pwkJMLzrETAbFraVuOQtfoXGHGcP29z4nQLmUdtAQf6a5kHK1FFoljmt9NFovmGPQzpj
 Gqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772532046; x=1773136846;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+I1VudMC+NxAe8pQ2YUQhe5nrqMg2fVzn96RL8BfTQ=;
 b=U9aH3ycequ9JjWP1YF9ZV8YXwguCNQShnzFKbEgr9IT25i9Vtpd02Ee7s/2FS3Vgi2
 KljLYdEvRmL8GWC523U584+iuK6ImY8LsgwrhGirzBHoRWRVOehtawGk53HlcxGdNEn6
 Z2MVTNwrMcIziS7Fim4+viAn7hrn8sSjh+/EKcSICZ0otmbQab3n5prJU/oRhTw8skyc
 hK9LpBigR8BwJISfJmW5+XvBSdUaM84raf2VTaqbBXZ5zk2LVhq4kVefELLI3C05zIzI
 6y68abMFA+A1fDyol5czM2rC/mzX/j6bJkGWhJBQhrY1ba8ioMrVFVQF/xAaPEBqGohn
 lYrQ==
X-Gm-Message-State: AOJu0YzOm5BcDZvPD3eBQyUycBT/n499FC97edcM6Gq6/XMpIq8EcucF
 hCHzjVsjg//eWJfvDw0AZCb5CPgUwQyAqVnqyoecrGkXEqCRJ4JlR+/+Q1h1VspmMVNKcNqPaTr
 HczKkl3iblYoDmH5DfDcJT7T7kynq3iXu6ZY5v5w4MwRWuA2/gc6CfBLW
X-Gm-Gg: ATEYQzzObp8S58EaeLWF2gq9AdDQkXILFV2lrI43RCYI7bQitcDRB0vZ6RSAKrAVpBV
 rS0sgZfh9UVuLF46EkFae0V2A5mcJStwJXiQZaEKHb6j/tBgjDaXsLVR0mxdt6W1wg7he0vAIj2
 beOaoS0gDOn0wkyih48Gjkuw6CI5kCXBx3g5/cP1tVwvTQi7A15aibk5vFUfMe2Y/vku0XoI+/5
 dNpAPARKSML8mBMUL4mUZMOxtj1ChLfu/TclRqNEKhb/wV/i6d6uumBH5MycumCjc1keJqpyL3H
 voNyNpceZLb1pTLHw88u/C/Bny1HqqQ6M0TLXOSSZU0Glo7mbUiNIVYHHL2bPQFj/z18LUzuk4x
 /8+2+MijBM105IZdi3q4DEu40RJe+O3xlAVWLEJA+2OfGx8fF9eqj2Lq/44VVQ+m5gkgPglj/u5
 OHFRtYZi5vWC6oMnVdXmInULuhBn8=
X-Received: by 2002:a17:907:3e0e:b0:b93:7255:2da with SMTP id
 a640c23a62f3a-b937659feb6mr1017289866b.55.1772532045206; 
 Tue, 03 Mar 2026 02:00:45 -0800 (PST)
X-Received: by 2002:a17:907:3e0e:b0:b93:7255:2da with SMTP id
 a640c23a62f3a-b937659feb6mr1017288266b.55.1772532044601; 
 Tue, 03 Mar 2026 02:00:44 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b935ab13564sm576055866b.9.2026.03.03.02.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 02:00:43 -0800 (PST)
Message-ID: <3cd5ac78-1833-4671-a866-60a57f29c3c1@redhat.com>
Date: Tue, 3 Mar 2026 11:00:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com> <87jyw0khu2.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87jyw0khu2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

On 2/25/26 15:39, Markus Armbruster wrote:
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
>         Identifiers starting with an underscore are typically used to
>         indicate an identifier that is intentionally unused, and will
>         silence the unused warning in rustc.
> 
>         https://doc.rust-lang.org/reference/identifiers.html
> 
> You replied "In this case it doesn't really matter: public items (such
> as QAPI enum entries, or struct fields) do not raise the unused warning
> anyway."
> 
> What gives us confidence rs_name() will only be used where it doesn't
> really matter?

The fact that all QAPI type definitions are (more or less by design) public.

>> +    # avoid some clashes with the standard library
>> +    if name in ('String',):
>> +        name = 'Qapi' + name
> 
> This hides the unwise use of 'String' in qapi/net.json from Rust.  I'd
> rather rename that one.

Ok, BoxedString?

>> +
>> +    return name
>> +
>> +
>> +def to_camel_case(value: str) -> str:
>> +    return ''.join('_' + word if word[0].isdigit()
>> +                   else word[:1].upper() + word[1:]
>> +                   for word in filter(None, re.split("[-_]+", value)))
> 
> Please use r'...' for regular expressions always.
> 
> Why do you need filter()?

To handle - or _ at the beginning or ending of a string, where an empty
string would cause an IndexError in word[0].isdigit().

> This maps 'foo-0123-bar' to 'Foo_0123Bar'.  Intentional?  I'd kind of
> expect 'Foo0123Bar'.

Will fix (it is meant for 0123-45).  New version is:

   def to_camel_case(value: str) -> str:
       result = ''
       for p in re.split(r'[-_]+', value):
           if not p:
               pass
           elif p[0].isalpha() or (result and result[-1].isalpha()):
               result += p[0].upper() + p[1:]
           else:
               result += '_' + p
       return result


>> +def mcgen(s: str, **kwds: object) -> str:
>> +    s = mcgen_common(s, **kwds)
>> +    return re.sub(r'(?: *\n)+', '\n', s)
> 
> This eats trailing spaces and blank lines.  The latter is a big hammer.
> Without it, I see unwanted blank lines generated.  With it, I see wanted
> blank lines eaten.  For instance:

Ok, I can look into adding rstrip here and there.

>> +        except FileNotFoundError:
>> +            pass
> 
> This runs rustfmt to clean up the generated file.  Silently does nothing
> if we don't have rustfmt.
> 
> Should we make rustfmt a hard requirement?  Please discuss this briefly
> in the commit message.

It's unnecessary, but it does make the output look nicer.  If I add 
rstrip, I don't need it.

>> +    # Return the Rust type for common use
> 
> Are the uncommon uses?
> 
> There are for C types, and that's why we have both .c_type(),
> .c_param_type(), nad .c_unboxed_type().

Yes, Box<> and Vec<>.  They just don't deserve their own function unlike C.

Paolo


