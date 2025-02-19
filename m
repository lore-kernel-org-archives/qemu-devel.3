Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7143EC021AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 06:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkdIn-0005v7-4F; Wed, 19 Feb 2025 01:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkdIk-0005uf-PL
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 01:11:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkdIh-0004Xh-BN
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 01:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739945474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y7tYAmg7JV8KAW5CtCPIXq0bWz3a2L3aHzggSoXshUg=;
 b=JSDx1bqpep36V5M9QMiOxqhWUhkyYqqXjFvFwXqZXXLqGhe3pHxyhaipweFK++b1NvBUX8
 z3e5pNOmHEXdZg2Vkn8mVThOY6ToDp3dRMMgEO7OOPLtmNcjojvb5w7sWx3jNDkbb5kEGF
 FUF/7sYVly7zjX1LaZ/6QeKtHlLuAFQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-eNpBl6N3MHyfhiHLNqm_2w-1; Wed, 19 Feb 2025 01:11:11 -0500
X-MC-Unique: eNpBl6N3MHyfhiHLNqm_2w-1
X-Mimecast-MFC-AGG-ID: eNpBl6N3MHyfhiHLNqm_2w_1739945470
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f455a8fcaso2713882f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 22:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739945470; x=1740550270;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y7tYAmg7JV8KAW5CtCPIXq0bWz3a2L3aHzggSoXshUg=;
 b=WD4FY3URJovGvJNC0I+ojCBtuJTPNcOrURlk8es6t+fOsWtTc9OPWkJuvz/1659td3
 dk01V69eLw0KE3LZh3Y6LIMJcLtwhXi2pyD8PzoZHBIcyuFceaoc6YpUCyTSu8091DyF
 rhbxeQzD3y+zHEVwDs1vmFSLpYN8/TeRUmexi8/aXS+c265ywfj7dWOsban6/PGA/oHc
 LzIf6cTqpAkg5CWtuaE+P+G5ldjcxKr4h5Qz7RGlu/vibL5sfrzkFXGqXhlSRxAvTyaE
 cQrUJr7EAjQHNQZbVg+qIqSQltB1JyZR3i9Qvp6dlvBZTW1+FszsUDgxvSGWi1lxuDcq
 VWqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIMDBrZVzSjUXTHHE3L9CQmme7WqvF1FRe9FhNKvFhpJOU4Sh3NSkHU2ClzuEHRDrwUrqULdLX6eYS@nongnu.org
X-Gm-Message-State: AOJu0YxLyx6v2ZnUsn2NtL2GQWpY2C81IWNKClNBDArEpFVLodPFLFZx
 gewxJeF0dbGP4j8Zll5OFbW09nt+7e2OlPFfme+2XyaTB1X2j2q0+AT3+fwxGyhU3APxc4Yk4iW
 x7eG9q7/TQIgtxQBjCGgUuIzb8LM264tHYYZHFX/fJFqFg8nnmQSm
X-Gm-Gg: ASbGnctF2CHZFAleYI+kUWkBGcuRGh5EVtoB2OY7h6XSZdYmoCC/+QpjHy3v1xmHxiC
 pQIq63UfEircYqWZbWpGNzNWNTbdRXNzY+OPIytFdhSl/csCLe9qD/wnKXi7kQa7jwiIsfvTjrE
 ZLbFM1yuD0hgOvyrk92kxxjdJK14mN7k0XpvnjwKAcmoIWy2xXP2uX1RxCZ2HTDPhs0uGltsknD
 zbDg24xo9tZUjNqt+ZjzzGtY+BTWYtXZib96opdjjaQt6GFysiNM6wfyr9lZOEBKFgO8vG/TJWq
 giLCMCOEBKI=
X-Received: by 2002:adf:eecf:0:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-38f587ca919mr1492981f8f.39.1739945469903; 
 Tue, 18 Feb 2025 22:11:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXXxA+rmES696gNGsK8pcLepitZ/LMHLF2C8Y9fu5mGLZXYguwVBMUX5lW2oJ/ABTblyACzQ==
X-Received: by 2002:adf:eecf:0:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-38f587ca919mr1492961f8f.39.1739945469486; 
 Tue, 18 Feb 2025 22:11:09 -0800 (PST)
