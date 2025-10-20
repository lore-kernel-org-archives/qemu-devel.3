Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B53CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAwL0-00030b-Tl; Mon, 20 Oct 2025 16:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwKz-00030B-Q8
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:18:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwKx-0003AW-7r
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:18:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso4963231f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760991513; x=1761596313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EtDqC8O1H7t9UZVQ7ht1bfB3f/HcDGJKYgaheD4Trqs=;
 b=MRuwyblpOjKm4lLBVJlj9/RrxvLMrZoe40ZqzFpdJs2mNRaFf7WKAYoKuG7z1Zrnzw
 vcwouXkR8zRl6JnIsN3mOkNwDHJz1ubELncMIJBjB/WRyLHbW7enKCUM31VwASVB/VjG
 GYSsFW9t9YQiXO+QBuyFQsFj/CxlZJN/XzRFQPvlQMgMK2PCv+mWQ2dWafb12BEgoatm
 /aSYP3a1CelgVXMe9Fe3c91eDKB0RSUK4xLA3H+fFgsAC/qXgHmFXO55Bi378bYjF3Hs
 3ncYv2gndrxoKfad0Rc88hWn37oRhSzS/20WppJ6O8AUi5FFNVsW9KpG4GIJd2nmpMlt
 vmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760991513; x=1761596313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EtDqC8O1H7t9UZVQ7ht1bfB3f/HcDGJKYgaheD4Trqs=;
 b=wgxDMBKWDBoMqbc9Y8IoRd6mvdac2w1srDk6PMilh4HbxXVZQ8bBbmp9vU7qMh1nao
 6IstxcBnyAJKC8AQ8Uz0crivKDtox0PO8JMAj06GMNU0uu3JBrbwD89gQLyhizoZ91BT
 Pt8hi+a4wZei8dgd3RCKnWrpdD6lzPzDsWQwGrhOjH2X+mxVhl8XuKayc7KNckC0VrUU
 pPZTsOfjHqVqst566S8q/D0zYdxhrE72UQIOnogpEZxJtNq3X17Nyy+aGWW2nYI5RTlR
 7xoosi4Wo6fb0ljl/ACIGsWh3aRvvxxuDmODD8g3g+X24fUMuIV9Z8AHPXC14Q8HgapI
 XDpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURI4UwogwPwF7rY44QIrvGOEA6Mjc4+UqMrR07ylYLi3BVA7y9RPJJpC1gXKwJd+p1iQs39/tV5hvE@nongnu.org
X-Gm-Message-State: AOJu0YwEliMV+9fZ0lcZsIL0R6oawVerp9HE3kiY8cnYegz9YX/ZgUhV
 lUQ9dsADWw1kZ/vgCaDetjbt4ZDMwrhOdowaOdwQTEXhvZpZtly+9Zq9foTaa3PrRg0=
X-Gm-Gg: ASbGncuZ+TdRAZKyqxmC58MJbt7s6F0XEAhqOr4PARGGvPhSzVEVkXAHbZ/wh/y7G/2
 6t5uNInPtKRZOYJdhFc8rs+NW3JREi+6yLNrTbO8L1MNL5GHW+YnysXkuGVakU/I8YPB9nAD1ge
 n+ENHUmA7LUGyoc5LOEH3VmIWHCDce5QaR+1iKJ46Mpqw99vGcKVbSA6Mi5Is+GgyvvrueGrn13
 efD/wb/S0LgR9r3bReqWJFU88WSE9jqTFNkYo1iSvpg1P5023Cgm1m0pTBJPWyHSqJBmPm0dRCb
 56ReNoD+S8s0kESm+QrkkwIMhhQM8QaqsFAQLA3V4J3n8jMip7JBD4j5oRTjykMh0PBoqwO06l2
 YHQpydn+ygFErth/r7BnpUceVjXDV5pRIz9t1YDqE6ZwftRvJ9cpIfe90yqJG16V/kNQpKOkrNz
 J6hmEDPzvOpot9n5Tva+/bJ9PudvkDylVifLCjSjetVo+yzHtx1wFkTQDHxo3ft1iB
X-Google-Smtp-Source: AGHT+IGD0SV/KdtvfMF6J02pPIWf80hfFjUJiVC8t2DRHtQAHFNi4BDDJVO6tKwoDYbj4Tso4iRXjg==
X-Received: by 2002:a05:6000:2dc7:b0:428:4354:aa36 with SMTP id
 ffacd0b85a97d-4284354abd1mr4579426f8f.58.1760991513001; 
 Mon, 20 Oct 2025 13:18:33 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520d753sm160913125e9.13.2025.10.20.13.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 13:18:32 -0700 (PDT)
Message-ID: <a4c90755-9f5a-4671-a25a-1789fc176802@linaro.org>
Date: Mon, 20 Oct 2025 22:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/16] hw/pci-host/raven: Simplify direct config access
 address decoding
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760795082.git.balaton@eik.bme.hu>
 <68c038fd225463db282d0277d80cb525e0551413.1760795082.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <68c038fd225463db282d0277d80cb525e0551413.1760795082.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/10/25 16:04, BALATON Zoltan wrote:
> Use ctz instead of an open coded version and rename function to better
> show what it does.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/pci-host/raven.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


