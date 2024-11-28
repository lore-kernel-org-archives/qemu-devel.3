Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA788D6D250
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 01:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGSuT-0004iJ-LT; Wed, 27 Nov 2024 20:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGSuR-0004i4-9W
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 20:01:31 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGSuO-0001iI-MB
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 20:01:30 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21210fe8775so12002065ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 17:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732755686; x=1733360486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=agMo0sn4GdPxx1USoTZBJcsm3hNVUefdD4V6iyDDlos=;
 b=wWD7T0Sr/o1VVA0E4YBR4tMRWe1RC48DAUDGc0f9LyjNGnpzN9aUO9ofGBlBlc174d
 y56doioKM6YvW6qvBs45h5yRQIn9+s18VAtibrfDPIhEfoxfHPGP5cuOGN+e4wUT+yGl
 KVGUqwWPt6uD5yo174aB6sEGWoeGKCXpDwGzDigimTF7VAdd6ymPeR351sZxTU7KTpFJ
 ZwzHgBIPR2GQrxww1IsxA7L9Zva+j4XzwBVro6uXUmc20xJN+ffDUJGUo6hbCwxqtVOY
 ThJhKuNqPRKf3fXtxHsHPSOetaY8WS9T947WFUrLv4qMaJ8RAUVq+gIR+/+10z1kpEqS
 7dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732755686; x=1733360486;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=agMo0sn4GdPxx1USoTZBJcsm3hNVUefdD4V6iyDDlos=;
 b=ondYapgz7/lP9LkPyHMy7d0+Jg2Q105uzHOvpa4i974ZVLnmbx9gdK7JJNSR192/OH
 Qy5ZlUqSzHA+7OT1NWMyUCQby6cjW9M+9YH2NIdrJloJyo/XqZ0v2aX4VtuYPotYBUQf
 ZDdomOxNKsG09NMRcOjiPu5ClL+DkjzKPHYUvN0BYemBx4BDw6CZmjYLk2CfIFvpC+RM
 7PULd89np3z33YWx6legdin3QuMHT5w2R0dhl3qbLDqWKe/6TLx7aK+0K1wUC4et6igQ
 u0CEeuhPwO2q/uSg6l/Lc8pVP6wbaGWugm4l24E7GrQHAbTFX+343MmWwZGADHCGWN9v
 D7rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnHpVrYrv6EiGee5g2PcWFrzjmTIA8AWhm6zWL1L7wyZ4rHtFBCoXAms8BqF+JGxgkSB5QOQN/iUGt@nongnu.org
X-Gm-Message-State: AOJu0YwpO7P93OXmNm3I7S74kqFQm5SDH0g/dj/1i/0jZvqYVXK5J0Iq
 eDuxhOQ3+izka+zkbQGoxey7j4D/OQKtbmlGB/LAFhGF9frnKwrToVO3xtoYy0k=
X-Gm-Gg: ASbGnctY9YTpTpcfX0Z0LRPcX5GSLgIVS+iaUiQ40cqAayl4+2Ojfw3jpt1KBTOjxDd
 /FG6tl168+y/25Dehz3UMHfcfY9Soabsiggzt0MnAKL4l8IrEzpfmCI89AFTPbvJMKNUGdL6Ww+
 PRG3Y6ZaflGufYLvzDsT+yY2F9cNlT4QiyuZN3t8V8mh+4kautZzuwMb8s+ZddBpcBf/C9RqCMO
 zlGridCPvKpb6rCXkOfUYpTh4DVeVZs/1uoO8a7uTCTuZUlbAC8kSo60O+vVrbz0JTRGogBoPaz
 bx5UoF/n6XTPyjKXVnEW6g==
X-Google-Smtp-Source: AGHT+IGfUhCI5/M+bxFYHf5vKZAhXK4Q2rOHoVLJA2JAPBso+HwroBboOnVGdl2wP7wSnrdUGefVEA==
X-Received: by 2002:a17:902:ecc5:b0:20c:c482:1d72 with SMTP id
 d9443c01a7336-2151d6565d9mr19968815ad.20.1732755686214; 
 Wed, 27 Nov 2024 17:01:26 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21521917e95sm1799275ad.105.2024.11.27.17.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 17:01:25 -0800 (PST)
Message-ID: <402b3bb4-f6b6-4d5f-a7ca-22e3caec62aa@linaro.org>
Date: Wed, 27 Nov 2024 17:01:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
 <20241126211736.122285-3-pierrick.bouvier@linaro.org>
 <CAFEAcA9cbV4a8r=h4imdvyMV3P3B4mhgnWU-eobH4ESrsr0Uww@mail.gmail.com>
 <e0c904f2-8620-4f6f-8392-75971529080e@linaro.org>
 <044d72c7-c135-40d7-945a-7aa2c8e89965@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <044d72c7-c135-40d7-945a-7aa2c8e89965@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 11/27/24 09:46, Richard Henderson wrote:
> On 11/26/24 18:15, Pierrick Bouvier wrote:
>> Except for saving memory in *very* specific case (a structure allocated tens of millions
>> times for example), I hardly see a benefit vs using integer types.
> 
> Even then, 'uint32_t flags' can be just as easy to use as unsigned foo:1, bar:1, etc:1.
> Plus you get knowledge of the actual structure layout, which is presumably important
> *because* it's allocated millions of times.
> 
> 
> r~
> 

Do we have a specific API (or set of macros) in QEMU to help with this?
If yes, maybe I could mention it in the doc ("we recommend using X 
instead of bitfields").

