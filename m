Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC439C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wza6N-0006T1-V9; Thu, 27 Aug 2026 09:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wza6M-0006Qu-He
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:25:06 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wza6K-0008Qt-DW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:25:06 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-836c8bde2dcso30799477b3.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 06:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787837103; cv=none;
 d=google.com; s=arc-20260327;
 b=JYuiUtJoMrmt4KpxmK2B+CVB4mgjEGq4whYB+vJZr0GIXPUMV554JrVu+0ZrtIVYfr
 vcobF4YGGOWGbEwvdARiwrX/5lQrH25b/ahBMayqO0eUAqxDhbQIouPOXei2vL0cXnJw
 oCNwDPTLHrQPu4A3fvlypmyYNTXDtNSp4CUL1qQbKIItau3TrLtB1o92TeuiL5jIniIM
 J3AcEzeW7LU3WU1xFv3CTHoi+NnH3zMeg/gLjCuGoGqQ+aLp1jefttZqpARJl/RlX4uR
 8FdmOFAeLjEJEcAoNSujRiEcl/gMVenMV2WxJpDLSopTAeVt9DsPyXA1T4NYSQvRvq4M
 UCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XfjMHc10et9ReVOFdjsA4jI9Vmgt2LhsatNQBv0Y6DU=;
 fh=ha6/36mnVIse2IYGESlpLWU1S2sZOniWgoAfZb7nzCU=;
 b=pIexFbqaIXaDQxXoEWW6R1gzMSiC0+Fn+w5RiFqxf0q+zLX5l3kv5kSdKwoDXBR07O
 mzccAct+izn5C3jp5P/n2He2PRwU5LGFU8wYPuBC4i3jqvkoJ0T5eHGAtv+kwhGzQ15O
 0eOwzDmfnLTHiATp5dV23POQGPv/njuzxFbpwRs3xTW1WPDpsxu51XenuPRWaTTS1wXq
 3m52aqv+JGyenaMi62YT+vQ1vj5GASt+WdIob6Zmig1ADFC0O6aoKxJ45DrE6nSa29IY
 g6SQxKKYJ8Qch5wDNyI6LzyvzrHL040UTwMLyo9kv7m9lQKI5Q0LeSFa8xHa7+P63AhF
 ZoDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787837103; x=1788441903; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XfjMHc10et9ReVOFdjsA4jI9Vmgt2LhsatNQBv0Y6DU=;
 b=YNe4Cc9NmwSSHU0yfJqzTz5iyIU/AQ5TulYQTjTUfb3yRBqbeSiEBYaWejcNaH+asi
 rwe6Yi4khyl67pkUtiUG0Ht9WAMa25LL8u6Xoq3GMwCn1uVUEoQwkiVE4IV10eexXT9r
 +zapV6am9MXighrz1yz2GzcjWSdTAM1x2uftIwNjbsystyfap5Xx/X+JOYAb3WWhS0qc
 6gZ9LYTMrKlMiX+szvVIM7w+zZyvVqLtvZ1s/MreHM2RNbzMFsmMHWQWa8jGRbN3OQnA
 3wggWxMSJR+5Ul28IEzi/8YM+5KY2u2n0dsDj8kLwFUY1dh6e6j2r4+yaM8dRaLxh1HU
 DyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787837103; x=1788441903;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XfjMHc10et9ReVOFdjsA4jI9Vmgt2LhsatNQBv0Y6DU=;
 b=pdTswFkwV7ogWCyQcYlgXETVrats7RutKChdEIaS52WpcLSzICQsHKp8uuJ8JXilpX
 XdwVhiZi6wrAiN1sS5lIaPy38SBb1fIamexVcSHcT4aZHH6uOytpMQz6qeZJCzoYhDU6
 T9FcKupvMoPPKzd3oUK1VjqrUURXZxwNPmY9+SOlRiC56UIbYvMW3RGRVbG02ngOCyOe
 F96VK1Nxf2g/Kp3XLjnvTsxzjWHwN7hT/snOUlt2SYAa7lCWa8JsKSqdQl66nH8fAXfV
 iNuXiJxjQd4QhGh2tEMyugcqZcRDj+tF4exg7Tq3mtkgTmQ93fXoygjvcZriSc3udEPw
 P8Rg==
X-Gm-Message-State: AFuF++m3DZqa/cfLteoucJwDLTkUjfpVBsz4pgIPzdknGm0AFVZ41js3
 jeU75E0qn9B9rX1AkEiBjX+XpiaDVyKpGxVeyyy8S4zxv5WTamdJlsD8WtiOwjjw4H+6YQ+LZQQ
 iF/Jak81RhrkmN/dztkw9xmGL1ppS/of5Z6AyzV6dmA==
X-Gm-Gg: AR+sD10fotW4TO5MzJproEFpU+i/QcZaOC3eue//Pct6oJ5JftePVLrICmgJ7QSMrhn
 V5hrzwwau1LM/v70o3uvpw3nC1Sp5FAR177Jk1qfmFsGOIgMwU1hHRQYGOTjvTDyX5LOKqicu0A
 zckCFK3NWuzFX/0wcVgO6yetrCCoqkmSHyEJrC+hftCCZfyly7AG5ofNF6twTIczjUBhIdjUBlL
 WDUz3WFjKuKy10CmnG3FdhcbFbdV8dMtylpk5SCA0NEQGIlg0oIgAt5FOPjVGsuwms/ptXDUoEX
 iXirUd8C6vYl0zv9lTCS0+oPSQRuKxRj1mOKYR6Nr/IPaJmB/bAQEQfigKQBhwTnJ3JcWBfyq/r
 HnFOZ47u5pFMRWxzAvtaPSKQif6X3
X-Received: by 2002:a05:690c:89:b0:857:b539:c43f with SMTP id
 00721157ae682-857b539d443mr56834937b3.26.1787837102655; Thu, 27 Aug 2026
 06:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260818002629.172827-1-simonxhy0404@gmail.com>
 <20260818002629.172827-4-simonxhy0404@gmail.com>
In-Reply-To: <20260818002629.172827-4-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 14:24:50 +0100
X-Gm-Features: AcwNN1XLCfAouug5BgrkFYDY0KdyTVkPrqcTuZNWq5_PneG-NlKiPf3UuhzrwF4
Message-ID: <CAFEAcA-jp-rQ2rdE-xYpZ75CbBC3ow4x6xj+P_3uNy3M0qevuw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] hw/misc/iotkit-sysctl.c: add SSE-310 support
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>, Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 18 Aug 2026 at 01:26, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add SSE-310 case statements for reads and writes.
> Add new SSE-310 PIDR and CLIDR values.
> Add new SSE-310 PPUINTSTAT register as RAZ with LOG_UMIMP on reads and
> RO on writes.
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> Message-Id: <20260805153005.9989-4-simonxhy0404@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

