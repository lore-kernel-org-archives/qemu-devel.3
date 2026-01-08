Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5FBCF6A88
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdm1H-0005T8-16; Thu, 08 Jan 2026 04:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdm1F-0005ST-N2
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:09:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdm1E-000246-1p
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767863362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eCFff5jpDe3EVXz+NUzoy2gDQaJ1pHSS1taRjjW9K+Q=;
 b=MKtQlQd4xia/StFo5tK7hvxSbHXwim4Ep2004iZIOODgaJ2BtYRblQjructl5ZJFLYAmLj
 DZwszGZMB0Jo4HwaPA3Hystvn0cbYcQ64i9HpqLGRQI1ftqn47B5Wr4s9gSYC70TrmwDiO
 QR35S05u0YQr70B7FxxRzFBFFRtrsi4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-0BhnmTqwOnqcEmfZoCs9sg-1; Thu, 08 Jan 2026 04:09:21 -0500
X-MC-Unique: 0BhnmTqwOnqcEmfZoCs9sg-1
X-Mimecast-MFC-AGG-ID: 0BhnmTqwOnqcEmfZoCs9sg_1767863360
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so20579435e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767863360; x=1768468160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eCFff5jpDe3EVXz+NUzoy2gDQaJ1pHSS1taRjjW9K+Q=;
 b=EPl+SWrmAlgVlc4ArjR/9JNtsQVNA9RwFfBGgKuGuXBQ1iS56SvyAdton5FKjfqa2W
 ytSb5dXE0VL1pEUrf0wIs1HTKEpTUqTlrWVNnnXX6HsXqilhs3WqDCbEqLeuKrCGKtJe
 zMi4SlqytdQwdy+S4q8qW1GfrXKtIhwBxTmLEZXCTnjcb95jhmayKsFLX3IPCTxZhySZ
 BDfrlXIiPYLVUei0IFTpGj3m/ROzcys9qSPyO9yEG6VjbXpBGmBggxquUV6YFEL3eNeA
 V28cZYw/S1pNYxB68ENCO2NQGP3sIBGnhWHBaCsZc07jP2TQWKeWQts4Wn6ZAUdPY1E+
 LhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767863360; x=1768468160;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCFff5jpDe3EVXz+NUzoy2gDQaJ1pHSS1taRjjW9K+Q=;
 b=BnmaBoNqW0QDJqRColCIctlTU3FMo0+LZyjf5QzpkxdX5shIYv5a6LbVe/1E0FuzIn
 ouwWYPV1c4NrmqcUW31uUmkWOJVsq60dZ9OqRCMTL16rQ2RHXvQnMxUYdCoLlV4h0M+N
 sgKIaIblyDfQErgEvy1r2zr6tDC5dXbaYXYS5iExVuc0Uu3H1K2NXpkEgiC+YYrmHxDx
 qtHodh7m+mUHe9pwdrWvJFGi/k2u7XHiR48yE7JNVMxu7OEoLCYIzSDqyKkGsUNT4yED
 +ScOkbTih4tZGUq/Q6+33GfntjRnZCT6OCsZZSd3ER6s3uRaCyN5md0uDU5KcQPtYL4g
 eY6g==
X-Gm-Message-State: AOJu0Yx9UMrVyvCJsjEz1eN8Ny6kzR+9x8jRt7AYoaCSw9qop2QVNlNS
 9Q146TeD71GdtEVKIJl9XUHa2iOJSNaXOKirkZgXnH6qy1+lJ8KbzKQNCEMXK9894Q39AEMSxKW
 2oudyKAelEXZXdKT0XkWjlXvRed7p+6dMAlYNqElLJC1ifQafAjd7i10S
X-Gm-Gg: AY/fxX6mn91sTfDEByU82UxmGD7bn/64+6qJ5EEVqBza1dNRGZWpnjc1WUpw9Mxqx71
 4sSKXBfzIIU/8H3XHcgqsfAzNjowAZUy7dVz+cSAABxEV89Azhy+hF9aj2N1iqHSrjweqJWCevO
 Xq5ZzZUiWcmRa2ufjn+tQBQd2NOcCMuezBFw8RRG3p3MXw6pHFDwuEMsGocXWCZIeg74/M0PJw7
 y8zHnl0BgNb32WhiQgQIjikFbTI28MjYQntRi2tvGMLteaTml+Cj/aKlg3/1dfDUDeux19TuwLn
 9YshWI74mSlDzdZC028BydM8CZeiby4OiiqkaRQE9pWp2lWfI+WWMqvBHg0eNscyf9xRvaU8ZiN
 hOQJ5x+ZRX8ln6kSlx+LHZA+OXcKsgZ/1ZU2pbJiGIeraX7dkIZdloGNh16DmpCum/fhoSrlncr
 JF8HgENCTfjHu5Ww==
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-47d84b3bb18mr65516765e9.22.1767863360329; 
 Thu, 08 Jan 2026 01:09:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHehBu8XqCb/Ny5Kt/+BvPF4M/btl/XP+tHbp9h25ddq8mDWtjFplE7n/LcRUuJ65oNbNU9jQ==
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-47d84b3bb18mr65516585e9.22.1767863359932; 
 Thu, 08 Jan 2026 01:09:19 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f4ddsm147162965e9.2.2026.01.08.01.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 01:09:19 -0800 (PST)
Message-ID: <9041d316-e7ee-4e60-82e2-590dc8797de4@redhat.com>
Date: Thu, 8 Jan 2026 10:09:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] scripts/qapi: generate high-level Rust bindings
From: Paolo Bonzini <pbonzini@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-15-pbonzini@redhat.com> <87wm2lkze4.fsf@pond.sub.org>
 <b91482ce-69fb-41a4-8e74-2ffd0e6aae6e@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <b91482ce-69fb-41a4-8e74-2ffd0e6aae6e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/7/26 10:06, Paolo Bonzini wrote:
>> The argument name @c_type suggests it is a C type, but this map contains
>> a mix of C types, QAPI built-in types, and even a user-defined QAPI type
>> (String).  How come?
>>
>> Why do we even have to map from C type to Rust type?  Why can't we map
>> from QAPI type to Rust type, like we map from QAPI type to C type?
> 
> I'll look into it.

Ok, the reason for this is to have a single "def rs_type()" function 
instead of multiple methods ("def rs_type(self)" and "def 
rs_boxed_type(self)" on each of the schema types).

I'll change this to use methods.

Paolo


