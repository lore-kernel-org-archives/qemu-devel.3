Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B7CCA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuQpi-0003QP-La; Fri, 05 Sep 2025 03:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuQph-0003Q1-1y
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uuQpc-0000Fd-A9
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757057158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S0PxiyyABOdY97qJcIF4odon9ytTX01ksu9trBxWkow=;
 b=HX9C5yF+4JmHgwRVbavdEtf7d1uyk4BzkzZ0Xwwpxl3oazBtVuxlp86DRfXXN5ZfNoNoQM
 p0t1R6igEgTV4hIL/X+tabkgwlx2r1OWWUa9Lu6yoEdVV7UGn+48J/PBpdjiHgoDVQkd/b
 iY2JQy1NbD/h7lAMUsqUa82NY4tjV+w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-PLDFjmaKMBmYlqhdzYdi8g-1; Fri, 05 Sep 2025 03:25:56 -0400
X-MC-Unique: PLDFjmaKMBmYlqhdzYdi8g-1
X-Mimecast-MFC-AGG-ID: PLDFjmaKMBmYlqhdzYdi8g_1757057155
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45dd9a66c3fso606345e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757057154; x=1757661954;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S0PxiyyABOdY97qJcIF4odon9ytTX01ksu9trBxWkow=;
 b=Dym49ffuqwCdrn3XHL9F+1Ow1LEclAPL1HcxoSpjzmgWfeH3795iQAQnmrDhbSYrxR
 /PdDNqkIxnO0EjZuo5Mjr/4cIZLzRleSs7ERjTap5iOdLWrn3L1sqyiXoL++TjsE5nPh
 +LMZiMGOcFLNAQCtKDBpBkoI4WFUEVSnsA1fFRvcQTwh/jHP+1Z8m1Osp/GCD2FRgBm2
 XiegFdzmJavsIIDMg0n9pkAtvyBJG4VyUA+SBSrlPFwkjSM6acp4xuMd3iIVLntcykqJ
 ESxotf6RzoBXCEo6scfSLyKzESjkozbDDVbvxqI2gpaiVPmRw3qOzSg/3ARNXLIMCyxp
 g2TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzJy+aFZX5Nxlk8dssJtZw0EFJCp10DMOod6CRagwlt8LTMhbc+5vvEZjwbsoC7BF6a6wiF6iU9bjO@nongnu.org
X-Gm-Message-State: AOJu0Yz9LLu3S8sN1Prlh8DeBZiHXQEYNJApGpfkrVCBHbKz2Ftqf+vl
 7zQUv0tRF0G7A8shXeeZmNlIl+KCpjeGd2UB1qvr9PPkXg3Q88pS57VOKE96o/8hngAEydpO7gV
 amA1bYaLkbKuDOEspCK0/fD9TI+Hkq6EPChNHbteLIrI60ZHnG3AygI2zU3Sei9Wq
X-Gm-Gg: ASbGncv0adGVCg0Q5ta5dXGh/xfSV/iV+7iGzl0piBltTdRwpDYlH5bAeFqAEIFEFjK
 UzIjU04d+/A6QvuV9Ck1X1Aud4XL0ggX/BiSxEtrSXffTX2tRdqUsEo2XP3ZHOAVe8G6fm07kh3
 MmdkRt1oOPqmzb3sTJzBJlfCmNb9raVLaiimNRjv3NFj+48DeW/2dKJ8cbNj1CU8X4SYsqhCcSF
 43UYejfEkvMQ0HF5bh1aPEHrO3eqe00glIMYImKegzNhXOa/rVtj+34NJjd3NXnWfiat4Z1+MQh
 YnZpVSjrEFACyUKbahpgTFD8I560SSVx7p5k+WNVtUKAKF62LSD28GgNbrzBh8TdVCiFuQOZpaN
 urGglTaNKx9csH0zmGHJc78HbmXyMRHHrFIemw/IXovs=
X-Received: by 2002:a05:600c:35d5:b0:456:fdd:6030 with SMTP id
 5b1f17b1804b1-45d030f7fc7mr51660355e9.19.1757057154305; 
 Fri, 05 Sep 2025 00:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp78wEsavL7MihpktLuS5+4mRfEgtDxfZpiFIgkIk4IpO45P8sjLme9ctqzXqeI8eVPFwx7A==
X-Received: by 2002:a05:600c:35d5:b0:456:fdd:6030 with SMTP id
 5b1f17b1804b1-45d030f7fc7mr51660115e9.19.1757057153861; 
 Fri, 05 Sep 2025 00:25:53 -0700 (PDT)
Received: from [10.173.24.179] ([131.175.126.3])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45b9bcda91dsm146643365e9.6.2025.09.05.00.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 00:25:52 -0700 (PDT)
Message-ID: <6e43209d-645f-46e4-a23a-2a1ec149dfe8@redhat.com>
Date: Fri, 5 Sep 2025 09:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Use meson's detected python installation
To: Peter Foley <pefoley@google.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-block@nongnu.org, nabihestefan@google.com
References: <20250904-python-v1-1-c43b3209a0cd@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250904-python-v1-1-c43b3209a0cd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/4/25 17:11, Peter Foley wrote:
> Relying on `python3` to be avilable in $PATH doesn't work in some build
> environments. Update the build files to use the found python binary
> explicitly.

