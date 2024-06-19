Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3467C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 16:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJyP7-0001yM-T4; Wed, 19 Jun 2024 12:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJyP2-0001xS-0v
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJyOx-0003We-5F
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 12:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718815393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TgB7gjl+/kTRq6JvyMDrRPZk9doMgSbDXT3hJexBGd4=;
 b=eT5RxkEIPNK4YT+BhQZ2FBg5VQMNCJf5/3tS8Mw6al8XLdW7RwGq8dLmQDZTytGd3DzF3l
 SsYty2I77QSIjXcVSlOUC/DAwa0mqyELl2Tb59V67cpcsKBoAZ6fSjVrzIqlV1hqigi6+M
 HgloGGBp+clkXCvT+neUy+1NmZRZrVQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-5PXqKhrbO86qX2dnM5c_Mg-1; Wed, 19 Jun 2024 12:43:05 -0400
X-MC-Unique: 5PXqKhrbO86qX2dnM5c_Mg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f1db7e425so457919566b.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 09:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718815384; x=1719420184;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TgB7gjl+/kTRq6JvyMDrRPZk9doMgSbDXT3hJexBGd4=;
 b=lI1QmFEiFsKMRbPlaYAh6WF+f2fNxENXMoQNOPPSsFnWbE4juljwHjBr1u6ZO9IbIU
 yTnuKmh4IAYBEKAJokYQNd+eatrZDLR2XUcxLW9tOrNcn9sk9GAOgKbzEffhI8rMPu9k
 O8Ji/wX8aER++JbnvmLH2RFJhiwDGDqwUYT+EXKzUnrMh8C3duNsurGIhWcDVmGlvqoV
 C0P2EsOHaXQ7Q3MJH07SWenGdoSKepa4VLOiejxqYZna3W7tBQVqd8tQGipI5P3NtTBq
 W1AaZpTOjvGl311V2un6nGF2azXz4r32m95Hi2GGM9uGa4IwIwu1sWHTmcetyA1RPfVh
 3bZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWije1ediHf4aNBweOB72d/hoh6HJXmvNlRnpAI7kCnZfyuoMeud0U9HD1xWFvisOUKSfZTzWUEAhHG9Ax2TtRtWMXi0Oo=
X-Gm-Message-State: AOJu0YwYX40CZjBdWwi2PTZy+DhkijlAJpZ8e8eF3Wx6cUtaerDN038K
 bWJxQRat6cxT8DdgBdiRhVEjBQYHCxTsUWspDwIvRVwPI0mRLY0i/VJd75zHOMVnxanG1Fsh3Zv
 V3/N5/+SIVIit8dLXMG2V1McbazqfUuoX/lvrwD3+cwNFFSKTzfdT
X-Received: by 2002:a17:906:9c88:b0:a6f:b58f:ae47 with SMTP id
 a640c23a62f3a-a6fb58fba6emr167312666b.10.1718815383765; 
 Wed, 19 Jun 2024 09:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjdl7OtKdxemCtPdhEAj+KIPWJE/Nn1hu5ux5aOdFKaAz/3Vp06zlZUCcEu9zACKtQ04Q2YA==
X-Received: by 2002:a17:906:9c88:b0:a6f:b58f:ae47 with SMTP id
 a640c23a62f3a-a6fb58fba6emr167307666b.10.1718815382270; 
 Wed, 19 Jun 2024 09:43:02 -0700 (PDT)
Received: from [192.168.10.81] ([151.62.196.71])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56da3fd8sm674579466b.42.2024.06.19.09.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 09:43:01 -0700 (PDT)
Message-ID: <1c53f8d2-3b33-404c-bb1c-38475087d7ae@redhat.com>
Date: Wed, 19 Jun 2024 18:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <0841ddd2-d962-4f1d-a818-be9a1ec4d9bf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <0841ddd2-d962-4f1d-a818-be9a1ec4d9bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/19/24 07:34, Richard Henderson wrote:
> First silly question: how much of this is boiler plate that gets moved 
> the moment that the second rust subdirectory is added?

If my suggestion at 
https://lore.kernel.org/qemu-devel/CABgObfaP7DRD8dbSKNmUzhZNyxeHWO0MztaW3_EFYt=vf6SbzA@mail.gmail.com/ 
works, we'd have only two directories that have a Cargo.toml in it.  For 
example it could be rust/qemu/ (common code) and rust/hw/ (code that 
depends on Kconfig).

I think we can also have a rust/Cargo.toml file as in 
https://doc.rust-lang.org/cargo/reference/workspaces.html#virtual-workspace, 
and then the various configuration files under rust/ will be valid for 
all subpackages.

