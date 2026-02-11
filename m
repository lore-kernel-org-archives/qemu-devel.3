Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D012EB594C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 01:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzRi-0008D8-G7; Tue, 10 Feb 2026 20:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpzRd-0008CN-JG
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 20:55:10 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpzRR-0005CV-JS
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 20:55:07 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso892820b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 17:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770774894; x=1771379694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0IWtkaCRL/vZGoNcNQIqkBbeDgieVrH6XD98uQ7H2u8=;
 b=oIley4dgQw09VgufljP1AAXdIpi8v+9Knk59NhmiCYuSPFHv97Dup7SPmCp3/NdvjU
 NLLHSdUzfYsPBUvFy++fpjtpxoZ/wCquH+3vx9kduXmZtQ1i1TDPwSWRq2X8LGBnWIzk
 jft8b/DpntY/6hy5If4sdCASdfznM7p5GaxDYhw0MzLAttF80IaDdGfeRDo2Q4x0pJ9A
 BYIyG37lgR8UjJB31UMMbSuLwiOdOXCHfIkIXqDGv28+x1wkmZJciwJgN6bhgXTvCeIH
 djnTc1Kxo7j3Y8Lz1/mRLU4wQhLYU737qNFDGqYQ0NdCHnsEMS+KaDmKb/YXKg2vr43M
 xCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770774894; x=1771379694;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0IWtkaCRL/vZGoNcNQIqkBbeDgieVrH6XD98uQ7H2u8=;
 b=KasZzZrTDHfxCIry5zrnREjyw0/dLauDcBdMKQJv8vPZdywlXT8SIxqSZ5szG5lN4z
 /qfw/xzP45K8YkKKzomlLJCWNE4lUTLm48Tr9C+4zkKNg7xFY1cFdvP3gaePiSrR44Ou
 wCVJ+o8vcl8W84Xq1Aa+oa1n/NewuTGvlTKmzsPGTKQlGl7nvJK2SBzSWD6aDfuTec01
 HyXpRmuwI5BJUPUuG2+/SgCf+3y1Fz/pM6HSdYJszr96x96BbHHSqNNKl30UHrIbq+Q2
 f3QdgrLvy7U8xPfijOv2k9XXH1P9fF4MvgqP+e9rTaUfI9zb/wv5gttwQ+Tor4zYvf5O
 XBBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW58BKEbZ9HXFWubNMTi1fVflIGXJTMeci7iq8KrV/E9ZFbMwe/L2pdI4tet0HILCB/BSkkO8lZvfas@nongnu.org
X-Gm-Message-State: AOJu0Yyla3uLi0qLZSHQygHKJ1o6QSgiH7ckpQvtXh3cK1wyTuZ2I6RI
 jvOvvIo3WL+rmO+RgMEV9vJokTiP6YUi+zekKQZo7O8Cos8So3bDCJCFEL2nlq8qjyw=
X-Gm-Gg: AZuq6aJBUXQM4ftiAkICCEJrNnoyOVWsvpkeB7X2bz9vje9omXLo6eXXLQ23Znac8rh
 3ww1MtdjUnfQt2BlIgbgN+wUr2U3/szeIMQvzg7mFR/WkzVPSdVqBmC/esPdI3mRvdG8pBfZgPd
 Si/jNqfNTzQ5cUo7sc8b8DNRTmyz4WgL4vlXn/dbyMkdOcxr0cQWjRr5aJJs0RDkT5203AeIgjK
 llais1p64TJ2AEfsTvdO9GhCa2CBAvx5lB4vsNkCsULnVkpl6XhMevcDEGimoVCRuF0snivBkrY
 i5ncZe18O28dFil0fz6NI6v7V7xqFrZcgwFL8gQ5BZH4L/S0eEIBc4w2CYgHxNxSCnzCCBUUO5e
 AHSxrI4Pvkra3M3BiFZulbuib5BivwaGAjMhEGrSI2tICCKWfOyZHrnjzOIKsjHtzxXr3xN4pc6
 HlyPdBq0++m/TiUUBV4hAJZhc+L/UZUmG4i01chFesOyGMQhFyDJ7Lt72vRkH0BQXXBELPo5wzN
 eiKB+4KO5RksQ==
X-Received: by 2002:a05:6a00:3d83:b0:823:b5e:d0 with SMTP id
 d2e1a72fcca58-824416f7984mr13392184b3a.39.1770774893771; 
 Tue, 10 Feb 2026 17:54:53 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:f8f8:2c3b:9605:55a0?
 ([2001:8003:e109:dd00:f8f8:2c3b:9605:55a0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e367b7esm288811b3a.4.2026.02.10.17.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 17:54:53 -0800 (PST)
Message-ID: <e1cfd6d3-695d-493d-b808-2752dcdaaebf@linaro.org>
Date: Wed, 11 Feb 2026 11:54:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] hw/loongarch: Use loongarch_palen_mask()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 palmer@dabbelt.com, alistair.francis@wdc.com, pbonzini@redhat.com,
 gaosong@loongson.cn, maobibo@loongson.cn, deller@gmx.de
References: <20260210-phys_addr-v4-0-725a589e83c8@rev.ng>
 <20260210-phys_addr-v4-6-725a589e83c8@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260210-phys_addr-v4-6-725a589e83c8@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/10/26 21:33, Anton Johansson wrote:
> Replaces remaining uses of TARGET_PHYS_ADDR_SPACE_BITS with
> runtime calls to loongarch_palen_mask() to fetch the physical
> address mask from the cpucfg PALEN field.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/hw/loongarch/boot.h |  3 ++-
>   hw/loongarch/boot.c         | 28 ++++++++++++++++------------
>   hw/loongarch/virt.c         |  5 ++++-
>   3 files changed, 22 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

