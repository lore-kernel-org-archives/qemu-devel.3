Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34996C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 15:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tazDZ-0003Rn-O8; Thu, 23 Jan 2025 10:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tazDR-0003Ls-CB
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 10:33:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tazDH-0002Mv-Sv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 10:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737646425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3+cyrcuOIwl+NyJWj6oDQo1ooJ1FM5G4u6uSe0Fo3A8=;
 b=jK0/sLLtVajxBcpXEyCk0YLiK9WaWkRaTGwSr61yGuemIWntSPu30K3nfoWuBlCEzraf6/
 GJFGXHuNDNfIO7mVpTaIV+uDfosxl3mVPbsupLZebQIFb5jO18B4FUOhWBP4qmUYdxq57R
 84j6PIBhT3lYb+SomFXpDCuhRKB3gVc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-d6XKVTAKN2Cr-PDIXQjJ6w-1; Thu, 23 Jan 2025 10:33:43 -0500
X-MC-Unique: d6XKVTAKN2Cr-PDIXQjJ6w-1
X-Mimecast-MFC-AGG-ID: d6XKVTAKN2Cr-PDIXQjJ6w
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361eb83f46so8541585e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 07:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737646422; x=1738251222;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+cyrcuOIwl+NyJWj6oDQo1ooJ1FM5G4u6uSe0Fo3A8=;
 b=hxeebaRy+rbjgyPrQRaooKmuWPoTC5xZ+ylhdAmy6Xl/8jDuDzGciu6tO20E6mpWG+
 i/dfkyPk0Ch3tYbv0/glRCJSwrhS/K9eiYgA95CUDNzfDeW5y8RW3zOdvSyeVLa1f7Zr
 aj2CLboVehANi48uUkAOFLupehmPgNbaHe5hbxlTzh8pVSmh8TTD+ERlNhczNvZPIwzP
 PVL2O1EgohPOcyvbrgxNBmJipFCDCWxBUZYPqNkLK/XYi/ZJTtBdnBe68C0iZJwsHj64
 DuTSbBShWl6+mkAerTi4Yt5nwTPuQsQO6fEsQS1eGCnI8l/oZHs4w/Bi+y7DSmUhzzjO
 23lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUsKYECLkLmDQCtAdYjlerFtOhjqWcrs3MmyR3p9s8dNbMBzixBh7Ur1LriE/UzlxRZE3Dj17c/8Qd@nongnu.org
X-Gm-Message-State: AOJu0YzgIAHGhp7SU4jPamiQM8byc51BRInf2G6ygT5ZvVCZL9nX64eb
 XhVAChBHnqUS8aAIliB04QPZ73+SVEgIkV+J/Hyym62IpybeNLd+lAlwl9cHsf4bq4K9VUXI7WI
 DEKGfRjmdKwUK2YSfjBpgK96oa3PGg/E0roGtDTcjREsulDOLCJMG
X-Gm-Gg: ASbGncs07sBwg7nPYncnhBW3JsYBG5zneJRR7IsinztgNXvs1F9Hjh5oKEq4yOpujj9
 lzepVjTn0I67M7P6JVAZOV7cFmXae9vZJz08lpPkfWkHcqUB4hAiWf/oFU4fPVOgqRGf871tCjb
 2HO+bXWVfcMnd7YhLtE4IKqeerVqD8kq4oiaXOYgOoGebGWnK1AIh2YBJ22JFkLL3/pYyNIpGBf
 xq5N12GBSjshwbn7u7shrn87ShdnMaEt5nsJX6WVdgvAGk02nWQFPSXW3kepNgZ0WENatehqA==
X-Received: by 2002:a05:600c:3149:b0:434:e9ee:c2d with SMTP id
 5b1f17b1804b1-4389144eee4mr215208135e9.26.1737646422467; 
 Thu, 23 Jan 2025 07:33:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3jYWFYyjcyo/8YRYcqQFvsC5xwopDikQgSgwFD5L1YusdbZTHF4r8sBiLeLxz07zTK0THZQ==
X-Received: by 2002:a05:600c:3149:b0:434:e9ee:c2d with SMTP id
 5b1f17b1804b1-4389144eee4mr215207915e9.26.1737646422068; 
 Thu, 23 Jan 2025 07:33:42 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188fd0sm3230f8f.58.2025.01.23.07.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 07:33:41 -0800 (PST)
Message-ID: <5e293daa-474c-4af2-98bf-9b995805b454@redhat.com>
Date: Thu, 23 Jan 2025 16:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
 <CABgObfZSR2s5AYEAcJfsdF0jKQGf_AVcDafKQq47qzLmBuX0RQ@mail.gmail.com>
 <CAFEAcA_dVnpN2Vn+VAf1XZSAdj183wJhQZ3pVNtb=NHeMOF2Jg@mail.gmail.com>
 <CABgObfaAdDtrLF4tWL17Lmw9UKiLRNVvuiDZsQxc-9Wd8W61Dw@mail.gmail.com>
 <Z45/MNYY5jD5fNET@intel.com>
 <e2920049-01c8-4ea2-8f52-b99ed0a559af@redhat.com>
 <Z5Jb7k3LLcYY5ZG6@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z5Jb7k3LLcYY5ZG6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/23/25 16:10, Zhao Liu wrote:
>> Another solution would be to implement Zeroable for __BindgenBitfieldUnit in
>> bindings.rs, but this is much nicer!  It works even with old Rust versions
>> and, even though it needs manual implementation of the trait each type, it
>> doesn't require enumerating the fields one by one.  So it's better than the
>> current version of Zeroable and, if you wish, you can also replace existing
>> implementations of Zeroable with const_zero.
> 
> I'm working on this, and it's just a simple patch.
> 
> But I'm not sure why Zeroable needs a Default constraint. I think Sized
> seems to be enough, doesn't it?

It's not needed but I think it makes sense semantically:

1) the idea was that Default::default() would always return the same 
value as Zeroable::ZERO, apart possibly from padding.  That is, for 
something that's Zeroable it should always make sense to use an all-zero 
value for Default::default().  And since there are standard library 
methods that use Default, the bound makes it possible to use them and 
know that they fill-with-zeroes.

2) I wasn't sure in which cases bindgen doesn't generate Default, if 
any; and with Default as a supertrait we'd have to double-check the 
first occurrence of a non-Default but zeroable struct.

Paolo


