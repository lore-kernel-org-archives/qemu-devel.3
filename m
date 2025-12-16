Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86676D5E130
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 11:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVSoD-00051p-4X; Tue, 16 Dec 2025 06:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVSoB-00051M-0J
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 06:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVSo9-0005fM-45
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 06:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765882892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PRUH9qj/bnyDFFMza/nx93UJFFtdEDCvKGROMtamQkQ=;
 b=V71f7NGhF94E1DsEIAD4JSh2CG5jW+PAAV3sOLBH90oERiJv7B0VKUTcCmyg4KLUOWFQpa
 J4rpcw/foF2sjeSTr8WWS4KBVxy6riVFn6nGul1CVGzJOL7Bz8mFVHh8RGOM3olg6AeGLW
 KzT8WCQ595rrCf+Xc9SZo0F/2zndNSc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-r25-y6H_OeO5tUUjvUFppw-1; Tue, 16 Dec 2025 06:01:30 -0500
X-MC-Unique: r25-y6H_OeO5tUUjvUFppw-1
X-Mimecast-MFC-AGG-ID: r25-y6H_OeO5tUUjvUFppw_1765882889
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso31409235e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765882889; x=1766487689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PRUH9qj/bnyDFFMza/nx93UJFFtdEDCvKGROMtamQkQ=;
 b=r9qWTQvvCyiu/A3iR3UcZWaVG+NTuJREQvxP1onYj5LupqfMpz2xPDYypdTlNHwP2a
 yOb8/SrzG4IA7/PzhuwK1HFvJqTVbnceZc1K7rnFxoMmh5ymP19jEx7vHdyl8E+xG6wj
 IkWzvxcA5CXtkyjWr1INFepyhbg+CFyHgxc95Lc1KohdUnsQ0vE8Au6DyXUFBWZKbrbU
 4UarXL86Z5invIHZyTXTrt+cNR7+IsU9Mmp0I69vwkPm6YPs03zOvBCdOf7/W3myqCtX
 nReqpIKqzH45qa0OjpOcYpdP0R5cRGmF885dw4B9d0JFxQm45aCPwhHoqo7rzgh0XleH
 nknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765882889; x=1766487689;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRUH9qj/bnyDFFMza/nx93UJFFtdEDCvKGROMtamQkQ=;
 b=uFXYGvJbYt6REf+tmBvloC/OxtmWD7Wzdmv/OnPf/ITkoI266r5Yi933GBbR6qX0kd
 xNkF3rxOe2HK58zMUXEGo0KRTTTHl49XOUnCxmFpt2hYm5aAarJHmv96jhXLATRr1pEc
 dmKuKEqvggWQ3zad5UbANYYcDY86ludokH3N0SNo+CJyO7Kxx2uIiJWd+OKxjpvPU+/B
 01usi1MzA7UySTU+NN3hPib2+urjKjKE1r7+KLJw5syZ33H2GMjYmm6OykAriag0a6ju
 YG3tylOKepDOD282kQ11t0+lzegBXLDnkKrwJmiiQl9xkzDzF5NjylleaTKlQ0f57Vfa
 GBew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHUhP+dHjq3Aw5EYgAYxG/9wSyA3of+iYvCUQQadmptwrIy0ZsMtz78g8KSqbkYHjAoVgpGlr6kszu@nongnu.org
X-Gm-Message-State: AOJu0YxV9smaN7/icMzvls2Pkp7DMP7rF6SeMcxsrsS1iKFaUXGOsxOi
 OpzEUMuVgSnndj3G8bBJA7Om0vIbW2rdDinEv5bQjiq8EF+4XRIQ+TFFz0C4T9E1tmjqdrT2U8+
 8xhE8kfa6MlItBrsrqQi4YRz1I/XYhKL5YKBINhWe7rXD9qgGcHGrfb44
X-Gm-Gg: AY/fxX5UYZLlJU0FVyKZPPBGeUOhdoyJ8DM7ljvE3R8kp527SEkKWE6knS7artr+vAu
 zW7iRuBgB0/mJ3Zurv9+z9vB/xJCzDDw6taTtQE8kU9CYzYK0l6iy61U52vYVUYGuTxZGJdHCYr
 HWE+eqv/UVljJOc07yMcB/pXq80L690f3NaVDT5xTSDuRZdscQ9iNpXhm1mpU/IKBOQdyzuxvPG
 mA7rCuQ5bOa2UyJdPFboxggODvgfh7LMJykadrqederyfqieQ1D7rTAyqoIptXDS7+OfS31hUFV
 5s5czC3hmi6HVMM4k5K3y61p+sJkpwaIotBDTlir7hHKaZo8wkpAtHcXJurhrB1IhnsbUeiiRnQ
 Ai7QRzXw=
X-Received: by 2002:a05:600d:6443:10b0:477:7b30:a6fc with SMTP id
 5b1f17b1804b1-47a8f90f371mr126759415e9.30.1765882888840; 
 Tue, 16 Dec 2025 03:01:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIhYJuKNYoffgY4pHOIQT739rmxApFycD4HQnMQK0kjd519yMb1s2n95E8btpB+mPpvMhfTA==
X-Received: by 2002:a05:600d:6443:10b0:477:7b30:a6fc with SMTP id
 5b1f17b1804b1-47a8f90f371mr126758895e9.30.1765882888310; 
 Tue, 16 Dec 2025 03:01:28 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd995d52csm6515535e9.17.2025.12.16.03.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 03:01:27 -0800 (PST)
Message-ID: <2adffcba-a77d-45a2-bafc-fd8d2bbf0fc6@redhat.com>
Date: Tue, 16 Dec 2025 12:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tests/vhost-user-bridge.c: Fix const qualifier
 build errors with recent glibc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>
References: <20251215101937.281722-1-clg@redhat.com>
 <20251215101937.281722-3-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251215101937.281722-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 15/12/2025 11.19, Cédric Le Goater wrote:
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
> Acked-by: Yodel Eldar <yodel.eldar@yodel.dev>
> Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>
> Link: https://lore.kernel.org/qemu-devel/20251210181306.926334-3-clg@redhat.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/vhost-user-bridge.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
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

Reviewed-by: Thomas Huth <thuth@redhat.com>