>> +[build]
>> +rustflags = ["-Crelocation-model=pic", "-Ctarget-feature=+crt-static"]
> 
> It seems certain that this is not specific to pl011, and will be commot to other rust 
> subdirectories.  Or, given the .cargo directory name, is this generated by cargo and 
> committed by mistake?

-Crelocation-mode should be pie.  But also, I am not sure it works 
because I think it's always going to be overridden by cargo_wrapper.py? 
See https://doc.rust-lang.org/cargo/reference/config.html#buildrustflags.

(I'm not sure what +crt-static is for).

I think the generate_cfg_flags() mechanism of cargo_wrapper.py has to be 
rewritten from Python to Rust and moved to build.rs (using 
cargo::rustc-cfg).  By doing this, the cfg flags are added to whatever 
is in .cargo/config.toml, rather than replaced.

>> diff --git a/rust/pl011/.gitignore b/rust/pl011/.gitignore
>> new file mode 100644
>> index 0000000000..28a02c847f
>> --- /dev/null
>> +++ b/rust/pl011/.gitignore
>> @@ -0,0 +1,2 @@
>> +target
>> +src/generated.rs.inc
> 
> Is this a symptom of generating files into the source directory and not 
> build directory?

If I understand correctly, Manos considered two possible ways to invoke 
cargo on the Rust code:

- directly, in which case you need to copy the generated source file to 
rust/pl011/src/generated.rs.inc, because cargo does not know where the 
build tree

- do everything through meson, which does the right thing because 
cargo_wrapper.py knows about the build tree and passes the information.

To avoid this, the first workflow could be adjusted so that cargo can 
still be invoked directly, _but from the build tree_, not the source 
tree.  For example configure could generate a 
.../build/.cargo/config.toml with

    [env]
    MESON_BUILD_ROOT = ".../build"

(extra advantage: -Crelocation-model=pie can be added based on 
--enable-pie/--disable-pie).  configure can also create symlinks in the 
build tree for the source tree's rust/, Cargo.toml and Cargo.lock.

This allows rust/pl011/src/generated.rs (which probably will become 
something like rust/common/src/generated.rs) to be:

    include!(concat!(env!("MESON_BUILD_ROOT"), "/generated.rs.inc"));

when cargo is invoked from the build tree.

Putting everything together you'd have

    build/
      rust/
        .cargo/
          config.toml   # generated by configure or meson.build
        Cargo.toml      # workspace generated by configure or meson.build
        Cargo.lock      # can be either linked to srctree or generated
        qemu/           # symlink to srctree/rust/qemu
        aarch64-softmmu-hw/
          Cargo.toml    # generated by meson.build (*)
          src/          # symlink to srctree/rust/hw/
        i386-softmmu-hw/
          Cargo.toml    # generated by meson.build
          src/          # symlink to srctree/rust/hw/
        generated/      # files generated by rust/generated/meson.build

(*) these have to be generated to change the package name, so 
configure_file() seems like a good match for it.

This is suspiciously similar to what tests/tcg/ looks like, except that 
tests/tcg/*/Makefile is just a symbolic link.  I tried creating a 
similar directory structure in a toy project, and it seemed to work...

> Second silly question: does this really need to be committed to the 
> repository? It *appears* to be specific to the host+os-version of the 
> build.  It is certainly very specific about versions and checksums...

Generally the idea is that libraries should not commit it, while 
applications should commit it.  The idea is that the Cargo.lock file 
reproduces a working configuration, and dependencies are updated to 
known-good releases when CI passes.  I don't think I like this, but it 
is what it is.  I ascribe it to me being from the Jurassic.

But for now I would consider not committing Cargo.lock, because we don't 
have the infrastructure to do that automatic dependency update (assuming 
we want it).  But we could generate it at release time so that it is 
included in tarballs, and create the symlink from 
srctree/rust/Cargo.lock into build/rust/ only if the file is present in 
the source tree.

>> diff --git a/rust/pl011/Cargo.toml b/rust/pl011/Cargo.toml
>> [...]
>> +# bilge deps included here to include them with docs
>> +[dependencies]
>> +arbitrary-int = { version = "1.2.7" }
>> +bilge = { version = "0.2.0" }
>> +bilge-impl = { version = "0.2.0" }

This one has to be included, but it is less restrictive than it seems.

It is equivalent to

arbitrary-int = { version = ">=1.2.7, <2.0.0" }
bilge = { version = ">=0.2.0, <0.3.0" }
bilge-impl = { version = ">=0.2.0, <0.3.0" }

That is, it assumes an API breakage when the first nonzero component 
changes in the version.  It is also possible to put a caret in front of 
the version, so that it's clearer that this is a range; but the behavior 
is the same.

Paolo


