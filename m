Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434DFC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 12:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJX3I-0005O8-2o; Mon, 26 May 2025 08:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJX3G-0005Ns-Qz
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJX3E-000298-Ka
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748262926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V4nsKL5XYpAnQ14Q1cZNYas8WaUj40agsGA/CVUFyzs=;
 b=C6KpN9zvxGyvX7b99NivDS1we+33zDLc+5gCel2q1yLD87doRs5cHeBuvczcA3QuqDbv0z
 Ewmg1zKaR0XHsG2mrG9XNJhXg76gnepIJeIaZoJ/ZNfOJjW41yhv2hz+JN00WuYgaKVACO
 YNX01nPwX5nduy++1GU+jGcW9so7if0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-6B4fy5LtPUWdwJ03tjzoMw-1; Mon, 26 May 2025 08:35:24 -0400
X-MC-Unique: 6B4fy5LtPUWdwJ03tjzoMw-1
X-Mimecast-MFC-AGG-ID: 6B4fy5LtPUWdwJ03tjzoMw_1748262923
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442cdf07ad9so12276335e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 05:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748262923; x=1748867723;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V4nsKL5XYpAnQ14Q1cZNYas8WaUj40agsGA/CVUFyzs=;
 b=AreUgFR/WbCZ4V8z1aQOou/aFyj+27zq/vriDEYf6guEZ+zTWbVHtjHyJtPkT8f7Dj
 2+kbywO46nbG800QQz87oqz9Y+0vB9her14hfyRaDCC8VqGh1W8uWjZejHXsrT/OdXW8
 RTDbk2J6+2o+IBjal6hayfEpP/fH8z57PUe6k1+3SuWKstkagLFoznP/pv91mFkoucc/
 6bqHIfw0e7svqjbstJLGu7DzluEbTtiwz2rERmQztaoOqVXIp84A6/jkasoQIkoi6FL1
 EZVycdISmwPNp0bv7jJLtHFYVvcBaA8+z8AddDYQ68Ni6nYCX5jt4v5/4UounFb/Il5J
 yerg==
X-Gm-Message-State: AOJu0YxmDA41RxZbgxx+Otd8IZYOMLAI40DVRok2ZYmd1g5wik5KAtvw
 bCVxvIQUG1T7rvBnkRHBafao04w0pvTk6J49PBjHlhl+ZynDqMYYi803MBFyNRjXSrcVsChz6G+
 pnYxNzk/e741/r4J2ObF6s7krxEptW6ehaVIuilCc/3NaOjpnj1JRfhIY
X-Gm-Gg: ASbGnct+K4VsRyDCH3Cf3FjqgKihagcZeg27hwf11hJIuFpbLKEFMg3U9OsJJ/uL/0w
 STvQwmO12I+qP9oAiHV93S09S4UvBKDiB+NmLaQu88iWwfkW1Wzpxxc2qJ50HWoR6NqLgNodMIt
 Ylew3FwiqqsznysgnMRJPrf5sWoAW8jakK2M+kYho52LVGMxwga5TohpqRkaKnbJ9z+j9vQf3O1
 OE6VvDY0s71KqTz6G6vpXKrq+GPOOLrFU1GILl4vIkkSxxaKroyvAwTWVgYsHGCbAlUt1i2hU1N
 Mqyv5B70snrS7w==
X-Received: by 2002:a05:600c:35d3:b0:442:f4a3:b5ec with SMTP id
 5b1f17b1804b1-44c9301650cmr86681595e9.4.1748262923120; 
 Mon, 26 May 2025 05:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2bzTWdOu7ChYBi1Dq1tRhmSjyDYxWAYjJ70yynaNOQWI9kCWx4UkSZaIt0arUTRAV8BLqiQ==
X-Received: by 2002:a05:600c:35d3:b0:442:f4a3:b5ec with SMTP id
 5b1f17b1804b1-44c9301650cmr86681265e9.4.1748262922771; 
 Mon, 26 May 2025 05:35:22 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-447f6b295e7sm235168965e9.2.2025.05.26.05.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 05:35:22 -0700 (PDT)
Message-ID: <10a65a3b-f2ab-40f4-9bb0-81da46cd5ed1@redhat.com>
Date: Mon, 26 May 2025 14:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] rust: define traits and pointer wrappers to convert
 from/to C representations
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
 <20240701145853.1394967-4-pbonzini@redhat.com>
 <CAJSP0QU3iT9REzdciVZBhRWLtQXtoabJ9Jb=S9Maun1cDb+WFw@mail.gmail.com>
 <CABgObfY=Lm_868Me7xqEk2zA+UGARbeH-4ELvBJn4tYucUCXJg@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CABgObfY=Lm_868Me7xqEk2zA+UGARbeH-4ELvBJn4tYucUCXJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/27/24 22:26, Paolo Bonzini wrote:
> On Fri, Sep 27, 2024 at 9:36 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>
>> On Mon, 1 Jul 2024 at 11:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> +/// A type for which there is a canonical representation as a C datum.
>>> +pub trait CloneToForeign {
>>> +    /// The representation of `Self` as a C datum.  Typically a
>>> +    /// `struct`, though there are exceptions for example `c_char`
>>> +    /// for strings, since C strings are of `char *` type).
>>> +    type Foreign;
>>> +
>>> +    /// Free the C datum pointed to by `p`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `p` must be `NULL` or point to valid data.
>>> +    unsafe fn free_foreign(p: *mut Self::Foreign);
>>> +
>>> +    /// Convert a native Rust object to a foreign C struct, copying
>>> +    /// everything pointed to by `self` (same as `to_glib_full` in `glib-rs`)
>>> +    fn clone_to_foreign(&self) -> OwnedPointer<Self>;
>>
>> I expected the return type to be OwnedPointer<Self::Foreign>. Is this a typo?
> 
> Kevin noticed the same. I'd have to check if I am missing something
> but it seems to be just tunnel vision.

It's been a while and probably everybody has forgotten about this. 
Anyhow, the main reason why this returns for example 
OwnedPointer<String> instead of OwnedPointer<c_char>, is that it tracks 
whether the pointer can be NULL or not.  A possibly-NULL pointer will be 
OwnedPointer<Option<String>>; if the pointer is certainly non-NULL, 
instead, it will be OwnedPointer<String>.  So you can express 
nullability in functions that accept an OwnedPointer<>.

Secondarily, it makes it possible to implement 
OwnedPointer::into_native().  That is, it makes it easier to do the 
opposite conversion once you're done with the foreign representation:

     // s is a String
     foreign_ptr = s.clone_to_foreign();
     call_c_function(foreign_ptr);
     *s = foreign_ptr.into_native();

as opposed to

     foreign_ptr = s.clone_to_foreign();
     call_c_function(foreign_ptr);
     *s = String::from_foreign(foreign_ptr);

By the way, I have now extracted this library and published it on 
crates.io with the name "foreign".

Paolo


