Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E201E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZ6r-0005nW-0e; Fri, 06 Dec 2024 09:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJZ6f-0005hc-6K
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:14:58 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJZ6d-0006d2-KK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:14:56 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e63e5c0c50so1133076b6e.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733494494; x=1734099294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9DO3MfHseDPhC40PHjPiKrOrG7RrBBPn6LvQQR8Im1s=;
 b=huYBFxMD2S7naUVTqkjC6dnGdbpgAy5Hg0a0B7A2uYkupN4JiTA9pioL7KHS19eR6V
 oPEh5Cl7277FHPDwN4jL6IlFopnRmZiONxM6zWr6pesot7W+o7TVs99OMMQhi6w1Otuu
 SzOORMKC1lfZ2jG1l7k3T8gHU66JxboN8wE0n2u6aewyzgYJ/HA7iLxEPs0lCNvtjaTk
 zm+j8rZKolxRLQqMQxJVzj6hjjK+7anRggSJSgyQiBV6LFGisln6Koiv3sc8+RAzjqtm
 efEBDOhWFk+CscwVU3vioUddh/a4xSmDxjo34h2LNbGRfm5wk/P+TGbkdG0szQJRcbz7
 GSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733494494; x=1734099294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9DO3MfHseDPhC40PHjPiKrOrG7RrBBPn6LvQQR8Im1s=;
 b=AWWZjs7diBAwg4ce9tG4oDVIclwFjG6WfePl/2DALvn1a70uOU1+6f4lD4FcjAgXMO
 6wEXqqCAUkoQe+7Gz+P/eAP+7HBsRWWfwSwkmT9ejF/3EgPcdn+8suSSVPs5+2wwijDZ
 vkEOTfpq7PHPgW3Z0t6orb7SRzd+naUxK86o+XjOpDjTdAs5pYlLKwN7cEPfeUEhXWTQ
 DkJAqFW8vfPKM6FrYVDvsHJiJfMRIyahJxdHSrLFUzayGxkgZe4iEhkbwa4s0UeoDg2g
 W7+AyGmwA4JfOitQLlHZWg7bhYEPKUvllMznwQoLgJ6d6egKc54+H1ASlTgoSKBrSzd0
 qcTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN07yK+kBbjrwS0UrVQDEzFjmN8X3pR2f5N805Oi2PZwm+DuQSuOYeOQwR0SkgSazPfcmt5N+DqgWB@nongnu.org
X-Gm-Message-State: AOJu0YzJeWQB6cT1ALJri06QsJzSrVktuxHjFZ8JNrExrSs3edtAD/p5
 WMCSdsrEthaZ5F/s7FLmFpkoFKeXYnSn0D7rxZjiBThaGMpJgUW5/w2tZ/tOKE4=
X-Gm-Gg: ASbGncvl41WzpRsznU25kKIuIW5DfTDqSA4aPuRA0agCu8NjQXbzQIAqNaqFQjV30f6
 pJ3kOlC0VhVa6QUfuVMIVd91g0uIFkJOS4cqAhdIXNp15pV0DVxBIub4ABmdoxXO7XAbDWN22zE
 FaVZIFTHnznCOnZYWkLL7hvs2CrfHuapXKGaCsE1xqHb2YZ+vp8BLSTwPOYfu9C0Kr1KRGyQZLv
 29sNJ9E6OwG2NipLbvyewDvNZxVxVqxW99E0XggyGuKv+oxxNGfjwMR56uiKVI5Y/9d4nh/bcl6
 jmnKltW6usJ8euTdaalZp9YzoUNM
X-Google-Smtp-Source: AGHT+IFYLHc/QJAzfJOsw9G9EygckyFDzQBrq5rkYrRqmcNOwkWeZZvZhe2yTn7S6W+av1/2HOAanw==
X-Received: by 2002:a05:6808:120d:b0:3ea:3672:e638 with SMTP id
 5614622812f47-3eb18324f55mr1963656b6e.3.1733494494089; 
 Fri, 06 Dec 2024 06:14:54 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb07674e24sm753922b6e.9.2024.12.06.06.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 06:14:53 -0800 (PST)
Message-ID: <df9cbf33-2e74-4ce7-a5d4-1cb952fabd83@linaro.org>
Date: Fri, 6 Dec 2024 08:14:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/15] KVM: s390: CPU model for gen17
To: Hendrik Brueckner <brueckner@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com
References: <20241206122751.189721-1-brueckner@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241206122751.189721-1-brueckner@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 12/6/24 06:27, Hendrik Brueckner wrote:
> Introducing the gen17 CPU model with feature indications
> comprising of:
> 
> * Concurrent-function facility with subcodes
> * More vector extensions
> * Ineffective-nonconstrained-transaction facility
> * Even more msa crypto extensions
> * Additional PLO subfunctions

Is the revised Principals of Operation public yet?
I can only find SA22-7832-13 from 2022.


r~


