Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E278CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 09:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urCma-0004t1-10; Wed, 27 Aug 2025 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urCmM-0004r7-2B
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 05:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urCmF-0003UR-UX
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 05:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756288147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DzPJLfP9VECufLuWOQ8dGHcHfP7LJTlDeegqWyXFcI8=;
 b=KMU/Hcrj/iUpBKO7zZj2uK9ryAH2W2x2FvagAWge1Cwcnwn9oY0BP4FOcqkaua2Dqt1kzz
 1FaCgf8H/ruZvBuhIrgN0bZj7pfibJq7ZGGHE+cnFnbJlyZ3O0AjQDZuOgfqbpool02KMq
 JZ4yQHL1dQmBY2AQ1A6yJgw2svEuT4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-krxvPrsxMDqbI7kLTCFqLg-1; Wed, 27 Aug 2025 05:49:06 -0400
X-MC-Unique: krxvPrsxMDqbI7kLTCFqLg-1
X-Mimecast-MFC-AGG-ID: krxvPrsxMDqbI7kLTCFqLg_1756288145
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3c584459d02so2386797f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 02:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756288145; x=1756892945;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DzPJLfP9VECufLuWOQ8dGHcHfP7LJTlDeegqWyXFcI8=;
 b=akRmL3uD0urowTwr7iJT+C4AAcXsUeSs5PEdEam+ur4KwaZF1IUXLH7GlFa6jk5OjL
 V0ECvbpVJi0BYGzwVc9NC8KsOr+X3SwvMCKSAaQpObRVAuxBF235Ztxc1cUO648FNVhN
 adaoabyb5c69dpid/Z9Gn8fanh7/L+wYf+C271duuG2BXtfKFUwwx8SsFDFa5DrbuRQW
 5EZacXf9/HnCk06FzArKIdsgb5NYGNcc/eOgPpWRy+64fSxe1ybA+reHTKTHCrZnPs++
 cUiUFfbn4j0t+hSsXG/bxs5wsGW4Ic22qtcIXM/42pF80bOgSivdFmOAcS5e/Dm3JPST
 4/Yw==
X-Gm-Message-State: AOJu0YzXISWH7WQ//fMUScjhLkx7Owq5o9unmAVcvmvUCzrOSsSe2Y5T
 g1zPaYpk9/rC98JxqvqbORnnP8OQN0jjKO1kkGgsoklRB4MF6BCZYqtYRFHbbIuy9AGrFMsWS1N
 oPIvuf59n/y2mngPJVlJTpOxMvT9c35SKxmp5GFHa+N1KiRobHzW3tCpe
X-Gm-Gg: ASbGnctRGLTsmkk05YMwJhRZtaUm99QAv2JKkgxTg1e1/+Km8FVjF4EpaagBkaLUiVN
 Gq+i0blkgvGki4LkRGJzAgMRnW9PPjJhY+6vfoM78A8SiIHyfbZb8zhQV5IjSYLhll1uwZNykzd
 eePMBTeP85cNcHTsWJUU1CsqVbDM8qDl0tsnjk+A4X3u98MiYab76xKEjxLY7PS2X7XYXil850T
 DdSZAjG1AZBYGsBAmHNLGBlqPjKq6UNtG5tbrtb9beEbsbPG037Fvgv7RueVW+K9gKooNhXqLob
 fl6ULQ+wWbJLou1AGtvUWaB4qCS+2WWNlbqWc0NYNiOOnR0YU3yvWiLmnpqAT8r781NSJoSoxsG
 vxgAqI718jEbELcCUunZcRFz3N/aVaFOSDVLCnLSMuOM=
X-Received: by 2002:a5d:5887:0:b0:3b8:dabe:bd8b with SMTP id
 ffacd0b85a97d-3c5db2dce81mr14047941f8f.27.1756288144740; 
 Wed, 27 Aug 2025 02:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhP4j4C4I+q5CKbWpfC3LLGYNXjDeqvhKlGQpKICiMGFuVwzPDHHmEMu0VYLc2H/d15WQnTg==
X-Received: by 2002:a5d:5887:0:b0:3b8:dabe:bd8b with SMTP id
 ffacd0b85a97d-3c5db2dce81mr14047914f8f.27.1756288144209; 
 Wed, 27 Aug 2025 02:49:04 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3cd2e01dd9dsm773837f8f.60.2025.08.27.02.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 02:49:03 -0700 (PDT)
