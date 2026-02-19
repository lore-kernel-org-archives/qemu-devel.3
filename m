Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439D2E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt50n-0006lR-Uk; Thu, 19 Feb 2026 09:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vt50c-0006kZ-8t
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:28:03 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vt50Z-0000q7-Sv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:28:01 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4094b31a037so578876fac.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771511277; x=1772116077;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fV24LqBketLmQXEpDnJr5l+sg4uafkBtnDWCe8W1dWg=;
 b=bpY8F/r/mueUwYSM4OyX65orL4wastZHlA0NXmX4XmEL1rDIfHcpFDDry2fLJJ1pyv
 5IF7nci3asVOy5FavnXGdpEwsl5E74huqXlusEOwyIYE3j4hH2frDa4ogeQLEUIKecaE
 TW9K2By63NHKxmokO1lj1k0H/NHp6YK2ttP960yS07Ar9p7uU+jQCrXV682nKtFHuHUs
 DGstBEKDaTvixgEdWSgZei3mR2LVWMxbqDJt/WDlfoPEX508zUgiCFAUcmVMSb+XxvRv
 L/Hi6P8wYQoQvfFOMFPG40e6gNVQM52amr7wfh58yXqFX8h80MIG9Yzjph3/NbM43chy
 +CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511277; x=1772116077;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fV24LqBketLmQXEpDnJr5l+sg4uafkBtnDWCe8W1dWg=;
 b=Qm1Y8G/uFNVSNuloLagi8vbgkEv9chKCjdZqHtgOZ01HBf3X73cyM/3nLJfTLYhVaU
 pThZdiFUEkq7QH+eJfdb4NAF35WSKFwGB/8hXHMqwJN5voUvhvCD03YFNhGITE82AQwn
 ed1EF/M48c1EJsC1KTBg95UGMvyP2jwpATmNj7/NtTiRs6VkVp8+33Z3oY+jX2RSfAsv
 7M+Dy2cS5y79p6FLufW6p/W9THAAVJHsxfZ2mFFjd/9m+EqjVVVgXLWFlX9brvdmTOie
 HFxEWRZjEUeZTF/dyzq5chuTpHjQmiJ1w8vN7RpEaNKPQhPMjRDc1LIZSBdp98xTCrLm
 3lzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUlwku3IFH8y8CsI8Qg719vh6U9ON+2HZrCBOzz71IgKZ6w5U3vzvtOStMajvFRsHaZbfFKkHcKpk1@nongnu.org
X-Gm-Message-State: AOJu0Yw/HdRBtfUonLYAS4Yx8nX0xZ6SM8Fa9YIYHJoIp70wI1uIZDEt
 nGgnSz9SbPmXJr34ggH/K6trWa9Q+1ZK1Su04Vbk1Cqak5qIXRiSjnsIhryU6VqMxh0=
X-Gm-Gg: AZuq6aIGm/In4c0gmUfwAF290rIsWkJeBtoC3APOXlRliUTiHJnrrLZKzvAXWvDUguy
 E2okUHdh3I3yUv65w03ULqyDw/z1TBsCH9TrbRG9UadbiM7u7/hBzPajFaNcDBPy/jpxIqw38Jw
 XLSMTSyFEdMZTCPtPC9BcollESlX2jpOuq6ZaKL5vmWblJnQi4T16IUrfyITsGNn2NeBOYbB/g1
 svhfvedHNF2IkmbVtSourgyAfPQYrRep3PM8dQ/av7dtpClMuRDaMaDWvDkIfSz/d4adco9FkPh
 zbxJdyxZah8qnNMmD8BDUZqesX46iqnGdEKhmCHp5ZSLAePjU7HgEe6iesV2v4wi0j08QeycYQY
 Dw4wFIXcFGzxtDZZvzTZbzIr8P7ZPMdWEP8pvHuL5fxLsNObFzwDWLdMbhNBsnM1V1eNzPezbwP
 P8r/9FPjcpNoetjnMb1R7KOtGy1fswSq/0QHLqA5Uv/XNe6EAWFjDKvK615niRlaGo5g8F0gfGF
 gjL3xqYiYY=
X-Received: by 2002:a05:6870:1714:b0:408:882c:90f6 with SMTP id
 586e51a60fabf-4153a28e368mr1888922fac.57.1771511277025; 
 Thu, 19 Feb 2026 06:27:57 -0800 (PST)
Received: from [172.25.209.35] ([187.199.77.89])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40f18df8a64sm15458632fac.14.2026.02.19.06.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 06:27:56 -0800 (PST)
Message-ID: <f4b12328-ef79-46a4-8a0b-0292d6b5ab3c@kernel.dk>
Date: Thu, 19 Feb 2026 07:27:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aio-posix: notify main loop when SQEs are queued
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, fam@euphon.net
References: <20260213143225.161043-1-axboe@kernel.dk>
 <20260213143225.161043-2-axboe@kernel.dk> <aY9Lj1BTVRCFyfic@redhat.com>
 <c32915a9-33a2-47c5-a91b-27f01147918f@proxmox.com>
 <20260218161127.GC587447@fedora>
 <d729df1d-ba33-4cab-88c9-ba980cdaa37d@kernel.dk>
 <07d701b9-3039-4f9b-99a2-abeae51146a5@kernel.dk>
 <20260218205731.GB605390@fedora>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20260218205731.GB605390@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=axboe@kernel.dk; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2/18/26 1:57 PM, Stefan Hajnoczi wrote:
> Thanks, applied to my block tree together with Patch 2 from v1:
> https://gitlab.com/stefanha/qemu/commits/block

Great, thank you!

-- 
Jens Axboe

