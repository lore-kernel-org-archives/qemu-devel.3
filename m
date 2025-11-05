Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E196CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 12:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGcbs-00083t-ES; Wed, 05 Nov 2025 07:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGcbo-00083d-6a
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:27:28 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGcbl-0000Pt-S6
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:27:27 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b6d2f5c0e8eso1285918166b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 04:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762345644; x=1762950444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/T9CPSqCQhmupq7cY83REKfHSAjd8PICkHWn9i5MnY=;
 b=bN1LYutUYTQZC92YFKG/JszAIRzHzeCnEuThd9s63uZRuE6GkKv7eV2iTS0qfqfj5P
 nZbjeJdVin4GAJSvwWkFPPzeH1V/SPcZ5qgUsc+YGPNHCvJtB2BF+7vwROz0j2k2HhNB
 9zTiv+m2SHh774kteLWrnqeZAIXqUT/qDSRyJEWFOzGGare63PgqgOqTP0c995P7bo3f
 7aA2qBJ5fqAl8s9GPkEZHQ+bqgjHNhZmd2dLVlADV5pr1sC4P6WI3/HS+N+WW1wo0XoA
 wf6JElXMVUz6mZPqns9oZRysyC6AMP3OVB3GehIg+iybt85lqdEULnxeYf2+4jhnKanE
 JwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762345644; x=1762950444;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/T9CPSqCQhmupq7cY83REKfHSAjd8PICkHWn9i5MnY=;
 b=IuC/r8iZGunpt7k3deqgqJGTe//ZFaCc68guQQZZgesBAr2GCeOeAR8YYm/3Cojqrf
 cUVbAARmb7qDLFUB+LoNBO3aNvypyQOE5J4LsE2iqPHJULFgRF5+PjZo56jBxx+0dIor
 CgP6908J937NdvCEJf8acLz3ehPOB8qlldgUp0rCwcJXw1nlD4lcVDOeeoFsL79Ol9rF
 w7rEgteSdGgkbMlTUHF518QTLiwsKjlMsIMP8+GWBy1OgLgveaiU7wA9FUVWg0eVdtiB
 1HWXIo+FOdsK9d2dEnXGH2Y4jXCx5nr7TVlT3byW/ab2yhsP2TRCpMN9KS1lsA79idGW
 vxHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXngygXNbgcy9WQ8FitxZSZ1KzDzw1UvXxafPf1mSPFtlqXbp9z1L0TQ2JIhB7k/o+7VNOCPm9NV6zA@nongnu.org
X-Gm-Message-State: AOJu0Yyey1cafpMmvYHeQn15vEnx8lwtyYvH0n6R77bVFRTucqayLCbv
 DKTXriKgHWO6Qof8weDeneTglcjBuWUlFUk/XquomIuC29hVWvB7ehJMKRWzqem53JM=
X-Gm-Gg: ASbGncsBYuZ7MfWejC1WxTUOBWjwK2B7X7qFm7ccTXzI38bIWQdfoW8WmDYbK+oFGxW
 bHKFG1S1FvAXLlo09po2mS1K/hsSCpGjLswZmjVF54ka7NdVw5TA6KaxI8TRhHB3J9UvTONu75D
 Ibjk08/2BXA5By0XRgma5b/qeYw0GWRMt+jZMZVVXp29CXF+pGSQubOBtOjnaY2uMZIxxZW8wcs
 kt8Pzsabcwxubc72qfOkvp7m6D1n6S0MbXuDQ0C53PqSEdyPqUva6SBKGU1zJ0oR0gqDylCeCt+
 kd0aluVplbZm579w2TdinBsPpozgxTscdrtO4QnohlQPKoT8KP34xaszKP/73crGbjkDPq3T5OK
 yQYglL+DTEpTlj1wo+VD1y+qxFGiuBtdRp+F/G9WR9p8A8nqS0F9Tytt+W4cj5rncOVzofsi51V
 9e8tddYsRjbZufHbxlTPzvVBI2xwE=
X-Google-Smtp-Source: AGHT+IEBhCXb2MU4lXweDIAHJuPhC/VWXIfohWcjtw9nuUBrfG2iDuiMJq2NRt5NISwDbrcPkjX5GQ==
X-Received: by 2002:a17:907:3fa5:b0:b72:614a:ab51 with SMTP id
 a640c23a62f3a-b7265298452mr326699166b.18.1762345643726; 
 Wed, 05 Nov 2025 04:27:23 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fa0828dsm473743466b.50.2025.11.05.04.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 04:27:23 -0800 (PST)
Message-ID: <e03bb90c-26ea-4471-b792-89b01adaefd0@linaro.org>
Date: Wed, 5 Nov 2025 13:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/36] migration/qmp: Update "resume" flag doc in "migrate"
 command
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
 <20251103210625.3689448-14-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103210625.3689448-14-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

On 11/3/25 22:06, Peter Xu wrote:
> It wasn't obvious how the resume flag should be used when staring at the
> QAPI doc.  Enrich it to be crystal clear.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Link: https://lore.kernel.org/r/20251022190425.2730441-1-peterx@redhat.com
> [peterx: amended wordings, per markus]
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   qapi/migration.json | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index be0f3fcc12..c7a6737cc1 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1732,7 +1732,10 @@
>   # @detach: this argument exists only for compatibility reasons and is
>   #     ignored by QEMU
>   #
> -# @resume: resume one paused migration, default "off".  (since 3.0)
> +# @resume: when set, use the new uri/channels specified to resume paused
> +#     postcopy migration.  This flag should only be used if the previous
> +#     postcopy migration was interrupted.  The command will fail unless
> +#     migration is in "postcopy-paused" state.  (default: false, since 3.0)
>   #
>   # Features:
>   #

Grr.  I interrupted myself last night and didn't complete all my pre-merge testing, so 
this has been merged with a regression:

/home/rth/qemu/bld-pub/pyvenv/bin/python3 /home/rth/qemu/publish/scripts/qapi-gen.py -o 
qapi -b ../publish/qapi/qapi-schema.json
In file included from ../publish/qapi/qapi-schema.json:53:
../publish/qapi/migration.json:1750:1: documentation line longer than 70 characters



r~

