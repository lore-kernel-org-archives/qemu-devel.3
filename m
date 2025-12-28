Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD52D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZywx-0001im-KZ; Sun, 28 Dec 2025 17:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZyww-0001ic-6T
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:09:18 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZywu-00039C-PL
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:09:17 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-786d1658793so74384417b3.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766959756; x=1767564556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FXCmaCz6FSbA6E+lo0D8VAKHOhyPQbS1hMZB1R98wR0=;
 b=NYrj8Cc0PCpIwwg8gd5HZF+T+nknjwu36HNxje15R0Q4XeJ3QzIOkujEI54h2oQnJh
 rkD/9sLYSAF/cawdyRfIuA8EuMHyfceHxjQ5vPLpxcHJb5xb4XTG1cvEGR7P0YDtQoct
 jWBuLxLaF9dsG37AGiwDiAPQRoMgJ676Quz6XGYUMCPBvPckazHNkQjY+HeeQhePskTq
 VNCNo+HWLyPQcevI1vcENYVIDiWbqlBBAh7qX4UW9ytzJYBehfz73PtkLQh6ntYw0hQ/
 WkHP5UkhVWK0XFf7LuJBIleQKlcs9wPXuPS24vilGn8TE7+NFe/RwWw9AG7kv8Ec7GQY
 7XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766959756; x=1767564556;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FXCmaCz6FSbA6E+lo0D8VAKHOhyPQbS1hMZB1R98wR0=;
 b=Wr9xNWSIwXvBu7Zr7726KWrpIhizhwsE/Z57M0HLE2yV7c+62ajjRnYmpOgb8rQJRL
 vqhc41oUKf79C5uYDMQELXFkOB3QdnTzb75oHSS1PpKNZgJnoMmTJHm3Gb9F9FkrPfWB
 EO0pVT4wksyBgGNO9mvouhzxbfs+2v5uI8WUp/SmzBONKbshcjjRdk5GRHDR/w6+6eum
 p+RRxrLZ+p8ernkAYECWey2dUfztlwQ3N0SuLWbChSxpfquUifJNi5yYzxqeRZy74+k9
 YfToeJoRzSkV4KdjJElHcorhx067grx9kfURMR1tU/ojBZSjeLU6dHngNPe6ELTSCt2p
 l/DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHqwV30XvOkk/bZq0IjNczdKHxPjD5WjF2cRYt19Ljb1OI96T1WFZde8orWW744YC2nAyzh6iv+slX@nongnu.org
X-Gm-Message-State: AOJu0Yw0dKROxBv+UfyrJBd6rT/eO2BIdqz30EwBXjEzNd7Mqgqj7GG2
 QPBCiYjNV7iynFY49SvxBEKoLYbR0CVSec4ALSD0xSbSf0Wi0UmNl5PmXxBlQJLjBqPiisWxDPI
 R6crN
X-Gm-Gg: AY/fxX488YC1jcetnlieJ9rHi2NuOP00dgAbT3sD/v1fKVk6gO1eity1rN2CmVi8l5F
 G6FE6sDL21X2GsCnN6W8dx+pE88Enq8ExyLkFd2Ct7py4uf4UsUir8bHBFTYM3oZwzB5KDesv1y
 y48eOSOQHTVvjPe1aMhs7RSh7ceZtj/V7xIR+IwLXH859ZlYlIla9fBpaOK8TParHRhL97WukXI
 WoOGQbodf0Bti1QVfd2KtY8JAzc9zPElmwYBl3IrJNpn1emqHqaZQfOWo2GfM3uQ0ZQZPV612me
 424h1gJCsLgvEBCrw5ScpqumcQA1SKHzGm9cN1z0W9QLkJUJJDuJlfSbAcEcYbubO+VeLewXdi7
 AsQBYxYXsv17QuYJv4luX0UFnNqlfkhdmQVlRF81EEA4oJuNl96K1nRl+F8kXmq0tmmSKM0r/nc
 Wy1SXoKCUhbMOkwTAN9RYtRDKGwsWs2jZhRd6kv2xGN/i6NHRZd8Qf
X-Google-Smtp-Source: AGHT+IFtVmCJg2j2+kbr4XwvyCWKV3K57uMubySfsaNIef/mkaCPsp3e/8Wd44u1FlKy9PLjca4+eg==
X-Received: by 2002:a05:690c:968b:b0:78c:69c9:d142 with SMTP id
 00721157ae682-78fb403b99emr550311457b3.44.1766959755589; 
 Sun, 28 Dec 2025 14:09:15 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6466a92d94asm13975184d50.19.2025.12.28.14.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:09:15 -0800 (PST)
Message-ID: <d40f6733-ea14-4d89-8fc8-37b812ca3f49@linaro.org>
Date: Mon, 29 Dec 2025 09:09:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] QTest patches for 2025-12-26
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20251226172718.12071-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251226172718.12071-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/27/25 04:27, Fabiano Rosas wrote:
> The following changes since commit 8dd5bceb2f9cc58481e9d22355a8d998220896de:
> 
>    Open 11.0 development tree (2025-12-23 14:45:38 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/qtest-20251226-pull-request
> 
> for you to fetch changes up to 9eef3854d30911d117f85253f1f2a154e4076adf:
> 
>    tests/qtest: Do not use versioned pc-q35-5.0 machine anymore (2025-12-26 12:06:46 -0300)
> 
> ----------------------------------------------------------------
> Qtest pull request
> 
> - Fix tests using deprecated machine versions


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

