Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AAAC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 14:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seyLd-0007OY-QH; Fri, 16 Aug 2024 10:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seyLc-0007Nh-RA
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 10:54:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seyLb-0004Ze-6F
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 10:54:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so15245215e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723820072; x=1724424872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6wi8hYYlchVBhg9rzkYTtvUCr3leRHfTFIhrDckhmB4=;
 b=LN69tlB+aBGTDcshw1stYHDXzp/fC7/vH9RRqJUD63SvKx5UgTV4Oy804YeRPdiM8Y
 HYJyUo3YwhmQzIUbbSqzjIebMfPdzsaz7kbOEjfi/vhf+q9euc851bKWMol5DDXgyXi4
 V4G981L4Srky+e/XaRklc0ZGz2d+dseDzfS3yK+cV/zzjxw3Y6m3GzxSczKpL+maA7vx
 obR9Hxi70UbiyXzQX16goyjoieQmTrQe4p5AGfqir9ukzxS00nBxepcFtSi+4k87d2Ax
 yRX7UcONw1UUV4JQnlRfETLxnFji5KKF6xJdxv08ft0VCVyw8tSUy5AaZsPDcBeKiWef
 M7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723820072; x=1724424872;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6wi8hYYlchVBhg9rzkYTtvUCr3leRHfTFIhrDckhmB4=;
 b=Ojok5w3guf1qjQH2Amg/4iwUYERwD214xJnmGyhLCZHh7jnd3FtBEEOJrdI8W4q6AK
 fL9BagU+UmXC4IQs/vYh+EpQBELjDjv75/5jN9YpDyVUgUK+3VX0t3b9M29tmHzn2y7K
 zOgA9L7bYaD3zcNPKOzgeshFIsZtKpoDxbAk5ZBmN0oOT102s/DK2S7jlgnNI0cXmU9H
 D02kSF6z4bkDkCmtMZeHJf/8c0dhp+sOAcQyLmBT92+6yMzlnOcKyd9/J5h0bZgISWSh
 DvfSbfiROLd6TN4izyzLV8zgBpxRLz8HqELA05ZepfKNUzzGN021IKKw7v4yIwhUM0ew
 RVLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXViQhQ4Ozp/M/HhxpBFUcAhszOENGjSIap+dWxNWugLYQoyRzWgFqFTmIRvQlDPa1gjf9moznsGOWc@nongnu.org
X-Gm-Message-State: AOJu0YywtUhnEG3HJmJ+65DaeyeKMk6SleY0921dG29bN/CGabhzqqMu
 FJOYa+m5pmUC7R3iWXKse1qY7HqPrjHMDR1G4nNaJKc/U/QPqsHYoRoEkS+VTsk=
X-Google-Smtp-Source: AGHT+IF2W3HfdhZTXzWEyAII6R9WHjS1Lns64l5iP1sfw01jsPZ+BGHHpilctLq58pjPwNHcqBjMMQ==
X-Received: by 2002:a5d:60c3:0:b0:368:3717:10b3 with SMTP id
 ffacd0b85a97d-37194315af1mr1897099f8f.8.1723820071854; 
 Fri, 16 Aug 2024 07:54:31 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed78481asm24743565e9.32.2024.08.16.07.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 07:54:31 -0700 (PDT)
Message-ID: <dfbaa406-e713-48a6-8469-27444f1840ad@linaro.org>
Date: Fri, 16 Aug 2024 16:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] include: Move QemuLockCnt APIs to their own header
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
 <20240816132212.3602106-7-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240816132212.3602106-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 16/8/24 15:22, Peter Maydell wrote:
> Currently the QemuLockCnt data structure and associated functions are
> in the include/qemu/thread.h header.  Move them to their own
> qemu/lockcnt.h.  The main reason for doing this is that it means we
> can autogenerate the documentation comments into the docs/devel
> documentation.
> 
> The copyright/author in the new header is drawn from lockcnt.c,
> since the header changes were added in the same commit as
> lockcnt.c; since neither thread.h nor lockcnt.c state an explicit
> license, the standard default of GPL-2-or-later applies.
> 
> We include the new header (and the .c file, which was accidentally
> omitted previously) in the "RCU" part of MAINTAINERS, since that
> is where the lockcnt.rst documentation is categorized.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Paolo: could you confirm that you meant GPL2+ for this code?
> ---
>   MAINTAINERS            |   2 +
>   docs/devel/lockcnt.rst |   2 +-
>   include/block/aio.h    |   1 +
>   include/hw/core/cpu.h  |   1 +
>   include/qemu/lockcnt.h | 130 +++++++++++++++++++++++++++++++++++++++++
>   include/qemu/thread.h  | 111 -----------------------------------
>   accel/accel-blocker.c  |   1 +
>   hw/core/cpu-common.c   |   1 +
>   util/aio-posix.c       |   1 +
>   util/aio-win32.c       |   1 +
>   util/async.c           |   1 +
>   util/fdmon-epoll.c     |   1 +
>   util/lockcnt.c         |   1 +
>   13 files changed, 142 insertions(+), 112 deletions(-)
>   create mode 100644 include/qemu/lockcnt.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


