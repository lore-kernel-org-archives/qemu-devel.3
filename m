Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC490C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmw4-0000yY-7C; Mon, 22 Jul 2024 02:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVmvy-0000il-Jd
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:54:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVmvw-00055K-U5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:54:10 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-36887ca3da2so1483825f8f.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721631246; x=1722236046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DPfGU/BA/sxZ2gzNfCsAG12BfIJbzay3LRA9fySmEkc=;
 b=sSv8H9rPrlZ3JJcZlDhLBIWwvZepObrNnHPzwAT0oNTD9Rc0mcUmJ9Fn/M2Xt57z6D
 Lwk2pDQ9gMuWlyadB4P6BZOo840VBP91x/uY9FZG6MD/EnfwbP7vKxaG3/3RpPzKnIou
 IUJuNQ0/MX+8nq/NNSUV/XuNk4aavK13wYZOHKNORLki9Vxa1A+ndRPiwS4vYpiLoXXG
 p11YQmQqk96BssA7L5sdf4xl1mbwLZLEtNB2unEncU1uHr5f43vwCDQKFe7Ucx28AJj7
 p7H5QLlBaobSZUnO9tMPMF25v/dEgy8OFNf/u47xn13WcL/qBqx29tMR1WH74rxTyYiY
 FLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721631246; x=1722236046;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DPfGU/BA/sxZ2gzNfCsAG12BfIJbzay3LRA9fySmEkc=;
 b=bf2ytnlC6meSPt6Vd8q0VvgN8AVk57yxPj7+MLzGVbGiP1aWYitJeJVPpuKpxyUI5Y
 zQjAPpWe3oaXC08rTscq6AW8A2d4ew+HsIiDSMptObVOcFldV90nWiA8I1PcmkaLfLxj
 g8YnrQy7Hw98OmE69Q1TON7EUbqAWrEM6xW+jaythnbJjl3jxAEsKl5QyScB6dXmrb5w
 rHsIPtG+Xo9zhLzvTcFrsnWJPdkbmkYbhzB9DRSu+CI8h0SU30glmDbYsSlTBgxyL8cM
 jtLd1/bNXJZMYsLrpOzASnfeIL2UFteLYl9XXhpvwL1seKaKx7UEHhtDSNk6YVipKFls
 VHKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ0WKt+jqTuJm4kjuLKCV+F9JA8Zh5tEZjePTVEqcMgdeWJRzaK/zs4M76wk94z5HRtRWCrn5sJmL8IQqUAcT6kUMhyeg=
X-Gm-Message-State: AOJu0YyVwok9AsvAas5CH+pSHTkkZFoPMtuPjAwG0ghX1NvVG78EIMXv
 L1N5jKDGIT2uxuMfHKGqDaDqDH4nlwGQ4H0eRChwYdvIiNHEPvgsYhXD0XqTKWg=
X-Google-Smtp-Source: AGHT+IGC7xP3zmDxOcjY0gQkIum0D1XdWmh5K4L+Xlwa8VLgUVyr3znNy62dt3/bPVhxbZ1mB/EzrA==
X-Received: by 2002:a5d:42c3:0:b0:368:48e6:5056 with SMTP id
 ffacd0b85a97d-369bbbbf9dfmr3170797f8f.22.1721631246446; 
 Sun, 21 Jul 2024 23:54:06 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ed595sm7622630f8f.107.2024.07.21.23.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jul 2024 23:54:06 -0700 (PDT)
Message-ID: <e3ff47be-6316-4db6-84bd-53bc39c42e7e@linaro.org>
Date: Mon, 22 Jul 2024 08:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] range: Make ranges_overlap() return bool
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-2-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722040742.11513-2-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 22/7/24 06:07, Yao Xingtao via wrote:
> Just like range_overlaps_range(), use the returned bool value
> to check whether 2 given ranges overlap.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   include/qemu/range.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


