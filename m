Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B25C02192
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 04:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td06s-0002al-Ub; Tue, 28 Jan 2025 23:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1td06o-0002Zw-Be
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 23:55:26 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1td06l-00021C-Hf
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 23:55:25 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166360285dso108886035ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 20:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738126522; x=1738731322;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/IFeUQjMu1pqweZZ2zI+5/tYS9SLCsGUkfUbrwEx0iA=;
 b=piZ+EAU0rTL6iFbtmYEGplu5lUTiHkb+S2ITRRoFCc6YffEt4LH/3OhDE21RD4/i85
 O/ue9JbSxkHNBLhxoKnlnhsd0Yn4tXn/tUPEq25RhJeqNK/5HOTNWlG5/eExAgiMILfE
 RTxlFEmCoWFgOTytKyj4qxXkJhMDVqn5Shy9uGJo4L/jPFmtwWuy13RRSfkYsyEMxgm2
 MaYZNoGIb2jwnxLrdDgxtXkbMEQI+ovWew0vM/3XF9VXFOhW777kJi2N2SkL9TjYUmK/
 9NGIllyAAM0d0+AjToIlSTmN628rKn8S332R71C77u5VvJe/Yd4UVhocQZ0m4sY9rdvT
 1kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738126522; x=1738731322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/IFeUQjMu1pqweZZ2zI+5/tYS9SLCsGUkfUbrwEx0iA=;
 b=EUockREqYXV5Hp4fLVg2ileG1RzuS/ei7YRNyKkE+NHKIG/fnIX82q0iiWYiuXLgpU
 KZq0tM18GGTV3Tgvub4zzFpkBSOVNPNpdNvPPSYjjE3SIZrSWMFliyYro35l9fv5WqcY
 GRnDmDST3lziw113PXTkg40EM3XabPyaV+Pidr//F4VyMZLIIV40I4n+6K76C9U8s2PB
 GmYBk9yI5s3txsH8mU8gob9NUq/SPusXgGvMimzb0HC0K+pPzGEp4CpTPn0bvBPiCpGn
 rKDyYvYh4EliGKPuJ7uPhs88sODaUylhdGZyHyaiDaG+iVz2uk+Se6EZQ7JEz0hzWBxx
 Hupw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfEqXMcs72EbPG8GdLu/13ouXb1LbxIUmmqbfoLURwLvYJdItwL+D0NCv5DOvR1ISvs5xVxepDR11e@nongnu.org
X-Gm-Message-State: AOJu0YxwuLK7tk5pPH1dMN0S63iVdH8af4i25yLfE3MDCmQnwVwdTN97
 ECxQKUB9VLhW6z8dshqurss2LesYFjqaJ+Az/tuA3CtIH6R/FKIGyMd5teDrlvg=
X-Gm-Gg: ASbGnculJH69DVwebxqODQIpvVfRIxbEpT+lwzsZL7yrunH1lhjG5+99BTebmW7vptE
 I5P0EbFpiBlO3NYN28XYWjwuKANJl9oHFs+4kr83Y6lXnIFnJ9YwXHaiZhrClWvTnMfsG33NDQw
 hwMA6KdTqLxwu9DD0/gYquctUDkXY0c5KFk5yl9rXKjqp7TQ39voD652Ld8a6fEaaQP5lXMrju8
 TrvrOMZOY2AH1EJSwNFFtCJQ38j/Uc+8cL1V2m7R6Q756T8L1zsj7VQFnKLFlfPMOdTUQnYAsZ8
 t+8267XARLmMUarabqlHIiS2C0z4
X-Google-Smtp-Source: AGHT+IE/ZkJCXSSPk6z1jArpZ1Lcz87un7Bm147NNNCD173L++5cdH5qki30oCucXAEB8021oAu+eQ==
X-Received: by 2002:a05:6a20:12d6:b0:1e1:ab51:f53e with SMTP id
 adf61e73a8af0-1ed7a5b66e1mr3007763637.5.1738126521875; 
 Tue, 28 Jan 2025 20:55:21 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a7609b5sm10625337b3a.107.2025.01.28.20.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 20:55:21 -0800 (PST)
Message-ID: <ddbacd27-d978-409b-be12-060f27cea9d6@daynix.com>
Date: Wed, 29 Jan 2025 13:55:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/qtest: Make qtest_has_accel() generic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128111821.93767-1-philmd@linaro.org>
 <20250128111821.93767-3-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250128111821.93767-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2025/01/28 20:18, Philippe Mathieu-Daudé wrote:
> Since commit b14a0b7469f ("accel: Use QOM classes for accel types")
> accelerators are registered as QOM objects. Use QOM as a generic
> API to query for available accelerators. This is in particular
> useful to query hardware accelerators such HFV, Xen or WHPX which
> otherwise have their definitions poisoned in "exec/poison.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/libqtest.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 7e9366ad6d5..3071dedeff6 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -30,6 +30,7 @@
>   
>   #include "libqtest.h"
>   #include "libqmp.h"
> +#include "qemu/accel.h"
>   #include "qemu/ctype.h"
>   #include "qemu/cutils.h"
>   #include "qemu/sockets.h"
> @@ -1030,13 +1031,10 @@ static bool qtest_qom_has_concrete_type(const char *parent_typename,
>   
>   bool qtest_has_accel(const char *accel_name)
>   {
> -    if (g_str_equal(accel_name, "tcg")) {
> -#if defined(CONFIG_TCG)
> -        return true;
> -#else
> -        return false;
> -#endif
> -    } else if (g_str_equal(accel_name, "kvm")) {
> +    static QList *list;
> +    g_autofree char *accel_type = NULL;
> +
> +    if (g_str_equal(accel_name, "kvm")) {
>           int i;
>           const char *arch = qtest_get_arch();
>           const char *targets[] = { CONFIG_KVM_TARGETS };
> @@ -1048,11 +1046,12 @@ bool qtest_has_accel(const char *accel_name)
>                   }
>               }
>           }
> -    } else {
> -        /* not implemented */
> -        g_assert_not_reached();
> +        return false;
>       }
> -    return false;
> +
> +    accel_type = g_strdup_printf("%s%s", accel_name, ACCEL_CLASS_SUFFIX);

g_strconcat() will make this a bit shorter.

> +
> +    return qtest_qom_has_concrete_type("accel", accel_type, &list);
>   }
>   
>   bool qtest_get_irq(QTestState *s, int num)


