Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5D0C369A2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0iZi-0008Oq-6I; Fri, 04 Apr 2025 11:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0iZP-0008O3-Q5
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:03:02 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0iZM-0000MK-Pn
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:02:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso11210945e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743778974; x=1744383774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q31cFHeYMFy+cq1J8JrkbYlWOVoUtOpGnWFTWhS7PFo=;
 b=t7nRMBsxxhVb8u77qCY9nyxOnMoqG92RW3pVaye24ci22hNj6jJbIh/3hG8F7V/b/K
 g6PjBShL7qnRsX/jrpdI7JuHTtZ+bYqybJ+M5rWDCEbkqKt4an8DLMCD3xPvcdnyAZyN
 l9vBq28HPz1oZkUy3DnE5r76x/IyrZcCIZqq/+y+V7SR74fbVvQPYzXRXdv//4KTrV1X
 anZmHKGB3XmzWNe7F0HnKgGPbMeRhEm0fG+X0auDY9azOcfQhKmgOvGn8iF5riUehskU
 h+i9/md4HTKpffPFFmL6t1VFGlrm3IisVwcUuHJQU0AJfN5sTlB4Jjd0p5qkXL7NznWM
 IFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778974; x=1744383774;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q31cFHeYMFy+cq1J8JrkbYlWOVoUtOpGnWFTWhS7PFo=;
 b=XdufVAz5fKSVoCosCTYMERxQCts745XMdJqEntBlbfzZlUsrDPynhDstGjM47yu1pi
 jafEhjBXtjMIq3R3JxwCqEYflTSsOMeC/DSg0rpttE2X9IJihR7xmGS7Kg2XQwe7JVwL
 ae15nTXgJRfqgX7dMnk9U5zFXSwR/hamnXpnz3BbI4iLe6dByCF3jVdpz/xB1QoiHzQp
 DsX7fR7tvaWZ7VWV/rgr2kFhad9XOF6wHU42UovXeIFTJislrcGa83vSuDBQKcSNwwyK
 qHtMhFLFVXL2czCWMKTvIyJZcrDdCwAZ0B+3PStx4BkCpGBB7S1LTTnT7iJyt77/+fhJ
 Edvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt/oU3b+9NGvxsvxm9c1CzPdU6+OliMJV6uPVDWLz57LhQTPSgvtQKhhKPdzFipMXoszWWRhucTKUW@nongnu.org
X-Gm-Message-State: AOJu0YwpxZBfnfAyl9ATEIDwLtWLWJeCzj5AeQQgotsp41DqWkdalG6H
 G57x5XKj/fF4ptQAeGWrmS/tm4KGQjXjT1RTsNPCFrMFm/Q8zfLVlguqT1uRBQA=
X-Gm-Gg: ASbGncvmpmZNUpeTWrcwTRzVmbAr8bwHmOBZlzGKsDVyLRff5z8LGga85vQhYT4ShnD
 jPz6+7+oJn1YtyV9JbFPzSEkZVhdElKC7Z5x5uFK88JYomE1mkfkszWr5RKB7zsG/Ex6g50MthA
 XykIV8wik6Tw1jd+c2ek0U1fG6hl3uGgKMY79QFfW/LHoq3D7fwjuhCU8haDyjja2MQ5MxRnZWr
 kqlDGJLCnOxjOQ4Tx6n16QlaBJ7Cu6SiDfqsqujmOA7rjwSj9AvubK3d71/PbgDmxpYAjZi+Uwy
 eNzb/NVf93niwbwba3bCuMiqm5xTCfSixI3h4j1SCWu0QgooumSUlJjIKSbewyd6TSU0DXPtYYC
 M4cpvckj4vjUp
X-Google-Smtp-Source: AGHT+IEG/c6NNIo8EyvP+ufOZCN9pG4J+XRUpjKedpYiuzaAa2w1kTX1rwGrfgIJ/ZGbzq4LxR5qqw==
X-Received: by 2002:a05:600c:5394:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-43ed0db4aa5mr24054925e9.32.1743778974523; 
 Fri, 04 Apr 2025 08:02:54 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bf193sm47910405e9.24.2025.04.04.08.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 08:02:54 -0700 (PDT)
Message-ID: <295e5a6f-9edf-4a0d-844f-f5209de99bfd@linaro.org>
Date: Fri, 4 Apr 2025 17:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: Fix buffer overrun when using path= option
To: Valentin David <valentin.david@canonical.com>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org,
 thuth@redhat.com, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
 <CAO8sHckT2Ko8TTJjzUsX0znafaL_4jp97QCtSxoZDnHow0bEAQ@mail.gmail.com>
 <aabb0497-016a-4cdf-9098-dbbaa92b781d@linaro.org>
 <CAK00H8NhzV6ZDr1Kisr2_GUr0b-7W+FKgekQOF_iD61-J1mh5w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAK00H8NhzV6ZDr1Kisr2_GUr0b-7W+FKgekQOF_iD61-J1mh5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 4/4/25 16:46, Valentin David wrote:
> On Thu, Apr 3, 2025 at 9:37 PM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     Also I was hoping I could get feedback from Valentin.
> 
> 
> Sorry, I did not realize that you wanted my feedback. Daan's patch looks 
> fine to me. I have manually tested it and it fixes my issue.

Thanks! Might I add your tag then?

Tested-by: Valentin David <valentin.david@canonical.com>


