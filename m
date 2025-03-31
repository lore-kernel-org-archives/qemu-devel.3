Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9ABC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGEh-0000nn-VC; Mon, 31 Mar 2025 10:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzGER-0000kg-VD
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 10:35:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzGEL-0007mk-8L
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 10:35:18 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so334855f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743431711; x=1744036511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yxoeJvnNk0SvKNd0N3DxwbMRQkbxBphdBurkZSyhJuc=;
 b=tgEWWykpEcTwIFCip/2DWz1oADgT6XiR05W3v5GwFJtTAWLzE3H2A2QTq3MsdboMwX
 YjocktqW4+DPKJgWRP6+YR8Im43HY19zR1wHdwcNdrg4u4CT7xDOqZy54U8kFmUtfqmg
 IkLToYRmnJDeIUHOZEd+Zc5x6bB7qbG5m2zgDgzj5KDRjJrzQGsNMfU4T/j+z1ZvGNhs
 qjZZ1mhmBiyxJ7ONfw8ZEcYm205FKflBvsIouMZ62EmNV9KsSbkvJEhQHVeJker4pBqo
 DWGWZA0bnTJtzfe7JerPcIHsgmQHokZCDWleuGi98Mbl3II+C2CvVMBACMX3gT5ayqJv
 aPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743431711; x=1744036511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yxoeJvnNk0SvKNd0N3DxwbMRQkbxBphdBurkZSyhJuc=;
 b=hJFzCdxR+QGYPMfwNhee36BQyY03CLO0ubnb7+MOOvD1o2DhzC+0tE7235qfYJTMoU
 7+t7BRb/W6xmVJD3oJrVnqkWZesp1Sl5bH3XpR8jPvUMw89L4Wko40JmGqSrZqSN4a5X
 pvu0BcNGFsvrfaBiCquUyFqzh+t2/W5/QdBxV/xcjkg257jxlUH6nDAB+VJZunX5jTfM
 ODr4c8JDMppCwrfijZRLP6GaNoSnQVSm56LBusCJqKgAIyBc4FN/yZV0/A0nyy8oP9uP
 yq5hEO+53ubJMQil1D5Fd7mwYab+VtN4f42IQZgtaxtB+JmaRqdBkwGVomN5nsk+6ts5
 Ea7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVRzYDvLIXjE88wK9xibfDdjiuQk5oiFHIZISoS0ttHf0qBs1T3LfZqjdSU632OWobGT6ar4seYYqD@nongnu.org
X-Gm-Message-State: AOJu0YzyMA8Inr0DiQ4cdAg3zHcOA1+GqkkpO+v3wcnxF9QbfoaA+iW/
 sQo09UVOLfkA5OiIo7H/c8Y12lItvLnHqf7oOLOIARieBBgYu/zZ/6V5mbCuZ9I=
X-Gm-Gg: ASbGncvv22Y76TviYu1WhdEuDsAzn3TI6agtsjxD4+XCBgD5SMjOBNzCRaYrKnYMtGT
 FTs7vb3glQjmwPTHFCyuKlQG1kYZxIOAystFJZL40w/kWr91ZqW2Mdm5VGzeoQRa1KrrE9vJ/mu
 HPgOA0dTXEecN9HhP/NbMbchwjY+eHnZrLJ6yaQvSzJ9gr2VxSlTGGfcbUdi1oyhr9/dLBFTSkw
 9iDDXT9c9+Y5fNxtOuiYHqgGbvM5RdP0uI1BpHP1aLK9W65zK6nY40Ksrb6sjAyC4RhPMkFNOPs
 ocXVvhaWtT1wAE4tM/e/sG3Za1tvTSaaEUtD1gmT+HbQMU1/zOv9zvO9dvsq0U05NyrrmFGCbfF
 vbor6c3uMFh9r
X-Google-Smtp-Source: AGHT+IHC2Qxdse5s7XWkCmdEI92ShcHniGDPOLUPSxr25Rr7/HMQkbrFswtP4+fWibK4/XHijwVkgA==
X-Received: by 2002:a05:6000:2a3:b0:38d:cf33:31d6 with SMTP id
 ffacd0b85a97d-39c120ca789mr5718341f8f.3.1743431711119; 
 Mon, 31 Mar 2025 07:35:11 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d900013afsm123996805e9.36.2025.03.31.07.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 07:35:09 -0700 (PDT)
Message-ID: <62cf875f-6a33-477d-8b35-7f130e4887d2@linaro.org>
Date: Mon, 31 Mar 2025 16:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 00/12] hw: Categorize few devices and add their
 descriptions
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 Samuel Tardieu <sam@rfc1149.net>, qemu-block@nongnu.org,
 Patrick Leis <venture@google.com>, David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250325224310.8785-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 25/3/25 23:42, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (12):

>    hw/block/m25p80: Categorize and add description
>    hw/display/dm163: Add description
>    hw/dma/i82374: Categorize and add description

>    hw/misc/pll: Do not expose as user-creatable
>    hw/nvram/xlnx-efuse: Do not expose as user-creatable

Patches 2-4 and 8-9 queued.

