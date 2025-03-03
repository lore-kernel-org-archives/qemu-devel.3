Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86CAC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6qs-0005ub-0A; Mon, 03 Mar 2025 09:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6qq-0005qn-ED
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:33:00 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp6qo-0002zr-HS
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:33:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so28654905e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741012376; x=1741617176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQx6WAMU3a+S0k8qWFheEFJj4SYETQf9xPBsJqQEtwo=;
 b=PJTe7xiWfLtel117BmK85H4FHAhkvtT2WywEVaRgWwT9ikvA8bhw4e7zK9z950Vt0+
 bJNdfgZm21K1VxJjNc2pRu8NUJJ/fz3mkE/J4dyn0GjTdau4Rlx6r+mLW3qt6yz4SjZn
 Rrb6yzrN8HTXIT5mofXtHCq9W28LJo6wG/tzVSJuJMYdqpaDHqMT0o908zuWRvjeyB2d
 pDRyX3nSD4cKmcdCAgdA8nzQYdMXvHmc3tGVvndgb3y0T0xfBoYWcLprb5/5wBzpawzf
 nXyDstMXX6YGvHDzny1kC+7r/3/uITCi9OrzmEFhM5W3hSZeY64g+T9v6Bj3RzOEtzmT
 lU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741012376; x=1741617176;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tQx6WAMU3a+S0k8qWFheEFJj4SYETQf9xPBsJqQEtwo=;
 b=v8pCpoqbnwGlSEwL9CJIqcxfCnV2BIn0p1lbNu6QHXizkMnMzQB4tBkOiXKHNfQOEQ
 2lHSQqbLBUEK4UW2FKE6rR3yWXwHhMfhklomoGPW8Du3X0JhyQdIT0FTLhD1RB8OpYTX
 Evf2ZcR+sNQ3y6uIsbH/y2Ha1TQksNNVMduQBQHKWiE7mDOO7IotBJ6qvB56mqCLRkN7
 Y21cYyvrInU3bauP1IAXw739fHBDO0Ec86ZusE7OXe2OUXL4+2iwe0UhNWEZg/V5wd/W
 Mbkd2T8ZxwQjpvKo/C3Jo4xv9avmjmSyEXM+Kz+MFBxl5K3xVD44JXQcg3Xs6tNAef9R
 i5OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQMt4F365dWicY9e7V0t5JAdcmI0hZzgxZfPcxQdHDwtSuIDXDsu3iRw3bgY149tURg242QrciFge9@nongnu.org
X-Gm-Message-State: AOJu0YxAaW4cYJD/tNU7iWJ2jYi/UpBI9VzBl6HDlb+FXAD8+mt0Iwkv
 y1LudXO+jI6SKmJLb24+X19lrkSDHvXNgULdp1IgS5udHxrEGkBDqzUqhtp5WSs=
X-Gm-Gg: ASbGncs4KLiFG03actt92oCsSWqYpW79nWy+BHPzy1yCO+yv20CYIIjKHcEATtgXo82
 yjdkPSmwqcyn5FrTU+EhY5pni05CHgVH2SKk6U8vnsiFONDguDjh7n7ar9763kXndtr0+V/BmsD
 3CKLyRXb1HD+v4/QcTKUDxJR6eAuxDDn55bEB8khraFLPkj/ZF67D1NkRGhxUNRYvS22Rk+bVWx
 UOywvD3v7qwjIwvPVgGtm6fIhxHffaqRquFvXJNQOtYKWeZDLDKakNsFLki13EsIFBV2G1nFx8l
 qK9qXKVm3u2xbs8KoQZ0mR9zUxIE2MLSaxpfXMCy160qovC9xmB/G7Na8hbYJaFd9HrJx/BgHYB
 TjIvg9ndBTuim
X-Google-Smtp-Source: AGHT+IGmhzJb3KrjTX+c2UPVGd6Vzrob4mqpsBRe5i+D8o4KppGNx8XlrFA9fTGz4lMIRPmwRfUbUQ==
X-Received: by 2002:a05:600c:4510:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-43bc95f12f6mr11716435e9.5.1741012376438; 
 Mon, 03 Mar 2025 06:32:56 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4796600sm14518419f8f.20.2025.03.03.06.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:32:55 -0800 (PST)
Message-ID: <d069fea1-3e3d-4fff-8548-8cba491fcdc0@linaro.org>
Date: Mon, 3 Mar 2025 15:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio: Make vfio-platform available on Aarch64
 platforms only
To: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Will Deacon <will@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-3-clg@redhat.com>
 <291bf12d-18bc-444f-b09d-3fb80e0f144a@redhat.com>
 <20250227102737.197ab32b.alex.williamson@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250227102737.197ab32b.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 27/2/25 18:27, Alex Williamson wrote:
> On Thu, 27 Feb 2025 09:32:46 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> Hi Cédric,
>>
>> On 2/26/25 9:47 AM, Cédric Le Goater wrote:
>>> VFIO Platforms was designed for Aarch64. Restrict availability to
>>> 64-bit host platforms.
>>>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>> As an outcome from last KVM forum, next step may be to simply remove
>> VFIO_PLATFORM from the qemu tree.
>>
>> We also need to make a decision wrt linux vfio platform driver. As I
>> can't test it anymore without hacks (my last tegra234 mgbe works are
>> unlikely to land on qemu side and lack traction on kernel side too),
>> either someone who can test it volunteers to take over the kernel
>> maintainership or we remove it from kernel too.
> 
> I think it's more than just a kernel maintainer stepping up to test,
> there really needs to be some in-kernel justification for the
> vfio-platform driver itself.  If it's only enabling out of tree use
> cases and there's nothing in-tree that's actually independently
> worthwhile, I don't really see why we shouldn't remove it and just let
> those out of tree use cases provide their own out of tree versions of
> vfio-platform.  Thanks,

Now (1 week before freeze for release) is a good time to post a patch
deprecating it :)