Meson already does this, if the file is not executable.  See 
docs/devel/build-system.rst:

   Meson has a special convention for invoking Python scripts: if their
   first line is ``#! /usr/bin/env python3`` and the file is *not*
   executable, find_program() arranges to invoke the script under the
   same Python interpreter that was used to invoke Meson.  This is the
   most common and preferred way to invoke support scripts from Meson
   build files, because it automatically uses the value of configure's
   --python= option.

Using "[python, 'foo']" is only needed for scripts "where it is 
desirable to make the script executable (for example for test scripts 
that developers may want to invoke from the command line, such as 
tests/qapi-schema/test-qapi.py)".

I think the only file you touched that is executable is 
scripts/qemu-plugin-symbols.py; so your issue can be fixed without code 
changes, and with a patch that only does "chmod -x 
scripts/qemu-plugin-symbols.py".  Please correct me if I'm wrong though!

Thanks,

Paolo

> Signed-off-by: Peter Foley <pefoley@google.com>
> ---
>   block/meson.build   |  6 ++----
>   meson.build         | 10 +++++-----
>   plugins/meson.build |  2 +-
>   3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/block/meson.build b/block/meson.build
> index 34b1b2a30630214959630d5543181bc82a54d2b3..67e9bee1210307ff15ca87ba0f5e7f785df15042 100644
> --- a/block/meson.build
> +++ b/block/meson.build
> @@ -139,14 +139,12 @@ if get_option('dmg').allowed()
>     endforeach
>   endif
>   
> -module_block_py = find_program('../scripts/modules/module_block.py')
>   module_block_h = custom_target('module_block.h',
>                                  output: 'module_block.h',
>                                  input: modsrc,
> -                               command: [module_block_py, '@OUTPUT0@', modsrc])
> +                               command: [python, files('../scripts/modules/module_block.py'), '@OUTPUT0@', modsrc])
>   block_ss.add(module_block_h)
>   
> -wrapper_py = find_program('../scripts/block-coroutine-wrapper.py')
>   block_gen_c = custom_target('block-gen.c',
>                               output: 'block-gen.c',
>                               input: files(
> @@ -158,7 +156,7 @@ block_gen_c = custom_target('block-gen.c',
>                                         '../include/system/block-backend-io.h',
>                                         'coroutines.h'
>                                         ),
> -                            command: [wrapper_py, '@OUTPUT@', '@INPUT@'])
> +                            command: [python, files('../scripts/block-coroutine-wrapper.py'), '@OUTPUT@', '@INPUT@'])
>   block_ss.add(block_gen_c)
>   
>   block_ss.add(files('stream.c'))
> diff --git a/meson.build b/meson.build
> index fa6186db33435c26d06dce2971a9f536250607e0..6e8baf3deb13c172eecd371ea302b1c2539048d0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -12,8 +12,6 @@ add_test_setup('slow', exclude_suites: ['thorough'],
>   add_test_setup('thorough',
>                  env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
>   
> -meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
> -
>   ####################
>   # Global variables #
>   ####################
> @@ -76,6 +74,8 @@ have_user = have_linux_user or have_bsd_user
>   sh = find_program('sh')
>   python = import('python').find_installation()
>   
> +meson.add_postconf_script([python, 'scripts/symlink-install-tree.py'])
> +
>   cc = meson.get_compiler('c')
>   all_languages = ['c']
>   if host_os == 'windows' and add_languages('cpp', required: false, native: false)
> @@ -3474,7 +3474,7 @@ foreach target : target_dirs
>         output: config_devices_mak,
>         depfile: config_devices_mak + '.d',
>         capture: true,
> -      command: [minikconf,
> +      command: [python, minikconf,
>                   get_option('default_devices') ? '--defconfig' : '--allnoconfig',
>                   config_devices_mak, '@DEPFILE@', '@INPUT@',
>                   host_kconfig, target_kconfig])
> @@ -3545,8 +3545,8 @@ config_host_h = configure_file(output: 'config-host.h', configuration: config_ho
>   genh += config_host_h
>   
>   hxtool = find_program('scripts/hxtool')
> -shaderinclude = find_program('scripts/shaderinclude.py')
> -qapi_gen = find_program('scripts/qapi-gen.py')
> +shaderinclude = [python, 'scripts/shaderinclude.py']
> +qapi_gen = [python, 'scripts/qapi-gen.py']
>   qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
>                        meson.current_source_dir() / 'scripts/qapi/commands.py',
>                        meson.current_source_dir() / 'scripts/qapi/common.py',
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 62c991d87fcdd8bcde8edddcc73909c6133f5460..6bf72a69060414ba1b7c1857515eeceb5a2c7b7c 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -6,7 +6,7 @@ qemu_plugin_symbols = configure_file(
>     input: files('../include/qemu/qemu-plugin.h'),
>     output: 'qemu-plugin.symbols',
>     capture: true,
> -  command: [files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
> +  command: [python, files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
>   
>   # Modules need more symbols than just those in plugins/qemu-plugins.symbols
>   if not enable_modules
> 
> ---
> base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
> change-id: 20250904-python-78ccebd0fded
> 
> Best regards,


