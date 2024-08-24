Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDA3C5321E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 01:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shfyi-0004Hd-Mq; Fri, 23 Aug 2024 21:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1shfyh-0004H8-BO
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 21:54:07 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1shfyf-0005Di-Gp
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 21:54:07 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7094468d392so2019758a34.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724464444; x=1725069244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vtsxOuCEIOBtg37eB2MYHjiIDZeU7tY4zt5r3GPCBT8=;
 b=Y73cMFGuQIXwtC1N6LtnYzcFyXTbzB+vvRorV+K4bgTvpub2zG/imHRdql08LvmdxM
 3HNrBEUiYoIyKRc0GoPps+PGbtf+LQTBmReJySqAE9rJclWe1B7UdJv6vw/Z2SIT/Is+
 bsa8jLr6FwDrbvM2APozpEjIAw3ZmuTtjK5cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724464444; x=1725069244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vtsxOuCEIOBtg37eB2MYHjiIDZeU7tY4zt5r3GPCBT8=;
 b=mDQFigrqXcpa+3rCuf/AX6QkYTya4WoaCIj6Ml5csK0OOU1PYhUY5dS20CKBDD0iWG
 gIwseBWTKG/cyXkuTyknkFnlPKb+ZbPtP2klwH8e5mYLZsBlitzcO/J4G3AUQ3j3YMG1
 iHDWnu2p3/h5U5ZEzKesI4dfhQrfWnyzYGAc0N5A8XuRapCvpuRKGqaU08KfAwJ5isPc
 TfGD+tDQ9dQqnjwexGTKvcHtlHDYRqTxksoxZJRm3RhG5KZH0S6sCrQzpoy2+dX2lulO
 KFGvYXkjG7yIYhkAe8kVN+t0TNaIh0R3lu2eATVNyMtm4NuGVt74qOjatH4eMJ24IViP
 puxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwtN1torgFCCo8UmvBzCZWO2E92LfIHT40v8Iu6O6I0i9oVIqXR0fcyfdxBZWo+bnbbAn2yHIdzKrd@nongnu.org
X-Gm-Message-State: AOJu0YwwfWp0a1x5X3T56tkywzMC35sGhRX14yar3gUWAqzKZpiSgSE3
 d5+SoYaqbyqyqlBAkKg2dyszWQY40j9jamRIcBO4puHWuyy4SZ2LJk/rU7ERE9I=
X-Google-Smtp-Source: AGHT+IGcmgdfMx2ZCEbrlv2LcedlJSh5ttdSfKqzjcICbuqU5xNaW8HiFRgxHGUZdN5HaJRVIKVktw==
X-Received: by 2002:a05:6830:7307:b0:709:3c5b:effb with SMTP id
 46e09a7af769-70e0ec01a92mr4954303a34.23.1724464443647; 
 Fri, 23 Aug 2024 18:54:03 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.200.153])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2d613941e79sm4892550a91.25.2024.08.23.18.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 18:54:03 -0700 (PDT)
Message-ID: <5aef262f-b1a7-4317-802e-8681451ac54f@schmorgal.com>
Date: Fri, 23 Aug 2024 18:54:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
To: Pavel Pisa <pisa@fel.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20240816163504.789393-1-doug@schmorgal.com>
 <202408210857.20254.pisa@fel.cvut.cz>
 <fdce5258-59f7-486c-bfd1-a4befdf72e3e@schmorgal.com>
 <202408220311.01551.pisa@fel.cvut.cz>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <202408220311.01551.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=doug@schmorgal.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Pavel and Francisco,

On 8/21/2024 6:11 PM, Pavel Pisa wrote:
> Vikram Garhwal is listed even as whole CAN subsystem comaintainer
> 
>   https://gitlab.com/qemu-project/qemu/-/blob/3472f54522a928f0020d6928d54c007f862c5478/MAINTAINERS#L2690

Unfortunately I am totally new to submitting patches for QEMU and have
no connection with AMD so I can't speak about Vikram's situation. I
agree though, at the very least something needs to change in the
MAINTAINERS file. Maybe Francisco knows more?

> But I would be more comfortable if there is somebody else
> who is willing to be at least my backup when I am on some
> trip without Internet (hiking etc.). I am quite loaded by
> teaching etc. and all these my CAN and in the fact all my
> open-source and other development projects are mostly out
> of any interrest of the university department where I serve.
> They would care a little if/when I bring paid contract from
> some company, as we have from Volkswagen and its subsidiaries.
> But it is long time ago at university and even longer
> at my company.

I'm very, very new to QEMU development so I think I would be a poor fit
as a maintainer, at least right now. I'm also not affiliated with any
big money companies. I can completely understand that the subsystem
needs an additional maintainer though. That's a lot on one person's
shoulders!

Thank you for reviewing all of my patches, Francisco.

Now, all of these patches are reviewed but there are a few other issues
we talked about here (dlc2len/len2dlc and issues with the flags), and I
also found a FIFO issue. Would it make the most sense for me to submit a
V2 of this series with a few extra patches tacked on the end, or should
I wait for this series to be applied first? I can do it either way, I
just wasn't sure what would be preferred.

Thanks,
Doug

