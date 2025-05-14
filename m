Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B31EC3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFJE-0000iq-DE; Wed, 14 May 2025 12:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFFJ3-0000Xi-PX
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:50:10 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFFJ1-0005Xg-TH
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:50:09 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22e3b069f23so329045ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747241406; x=1747846206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ftifFUtawtU70JBQxY86KdqzY76jF1UryKbSrTds91I=;
 b=FaAogOSMhB15ILCWBJvPY2Nzo3KRcwYdgQW+rNJsfoZ/WRrJhqjV8wjTIi4PpOACQO
 EdLqQ17gjSGr51RJ5q74PEQuGHk/UuRtN24DGVIIfp9qZJdFJWNFmss069bhesZM96ol
 FTn/8GvrWDEu5+bHutPBkshGlktHYT5jMhZ8379p8+EkuCWQMOc6MdADKGmh73I5e1T4
 kpyoj/pXyEIa1eWRBsGagt4hzpguZnHDQfnu5Ox4G30qKYqG1c7726YNYoiZAMCsbHx+
 UsdtWIhF8l5pPZuMd6lEIH18OCK8bODa99UZ9lAWjxO28Ufc/fK1xolRE7z/Th/kYSiC
 cI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747241406; x=1747846206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ftifFUtawtU70JBQxY86KdqzY76jF1UryKbSrTds91I=;
 b=kKlGU1x/Af/H30Lva3GZ+PjksHJN8oH7naexJvCkC1wuO6Hw1csVurD56310cTxjNY
 LPMaFBk7+Z1+kuxZM2As+B3E9KkR2NaTS3VTY+g6pABtd6XbtAsNI5ZC7hX5T/aYts4p
 8wep9CJJSFke0TfjBCWXeGiDjfM6YHjBwL8yfn4IvEKLP+M5QrpnLCH+3DhAB48HXZjo
 aRHrg2/sa35b9KNzGA8C4v/ias+7dFIK8h1xDs1pwQGYFZKh4nzU9zUAQ8ukJbOLJein
 b95Gc3uUFdfhqXYJ7acw4mMTWgmhH069RyS2d4cNDQ7zbMC5ga9R7tYSEjapvCK1fiv7
 4Hnw==
X-Gm-Message-State: AOJu0YzzyrzKicYzJZbvIjvAq7PHnthJxrVbffiRoJTmzpJcNnOac1iv
 u/TCyxkT4VvLiGdoUA73wQ6GIGSFpE+Albnz9PiraXPCQLImrzyOZIY9fsHvAew=
X-Gm-Gg: ASbGncu+ZgRvQfs4N1SKpydM0PwVwtS/H1Se5XdAHa2cK73ZoSf1jfD2n6pS7iBK09K
 uclANCXoJNZkcmMAFerMm8hJAMoqSUmLiiYM6h90D8OrygGGk2NdiJWeIlmcF3W2OWWtsXshHcW
 0+vR5WJvq9P8UluO1Yxf5/7MrF/kBNeA+qXlhDA2Iavuasci5DdxbJC6hboQu0LdysacNr7KteT
 3MgbgImO0kvcbu6xgiAvlXGnYy38yuyJ03BfsbkH75zun+Vke/emrAnFweQ/2wxylIxGRL2AsiE
 84iBhHpLqpCv/UQbOPMjgVRUju1erxTuw2yHl23EKg5VmC+9dF6/WQn+Z/U6F444oeqFba5/cF4
 =
X-Google-Smtp-Source: AGHT+IFWC/OT0z+b2lyDUElnGL8TNfTtK+wyh2J4J9GmcBMrPez+B8F9F8zs2+/z4EvugXMAyjDTow==
X-Received: by 2002:a17:902:f70e:b0:224:1001:677c with SMTP id
 d9443c01a7336-231981164fdmr58797525ad.9.1747241405709; 
 Wed, 14 May 2025 09:50:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc75477fesm101147885ad.17.2025.05.14.09.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:50:05 -0700 (PDT)
Message-ID: <c2c906c8-e516-4229-8d62-ec673753c3dd@linaro.org>
Date: Wed, 14 May 2025 09:50:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, berrange@redhat.com, thuth@redhat.com,
 Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
 <87h61n8eta.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87h61n8eta.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 5/14/25 7:09 AM, Markus Armbruster wrote:
> Fails to build:
> 
>          /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-machine-target.c.o: in function `qmp_marshal_query_cpu_model_comparison':
>          /work/armbru/qemu/bld-x86/qapi/qapi-commands-machine-target.c:66:(.text+0x10c9): undefined reference to `qmp_query_cpu_model_comparison'
>          /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-machine-target.c.o: in function `qmp_marshal_query_cpu_model_baseline':
>          /work/armbru/qemu/bld-x86/qapi/qapi-commands-machine-target.c:131:(.text+0x143c): undefined reference to `qmp_query_cpu_model_baseline'
>          /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-machine-target.c.o: in function `qmp_marshal_set_cpu_topology':
>          /work/armbru/qemu/bld-x86/qapi/qapi-commands-machine-target.c:306:(.text+0x1de1): undefined reference to `qmp_set_cpu_topology'
>          /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-machine-target.c.o: in function `qmp_marshal_query_s390x_cpu_polarization':
>          /work/armbru/qemu/bld-x86/qapi/qapi-commands-machine-target.c:362:(.text+0x20c6): undefined reference to `qmp_query_s390x_cpu_polarization'
>          /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-misc-target.c.o: in function `qmp_marshal_query_gic_capabilities':
>          /work/armbru/qemu/bld-x86/qapi/qapi-commands-misc-target.c:393:(.text+0x2d2d): undefined reference to `qmp_query_gic_capabilities'
>          collect2: error: ld returned 1 exit status
> 
> The next commit fixes it.  It then fails tests:
> 

Oops indeed, I wrongly ordered this when rebasing (stubs should come first).

>      stdout:
>      --- /work/armbru/qemu/bld-x86/../tests/qapi-schema/unknown-expr-key.err
>      +++
>      @@ -1,3 +1,3 @@
>       unknown-expr-key.json: In struct 'Bar':
>       unknown-expr-key.json:2: struct has unknown keys 'bogus', 'phony'
>      -Valid keys are 'base', 'data', 'features', 'if', 'struct'.
>      +Valid keys are 'base', 'data', 'features', 'if', 'runtime_if', 'struct'.
>      stderr:
>      unknown-expr-key FAIL
> 
> Fixup:
> 
> diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/unknown-expr-key.err
> index f2538e3ce7..8184f3c768 100644
> --- a/tests/qapi-schema/unknown-expr-key.err
> +++ b/tests/qapi-schema/unknown-expr-key.err
> @@ -1,3 +1,3 @@
>   unknown-expr-key.json: In struct 'Bar':
>   unknown-expr-key.json:2: struct has unknown keys 'bogus', 'phony'
> -Valid keys are 'base', 'data', 'features', 'if', 'struct'.
> +Valid keys are 'base', 'data', 'features', 'if', 'runtime_if', 'struct'.
> 

Yes, I noticed this test failure, but as mentioned in cover letter, I 
let tests and doc out of the scope of this series.