Message-ID: <599c6937-9fc3-4625-ab8e-08ef02d527ff@redhat.com>
Date: Wed, 27 Aug 2025 11:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 10/18] rust: split "qom" crate
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-rust@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
 <20250826140449.4190022-11-marcandre.lureau@redhat.com>
 <aK6r0AytZGSOkWYF@intel.com>
 <CAMxuvaxeqgtpKDPwxuRd-bqdy5We=pEpy_FKRo0AysKKFa9kHg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAMxuvaxeqgtpKDPwxuRd-bqdy5We=pEpy_FKRo0AysKKFa9kHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/27/25 10:57, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Aug 27, 2025 at 10:33 AM Zhao Liu <zhao1.liu@intel.com 
> <mailto:zhao1.liu@intel.com>> wrote:
> 
>      > diff --git a/rust/hw/char/pl011/src/device.rs <http://device.rs>
>     b/rust/hw/char/pl011/src/device.rs <http://device.rs>
>      > index 7cffb894a8..a3bcd1297a 100644
>      > --- a/rust/hw/char/pl011/src/device.rs <http://device.rs>
>      > +++ b/rust/hw/char/pl011/src/device.rs <http://device.rs>
>      > @@ -21,10 +21,13 @@
>      >      memory::{hwaddr, MemoryRegion, MemoryRegionOps,
>     MemoryRegionOpsBuilder},
>      >      prelude::*,
>      >      qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property,
>     ResetType, ResettablePhasesImpl},
>      > -    qom::{ObjectImpl, Owned, ParentField, ParentInit},
>      >      sysbus::{SysBusDevice, SysBusDeviceImpl},
>      >      vmstate_clock,
>      >  };
>      > +use qom::{
>      > +    qom_isa, IsA, Object, ObjectClassMethods, ObjectDeref,
>     ObjectImpl, ObjectMethods, ObjectType,
>      > +    Owned, ParentField, ParentInit,
>      > +};
> 
>     These QOM parts are frequently used and very common. at least for qom,
>     I think prelude would help a lot. 
> 
> 
> ack
> 
>     A qom prelude could help reduce the changes in other parts (pl011/
>     hpet/memory...).
> 
>      > diff --git a/rust/qom/meson.build b/rust/qom/meson.build
>      > new file mode 100644
>      > index 0000000000..6e95d75fa0
>      > --- /dev/null
>      > +++ b/rust/qom/meson.build
>      > @@ -0,0 +1,61 @@
>      > +_qom_cfg = run_command(rustc_args,
>      > +  '--config-headers', config_host_h, '--features',
>     files('Cargo.toml'),
>      > +  capture: true, check: true).stdout().strip().splitlines()
>      > +
>      > +# TODO: Remove this comment when the clang/libclang mismatch
>     issue is solved.
>      > +#
>      > +# Rust bindings generation with `bindgen` might fail in some
>     cases where the
>      > +# detected `libclang` does not match the expected `clang`
>     version/target. In
>      > +# this case you must pass the path to `clang` and `libclang` to
>     your build
>      > +# command invocation using the environment variables CLANG_PATH and
>      > +# LIBCLANG_PATH
>      > +_qom_bindings_inc_rs = rust.bindgen(
>      > +  input: 'wrapper.h',
>      > +  dependencies: common_ss.all_dependencies(),
>      > +  output: 'bindings.inc.rs <http://bindings.inc.rs>',
> 
>     There're many binding files with the same name. What about adding a
>     prefix
>     like "qom-bindings" to distinguish it? This can help search and locate
>     specific binding file.
> 
> 
> they are already under different directories :)
> 
> 
>      > +  include_directories: bindings_incdir,
>      > +  bindgen_version: ['>=0.60.0'],
>      > +  args: bindgen_args_common,
>      > +)
> 
>     ...
> 
>      > diff --git a/rust/qom/tests/tests.rs <http://tests.rs> b/rust/
>     qom/tests/tests.rs <http://tests.rs>
>      > new file mode 100644
>      > index 0000000000..49f1cbecf5
>      > --- /dev/null
>      > +++ b/rust/qom/tests/tests.rs <http://tests.rs>
>      > @@ -0,0 +1,47 @@
>      > +use std::{ffi::CStr, sync::LazyLock};
> 
>     LazyLock is useful, but it became stable since v1.80. So if Paolo
>     decide pick this series after v1.83 support, it's fine.
yes, you all can assume 1.83.

Paolo


