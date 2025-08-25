Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A59CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 02:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqN2v-0004TG-G1; Sun, 24 Aug 2025 22:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqN2s-0004SK-NJ
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 22:34:54 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqN2q-0005nP-UV
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 22:34:54 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b47174beb13so2675639a12.2
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 19:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756089291; x=1756694091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ulxwzg8ccPx/Aie5D9f00WxroO5J4GNyJyNafrpgZVY=;
 b=xYFR72qA2KFUZBr6fOh8CBzcFbubYfL79kfaIJcq7H4ZjhL+coIpcrQIeiBL/p5VOM
 H09vBKSq3eCVjDIHMS8RrEZLOiTu9+PBMqMobGVJ8xdHWc78JMbp66xXMQePtbaZsKtN
 IwBYtBQh18CYhMwBKZLoziR94PGmCvy2pJV1F14idpzQsya57p/O69uWP+wncT++klIm
 KlJlMsuHgVIsnnH+oWejmZ3Qfwz2zlgX4/Mfihf5Dyg5Yj0axm8V93z4KlsJfttL6b7Y
 6y3vfM02ORAK1SQpaINbxGwGWiP43MQ6mluBnq+GLwfBIEwTq81fUrP/5R+QTZnRY8UB
 AlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756089291; x=1756694091;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ulxwzg8ccPx/Aie5D9f00WxroO5J4GNyJyNafrpgZVY=;
 b=Q1sdF9UBRsy6zasbbXqsrDya2Y3fitI41KLxzFhDkwp3SvaGJkhEbrf1apEJ7RvUHE
 oFdyVqwXy6V2U9arzl2u8RjSlwys/kcMXzJZv2aEfIsL54M+jP48IfaXr/xzmS9pnS3e
 qy3m0FNbiplkYBrVlrsjPI3XvTh41r48VA/NHhWxd9EniagrxuPatBO2XEJqL4PJ34Ge
 DuM0tIiBkcMV96EcMmIyxZhQhhN632wmtZJqaU+F9lyNmLYLwE30NYe8k2chghNCZJgD
 VZjYLeUcSoa6QPZoU9NCw69fw0ElXb3WYUn+3UgVmCvyUM+djNr6xebnulQXHY5UugUG
 E67w==
X-Gm-Message-State: AOJu0YwYNX36GvAdbpWvoWp3OXlApbOYuqOrNuWtnxp9ktnIsOYuZxKD
 PBGuqDEeg+jrpMYXWNu/qo60ju+VX7MGrD7kYnP+oNEb0jPToZ3Wep5pKRA2hZLx/VBg8+C05uP
 gMqg2M5c=
X-Gm-Gg: ASbGncszt0cKM84Fbr2r+n3v6R5XLnzfz97O2Yah5Oh+BpiBgQYiXngrbfkmq/ARXEp
 Kp2gCvvstBgktPAtlJHWAuSwZgolmhoGyGdeLjtItySzqgu5hlfZd5lcN1ToeeE9mjOOjQmHj/C
 cnoYvxSThDb4L7yg8tfzrGWBG20tgO9XScL2Z/nyId9gk3j0MCJrHcbQ0PTmfUiSUR36q+q6Au8
 L1au0L3gamnPMcXFonsQLLUXtJObYukYTSk1Q00h4KxNTeb7dWKUbbbXjpk4IilnmVV5K9dik+O
 FRjSr62YCBN6n114A2jrnHVK7m5+yFPKywlmT3VNoE0MrlR5ZY5mwI/byqHJgFL3MK0//LFnoK0
 Opw5buEclUaIG37a4hIyEdlIpMZkfNa53G2EorfYY88giiYZJnFuL2ja5SAZ+CEdFN6SDxy2/FC
 wEihGjfEwqaLR3qPQ4/0HJ9YsdlUi1r/0RQRUK1yvucLO5rDeo0wZX8V5deWAcnnTM
X-Google-Smtp-Source: AGHT+IE3U1ddv0egE6QY86rbtghBjaqNAVxIOXPlKpAwodZe98C+AcG5QoXS2jnzGfNlbC81X0NeIg==
X-Received: by 2002:a17:903:1a08:b0:246:a8ad:3f24 with SMTP id
 d9443c01a7336-246a8ad4130mr53060135ad.7.1756089290658; 
 Sun, 24 Aug 2025 19:34:50 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:2b1d:8711:2597:136f?
 (19r3hzjj0vw81f3fs315.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:2b1d:8711:2597:136f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-246688797b1sm53651595ad.115.2025.08.24.19.34.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Aug 2025 19:34:50 -0700 (PDT)
Message-ID: <8815be9d-6c01-4f3b-9163-a79975325d7e@linaro.org>
Date: Mon, 25 Aug 2025 12:34:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] target/i386: Save/restore the nested flag of an
 exception
To: qemu-devel@nongnu.org
References: <20250723182211.1299776-1-xin@zytor.com>
 <aKmTtaOlPewxllUZ@intel.com> <211ff764-e24f-4afb-81ff-fe0d9a78324e@zytor.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <211ff764-e24f-4afb-81ff-fe0d9a78324e@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 8/25/25 12:03, Xin Li wrote:
>> In addition, I think it's better to update header files in a seperate
>> patch.
>>
> 
> Is it a protocol that the Qemu community prefers?

For imports from external projects, yes.

r~

