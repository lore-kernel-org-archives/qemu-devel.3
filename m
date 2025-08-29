Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7176CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNhx-0001PH-WB; Sat, 30 Aug 2025 11:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us5sw-00076B-Nx
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:39:46 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us5su-00035U-U9
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:39:46 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-327f87275d4so839008a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756499983; x=1757104783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4dzZnDp7KYkcL8hG5rMrS1nawUsw2ENK/L5BwXgZIwE=;
 b=Vj1A8FcNGyPww5n4gtZo4GqAl6eBHc2fg92n9a8Gjtvf31minKx2Y8gFRKQ1LFaZkH
 AGTXwWk0mvjnlGIsAcKtV4bDOXBcWurzbTfchbo/l6N0LZ3cFjV7Myw2HDZP+/IIduRE
 NjOBavIVpdAPIOmTz7M282z3VzGUhu6nLew7JIz2vDfFz7CGjRwnCJJXXXv/tExmVA8G
 gw4aIAMGbdVwZ0yO3F7Lu7YIIFp8vSsfYZzzCXmMLlqyiwt7l4TvltM1YotYksHiPRUI
 UgQd3WYdFXfSHgys+AzE1wGFq2CQZ6JzB7fIfZC0DzDEEVAXaS+X76TBEyvi3KX4qEPS
 hIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756499983; x=1757104783;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4dzZnDp7KYkcL8hG5rMrS1nawUsw2ENK/L5BwXgZIwE=;
 b=ip2gYO2j9vNeBY+V5jTRWWzULRHII3d19aidqfS1INpL72AkOcNxOQhH+hgvzrlUIC
 balsHjO6x/JUTS0CxCzkRLKrmjuZft4BJo5+NFTOWRLj5cM8jBTIAhI2xPRRzRyC1anT
 llPXykM6DTt13KjycDzwQywEULvs6oUlvPL8N4+bS3iFLybOWgh/sLofaWyju5GgKOW/
 fU0Enc43wFIsPJMGJ/yWoQAfTvKvca9PwZ6OorrgcCYH+aRuuP/LpX3/gdE4yOhbuLlo
 5gxhROhY3jm2LricoReBx04Ew/9JFe9BAM495eZWCbzOkfviDCmuKQ1MshbZwSh7lxF4
 lJMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD+GvGFjmUBUxaVxAInRK0GDKR0ESySiVA6QKP9CoxPHHHrFoXO/LRHk7wyTmPhMnFImaofhxCyE2v@nongnu.org
X-Gm-Message-State: AOJu0YxE9TNIybrBj+fi9UZjMEYEU3XgOk2Z2GlxNimmk6YYg63VeT+o
 K5hVwopmc28UjRLc3NeUBgCZfCqTX21p+BxNmVI6N7cRNzVmJgsifEL0uS+9DRnxxQc=
X-Gm-Gg: ASbGncthdGYTd6CFzNeNvHQd023kR4HFQWvw6ejW2GaUrT2GVC6uMICgkDw+7Gq1rf2
 qrZZYU9lRIQtwcemS3IEq+1qyGr9iAnbSqQ7H1NSWCb9n0jfkycNBgICZbaBhUiTVG3Ub+eC9Wy
 ukBz30fqLvWYKkW2Fin5At3Lk7wT+Q1/vzkeKIYXwgdfGwFXDPtN3O7Ww1I88jLJWVcLh6M4wqb
 8FH20oo2V68SV+q2WGKNQKYL0PG1HAnnyq6DU1vEYq8FeJWwNseZJqYsRwPRjidraY/a+Qb6VJd
 T8pRaJrJlwbDaB8egmREXz1pz/1BS5gCS2Vm+7qlWtn92IDga7B8E8+1GF3lInwlOCYXHpk4kih
 bjHLRy3kbKR/w6bY3I1JnFXgs1dbnfKuqjfAlEU6eyPYPyAEEE6W7/lDins87FVObwID+hg==
X-Google-Smtp-Source: AGHT+IEES1TL7Tm3HB0dbu6wdbQDNSw/ODHdTiz1nQPGAAq/XbxhCf/038phfzDdPSmR3j51uIWStA==
X-Received: by 2002:a17:90a:d60d:b0:324:e3cc:d224 with SMTP id
 98e67ed59e1d1-32515ee54c6mr41742347a91.4.1756499983208; 
 Fri, 29 Aug 2025 13:39:43 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-64.dyn.ip.vocus.au.
 [122.150.204.64]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327da8e5ad5sm3667394a91.18.2025.08.29.13.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 13:39:42 -0700 (PDT)
Message-ID: <50578a74-c45d-4106-844c-2df23a791181@linaro.org>
Date: Sat, 30 Aug 2025 06:39:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/9] qga: fix potentially not initialized nr_volumes in
 qga_vss_fsfreeze()
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250829110813.50286-1-kkostiuk@redhat.com>
 <20250829110813.50286-3-kkostiuk@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829110813.50286-3-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/29/25 21:08, Kostiantyn Kostiuk wrote:
> From: "Denis V. Lunev via" <qemu-devel@nongnu.org>

Patch author is wrong; please fix.


r~

