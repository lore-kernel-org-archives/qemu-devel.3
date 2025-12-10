Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD7ED3C526
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLLf-0005Mj-89; Wed, 10 Dec 2025 09:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTLLJ-0005Ha-T9
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:39:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTLLH-0001RK-DN
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765377538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hrE41cTYSlP7BLdB5AcGAZxkSuBX+V7/2OvidQylAPc=;
 b=OhbGGxYHWaO//vCrzd4oGCQBIHFk9DLb34i12KM8nLHNjxf3G+DW0x2qmgXg9g+6fwOtfY
 aTb+1FnQQE8t2Qf2sgJ5GbG+kIjS2Apr3cSpuhFkXhvhet018ovuWEiNY5Ttnay6Wh+uVU
 yOwA7QvM+miPSejahSJdMtvLl4yJhvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-GEaIETjbPBq22bEXU8-Z5Q-1; Wed, 10 Dec 2025 09:38:55 -0500
X-MC-Unique: GEaIETjbPBq22bEXU8-Z5Q-1
X-Mimecast-MFC-AGG-ID: GEaIETjbPBq22bEXU8-Z5Q_1765377534
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so55740025e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765377534; x=1765982334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hrE41cTYSlP7BLdB5AcGAZxkSuBX+V7/2OvidQylAPc=;
 b=mOX7G2MEoxLxIKswOqfLByTqAXi0T/I3zWvKrsbwFytY7Rvab02Z4PgH447woqphWL
 ZVFvJAK4zoEi8q54v282AsvdWOW6m2QEZaGJT69ZkFE/7F24/4mWhAJIvVnDtDxquI5+
 rwuuen7yWq5icOGoaVSmbvHhNA0E+61hxfyZvprXV338sZDnMtghov7v7g5yBIdgVLlO
 c5E4wZVJgsadUmSuePpspAO0SjoRvdutbvUz9ev1XTrCz+Lt3pKNTSclQvTaoRZFB86o
 Unn3O0e+CGvBJTKfdJe68V8MRWScaA+GpuV2uSez8HV5en4B0TRNSjDoJGaTyiEtFW8Q
 tAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765377534; x=1765982334;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrE41cTYSlP7BLdB5AcGAZxkSuBX+V7/2OvidQylAPc=;
 b=NCMcBojlf+cDx8qk9WCiWqg2Qp/R45Og+CBLrYsaFVj97GiM5kT7p4zUilfUbRDiNr
 GAepT3As0/Sw0trRjVwaI6QSqSUEYpDme5GsIJ7ahArApLs/9kPo6ozaQoJ+UV5yD/0V
 pfcyAtwwGQUVbiQv/Icz+YDgPaWEWs1yYhROldrr1LAvzVITdWfB21+JIsug0g+jhmQX
 f3QV45OA1ANklhoV+URGAzBOZ+TL4zj65ova2XL7BSuwxXDHdeggTDvrsFd671ADgmBr
 7cBrKDbXVIXyJSoLyCoo+LXJx67JfLk29sKudmmgy6DQqyXmcWn8Zm7HAaj+/YlDxLKF
 rIag==
X-Gm-Message-State: AOJu0YweKAZX299NCZKpGJ1ia32tAajqsaeIFJ4ceNHLwO/ztnN94bvp
 2kaKKwXaFKyC1CoK3xIGFzuacPL7d03pYNRSxC73XlQkeG+Ppvn45GEn9YCirMQ14gWv0XkcrSJ
 h6l/tSC9uv8iYc004ulFMAhCdows9J2u4D0Sqsqhejw0vT420jkKZYsOL
X-Gm-Gg: ASbGncteG5l2XrIXuEKDWwG16U2gcTym3iAuMFO7bBSi4nMkIrzJyng9i4MVfWIYk48
 ViuX2ysd62w3knsO0QTC4y6tcOVMw1E2ugByt5C6FmzmT58BEZoIiZJ/jrnastE6slk8xraY5pI
 UOifEiTkpwhhOKPRtZTQ1VJE5i4LWJgrFDDLq2QnWXNlBw7R2FAGCAuFlTHi2H5LO3Zi7Z8to4C
 3y+zIET6jX2hEgXUDmewmWJrv6tiTVigoQHC7ZHaBYPmfrB3Nt3bCOe4oTKoPFCP8CVeHbAdysX
 l5DLcQjy02tHIpJO8Owgb6s51HEBFublbod0oCEpqE/Eja08q+5ADLd90721IS27TwL4ZtseVvW
 LBiriDIU151UWk55nA5Q/yZ3bosTUNPsvjjOGYn8nFh0CVkgy7iUjUcpXzq4WLveqbxLX15DcU/
 AoqE+O3Av4bbSDvRQ=
