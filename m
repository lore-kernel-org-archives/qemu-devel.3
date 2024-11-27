Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A397D609A1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 06:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGBVD-0003V5-DU; Wed, 27 Nov 2024 01:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tGBV8-0003Sm-1k
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 01:26:14 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tGBV5-0002ah-B0
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 01:26:13 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ea4f9825f6so1393321b6e.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 22:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732688769; x=1733293569;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/cS4h1fIAwbA8LEtB5wlviHudN0b7lmDgjqOKKV5yCk=;
 b=SXe+3RJK31Dv0IfniWJLHA45zZzK8KQzBy2C2Qq0AGgDbFDB1L4j61D9aQfXWrmwGj
 eRosukUXGstblAU7SDetT3fd70WduM3S2CXxmIe05RI5yAki54P6RLaeURFILVLQqGCy
 PirfA+DOY+0+JCOlG4arHNrmyM0TYqFigYQHr2oFIe2EdNXsFBy3hNepFDTHcJOagKeF
 Oj3uwWjTyZUF2+UCSvG2iIvVrBX6NJeIQHHxGx9eXGwdKZeevxaYqvCmEOUTSFz5x0Gv
 ysQC0e/VtNQa+mOLWl3HL1t/U93Ks1bM+7EqYcKQ9Lz0brvJVxzuUCqDBq+V6PgEOIK1
 h+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732688769; x=1733293569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/cS4h1fIAwbA8LEtB5wlviHudN0b7lmDgjqOKKV5yCk=;
 b=RMKru0xBix+0kPshp++vn9mVSVYnalmo6XAFIgowp5YxlaTIksQIpWY4GXoc3paEys
 OOqVbQebSQjsgiNj7aG97tmOH+UMjJyzRqjsleRa7/MSDmgrb1D8DSLRnSGFerJeHf8w
 RJnD3ANrHhOSlBXbCYf5KVR2Fk6P45Tl3A9ktGT6PvMDnm/c4wDGMJonmM6ZXaFGXbZZ
 FRj4Y86qWhwifgirI2sQNOhKOp4qxHzjb21ZHelnkXZAKMthVEVTcffS1VyWUWQHNE61
 Uyey6ZAFUyz8nDjUAGN50KnNwmCg1985fjQeMOJGla9rZUSFVZownkzqtpc8N+cAdDA8
 zLCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe9muwbS7HO2IgZHjXONHSC5qPpqYiHpuU5Es+Krf+3s9XGp8Zgu8dq3HE75RJt6aD/bD/VKMPL0K1@nongnu.org
X-Gm-Message-State: AOJu0YzroI56+ug1GViXt3L2rz30t2A05lyreO6+00h2PS+zwZLgyous
 BsV8kiImPW7FermzDDIycHk5e70R4+RcxFWOA7Bchg31uq8K6v5H0A5gxIw86x4=
X-Gm-Gg: ASbGnctPkXU/MBARcfkK27FG9b7UKcvvLV3L4KhmeP6t+NDhfOMDq2xoBT8+OeFStl1
 iiivBNVgimXurpL0DK41sEZObEwrEmbhLkR9vfov25stKUp627bECa1gnVL+JKQub3lcoUpbOqI
 vXzS9H4YBXqLAc5RH8mp4TrMhmkpETbTp2q1IcDm5b6qJWYM8drw23xxVNn53j5VWlqsnTw8z1x
 8YdORyowGI0cTocKzdoRxJfCj/MB4UeIpJI9bAa4kgC45WTMYVScVbl4bwKgRE=
X-Google-Smtp-Source: AGHT+IGsXLTd/7qFiRn8LX3UCFwKrnjsLKtXQtXsgT5kcGKTRO7fuKOZVGd148cUI4eXLLrdnqYRxw==
X-Received: by 2002:a05:6808:22a2:b0:3e7:c7c1:e6cf with SMTP id
 5614622812f47-3ea6dda7194mr1805518b6e.43.1732688769611; 
 Tue, 26 Nov 2024 22:26:09 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcbfc0857sm9813500a12.10.2024.11.26.22.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 22:26:09 -0800 (PST)
Message-ID: <3692551b-4203-4050-b976-04746f6db3e5@daynix.com>
Date: Wed, 27 Nov 2024 15:26:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/15] hw/vmapple/cfg: Introduce vmapple cfg region
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-13-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241113142343.40832-13-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/13 23:23, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Instead of device tree or other more standardized means, VMApple passes
> platform configuration to the first stage boot loader in a binary encoded
> format that resides at a dedicated RAM region in physical address space.
> 
> This patch models this configuration space as a qdev device which we can
> then map at the fixed location in the address space. That way, we can
> influence and annotate all configuration fields easily.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

