Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE592C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 09:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM1k7-0005p1-G3; Mon, 02 Jun 2025 05:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uM1jx-0005oA-6W
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uM1ju-0001NC-KI
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748857550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sOABQMiaSUNvVZN7w4weKj3AXpGQsNA33epBnUhjM44=;
 b=Us2pIj428XjpZeXbm7pbeVZbGU8eeBKwDbS4ZAxLE7obSku1r9lNeCvEb5aAkBPUJu6YzD
 MQvHE6qvuWN8ZMN9GCnLP7KqDqi5z5ZUIFzZdSRfLQum97oh4Ker9H7Y6F5OIbbji323zb
 /JKLDmehOuwkUCoab3LWMfR93tIgJOk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-V3msFcnYNyaqhNjs5oJGwA-1; Mon, 02 Jun 2025 05:45:49 -0400
X-MC-Unique: V3msFcnYNyaqhNjs5oJGwA-1
X-Mimecast-MFC-AGG-ID: V3msFcnYNyaqhNjs5oJGwA_1748857548
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1847so987861f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 02:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748857548; x=1749462348;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sOABQMiaSUNvVZN7w4weKj3AXpGQsNA33epBnUhjM44=;
 b=rLmV0KA5VVzTcrpivmVeiHPYbm80UghZzyU6y1YSzF/OOqxzj3yKu3SYQopJW7HxQS
 giuNtgg9Y+Yf/I+VBAVa8hA1XPGWOzQWMwcQ/CB9d++RNQ2tpVAwHD7ZaN1t8zkQyVGJ
 Y4TpzCTNe+aBxGta80pUzJAbvXWwoNBiPhYFFxh4sAcKnQWKligqPfuI1F9Dcq4caKR4
 zSkQ1utq38XFUjYyzsugER1nYWEypuFRKASTmUplviYcU+RDQCqDuEGyC7brdpmgSDqg
 L7wjqrwRwNKj+rphm0tCQfqfZY1sVpEBP0pmipr1ICeKlDhEvVnuULVqOs0PzN0mQts/
 x90g==
X-Gm-Message-State: AOJu0YwW/IJFWTxgHZIdxN85JhWZIvT0cYYpKl7gki899JSU8y1adzja
 VggMgXZQaoaW4jyn1fYHqoGM5BGW9wYkMyS3nK+91hq7jLS6YK5LgS1p4+RAPFvU4tmQIY8/kPz
 4ccgbcu4IyC0sFoWjRinvmbEs9udx9N/OGiPXfSeU1xVAe4zzGuViD1/B
X-Gm-Gg: ASbGncsMNRHkQEIwRNmWQtx0lZUSzvwvBHrvpfNNr9FGDejy7dP9n4b3UzSiDxRoFbX
 gv7gudCggK8l+LpOeo910tP5hDH4uhn0dSmqEYyLVKP+p28G0rksm42/de1Nii+brBK1fuVDa+X
 JWRN8M/XdPIfo0E9wbSrIiUg81c44JKaHkJEEev85Bnwr5MuzWG3bCxqSZcG8sPTJ0B5MthKOvn
 qR0I+cOro/Uy0KokHYRiabQ5fZ+7UkA1kvuFV5Jh2sRyJdS14LYTvdBV+pToiLfMRmWeW3a6Ltg
 OSM7DMmNeQDBR04=
X-Received: by 2002:a05:6000:18ab:b0:3a4:ea40:4d3f with SMTP id
 ffacd0b85a97d-3a4f7aafa70mr11404095f8f.53.1748857547789; 
 Mon, 02 Jun 2025 02:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7EjSpIatYNI20kC+RsKecY91KFhewaeyHwOu4qZ3VjxTlz35QAyv3tJvdf3iH9xd/8TPb4Q==
X-Received: by 2002:a05:6000:18ab:b0:3a4:ea40:4d3f with SMTP id
 ffacd0b85a97d-3a4f7aafa70mr11404080f8f.53.1748857547453; 
 Mon, 02 Jun 2025 02:45:47 -0700 (PDT)
Received: from [192.168.76.123] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7e41sm113982595e9.26.2025.06.02.02.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 02:45:46 -0700 (PDT)
Message-ID: <8844c934-1790-49fb-8e55-d3461b32e8f3@redhat.com>
Date: Mon, 2 Jun 2025 11:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] rust: bindings for Error
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <87y0uamvm6.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87y0uamvm6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/2/25 09:49, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> As explained for v1, the impetus for this series is to remove BqlCell<>
>> from HPETState::num_timers.  However, it's also an important step for QAPI:
>> error propagation is pretty central for example to QMP, and the series
>> is also a first example of two-way conversion between C and native-Rust
>> structs (i.e. not using bindgen-generated structs or their opaque wrappers).
>>
>> As an aside, support for NUL-terminated file is now scheduled for
>> inclusion in Rust as "panic::Location::file_with_nul()", but it will be
>> quite a while before QEMU can use it.  For more information, see
>> https://github.com/rust-lang/rust/issues/141727.
> 
> Doen't apply for me on current master (3e82ddaa8db).  What's your base?

I have a few more patches queued before this series.  For something that 
applies directly on top of master, you can check branch rust-next at 
https://gitlab.com/bonzini/qemu.

You'll also need Meson 1.8.1, which you can install via pip, because 
Daniel preferred not to have such a new version required for everyone.

Paolo


