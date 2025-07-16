Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717FEC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 16:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc4uk-0004Pn-7V; Wed, 16 Jul 2025 12:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uc4ui-0004Np-Db
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:23:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uc4ug-0005Re-Gv
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:23:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso71088635ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752683001; x=1753287801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gnmot9ZBXyf46rDvhtLwclzETqSs7/1SDgU+fx7UWqg=;
 b=cIZQpAsCZywnVIlv35g7qh0OaS/0Ayi8SucqwFGn9lMgYebamrGXgtkhnH97UqU2RO
 9zdztoKCQu8qklQ+g6bdCyoU6BPJzqvmYolNxqtjKg1GfS5uARG4eWbv57Uhb7PB6n77
 UWCAZ26S6g80HH+I525vAx3GTxqltDa81tMLwm0CGhmOjvTl3xSRzuezXUynk5mzL5Fm
 ab6hRyx2dbDEq6AHXFuGhd0SqEccJYnmcVov7aBIIjlW8PzDEXahaea90jTqTJPGH7G+
 jk8hMLLdiG8fz1Y1SWdht6hq92KMsiwZFSCZ2Afs6J+5TA+x0hFfaLKcxHF9GcaNFkyE
 GSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752683001; x=1753287801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnmot9ZBXyf46rDvhtLwclzETqSs7/1SDgU+fx7UWqg=;
 b=vPNKpuk3JkrJREV5uP6wjNqs46Ly1NBX/LS2vF6JWgRWH1DdihsSmhR5Yb6B5ooYNE
 GqsENnVEfe3ZQGHVgCG0hxeF6XHzsb0xH3t307QYmkjPPAJpkiKMapYHP4tHc8LqdKQN
 ni5qVDSB3wr1r/rQrZ2NYX7elgs38mucPwflLLxxHZuK/MxXL9f6l6XyV5yzcqJNGowT
 WsV3zYviowuZFJJwdVVU+RJvUhE9RUIs8sazqvr4DNYzyD0QrrRyGH46HrKeg4/q4Ape
 9HJSEnypEiMls6JBPf+YwksbzDAprPYvMVggneTjUnQFsFeh2hINUGyRJca4tqzDKoYV
 noGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU25mgkyKiMyJ8qS5HemtFUdDAXhE7Qwow6zEnxlVdnMYJ2gq9+tLegggWfKDFEH5aZd0AweirAatvo@nongnu.org
X-Gm-Message-State: AOJu0YznsFXrmmcPkyLtQl60fO0zrqVqIFUfBJ1Bb/uxSoJ+hQG98OJK
 iqtRqX7BPDIUX3J557Cu29IiJs4y40kGuJmTPcGtdvX9mrAma1JZv4TKMILtrZjqZiU=
X-Gm-Gg: ASbGncs4x3cyw8PkNPYNtCzKnH0AM82M3qkzLDCn2eUS13YJYuUwIJGcphvw41YB4ew
 Kq2o2D9curHCXp04SpKxfc4NqbcAvApxedIFHl7wxhAmRAuWOvvgqxD5Ic/hAN8K0gDu/bgnV+e
 RVbMCdROxrUZ9L1bngP4/pXOmypSMvP81tzPF2EIDJPal8ddxmudTWfDEthoonqO/+TyIu4eAnb
 Yu5C/wOs+XbKYNZFdZ2uV0uZbSWpn58g+8XaSfiKZ2e2MRaCDabmJaxA0oKrAs93vjMDNRCyK+A
 nuf8Z/GFy0TF7PYLeMtXDfp0YIEOKVahNaHzu9BZjY+bFzC9KajOKv00kr2vti5zK779ZsD42aF
 F2p4fFkuIL27MEm7Bouq+ngbECsD2FRu7cqkFYfhYoIGVFA==
X-Google-Smtp-Source: AGHT+IEUzcfnkSBhBjFKOWBavZJqF+a02+EFVUahZUmqtBesxQ19dkBBpy4FbXALKc2nGytGH51FPg==
X-Received: by 2002:a17:902:d4cf:b0:23d:dcf5:47e1 with SMTP id
 d9443c01a7336-23e25737d09mr48848835ad.31.1752683000938; 
 Wed, 16 Jul 2025 09:23:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4332cdcsm127669905ad.145.2025.07.16.09.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 09:23:20 -0700 (PDT)
Message-ID: <ad2026f8-0907-4bde-83c3-b52b71e848a6@linaro.org>
Date: Wed, 16 Jul 2025 09:23:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/15/25 11:08 PM, Manos Pitsidianakis wrote:
> Add argument parsing to functional tests to improve developer experience
> when running individual tests. All logs are printed to stdout
> interspersed with TAP output.
> 
>    ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>    usage: test_aarch64_virt [-h] [-d]
> 
>    QEMU Functional test
> 
>    options:
>      -h, --help   show this help message and exit
>      -d, --debug  Also print test and console logs on stdout. This will
>                   make the TAP output invalid and is meant for debugging
>                   only.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   docs/devel/testing/functional.rst      |  2 ++
>   tests/functional/qemu_test/testcase.py | 51 ++++++++++++++++++++++++++++++++--
>   2 files changed, 50 insertions(+), 3 deletions(-)

Thanks, that's a great idea, and more convenient than the poor man's 
tail -f I was using for that.

Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

