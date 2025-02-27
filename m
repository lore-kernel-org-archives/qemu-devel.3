Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190C1C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnazt-00005H-7j; Thu, 27 Feb 2025 05:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnazq-0008VF-Nt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnazo-0008JA-Dz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740651598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QKsW9BiuCkIutRc37dB6/ntS6CkwHzfpfYHjlCv7y1M=;
 b=MRnZM6oPU8m8nMHykeQIeQ0xUFTfXtsVONY5WICW6q+ahLAq+UiIaDcXxDVfRhWz46VcxZ
 PZNc6t8LyPvmDcXE0l6cHGuF3bA4Bikh+0tX7vlVu7lWo2/7D//6XudY/dzkde+K/ThEbn
 Ig0LEHpzhhdY0BCvJC7qqZ/T6IHtz/g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-LQ02gvCbPPiUT8Sf_Doj5g-1; Thu, 27 Feb 2025 05:19:56 -0500
X-MC-Unique: LQ02gvCbPPiUT8Sf_Doj5g-1
X-Mimecast-MFC-AGG-ID: LQ02gvCbPPiUT8Sf_Doj5g_1740651596
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abb76bd0feeso100394166b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 02:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740651595; x=1741256395;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QKsW9BiuCkIutRc37dB6/ntS6CkwHzfpfYHjlCv7y1M=;
 b=qg2D5Y6+UbEnKF9MZ5NLNa0Spr7zwQHzKp6kOpBcb/QbJCjVSg/uzpDtpaUmfheiN6
 nzhhGLBC0DRzK5SctI4HOpmQ1thv7amX4VPIuuM7mrgxtCsFN1ZBbYEgEoksblfFnjpA
 6foatZvxD8KRJq3NomseMaw7FBoGK9GAxu50FGdPpz99cWF7NVVyuR0ZZWIvTImI51MR
 jxHeTjB0CcOkSFfFxzPoiabK5uAf+34nluOnEnxhGib/GNk8UEYFkqr6D7Sp9OknZxcO
 /7TYyY95SnoGGdfgRPxcRthpIyCOED9hRmyhEllBVUfB9ViOPTyEGp12y2Vrhc1vY5U8
 QQ4w==
X-Gm-Message-State: AOJu0YzEm2QwVojck5XPzyxmcX/paHDz3FKKJZmeWvHMzeyey+OnKJmu
 90bKYIXHRuj2MhWZUZHL26eiWMLWEsU/7mZUpjAJdw78/+SSJLYQKQIau3hjXKXIWdA1z+Ufvrn
 Rna+NA7sIEBx6jdLi1Nl2uC3lq5V+nWdOqL5KDtTZlnWckL54q4b9
X-Gm-Gg: ASbGncuVyhtaNqSLVyqPGBD+TLozst94nJ2la5O7RXnGE/199AnK0oLi6v1hGN2m0T4
 yN8vkErWGVfMCpV3MhrGylOaoQWY6OpH0V9/wi5CDPJebdXI7cxK3B7QNDOFnyrSa5Uf9+xVY/m
 D4gXvKhZxY2gFeScIWnVTNhwWC6GTmw0GS73Q76SBofQnVse6CCE+za/Wy0HaBWQPolA7++3alO
 Hyzbe/uzqEvY4MFEqKx/e1E8sMLrBwsi//OZghj6UbWH892drb4/CUAqfe++XWMPH9SnEuWOPyA
 iBwwIz4imeQ+Qdqh66Fc
X-Received: by 2002:a17:907:cf84:b0:ab7:46c4:a7be with SMTP id
 a640c23a62f3a-abf05dcd4eamr333273866b.2.1740651595454; 
 Thu, 27 Feb 2025 02:19:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi+NAXC3clczywtW+lLoZhVsdsV5Fs/KybU6J19s4mUk5ndDltmudTPzTBmg5tNo12u8GlOg==
X-Received: by 2002:a17:907:cf84:b0:ab7:46c4:a7be with SMTP id
 a640c23a62f3a-abf05dcd4eamr333272366b.2.1740651595073; 
 Thu, 27 Feb 2025 02:19:55 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-abf0c755d22sm97541166b.129.2025.02.27.02.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 02:19:54 -0800 (PST)
Message-ID: <d788bb12-0d69-43eb-bf09-a94ead71c9e4@redhat.com>
Date: Thu, 27 Feb 2025 11:19:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: Replace meson introspection argument with a
 builddir
To: Joel Granados <joel.granados@kernel.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20250204-jag-fix_meson-v1-1-ecb6bdb1db51@kernel.org>
 <5ea3a240-1805-40f8-9c5d-af12794ea34c@redhat.com>
 <opabljxycyh2huu4yicopg5dkur56pntyehozkrp2tai5orgnz@frubtj4drvma>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <opabljxycyh2huu4yicopg5dkur56pntyehozkrp2tai5orgnz@frubtj4drvma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 2/27/25 11:07, Joel Granados wrote:
> Here is the error I see:
> cmd:
>    meson introspect --buildoptions /home/joel/src/qemu/meson.build
> 
> output:
>    meson.build:88:12: ERROR: Unknown compiler(s): [['rustc']]
>    The following exception(s) were encountered:
>    Running `rustc --version` gave "[Errno 2] No such file or directory: 'rustc'"

Thanks, this helps.

> When I pass it a builddir it actually gives me all the buildoptions
> (which is what I expect)
> cmd:
>    meson introspect --buildoptions /home/joel/src/qemu/bdir

Yes, the difference is that the builddir version uses the results of 
actually executing meson.build, whereas the srcdir version only does 
some cursory parsing and always looks at both branches of "if" statements.

This is actually not a bug, and in fact now I remember why it is using 
the srcdir version...  Looking at the required languages is needed in 
order to figure out language-dependent build options, and the srcdir 
version includes the options for all languages that QEMU could use.

None of the language-dependent options (for example c_std) are surfaced 
in meson-buildoptions.sh, which is why your patch works in the first 
place.  But I think it's a better fix for you to install rustc, since it 
will anyway become mandatory sooner or later.

Paolo

> Quickly looking at the error message and at line 88 shows me that it has
> to do with the build trying to call the rust compiler (which I do
> **not** have installed). It seems that have_rust has the true value even
> though I do not have it installed. However all this goes away when I
> pass it a builddir.
> 
> Maybe the fix is to change the detection logic for the rust compiler?
> FYI:
> 1. These are the lines that have rust in the meson_options.txt:
>    option('rust', type: 'feature', value: 'disabled',
>           description: 'Rust support')
>    option('strict_rust_lints', type: 'boolean', value: false,
>           description: 'Enable stricter set of Rust warnings')
> 2. This is how I run configure:
>    ../configure --target-list=x86_64-softmmu --disable-docs
> 
> Notice that in meson.build:88 the value of has_rust depends on
> have_system which in turn depends on target_dirs. Does target_dirs have
> values outside a builddir?