X-Received: by 2002:a05:600c:1389:b0:477:54cd:2030 with SMTP id
 5b1f17b1804b1-47a8384375fmr25741545e9.21.1765377534105; 
 Wed, 10 Dec 2025 06:38:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnNtaOMoLqEXR//7xOSV++X5EpFOwMTyvW/RyKa06/YowGXC/fo/t4yh9bXjemf4oTDWV4aA==
X-Received: by 2002:a05:600c:1389:b0:477:54cd:2030 with SMTP id
 5b1f17b1804b1-47a8384375fmr25741355e9.21.1765377533640; 
 Wed, 10 Dec 2025 06:38:53 -0800 (PST)
Received: from [192.168.10.81] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47a82d72f68sm51635535e9.3.2025.12.10.06.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 06:38:53 -0800 (PST)
Message-ID: <f8b03a16-d957-4968-a7c8-38fec0b01a88@redhat.com>
Date: Wed, 10 Dec 2025 15:38:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] scripts/qapi: generate high-level Rust bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-15-pbonzini@redhat.com> <87v7ig3rc2.fsf@pond.sub.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87v7ig3rc2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/9/25 11:03, Markus Armbruster wrote:
> * Why is util::qobject::QObject needed?
> 
> * NONE is an error value, not a valid QType.  Having such error values
>    in enums isn't unusual in C.  What about idiomatic Rust?  Even if it's
>    unusual there, we may elect to do it anyway, just to keep generated
>    Rust closer to C.  But it should be a conscious decision, not a blind
>    port from C to Rust.

For QType we don't need to keep it closer, but actually ABI-compatible: 
QType is defined by QAPI but is used (almost exclusively) by QObject. 
We use the C version in the QObject bindings, for example:

                 $($crate::bindings::QTYPE_QNULL => break $unit,)?

> * "Default for QType" is NONE.  In C, it's zero bytes, which boils down
>    to QTYPE_NONE.
> 
> * QTYPE__MAX is a bit of a headache in C.  It's not a valid enum value.
>    We make it one only because we need to know the largest valid enum
>    value, e.g. to size arrays, and the easiest way to get that value is
>    adding an invalid one to the enum.  Same for all the other generated
>    enums.  Could we avoid it in Rust?

Yes, I think so.

> * C has a file comment of the form
> 
>      /*
>       * One-line description of the file's purpose
>       *
>       * Copyright lines
>       *
>       * License blurb
>       */
> 
>    I think Rust could use such a comment, too.

Ok.

> * C has built-in types like QType in qapi-builtin-types.h, generated
>    only with -b.  This is a somewhat crude way to let code generated for
>    multiple schemas coexist: pass -b for exactly one of them.  If we
>    generated code for built-in types unconditionally into qapi-types.h,
>    the C compiler would choke on duplicate definitions.  Why is this not
>    a problem with Rust?

Because there's better namespacing, so it's okay to define the builtin 
types in more than one place.  However, do we need at all the builtin 
types in Rust?  QType is only defined in QAPI to have the nice enum 
lookup tables, and we can get it via FFI bindings.  Lists, as you say 
below, are not needed, and they are also a part of qapi-builtin-types.h.

So I think Rust does not need built-in types at all, which I think 
solves all your problems here (other than _MAX which can be removed).

> 
> * The Rust version doesn't have deallocation boilerplate.  Deallocation
>    just works there, I guess.
> 
> * The Rust version doesn't have the List type.  Lists just work there, I
>    guess.

Yep.

> * The Rust version doesn't have the implicit type q_obj_my_command_arg,
>    which is the arguments of my-command as a struct type.  C needs it for
>    marshaling / unmarshaling with visitors.  Rust doesn't, because we use
>    serde.  Correct?

Commands are not supported at all yet.

Paolo


