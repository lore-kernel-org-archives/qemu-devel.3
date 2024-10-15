Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ABDCFC277
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0j05-0000y6-Vs; Tue, 15 Oct 2024 10:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0j05-0000xi-34
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0j03-0008Uq-Du
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729004294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pBp1ZsEDXGy7FlHBgjLv10Vek8gg6fJ8NfCGDQZFSLo=;
 b=M83OJAL1ND4aqrwp6Dc9E+/fEsVsiBET/Z/XfTXPntJKwJY0HHxoqydTG5lOk+GMrhYcP9
 7WJWq8J2u8/V3sY/p+ZNGVxnMu6TawBIAae8uyQuae2Fdbrd9QPXRiu4KPJnP6UQml17/z
 Gnhw1SlCUHe5qFrXRfWjG1DCBE2DUUs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-6LZY91SrPuCAIk34ETgU7A-1; Tue, 15 Oct 2024 10:58:12 -0400
X-MC-Unique: 6LZY91SrPuCAIk34ETgU7A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d504759d0so3088788f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729004291; x=1729609091;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pBp1ZsEDXGy7FlHBgjLv10Vek8gg6fJ8NfCGDQZFSLo=;
 b=aaK/a0UR/RC0E7vsNRc1L6HD9Q3Omh1w4TEI0ZT1fPphkRGMhBy/H8xFUEfUBkSygp
 59Ufy109GwGZWchwAf44Y93qfvbTI5F3ltT8qMMAMpmhLkX6d0rE8WX1Qhm+W1fFG9Xp
 vJcRHI+Uiwaoe5CfKUZvxZkL1860U9iLINrsfZIKU2YevjNMXyzeN6fQXjk4Rsyo7U/I
 8a2SWcDbj1VKEl0hTr43SY2bMeYAfMwYDTLTf1fXmDZdE2YNk6/unpDXLiDni9sNMOCD
 l/OfDz+P/2Gj0U3dlSxNuSTJGa6uzd/zn213y8fRBsYtU61YG/tk5AMdIWSxaOEGyF4o
 QHxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/OGdwpyy5djSvjd4wl0FLmNmPurMgJfaNnTIh50nAqNIeDSs8dXzmAjdf8YAE/ykMSAs4f1WiY5F9@nongnu.org
X-Gm-Message-State: AOJu0Yy3M5fGXQuzZmjOzOsLbWPC8Md2Vb6uBN2xjblQju3nt1C4Cdme
 xquc3lrWAnL9zlUtS8b+PNCPcw5Sk+15ZPqy5w1G7j/8JMgIvGQIuEgSZhcrt1hhelcoSeWbA/g
 J9uSBgHxuQ7fatcqRjPGTaQw37/UslfF+jCUOw9t4wXBnw7UExnWA
X-Received: by 2002:adf:e650:0:b0:37d:5042:c8de with SMTP id
 ffacd0b85a97d-37d5ff8a25emr9515917f8f.22.1729004291442; 
 Tue, 15 Oct 2024 07:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9QaTjozw44q7WSCsZECbJpcXou0hyjigkmTX0ljbyb94vg0zc3ZRNlkP1aK11J/avQ69Q8g==
X-Received: by 2002:adf:e650:0:b0:37d:5042:c8de with SMTP id
 ffacd0b85a97d-37d5ff8a25emr9515893f8f.22.1729004290991; 
 Tue, 15 Oct 2024 07:58:10 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37d7fbf814esm1745490f8f.68.2024.10.15.07.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:58:10 -0700 (PDT)
Message-ID: <24e344f1-d6a8-40c7-a543-68251570fc58@redhat.com>
Date: Tue, 15 Oct 2024 16:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust/wrapper.h: define memory_order enum
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241015-rust-wrapper-stdatomic-v1-1-f22c0bd31140@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241015-rust-wrapper-stdatomic-v1-1-f22c0bd31140@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/15/24 14:07, Manos Pitsidianakis wrote:
> Add stub definition of memory_order enum in wrapper.h.
> 
> Creating Rust bindings from C code is done by passing the wrapper.h
> header to `bindgen`. This fails when library dependencies that use
> compiler headers are enabled, and the libclang that bindgen detects does
> not match the expected clang version. So far this has only been observed
> with the memory_order enum symbols from stdatomic.h. If we add the enum
> definition to wrapper.h ourselves, the error does not happen.
> 
> Before this commit, if the mismatch happened the following error could
> come up:
> 
>    /usr/include/liburing/barrier.h:72:10: error: use of undeclared identifier 'memory_order_release'
>    /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
>    /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
>    /usr/include/liburing/barrier.h:68:9: error: use of undeclared identifier 'memory_order_relaxed'
>    /usr/include/liburing/barrier.h:65:17: error: use of undeclared identifier 'memory_order_relaxed'
>    /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
>    /usr/include/liburing/barrier.h:75:9: error: use of undeclared identifier 'memory_order_acquire'
>    /usr/include/liburing/barrier.h:72:10: error: use of undeclared identifier 'memory_order_release'
>    panicked at [..]/.cargo/registry/src/index.crates.io-6f17d22bba15001f/bindgen-cli-0.70.1/main.rs:45:36:
>    Unable to generate bindings
> 
> To fix this (on my system) I would have to export CLANG_PATH and
> LIBCLANG_PATH:
> 
>    export CLANG_PATH=/bin/clang-17
>    export LIBCLANG_PATH=/usr/lib/llvm-17/lib
> 
> With these changes applied, bindgen is successful with both the
> environment variables set and unset.
> 
> Since we're not using those symbols in the bindings (they are only used
> by dependencies) this does not affect the generated bindings in any way.

That is still likely to break, depending on what changes in the future 
in the headers that clang provides.

We can do this (or alternatively, limit the number of files included in 
wrapper.h; in this case trying to remove use of io_uring's headers from 
include/block/aio.h) but probably we have to leave the warning in.

Paolo


