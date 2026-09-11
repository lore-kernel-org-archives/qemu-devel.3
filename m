Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0367BC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5Atn-0000AA-2J; Fri, 11 Sep 2026 19:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5Atl-00009g-MT
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 19:43:13 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5Atk-0000TQ-1B
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 19:43:13 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747eb79f6so2817045ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789170190; x=1789774990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=doaGtjQVIbDg8Jdfardvb/NVcrTuNt304Zj+H+pqEvg=;
 b=jPD4ZRD+TdeADOJY6amE/WTxQnhuJV/n40NNwu/noDAlnXcPviGciIrICdQiaYRIm4
 nkY2fyLUAAYRxgb7f88HWn2QB5gcwLdzHbZAWVz2DPzlVmhdwvD1PC1VdbR1JMZrVJ9i
 pWwVQbRteSs2prKEOqWBC1x9Whl2nDhTpI+HzVlaoFdEFR7bYquR4YFKUwhilCgQOOHo
 +xN/2N4W3q/yfFu/rgOe3DZ6ZxALAdKOONZCJMbRQpNaf9IgnjBbMN1gS9427jxm7tBN
 96siiIQReHQNIF8qkxZ8h8j+YHlmgWTZcLUItGk3jfLbBgbMJOTSwVv0Rtn6fuPNqmZa
 pMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789170190; x=1789774990;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=doaGtjQVIbDg8Jdfardvb/NVcrTuNt304Zj+H+pqEvg=;
 b=jB2LaQxbdVLqHX2qP8OujM/vXUkcXtWKhk9ZyEJ8Zz91r4k5cdpjiFfB+ieEmYtnVi
 rBGbAyTAOF5I6BuhrZhPg+b6sgzYqOhIxJmgfs0nvPKuLnCmAyhezZA9UaBa+4WuquCa
 ugHPXrnQNxZJ0xPoF+tIOmq4DFVRp3MD0KRURvy9KSePsOWgup/1X3CPgh4FJJWdtw3m
 ZsXsmE3JpsdwEWMBht420vXAySLmrlBdQtMzraE6ciHcd68z754c2MV+XRbj8sZsydXC
 z/IfYSVOBfEGW3wjNs0XsJLv8fJzbi7jIkQS3kcs4IY2AJxcqHVXhEtUn/1cSjntblis
 SDAA==
X-Gm-Message-State: AFuF++krAaapsl94RU6TDIRaECGIvan3KnhGFQ+BzRmsL+bUYdnqnr5S
 eRSYTZpfDKu4dCwrVDN8xgoomY3sBqGsGrPX2MkuW6sboTVjIWd9zvTF5NV7Obrgmak=
X-Gm-Gg: AYBFou2bxbpuMiKwPMuAnTOXt/2EmizFQK2qG81GPrn9Xv7sEY2bbP2MuBg/KtsFtvk
 nYGoioySD6OqJvyDf6xm9Zv1f1LYVUdioGUv9mxiZBvFrHS1ucjSM4aGLuXgC+tyMFENwKWmpSS
 JV7rJXHX6kBiSoTsW4OiOXBgFulZF1FkT+wQeYuDuGtL0l5HnSpc/Q5zcO7fUb56aCjmd91O3RR
 0lKNhc3iUbQakSfSkcKd3lj5Z2EIKAL9TpR3V2QUPaHFentjHpl06clrP8ABaXt/GYEa7zMQfqD
 VPRscHQpbWcR4GbryHbkyatt61Amqf2P8ZW1nuremfkvHRpGN8rZEObJ6bWN7w7hNwwgTpDXOwd
 QDwTO4QDpiCt4nF/vqGD2dlBJDwGo7Pkf6WKS6g1kFJcBdvrs0mRRwzHHwlfZ50laU7Sz1BZxfI
 CPxtT74bdF3ToQc5dgnxxhlAFdVC4/h89+xlILwD9VCda1oNfgA9xq0BVi8fyZeIAqSlOKXqwgW
 6odVu3sin2R+lXtpARD9u3Y08Ceeo8riTMaRjpDTAxFcEJmd647kyDU8Ok=
X-Received: by 2002:a17:902:e74d:b0:2d6:fec3:bd57 with SMTP id
 d9443c01a7336-2dd2a34b154mr114124535ad.14.1789170189931; 
 Fri, 11 Sep 2026 16:43:09 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e4fb3esm9670029eec.7.2026.09.11.16.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 16:43:09 -0700 (PDT)
Message-ID: <165943ab-40d3-4059-8957-171197835fad@linaro.org>
Date: Fri, 11 Sep 2026 13:43:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/75] pci, vhost, virtio, iommu, apci: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <cover.1789117222.git.mst@redhat.com>
 <6134ac71-f451-4caf-88df-af001641a05f@linaro.org>
 <20260911155428-mutt-send-email-mst@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260911155428-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/11/26 10:00, Michael S. Tsirkin wrote:
> On Fri, Sep 11, 2026 at 09:06:26AM -1000, Richard Henderson wrote:
>> On 9/10/26 23:01, Michael S. Tsirkin wrote:
>>> The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:
>>>
>>>     Merge tag 'qom-qapi-pr-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>>
>>> for you to fetch changes up to 2f8991c0b9c400f55897849a538580039b61865a:
>>>
>>>     MAINTAINERS: add Junjie Cao as CXL reviewer (2026-09-11 04:59:15 -0400)
...
> That's the new test. I dropped that.
> 
> 
> The func-rx-vnc is due to the test using a fixed port which is
> always a bad idea, making the test flaky.
> 
> Pushed to same tag, could you try again pls?
Applied, thanks.

r~

