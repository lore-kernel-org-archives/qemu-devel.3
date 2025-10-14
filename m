Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D529CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kyO-0007RD-Qn; Tue, 14 Oct 2025 15:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8kyF-0007Pl-8P
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:46:07 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8ky8-0002dQ-4O
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:46:06 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b6093f8f71dso3583599a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471157; x=1761075957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G+1foOBUgDKP8pkUwUANvYxIvOn5l0UiQiAbbDSszVQ=;
 b=eqXvJPvADl1BuGGIBy5mQ/XFFVbL89VArvJEz5oCufw0ZRja87fKvBBzU49P15yWLZ
 Mbura814bhML5MwrMHaE0kqU0IWpo4+Q6tftbvF840igypGdgF5IiD6KZg8AGUATITWD
 eozqa+1szb7q4VS06shb6B/oGHYhvEXPUt4uq5dFvAHwgdgLUCuaNn9z2nvWpot9UUxv
 8dLvlwfQyDwljHrSm3+rGukyZYKcT78lcZ2HUlOkYEfIXzC/0hsEqeDJfJiZuxz3FnFV
 3hpas0qXAkl6aaTnyzc9n9YwvYp/GN3jhiGOf2O6QVPuh0Ju+nYzSdh1mrJKOu7C7C8o
 QCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471157; x=1761075957;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+1foOBUgDKP8pkUwUANvYxIvOn5l0UiQiAbbDSszVQ=;
 b=bFohBtD/Mq6c43OEVs/sJSx4wMwYBCohkOafJU+ntJPKG9WJR95d3mb+sHAhRwXoWJ
 YvI8CvrxaFyPjwBOb7a2jYJ/muQgFc6GtL5b0EgILOoJ14LKQGw0tMk1yjikAXocD6tr
 ei5chQxq9PPTw7k4W22xnC1S1wnlOlXXSCZkVvvIOqAWH+w/TDrqBDLMGFq/I8GSwtdn
 DcjjMm2K8jJTDXOtqV1zudmtdZDMQQuIQiH6GpX27GDcq7t6yOLwgfmHJek9lkkdKtWl
 8xC/+kgBrIElwDpflZsRqNnx7cjiDILEzNbVqN9y6t6meO9ZgHqTPDbFlYs7jxO8O1iy
 QFfQ==
X-Gm-Message-State: AOJu0YyGlqPHjcQz9Klv7Kc/ccLnvr+b3rhuiDqlOZaWJ9ZSbhy0sR7K
 uSIbFT3fwzTSap+RCRQLB6e4bM0TpD+NGTe3riI8snJnum2xqOGFGoeomYFKqbjT0XMlHymQJqG
 7fKILl6Y=
X-Gm-Gg: ASbGncsBZESbghM0Qmkh/NxNkOvjxWj+8J79I6AtvRKQhDu5mdYOw2hPSyjiIqgmxoo
 tEWn1mHbAiw8wtVxroDlrRczzdDp9Q0/WXyvPI8spslHtsOSfNpllurxtkq1o5odA0tkRFKvYxT
 fDUJfKPeaM562W8hiNhQkO05zCw3TzJUpuxPIhp2Hq+nu6SABMDx73KaUdpRqLwwOaHG9b8x0My
 OUOhnz0SQTvjZEV7YjcWd5mdLzem47ZnTEQLMnKgxTcmVYej7SbBFLwHXRmmbiXdEVKBQFN8mF1
 BvCORWGp6tn1r7gTSFQA47dbAS4l2iYL7uSj2AYC1Ox1fnc85lzQ1SCjNN0/nsh3kFelzq4sJ19
 dh4Xba9uub1S3oFEY53rqrxVhlnTrB8nAouXIG/ZP1QmTOOQCrBHU9YJGN6M=
X-Google-Smtp-Source: AGHT+IEPWqwHFQnkkUzQqVOf0L9hiVV12gEYi791rxjGeP8nJZ5qNL1r8IfGbuZu6yIcBFk8PIFUhA==
X-Received: by 2002:a17:903:19e8:b0:283:c950:a76f with SMTP id
 d9443c01a7336-290273ffc69mr345279325ad.43.1760471156959; 
 Tue, 14 Oct 2025 12:45:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f09069sm172068725ad.75.2025.10.14.12.45.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:45:56 -0700 (PDT)
Message-ID: <ccc9eacf-08ed-458f-855c-02b440bdc808@linaro.org>
Date: Tue, 14 Oct 2025 12:45:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/29] aspeed queue
To: qemu-devel@nongnu.org
References: <20251013124421.71977-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/13/25 05:43, Cédric Le Goater wrote:
> The following changes since commit f3f2ad119347e8c086b72282febcaac5d731b343:
> 
>    Merge tag 'pull-target-arm-20251010' ofhttps://gitlab.com/pm215/qemu into staging (2025-10-10 08:26:09 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20251013
> 
> for you to fetch changes up to 0cf9761b0ae6dd04815b54eb785301f35015246d:
> 
>    hw/arm/aspeed_ast27x0-{ssp,tsp}: Fix coding style (2025-10-13 14:37:55 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Introduce AspeedCoprocessor class and base implementation
> * Remove redudant functional tests to optimize for CI resources
> * Deprecate fp5280g2-bmc, qcom-dc-scm-v1-bmc, qcom-firework-bmc and
>    sonorapass-bmc machines
> * Bump ASPEED SDK to v09.08
> * Add PCIe and network tests

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

