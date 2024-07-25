Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B87C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWx0U-0000BI-QW; Thu, 25 Jul 2024 07:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx0N-0008Bg-8w
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:51:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx0L-0004oQ-Jk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:51:31 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-368557c9e93so414408f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721908288; x=1722513088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=08urrvynMYNDDjtN4i7oxgs0+ri+z9bSvCvawyV3hSk=;
 b=Of8pQ9b69PD5QjZQFKb7OGqzWAIQ9XOl7oaPponNNLIa0UN5YeDHplk/8n6y0hxz55
 UBXHw/GFJt6g4LoZ8eVKsUlwRQyCYeLtUi/9UxVEd7w4nRO3D/z++3otT9UNrADcgcrR
 m672DmjX1xrG+AM/5dl2/iyLgZEqeb8pMSIRLwQWiBr8sQmTHAsUzyFZcwMCDsVBwIbe
 WXl3toB55HT8onY+pAf4pEaUqw+iiom7lgLWCBZOpdmraB+rNhD+jKGT2sXN+yJN1LyL
 HNTNJj7hRglK+HzXBldcSdCxHsu6iVLKkbSoDZ3TOmzLxsBRZ2IlVzSRZOczsppUT+6Z
 4MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721908288; x=1722513088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=08urrvynMYNDDjtN4i7oxgs0+ri+z9bSvCvawyV3hSk=;
 b=dMBfH5vnPExrg/UMaZYYzDLHYzn34Sr+Mz7NvOrcpmamt9tjzeAswg9aRgmXfDjvrk
 lkdFMXs3BhoJnFsksBFXqAtb71HAtjZtKWCQWtFct+olBRdZyCPBwZvbn87PgxcletKN
 5wiNFxlZkqOCqldSabJM/A4Cync1RA7jgYykC5Cd8QBb5CTRU+puLFLCs/dnocX+2m/4
 2ktlqNMMounfjaXUi9Ccl21nvRVrk5iog4JckkWVkHLK6fmP8kuCbLkkha6locpfMZv1
 IbnckDnBwrDpmZ+VNeKPR9K7ke9yJY6F0YcNuh3+AOZ6Gog5MAF7PvQ8y8K37jH+QDJC
 SK3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgtkJ0RRF8HBf6WkL+IQbZQ6Asv1UksI6fwSmicdgeWcogbFHXXLsR6BYcTCcJhkJnB+K2Q1kqOdSNeqCTBie8qteoApE=
X-Gm-Message-State: AOJu0YzbK9tzneBSwqu6AY1j7R1aZIgfiMEfaqX11LHW/tOoO1GqhknA
 DiFPheOiJtBxM3XETen6dhIsFe6JBSZTu1MIYx/2SscQpPGHg0jCn4GBdrwHWaM=
X-Google-Smtp-Source: AGHT+IEclxBH/6b7O2ZSZfPrLRk2eYmAXJwt5ajVOf7c33W3Ppf+97rO27+VX7iRPOREvW4JFPCgZA==
X-Received: by 2002:a5d:45cf:0:b0:368:591:9bc1 with SMTP id
 ffacd0b85a97d-36b364116famr1406869f8f.46.1721908287852; 
 Thu, 25 Jul 2024 04:51:27 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0574sm1958837f8f.8.2024.07.25.04.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 04:51:27 -0700 (PDT)
Message-ID: <438b30d6-6c16-4e4b-befc-dbf06cf087ba@linaro.org>
Date: Thu, 25 Jul 2024 13:51:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/23] tests/functional: Add a function for extracting
 files from an archive
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-10-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-10-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 24/7/24 19:52, Thomas Huth wrote:
> Some Avocado-based tests use the "archive" module from avocado.utils
> to extract files from an archive. To be able to use these tests
> without Avocado, we have to provide our own function for extracting
> files. Fortunately, there is already the tarfile module that will
> provide us with this functionality, so let's just add a nice wrapper
> function around that.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/utils.py | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 tests/functional/qemu_test/utils.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


