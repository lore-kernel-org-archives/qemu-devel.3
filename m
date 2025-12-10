Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C79D3C928
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 17:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTNqz-0005v3-VC; Wed, 10 Dec 2025 12:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTNqt-0005uG-Bf
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:19:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTNqs-0007sv-1x
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765387185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n/bi4hXd77xtlzpxZSweyBsCJ2kB442lBr797cluk9U=;
 b=bWHezueAx9vqO9JnJoLtHuN+79L0weQPYcNo63wwcT/D6mrrXUOvyJ/y+d9jUp5GOCKY/h
 0GAYk1HdBYMAzlc0GSCV8qKMkkeJdHut3rebqMi6chE+5GmQBoA2HZCO9UQ6CnweXYCiae
 0ORlatxwFUgcGQy8htxmkgQODmnhuCA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-q4-BpWq7PTuzGBDibIeVLA-1; Wed, 10 Dec 2025 12:19:40 -0500
X-MC-Unique: q4-BpWq7PTuzGBDibIeVLA-1
X-Mimecast-MFC-AGG-ID: q4-BpWq7PTuzGBDibIeVLA_1765387179
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42e1e1ca008so623366f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 09:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765387179; x=1765991979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=n/bi4hXd77xtlzpxZSweyBsCJ2kB442lBr797cluk9U=;
 b=GOSiBApumh+zgYWA10sC/5M6tbAK3h9otnL4JWaMYND4fQFOxZrQAfSAfrnVV5iKO0
 hXOzJaa8Wd92R6tLm3MWfTn23xkBsUCxfw4Qw2LalADKmphItAc8oza6Z+Qk69U8/kku
 yJ/8T8MgGabHBZy+Q0L12bOxX98wlyqC10iw1LT3bm+8Y/dORlYhb9TA6Mrs2n2dpaFn
 Zsr6FSGnnd01SbX/WLtLtuszu63mQ5/jB3RaRwlB0EFqUmf0z7nd+S74rwaEqClJvJxF
 t6q0W9PUipnk1ilUgfWRue5QdoxYvdl7ES0dbMJHG8DXXKCnz2NLIyxWJNZuztnLqMBW
 mBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765387179; x=1765991979;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/bi4hXd77xtlzpxZSweyBsCJ2kB442lBr797cluk9U=;
 b=A6sT0CbKFfgBZg9cclZdhvbywQHlML9Vn7st5yCEFtOa+/ytUXPrQuM0x1mIRuUkCD
 Spm6OpDYEJM/9NnA6F5v2A4GQIqyxCNdbcnpdwRB0kb7P+qKHgyQZnn5mWGYirCRqERf
 UVdT0beuW32vlVvin9tMEbnTR0Kni0i6Gbgp2cAYxnK1v/W/5u3F+UpSJE/yopadebgU
 iTE9MD0IOfEwXqMcvhkHior92bjHLOH8Axy7niXu9Xe5fl3C5xJ+pnLVvregBf/AOqjB
 /iBbBWnaOY7Dk9jnuL4JRxNeufxyWXVfl87x6SMzcVouhmndZKi5Zbwspa2wfamNMhnt
 6rkQ==
X-Gm-Message-State: AOJu0YwqMIwoxLnBkzPKRQXC+jBKlbRYipLGQyo3zY0qVpNC9Uic3x1L
 ImYXqVmTwnDiYFNeS9ytycGf1bv2Q3cDvO+TYmxwK8uJsNHkzdc5RUH0qdww81Pet+TAepedAZM
 1Jf898y8rKoJx9F1wpvqjJ1efWrOJEbm2AZjMFqbX5B1oyqb0/n8T0kCt
X-Gm-Gg: AY/fxX7Y2Mo6FgAwypAxTFi4saIDGwz6KG9bZib+JpQW0JTzN5EV6NipiadzU6Ra7MT
 cPn86++J8pg9t6AkE4Sh1wS3J7BA+AYJqbocHCqu2giZpi8lbeEatqVJpOcbP8iE7LLO4MwkX1q
 YRKR0Gr1a+PLsGowNaMeFQnguJ+iYW0ZPV1npIDHjiE4ZFMfeE/GZfHpj4MAEHVNP8MQb4KMjOH
 uO+dsNS3fvC6e96BrXAxG4lVE11Moo0l6E8YP79D2zH05KNUX/5cbmI7EtuQrSJMcjBeNmHT8wD
 bjt9JUurdOwMrIgq1IYAUIJmCDi2YVgX0FN04gW7/t2w7A/vj8TcPi6Db+gMtZSZLcP12jb1s+m
 aLL+0xjx5rIn79O/Flijvmw8a+BTSjo6TClv4O55wUf4RxLW6S1+pDGH04sUTl7kzcPOB1m6QWP
 BSBIlY1OXTKdh6zOc=
X-Received: by 2002:a05:6000:186b:b0:42b:3455:e4a1 with SMTP id
 ffacd0b85a97d-42fa89ec4a8mr215120f8f.15.1765387179266; 
 Wed, 10 Dec 2025 09:19:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkAKahCwN0k6df8RMeBvgFidiJdlAa8mo4FMWukQK0sxXiNj84d4mzykYjbpQ4dzBiOu0BZg==
X-Received: by 2002:a05:6000:186b:b0:42b:3455:e4a1 with SMTP id
 ffacd0b85a97d-42fa89ec4a8mr215086f8f.15.1765387178806; 
 Wed, 10 Dec 2025 09:19:38 -0800 (PST)
Received: from [192.168.10.81] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a70394sm146572f8f.14.2025.12.10.09.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 09:19:38 -0800 (PST)
Message-ID: <239ea6cb-de87-48b7-8ef0-71158bf5ae70@redhat.com>
Date: Wed, 10 Dec 2025 18:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] rust/qobject: add Serialize implementation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-7-pbonzini@redhat.com> <87a4zx5kgm.fsf@pond.sub.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87a4zx5kgm.fsf@pond.sub.org>
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

On 12/5/25 10:47, Markus Armbruster wrote:
>> +        match_qobject! { (self) =>
>> +            () => serializer.serialize_unit(),
>> +            bool(b) => serializer.serialize_bool(b),
>> +            i64(i) => serializer.serialize_i64(i),
>> +            u64(u) => serializer.serialize_u64(u),
>> +            f64(f) => serializer.serialize_f64(f),
>> +            CStr(cstr) => cstr.to_str().map_or_else(
>> +                |_| Err(ser::Error::custom("invalid UTF-8 in QString")),
> 
> Could this be a programming error?  Like flawed input validation?

Possibly, but given that you have to create a custom error type anyway, 
I'd rather not special case this into the only abort (see the 
"#![deny(clippy::unwrap_used)]" in patch 4).

Paolo


