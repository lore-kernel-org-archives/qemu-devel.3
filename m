Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A267EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDvo-000174-8K; Tue, 10 Sep 2024 23:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDvm-00010l-Jb
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:22:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDvk-0000Z9-TB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:22:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-718f28f77f4so1370490b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024927; x=1726629727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CRSJxafTpI1VJdKR88RzoOdZHSst2RIdjb/hLiOkcYs=;
 b=LWR2PYg3Bijydp+rfGVhHwlyoCJLxVH4VDoFL5KkDRhFNtk1AWlyhH8HsFTrhNgEkl
 tB5z5WC415VLv9NyG/hJlDB1s58PemjvngiZazQnmjcb6ydf3xq9WVq31CdHr3JqBLAT
 Yo1mHb7PPQVGOqmPwa4i6Zx2qxGKVDCIrgeVA6LzMQ+RvTD6b0RDy2AvlrJq84z42mEU
 j40d7LjJEJIk+1t6Xdl9WCmZ74MBYqspDJUH2VQC6QqvnWHbCzDqEQ6Bxe2y/PHPkcPX
 86TwKBDzua4ZpfTCoLUN83DXSbmfcLqaJWPm5KP67cV1pkf4rLOFN+21OvSuC37GChGS
 5nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024927; x=1726629727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CRSJxafTpI1VJdKR88RzoOdZHSst2RIdjb/hLiOkcYs=;
 b=WhfnJCD5HUlfjXb+hnHVQLqeImXvW391sY51/69Th7ht+zqyp/GcnY94s9Kob17e08
 ARr079whFQ7z2ncTj10Umq+0zakkLSTeRvhXSV9y1IZPMRUlt44taewRqfYt94WzB4iy
 3mHQO5gfvBHqPxvSt4Jr0pQ1XwOgA4AtWXwvpkcyt0+oURkEXmQa2afvRfaJX0r34Yto
 ViuGjjJGSEX4ucCdq/MknoVur6XFRTPzxil4D1UHxlNEXvvd9isl5gSS6FdtSMKdeNyr
 p6Jsk4zn1MtEryEQhTQqBvtTT5mYUnmucV2euEy+IREWaaFyNNrKqGr5uCaGYBI3Ro1M
 qGUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlo/n8JJU/fiOVVdmshX9bbQi2ZGDcYsThnZUZAr9QV2UwwE1WaRZhs6SqYEcFvn6xVwifrIj9eAgw@nongnu.org
X-Gm-Message-State: AOJu0YzJcxSouFqLQd+65AG5vvrsixyDh0dfy2dFiMfXGqE6GgHrTvML
 RMQ1q83f3MrDGUXP0tB6W9GSLVPYNkh+gCQXrQm6J7zbr4aBghR5VIRN/NyvqE8=
X-Google-Smtp-Source: AGHT+IG9frf+WkpkkRd6KQAGwnjq3e8nxvTKQDxQk8THsC93xVZ3bKrZT+6d0Yzmv9Pum4Vr/zKLRQ==
X-Received: by 2002:a05:6a00:9166:b0:717:8f4b:afd6 with SMTP id
 d2e1a72fcca58-71916e9847dmr2040195b3a.20.1726024927470; 
 Tue, 10 Sep 2024 20:22:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090924casm2054227b3a.101.2024.09.10.20.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:22:07 -0700 (PDT)
Message-ID: <78f0cd3d-7dcd-47af-8cc8-df0144658bde@linaro.org>
Date: Tue, 10 Sep 2024 20:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/39] hw/nvme: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-19-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-19-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/nvme/ctrl.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

