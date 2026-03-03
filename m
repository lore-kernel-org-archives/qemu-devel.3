Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAD2EC1431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPdz-0005lD-Fj; Tue, 03 Mar 2026 08:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vxPdx-0005ki-F7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:18:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vxPdv-000272-A1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772543909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMeLeLGM3VWI7m/PqytyRwFZ9ygZG3Yk77w/eKyUnkY=;
 b=Al2irn/bG6FJilJn5zyW6lxk0U/0B1pOkWgBES1FGGxMapWPxTc7tvV9hI2m40z8ZbPjwq
 bc9GytP/GiBKim8iBZW8qdoqtZ0wTEaJnL3YSpToGrWNt6rA6OjxgIqhtMaaQYpRmy8JbH
 uttBWCwrMzIz8tUBVX+XaVcw6VRGjlE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-wrUMgU-MMPOj1Pq9zAOs6w-1; Tue, 03 Mar 2026 08:17:44 -0500
X-MC-Unique: wrUMgU-MMPOj1Pq9zAOs6w-1
X-Mimecast-MFC-AGG-ID: wrUMgU-MMPOj1Pq9zAOs6w_1772543863
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b8fbe7a6f41so509867066b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772543863; x=1773148663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mMeLeLGM3VWI7m/PqytyRwFZ9ygZG3Yk77w/eKyUnkY=;
 b=b87FcF4+PSERcgxLEDAAxOmhUyhdbDgPJasVRgAB9YjEP09ZLpBA6mUxTYCWT0P4mV
 wDDB8nLMeHSUZRAwoouqjwBF+hgbOshQWbINaUX+OwGtnI36G1JaNC3L5Fk9Zdl6Vz7F
 W6Iws1GZqynQ4fr2UuMO/F7LciGckm6q7QjuyuG5n2t0fcb+CrJ7y+sYVwUS7b8M2u7J
 ekQWUvl9q8FKnBa5FFa2Ii+p/90wy1sL14SwdDHdYKkwxXmX1TN3/uVybgYE5zluHujT
 OEHGvEO53S5DBd8PCzmNxLocurpadNTl5rvZwn5gcEgfsYJNxTgKc7Cssb2whaAWdpmy
 6Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772543863; x=1773148663;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mMeLeLGM3VWI7m/PqytyRwFZ9ygZG3Yk77w/eKyUnkY=;
 b=f8pHyPx9rnGiT5nsF2UHZi3ePGanD/0/9CgpPL7fA94JgwaF1MyxjLwotwtp4APo7d
 x2d6m8geECB53Msw2ZBQsW8apz5y/cyD3paP6IkJprA7qP4Rcye7Snu6M7YVHaRPnSXI
 SqT1+yzo62+uSDZ/xWgcKEXp5wYPl1n63Snka8HLKy8cpxHt4f0yvj2gWFe/fNGDYJiz
 ICiI833nF8+4H40Hq7vibZX/tpBLefgtQS586PXKfog5kkQQHhii4W1XhUmLqaKfSl2g
 RlVhHUXHDpLMou7IS6u/688IR2kxqTfVZR2MNwYypIDAgrTMreWuxlmcIEhhj96YVnBj
 8Bpg==
X-Gm-Message-State: AOJu0YwpWrTzikyCEGDaBYQsY6KrxganPg9bBepZs5re9VLk71maHR/j
 8rvRuWxOeR7090AIi4pJQfoA9uoEg89RdfrCDNemGiJZmTVLUe2hfAbqeGK15GelHepxMdWf6I+
 uceHRzC1yDDBKusWRIRGdIevKPU194G26wGshxPrt70n9ZPTGsXA5nUJz
X-Gm-Gg: ATEYQzxONQKs60q3dxAQeMJ0UjdwKaZblXJTygfz7xGbI2PhNks8ZH7EMo/hfCFD7k8
 T3HwTplu3mtjSnfTZyTWTWl/8oOEsyqbCEAqwODiQyR8LStsriGxJkis+ehwESiyEcaftoH8xps
 0Os9Ok+fpbUbIV1MaexqEJlV54TmjmmNooOexSxpgRi3zoeP72sem2Vq1KIpBrKs3XmmXSY63EY
 niGc5udG6g6bfTwvx5dh7OMvonIQf0971uo5bZpkd3CIZ8TeUjSUrvoupVqqgfhG+fBRoLwkD+a
 aKxI/tAgxa40Mc9manSwEM9VpeSVYbR7ExsPj+eqd+B6AnsARcillYBWIc2zswBucW1CyiCUeop
 TuZXVcWVy/48/+7cowlzYem/4C2N6/fuzlD/NNSDElZGOVRpucEPCkYiMKU2G5UIfUEFQ/EWX47
 d1vIMBUkNCIvKjsI1SJcD0Ul8pow8=
X-Received: by 2002:a17:906:951:b0:b93:5c5c:a9ae with SMTP id
 a640c23a62f3a-b9376511a03mr651841966b.34.1772543862819; 
 Tue, 03 Mar 2026 05:17:42 -0800 (PST)
X-Received: by 2002:a17:906:951:b0:b93:5c5c:a9ae with SMTP id
 a640c23a62f3a-b9376511a03mr651839466b.34.1772543862157; 
 Tue, 03 Mar 2026 05:17:42 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b935ae60c16sm594356066b.38.2026.03.03.05.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 05:17:41 -0800 (PST)
