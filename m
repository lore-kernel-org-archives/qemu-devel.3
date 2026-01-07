Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C30CF6C16
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 09:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPUj-0008D1-J7; Wed, 07 Jan 2026 04:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPUh-0008C1-NQ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPUf-0004gu-3S
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767776774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GOQkrxydfwh6HVpCiIIXvwbdKqIFn3GT7DwwoG2JOBI=;
 b=e/A4c1zrBewjuYDP5qjfuohHBf+oHNAsUprVRKBHxIhiszi0Sk8vOPIHQtWJ0ItrwJej5K
 9Dlch5kayNEdp9YNG5SkMDRXIXBSmWQSoc6hKVehlM3UF15+XuFKLxEPeibW4YLIpPQ9mI
 V2OchbhcxyWwTW03LiVibmrIlxNEI6Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-hSPguE97N1Wtn601Ug3AVA-1; Wed, 07 Jan 2026 04:06:13 -0500
X-MC-Unique: hSPguE97N1Wtn601Ug3AVA-1
X-Mimecast-MFC-AGG-ID: hSPguE97N1Wtn601Ug3AVA_1767776772
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fb8d41acso1061641f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 01:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767776772; x=1768381572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GOQkrxydfwh6HVpCiIIXvwbdKqIFn3GT7DwwoG2JOBI=;
 b=fSZZInYImAtlqwCLjabcNqdIfjLDj21+eC9h+n6WpMaYv2blJn17DLyFhbQ673nJgC
 M/h2dxYrPl38Gem/I4kIplhl543pWvr/dDtsR1cDzwIzIbRJRITarzorc3+yGGqHcUAS
 N45SfA1Py9EmIlCvcJOodN2GHHrrDSETG84m+AQvtVYrhLipiCfKuyNFEmFO47bCvOUo
 rRrKOgIChuunAIL8jrz0T5CremYqgS1rh3diOWKmGehMtN5AtdXS5Mx+yP9uGxRVrG7a
 Fd3h6/+CJkU6kMRyeAKWGry0mPp1HqFT+4omP/vzSzicyFt/4B3FEAsC/ybW2vcB22SV
 U/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767776772; x=1768381572;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOQkrxydfwh6HVpCiIIXvwbdKqIFn3GT7DwwoG2JOBI=;
 b=BtVxzskG/Z9wHEpWhkVYoqo1KXawUd3HL6C8McpIeYCJpbgmmsuVrtH0rAWEyqt8ZW
 zyuKYrvFVoac7rsQcd849SRcNoKjy95chz27i2YvLQKjm4i9I/HqSAWpgINe3lwIwPnG
 ppabRybLepAU8/bhNtdoVAfm47SX7th2YYJ11H9+71wKgXnHP5JWEeb6FNyjDrz8yZZg
 WKhHUKRcM2PjLMUy8bvfFECzWwhsimmJk1cN3iylEbJgW6v4pZCZ7Vd8TAZUxdx8VzLH
 M366R9g5mKhhvxKtSgGA95UIakmoxqmIr70KKwnfDbMcs/JuRoV1YT+9QjWLpndjAiGb
 ws9A==
X-Gm-Message-State: AOJu0YzN5s15zMxINwwPE0LM926+Y82nMimnwqEICQgx4TFwP+Mi/5uK
 Jy0cPWUq89fgIPOeZxq9h4txp8AKwK3amJRbjJWPNF38yxgszfw2rfB0JDItcPRcAa49OoVEpAY
 iKSZAzyWZrCtoOwQc38W6x7sJfTal4HSCmayJdmW7wDpxpGjJ3b2UMrU2
X-Gm-Gg: AY/fxX6eqJ6AqJ6X93sK0f0NRY+fiKrjvVE560eBzWuPkXzFsgYDaO4I8Ri6MmeHR6H
 w5BrcSEtQQ4ACni1MwKy17Q8UKic0hoUAbNnzhSsnNJ/9qiq8SnNYVjW+Hyavs2+I+8lomtlx0k
 y5G9hrVHKw9o0mEjkbxwX4ZjeUuUJsWyB8LgAJDcuaN4lP0fTSlQQBOefWm2pk8WMrjNXvfNZTz
 jYS0FrbqRULe38tm6K9N9wWaE+ebV+bkdM/2rzUHs3rrkgBxTJbWi4YPdyoDKQPL5SFnlNhm5Qr
 kwbcd78gVj5weRJ1l/8rUNIGYhK4rCDLOe+9lvHPidDxwjiWFf3uAC5Gz8QJlb0tkmYb8BF1ln0
 WBqWPw1jHJdEWdqge7n32gpWVNQy6PCjWyWjv8hx/5gz5OfnUCgCOytd57+I5cr7yDBlPQ38Qh7
 ecQiVzB9QVFCEtoA==
