Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9D9CEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLG98-0001pS-Un; Tue, 18 Nov 2025 02:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLG8w-0001nJ-L3
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLG8u-00071Z-W3
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763450928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AUt4e6JBk/m1zYpdL5npjX7XJ0KGUdsr/kjIm1seML4=;
 b=YhbH3vWBu7KN8XjMxelhIdV0bnBEVnuQ80NdPCr7WLlm9f9Hl876fVYM4/xWDqdpmXqFRc
 3H7cZKGPOyFbnmkB3B+4L2zPeTIvSF1weFhMlh6bkfozkYW3CRWBiJ/Y337Ko+BCyLUtcq
 Fr/eaAY8jG4YgJX6Bcu29xtY+ZUHb/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-OhgALVpaPPGHTWlaG9kWYQ-1; Tue, 18 Nov 2025 02:28:44 -0500
X-MC-Unique: OhgALVpaPPGHTWlaG9kWYQ-1
X-Mimecast-MFC-AGG-ID: OhgALVpaPPGHTWlaG9kWYQ_1763450924
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47799717212so23232315e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 23:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763450924; x=1764055724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AUt4e6JBk/m1zYpdL5npjX7XJ0KGUdsr/kjIm1seML4=;
 b=kAmAyZU6hn917a3I8J/5IInldS6EaA0el5SFbEdf4Eg8EcxWvxgfUxcG/audmIkbEp
 G0fFW2P7SdLIt9CTASh4TZcNyd4XjgKqzrsJ+vU/4GShGYSxbnKRcaBBgjt/ly4D9il8
 I2AZt78goRHWZS+yxG/66zbPlbauA5IFNEEIIp8zBWuUS2D5R2I0t58ejKusAXQxLMkb
 8MJrFjF396V8ChJbE7pPmLDwseBAU2oJkAoh0X1U2fWY6wqjV8VxeSEl2ta8frMadaLv
 G/1/CO1BVo4MSINJgW9i4KSc3n1BHenmWq7GCMM21phnXF0W97JTAFKRM4DkNfFYB5Kp
 Rq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763450924; x=1764055724;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUt4e6JBk/m1zYpdL5npjX7XJ0KGUdsr/kjIm1seML4=;
 b=Aq+mgWipl8Pg1cFj46cayYBgaGQunYIxUqMGCj0VoAxRpZGHyOg+r0SSHnakMIXkQj
 ze54vNLNH9IBezRniV3wbWOR3rcFFoJxiYKLRgjWnIDAZaTb43n/cQ+Pc53tjtU+XzEm
 JStnHriEHhS8wdjMair5Iqr3UPL+LV/fQv0BFvW1ox1bFT4+HvRWKzbmqPKCZWObZkM0
 TPiSH5Pc4HIdkPeuNh4IvOQ2rcpM75Ymqu0KamZ8K4SE4y53ugRYTioN5F/YyGYEm+NI
 pmel4zpEnzVG3JI+9QSTb61U8LIlNqFgy8JALiVjHE5Zpe2uvEY6TddybWJBXdxD/pgE
 +eBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgzw1PVHgSVQJLtg30z0u3mH4l2ebRmO6vhIux2p1LwVF8MAS+SS1m7zoJLgs9e9jGNW8UTRWz/Jvj@nongnu.org
X-Gm-Message-State: AOJu0YyJrBbvPFsGMSbBLeSAeo51jli7lgDtGtOb8HFUA0tQFDBECTk2
 Zcd7SEwMmhFPQfOabOLpU2wQBYtYyKew2IF7t8x9Av/UAokjpBuEmaN98CCGvTOmyj+xrZ7RV15
 7NkbZuO6JqzvODIIyoZyH8e9QKjSvP6/Y87pHMf2VPHZ26id9wDLNJarG
X-Gm-Gg: ASbGncsyUKP/4FicHAVb2cuF15+PLMcbDN2dsp8LIdd+M11jIY/oHwbdidudlUfZxOs
 i0XWrOqNdIrLNapTDssBPuEJjhIBifyhxj7HC7Su0FPdRgW+u8v7ByZ1Za6YZZlQ/8C1rwc0ts7
 4KEHAUX6WYjrbSq6/mhHRQUMUXsf3IYPAKXHEkvzFCbAOxhNiNcKTAbpxME8A/T/lly5MeXiVp8
 xhQhz782glhtqffFDQBrFgSPajwNfru0+jk8tXJeIW6gSgB3f6UzXvK/ZYUHwhCcL8w93tSoF7L
 Ag+l8YvswKCjFexoSj3A+IBRpK7LIfYwRhAjx+435Um4zRV7KViIGhA/TsVlaKq70BpGvWiCGFQ
 NxYfN8pA=
X-Received: by 2002:a05:600c:a43:b0:477:3543:3a3b with SMTP id
 5b1f17b1804b1-4778fe59f2amr129085045e9.6.1763450923756; 
 Mon, 17 Nov 2025 23:28:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgHoPjDcFidLAHnOZIHDogXBE8JnhjFIhqFNnUMtEzqjLNE1VKqzkk9OnFXINO6tljujv73Q==
X-Received: by 2002:a05:600c:a43:b0:477:3543:3a3b with SMTP id
 5b1f17b1804b1-4778fe59f2amr129084895e9.6.1763450923419; 
 Mon, 17 Nov 2025 23:28:43 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae2dsm30812140f8f.5.2025.11.17.23.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 23:28:43 -0800 (PST)
Message-ID: <1ca429b5-7fe5-44c5-a948-9e645b855118@redhat.com>
Date: Tue, 18 Nov 2025 08:28:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] python/qapi: delint import statements
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-4-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-4-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/11/2025 19.51, John Snow wrote:
> Missed a spot with isort, which now causes the python-minreqs test on
> GitLab to fail. Fix it.
> 
> (Hint: the commands in python/tests/qapi-isort.sh can be run without the
> "-c" parameter to automatically adjust import statements according to
> our style rules. Maybe I should make a pre-submit hook that makes this
> adjustment automatically. What do you think?)
> 
> Fixes: 5bd89761
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/commands.py | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index a82b5a2a5e6..9dede747205 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -13,10 +13,7 @@
>   See the COPYING file in the top-level directory.
>   """
>   
> -from typing import (
> -    List,
> -    Optional,
> -)
> +from typing import List, Optional
>   
>   from .common import c_name, mcgen
>   from .gen import (

Reviewed-by: Thomas Huth <thuth@redhat.com>


