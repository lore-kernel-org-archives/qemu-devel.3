Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31053C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGZy-0007tc-4m; Tue, 08 Jul 2025 18:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGOE-00020x-2U
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 18:02:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGOC-0004ZE-2X
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 18:02:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so43374075e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752012129; x=1752616929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gypyUV1zEJlvjHKMKE4WvpYJ2muJvWwpp3t+miyRnww=;
 b=ge5p5tPgwlkgtm82yB3xsYI5/aN43LDp3nLJ2YvwhDplfQ5UJKUzs/jZbJTTgeKXM1
 CWQOt5l/kF16SyKhClM7LVEykPUKzdUiqHw4CWjP2+eqFHhBs6puA2L5cfe65JhEUKZC
 jSZRMhEQFOv8YDKOl37Fp85YKVQ/whVqtS8k51PrRrJE7ly1tZ2y4iC3Ds6BVSaUGtQ6
 VLKm4JocdOuVS4FDrT01MFJq84IxLGuXnT0IDJ0Vz66jLy2jD7yYK5NW6hdDHI8X2OOD
 khoYB7bP5MOEHKWCPlsyyT4QcdMofVImw25yhlObJJOv1DfabRCdy07aCa3nD3YiFnk2
 zcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752012129; x=1752616929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gypyUV1zEJlvjHKMKE4WvpYJ2muJvWwpp3t+miyRnww=;
 b=jdhKD+uDFft8yaAfkDgxVbO5u2fhV4bk03sD/e2S8+fDlWzAiT+kvN6ozQv7vyqhXI
 oriwgk5qCGEJqFcgk9GfI7WEonHWgTeRZgK82m/b7gyM6RylTeUiH2cTCo7VnXCFf8ip
 Ve77qF42BtK3EoTSElUwQgBeUzGPtN6XP+vI5K9UU2I7ePHbIreo8IoUk17ror+2ZE6G
 Dn/Nug46Ifd2X9bVnMMmjdjICMHjs91xzPoPQdJBpDGg6EqS3M/QyojcwBsCebn3zI+F
 zfM9LNcoDBkJkOrfN902kmM1TVtd9nKzGdN9h4k1edHWg/MpWEm0u7YIQTVxGK2HeF9I
 0l2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMriMrt9+7Lom2L8veJt525+nSuS3sb29qQxc5j20zaNh7828D+uV4DsvGtCnoV7OsOYYxp03qBkzP@nongnu.org
X-Gm-Message-State: AOJu0Yz0vA03fyha8jz+4bmp+m+gGeMHpeyZE0reZ4dRMwhYMKiS7nsJ
 qJa+e2ehV4aUeo3bukQKo4C3K1MmFe7N2Y5uzEY1kEbiot6IBy6ZA1kwpHqosLsNlp8=
X-Gm-Gg: ASbGncvZze8YhNiJQXKpm8G1RFZKAuf11ZzhrSInAAFb++5YFQ9nMiBi9ICYx7Th4VM
 wNNPiJjmS0lL0m2Dck17iXsQlgbBOIWutty+XMImd2qXVbp27ekILyfSWsHw6P273AaLyggXRZm
 hza1oSfxbgyWjcBFSqXTh9tj4ONF/4GUkK89JBqXL4MBroWPDxuzc/kVOxMb236tLaDKkVvPc/J
 8oMIUgPe9pDejOsj5TS7QZ/PTAT+mXmtBL+uD+E3rRlJHcG7lyDoHcOZZjAzugG8WQ4vUfISAh+
 S+NQ0Q9gpG5dUS/otbueg7Jtp9I83JD4wuXFiQMsDA9LIsN+dhu+vN4mNB49/Yu07lGa1G0qmZg
 1r2jkmurlka+BhIOfsZRvXfQCcn4u0wWTljD42JQ12EQ=
