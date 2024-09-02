Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E924CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 19:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slCxa-0006uM-2n; Mon, 02 Sep 2024 15:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slCxY-0006tl-QE
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 15:43:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slCxX-0005Y6-2f
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 15:43:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374c7d14191so844539f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725306209; x=1725911009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sDuhJWRa1QvylGm4bjVtfsbudlh0pem8sDtFZ6wOfqM=;
 b=p9V8+dMxPnT8Lw2gr2bCNFpTD9xbB4fu5yRxQYD9gmtbAmZM1htAuBl9Y02+0XJ5eO
 bOZ+g4tMqIbDqoQvJzffNsYFiGPoHFf4hDnRwNGF8GC2sCI33B1WEqtDkOfIshFBEtAm
 Twz/7FEyFzGh/ILQbpDSxDLCLOKuoP0sEono8/mE8DI/gihyMAhOhdujffnLJubkqEk/
 9Pv8pXOUc/UhELViCKUviDvnX0XPGZ1ko/BOPVyzz7xbJP47NHffpJzs9woqGbkx9zOt
 GldlzefdZCaKoaLg3ejpVRjyv+pFh8PBTGC+Ynf5rxCIt6wLo/dYVLLaPpaUGlneNAd4
 /nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725306209; x=1725911009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sDuhJWRa1QvylGm4bjVtfsbudlh0pem8sDtFZ6wOfqM=;
 b=Q7QBX5A2Cb5yPRTlp/45W8AHzA9LdBGMdrU9bFJVyqdvY4Rq7BIfow+ppXuJhurvy+
 YmXu8KuyVaDTjVlo3RXWKbHuXXkSCzHIwVz4v6fLuic7IGBproA8WNAYue00RbOCBSJx
 mFwpQlLAc83MKnTOtnjH20itJ6j5fcZDq5j003F2bUaP0S6mQikpcs0Kn/oJkFd/ereP
 c6m1KHAlJxpu1HHYXuiY0MzD2s8f62LmwA/WVA0XMlmSosX92CjsQCHfOrcn3pZLnAAY
 v2YjTgoiLs7/cnfPf7IND907OcnlgcpXsISuchvTQdF7XjUAvdNiMyboUlGc/rphKPq+
 1CmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXVMBc67LYx8YLXVF5Xr+pPYBwodhzLCw5ZT4NORPD4sd6sTBhkhIDyAas1s4ni5l5USbSTlXG/paT@nongnu.org
X-Gm-Message-State: AOJu0YzHPH8WYLL56L0es81A/BS3/F0aOYsqsaWaMiV0lyq2OQHGtVXe
 ii/mRybJ9DG75x5/uMJVXNNHf1JHU4jduDS8o47sQMny+9Y1acykqk8rA1NQUcR7EIWTa87pGQ+
 nZqk=
X-Google-Smtp-Source: AGHT+IGp81tbkAmTcWN/29Vl7pdPYeLql/6CmyjXtsj7dkJ5vDKVF5nrikpdAz3OLjnMqjsUoN9ulg==
X-Received: by 2002:a05:6000:210e:b0:374:cf83:23dd with SMTP id
 ffacd0b85a97d-374cf83267cmr1962216f8f.2.1725306209186; 
 Mon, 02 Sep 2024 12:43:29 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df79b6sm146505795e9.22.2024.09.02.12.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 12:43:28 -0700 (PDT)
Message-ID: <2438beb1-4f86-4890-b903-b2db6e1f4077@linaro.org>
Date: Mon, 2 Sep 2024 21:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: check gnutls & gcrypt support the requested
 pbkdf hash
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20240830110533.2544070-1-berrange@redhat.com>
 <20240830110533.2544070-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830110533.2544070-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/8/24 13:05, Daniel P. Berrangé wrote:
> Both gnutls and gcrypt can be configured to exclude support for certain
> algorithms via a runtime check against system crypto policies. Thus it
> is not sufficient to have a compile time test for hash support in their
> pbkdf implementations.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/pbkdf-gcrypt.c | 2 +-
>   crypto/pbkdf-gnutls.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


