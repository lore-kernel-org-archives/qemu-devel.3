Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446DFCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 12:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGcdX-0008Sl-Ut; Wed, 05 Nov 2025 07:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGcd8-0008Ja-Hb
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:28:54 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGcd6-0000WU-Pi
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:28:50 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b713c7096f9so490411666b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 04:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762345727; x=1762950527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jB3SchOueo86jNN7lX9TwsisWrHgnL185wSSa3bCRjI=;
 b=jICc5oPiRsZwAkRUndiuDrTiRRxm/+v9jGMCPoS8miQkaMpYuwAmM/zfE8H5NA+7kw
 cq+rGMmI5uFYGk5bPybYdnEe9lR0m5HYr1xp43egPrIH5TSWbyPyQAuqmjVrpOMx6H8W
 xBKxAM7qpOVKHgQy42N18BFGbpX3yFKRQkdGp022yTgj6DdVzgFKFGuyzWDyHnRZeXqX
 7Pp8JmUl45yrHC+nMOmJCUAuwjTmSH4DS6AbCViLF6U7ZFrC8s0zgD3Y5gB81iQLCNl4
 h5Fe8MbHBpKHu6Gyc/an1GwOUpz3YPCFObCJIzZ0AFlmu2zUFtvsQ/YzxzC6z7rAdbkW
 2/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762345727; x=1762950527;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jB3SchOueo86jNN7lX9TwsisWrHgnL185wSSa3bCRjI=;
 b=vkuXQiJskHloPAo9WbIhAeCx/DBVlIPdRDCwk6+sOzabRUqRKuv0vI3ShO1rTSEldB
 ODg9xpcpAqJzMCSIsbGWGVBSI8GbaxInza1Tm4l8XzwMG6dPzU22GCkFOzqfF7Z7sQJl
 cQgrkItxm9jaVIfU4+PRygeAtJzSfYhyOxr4ZUMqvv/KWa1fviMyFi3ltUIK1w6awiVi
 6GOb1O4STGJit39ucivRW7ZkGxpyqxzU9mIYG7zb1YkNkq6l1l2gIc6xfUG2TaqRITVG
 W4ewQlH0aFQS5M2d3QMmqWkXplst2Hgj3iXgcHQ90zcK58+O+mnueCyEjzqZCasSMcfG
 /lqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5qM+lG7E+QtcG54q0rprenBuWtukHiE314EmLsColpFZfwgj+YxOpmQoZJxVlnb+okRaYKO6vH0eP@nongnu.org
X-Gm-Message-State: AOJu0YyKIQFDMQgOhyztYmS5kQr281jnVqsbaXw6TAcvnTnD+VWoqGRX
 cp67pdBYoWrSg3FhSPgpz0WfqYH/vC+RiprsR6pePDu+aSNoUqyCbZF4V2plartEPOQ=
X-Gm-Gg: ASbGncv8uZ4ew1PBFjksb1HJzorrH0aTRgzSc2IsAJRzfje3fuZjOfaykoRhZdCYzKN
 8ZxS5ml9DHvw/SEzeUQJ9/Q2YiHBBAID48KafxISY4C1LOQp1czG7fatPy65Fxn+BNeWHfFtK8c
 oIDySI41fiGX4kP4NAgJ4d9PilxbHOLCwMGNwJESqy54PQwfkokgVZpEDPlYlLfGedCHW6hZvoj
 IwbhkrFqYwwfHUMcCR7lR7bMU0XcoJpHh4pC4xro8Wxd1D4L3WvOiySMu7YY8skT8/O1q42q8DC
 V+h4OLtNSGl/x8KUAtKajin87ou4V42k7EawzTboZvrITnlLokX9W6EXTbcZBxfsbS29gxPO/uV
 8qOfStGxL/1m8PjB7BMAzxI/5Z972xCkF29ZKXv7NLFZZA67BJYYWYqSt9YdiJqzrORSXrcQu5t
 VQSvRMAVKVjLecQlpeS41mf71K4JM=
X-Google-Smtp-Source: AGHT+IG7sRiMIDye8D+iyN6+JFhFUuox0ploLgrLqjct8ax7p47qpl2Dyv4jbYqxc0DRUJI+f2LNeA==
X-Received: by 2002:a17:907:268c:b0:b72:607b:1868 with SMTP id
 a640c23a62f3a-b7265297ed6mr299452066b.21.1762345727258; 
 Wed, 05 Nov 2025 04:28:47 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723f6e3764sm479783666b.48.2025.11.05.04.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 04:28:46 -0800 (PST)
Message-ID: <c3a97601-7c8b-49d1-b005-f6a819bc0e40@linaro.org>
Date: Wed, 5 Nov 2025 13:28:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] QAPI patches for 2025-11-04
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20251104132125.4134730-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104132125.4134730-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

On 11/4/25 14:21, Markus Armbruster wrote:
> The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:
> 
>    Merge tag 'igvm-20251103--pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-11-04
> 
> for you to fetch changes up to 8107ba47fd78bcf8c3206de42dbfb5ba8184d706:
> 
>    qapi: Add documentation format validation (2025-11-04 13:55:27 +0100)
> 
> ----------------------------------------------------------------
> QAPI patches for 2025-11-04


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

