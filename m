Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72C6CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 07:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRmUx-0006eB-Ck; Tue, 26 May 2026 03:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRmUv-0006db-EG
 for qemu-devel@nongnu.org; Tue, 26 May 2026 03:46:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRmUu-0007DP-2O
 for qemu-devel@nongnu.org; Tue, 26 May 2026 03:46:45 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso87779145e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 00:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779781602; x=1780386402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ccuaxQlJ6nmnaxwolOCTONAaLO9F7oYlnRvBOl+TEIg=;
 b=k6kMvj5wK3oozJqJno1+9t4agVwSkYFEV73TZsRh1Aa8ERud6khZwTq9iCQnLPXRKj
 7+ze2LeE7dYzgv4xvm4dZyjYoVm0TbksrHhp/dmur7sRboXeUdP5XxqSwnI6PsW+xAUI
 R6MKYYJc7gEz4LXY3vz343GGrXWclJbeLGvin+oTdG/V9yCg/WQO1Dcy79wzQwPsVjbS
 w+J0BIVdEbpHRErTLMm66AM0tP7kQ0BTz+2ALbuylsqj0xUWzD2V/q3gA3iUON5HBUbT
 N2RAfIy0dbiM2HafNVqMLi7OVZGB4+2Jv8nLaObovduvuvc43jZGiTcVkU5NVlHDiHBs
 lRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779781602; x=1780386402;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ccuaxQlJ6nmnaxwolOCTONAaLO9F7oYlnRvBOl+TEIg=;
 b=UcVlf2/zvEorxDKwrjyiBrd5ApMrNwFQZe1FwDDuNZRx4trbiNlu61IZDvKDbQJYou
 lvnPkBX01SUiLl28Yw2Pr2uquuLQ6e4Tv6F1QNXyFt2Hbn7045U2PRkL/rYDV5g3OOYW
 uYFu7ZGBYGecdXAtcbb0NYqZ29R++dqszkKrJoOrf80L0UK6qM15h5u6ixAbgoUQz7b+
 UzZcxYEb0gILPbFs9wjfKDIAqLS6mijg+2Q3BkI1xUggT8QrK+CFotVY4EASYCCONRrN
 GQt0hn8afKAMDZGEsC2emQ2vI9Fpc2mcjd9lX+RHGGEkMH0Xw1+qJIWq0xqOiPwUly/x
 M5eQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CBj1stdyFOvePJOjW9jaR98uuZ6++bKJbFpwV20XQztaTTOgUXv+ZGPa4nRg18M3uaT4L+6glEY3j@nongnu.org
X-Gm-Message-State: AOJu0YznAi5vG/3u3nBLSWlSubMagAIRRq87wC3uXCOp39as0U7GTzpz
 xn8Ncj2or8L38RSA53lOAzdo34U9styiSdXB2A1sJzGLdtcUhL9Irbu/PEVmDh3w0Q8=
X-Gm-Gg: Acq92OHTI/2Eet8ZDtr10AFFe0eoZazlGwg48ywToP0jmHBUoZj/0SClAfFJxWqXU6q
 4xlW7LzuwkBCnL624ybKmQlWyglABhVmmI7+K8JYkKTY8j/7kRFCx99OCy1huArW3W6gAwbUeqq
 plVQZi7PWx5f0/gK2vpfJZiTLRsG2JS9bCnYwO+43J6AwiT3ezsJaAwVGCTclds5rccUESF0cEi
 WiPtmDkIOVaWZ2Z0lpxvfWvkBBtS4vZPte9f7jBwRSiSdEI7tSKFW0GDQRFephCHXOnKfumVfCy
 rvTKvnxJ/nPc7x3Wz7YwShGSGf/Ef/awuJsGjOBigfnOvJMsOFdLb0MjtAZGGKL4mzNQXJIFyGG
 CgWJI2JkSERjN1Y78oFm7gcgujtAmqDcxt2pdbmrAvJpd+31I51Y0w3wFUy0rhruPzLlM1JKj9a
 6iPAaTOj6a4FYS+7/J33idxlWOHrg2RVfoOd+MO1SF2wi5dcnjI7TrPB+9M8NhI6H9eg==
X-Received: by 2002:a05:600c:6217:b0:490:44d0:11b6 with SMTP id
 5b1f17b1804b1-49044d01257mr287308425e9.12.1779781602375; 
 Tue, 26 May 2026 00:46:42 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a33dsm278977915e9.11.2026.05.26.00.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:46:41 -0700 (PDT)
Message-ID: <fae4fb8f-8574-424e-bfc9-dc9eec86b943@linaro.org>
Date: Tue, 26 May 2026 09:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/io: Use QEMU_LOCK_GUARD to simplify mutex
 handling
Content-Language: en-US
To: Evgeny Kolmakov <randomjack94dev@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jasowang@redhat.com
References: <20260522080644.9531-1-randomjack94dev@gmail.com>
 <20260522080644.9531-3-randomjack94dev@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260522080644.9531-3-randomjack94dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 22/5/26 10:06, Evgeny Kolmakov wrote:
> Replace qemu_mutex_(un)lock() calls with QEMU_LOCK_GUARD().
> 
> Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
> ---
>   block/io.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