X-Google-Smtp-Source: AGHT+IEzf/lWKiD+9nrhuvSKc+BGD+DquwR1N4skWGHH2rCEQiHjlgy6V0YeKBUQgKwMKTd6bLgEEA==
X-Received: by 2002:a05:6000:470f:b0:3a5:3b63:58f0 with SMTP id
 ffacd0b85a97d-3b49701c86cmr12533525f8f.18.1752012129354; 
 Tue, 08 Jul 2025 15:02:09 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030cdf5sm13785745f8f.1.2025.07.08.15.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 15:02:08 -0700 (PDT)
Message-ID: <bdb92ceb-59d3-4e82-83f7-d4bde9b96583@linaro.org>
Date: Wed, 9 Jul 2025 00:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] tests/qtest/qom-test: unit test for qom-list-getv
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-4-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1751995472-211897-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Steve,

On 8/7/25 19:24, Steve Sistare wrote:
> Add a unit test for qom-list-getv.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   tests/qtest/qom-test.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 64 insertions(+)
> 
> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
> index 27d70bc..4defff1 100644
> --- a/tests/qtest/qom-test.c
> +++ b/tests/qtest/qom-test.c
> @@ -11,11 +11,72 @@
>   
>   #include "qobject/qdict.h"
>   #include "qobject/qlist.h"
> +#include "qobject/qstring.h"
>   #include "qemu/cutils.h"
>   #include "libqtest.h"
>   
>   static int verbosity_level;
>   
> +static void test_getv(QTestState *qts, QList *paths)
> +{
> +    QListEntry *entry, *prop_entry, *path_entry;
> +    g_autoptr(QDict) response = NULL;
> +    QDict *args = qdict_new();
> +    QDict *prop;
> +    QList *return_list;
> +
> +    if (verbosity_level >= 2) {

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

But I note this doesn't assert anything except if you use V=3 and
look at the output.

Maybe stick it to a particular machine and check for a particular
path and its properties?

> +        g_test_message("Obtaining properties for paths:");
> +        QLIST_FOREACH_ENTRY(paths, path_entry) {
> +            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
> +            g_test_message("  %s", qstring_get_str(qstr));
> +        }
> +    }
> +
> +    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));
> +    response = qtest_qmp(qts, "{ 'execute': 'qom-list-getv',"
> +                              "  'arguments': %p }", args);
> +    g_assert(response);
> +    g_assert(qdict_haskey(response, "return"));
> +    return_list = qobject_to(QList, qdict_get(response, "return"));
> +
> +    path_entry = QTAILQ_FIRST(&paths->head);
> +    QLIST_FOREACH_ENTRY(return_list, entry) {
> +        QDict *obj = qobject_to(QDict, qlist_entry_obj(entry));
> +        g_assert(qdict_haskey(obj, "properties"));
> +        QList *properties = qobject_to(QList, qdict_get(obj, "properties"));
> +        bool has_child = false;
> +
> +        QLIST_FOREACH_ENTRY(properties, prop_entry) {
> +            prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
> +            g_assert(qdict_haskey(prop, "name"));
> +            g_assert(qdict_haskey(prop, "type"));
> +            has_child |= strstart(qdict_get_str(prop, "type"), "child<", NULL);
> +        }
> +
> +        if (has_child) {
> +            /* build a list of child paths */
> +            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
> +            const char *path = qstring_get_str(qstr);
> +            g_autoptr(QList) child_paths = qlist_new();
> +
> +            QLIST_FOREACH_ENTRY(properties, prop_entry) {
> +                prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
> +                if (strstart(qdict_get_str(prop, "type"), "child<", NULL)) {
> +                    g_autofree char *child_path = g_strdup_printf(
> +                        "%s/%s", path, qdict_get_str(prop, "name"));
> +                    qlist_append_str(child_paths, child_path);
> +                }
> +            }
> +
> +            /* fetch props for all children with one qom-list-getv call */
> +            test_getv(qts, child_paths);
> +        }
> +
> +        path_entry = QTAILQ_NEXT(path_entry, next);
> +    }
> +}

