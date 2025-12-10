Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFD9D3E768
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTOiL-0004MD-V0; Wed, 10 Dec 2025 13:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTOiJ-0004KC-CD
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:14:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTOiH-0002hN-Oa
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765390496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bv75et6Wkq2Vmbe0CFqkvB++AoitxIUcPz++L0nUj9Q=;
 b=R+lQtMaHEDH1xYbUFkrRV442bw1+vigGqVDWeC7GVELAjmbSm7JFwcNGPOVT/OK9MOpARC
 0lsNCopEJQLaVJmLezS1yOofO/Pam4t0GPpbvfeFc4q84sfWT2QQrmVmtsf2jDad1P3kjA
 VEp3asCOiMyRQLdK7xN7ip4uiotHU/k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-2JDxdQBqMgKmwrU3WgaV5A-1; Wed, 10 Dec 2025 13:14:54 -0500
X-MC-Unique: 2JDxdQBqMgKmwrU3WgaV5A-1
X-Mimecast-MFC-AGG-ID: 2JDxdQBqMgKmwrU3WgaV5A_1765390493
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47797caba11so293345e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765390492; x=1765995292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bv75et6Wkq2Vmbe0CFqkvB++AoitxIUcPz++L0nUj9Q=;
 b=CiGsreqBNug9xyi/7YHSDRzXnK4eLj+KMOZa3aMog+ZbxAxjXtkk9sz9j/iqd/dJu0
 eTDo+3XmbIfeTm5n+hDVB3TjzOhk+01+myxuKFEfYp3uXNaDzIQKO8Y6TeEh/j7DvwBy
 N4KyiE4syoH2Ni+Klqvd09pZLDQb8paGgCzLVCw43ZleG7fNWzMMMOjNXZiFXPfujZUL
 ahrC26/0IV7eCOpO/sMbyEysZbwKlT3U4PWPcio3XjFVid4wztEXUO//4fTuxDFQ8d6g
 nyqMJIGxyurCWo3NInvZGj68l+ljyueGem1Sl+fXmlzxAuoxJRHv3GusmH1lYDG3kp7r
 g3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765390492; x=1765995292;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bv75et6Wkq2Vmbe0CFqkvB++AoitxIUcPz++L0nUj9Q=;
 b=AYITGapkw6zUABiD8a6s7xAl+7gPTqOfnE06ZnkSwkuhStVnDqYGqhX5/Nimdwe/JI
 Mu6ErYX73ykrH0gHFSukHy3OskCwkiU+A2a4T7FOblvsOZ8WF5CXLuyyb5ySpkfA6Bz+
 RuVPL/LfxcNuvIzVGxfS2lKQy7rkun3Wr/XOJaedQ0qFVp+GRLHpxVVU/r3M5LPWMAvS
 NmZESeT/+69zo8GIFTh5I83hW6CUNlilEsaExC6PwDb5QllXddaPPyYIu7lH4i6AQTNq
 CiBkmrXVPpCxeKeOH0eM1fZpZn65tFMuWkRCAqLo69EArmrvf6ola7IPiMOxNlk4yQ8L
 S2cg==
X-Gm-Message-State: AOJu0YwSWyhjgJIwEVLmmruTCwwbCHXt3ieLZ+sLdyU1HNB6kF1Ec3ea
 58sPOIueZ5o7sX1s0qNufC7AG+q4Ss8ewcJUzGcD9s51t44/2aQ/UK8fZvHmCYLflwna2vfUz/g
 6pNkiTHC7bdDUuWS9ehygyOzLmrxJa0tBYsDBOL7gduPlhjZCAtYvf3JICnlbVUPiZU/bYwhbql
 fTEbKT9D1xxlVArJVD7afXIjgfd8NWVI7xVA==
X-Gm-Gg: ASbGncuad+CkRp6LmSj4lKPtzG40OKldybDXBDqpJoS2yJ02Y5qiEWxxnO7q+s4iMVw
 kQZJyUAwa7escdVau0BdLibAcpts2MAIMbm07bW5/teCkC+po+poWkVuF/zipuBcxAiyXOU//eV
 8nXLW720oSrml4ZAThp4YAWdf6sa97yU1U11q6CdsMCVkUi1g6D3vNwAI91ZsAgLiZeeGL16tB0
 CdrhHWcnvtxY57OmcX0cTGSoj0nWx8d7xi/EPcmLTjMYnxNw8QhozN07ebeIM3+/bj/tMnNConH
 gziB/AoH+fD2AMeLVgLJ8hsLfF28ZAKjXNrqFBnriqhUT2HIKE3gw7heVTS6ycnNIZ+ttlB0V6m
 a+tjgs9mKrpJ6DVGBBKFU/mhgP5o70ZyTRwJAIb62fgIBeXDD
X-Received: by 2002:a05:600c:3507:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-47a8380c0c6mr32819045e9.10.1765390492173; 
 Wed, 10 Dec 2025 10:14:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbOd+ONYjkxtB+YQeL+bkXq3YG8gCeENXN5QW8KQRzjsIGDAnvfLI8H1gf7xgqiQw6ghh+2w==
X-Received: by 2002:a05:600c:3507:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-47a8380c0c6mr32818835e9.10.1765390491751; 
 Wed, 10 Dec 2025 10:14:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a88a0b793sm2416965e9.3.2025.12.10.10.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 10:14:50 -0800 (PST)
Message-ID: <be8600fa-81cd-4c30-8fd1-c0049be4c9ab@redhat.com>
Date: Wed, 10 Dec 2025 19:14:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/vhost-user-bridge.c: Fix const qualifier build
 errors with recent glibc
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20251210181306.926334-1-clg@redhat.com>
 <20251210181306.926334-3-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251210181306.926334-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 12/10/25 19:13, Cédric Le Goater wrote:
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
> 
> ../tests/vhost-user-bridge.c: In function ‘vubr_parse_host_port’:
> ../tests/vhost-user-bridge.c:749:15: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    749 |     char *p = strchr(buf, ':');
>        |               ^~~~~~
> 
> Fix this by using the glib g_strsplit() routine instead of strdup().
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/vhost-user-bridge.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

I should have added 'Not Tested' !

Thanks,

C.

> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index a5c711b1de8e9c164dd1614f4329b8e3c05d0402..ce4c3426d3938a0b54195f3e95bb1f1c3c4ae823 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -746,14 +746,12 @@ vubr_run(VubrDev *dev)
>   static int
>   vubr_parse_host_port(const char **host, const char **port, const char *buf)
>   {
> -    char *p = strchr(buf, ':');
> -
> -    if (!p) {
> +    g_auto(GStrv) tokens = g_strsplit(buf, ":", 2);
> +    if (!tokens[0] || !tokens[1]) {
>           return -1;
>       }
> -    *p = '\0';
> -    *host = strdup(buf);
> -    *port = strdup(p + 1);
> +    *host = g_steal_pointer(&tokens[0]);
> +    *port = g_steal_pointer(&tokens[1]);
>       return 0;
>   }
>   


