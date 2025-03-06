Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFB0C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 12:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqAJp-0004hL-8b; Thu, 06 Mar 2025 07:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqAJm-0004g6-Pz
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:27:14 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqAJk-0004we-Q0
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:27:14 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac21c5d0ea0so74827966b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741264031; x=1741868831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uywctsa4YD0Q6N59/rve/Yt7Zjyk6Nhk26U0WfvFJPM=;
 b=eELJCANXaDXimmqy1aKKokRCfbNPo7JEpTbOI++dzv5UxGmHYOLly8T8gshseXCYQc
 Wb5+7xmWPoY/Bq75dnurtaDojByxPgUwQKrh+Vsq6OmasEcNl2JcZ0w9lfiTr2NA+GMX
 1AlziT8oy7rhTGDNnBvnqStdl1N5Qdl0Jnp+5qddDchLpOnQQS30dcWgu4SL3E07/NMt
 xoZG1eQt+GtK2VPkooZMsC2UQ9GavFDyyD6Y6MofEmQGxpStw/5NYWLe+oztX77GWSrg
 +eTUoaE2QA7IxNTDukcxUZACP1IS7YVBpLIizE2rkmOJZyc7ArehTe5Se2aIQDAI6+7C
 P21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741264031; x=1741868831;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uywctsa4YD0Q6N59/rve/Yt7Zjyk6Nhk26U0WfvFJPM=;
 b=YQ/88Oj0dHfSVQ62EEZ803Al2V/3EEgLvZDdXy1No/l+Fyw6ZsaTk6iGfK/1ucVDKy
 j42FITJB/cL9D7/h0JqlNH0Bwvy3sUXo93FmV8kbP4C+QfsV7PAc8uTFe9yyftrIiYQd
 pBymUGDDWXmiAkCswyas8fl2vdLAlecPFjt1O4wVjNlzwX5nP7xISJMVn3mQsqDUeKpg
 sEbXji4skUMOx9gcpRZcDOBs7PyFkdkoRmOaDXL0a7II3GDjb89zyONj/QMLO6zVwM7B
 bnEnnV5ooXMBK5kYXVfLCLR8NP5DKVYSfuyktHnKOuriN/MPzEJTayNxYJFFLwAPokKe
 qcxQ==
X-Gm-Message-State: AOJu0YzcdLIhXiBJeO0wwZ9RXxBD9FmTGhXxEPqxofQcQ5naad89RUfW
 yHEZm6sbq+vSVOIPO9u39WPNfAPILkXe4lG0fUeF+ev/nwsqjQO85fb8m55bCL0=
X-Gm-Gg: ASbGncseVOw7YTk+Yu3KoR7Wnf4NZw+OA1/Y5TPVSEHNeHyKdRT7aajn30GHVIijmza
 ntmtsvJaLyszsQerZwJlGf3bFZxr72r5wJcsn5pW0OcKWXeBX3Ilx2b6F8nhke6GGo3nBcwwzYL
 +HUAyr9uFqE62gYnFdeJQomlu8D5gtS7hLXgsmV7ZVQsdloN+Scru9zE6EEztmnMnd8FjXp6+js
 VNjAQuPVZy4oTH/AugXMSSMkUy5f8pQVfWvOa/Mr50/6lUxe/VJ+dzmCaCZi4n0/WaCPdnpas9w
 xsVazE0zy049blnv7DRVh77CwuHFJla/5m5uh4ksZFyOe1c=
X-Google-Smtp-Source: AGHT+IFpscY/rWMvlVBbyX7isuNDnwxpP05cG0XH/ClvjNHRmnzxornZo7dhMEptxV7deOMEZqJ6eg==
X-Received: by 2002:a05:6402:13cd:b0:5dc:74fd:abf1 with SMTP id
 4fb4d7f45d1cf-5e59f3ee29amr16513660a12.15.1741264029258; 
 Thu, 06 Mar 2025 04:27:09 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac239488be1sm89025766b.74.2025.03.06.04.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 04:27:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF6E85F9CF;
 Thu,  6 Mar 2025 12:27:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  kvm@vger.kernel.org,  philmd@linaro.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  manos.pitsidianakis@linaro.org,  "Maciej
 S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org,  Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 2/7] hw/hyperv/hyperv.h: header cleanup
In-Reply-To: <20250306064118.3879213-3-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 5 Mar 2025 22:41:13 -0800")
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-3-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 06 Mar 2025 12:27:07 +0000
Message-ID: <871pva4a5g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  include/hw/hyperv/hyperv.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
> index d717b4e13d4..c6f7039447f 100644
> --- a/include/hw/hyperv/hyperv.h
> +++ b/include/hw/hyperv/hyperv.h
> @@ -10,7 +10,9 @@
>  #ifndef HW_HYPERV_HYPERV_H
>  #define HW_HYPERV_HYPERV_H
>=20=20
> -#include "cpu-qom.h"
> +#include "qemu/osdep.h"

We shouldn't need to include osdep.h in headers, indeed style says:

  Do not include "qemu/osdep.h" from header files since the .c file will ha=
ve
  already included it.

> +#include "exec/hwaddr.h"
> +#include "hw/core/cpu.h"
>  #include "hw/hyperv/hyperv-proto.h"
>=20=20
>  typedef struct HvSintRoute HvSintRoute;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

