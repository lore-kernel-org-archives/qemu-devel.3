Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B257CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 13:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5l3w-0000Nd-H6; Mon, 06 Oct 2025 09:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5l3u-0000NL-7I
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:15:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5l3q-0003Ao-61
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:15:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so3124130f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759756525; x=1760361325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vmPIqWj2Wtv4C49NaQG7FA68ceHxLlp3TZb7QBj4Rw4=;
 b=keh/+VzodiX+5OeHe47ttKl0M6TjKmDXO1dB95JmoM9N/jaqne6h4RIIuBXURHzfoS
 /9Sum/JpGkqIybFhAHifj5FJbXNW0NpvOLvkOlIolA55yLxCJDNdulIo33EkpcPOzmTj
 5nfcnKQ9aITrxpehQ0bcvozMmUb1ntvJWEdq+2Ysuy7nxnNK/MRnPLgBXQdTKzLDt+gt
 pqQM1BckerV9ATxBFxeol6JJTWlm5CAL+VW6bkZ/9rP5auiZ3suqmIU9BRNUdqz+aw1t
 cCnTp1VGpcn/Rx8iA1K8i6W9jo7r3UCHsG6apW+YzfKkWlJKI/JVkFk4FCBwCt7rQtiU
 G25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759756525; x=1760361325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vmPIqWj2Wtv4C49NaQG7FA68ceHxLlp3TZb7QBj4Rw4=;
 b=T0baJxHPxtYDl4nXoN0AVeMm22VjCw98IbPEtKHtuS3kiUoRuuF4Oj+xX8OEeA9hHD
 w7fslBKW9zt9432um5XTiNmcu2lqWSyf/kOj6wX6AOLi5d3pCpbEloRLZHocWIRIjO/J
 10AUEmA3Jbxm6r8yx/7xIuOg12lkYTHgQTGrW+cQ7kakOix0zl3yjzLYOAiEvKyBXPcl
 Fs4AQ5dWiU5uzuOPe4IL4LrtJz9DnOf+bYpiPCCjkKC0TSx8B3yzg22mDGaHjXxboGba
 nXYAuIe1UrobWf1TKuTxnlKmrLdcE9IpSPwVja8Q11P9Es9s2P5fRBcjVRcMTVL+R3bx
 pW1A==
X-Gm-Message-State: AOJu0YxFrGMhbD1lryNWnD802+AzwuDmnaRFEr3baU02y26QgFWgsyg1
 6fpDKT2TlntXYU0e6Zcq1hj7VxNZsjpmigIs9IhJNENKr7MOLeohpQAs6nqkhcCkiIk=
X-Gm-Gg: ASbGncu8MpivEGovBT1QE1psTgUZ7Fpf1PR90+vwzQjQc1LyZNfByUC4i5eAsBC7tTZ
 ETa7xRwDKOyPd61XqojSs1selc1TWw45XhOtTmI9EjYlbVFygiJhlp8oGZ9uAtenbq02v2AEklc
 r3BWy+mYaqSxvzbR+aH4ffDzdNRm78wetIue9/XA5GzGFgvx1bOnjMoQJg7GkmNzHmtkLgu54+B
 If9kZ7/029N12Pxnny6OgC+NtAO1/pmV/R/f1fGSuiTH75AB0kUPKbpb03GAAy0v3iA2+jPzkTu
 p38EZptgCsMT3uynKQul+Ft3EciFnzn0aMM8gIHZcejIkPOjvkBJhocFFGk9dQ42ge9G6jkUA7V
 1sDH2mLDpfuTtxy96RDlANwdbzfCpFwevExscd/nqghcBhOqhaDF3q7WzrzsMt30P6qqJ25e3oS
 lzMpWeSyQG2EGunPJI0w==
X-Google-Smtp-Source: AGHT+IFz0V58JhRk1kKFVZcpt2UYfO2wIR49iXxqvauzKK1Qs17TiMZ5+X3XsCxL2xtz9u8Fm+Vofg==
X-Received: by 2002:a05:6000:4285:b0:3e5:5822:ec9d with SMTP id
 ffacd0b85a97d-4256719ea15mr6449385f8f.41.1759756524605; 
 Mon, 06 Oct 2025 06:15:24 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9724sm20626061f8f.28.2025.10.06.06.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 06:15:24 -0700 (PDT)
Message-ID: <d346ac0c-5d9e-46ab-bcb0-c425741a6814@linaro.org>
Date: Mon, 6 Oct 2025 15:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/aarch64: Skip some sbsaref_alpile tests
 by default
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Radoslaw Biernacki <rad@semihalf.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20251006115022.164004-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251006115022.164004-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 6/10/25 13:50, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> test_sbsaref_alpine is one of the longest running tests in our testsuite,
> because it does a full Linux boot a couple of times, for various different
> CPU configurations. That's quite a lot of testing each time, for a rather
> small additional test coverage, so mark some of the tests with the
> @skipSlowTest() decorator.
> 
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   See: https://lore.kernel.org/qemu-devel/87eczriaej.fsf@draig.linaro.org
>   
>   tests/functional/aarch64/test_sbsaref_alpine.py | 2 ++
>   1 file changed, 2 insertions(+)

'alpile' typo in subject.


