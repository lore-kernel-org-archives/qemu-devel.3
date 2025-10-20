Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE43CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 19:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAvsA-0000oM-BD; Mon, 20 Oct 2025 15:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvs8-0000nz-Px
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:48:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAvs6-0008D5-Sw
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 15:48:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-471076f819bso37721905e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760989725; x=1761594525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MSr0I5sh5yVEyHJBFhpWZ5O2zsSbZGdCD5UdZA87ZeM=;
 b=umBRI/ZZqIWgdvsWabE/MkNUVxg+Zp3f3Yyl9RrT6gpl3CKG91dtqGAjfRARJ/rdg5
 H4UCDNpcyf0iz6GQg/lV+PcermLsax0EBQ1fXlmTpmhqKXsYjtcF5IcbVLiUxtvTY+Hd
 JqUfK6WCFnZ+KXrvD8/V1dAAVeRh224wWFQ8iGlnkqfXr+NF8T8wvA3Pc8cXvyi0/6xM
 tm6v5anhkz5l18t0958RYl3OdTwtbBjVZHQb2sxkoBULrTetwqDY1n9YgpLqYKGiHCil
 HIxi0+3a78okLI184qlxVf+oVHwL6C5h1OVLqNs2paJ/xASw83EFTESIXrL4XZF5LMRp
 RIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760989725; x=1761594525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MSr0I5sh5yVEyHJBFhpWZ5O2zsSbZGdCD5UdZA87ZeM=;
 b=l/ELEX7TDLL84ZVyyI8N5pGn62N0gqmBGIzNjd5k03shgkMyUFBmLZgE+frJYrzHQD
 sYUujQCSuS5WbJjVDsQoZsR5gMsiVZddSvxw70K9uAAAUHKviIEl8vnctouzAO60bjvF
 aZwgyZhNuOzVq+PZPVQysDCCQV/lUytWZzUVHh+0Z8YDp7xU724VNM4HH4LcisKlxKIT
 V6g/Hnu8v3jO78Lk5mkODzmf/UiczwNxbYV7VMc3QSWC6+PYD2F2Y1QckD3wwYqCzNbd
 XB0GzQ+UORW9X1zv1zBtxP1OqgflZ3YQFOjL9v+0tjaWMNw/vEjwrE94x0r0WaouAn7P
 UwbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtMZ74a0RHi+Z6g+RYXDyvLLtm9bR/uox8vIxANS+esQqCPrpo56Af8elnuzTY37P97N0FkqZfcpyx@nongnu.org
X-Gm-Message-State: AOJu0Ywoj7tQSy3RGbM1SwkLtr3DrXQOI6mjNo9kNg6sN+RCQ5CTNIIR
 f8veeC6vi6LDULoZXk/oYOZ4TK53BJXMvA96BJS9CysQWNTASubfe1AtD/yNF1Pb5N4=
X-Gm-Gg: ASbGncs4JiI7xgw724R3VlWjisOg3J0csUP2HET1M11/Y5mzzhuJPwXSQ6xIkwXCx+/
 v0k0R/bnUBn0u5d11N4iO0RM1utyy3Y2LR2FyAKeo2a4BJYbqWGG3CQvs+Ij0TKtuK6QqgJiDg4
 ZuKRQfxtbypnrP2maAZMTU1CpGdW/Wgg/fte3lxqaGmXZzDEpg4e0qyjQWGP6nwOc5oevR3xeMY
 RJfz3Xn6Re9mN7WQ9V6Kbl7RNRuJnfb6GhrbM3mjMNt1lWA/rWlutOalzgeRQgQpTxkuTj1I5w0
 zk23RsGUy7eDBVwV/Lxa/N87uV9TsZPnu6jmJ3PB96TC0AcGpNYRaC5sBLjOPHqa/PxNFFrPOTO
 IWdEj5y8uoDGKUiCxbpAMUWOcz8YARBtGHOw9lx2ihnrl1P00ig8H911AI5ZNdUvfDPoQZc9ZR7
 ouU562GqbHyHnQ0n0iPIKobJsrCMO/Xh6DmUS/0j5EaGEm3lr3a9L97A==
X-Google-Smtp-Source: AGHT+IG74cEDSBgD4uCAnRvH4tMSQHYpqX8Gfx7+2Bm6L82940u8mpyIeGU98UFIFbOICELm1HvMUQ==
X-Received: by 2002:a5d:5f93:0:b0:427:7b7:a86d with SMTP id
 ffacd0b85a97d-42707b7aa0bmr9280664f8f.36.1760989723569; 
 Mon, 20 Oct 2025 12:48:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f7dsm16504299f8f.4.2025.10.20.12.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 12:48:43 -0700 (PDT)
Message-ID: <81d9ca31-2705-46bd-92eb-1be8e8d03843@linaro.org>
Date: Mon, 20 Oct 2025 21:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/16] hw/pci-host/raven: Do not map regions in init
 method
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760795082.git.balaton@eik.bme.hu>
 <0256c29a5f3c0659174827cb7eb3257117751f22.1760795082.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0256c29a5f3c0659174827cb7eb3257117751f22.1760795082.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
> Export memory regions as sysbus mmio regions and let the board code
> map them similar to how it is done in grackle. While at it rename
> raven_pcihost_realizefn to raven_pcihost_realize.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 38 +++++++++++++-------------------------
>   hw/ppc/prep.c       | 10 ++++++++--
>   2 files changed, 21 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


