Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981DAD232ED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7va-0006XX-NC; Fri, 09 Jan 2026 03:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7vY-0006WA-Aj
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:33:00 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7vV-0001Mc-6b
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:32:59 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so41295265e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767947575; x=1768552375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JN95LlaYUC6jfSjGa6p7KMrkTRMmKV06EgoPVrwbnH8=;
 b=H6UpfUYk9TiZ3ujO8lDPfIoFIuisnStsuCoK3mfHz8TJWoMNg8yOwXl9MLLTdOjOOR
 zWI7v4TftBRWn6tcjho7mkW/gTeVwXTFR5SR+MzCNrTqziPubuA60dfXB4FPYEif175B
 Yvz4hHuFQJQPDXPXBp/iObmbLzDSIYMhtPTD7+CXWoSaY3sAkl0Q1bGmHzmFvDjBJVRF
 EW38FBj+JPQvrwYFd4K9eH+4Hl95PiSDtIucX/Inrm2BuO5fJGJ8DTGI3vP1QxEVBIVS
 QLW96eF36ra+QYbqDNQDiZSy8vIiv9k7sHXdYRlJ49oIn6JDMWa/GlrF+N3v9Fxeinam
 oipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767947575; x=1768552375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JN95LlaYUC6jfSjGa6p7KMrkTRMmKV06EgoPVrwbnH8=;
 b=b5n+71CeaiJCPfKbcs6esr6aInSBRUiTJ+y7VMGkjVG9FyUdsY6fhTgLRlL3K9N+J8
 6eNVL+yHN1XdUYDxcZ+grns/yP51scYBggli37ql1ocPXvtjeDrDDcuDdW7zDfWXlJ9E
 Wv8APGgoyJVXLKxtXXUu3+2CLGdrq8kWaxMB7X5Iqtr81GKSirbHBQcxRsn7RLv1Omyp
 6yudxSeS1zFTrS9zymiesGNZRa7jkzTPLFIheGOj2ebCLhipO/S18h5SGf1KOkvaX7Yv
 NQL0IQw2ECV83E7nBnEuUyAm9A2UUdoqlczGhJjKU1LA60xn5Ju7kvQSHqC+2QekHp2m
 n1VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUxE0ir/5Wov09PZ//eB8M+NrVPiK9ffBc2uThpf8Z2aFstlbdABAqjl9HB0Se3GVSggVJskjhnxJ4@nongnu.org
X-Gm-Message-State: AOJu0YxiIU7MVOPAG6ZHPDThoV70UuP9dRu3qw54DnTo0jH/W3NTbK7q
 cjbnuvdbzRAQ7cHK7PzUPSv/Xm+6wl8EgVAyHLxNYHeIhwxSL+BQ1B7rO6vEdQs70RE=
X-Gm-Gg: AY/fxX6+kh67uQYTHumyj5qCsW8kPDGXLVYVfRdx5NaKKy+Pndhyq2LgEPX4fWLEbsX
 BdIFigG9xVZSAAd7tJhMF2pmtpUPJ/JTkRvwii0s+rp1EDfCO35MOIMLBH2BHKdTohaMlj9S/xT
 qY9VlmMPUlPfQ9EJPMXRinG2PEOM48StI5c5HDGnSJLMN7GdtAoe6H9KiNUn6KJC2svx/aaVfJW
 BICigrn0mS57l2EpaRQ/aSFp4UHOy6eJco5E4qbzUB5y16kzYD3iQxuZ3nnoLZu75FNV1BF6jmz
 AncWvFlq3oQ/YZ0EPODvvAvH2yedgNXCHAeIYEZIn6rRTlhvPrvsMdfH8Ju1JJWJkP5DiOe8kFT
 mqjTrdqGpCIqCpqN5KeUDpgpntwJYeEbZeLz86KMnjkeli6SdfmmtGtrqyBfKswUiNiE8GDOeQT
 lB3M/voa3SkRxUVddtZIkACBUTcR/ua2petU1Q0DOfj+VskdnIadqL3QL6QszZcRzU
X-Google-Smtp-Source: AGHT+IErpsRFEP8wi2dxqYKhvpC0zX2AsOIvMYNCm7t2wVdF2UtTVTr46QCWy7Qhbu5EXNgdTV97fQ==
X-Received: by 2002:a05:600c:3556:b0:477:7b72:bf9a with SMTP id
 5b1f17b1804b1-47d84b3b8c4mr102722745e9.28.1767947575158; 
 Fri, 09 Jan 2026 00:32:55 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm21152344f8f.19.2026.01.09.00.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:32:54 -0800 (PST)
Message-ID: <9678ac55-13f7-497c-92c1-3035593251f5@linaro.org>
Date: Fri, 9 Jan 2026 09:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] system: Convert qemu_arch_available() to TargetInfo API
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260108163601.18676-1-philmd@linaro.org>
 <f089c7c9-c00f-4c19-b4b5-175873fd8c1e@linaro.org>
 <341da906-68c9-44e9-929b-30760883178e@linaro.org>
 <0e4437cd-0e4d-4e5b-9aac-c882ef1e9214@linaro.org>
 <d8792a35-340b-4a5b-8349-42ee3d050b2a@linaro.org>
 <87ldi7mc6c.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ldi7mc6c.fsf@pond.sub.org>
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

On 9/1/26 09:18, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 9/1/26 07:58, Pierrick Bouvier wrote:
> 
> [...]
> 
>>> See my previous answer on v1, -Wswitch is used:
>>> Reading the thread above, the only mention I find is the 3rd commit that
>>> precisely change definition because -Wswitch is enabled with clang.
>>> And it's not only a clang thing, gcc has it in Wall also [1].
>>
>> Yes I read that, I'd really like we use -Wswitch but IIUC we can not,
>> so with that in mind I don't understand your request. Is that for the
>> hypothetical case we can use -Wswitch in the future? Sorry I'm not
>> trying to be picky here, I just fail to see the problem you raised :(
> 
> We *are* using -Wswitch.

Oh... I guess I meant -Wswitch-enum then (which forces to handle the
-- meaningless in that case -- QAPI foo__MAX enum values).

Anyway time to stop bikeshedding and call it a day (originally I just
wanted to remove the duplicated qemu_arch_available symbol :) ).

> To see that, delete the default: case in to_json()'s outer switch (patch
> appended), and compile:
> 
>      ../qobject/qjson.c: In function ‘to_json’:
>      ../qobject/qjson.c:154:5: warning: enumeration value ‘QTYPE_NONE’ not handled in switch [-Wswitch]
>        154 |     switch (qobject_type(obj)) {
>            |     ^~~~~~
>      ../qobject/qjson.c:154:5: warning: enumeration value ‘QTYPE__MAX’ not handled in switch [-Wswitch]
> 
> We run gcc -Wall, which implies -Wswitch.
> 
> [...]
> 
> 
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index c858dafb5e..6287c93c67 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -213,8 +213,6 @@ static void to_json(JSONWriter *writer, const char *name,
>           json_writer_bool(writer, name, qbool_get_bool(val));
>           break;
>       }
> -    default:
> -        abort();
>       }
>   }
>   
> 