Received: from [192.168.10.81] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4399600257asm34908215e9.4.2025.02.18.22.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 22:11:08 -0800 (PST)
Message-ID: <0ee134e7-02bf-4b9b-9c9a-83c88386cd57@redhat.com>
Date: Wed, 19 Feb 2025 07:11:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] rust/block: Add read support for block drivers
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-10-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250218182019.111467-10-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/18/25 19:20, Kevin Wolf wrote:
> +    /// The described blocks are stored in a child node.
> +    Data {
> +        /// Child node in which the data is stored
> +        node: Arc<BdrvChild>,

Having Arc<> here shouldn't be necessary, since the BdrvChild is already 
reference counted.  Since the code is called under the bdrv_graph_rdlock 
there's no risk of the BdrvChild going away, and you can just make it a 
&BdrvChild.

Likewise, even BochsImage should not need a standard Rust 
Arc<BdrvChild>.  However you need to add your own block::Arc<BdrvChild> 
and map Clone/Drop to bdrv_ref/bdrv_unref.  Then BochsImage can use 
block::Arc<BdrvChild>; this makes it even clearer that Mapping should 
not use the Arc<> wrapper, because bdrv_ref is GLOBAL_STATE_CODE() and 
would abort if run from a non-main thread.

That said, I'm not sure how to include "block graph lock must be taken" 
into the types, yet.  That has to be taken into account too, sooner or 
later.  You probably have a lot of items like this one so it'd be nice 
to have TODO comments as much as you can.

(This boundary is where you get an unholy mix of C and Rust concepts. 
It takes a while to get used to, and it teaches you a lot of the parts 
of Rust that you usually take for granted.  So while it's not hard, it's 
unusual and it does feel like water and oil in the beginning).

> +) -> std::os::raw::c_int {
> +    let s = unsafe { &mut *((*bs).opaque as *mut D) };

&mut is not safe here (don't worry, we went through the same thing for 
devices :)).  You can only get an & unless you go through an UnsafeCell 
(or something that contains one).  You'll need to split the mutable and 
immutable parts of BochsImage in separate structs, and embed the former 
into the latter.  Long term you there should be a 
qemu_api::coroutine::CoMutex<>, but for the short term you can just use 
a BqlRefCell<> or a standard Rust RefCell<>.  You can see how 
PL011Registers is included into PL011State in 
rust/hw/char/pl011/src/device.rs, and a small intro is also present in 
docs/devel/rust.rst.

Anyway, the BdrvChild needs to remain in BochsImage, so that it is 
accessible outside the CoMutex critical section and can be placed into 
the Mapping.

> +    let mut offset = offset as u64;
> +    let mut bytes = bytes as u64;
> +
> +    while bytes > 0 {
> +        let req = Request::Read { offset, len: bytes };
> +        let mapping = match qemu_co_run_future(s.map(&req)) {
> +            Ok(mapping) => mapping,
> +            Err(e) => return -i32::from(Errno::from(e).0),

This is indeed not great, but it's partly so because you're doing a lot 
(for some definition of "a lot") in the function.  While it would be 
possible to use a trait, I wrote the API thinking of minimal glue code 
that only does the C<->Rust conversion.

In this case, because you have a lot more code than just a call into the 
BlockDriver trait, you'd have something like

fn bdrv_co_preadv_part(
     bs: &dyn BlockDriver,
     offset: i64,
     bytes: i64,
     qiov: &bindings::QEMUIOVector,
     mut qiov_offset: usize,
     flags: bindings::BdrvRequestFlags) -> io::Result<()>

and then a wrapper (e.g. rust_co_preadv_part?) that only does

    let s = unsafe { &mut *((*bs).opaque as *mut D) };
    let qiov = unsafe { &*qiov };
    let result = bdrv_co_preadv_part(s, offset, bytes,
          qiov, qiov_offset, flags);
    errno::into_negative_errno(result)

This by the way has also code size benefits because &dyn, unlike 
generics, does not need to result in duplicated code.

For now, I'd rather keep into_negative_errno() this way, to keep an eye 
on other cases where you have an io::Error<()>.  Since Rust rarely has 
Error objects that aren't part of a Result, it stands to reason that the 
same is true of QEMU code, but if I'm wrong then it can be changed.

Paolo