Message-ID: <ad122aa5-a726-4057-add5-78b3356e395a@redhat.com>
Date: Tue, 3 Mar 2026 14:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-13-pbonzini@redhat.com> <87seahnucu.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87seahnucu.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/3/26 10:19, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Generate high-level native Rust declarations for the QAPI types.
>>
>> - char* is mapped to String, scalars to there corresponding Rust types
>>
>> - enums use #[repr(u32)] and can be transmuted to their C counterparts
>>
>> - has_foo/foo members are mapped to Option<T>
>>
>> - lists are represented as Vec<T>
>>
>> - structures map fields 1:1 to Rust
>>
>> - alternate are represented as Rust enum, each variant being a 1-element
>>    tuple
>>
>> - unions are represented in a similar way as in C: a struct S with a "u"
>>    member (since S may have extra 'base' fields). The discriminant
>>    isn't a member of S, since Rust enum already include it, but it can be
>>    recovered with "mystruct.u.into()"
>>
>> Anything that includes a recursive struct puts it in a Box.  Lists are
>> not considered recursive, because Vec breaks the recursion (it's possible
>> to construct an object containing an empty Vec of its own type).
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lureau@redhat.com
>> [Paolo: rewrite conversion of schema types to Rust types]
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Let's look at the generated Rust.  I'm going to ignore formatting issues
> like blank lines.  My test inputs are adapted from
> tests/qapi-schema/qapi-schema-test.json.
> 
> = Boilerplate and built-in stuff =
> 
> The qapi-types.rs generated for an empty schema is basically empty:
> 
>      // @generated by qapi-gen, DO NOT EDIT
>      //!
>      //! Schema-defined QAPI types
>      //!
>      //! Copyright (c) 2025 Red Hat, Inc.
>      //!
>      //! This work is licensed under the terms of the GNU LGPL, version 2.1 or
>      //! later. See the COPYING.LIB file in the top-level directory.
>      #![allow(unexpected_cfgs)]
>      #![allow(non_camel_case_types)]
>      #![allow(clippy::empty_structs_with_brackets)]
>      #![allow(clippy::large_enum_variant)]
>      #![allow(clippy::pub_underscore_fields)]
>      // Because QAPI structs can contain float, for simplicity we never
>      // derive Eq.  Clippy however would complain for those structs
>      // that *could* be Eq too.
>      #![allow(clippy::derive_partial_eq_without_eq)]
>      use util::qobject::QObject;
> 
> Okay.
> 
> Note we generate nothing for the built-in types.  For C, we generate
> qapi-builtin-types.[ch], which provides lists of built-in types, and
> enum QType.  Rust gives us lists for free, and QType we don't need right
> now.  Good.
> 
> = Enum types =
> 
> Input:
> 
>      { 'enum': 'TestIfEnum',
>        'data': [ 'foo', { 'name' : 'bar', 'if': 'TEST_IF_ENUM_MEMBER' } ],
>        'if': 'TEST_IF_UNION' }
> 
> Output without the boilerplate:
> 
>      #[cfg(TEST_IF_UNION)]
>      #[derive(Copy, Clone, Debug, PartialEq)]
> 
> Ignoring such lines for now.
> 
>      #[repr(u32)]
> 
> As explained in the commit message.
> 
>      #[derive(common::TryInto)]
> 
> Ignoring these, too.
> 
>      pub enum TestIfEnum {
> 
>          FOO,
>          #[cfg(TEST_IF_ENUM_MEMBER)]
>          BAR,
>      }
> 
> The obvious part :)
> 
>      #[cfg(TEST_IF_UNION)]
>      impl Default for TestIfEnum {
>          #[inline]
>          fn default() -> TestIfEnum {
>              Self::FOO
>          }
>      }
> 
> This specifies the enum type's default value.  Hmm...  Modified input:
> 
>      { 'enum': 'TestIfEnum',
>        'data': [ { 'name' : 'bar', 'if': 'TEST_IF_ENUM_MEMBER' }, 'foo' ],
>        'if': 'TEST_IF_UNION' }
> 
> Output:
> 
>      #[cfg(TEST_IF_UNION)]
>      #[derive(Copy, Clone, Debug, PartialEq)]
>      #[repr(u32)]
>      #[derive(common::TryInto)]
>      pub enum TestIfEnum {
>          #[cfg(TEST_IF_ENUM_MEMBER)]
>          BAR,
> 
>          FOO,
>      }
> 
>      #[cfg(TEST_IF_UNION)]
>      impl Default for TestIfEnum {
>          #[inline]
>          fn default() -> TestIfEnum {
>              Self::BAR
>          }
>      }
> 
> If TEST_IF_ENUM_MEMBER is off, member BAR does not exist.  default()
> uses it anyway.  Bug?

Nice catch.  I can make it produce the first element (as in C) with a 
tiny bit of cheating

     unsafe { ::std::mem::transmute_copy(&0u32) }

or some reliance on the optimizer

     0.try_into().unwrap()


However, I'm inclined to handle this generically.  For example, an enum 
where the first element is configuration dependent could be usable only 
if optional.  And then the Rust code can skip the "impl Default".  Let 
me check how often it would trigger.

Paolo


