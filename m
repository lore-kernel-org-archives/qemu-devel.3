Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F35CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNzi-00056e-34; Mon, 11 May 2026 06:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNzZ-00054p-CV
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:36:07 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNzW-0005ba-BT
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:36:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d75312379so3270594f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778495759; x=1779100559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PuQmuzzhy2i6oWR9R1bbGX789ZrNDOMvxXnpc8PS91I=;
 b=zuHc8B3r3lvms5gZHVPn8+6C3vl+5ynkOKqzWkjurgp78Tkb06WxD+RvkY/lVxxLuq
 Sy7mZAl6jfkZBiSg2SOztnfNeGFL22q1ehjJLh7y0eOnZ8Hhq7mIVpcuLo+syWp8elYB
 UW0hEaagnTvQBh9LCKcsQncC0IHQZ7+d5Rn1d9CnBdE0IhSvREU8YDYY9Ob8oJnOUjSh
 K1VwLZYeUZGcmlPrNTaXh0UEWOBVyAurU7BsQ0I+WoB5bJMIJqXKfHjU3ljh2U2AO2gc
 S3LFsjmxph20vnA/ZRaG2mYRqvmi2uMvA3aPuP9z5fwPgxaDI7W5atmKssRYcbhshFyM
 M20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778495759; x=1779100559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuQmuzzhy2i6oWR9R1bbGX789ZrNDOMvxXnpc8PS91I=;
 b=fhWUBhETwApDJ7jdrm4ZfWXHrODxvKGJvXs39m8kLPXlKDzvZU/y3ywfJ9L4dgQvVw
 gfCxczSJD8IEKvPUMhBZok1NVcwRFshI0NzkK9FhjHbixzZNlWRcwFO1fzJvDpkAfUZP
 HJw8AOWB4TM+Z5f+q8IIBQDWvMnCE5pyVTEh7uzbwTNBatpSCt2F0Mgy2P7ZTPf4d1kl
 UuFdy4kUjgHl+ZYVEgzq4LoSMYqRwlNpdC9PGBiuLZi948LDt5HT4d4U4lwdLQ1kTntR
 YErmpwpuWggnc6X/PsOLpGg2160RIrzGwDX89RM9tDiY2U8MLAwk5ezkYgwRboZXLBkD
 0dZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ80fvw5d4gqMMM8uJid1So3QZuykgO145FzFYqw5Mu2nok3A7a7LRKB/GJ+KrGc8ajRumgGw2K+xqiA@nongnu.org
X-Gm-Message-State: AOJu0Yx9+FLq8PYP607+RFMUFuiPUsPqtHhoF3J4R5g95y35VUGzRm/y
 mOj4S67GO5/NWCVArd+uymeexl1vBfZjR6gWLxiLNTyBGB5LHNWUTOUjHu5Yf0UF778=
X-Gm-Gg: Acq92OEz4S++wJj1wjyJg54mD8QuGzSSBstogy2/isvXpG1/FTteDYfnV2ElH4/bIG/
 FDTU4kFvrVkMBLnV7gw7azvCeNBpFIj8vKTUbkLmpvzvfYAqdBt0ZodTnW9s4+lcHINgFpOCdlH
 hf+Wt51tpVLtjv788hdEvdiWE75dJ2wMnS2g7n/yHUWFub+w74Mbn5tgQDkj/vKf3BnaEBEdwc6
 X1au5D189NMREBsag7gklOaUG2ulWMEhpxtLOUnm+g8kyciH/o/UfQZLL4zpwdaA4Y903bRYHhB
 cuPIp+TO1PtQZZJ127uao4vuq1VlL7G8xFvV7b8Rf484r113Zq4JATiuQbh17wlWXuC3gRM4nbN
 nlw5v8eQg7UCniwREA6VIf6yc5bemQArgWjdlxw+OBAhT3VwEIzib3NTpDIDHX3fZl8ljxVvvqw
 5yjRs02cvqoKFO8PTmLmc02ZZdTerZZOL3f/sAv+jr0ttc0DarmZH4OcXtU/z3N9g97uGuFb3Lz
 pwQ
X-Received: by 2002:a5d:5707:0:b0:43d:799c:b2cb with SMTP id
 ffacd0b85a97d-452ea1743b7mr19155556f8f.24.1778495758700; 
 Mon, 11 May 2026 03:35:58 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549217b782sm21941862f8f.35.2026.05.11.03.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:35:58 -0700 (PDT)
Message-ID: <b3acf8bc-7ac1-4b4d-b7a4-4848b58ec51d@linaro.org>
Date: Mon, 11 May 2026 12:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] qom: validate ID format when creating objects
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260508112429.643360-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 8/5/26 13:24, Daniel P. Berrangé wrote:
> The object_new_with_props/propv methods failed to validate the ID string
> format, thus diverging from user_creatable_add_type.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qom/object.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 9c391071fb..62d2f0486a 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -24,6 +24,8 @@
>   #include "qapi/forward-visitor.h"
>   #include "qapi/qapi-builtin-visit.h"
>   #include "qobject/qjson.h"
> +#include "qemu/id.h"
> +#include "qapi/qmp/qerror.h"
>   #include "trace.h"
>   
>   /* TODO: replace QObject with a simpler visitor to avoid a dependency
> @@ -764,6 +766,13 @@ Object *object_new_with_propv(const char *typename,
>       ObjectClass *klass;
>       UserCreatable *uc;
>   
> +    if (id != NULL && !id_wellformed(id)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identifier");
> +        error_append_hint(errp, "Identifiers consist of letters, digits, "
> +                          "'-', '.', '_', starting with a letter.\n");
> +        return NULL;
> +    }

Use a common object_identifier_is_well_formed() helper?

> +
>       klass = object_class_by_name(typename);
>       if (!klass) {
>           error_setg(errp, "invalid object type: %s", typename);


