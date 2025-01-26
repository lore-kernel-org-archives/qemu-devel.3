Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D809C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcAbd-0000mD-2u; Sun, 26 Jan 2025 16:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAbZ-0000jf-L5
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:55:46 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAbX-0006WN-Fq
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:55:45 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2156e078563so51932465ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737928542; x=1738533342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DmWAfRYK5boijsv6cV4zUJ6voOlP5Qa6aGO+wBJIhrg=;
 b=MFvLv8hUeIVFkjQeICT1nfghyhpZRXWB5bM9cn3CYpmqNp0n/TIy+L72eIMK6NWRnu
 krVSle5i/FIfrZMYhcj/NyDpm7l1N4CcNBAG1KRpFEq1oGd4VnDxzK6VN/8bKi34cswW
 mvFTCKea72sBufXuhJ3baBiX/ttGPL9cDMvnKkA+ErlKf4/B9g0faxJ4h5dEccxHf/t3
 YbzzkM9oZ+fYwRMDLKy2IHRqsxA20ULu+/Bp0LdSNah/oV27m6Y2v3Kzp3DMfLpELfk6
 IMZRUArgV5C5ycdlfU0fcZ0ZKVwrH4UweCaAa9SOl/kCfu4mBmRqgb1zk1/338qGZWZL
 zcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737928542; x=1738533342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DmWAfRYK5boijsv6cV4zUJ6voOlP5Qa6aGO+wBJIhrg=;
 b=G2IQzykLBNlP6ZCY+LLjmo1h2tfOqkMR7yQVu6UmpH8xo8Cygqk7qDu2suzK1y+jPy
 rONPD+0IB1RfTGplHF3aMz3G4iwximK03Owk6NTcwZkq2UjS3/C9HFT6Cqo2eflZQkUi
 rVI2VAj2mZwk2xdnD/JFOBaq0eVu/zBjxf+40lOhkU5VDdononwojvaFwaGlocIT3Rqw
 3ywXxG8kXcxqAuG46FddnUjehULvBaxNpRCg5gZk13bO+jLZDgLNn3j09OkpQuTQu63Q
 cbUwC6bomh9ugj6NGaxK9pZ3AdqqGUlPJ+YM47lVYtLZokO8Y7ORZ6pkco+Ej/rcw4Tl
 OCFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXNAire+RnSA57ORGpXwFDnVpB/I8MfWN8Tpv9J7x/2+3VITFyPW3Rqkxouj/JScbn1rNit0jJ6+HK@nongnu.org
X-Gm-Message-State: AOJu0Yx5rLWfPTqXravMd9LlJ8KWckTVjbt41i7dl6wKakqTS7YBqSVZ
 Wmxcxocv1SM/Di6WyjoOel7uwsYpXVnQ4CvgXYDU4T+ZSQPneYssGxNAfudC9Fw=
X-Gm-Gg: ASbGncu/OWVwA7z+YIjB/qd1iBC05DiC63XxI3twx12e66m0jdeRSlR1oomG4sHnVP2
 OdniuMPDyxZ9L07n6LBjqPuSxSknBbyvmqHZS1gAYJEGi61mOKxmMZBe1Vpl+0V73+DG7kOPkMI
 Jcaae3k5CD9uWcpml8ZIhaCBi/WvaSDoXRrheCqlGyCyzuzEQBtQDTk8Oewt/4BARD32qgmTq9S
 cWKKZ8pVa5PsSMu7P0NxKV3IIIy7XIdIsgoBsNv44lPrJeKYlxtbfTI+VRCtDtJmz0gMypXkn0h
 CtFz7iQ6pIMe9Jr+Ag3JXt0i/QUkbTnZ2zsCZXyncA0i5yw=
X-Google-Smtp-Source: AGHT+IE3YIYOdo1T6JkUVpGn/pfyuAiore5HYKcZFPZXQV4+qKy/YHVMga/C4yeWraXoaPQj9ToeeQ==
X-Received: by 2002:a05:6a00:4289:b0:725:cfa3:bc76 with SMTP id
 d2e1a72fcca58-72daf92bbcamr52517798b3a.4.1737928542145; 
 Sun, 26 Jan 2025 13:55:42 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac490cb8bf7sm4212809a12.42.2025.01.26.13.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:55:41 -0800 (PST)
Message-ID: <d5ae1267-988e-4e35-9db3-ac19f32f41a5@linaro.org>
Date: Sun, 26 Jan 2025 13:55:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] hw/tpm: Have TPM TIS sysbus device inherit from
 DYNAMIC_SYS_BUS_DEVICE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125181343.59151-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/25/25 10:13, Philippe Mathieu-Daudé wrote:
> Because the TPM TIS sysbus device can be optionally plugged on the
> TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/tpm/tpm_tis_sysbus.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

