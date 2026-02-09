Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B73EF0718
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLOf-0001EQ-DC; Mon, 09 Feb 2026 02:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLOd-0001AZ-Jm
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:09:23 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLOa-0007KE-QH
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:09:22 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8230c33f477so1780683b3a.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 23:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770620959; x=1771225759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/hXjmQga/t94y1fer0aVEi01FHyIzBKnjaTK89NZhGA=;
 b=BUewmpdpTnH8yHHICwF4LvboKNrQChSZnfxaV1d49dkQmqJvwHp/8vyk5oLJnTcveO
 DkWgiyjFD102pxn56l34vI/mFFbvO1ppl9rN5hPCXP536Ke8Qqvnkqm5ie+JJQ0FLIia
 4sVNfhOzXHYhY6uaW0OumDbKXpQ4NRpA1fHujjrGexgrlL6/hIoEWVlRHbIEfBDdkjiH
 EQyqWsuOsYJDGl26k7qOzgNeVRhiRXcm7dPMjdlHfS7LugNYSzSGYMWR+Tala24svRBX
 02sVexfzZ+eZ0eJUayf60mAr/PA07hcb7IftAOnEIIg/fEbp2dDTpQ6dw++kfzdR2sok
 dJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770620959; x=1771225759;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hXjmQga/t94y1fer0aVEi01FHyIzBKnjaTK89NZhGA=;
 b=TXFa5niAknypDfCl3S5W1I8exdyLqx0zgCnH7UHlHRUBlHlr1hFv678im6aILB3+PK
 mbINMDTQ3go1ShwKXAoSycFeyuIRCzbzHfXo7SCIYj8otMyov06xuoJ6tEBczSguAhps
 RdXmOPJMJ+BcxPzeBpABZ/NnRyI5CowCYL1Xekhye3QYMe2nBlMOJWm8eRKgGM9/8JWo
 jV6lzDRQhzFGQG18/GGNysdHaYR0YOZ3T7CtEmfdMsSVKf15MdtfpOWV1WLwqzl/R11m
 hXryr0WU2Qgx2XT32zg6+caFgydyfXt57/IOTPq4BkfvyDJbL4K64x7Ll0DQPfB2bm+x
 r+cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMWDZu/Q5i7u4XwCQAxcGJY5+A/UxgS6NTpXmtAA9/eNWXlPotBz8rQOLbOb7QmoDjp/JvqqIQ9EW8@nongnu.org
X-Gm-Message-State: AOJu0YzZGjMQj5bc1uQJqkz/jtL/GPdmfUG1ZS2lVfREd/7gYLXmYMjs
 RzxVYLn8h14gnOvBUpqL1Zh06DpSTFBnWXQwDx0Psiihrpfu06rujgChZ8VF/3hw2rg=
X-Gm-Gg: AZuq6aLoKFfo+40YFjERqLbW0jnpiEpsgo3JJE80OFAhVnYbrswnrpdiuM0q7KEPAxR
 12bg4OXenRptQ/eNZZQ1d0rqqUrD83p/4tSimmfk9ARFWRB+1ATexOVzj1qBgcQ6zyKFcTuJZtk
 IuSzerj/vdEmBbuCcnQanukk2jKw4WDrSAWn1Rd61cQE/NSSuJ14ao6I8UMftqLG3B722ni0WRf
 DugUC/XNBQ3myENO6NvxCKwHMF/YwK/roC4fN+KdSAhDzmLCRCAk4dySs5DFJgKuw8RDVfIfYw2
 zqY7Y3rC1vH7bLKjR5oYwMXAaDBPg/evxJyprMOThl2mth8XWnfwkRItvDnjSBIf40w69yyAvWH
 yS0ZCaa19nAdqguE1JPtHR7v7E2CGsRsgzCcYlojJBl+1nKnPGD9Kmd2XxfupH4drMIexk2I+SY
 ORC1FWNE1kzoxV5dDT7x10D4n/pJGDwzF+iGnNbwbyoCTB15szhlvWi08ENXcUWpjDyGskDBq+2
 g==
X-Received: by 2002:a05:6a21:a8f:b0:35e:3cac:858c with SMTP id
 adf61e73a8af0-393aef660e6mr10943407637.33.1770620959377; 
 Sun, 08 Feb 2026 23:09:19 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:7b35:2dcc:ff07:8193?
 ([2001:8003:e109:dd00:7b35:2dcc:ff07:8193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb5e41f9sm8856448a12.23.2026.02.08.23.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 23:09:19 -0800 (PST)
Message-ID: <5a117a91-1139-41e6-b949-2e2976d70dc5@linaro.org>
Date: Mon, 9 Feb 2026 17:09:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS
 in a new header
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-7-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206221908.1451528-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/7/26 08:19, Pierrick Bouvier wrote:
> Allow to include it from common code (vhost-user, in next commit), else
> it pulls ppc/cpu.h which has target specifics.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/hw/ppc/spapr.h        |  8 +-------
>   include/hw/ppc/spapr_common.h | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+), 7 deletions(-)
>   create mode 100644 include/hw/ppc/spapr_common.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

