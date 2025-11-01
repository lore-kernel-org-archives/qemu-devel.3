Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430DBCCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 09:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF8GM-00013C-Uw; Sat, 01 Nov 2025 05:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF8GB-00012Q-QE
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:51:00 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF8G9-0000Yh-CN
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:50:59 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b6d3340dc2aso808495566b.0
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761990655; x=1762595455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WN7XdMQOe2ash4cXQyh/Ip1hnGOXVQhLeInYIfGhdmo=;
 b=f7E8tsTvYVxfgRcgBv4Pv/jQT28PBQPsgZTMaDHRmqjBLPks/1bxfjKiAh+rHWIL8r
 nmqCwyArsVFvFKuJbfjwVq8tT9fgzXjCCPF3YezW47BpBN4Pw+nsEMcTQczWVUGa02SJ
 ibTbv2VNFS1/pckldY4wYpgZS1ZTBgmYWlknkIknmCiz3knnLJiC2Z8y+/ddv7hWgW0K
 0tQK1WindacgtJB9FVc4WN6ICKNyDuHLpIhaRa0yEvCQ6YMDiKQM0MFAmAyRhm9OdvNd
 bC8n0nesVpC/rdRhjr8TQD5ZwR28cWjqAhBiC9ZIo6lGR0HL6C7ps/4i9W+EexK2Rqxt
 hdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761990655; x=1762595455;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WN7XdMQOe2ash4cXQyh/Ip1hnGOXVQhLeInYIfGhdmo=;
 b=M3SK0VGRKM4Z9iabDljFk7Im3KCmT8ohgzQpBv7RbuPgM0HAqoF8Zx5nMD3u0vs2gK
 tG1Ub0h+CWZcOasfrNyPAp8VitvbXIZ5GvYYlIxfAD2akNgpLwC+yn+DUZNW3712gbI1
 VqzPE4YQPtJp1Ryblh3uZ5awhaJHJ8+fL7geHijU0mBOJCK7fLAnOCCTTOGVGaV6roBE
 zopnl8803E8Uj/pfz05ALjIk5C9JfjW+AWerBwdKrdX1pnuKZDKPODCDdl63FxUWWJsP
 Jc5ks1+ntNifvHlmORIDbiNZnjeKWtzaf63/kfZqPBlJPdEmTA9DA9Ls+52dYfCW9ZZl
 mAVA==
X-Gm-Message-State: AOJu0YwZhpOf+RWJQhOG2BDphWt7qB4leXQWQ5zlkTSuF2G8jA2fxaCZ
 mEIx04ylAlZQ59zJDfTbhEAW+kXnTx1EdSYdo0ZrMd4UGR5tVI0obtFcKSOiotLAvlfL6hNTInd
 Vr8aPgm0=
X-Gm-Gg: ASbGnctJnDfXNviDgD3e3JFImmo6LWBGJRwwPqdJexBg37rme0hPU+FVlUXnzG6+AQv
 7vTPnqZ7q+KJlh5Z4XrMeoWenDwcXl3Tj89oQ6uJ3qczPEGoGU5Yo3fPPPJbLHmq7HqvlxUxJSd
 Ct/N48PHrrxKvZ3KFS7y0OaSjbdb0oKjgba4kacDCkOr0eYE0ImkQkgLfzkOuUgWMTwG9ozwrLR
 5UuJ3wmw9PcmlYG/zNSr4DE+pnQDaNNUuGfmgkO/MagUJhn1dbY9zZA/wxMZh9LH4ViBd0nfT7Y
 Ml2t8kce1E1sr7EradgabbWbBPr+sCUPu2jQ5CmT6+FdLR2flMMnXu5d0C9bK6NPpM59r5ijUIC
 gg9Q4D7Z8WrLHkUaWIgtCCozYy/QBCyiElxgAipDYzqJl3xAW+HM1T/vo7UZCl+8f9GdRiUPqDb
 VLRmHtDuiQSM3Lqo/sfkhWBfgFUfelm1JySy+UjBEx5XHdCDnKG3s=
X-Google-Smtp-Source: AGHT+IGcwRYvRjEjIIxKfMVS0/FuU0+A+cTFfsf8x6JZXaT1yzt8acUCpqbfCA8okInrhEW5CaPMuw==
X-Received: by 2002:a17:906:4fc4:b0:b5c:6e0b:3706 with SMTP id
 a640c23a62f3a-b706e29fd2cmr844769366b.13.1761990654644; 
 Sat, 01 Nov 2025 02:50:54 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077c3dbeesm427677966b.44.2025.11.01.02.50.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 02:50:54 -0700 (PDT)
Message-ID: <2d782723-73ad-4c4f-92bb-2a30d1a1af2e@linaro.org>
Date: Sat, 1 Nov 2025 10:50:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] ppc-for-10.2-d4 queue
To: qemu-devel@nongnu.org
References: <20251030084936.1132417-1-harshpb@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251030084936.1132417-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

On 10/30/25 09:49, Harsh Prateek Bora wrote:
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-10.2-d4-20251030
> 
> for you to fetch changes up to 5795c7650e4b149e19020f95cc4892bf7b2beef6:
> 
>    hw/ppc/pegasos: Update documentation for pegasos1 (2025-10-30 13:40:38 +0530)
> 
> ----------------------------------------------------------------
> ppc queue for 10.2
> 
> * Firmware updates for SLOF, sam460ex u-boot
> * Removal of unusable e200 CPUs
> * Coverity fixes for fadump
> * Other minor fixes, cleanups for pegasos, spapr.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

