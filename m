Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B92C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGQ4-0004qr-BP; Tue, 08 Jul 2025 18:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZFq0-0005OZ-VJ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:26:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZFpx-0008P3-IL
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:26:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so29560895e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752010008; x=1752614808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mj62iE3xvIhy4oJ2TkanIiJSkBpd3fDhboJjZRfVaSM=;
 b=Qal0vdr00B8ObUs6l6VIu0HoJUsxgOUrMYcvzOdr4Y4fvoLpGvHb8WTLHPr5JDL7EN
 VMalk7jqy5ptyMBsjb7VXn9MGRVXlJWLsmC191ihqilqRNeBOWtR9OKJCc/d3zlLBdtt
 L63m3hSEz35oQlH93IFG/WaNcsf82PLcrsvrlBk9OB7h98/seKDrUYPt233Y1gqkCK6f
 g1OgKp6Y47j8XUe6/T+SA8mRqtaL07kfpTbGBVN2BHOw31ZTElsFTA/CQLOOiKAIWIWX
 4xC8Ka48mOuAMxI04HzCJBZWHNsxHctjhYFaT+tv30KX38W7t0wNp0eGcYg/gxBHaxQj
 0yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752010008; x=1752614808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mj62iE3xvIhy4oJ2TkanIiJSkBpd3fDhboJjZRfVaSM=;
 b=fWcR8wNXOhrYv/GC2d/mTkT7h63sd4XpSlQkHttNN+j49wP0fVi5+oF/LqFr9Hb20j
 Nnp2dPqC7kPgtTR2RqN3VOYxB8CgJB5vMecGj9pI7s0kDz5BJOprSGS3f6ZAWdj+CBNA
 StE2pnmHzpPLVGESJynVmJq6O+4org9BdiArVT2woNwLYilwFHEHT9PAaoFjJzrZK6D+
 92c4hclhQqZG08Q7TLKoxWSVuITS+exIzHNAz8yrpv6Ort3dwze7PAG4VtUk9T0DMcMg
 hGLYEr6ADEE1/+qrFcvs8zftCrmHec0SlFWJ+Huk+rnaFxj+O72G2WbPydfkHV982Sg4
 cCpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5fAcqxS16JFYcsxZibB6mXReQMfF0KVAs6jfh+dXhwsdcZXN4okN+yM5aQ3i1OQVCj+Y8SkqJ9EtI@nongnu.org
X-Gm-Message-State: AOJu0YxK690fuu6APumnDNnFsl1WwI0nMuZ7IpPPHTrgQLS2Ky8US04u
 sYDwtTyDyeoObJlnAekmydDoYsfZp3bwMoI/VO7ZqBhNq531GRsIeXpWTPGM05ZZwt8=
X-Gm-Gg: ASbGncuhNV/CGdSO6ffQl1Dv9wXymt1CevENEpMby4svDEO+WtTZ7If4EK+MhBnlEeZ
 +W7uxppCnUCE8AeWC/GhBDgMi0+EcqD9l0nkReOHbmXuc5O7iRrJqKJPch25wkkrtZaiNQqK0a3
 cp1jxWGF/RUXoZMG6e4Mirp0c8TmgAza4mjam+PyrMXf5OrnGhy7wJfNHyKjQqFbEYXO7tfq9cD
 FSkK43/uJhC3Oi87eGw5WDklWbHtL0mzNBYp3ZFISYvR6KDSDacDrXHZ7hLEH3zwpq3kg8/oyp1
 4/iLBbgMEXSNWLNWd2v6amHs2fm5RHsKPCOGZKxkyhhonPZL8ijNGx6I+SJAucqW3+4odRigOn1
 Qq8PpSYi0U/yaLn11wyOBCcmQV6SKQVNdjlPcMohn
X-Google-Smtp-Source: AGHT+IH7rikhE5eGoGKvue52ZLKzQXfj4RFx6aAaqSoMDyaSOuJYfO3dAWy220MnJbN3DzViz650Fw==
X-Received: by 2002:a05:600c:3b01:b0:442:dc6f:2f11 with SMTP id
 5b1f17b1804b1-454b3169103mr167683295e9.25.1752010007660; 
 Tue, 08 Jul 2025 14:26:47 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5dfd4657dsm2381214f8f.17.2025.07.08.14.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 14:26:47 -0700 (PDT)
Message-ID: <b1ff31c4-25e7-47a1-9579-095e7978e4a6@linaro.org>
Date: Tue, 8 Jul 2025 23:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 4/8] qemu/target-info: Add target_endian_mode()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-5-philmd@linaro.org>
 <d182e9ee-afae-41fc-b160-971cd909b9b9@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d182e9ee-afae-41fc-b160-971cd909b9b9@linaro.org>
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

On 8/7/25 19:36, Richard Henderson wrote:
> On 7/8/25 11:19, Philippe Mathieu-Daudé wrote:
>> +/**
>> + * target_endian_mode:
>> + *
>> + * Returns: QAPI EndianMode enum (i.e. ENDIAN_MODE_LITTLE).
> 
> s/i.e./e.g./

TIL i.e. vs e.g. :)

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


