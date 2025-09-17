Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBB6CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 15:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuTY-0007mX-Iw; Wed, 17 Sep 2025 11:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuTX-0007l0-G6
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:53:43 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuTV-0006Aj-S0
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:53:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77b91ed5546so224b3a.2
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758124420; x=1758729220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GSRSMiCBlJYjpvmHHWEEeA5aZf2MpeHXlmZ3nfu0Aiw=;
 b=P5uTujU0R16DimvCl2yssD+qmo6Jdvn9B13U1QhLR9ED9mdhUDLb7SDEI7JhM3FsEf
 lThqfnJQkpWO8w8pbtXl8bkXlq5bLuPWXJIg5KIIjZh69oQLzpwjJDsKOfdM5qdi6wMi
 OepwjJNIrVW8gZ3ODSQ2fESYyM6++XXQRr6MAOMtZeaXFe22kkbJ3XheVd5chzR40d+q
 5IjOgrEV9PS4dEE1n6BOAtwImvKG2LU0RmieQc/ATaC6nOJgY7FL1UllN1nWL18k3Qp5
 Y6ZWDNorUlp3rkvX6Ftm+P6rT82XXA9YDNy1A4bBLAto+lmQIQc9W6zjU9YsLJz1tlbt
 TjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758124420; x=1758729220;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GSRSMiCBlJYjpvmHHWEEeA5aZf2MpeHXlmZ3nfu0Aiw=;
 b=OGs4hQW7PCECaqvtlliCWbFnngTMifCMjRXklbhiU3fkhEI9qqZ4dDk2y1f4vDDUv/
 113LLxjQ4vzAb7xrv/PvkBwMAxYHWDwF01u9i4hVIPjI5POLUEYN5XJpOpf7zsLMRhGo
 xGlzuHjcB6vXXUht88PPOzBA5F0343vWM/PuBNypEgywMfOHZwDqDjgJkKanfxMJFAh+
 3NmsOPKmGg1eYvf4O6SJ5sDomv2FCXvFZKlwMwevTmoZfNjizCJszZPjkWQXf4ZQq2C5
 9t6EAlyg+AZXirWl67P6+tvH1NhV47xYxkQuCzUpJpTlEhYVFgELNsETXBZtQ3kY/ze+
 F8pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaTwshxnwI5i/Ce1BRjalyv7H86ZVgbGeA8rBFkrCZqLmsUPISH0tKJVvlnxUT5XISn960OWnQkUYi@nongnu.org
X-Gm-Message-State: AOJu0YzgUjCHBP/vtDJI3YXUgiGq/uBQAJ6GTHNsWM+o6L4sUQg1j/Sn
 k2bqvZHtiekQmud6PQAEsNeI2wvdSZwjCMFp7Po4p5xSCeKzckTsq/iLe2IsN7mZ49M=
X-Gm-Gg: ASbGnctWjSOHhIc9QR7Q1k2IKtZaICrzMWutHB8BqIPCJInZcDJ5lPIrUxQ6w4mZvuU
 B+GqMRBnGg300N6RyBoeYCCRtrWo3UlCCxY/n49lGNxl2mxHjDbsALKE8KgEWUJFJj1MeFDL2cb
 ZHJQr/8BTDaAouuORWVDiBHhLrWxpX2gb7BrkIQJCxEo5XyJu7mTWNnApmQsJxYYHJlsjsvv5mX
 Vtxvesg+JI0pCkTcxLb9VTgSKYhExRr44QOO37kypXuMFjaQor7rZQ9azpVNqw4ehPHqFUZCpaN
 4iPjV0FREWxn2T9+tPvRxbMX1pZOkrsYZxeOnx0SyaJEhNNLhheKZUaxXWQqhtgI6I3f/dXI9ge
 99h8db9GLzpDKLwfiHE96yftWzz5RsaWHZF/7
X-Google-Smtp-Source: AGHT+IHK5psNIDYiFqYjzvcF9rPe0VySsQIzJcppoXUzeCMWzM8XVvjLudWAs9f77qOchgZ3Z/Xynw==
X-Received: by 2002:a05:6a00:4fc8:b0:776:153d:1d87 with SMTP id
 d2e1a72fcca58-77bf6be1b10mr2940452b3a.3.1758124419680; 
 Wed, 17 Sep 2025 08:53:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77c683e1fd0sm1300344b3a.97.2025.09.17.08.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 08:53:39 -0700 (PDT)
Message-ID: <da9ea507-e0c5-4e4e-8624-9cddc77b7ab2@linaro.org>
Date: Wed, 17 Sep 2025 08:53:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/35] memory: QOM-ify AddressSpace
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-qom-v1-1-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250917-qom-v1-1-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
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

On 9/17/25 05:56, Akihiko Odaki wrote:
> +char *address_space_get_path(AddressSpace *as)
> +{
> +    char *path;
> +
> +    if (!as->qom) {
> +        return as->name;

You need to strdup this to allow the caller to free the result.

r~

> +    }
> +
> +    path = object_get_canonical_path(OBJECT(as));
> +
> +    return path ? path : g_strdup("orphan");
>   }


