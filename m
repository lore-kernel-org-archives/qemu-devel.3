Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CA2ECD992
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 18:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo47y-0001qn-16; Thu, 05 Feb 2026 13:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vo47t-0001q9-0W
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vo47r-0004FC-J1
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 13:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770316246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3XeYxZoZE6yXhwU4PR/C81D/L16K7HfSeZY2MgHSmfs=;
 b=GNoQX3ALmi6lOaZ9ML7drRigyqD49LL0wwKCsCAh385l+XptLW6yR4pU58UMF49gGbue15
 c7h+g9mqgN7AkOarg934dhPy77agDC5iNfKMoSA0A7iIEdNV06mUxIYB1MXqhq9noWsg67
 rBg+klWEheACEXQ8tEW1mvwa64SjDHM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-IMhKXJeBOO6zoGszeLkQ1g-1; Thu, 05 Feb 2026 13:30:45 -0500
X-MC-Unique: IMhKXJeBOO6zoGszeLkQ1g-1
X-Mimecast-MFC-AGG-ID: IMhKXJeBOO6zoGszeLkQ1g_1770316244
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801bceb317so18341305e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 10:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770316244; x=1770921044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3XeYxZoZE6yXhwU4PR/C81D/L16K7HfSeZY2MgHSmfs=;
 b=OqiaWEhu+QOLA5Oj4PvdyHUo70q39wxei3qOb5bsITX52UZnPrwY5V/Tm6BP5/TgpW
 bmq0z4DycRvXgSfuotnLCt4+gHKU26chMSR0KZCRokpVEOxoozrnO96sISw+QhLsHcPB
 RVkIr3jOzO2oGklXcG2C8t9fy1U2MhNxoYKnuqbrZ/eUXIRuSdP5W9uiuRYJZv4n5R1t
 Eb+O2i1H+tQSB/aZ6j3dTxwiiS4pL07YahONknzpc/vGks7fTFpeXuPPgLe7r6u1TtQ4
 mGgAoVaQqnJW7Geb21o65jL+ZSgTw9ei2W1iUcUlWpsF/bRNnbbZVTj6UxQFJkRo+W+X
 f80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770316244; x=1770921044;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XeYxZoZE6yXhwU4PR/C81D/L16K7HfSeZY2MgHSmfs=;
 b=rMv0YLo0hR2O5v5J+C1+vT1EwiO4RGnu93Q71WRh2UjWAu35iF6dQarn49MFgVNM8R
 6ItIs1AAUs9xU/63YDx7HfMg16Hd8/nw4AWAtAIfKnTWslD4uOVb4N28WQgEriKcJWPz
 M5yETx5w+6d0YURkG/YZmtdz/Kn0Qa91BpOyQbWHCLFWN5iGnOOHB6RcUtTxQPRuyDAo
 uJog8SBtBeEB/xFkdMDFMWxDIvRAn0SnXrx8WVfSHoGh5vt4EhbU6O5DYiQp6n1zSwFt
 qsZjQ0X+V3fOFkllUwaBvOPzQjZ74ErVrwOMkm2KnRTd4PcO+yKa6fpJso54x0C9yAKU
 LTag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnbBdKtyFKAYzd+9GAYr4FbMkDguhlIhGW1Hd1fzJrYtp4yQYLui2VD+uwMUVbSQd5UHbMvi+fmGRB@nongnu.org
X-Gm-Message-State: AOJu0YwlBFeJ5nfnN/xetTYQBl2elAsg/FlNfz1i/4BP7AYVb4DR9h+/
 m0MB6YER7sOXBo4kyripzUCX4W7PEKQIpnUoukrEpX9U/h1kE36aJf72tIxnhoUVtKoxnu/7mWP
 1CVDCoTU1eVec7Rnwm4o7GHwCNLWpiOgra5g6SANFjt6y5PCp2h14lsBh
X-Gm-Gg: AZuq6aKRPk2v8gBK3XkTaTnXfbe68zV2a4cQ7AsZomu1a6DuazRQO2MvBXmQrgud/xf
 H2O24+G1Bln8Jk2PMnpY9EoKljT42wNMpr4+qGtV1oIEEG0hVWG3zgTd6b79FrARYyiYHEFc2bS
 v1PB7PZPj7QrPSoYxNupuudP/v9AzGGS9EHcM624NKufQpryB4boZ0+L0czZxbDRWTL9BYahNiU
 Cj60/om7+E0mjA9b8TBky453bCQkLDPsNPNiigpDwb2cZDD6vPsbd0VylCf28jeXSz6oadXt+Ev
 wQkv5TizztrpEuqrpBB2vs+QSO7hKq8VwRF4U2N97J5n2sfhQo8Dh9ZZTiTkfFv6IUzR7TT+ebC
 QcTvy6IY=
X-Received: by 2002:a05:6000:2483:b0:430:fc5a:40ac with SMTP id
 ffacd0b85a97d-4362937bd0cmr322990f8f.54.1770316244058; 
 Thu, 05 Feb 2026 10:30:44 -0800 (PST)
X-Received: by 2002:a05:6000:2483:b0:430:fc5a:40ac with SMTP id
 ffacd0b85a97d-4362937bd0cmr322955f8f.54.1770316243657; 
 Thu, 05 Feb 2026 10:30:43 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd1bcsm87188f8f.12.2026.02.05.10.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 10:30:43 -0800 (PST)
Message-ID: <e348f502-e404-4b60-a209-865e82002bc0@redhat.com>
Date: Thu, 5 Feb 2026 19:30:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] target/s390x: Expand TCGv type as 64-bit target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-9-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260204182722.44062-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/02/2026 19.27, Philippe Mathieu-Daudé wrote:
> The s390x target is a 64-bit one, so TCGv expands to TCGv_i64.
> Use the latter which is already used about a hundred times in
> this file, and is also more explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


