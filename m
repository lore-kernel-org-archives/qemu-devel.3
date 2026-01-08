Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923CCD1D495
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxJN-0004zg-78; Thu, 08 Jan 2026 16:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxJL-0004yp-MZ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:12:51 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxJE-0004pc-8T
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:12:46 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso3105842b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906762; x=1768511562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4VPeQ5fA7Ty2nS/1KU56X9qxCEWSPEC1IHVJxQDWZFk=;
 b=iPop6srDZwjJCpLTvoF8mh/km9tGyVz5/ruYWv7lGVim5+ZhtHQT2uGdpdujTHJCzb
 x2SLJn6VoHAYrFo6sMwQYiGTi67D1ZvjY48bZEOA6JdKcRwW+3I3WnKHW9hpPmiEEo2U
 ZbkaSZxbjSJIabkBVhYkfigu8yyd0663cdC6nQH35a/PoVz6FcVUJH6CEcuIQ/gi+aVj
 2DKG7L0Bv4rJYgym4dfq3ipOcVt+iIkdyeAQ7z6CvWHGBGUnPO41YKVNIcjr1KNV/Hjk
 KHtp22YlXuGaMYKVqsXqH7uHd27uqlfoqVNjJD9lbUzDLIavXJONp6JQI3JH9BjA3zvv
 827w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906762; x=1768511562;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4VPeQ5fA7Ty2nS/1KU56X9qxCEWSPEC1IHVJxQDWZFk=;
 b=vtU+Xs2JyaE25inL+pNPCe3EmNZBuOzr6F92MNxcEHQ6ydf6rhcSkRLr0pcPYYptIf
 I74yrrLFo8qWtC+CJAjndm7NgTitmRHWBLiX3X9ZtLucL5VcqlSLYYYJTe7XafYarHUe
 n5Eefq04Z0VP1p3hZgn80vv4I2l1WycW12ia5rOqf4pIhIZKtMnzMNubNVXZHkCRXFy3
 w14Ncu7OoeKwPC5Z+8gt2VMnn/t7TQ3f1b9A2MIkCjU5nSR6I0Ag0DjrlVtO9Uc7Zrr/
 Eap7cxT8gKtmsJy3ShLUYhoy9qCHD9UEJkKUbcRpWpwKwqZQwYE8+sv795RpFL466VxE
 HfwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDbPXLS99wVSZiNWnud43lpg+Gbdm41PCrzgY0aY0H2gyAmczkx3ruOpIqFFNCUqbQtkf/OidiR0KB@nongnu.org
X-Gm-Message-State: AOJu0Yyz47Zi3pd01VA+ZXybzud2LGL1CXkCsKVlMjsE6bEFvST8bObK
 LWCaXgVsbflAL0tK/UuQOeMJy0xuW9pqnzfpD9PoINZgiKDq+n2y6n5jdxwKSYpVl94=
X-Gm-Gg: AY/fxX6AfEXq6uh7B2r2frace3hQH7m2Xb7Mrz9wBZL5v8T74r9I4APJmuCA7crSy/1
 rca5PSl2zL00ptHzPJCKcjfClLcbYakPz4BmceES+XflSHFnacB8XiZbWGRKaWzX/eJFukQoPZ4
 AsICQ2QAQTR3MjboVGYsNeH+pExciVOZ0cMLmc3uYgyIPX11mRVNpoAJJEJfiIkGSea2HkmIb4D
 nWST1ji8fTK2LyDIb4PB7s+xuhX3SwiAMKObsFsNQVduNT9QB6fZbuLxcSjk6mvcNDfqfBEu+Nx
 c0ICtsDkPxn0FBaTkWm6njJXBi/O/5pJCF9RIhe04HY4TG+AtpeDNxC0ZHDZye5AUQoiKxuLHPZ
 mvNnES7VoYp5EH8OJNsCZFifE+YQ9rXJ+nGDTZUDZPiSjIliDbrcwftdvkuFIreHaUjB8BcoSrm
 H71YtO67iNsgsmZl/wmkCenh7eqtQfNeh+kez8hcVwaH0ASmdHHbeTt94g55WvwTZopIg=
X-Google-Smtp-Source: AGHT+IFF5UBVF8clD+QHVHKxbVejWm0nZj1vyGVszHqCaKsnjDWvBkXBjX9vZVS4pYY01I8pwN8Bcw==
X-Received: by 2002:a05:6a21:9984:b0:366:2447:6778 with SMTP id
 adf61e73a8af0-3898f9c3f0cmr7443803637.53.1767906761539; 
 Thu, 08 Jan 2026 13:12:41 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fb7442asm8705018a91.15.2026.01.08.13.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:12:41 -0800 (PST)
Message-ID: <46312dc8-2728-41f1-b972-ca5f1196724e@linaro.org>
Date: Thu, 8 Jan 2026 13:12:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/50] accel/tcg: Drop CONFIG_ATOMIC64 test from
 translator.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-39-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

