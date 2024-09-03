Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C650CD3440
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 21:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slb1g-0004i4-Tp; Tue, 03 Sep 2024 17:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slb1c-0004h7-IB
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:25:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slb1Y-0006my-Oe
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:25:18 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-371941bbfb0so3717828f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725398714; x=1726003514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qg5XMgNIAPbecRyl+/+UpCVm04X/3lm3OWBXOWHGPwA=;
 b=n2jMbKMtckckGGxcB+HyM0buy7iINriehaOQincU9xGr/73SfLhZQ+Gftv3SZ6gzoz
 BfQvk0SQwwunyA9XiSrfEAuhNjzlJ1SLlQtc5iFhTeM916W7D5RUVqc+DrygQZdt0A8r
 ++Sw4jYzCrwhq7UPFdrG3riRf57pCJFKT6bs0laYzLeH4jNCDadW6uYqUZ+0IraPh7A6
 z0vvIcU2CcA5o+wmvR/P0/j+23Jo/mnCdfMYn4HZ/a6pX8nGZ1sPTyGgsQ1EEJnKb/mr
 4OKA5M6JC5El1j7STgcxpSRsMuOCBQ2BpmDuMTVapPfe80bgl+ua4gW4BTnuOYCc/hjn
 pmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725398714; x=1726003514;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qg5XMgNIAPbecRyl+/+UpCVm04X/3lm3OWBXOWHGPwA=;
 b=VY89JgDlbkTbRBJQjO3gs2EaPdrjU6/HM5KU2SjA1sekacXAvHElDkqibZhU+tYpFD
 0+LZPsfJPbmKjA+DZzLCFAg81s1VZDoUeJUSSsV4ayAS9WOVAc56jx03EDTDyzbLA1ol
 KZVh7rknkT58Cu2aGZKlGwegHob3LAq3YDnu4UYQPyy9Qk5vjd7D9hTdZxGasBCjTcAT
 G2huRCdsc9YTlDsL2Kv5iWJQGytT5hdlA3TWSTsA79I+pw754/4aNzqRRMHEeq6NfZ7E
 HaO7KUMfOLAhtQcZaNQlSm4PtUo9YENaucloMa9sTiCzWHgYtcGmuk8GBgpOQJKkVr62
 lCIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTthd5IzXSPWbBXoyqalwhjTbTffuVILUTS1lM6jyBCBirQ1oFEVKPsMI9BrSsBZKhMHDTFmhCbY5m@nongnu.org
X-Gm-Message-State: AOJu0YzTWsVCgBoDGZIeT1z3KJfhUEn0wXSdiw3U2MNnBKqqn5/jLubc
 hbSCKrpETuE+WwaoWpR3eDWSBKqPfFb/FnSYtjgrTuMLoJXqrjJ5MON2zxnxEFU=
X-Google-Smtp-Source: AGHT+IGw/kwH50t2/xO1iscCYn5uBcvEYXCV/ok9RvRzqLBQmC37oJ6v0+gNphfIIdFvp+6/MLig/w==
X-Received: by 2002:adf:8b5a:0:b0:374:be8e:7325 with SMTP id
 ffacd0b85a97d-374be8e742fmr7335012f8f.51.1725398713860; 
 Tue, 03 Sep 2024 14:25:13 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c29aa150sm9464380f8f.101.2024.09.03.14.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 14:25:13 -0700 (PDT)
Message-ID: <74e730c9-8abb-4644-8948-366e61175e76@linaro.org>
Date: Tue, 3 Sep 2024 23:25:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 36/53] docs: Document removal of old Arm boards
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-37-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-37-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> Now we have removed all the board types that it covers, we can move
> the text about old Arm boards from deprecated.rst to
> removed-features.rst, tweaking it appropriately.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/about/deprecated.rst       | 15 ---------------
>   docs/about/removed-features.rst | 15 +++++++++++++++
>   2 files changed, 15 insertions(+), 15 deletions(-)


> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index fc7b28e6373..815d63f5941 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -978,6 +978,21 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (removed in 9.1)
>   
>   The Nios II architecture was orphan.
>   
> +Arm machines ``akita``, ``borzoi``, ``cheetah``, ``connex``, ``mainstone``, ``n800``, ``n810``, ``spitz``, ``terrier``, ``tosa``, ``verdex``, ``z2`` (removed in 9.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +QEMU included models of some machine types where the QEMU code that
> +emulates their SoCs was very old and unmaintained. This code was
> +blocking our ability to move forward with various changes across
> +the codebase, and over many years nobody has been interested in
> +trying to modernise it. We don't expect any of these machines to have

Note, sx1 also contains "code blocking our ability to move forward
with various changes across the codebase".

> +a large number of users, because they're all modelling hardware that
> +has now passed away into history. We are therefore dropping support
> +for all machine types using the PXA2xx and OMAP2 SoCs. We are also
> +dropping the ``cheetah`` OMAP1 board, because we don't have any
> +test images for it and don't know of anybody who does; the ``sx1``
> +and ``sx1-v1`` OMAP1 machines remain supported for now.

I'd remove the "the ``sx1`` and ``sx1-v1`` OMAP1 machines remain 
supported for now." part which doesn't seem so relevant in the
removed-features.rst file.

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


