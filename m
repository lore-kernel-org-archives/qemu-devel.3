Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286CFC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCCg-0002iD-5Z; Tue, 09 Jul 2024 10:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRCCe-0002hE-Hi
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:52:24 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRCCc-00081G-Ax
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:52:24 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77abe5c709so646142166b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720536740; x=1721141540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=msljsHL+RHUB6aM+37z2AL9JEVkNe+jrOgCXJpo759M=;
 b=KpSyB4pKMpdSLau0LWsimEPqXAo0pKNcVJ9wUs4hJvB9rrHMwhEsS1ph+g1yg1/e07
 WCL0wExrlDp+IGT6SFl+R5aokF1S+H7ACm1YZThlxuUk3q+DgRAv2cKHJGQrgfcfZuKb
 1H4G9tA1CIg9TR68LUfToViAFf57xxysRizHOHY58xo3X/XVCInTkcLzfwKUYQMgtLvx
 v3MWua2Z0WvATdJ2b8STnBlhEU84bpHsLNkkPF3CeJvQq/bon9ufZLAR8EKvN2+qZ9vr
 RXJtSxlvZZL5MPrxWzRnm+GUHvQnKzaAztz2PmWrpw6c67ZvqqF/RypkTXUXbmUv7buN
 moXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720536740; x=1721141540;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=msljsHL+RHUB6aM+37z2AL9JEVkNe+jrOgCXJpo759M=;
 b=pG9eKpBmhaEocWSL3kv6AQoJp4qUTrB0L77xDqvTLCC0ieBX39vblRcHaA8m0CIbnt
 dh7BkDMphRlM0CP2B+g54eSv5/5DGY4QjoCXiU3SgDgDpRk52h9lBXmKrWB8fOqlXDNg
 LHtqqUnBjd9fib3YDPnTpjuH/NhDyjjxvQ/Wjbw+2DiUPNe+yhekp6tKVoLkbWlF1Qft
 CtbSV12Vo3B+3nNYJU5tDmWcCSpG3fPGvr/R9eBXujVndxVF0aUzITJet3scnXONUPiT
 vYUwXvpVK3HK7q67//o3VHVx/ILPpCxxtK425blXVMdMNuURO2e5XGDIZWKZfDbNY8DC
 2NuQ==
X-Gm-Message-State: AOJu0YxoQ3ckazJlTdbTPazU9R6zQDkCtFL+ZfTiG8Gzz+NQ+haj/11W
 6kxDVI0JwbhlvSUvK3fLOr8eS2VSrXU6/J515frHZHXeOA62sGyz56NZSTGkgVQ=
X-Google-Smtp-Source: AGHT+IFI8f2DyzkM51cM7jxSMM1Ah9x3E5TU3giyK/VimjmLLRwSlKyMxapaP9KCstVibsueUv9uHQ==
X-Received: by 2002:a17:906:514:b0:a77:a58f:7f6a with SMTP id
 a640c23a62f3a-a780b6fe37amr147476666b.38.1720536739909; 
 Tue, 09 Jul 2024 07:52:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a6de323sm83329366b.62.2024.07.09.07.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 07:52:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 688645F8D7;
 Tue,  9 Jul 2024 15:52:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  rowan.hart@intel.com,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
In-Reply-To: <87msmqsunu.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Tue, 09 Jul 2024 11:53:57 +0100")
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
Date: Tue, 09 Jul 2024 15:52:18 +0100
Message-ID: <875xtesjml.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
>> Add mechanism to generate rust hw targets that depend on a custom
>> bindgen target for rust bindings to C.
>>
>> This way bindings will be created before the rust crate is compiled.
>>
>> The bindings will end up in BUILDDIR/{target}-generated.rs and have the =
same name
>> as a target:
>>
>> ninja aarch64-softmmu-generated.rs
>>
>> The way the bindings are generated is:
>>
>> 1. All required C headers are included in a single file, in our case
>>    rust/wrapper.h for convenience. Otherwise we'd have to provide a list
>>    of headers every time to the bindgen tool.
>>
>> 2. Meson creates a generated_rs target that runs bindgen making sure
>>    the architecture etc header dependencies are present.
>>
>> 3. The generated_rs target takes a list of files, type symbols,
>>    function symbols to block from being generated. This is not necessary
>>    for the bindings to work, but saves us time and space.
>>
>> 4. Meson creates rust hardware target dependencies from the rust_targets
>>    dictionary defined in rust/meson.build.
>>
>>    Since we cannot declare a dependency on generated_rs before it is
>>    declared in meson.build, the rust crate targets must be defined after
>>    the generated_rs target for each target architecture is defined. This
>>    way meson sets up the dependency tree properly.
>>
>> 5. After compiling each rust crate with the cargo_wrapper.py script,
>>    its static library artifact is linked as a `whole-archive` with the
>>    final binary.
>>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> <snip>
>> +
>> +msrv =3D {
>> +  'rustc': '1.77.2',
>> +  'cargo': '1.77.2',
>> +  'bindgen': '0.69.4',
>> +}
>
> This is still pretty bleeding edge (it even tripped up on the
> .cargo/bin/cargo I have installed). This needs to be set to the
> baseline which from:
>
>   https://wiki.qemu.org/RustInQemu/2022
>
> Looks to be 1.24.0 for rustc and I guess even lower for cargo (Debian
> says 0.66.0). While it might make sense to delay merging if we are
> waiting for one distro to produce a new LTS we shouldn't be needing
> rustup by default.

Also bindgen, do we need such a new one? On Trixie:

  Message:

  ../../rust/meson.build:41:4: ERROR: Problem encountered: bindgen version =
0.66.1 is unsupported: Please upgrade to at least 0.69.4

  A full log can be found at /home/alex/lsrc/qemu.git/builds/rust/meson-log=
s/meson-log.txt

  ERROR: meson setup failed

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

