Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ECDD10F22
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 10:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOCkq-0004GX-Ok; Wed, 26 Nov 2025 05:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOCkp-0004D3-Mq
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 05:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOCko-000858-5N
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 05:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764152885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=29wbdU4iF+z8wqazZSAKxIB8pePK0D2H6hda8etchK0=;
 b=aNmvDuQJdrLAjTESlmM0KQ2WFuySotz4R+ewsB+p3bS0uQNl84FnccuB4rEN5uVVZblNs3
 tMIgFg/8mLeQOKeFpH6KyxPEWSqI6/3/JpQEm/5RvRnFjbPGvK/MCHBP43uS85JAgsgj0D
 5GPwsZSizgC34fiHkESo9Bw+wviTh0s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Uh19MHlTOqqUMRk0Dnlmog-1; Wed, 26 Nov 2025 05:28:01 -0500
X-MC-Unique: Uh19MHlTOqqUMRk0Dnlmog-1
X-Mimecast-MFC-AGG-ID: Uh19MHlTOqqUMRk0Dnlmog_1764152880
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775d8428e8so51037145e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 02:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764152880; x=1764757680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=29wbdU4iF+z8wqazZSAKxIB8pePK0D2H6hda8etchK0=;
 b=paZH/pxaqL6HGRgPOMmbSUJcWWDPZcjOyw5wKCuAQ3LRuliRdZeKVuUF1yDUe4oEjc
 Cw1fVYS/cDipYP7/hs11Cpub8a8Br13SopPNL1uP07FA4P2dthyhECebFk2OoGdI6ul3
 /I/IGWPjYkanP3btVGEHItSJZKsH/xABUcRJX/KtYioS7W1ECWKyFUUtpedcM/VhXERJ
 RXoCHZcYVlQxpmqsBSjvRM6MkafzW4hoXEzD5I/eRzZBFA2c4EAtXexl7OZ+Pb82kk6J
 6nNuTBA9zyVOLchEoY4CBfw8slnR9Tp32ALpWJNFZZYrPdg+ntlN/ZHe+6X5K2KcvP7G
 3Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764152880; x=1764757680;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29wbdU4iF+z8wqazZSAKxIB8pePK0D2H6hda8etchK0=;
 b=pS3TlF4nDXPfrnHmPuEL9s/xRJ8N6y3fDsgLTjQcp+7L1CJg5S8DOtwsuHefr4HSeh
 wws36jsbLTTqz8aZkLTX6MnIW2THNFl1eQI8WQ6PNW2jbX0sK4t0rKI+OQMUOcW/6+K6
 Hji/3QlK6Qzq0ZUVl+MC5EHuF409LC13S/U5qgQrJqV8HO6P0FVMsUT6LDLV9V+uFE9d
 sXHHQR0ondPoEnaVc0T5Rg22MtrLAiVkmqIeYrkAH7b48uwnON8PA1c+jo2RrYeCK3sy
 AcuWl1cypgdKgUsf8YcoVlZYhkoRhOLKByopqtIktpoSPFwNPWMH1xtCSbt9hV8pZjsU
 A+JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj5+hFlzRu2NL5KiDxbwKDeRZbBsK7eG7p9PJN8g2NA1+fV1paa0JPLEv1fKPdN/PbvKYuNnQKRbUC@nongnu.org
X-Gm-Message-State: AOJu0YzQrpWX4SK7j5CphZgM++kl9fdt2IHhKWYBZg8n4+grMGUz7MbY
 FB2XxurdcJoM3y1AS6HjktIFoPNh/kPQTn53XZVCru3IJSy1yTT2MI/iC+rNjr44V4RvAX9QQj3
 DZhVYdRLgGoZAM9/CMkvqmLwyP4jK/3on7U9E7qBS34OuigCtl47L4hyR
X-Gm-Gg: ASbGnctsrzjYDh9QmQAXzwFdiuQEJV2bEfvosHgE5OAd2bwhgfm4sNbVBJy6ylxlKc1
 8GF4ne4itWDoSV+wg/ROstm1b3sdDTH43etNwbOxYkh+V4TBcCTUFQ8YecmPriVR7kwtSPDi9tj
 pl6FQhlYMQ9XCmUfMQvroGIC0v4A7d2FC6iOdT7pkyRuiZdYJItmZIag962BROcGG9oNyghiIhk
 Jw7z2hgr2XpOpouYML428PZpSxFgTNM8hg0rQ2Lcxx+ijwWjuGU/3I/nz9xSD/MSeAMPA2QYebO
 tasdX37RmRaWFOM31jisCmY3MQ/kB0igy3Xqe/DKAAulhNhjjM1UHAUekWZZGbmLAtIMHnNCzWj
 BO4qIJZIg1iOlvNCJi9m5Q/UamWMZazGnpLvFsXFWCO2UI1kV
X-Received: by 2002:a05:600c:3110:b0:477:b734:8c52 with SMTP id
 5b1f17b1804b1-477c0185bebmr205149305e9.14.1764152879696; 
 Wed, 26 Nov 2025 02:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLcNoHIF/bz7pPOkuikmhUNUzMBHzont78aC3Fjo4e3l1tpgtQe0VK0cpUR2eQcIEpcG3V3Q==
X-Received: by 2002:a05:600c:3110:b0:477:b734:8c52 with SMTP id
 5b1f17b1804b1-477c0185bebmr205149075e9.14.1764152879330; 
 Wed, 26 Nov 2025 02:27:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790addeeaasm35969205e9.7.2025.11.26.02.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 02:27:58 -0800 (PST)
Message-ID: <5ce49d32-cabf-422e-a9f2-2972c1b4fdd9@redhat.com>
Date: Wed, 26 Nov 2025 11:27:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed/{xdma, rtc, sdhci}: Fix endianness to
 DEVICE_LITTLE_ENDIAN
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20251125142631.676689-1-clg@redhat.com>
 <b8170e28-e4ba-479c-bbbb-1b94a2fca81c@tls.msk.ru>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <b8170e28-e4ba-479c-bbbb-1b94a2fca81c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/26/25 07:48, Michael Tokarev wrote:
> On 11/25/25 17:26, Cédric Le Goater via wrote:
>> When the XDMA, RTC and SDHCI device models of the Aspeed SoCs were
>> first introduced, their MMIO regions inherited of a DEVICE_NATIVE_ENDIAN
>> endianness. It should be DEVICE_LITTLE_ENDIAN. Fix that.
> 
> This looks like another bit for qemu-stable.  I'm picking it up
> for 10.0 and 10.1 series.  Please let me know if I shouldn't.

You can. It shouldn't harm anyone.

Thanks,

C.



