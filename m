Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14794D68BDD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW85v-0007El-8g; Thu, 18 Dec 2025 02:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW85a-00073A-N4
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:06:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vW85Y-00024z-Bf
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:06:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477770019e4so2483245e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 23:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766041575; x=1766646375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=47VurGpf78D0+j7KpKwuqbjBKM8fjALl8maMHwx3vUE=;
 b=AZsQxi1aCkjbW/TsK6sX0EFnlvR47m5hNrkvwp7ybK33VWLaBEqAbg0Amibtjtrnpm
 FEDHW0YQpxUNEQgDYFxB0SpVfeyJn2KTlB5GCV+aZTd06AqTmc96Kv1WfwuCtxbdFEhe
 CAHRE+yxhDViu630WOqyotBQd+fAUeuvkhl+7RXGo+pYbF/69gwKUn51rv9o9a8cynDx
 amJSDZJRJWrraZ0ksx1wII4oHG7FvNJy2du3ea1s7GP6nIrYyvpdtu5bjpX/ImpbGpnF
 6XCm0Ums88iHouSskBOm0FqPjTu5A8NhYqcOF410/+sErcWGHa+EebB5FK41C6wK4pFl
 NjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766041575; x=1766646375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=47VurGpf78D0+j7KpKwuqbjBKM8fjALl8maMHwx3vUE=;
 b=IdezCgDWlzw9H9zc+RmHFpRTUpGMupWcHxhtTc9FwsrHpNRJ/le8GXLJJojRgNhSXa
 nwvdXPT7QiLS/KQLZA9sX7WO3g6QbZcyGZSrsnFFz8ZAwFjaP7QnqSPfAFndvQxAlGid
 kLw57TFz+RMLGwiBBFEgSopFj/1apBFiJpe5YMUccHPWzJkxD9W2H1bcfBugav3P4KsP
 Mdm06yIVeHHXp6ODaOovsipNK+krBuTfzsecdGFjOgAY2ARB8pB1V+t7E2LJiNw4kXx1
 z6I5xc5fYbvX7rT/t1bT0vfnV2Avm4rBhEgzuvE0Rsj9wUHkuhFcnMYoo+NQnzndTGLg
 zwdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDEHgWpWHgEDngtSzQROQY2KUAd1EfhBQZKWYs77MW7JwiU+Cl+QGy/ln9qZK01/EKoedku1umgMhR@nongnu.org
X-Gm-Message-State: AOJu0Yyjn0XdNLS/u8UygeQnnLrmh4fD1Uk2xFdRMIIl+prhMeFtqghE
 bsZ339/boIfCmx18ZCKwttC3K4DPCqxzsqqojD5pDwRVZehBVF69XSVTsvmxLtZlIc4=
X-Gm-Gg: AY/fxX6ZQWQspE2g8FRPT3BwUMpZLxZV6mkNfrn1SWxjdCiOO4Pq55HdtBPn/AvRZUR
 +TfbtkE5gnnPkCXARddLARUNH1Jr1t1t8qlqKILvqUNQ+sFVOeIiLFfWxVLQxHu56jgPWq5hOx1
 KI2xpLwk32ue8YkxZ3CLaYvi7bHtGjq/FC/v73Jzrtgio7SlUzlYG00pdxVDsyywygPsy1WuX6l
 OiEAyCyWHe7hxO4hTtJNJ/61iYmjCcVgyminykYt234QDACbv3nZ1+QoLXmTdn7JwzC6ydIOeKY
 80fkP0BClneOEbujlNmzOBRhdgDa0nrHCpS2OVHbsdzuLijbMcCm4C5m4kD8afnB/IEH51Gwa7+
 n4v9HM5ZN/TSpMNpm4+Lhj5pwlO0Zp9cnMUc12q/tcUqTOeWdl7u5a+xbO/mLmd5l0zORuhJ/GT
 ab2K/iEIRQ8fZECYi+6/NOHz/YjaGbhJj6t2ccW5SzS2H71A9FQiI7xQ==
X-Google-Smtp-Source: AGHT+IGroYJ6/akb3hGsy22Rlx6VXrnVn8mcVokRirLwanSbQ5hDO4F+Mqa0Ts7+XlofuTonTioLIw==
X-Received: by 2002:a05:600c:46cb:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-47a8f8a7591mr229126885e9.5.1766041574735; 
 Wed, 17 Dec 2025 23:06:14 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43244999258sm3284969f8f.37.2025.12.17.23.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 23:06:13 -0800 (PST)
Message-ID: <9c2ca60c-72ea-46ce-81cd-2f601a7ee612@linaro.org>
Date: Thu, 18 Dec 2025 08:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
Content-Language: en-US
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org, clg@redhat.com
References: <20251217184253.1520-1-alifm@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251217184253.1520-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 17/12/25 19:42, Farhan Ali wrote:
> The VFIO pread/pwrite functions use little-endian data format.
> When enabling the Bus Master bit, the value must be correctly converted
> from the CPU's native endianess to little-endian format.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   util/vfio-helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


