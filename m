Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37135CFB454
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxt9f-0001zJ-Hr; Mon, 07 Oct 2024 15:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxt9S-0001xo-Kb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:12:17 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxt9O-0003cQ-MZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:12:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e10ae746aso127491b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728328329; x=1728933129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8zK6+n5gSfwsy/IpPKHb6ZmNj3XPkx1lQmt9xXT82u8=;
 b=ke/8u8eNdm6NkvEJiDh/5MYXOiSjsCrUsdSIy5Pq0QyGhY+H3HYScWYK2Sw7Fzdwtq
 C/l5BBTPQNyFKwyfs9oxLbLQyMS+Pv54ypW+/h0yVCcPe/P6SMaWgXgGdqZXDdqXjxc9
 rkM9Sq3v2yLhcMzo3P1VTELwxPac1US3TqpkiAj/e/X8DZeAtSaykJB4A/hbWpMqmplw
 +N2wpxfsF3ynK/s3ye7hZAlsZHSdslJ6JEDTxvqvP1Lt97Mah2ZiQoXrmAg+N3CkonQ2
 AiwLzAoBdKbmRbqWYfs5KCdIYBWMh4Z56m8YyFePZK4cQeoPLUHqpe00pyINBHfl1rOi
 DEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728328329; x=1728933129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8zK6+n5gSfwsy/IpPKHb6ZmNj3XPkx1lQmt9xXT82u8=;
 b=uaRJeznOHYWS/4ZUAqPoIcBLPoZwLQVJlWxGUnbw1PFhor6tn03ahpL74/R5CnCvN7
 /okyGnj1HxHo8+WOpsoP0zMG9Smy+aKEkCEd+rglHZobm5PvIWzbks0Ua0EH1aPOEb55
 PUhYLhC+5JP258mIdS8jcEGpYmK1gliWocG5CTfVhg3abpiVHux1wsoaslSdrJFjBEcT
 gA5i020qgyR3FXN7KBj20OsbPu0icbrHJ3xB1DB3iYzNe/pvIc+ASwT9+YuSQ4YOD5Ii
 hXvA6yJ3lWy6CZJwetCSZYqvQwt0nwXFoS19NzxwNNJU6PsvjlqPN7+HaliRQD/thQEG
 WylA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd1xbCtXcpb0SlraKbvy/6PVjEajMuWy2wYnrq+32eMkt06xKPzBXsboBA+6Dr8V7fimVbdyKzOfVi@nongnu.org
X-Gm-Message-State: AOJu0Yx7xF2ed2SnqjFfJcFaz91+D7GTcTw9gNrUpMW0wGFn91mpJFx6
 6wetRwZWUAziKUOU3P3/DjkpczfFnGEyTAVrr/iPvdri8sIEDPo+KI4eo3gE8TM=
X-Google-Smtp-Source: AGHT+IH1C1ixJx9E4fwMNq6YptjG3GnBZppGW23zCA47gGBgZhIQalXGHNY62sNiP5M/cVYSAU/5uQ==
X-Received: by 2002:a05:6a00:b83:b0:71e:989:e714 with SMTP id
 d2e1a72fcca58-71e0989fcc5mr4244378b3a.11.1728328328669; 
 Mon, 07 Oct 2024 12:12:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0ccd03dsm4762623b3a.62.2024.10.07.12.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 12:12:08 -0700 (PDT)
Message-ID: <4902a5ea-59ad-406b-9171-b834f82cdcc1@linaro.org>
Date: Mon, 7 Oct 2024 12:12:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] meson: ensure we enable CMPXCHG128 on x86_64
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, alex.bennee@linaro.org
References: <20241007172317.1439564-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241007172317.1439564-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 10/7/24 10:23, Paolo Bonzini wrote:
> v2->v3: collect *-by tags
>          append to qemu_isa_flags instead of prepending
> 
> Paolo Bonzini (2):
>    meson: define qemu_isa_flags
>    meson: ensure -mcx16 is passed when detecting ATOMIC128

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