X-Received: by 2002:a5d:64c6:0:b0:42f:b581:c69d with SMTP id
 ffacd0b85a97d-432c3628323mr1896857f8f.3.1767776771952; 
 Wed, 07 Jan 2026 01:06:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQXCy23HSoZVD+cMJb9OGHDzQLF1QkNGV0ILf6Cm9GeXqvKciTeTBMG3xoBtiA3ZLyS1vCpw==
X-Received: by 2002:a5d:64c6:0:b0:42f:b581:c69d with SMTP id
 ffacd0b85a97d-432c3628323mr1896815f8f.3.1767776771445; 
 Wed, 07 Jan 2026 01:06:11 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df939sm8995127f8f.21.2026.01.07.01.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 01:06:10 -0800 (PST)
Message-ID: <b91482ce-69fb-41a4-8e74-2ffd0e6aae6e@redhat.com>
Date: Wed, 7 Jan 2026 10:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] scripts/qapi: generate high-level Rust bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-15-pbonzini@redhat.com> <87wm2lkze4.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87wm2lkze4.fsf@pond.sub.org>
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

On 12/17/25 14:32, Markus Armbruster wrote:
> This is like common.c_name().  Differences:
> 
> 1. Funny input characters
> 
>     c_name() returns a valid C identifier for any non-empty input.
> 
>     rs_name() requires its argument to contain only characters valid in
>     Rust identifiers plus '.' and '-'.
> 
>     I think we better avoid this difference.

Done.

> 3. Input starting with a digit
> 
>     c_name() treats them just like protected identifiers, i.e. prefix
>     with 'q_' when @protect.
> 
>     rs_name() prefixes with '_'.  Is this a good idea?  Hmm...  "The Rust
>     Reference:
> 
>         Note
> 
>         Identifiers starting with an underscore are typically used to
>         indicate an identifier that is intentionally unused, and will
>         silence the unused warning in rustc.
> 
>         https://doc.rust-lang.org/reference/identifiers.html

In this case it doesn't really matter: public items (such as QAPI enum 
entries, or struct fields) do not raise the unused warning anyway.

>     rs_name() prefixes always, not just when @protect.  Is this a good
>     idea?  Remember, @protect is typically false when the output is used
>     as part of an identifier.  Or do we use it differently for Rust?

Removed @protect, as it was unused for Rust.  Makes sense, because Rust 
uses Enum::Ident instead of ENUM_IDENT.

> 4. Name clash avoidance
> 
>     c_name() treats names that are prone to clash as protected,
>     i.e. prefix 'q_' unless @protect.
> 
>     rs_name() prefixes 'Qapi' instead.  Why?

Because Rust tools are a bit more fussy about the shape of the 
identifiers; in particular they want types and enum names to start with 
an uppercase letter and use camel case.  Using 'q_' as the prefix makes 
them complain.

Fortunately this is limited to String, which has very limited uses...  I 
don't remember why String exists, probably strList wasn't a thing yet?

>> +
>> +
>> +def rs_type(c_type: str,
>> +            qapi_ns: str = 'qapi::',
>> +            optional: bool = False,
>> +            box: bool = False) -> str:
>> +    (is_pointer, _, is_list, c_type) = rs_ctype_parse(c_type)
>> +    to_rs = {
>> +        'QNull': '()',
>> +        'QObject': 'QObject',
>> +        'any': 'QObject',
>> +        'bool': 'bool',
>> +        'char': 'i8',
>> +        'double': 'f64',
>> +        'int': 'i64',
>> +        'int16': 'i16',
>> +        'int16_t': 'i16',
>> +        'int32': 'i32',
>> +        'int32_t': 'i32',
>> +        'int64': 'i64',
>> +        'int64_t': 'i64',
>> +        'int8': 'i8',
>> +        'int8_t': 'i8',
>> +        'number': 'f64',
>> +        'size': 'u64',
>> +        'str': 'String',
>> +        'uint16': 'u16',
>> +        'uint16_t': 'u16',
>> +        'uint32': 'u32',
>> +        'uint32_t': 'u32',
>> +        'uint64': 'u64',
>> +        'uint64_t': 'u64',
>> +        'uint8': 'u8',
>> +        'uint8_t': 'u8',
>> +        'String': 'QapiString',
>> +    }
> 
> The argument name @c_type suggests it is a C type, but this map contains
> a mix of C types, QAPI built-in types, and even a user-defined QAPI type
> (String).  How come?
> 
> Why do we even have to map from C type to Rust type?  Why can't we map
> from QAPI type to Rust type, like we map from QAPI type to C type?

I'll look into it.

All other comments addressed, thanks for the review!

Paolo


