Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F5BC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWv4-0000pR-PE; Fri, 07 Mar 2025 07:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqWux-0000jD-2z
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:35:07 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqWuq-0006T7-Ck
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:35:06 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3912c09be7dso1063175f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741350897; x=1741955697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BKuN66wv044dIn1KLjrdWfR3uuqkDA34AnpzetfvukE=;
 b=txnvPAvqMwlENIU1jDTBkbXa0bBCC7UhJ++C/c/0pzpXGt71qk5CBdysybtY2BvfU6
 EcBueYRkEgrZJ2gOnxbE11Y7JsYnKLCyqTmfrWXVAAPuqyn36j4dfBLesBkMPEDi0MQf
 E+RtAdHv5Eq8+QSEn00XSmZw1JuoANEyVOUnMx02WtuE5RA940dpHcebA8E6FF9fdkrL
 9g8rFi9CdAQHWWwBKB4diefebNhaS2tteGAXgf0t8Xq8uqCJfooDyCUoR9QtB00wOi9K
 /CvLnD/MQBPaOSh95qMl5DflStvD2SaciVmspHV8EHpwGEPc+Q9+uYyKH48DidpxalWD
 xGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741350897; x=1741955697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BKuN66wv044dIn1KLjrdWfR3uuqkDA34AnpzetfvukE=;
 b=KLBBE1J3xKEgZAc1MNPr2pe6/m3dY7LUhiQMW52Iq5JWDhf09BfDkovJu0bB+Ieizn
 dJa3lFlMl8RK2ntqwJVkHYy3RR0DiuThR5ViGAMiLac8AyevSbujCHQNbfv6JDDvuQqs
 f8SB9s3Ef22naN1eZfw4mKjZlLwgToAWtzLQvSR9pYM4YnuvlnLnHM7yUWcvHq9aDs2B
 cEontD4hAFIfjbsd9tvwQNFeSWgPOb7DIc37I85/r545ahN2ye4v8grrfdwslQb75+X7
 3rWn64M7ADwsfQVD7CV0DfJ1qr6MQdit+8+yeoIIqZCrGBBjh8I7armp1KzGXcR2c9Ze
 5Q3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW25alg4R/GA9iZCHKRCjuzREzmc51nrYCkseaut7GjJGk1RTH+/Qy51s9ORwu6gspPIHJ4nFKjNRS@nongnu.org
X-Gm-Message-State: AOJu0Yyan+9iUToEjYPFV/IZ3YID4LBpVlRUk28ywx6lZmSq9XnWgXQr
 EF2c85Yys/KzSo5A0xKpiot6ttLKCOLsclYQaKlgiTzRWwPwtxyuB3Fq38+vkPY=
X-Gm-Gg: ASbGncuGjDi95WBw0i8DyiXHPMlokqgzuUN1kch/l2c+PDT2Z45kfgvDZQqS07+/JC2
 OKP4J8c9uvjzqEvjMo8u29YxMPYT1iUrjjv5lwIU8OBmHzUZeOa9Q5xEDrHNOCP9qh8dgpOp/Dz
 txpPBglqTf7TezNKgD9f5rN/mQnCmZEbV80AjNPPlis2t6ex5Hx8UI3t5vin9teaeqlYus4UB9R
 rpeVCGi2RZi2rayadRA+IvCNNUA1eMcaQQXLkLP8DcL3PyW1Gnx+frJS+FzTptUmjXISOhgFY47
 AMXap3iHFOs8CyjnaGbYwa8any91yJUHhuDauFHDKEdgf1JzLFwVGRGBg6ojqYd1J+hrrddox8q
 Ss9b56vSq6+nB
X-Google-Smtp-Source: AGHT+IF0umeJTup3v42XHUUtfvlx6j2HIMYztLMFUq+WzHgsk+gLbqUTXqp3lDHwxo7qOzyYo6VqUQ==
X-Received: by 2002:a05:6000:4108:b0:390:df6c:592a with SMTP id
 ffacd0b85a97d-39132d38302mr1887655f8f.29.1741350896834; 
 Fri, 07 Mar 2025 04:34:56 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8de4ffsm50559865e9.24.2025.03.07.04.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:34:56 -0800 (PST)
Message-ID: <69bc17ce-de05-4b4f-88c2-57866c6409c4@linaro.org>
Date: Fri, 7 Mar 2025 13:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/15] tests/functional: fix race in virtio balloon test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
 <20250307115314.1096373-11-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307115314.1096373-11-thuth@redhat.com>
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

Hi Thomas, Daniel,

On 7/3/25 12:53, Thomas Huth wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> There are two race conditions in the recently added virtio balloon
> test
> 
>   * The /dev/vda device node is not ready
>   * The virtio-balloon driver has not issued the first stats refresh
> 
> To fix the former, monitor dmesg for a line about 'vda'.
> 
> To fix the latter, retry the stats query until seeing fresh data.
> 
> Adding 'quiet' to the kernel command line reduces serial output
> which otherwise slows boot, making it less likely to hit the former
> race too.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20250304183340.3749797-1-berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> [thuth: Break long line to avoid checkpatch error]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_virtio_balloon.py | 26 ++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)

This fix isn't really working, and is more of band-aid IIUC.

With the following patch restricting to KVM accel, do we still want it 
merged?

