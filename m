Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C989CC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 20:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsT4-0003Az-TH; Mon, 07 Jul 2025 16:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYs7N-000505-IX
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:07:21 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYs7G-0002QY-3U
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:07:10 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4a43972dcd7so45076701cf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751918825; x=1752523625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=33FkQa4+h0oN3Ah6xgEFjXlJTGqQVdY3+kPUTsXd5C8=;
 b=ZpyopxDuSpkix368CcVjKMuOo3Nkjverr5n9tHMwFf7qqHQyzoi6kt+I/WTMI4wZNZ
 P+b0p2sQP1IxZOCKwsiGCnrkxm4G2b+GuQqlV4euSuOtvQdmM9Pc/ccb1KZwssV4b5bF
 5Jtyu+PkdO290sq+3xJ98LWof7tLv5zI88Dq64tvVUyAozjt68PGm5mu+gD+lYYmDiio
 HQVX/jkIFxvA5r3ykNRQlVkEM0RlrYicECDcy4IH2+BIBKye43MP7qeyi72YHcr4Xmru
 ZMDRFhJxfDKy9otRqIxshS3nu9bxXWpCw3iEbk5oVoUwWy/FOthHuCJyZW4IU8DNdMgB
 KeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918825; x=1752523625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=33FkQa4+h0oN3Ah6xgEFjXlJTGqQVdY3+kPUTsXd5C8=;
 b=ShwYGioAT3RAA+MGLFP9qcT8nefVs8s+87/lvtbXzfBkZfc8ApOwv0l5H7n/qfz/1o
 TF3nBnYvkd1dfY7UzYKr6ioTP1ttXtwkhVJhGoikYajeTz9WIkONhSaZvudHuXzGcNmv
 qVCXY4O65WrPae7ui+RClKQA4vosZpqbD8JcA+kUXAvWjnjdtrUxh9EKa6ESUxu/FdvJ
 vn2lRcGkXkFmSDK1fN5JmuNyWUi1D34DzI3M9RJmH5ly2nJk8o3IR2amUojLcam76048
 peLBCu6d2RvN3FdySUJdZmG+7whQ4k4AMKMRUpEbROZpesYe4kU+vOwVrxZ3FRjzZk8p
 yiLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZQvk7s+boXchBSvziqSPa6o32Ebz37VB8BLtg+pRfQbURlLTHYh3UXTH7QRcKM9HKrcQEO9/XsvQC@nongnu.org
X-Gm-Message-State: AOJu0YzElxQtQA2u/BYOPjwzqNGLerp+4K7aM5iKa+nIqG7MMMIE44VU
 4TTkxCSoiqqOi06hi7yx8y3nN+SbVsqo1QMW6e81qRAa3z+2yIBiXOBGqzYdD3hFhQU=
X-Gm-Gg: ASbGncukpxW+NrwNBPyJzBqg9AfRrSC4mAjc22WxgDPLnFIbBkzYCBt2gmjC1nG/gRc
 RWmAfZoz3tJ9zhf5uzkn3qs+0jAyRK2IRIGN+O2hisN5B0MS/ESFg8V0uYym9kGLnxH8iJxtfkl
 G/LrU/vgiHzguahH6BHPiLOcnQpMBmpOtDmu2F7ZXGxHzgb1NCYz6H3HwVZ/qhi53pD5eOVWki4
 8OSZXbjgVG2pwltssGl/SrZA/IY1tWUpKQypCClgHF0865dpOAButvu9zyDvosFy5vzvHIG1M6U
 nm0ItqcJhPBS962WIqjXY0SlummqQPbhUpiWIeuy+wfjyXAVWoZDhDpl1OkeJA/IpiopaXqCSOa
 8qKt3b1Hafimtakqx0Fdzl0NzEsQ=
X-Google-Smtp-Source: AGHT+IE0TB4c0eowcUJXdZRrsr9MyTK+hD+xSVw2bagacVXPZBjA+qPoyQNUfJRDxhDpt9j6RXLRaQ==
X-Received: by 2002:a05:622a:4006:b0:4a6:fa5b:5438 with SMTP id
 d75a77b69052e-4a9985f91ddmr227991891cf.4.1751918824812; 
 Mon, 07 Jul 2025 13:07:04 -0700 (PDT)
Received: from [10.225.72.227] ([172.58.142.143])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994aa9413sm67532191cf.78.2025.07.07.13.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 13:07:04 -0700 (PDT)
Message-ID: <589efb93-f0c4-41d7-8947-6dadf1f06c56@linaro.org>
Date: Mon, 7 Jul 2025 14:06:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v6 02/14] qemu/target-info: Factor target_arch()
 out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250707172009.3884-1-philmd@linaro.org>
 <20250707172009.3884-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250707172009.3884-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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

On 7/7/25 11:19, Philippe Mathieu-Daudé wrote:
> To keep "qemu/target-info.h" self-contained to native
> types, declare target_arch() -- which returns a QAPI
> type -- in "qemu/target-info-qapi.h".
> 
> No logical change.
> 
> Keeping native types in "qemu/target-info.h" is necessary
> to keep building tests such tests/tcg/plugins/mem.c, as
> per the comment added in commit ecbcc9ead2f ("tests/tcg:
> add a system test to check memory instrumentation"):
> 
> /*
>   * plugins should not include anything from QEMU aside from the
>   * API header. However as this is a test plugin to exercise the
>   * internals of QEMU and we want to avoid needless code duplication we
>   * do so here. bswap.h is pretty self-contained although it needs a
>   * few things provided by compiler.h.
>   */
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/target-info-qapi.h | 21 +++++++++++++++++++++
>   include/qemu/target-info.h      |  2 +-
>   hw/core/machine-qmp-cmds.c      |  8 +++-----
>   target-info.c                   |  8 ++++++++
>   4 files changed, 33 insertions(+), 6 deletions(-)
>   create mode 100644 include/qemu/target-info-qapi.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

