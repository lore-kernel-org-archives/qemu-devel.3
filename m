Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ABDE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTij9-00086a-PD; Fri, 03 Jan 2025 09:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTiik-00081z-AV
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:32:27 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTiig-0003Tv-Fa
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:32:14 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166651f752so199380755ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 06:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735914728; x=1736519528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SpchRmUUV0UJsvz/kKcTGLrwKlLIs5xUD2UNUqcP/sA=;
 b=qwtRef/Oi+dffjB00wZQHTo7UMUqehb2C+CDcfQBvgDq7tkJLQN9VteojGB8aYs3SP
 135RRcvHDIXf/w5ws3apfE40k3l+fQ0NcQps6nC0h68dZeNaov0SxBfgS+GX9EoZuOp0
 /hZyXnTYAhvr626wwkt5nbW4jrCNvj48KJZBDJzs4NyFPiat9+IugV4JKWnVikH4qenb
 Pak2syLwPoVvwuZnce0LErXrTh5umqpqI9F6MSiuI4+XAchaHV28PR0p7aLGsGmTUEXh
 vevLmp4rdC2QlrEWuElGIgsEAIC7nTVnK58AmmaTtX2ssA3I4LRdiRco7M31hwY8mOTR
 Eojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735914728; x=1736519528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SpchRmUUV0UJsvz/kKcTGLrwKlLIs5xUD2UNUqcP/sA=;
 b=w9i+ey4xgRLFhljIWdqec1P7z+vJ0LacriWfo079ebBOHtFzs4bpEnfgEiJhOTeLYo
 53iVb+j7TVBosxvhduO4KsWvX/IUj0R3MhfppMbwSJjkKTloDiI2tXlRpGm5UZWdgz+s
 GQGg2j0jLCll4WVxBtERiDrzLjcWreYPv0vExbL60r6dWwWI1bwumRwEi90L9mxArCeX
 iXG+28NQMN2pKXDSKucizemkmvIivaBVaG7bcnLq7padlfzfnFuDYLIYMrbKheyQq0cQ
 YuQndFlyzz5vVK1VGjnCT8abf5vNYwmL0p7/K5NHm5lNHYdbqay8N37gLtNcqAUrHLTG
 Bjdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8rFJn4N4wJll0Q/hD79Q858kTvQ9Pqoj8o/J8B6tYIcE8t+uIGuLSuoYL5qqobb4y2ErJyH5IZOHa@nongnu.org
X-Gm-Message-State: AOJu0YwpYsyja0dbCEXUHKSQ3nMKQLO5V/AeTlQuYJxNh5ip3WEO51md
 W3hmI6PRle0pInrxuGYWUtuZgAjE2DdGEWXjPJWKLtdZK5KyyPVOQ8QQPnlchsQIGxRycXDq3No
 y
X-Gm-Gg: ASbGncugSeZN86cAGDXUS56d3dGrtjpRAx7zpt83Bf5heUqiRoUN69I1tCjFW/LXBMp
 uZTk8W6xVFoghle6audXPbtqtVjcgiL5uiWS+0VjSK4tQ9qgMaySfObGUrNXUr/8pTD5C453QrJ
 gZEbmdsXBTyif/8dosRG/ROBD0P8XQ+s59MBlT3anCN6WfISi+qTrH6HZ97f/4SaWeLYF24FtXp
 t/rG8s0r3SfpWsnUK1Ntf0wzp6zWQnS2y41c7qtv9h1WLTwiyVA2+Rs3wlSyX6gozOmxS4=
X-Google-Smtp-Source: AGHT+IFuLqFkWwGcClmQDcp72UiRbHd3BcV4lkZByyzve0QW5Yza5LbLNciDLcN2YVaCffuSWZfeQw==
X-Received: by 2002:a17:902:ec88:b0:216:57a6:28b5 with SMTP id
 d9443c01a7336-219e6f3ab09mr720733865ad.56.1735914727937; 
 Fri, 03 Jan 2025 06:32:07 -0800 (PST)
Received: from [172.21.1.122] ([63.239.63.212])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4478d577csm28363948a91.53.2025.01.03.06.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 06:32:07 -0800 (PST)
Message-ID: <ed91ba26-4bc6-4aa8-97ca-3815a5f85d99@linaro.org>
Date: Fri, 3 Jan 2025 06:32:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] system: Inline machine_containers[] in
 qemu_create_machine_containers()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250102211800.79235-1-philmd@linaro.org>
 <20250102211800.79235-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250102211800.79235-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/2/25 13:18, Philippe Mathieu-Daudé wrote:
> Only qemu_create_machine_containers() uses the
> machine_containers[] array, restrict the scope
> to this single user.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
>   system/vl.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

