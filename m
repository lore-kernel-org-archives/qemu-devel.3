Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7348AFF8870
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSkg-00010z-U7; Mon, 27 Apr 2026 16:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSkf-00010H-7u
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:40:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSkd-0004ZU-Mn
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:40:20 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso76622855e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777322418; x=1777927218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KvxyMSLLP5ZEHJiyeXzosGyPu67kHiZZbZWHlrzmaSI=;
 b=tjN7Qm3WcH4FElMe3QSKTmCD3Cc2EyYEzCEr/9QVryxS90pJwJq3/+F8KyKTkfQcO6
 6kbbjpADADx8all1/P7cUkjd/PaEiZ/pZ7diaweprC2sRlQqVFHsvZ7Iz1yl1BSoFq+U
 QYe2xFbjerlJE6t0TsiFHynKfEoQpvXMrJQv16gvxoatU+UQDUZuIy0oedTYSWsfJh2p
 7ofPpbAPOUBUZkH63BGwA15QH/0YDIdD7S8a26HY6ilQFR/eBcY+dBRjr3K7/+K4sLxG
 imCIiMMlkWNjegx/TyzWhROHgoVCw3jUNTOkvZLXgtNi9AdN4tEhSKE+UREz9mPPQaf8
 xlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777322418; x=1777927218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvxyMSLLP5ZEHJiyeXzosGyPu67kHiZZbZWHlrzmaSI=;
 b=feJqPUoS1VAFuQ3nLAdjCMTDC65xayoRiSuR6nhym7llKZGVKa46kWDKOMBC4I0M3G
 wdrultLBONjzCC+Uqk5qdwvsgxgZAQR+la1zmHOoCMxsVnu+t/da47IQmQcwEqcZRDvj
 hQw0D5kUiPFwfKBmTF6SJ1IVBKWLaWQ8fHAmMw6mpGYFDruDlwr0G1hLA0LZikvbHdwM
 9d9rfLlqrHywcehDLv8kw/EUvIDEMFPE0iLLxxa+KVaLGpo7CIb0QaYT4zryMczR6eAS
 sqlCzhYTo99haiXSAZ+IBHakZ+lsDki0OUhv20cI8xictkoOeqbW3F7RVT+YOR0l8ql6
 1x/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iKHsSRJPWMYbooAM/5tYFv9O9Z+WPlcgv/vjrQ7R0s0mbbzrK0RsmyhJafVqrCAFKs7FUE7eEQmfv@nongnu.org
X-Gm-Message-State: AOJu0YwF9/QR3MIZYl/MwaDpHoZmK72zWwznEFr+iW5xBAZEM8aT7q+C
 dleGhWyjgBVptTBCT70CwKaR4wAes4c5fu+Jv4ISPYI4qLLEywPFQVZqbY7MvVR5L1s=
X-Gm-Gg: AeBDieuFTSyAyvPUFXmUSAIvu1mbN8wFGvcd5/RRt30pv3I904UOhUOl/B3eu1TS3kY
 OwywBQbvr6+ojT6wZMwH6Jg2V0tVuhztrUHnYAs0u9MCl6mKdeuizm0sFcwHFLUnBl9WZnVlHzA
 gL/BBhX0NBnRHjYE+y7DVgiKJDf6eqyoomT8BR3amf1+wJdafpTI0FQwNUviIgWHGb7IBZO/nph
 nuOXZn97BgmDD0xaMctTS5HuPbTUo6sNTLKb9zHIhblzHjapbZxa2XVlgYR49tQ4my3VL7dAV8e
 jjDIrJJBKKFR1dyOYe9csy/wVJKqjwvpKgmWpT5k/WSef/Q281n3Xywd6cb5Ay8Qr6KBvXBJnAJ
 sYJZGQjPnJ/+syAiqllNn40kXzIhWL9FvyQJ9Vgr9sD1fGfCWQxE1s+YWjLJJ2+hkin+SUenEM4
 97zhPYDvbutsMngAZE0A7kLHj7t8EYKYVI+4mpaG9y7KyQt5jUFRYIE0IzvoVpSEtOr5rzVwjjC
 lIg
X-Received: by 2002:a05:600c:4593:b0:48a:5574:3a48 with SMTP id
 5b1f17b1804b1-48a77b14722mr3846555e9.16.1777322417794; 
 Mon, 27 Apr 2026 13:40:17 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77af1b86sm4332385e9.5.2026.04.27.13.40.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:40:17 -0700 (PDT)
Message-ID: <9a8407d1-ce20-48a5-9975-4b08075e3768@linaro.org>
Date: Mon, 27 Apr 2026 22:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/41] hw/intc/apic: guard against NULL cpu in set_id
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-8-c413f3605311@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260427-qom-tests-v1-8-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/4/26 21:42, Marc-André Lureau wrote:
> apic_common_set_id() dereferences s->cpu to check for x2APIC support
> when the APIC ID is >= 255. On a standalone APIC object that has not
> been attached to a CPU, s->cpu is NULL, causing a segfault.
> 
> Add a NULL check before dereferencing. When there is no CPU, the
> x2APIC feature cannot be verified, so reject the large APIC ID.
> 
> Fixes: b5ee0468e9d2 ("apic: add support for x2APIC mode")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/intc/apic_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index bf4abc21d7b..874a05e529c 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -421,7 +421,7 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
>           return;
>       }

Could we check s->cpu earlier, i.e. on entry?

Or actually, why don't we use a link property checked once
in apic_common_realize()?

>   
> -    if (value >= 255 && !cpu_has_x2apic_feature(&s->cpu->env)) {
> +    if (value >= 255 && (!s->cpu || !cpu_has_x2apic_feature(&s->cpu->env))) {
>           error_setg(&local_err,
>                      "APIC ID %d requires x2APIC feature in CPU",
>                      value);
> 


