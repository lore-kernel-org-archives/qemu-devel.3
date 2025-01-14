Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB746E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXl1u-00046U-BI; Tue, 14 Jan 2025 12:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXl1l-0003tI-6w
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:48:36 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXl1i-0005JV-Ry
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:48:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso41337595e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736876908; x=1737481708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xvN2XyyamhWgFch8PR1zDMvwICWSSkZMnIGqZbb7/gg=;
 b=NlwtehSUcQsI2pr4c5xQsRrSzvhEA6D+jwooGJ1/dM3crOFOE3bIj3rnoG4zIObXYj
 J97bRXz5rj65U+i92QM/LpkrLBhclNskwqsFwUAl3kXD3gxXMFWpk3J9sSTtZK8C3Cca
 mPYjfQXcwpuLX3/kfwxQPNEvH2onrpHMDPASBOwt2K70l3wTZByFJpw0hkvsNaix5mMg
 Y7MNelzIdoCZePF+CKPx+PxXH5/crcUlCJcvHcXJ9aG96e66wOgg6TT6FnyyLSSz7Uam
 n3bxPvzU+8KbNi0GLkznRdxIUxCn8h3AQuotJ8y0yRkovyyukfJrZsmtrUKkGsjIVStZ
 NDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736876908; x=1737481708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xvN2XyyamhWgFch8PR1zDMvwICWSSkZMnIGqZbb7/gg=;
 b=DmovCegqyruDT0p50M3Pe196Br4BrAbM15d8FWK/jvGWYRpmpTx8iHiCE2s3Ww1aA/
 Xu9twDJF890k6lmKkS/015p+a5YpBPKtp/k5HcXik6fCSi5dDXyeCDYyeL6py1NXcNBR
 D8yPyD4lDb+Bq1EK5ngstGq/x3ZF/Iorb0OMtut84KUjkUvNhvCGT0AcB1lIPklpgBB0
 ptzCrAqviOGxyvE7qaZKA0GnRoSbTxqwipkdcr/F3Xj5hJEuHcDSkMal1UvIxcXGH1q2
 MS2qQqiC0YzkGK+RKRDaIs1W2JUmPCAuF6DQ8tp95PFLQeCW3DIdhNMyGQxxS0PHv4oS
 hK0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUImBmP3/RQAvs2RczT4tj8zYvH8sOfhs2US++6vwYXuSAf5/3R6g1b87XTtZPan/RwloeXcYxLrBUb@nongnu.org
X-Gm-Message-State: AOJu0Yyz3//ZU6MgnaJumlzn1olLKJ7PsX1+ejW7Umr8QpVoQ9FJ1A0/
 wEP/+pzS8TxdhavK5hzQa1jDEBaLrChUhgJ3FKJY5KY1f5nWQ5ahV/l971RIpko=
X-Gm-Gg: ASbGnctSglFSbfBHRsSyE8i2J+x5wXynSnSW+G8rOKAq49ZjU5G0GwymNK5BtY4iWtk
 Yb9M0ZOCa81avnp6Wxjgm4induKlX8eDPKJxI1HTOx1zVnHiD24xGVS6c6Uvb8gCCj/hlBiYLlt
 uPbmw0TEWiLYfEUP0XUZblE/huM8BrXxWFuRCJEwcdpykV7j5mnM1H0Mjswy6Cr/A4foCjv087z
 +NeLUfLCwezjvlDdI+5ofcQCXDHVA2JN5O3CsNsQxKG7wM6GJuEF3wOsNCUf8BD0Ie4KBPeJejI
 FGAhNqSRDJSzN816dJ0+LZ5J
X-Google-Smtp-Source: AGHT+IEHewZXAsjRQPjytVLQpdqr5Qhrx7hgnvuYvFouo3PUBoAT+HkF7RaLKKYDvZgA+7lThQvTvg==
X-Received: by 2002:a05:6000:186b:b0:385:ef97:78c with SMTP id
 ffacd0b85a97d-38a872d2ae8mr20481172f8f.6.1736876908497; 
 Tue, 14 Jan 2025 09:48:28 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1b2asm15050444f8f.89.2025.01.14.09.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 09:48:28 -0800 (PST)
Message-ID: <9b0f8fe6-55f4-43f3-8d4f-66399d74ea6a@linaro.org>
Date: Tue, 14 Jan 2025 18:48:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/81] tcg: Reorg process_op_defs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-23-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Process each TCGConstraintSetIndex first.  Allocate TCGArgConstraint
> arrays based on those.  Only afterward process the TCGOpcodes and
> share those TCGArgConstraint arrays.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |   7 +-
>   tcg/tcg.c         | 272 +++++++++++++++++++++++-----------------------
>   2 files changed, 136 insertions(+), 143 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


