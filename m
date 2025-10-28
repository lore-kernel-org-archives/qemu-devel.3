Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F21CCF9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiYZ-0004dV-Gr; Tue, 28 Oct 2025 08:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiYY-0004dC-06
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:12:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiYT-0001xj-RA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:12:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so58953565e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761653515; x=1762258315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=POo/FvQWtJoEZs4dbej07O3M1h2W/xpr0kV9kclHaFs=;
 b=ksritUjw6OsmGv6cnuunUOJ53OqjH1LjY6BCXRvWFoXtVLU0AY6tNm0hcDfI1nJtgg
 k482+qMIsVIbHF+UMxpcwkq7o8HLseI1Dw/Mn+ekOZ+OrOJ6b5QFbEiVVrT7luX1by7/
 aEYPxf/I9KdaSrZc7UeHwR1sf03TQVYU4Zz5vHsrnNOqZtCuQbm7G7RbJhcBWSONrYHo
 V42WCT+cXJhAkZsWHNAul23Ndm32rPZgQmKAurIkX6z0jSCyVvqsz8zl73/cuWP3BeDo
 64DCnEOh7ubDJUIgPH8NDEccjOyj8gCUEe5PId94jGJbDKu4PijUaM/mJGe5SWJwpesl
 2zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761653515; x=1762258315;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=POo/FvQWtJoEZs4dbej07O3M1h2W/xpr0kV9kclHaFs=;
 b=cGwvQI9rVQ/ylQoOAwTOHgXlTPuzxwXzU/+C6jGoNT7x+wB1dLrysTH8UkfLWDNbL4
 OMGbadWK6oPThQv/F3GkY7wBoAAfS42ifn6OnyREi0Gb4JppRcOnVAUm8+fv6paTQng2
 2xF8VGlVNCWNgwJeysHn8J8EvpZdsyYLXffUZrs4ka89XrgkKvQs3D4klFeLb60N7B25
 z66Ms/z36ys/mWD1heMK8nQbkoh4vim4KgFHxYa/pEaGosl/lzMFBsw5NoQL/3AXN4AC
 aoutPp67bPVF8byNDF8RQvZtvn++iP472ttwvEOZ85ygFwueTvC5Jo35LBGKbEgZnoyn
 X5QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUekTPbpsWpFQqCX+xxYjE1lOqmmyksU096SDAPkK+H6xKsWbvi8BbYfXIpc2Q0euBcHSToUnd9qRXN@nongnu.org
X-Gm-Message-State: AOJu0YyOqsH2F5QUhPElZbaWRtTFC8R/eoep0yw3NVR4do5y/qJK/LYK
 qdXFEh8eDAQxuYtuEXBF5vj0AkxLHTFtbk9T4WYoQBwbZHqDLlNfuH4OoXDVvBJMuNwHGkA5XfC
 shEq0EkU=
X-Gm-Gg: ASbGncvvvrPoz2Nj4g4iRq73eUins2kJrvQG41LeSuwedSubXmR1zPwAh1aGNyQP9nm
 qRNHa6xkM5HLUURf3BL50BCFEkM0ugEqPrH0fTLToMUP9OaE1HC3+7gonnjhjyYeg3awgqPUuyW
 YknwGpVzlD2pqsBwmxUmtMiqqk9AVYFa5tzVmYc1foXZrkYREKN/pAuz6gj5CVJMkJgc5uQHiVf
 QEv1FqFQrtbPNtTfZmnKvrPp4c2wdBqtdCkrQSKFGUvf032oFtkuLhiiL6txI7L2Ygpx+/kzOCM
 x/2tDxI9mzOQtsLHcUYqV5AdDTo9s/FwAJRdXqdsBLpftGh6MbHFeK9Zl8+2g8da1ZLAeTxLtMi
 LR7w4klsJ7ZYBW6TTfwkEiGi/REUZRcui7cak7EKUM5dCatEC/VbEldxoarvtelWb5/L7B0tic6
 9kxuhNLqGdwegtBkbE
X-Google-Smtp-Source: AGHT+IFdYclInPNHXOhzwQIJ346wFApGdi77eManRVhQndTgSSzIB1LQoiJ8CvdTFzkP4x9nvV45vw==
X-Received: by 2002:a05:600c:4446:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-47717e6ab4bmr30532525e9.29.1761653515565; 
 Tue, 28 Oct 2025 05:11:55 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd374e4esm186445655e9.11.2025.10.28.05.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:11:55 -0700 (PDT)
Message-ID: <5d343d3a-75b0-4528-84c0-25333e984157@linaro.org>
Date: Tue, 28 Oct 2025 13:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
References: <20251027190514.36991-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251027190514.36991-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/27/25 20:05, Stefan Hajnoczi wrote:
> The following changes since commit 36076d24f04ea9dc3357c0fbe7bb14917375819c:
> 
>    Merge tag 'next-pr-pull-request' ofhttps://gitlab.com/berrange/qemu into staging (2025-10-25 10:42:55 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to 6910f04aa646f63a0257f77201ad8ea15992b816:
> 
>    hw/scsi: avoid deadlock upon TMF request cancelling with VirtIO (2025-10-27 15:00:45 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Fiona's virtio-scsi TMF deadlock fix.
> 
> Paolo: I merged the scsi fix in my block tree, but realize now that it belongs
> to the scsi subsystem. Sorry about that, I'll be more careful next time. Please
> reply if you want to handle this patch yourself.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

