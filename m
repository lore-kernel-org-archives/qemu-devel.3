Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C45EC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzgW-0007jU-Cw; Mon, 05 May 2025 13:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBzfp-0007LP-1q
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:32:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBzfn-00072u-1b
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:32:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224341bbc1dso61775395ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746466329; x=1747071129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9c4P9d4HxGT6taOxemai8T/lqQm1Md/UyLAAS06MThk=;
 b=V7laP2anYUspryBZ1OemiVoKgVyLYob1+kicX1i1P54vK5KbFRzgUDvcFMxtuPhYS8
 IXXka6vSEsiv/O3UotTFTgccxkLV4P1y6P+7a5p8Hn6XZL8+k8RXFHOvJhayjl7PcYHh
 KslW8mDIQKH443I4NWacFVxrA745ZQ8e6F8xIVo65BFDTD0u4VVj9PghNDew2V7uNP1Q
 /9g7wJobqamTpmLcEDQgJ/OY16oRMjCVkQqtSBIW4l85SnHAGmuwqwTxOTcanJeuHVim
 DNvTQxAxNazZmpXaAZIKFcISsaWL030NrtU4592Y9MrcJadYlL/oNAl+LDJzlo/+3OTm
 Obwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746466329; x=1747071129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9c4P9d4HxGT6taOxemai8T/lqQm1Md/UyLAAS06MThk=;
 b=IA/eVYkhrW04ckAkZT00UsfD/+3nve6SYimc0RVxCfUFMHCHIChDPscNOMaWSAwcPl
 qr6f/12bhGxNG/1rYo6p9QHhm3Hvthjde2dxm+g3NRoX16xYLTSVE8DBjeAKY5QUV1l6
 L3jsi0eec3iiJp1ACTluQL//txAZi4M5qYv8m+aNVCX9SJoqT8aCCYmFWyKjCXUwqST7
 1BjVI45ysTpjqgsUJfEAFZhUC7qb+ewZ5pmnM481TpU6Ca65ObjZ5asqCZcpa1Z8YU/R
 DAVA9qzb/I9O4oG79b9zsxbJ5WTmJ5tgR5gLFVv67WF7ubniHm2djyZCNEGiuxNTIB/P
 FYEQ==
X-Gm-Message-State: AOJu0YwUKtvKVCXKjttf8AKqWqNq6OgO1BieqgWAA0voFSRtDO74TbQS
 WUMOdLgfHZt6rUQFN+tLIQ5eW5CF/+PsoYqnPTdGg6xDpWkMbvVT6D2Zs//urK0=
X-Gm-Gg: ASbGncsVZHfS6yaIVy9yF+gQ+jVQya8YaHQ2thTL/3RiDhwiWCpIKdL0UwF7vndFL5p
 iwHfQsgby0MxPJjT8DS2vJT3hu5vN493kNxUsl6MXyNacmiIKeQzEQ2l56gilKxjMr0mt8rRuvT
 lyYjqqmyT3t0h6GXXjbyzHTeBRTwV1N3bP2943e5A3ZBVRe/vdt1pJR/K8e8ZHrKGiHt2fH9Qa2
 AyJCtUa9UiZVqEczYD33gjCe18G8c5hiorPtk+U06y4LKxLEiFkodnsFNIMwlfG5z462O8t2Z7q
 n9qm/IvQeSPdwUTvMTVuqDGgT8vb5F9kHVqA8YUyZGFu+zGDJrezdHrZvqRDZFnQ
X-Google-Smtp-Source: AGHT+IEzCriheJV8ttPqC2uNseLP5/6HGbEmTdf2BtEuahxpQE3JefC5tuwnohCw1U/epu4Fgxaj1g==
X-Received: by 2002:a17:902:f54e:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-22e18c4f10cmr160523945ad.44.1746466328889; 
 Mon, 05 May 2025 10:32:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150ec271sm58005045ad.10.2025.05.05.10.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 10:32:08 -0700 (PDT)
Message-ID: <4f64dd15-7cae-4a46-9bc7-14f92dceaf25@linaro.org>
Date: Mon, 5 May 2025 10:32:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use thorough test setup as default
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <CABgObfYxsES9JYDDrQzZzMpMPbN9se9ykg9OhE8xvYy0DQBzNg@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfYxsES9JYDDrQzZzMpMPbN9se9ykg9OhE8xvYy0DQBzNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 5/4/25 11:00 PM, Paolo Bonzini wrote:
> 
> 
> Il sab 3 mag 2025, 22:18 Pierrick Bouvier <pierrick.bouvier@linaro.org 
> <mailto:pierrick.bouvier@linaro.org>> ha scritto:
> 
>     Allows all tests to be visible by default when using meson test
>     directly.
> 
>     This has no impact on make check-* commands, which use SPEED=quick by
>     default (see scripts/mtest2make.py).
> 
> 
> What's the advantage of having different defaults depending on whether 
> you use "make check" or "meson test"?
>

"make check" can be seen as a blackbox, where you have different 
targets, but don't really do things on a per test basis. At least, it's 
not the workflow that was implemented.
"meson test", on the opposite, expose the list of tests to you.

My rationale here is to expose all tests for meson test (instead of 
having to add --setup thorough everytime), and let the "per setup" 
workflow to make command.

> I don't oppose this change per se, but if it's useful it should be 
> matched by a change in the default SPEED.
> 

As Thomas pointed, running thorough tests by default would take more 
time/more disk space, and I'm not sure we want to change what is done in 
our CI or for people by default.

This change is just supposed to be convenience for people using meson 
test directly, without impacting "make check*" users.
So when you want to run a single test, it's visible from
"meson test -C build --list", by default.

> Paolo
> 
> 
>     Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org
>     <mailto:pierrick.bouvier@linaro.org>>
>     ---
>       meson.build | 5 +++--
>       1 file changed, 3 insertions(+), 2 deletions(-)
> 
>     diff --git a/meson.build b/meson.build
>     index f8bf6e7bb66..57ff3f722d8 100644
>     --- a/meson.build
>     +++ b/meson.build
>     @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
> 
>       meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
> 
>     -add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
>     is_default: true,
>     +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
>                      env: ['RUST_BACKTRACE=1'])
>       add_test_setup('slow', exclude_suites: ['thorough'],
>                      env: ['G_TEST_SLOW=1', 'SPEED=slow',
>     'RUST_BACKTRACE=1'])
>       add_test_setup('thorough',
>     -               env: ['G_TEST_SLOW=1', 'SPEED=thorough',
>     'RUST_BACKTRACE=1'])
>     +               env: ['G_TEST_SLOW=1', 'SPEED=thorough',
>     'RUST_BACKTRACE=1'],
>     +               is_default: true)
> 
>       meson.add_postconf_script(find_program('scripts/symlink-install-
>     tree.py'))
> 
>     -- 
>     2.47.2
> 


