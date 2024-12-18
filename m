Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E68CE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNx0g-0002Ka-3K; Wed, 18 Dec 2024 11:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx0e-0002K6-3x
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:34:52 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNx0Y-0002hy-OG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:34:50 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3003c0c43c0so70590961fa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734539682; x=1735144482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TZNMU5mJp4n3DAzXD6l59ElxvfOJRtsCerBsyZUvp2o=;
 b=vty4dO908GfKxlfxs+Y4wx6Rk7KB7dtTyYW6s1786xQhnM8G492x/1lHWZCjsvbJyy
 /UtKOdD7qmcK9VkT3mHp+E/kK7pNwcnZRwOLY8uEVWW6KbBG/LnfCeqcV6EHBgszeS0+
 xGb7Q8m8uVI5SA8My/7/3CQHUKaAQk52QahCea/juRjA7WlJ2VW0XAoTaa6fsvvJjMuR
 jEU6POZD3W0QuVahX2B70zw3zuKWBVvIK2N9eBTRemmLlgk02/muGrEFcDFCmrBYmFUJ
 WsnGjUcNSy/BIE+RM7hD5LEiOtt+q2QQmv5daQ3KhbIBKjMr2RGJVlMUXuMTXq9GBDJM
 LgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734539682; x=1735144482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TZNMU5mJp4n3DAzXD6l59ElxvfOJRtsCerBsyZUvp2o=;
 b=IDss/jHx1SbrUJNRB3/20EJBnUuli+6rdt2dCEefs+8pwRSj7FYAJP1/sk8XiBcu52
 ggG/dqWxLWJtqfwa0ctWqo0nXpQmsjJGF8hHvfBqR2D4ljP2xWjbOVxkL8n7+wLUoVLA
 jV4yMfBUWpB3UOmRVExkEBn0+H/g3+K2Lq+GtEMnYIt9uCgMVQgiYAMy62zjnipRL2gf
 obiB08pF5UqBYnnIvtHc38WuYe4nFRZBYZVBkzjLa2XH4ft55wDEMeGxupmZo0pqTLqS
 lbPO8Z4ZY0B/1IZaKPiDcMeQTTPRcrrnPYb51nBJcAKSXOhmSXJriRozWcmeSpmG8s8b
 ZMrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQsqmmO7Zfb6W3zQVd4gcm8M0J/IvWpxH+GzK9wz85zIJyNqY9O5EjxhNkPn3vIVpKFY1yanyOI0XA@nongnu.org
X-Gm-Message-State: AOJu0YyIcgrzLi3mDY1e42fiGGR+o5WUrOMzgh6GydQUd6eRlmqrNqId
 6xJaUUtwq4O4SKGs1oDLG1JCfMIqcL5AyEc+JPp1C2aZy1gdVtu31V/XVxH5h+c=
X-Gm-Gg: ASbGncs45XElJ0cm9luHyBGEjZn77YHRAztVAj6nLOudv/yo3Q3xMcgaHgdrHn7QmX/
 RLTCVNxEk5I4nbB2DVZ2YdADnZsxbTbq1kp8W9XCUobRJ1XkBlvrZkAViDfD19CKFS/09m4HW8B
 SP8WSP50o/CVSy505zYvbg2FoMIWy+kHTntUMfuGPnVo1y9l+bVumyosd88TqFk99PrtNIH9l0E
 FXGCaeu5fooaNe8Bqav2xiU+EsvSt6bIhK8D+iP0nibD6XQly3JkpRSM+wXIq+cFkVy97u0oPU=
X-Google-Smtp-Source: AGHT+IGsTDeaY2n3Z3ZUPUyJw8KH+LhtCLF6gJs9F2k5QDDm2AySFesG+r9FvrR+JmbZ8vJpbhPk2A==
X-Received: by 2002:a2e:93cf:0:b0:302:210d:3b5a with SMTP id
 38308e7fff4ca-3044db52b29mr10969621fa.39.1734539681726; 
 Wed, 18 Dec 2024 08:34:41 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-303440452a8sm16464311fa.40.2024.12.18.08.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:34:41 -0800 (PST)
Message-ID: <4eed5256-ca6f-4916-8a9e-5c874eacbe5e@linaro.org>
Date: Wed, 18 Dec 2024 10:34:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] target/riscv: rvv: fix typo in vext continuous
 ldst function names
To: Craig Blackmore <craig.blackmore@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
References: <14dfb7b7-98bb-4e8c-a223-c568512180b7@embecosm.com>
 <20241218142353.1027938-2-craig.blackmore@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241218142353.1027938-2-craig.blackmore@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x230.google.com
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

On 12/18/24 08:23, Craig Blackmore wrote:
> Replace `continus` with `continuous`.
> 
> Signed-off-by: Craig Blackmore<craig.blackmore@embecosm.com>
> ---
>   target/riscv/vector_helper.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

