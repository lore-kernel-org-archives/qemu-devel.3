Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12577C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEncM-000747-1o; Tue, 13 May 2025 07:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEncH-0006va-Hv
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:16:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEncF-0006oB-SO
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:16:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so62247185e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747134966; x=1747739766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9j+grCFN2YLTvFGeoAhWMRZ/PDA3UQbbHpvz0Ebxvpo=;
 b=jkuVbq09hWA9SK0ie/DjaeSmatK5w9JyU9jHIlO0Y+8zPjnO8WoMCt3vBjrobDlk9J
 lraevGF/iOMdPGpi4zIdHQnKT0LL8jZPMeeKM1ih6xOz15N/TFsQ+tVz9viOQcfwsGdT
 dSHMn3ODsU41AqRzRuS4HHp841+GraPYVHI7PB+1GJQ/+mtud8pTX3jF7iliaqHXl79p
 jpvI9jx6B79tq9uMudkvUC7cx8UFNfY98l5xKuFKYrsRRgocosvfu1TyR41/R3GfEWCJ
 i4PzAjvRE/hs5wYQG6UTH6W+MO1RD1NVDc6xd91ZmqUMpmfEZb1QzIjKIfpkIfUKe7oQ
 BH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134966; x=1747739766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9j+grCFN2YLTvFGeoAhWMRZ/PDA3UQbbHpvz0Ebxvpo=;
 b=i35bNF/Y4oXZwhSeiIaTmF/aKzK7YHRbpg9u2Cb+m9ZKrMCtvOAljKDSVrLJmEtU2j
 B1c5mrZpSN9DiqpnZXbMldJmFo1RA4J/23NbaimA7lBv8zXgwcTbyFw3yhMaC6HRIM4Q
 rm6vKMasPJwtoeEeFARBJFAgtaynto6qOVIPMH2vYs4oBvyJqpD5qssJWo1HFid7yycJ
 JR6TZ++A+5So7KSfZDX5KrdnGbjPAqAH+mB7XaW6msmoChp9pXIuwp0nfgUQ6KyI0/7s
 6DG3Sk4cPOwXJ314bWYudsx3L5xHzQoUpxUSEE0GZm37SH9kzf63FaurY9EHPgzXZe95
 bs+Q==
X-Gm-Message-State: AOJu0YwQ++4+RcR0JqFJcyXVzodud/IFM86weHoKZoGEyKCXH2xzk2XI
 HYljp8Evg62nftrX1hLryvO51PY1AW8ma9892wQixarglOMiCdtlhsRbTgiWq0w=
X-Gm-Gg: ASbGncuT6uIYOWE80PAXPa2MCiYVZ2sdgnhZlFplOrYLFA0Knmgcl4tlSksU6GW11MW
 K2YgvZPQBiSRpjup4F26eqop0KWQNYqbLsBzESwZw4FrCbOQRgtyaKsvPCDHixzpx7TkG7fnWre
 lp9SPq+0W4FDEXFAk7RxjL9xlNfxDy1PU0GRLk95V8sjyziu+f0S9cG7vZ97FzGbLyJH+l7061t
 4SKxIn+krxyIKq3ogDetpeAjIciGclGdFhZyt0fH6fHRxyJwfUUJRKvmV2jqQALD4Awdns++wVS
 NEAPupgrCiZlLxyh2w3E6hDhL5clVF4dfaqFaLTixz+khPNoDe0CCbMNSYh7Wt77aMOXY4S/Lvj
 JChzxfaY+2uvl
X-Google-Smtp-Source: AGHT+IGmD7d/jAN7Fjk8DsSW+LYm+ArV9QCgUlEqxO57dl4eJZyrAtkDcMuM0nM46wnmIMBrZkwfJA==
X-Received: by 2002:a05:600c:37cd:b0:43d:fa59:be38 with SMTP id
 5b1f17b1804b1-442d6ddf676mr124720185e9.32.1747134966150; 
 Tue, 13 May 2025 04:16:06 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebdc362fsm16637015e9.1.2025.05.13.04.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 04:16:05 -0700 (PDT)
Message-ID: <a06e389a-1d72-4f33-bae6-7b13c0ac6612@linaro.org>
Date: Tue, 13 May 2025 12:16:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ui/vnc.c: replace big endian flag with byte order
 value
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20250513100819.1179249-1-berrange@redhat.com>
 <20250513100819.1179249-2-berrange@redhat.com>
 <6c9f7141-8b2e-4b58-9ade-134a7289cff6@linaro.org>
 <caf9f1e2-fe92-48bb-92d9-17e5a5f61476@linaro.org>
 <aCMpU_n2GK1_a8UJ@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aCMpU_n2GK1_a8UJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 13/5/25 13:13, Daniel P. Berrangé wrote:
> On Tue, May 13, 2025 at 12:11:05PM +0100, Philippe Mathieu-Daudé wrote:
>> On 13/5/25 13:08, Philippe Mathieu-Daudé wrote:
>>> On 13/5/25 12:08, Daniel P. Berrangé wrote:
>>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>>
>>>> It will make it easier to do certain comparisons in future if we
>>>> store G_BIG_ENDIAN/G_LITTLE_ENDIAN directly, instead of a boolean
>>>> flag.
>>>>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> ---
>>>>    ui/vnc-enc-tight.c | 2 +-
>>>>    ui/vnc-enc-zrle.c  | 2 +-
>>>>    ui/vnc-jobs.c      | 2 +-
>>>>    ui/vnc.c           | 6 +++---
>>>>    ui/vnc.h           | 2 +-
>>>>    5 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>>
>>>> diff --git a/ui/vnc.h b/ui/vnc.h
>>>> index acc53a2cc1..f2a627dcdf 100644
>>>> --- a/ui/vnc.h
>>>> +++ b/ui/vnc.h
>>>> @@ -323,7 +323,7 @@ struct VncState
>>>>        VncWritePixels *write_pixels;
>>>>        PixelFormat client_pf;
>>>>        pixman_format_code_t client_format;
>>>> -    bool client_be;
>>>> +    int client_bo; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */
>>
>> 'bo' = 'big order'?
> 
> bo == byte order.

Oh of course. Since no GLib endian enum, preferably:

   int client_bo; /* byte order: G_LITTLE_ENDIAN or G_BIG_ENDIAN */


