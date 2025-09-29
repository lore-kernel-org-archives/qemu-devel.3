Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955C1CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 10:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3BGi-00006f-R3; Mon, 29 Sep 2025 06:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3BGc-000069-53
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:38:02 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3BGV-0003nx-JC
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 06:38:01 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so42835115e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759142270; x=1759747070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MAjojh3+fzVJToeRPImJu4+aCgGjbdiTzfqgwr3WcbI=;
 b=sPsVbeMOPZa0LxTt4czL/VO4AJchrcTlfg+xVlR7x/h+q36a7phCEEExz/+ZLlrxcI
 69eg4XW4a7fxWBSpqIhN4OXMUc48VPnMjYirkL8tGQRCtpLupQnKFwyXc+tNBsrMamU3
 bFQaWsKSqw4iqddSXVedrLE4AzyYo1FZqL48iwZlFuUrGd22QIvvTpL2TvHVXS2S+Lh9
 f0MkCrKolRosVUz9b2SwGlTsBMn2OREKzsP4+Rx5hFdxGlen7SBklD6wjwCUJ+Mg0HbV
 M/G7C6BwVHuP/PNClvvDHXqFNu/TUeXMftPlWXmwLCIBXG87w4bxEOmTN+wieGxoCnon
 X2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759142270; x=1759747070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MAjojh3+fzVJToeRPImJu4+aCgGjbdiTzfqgwr3WcbI=;
 b=n/bGFipSWqxs+3uSiTQOxSkPa4iszIeoqRqdCkRZskIOqkVxUM08UTFW8ld7/SdCsr
 NcfkKhk8H3aUe9BPcQ8fzRvowobLSSZQ5z7o1+NoUAQL4yoIEL9F95B2ZuA1PUbO45VK
 kbo0+R1FhMJyGZDMeReq9uKTe+p3ioP+NRPLMTpUFCbnA+icir/VDy7kThGAP5lDC1k0
 HeW2ZXzAhJi6lfkHdAEKT5dHReFtbJTBWONqnJmoJZ9oRrBfs2My86UbK7y+S40M5gPh
 yXs+eWwdjGA720bnqf2wBbH5JNXs7unK32ak0SOFHc2C7Jn8VZ6xf1iuWK/Q9+f34sPj
 YyFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrhih1vppjBCUePRvo8ZOMRucKXmAzHXT29PqtkclesQQld5kWlM1Yo5HufGw2Z9dbopqvdNMQvdVj@nongnu.org
X-Gm-Message-State: AOJu0YzWbKjimcVLpTZ4DDzda24JV+6S7WOhYSh6VPeMfbemxwDvJ27L
 lRizOjvQFvxVPbZsJzmioabg26MMntRbFy2n89elf2bx7eJnqge8i/P+RwiHi73P3co=
X-Gm-Gg: ASbGnctPD3OrTH0Z7gRDEw3SdslyI6xx6uxVqtgWqhkHqjZznnMSiVtPQ6VfzdSMO1J
 B5ssE0/APxR9q/alhwdQbjCYSNwmQyD3fkiGIsWFS8oB5s0AlN1mUc+QfSP/v2DuKWPyqgbVXuZ
 NB1YXGhNeVkL/BchKKNtm+NUlU33hoUUoYvuhlp5rCnysOchhfjeZBIDODNjNj4Qx0Z4aqLHB4U
 2FQ5+8gJtUBDsLWrVUyOijoE7XUxXutuEvyeh/HnN1ujXCmOSXa35BY2PIjMDvoIm2sVSth+Tys
 8OJGZHDhpSJ5+iQwCwHlGykIamyNWkMmhTgTFfE/mM5FtR77hmjXVUV+RpLz+bbz6NP8GxloEbh
 YQtPSeLdf8b+bwqDdaLQGCKXWoPtrKDy59aAwkynjeKLyx3kbWAHDD9wfs+ucHvnZUg==
X-Google-Smtp-Source: AGHT+IEjWw5O8IWWBs437wcF5tJzOMjRcXQ+lr1qPZVm5+EgVWyT5y8HlNDnwynHeJt1X95wAvY7sg==
X-Received: by 2002:a05:600c:4e50:b0:46e:3d5a:d15d with SMTP id
 5b1f17b1804b1-46e3d5ad285mr110930615e9.26.1759142269951; 
 Mon, 29 Sep 2025 03:37:49 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f658ffsm7443535e9.14.2025.09.29.03.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 03:37:49 -0700 (PDT)
Message-ID: <41fd8595-6f8d-4583-8d72-dace695adc2d@linaro.org>
Date: Mon, 29 Sep 2025 12:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/47] hw/arm/xlnx-versal-virt: split into
 base/concrete classes
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
 <20250926070806.292065-43-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250926070806.292065-43-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 26/9/25 09:08, Luc Michel wrote:
> Split the xlnx-versal-virt machine type into a base abstract type and a
> concrete type. There is no functional change. This is in preparation for
> the versal2 machine.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/arm/xlnx-versal-virt.c | 74 +++++++++++++++++++++++++++------------
>   1 file changed, 52 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


