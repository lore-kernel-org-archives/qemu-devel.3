Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55269106F2F9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5mAm-0003YY-M2; Thu, 26 Mar 2026 10:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5mAk-0003Xp-UQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:58:58 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5mAj-0006L9-HJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:58:58 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso1061545d50.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 07:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774537136; cv=none;
 d=google.com; s=arc-20240605;
 b=EVxVL6UQNsxp5S3l0+fiB9HotXH47GWKsEIFrQZjNC6BL/XA1MkaLnAlTkwSBiuUrN
 qbBoYrHO4uasEpN4rQRkiJuswuPSxRnE2Xpj4BuSnlmRR/DxKrr7QG2bwnW6kUWOCqAr
 haq7oqDfoNlxJg2odgKk0wsXc2DZFXov4v9LnmxDswZ+CoJnnKTai00tsJFVdruGOBaQ
 s+BP8UJtOb6aoLEgjbgsCQyQSsrGHszrTZw/tNui5/LATafLXJdUgdfD6pow2IyfKrlK
 TFKPMKNeY55lbdJ83NxughuvkdZUV2JwK4urYHoWP2QAe6p6tXDto7Dcg7HtRnf5J5p6
 Xh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Wm+cYQQdXtRWanK2g8DoOwqHLD/nkrl33PwHLKdZ7SI=;
 fh=pX01Iy5UbPWUSmSo/T1sZj7atqJo51a1a3xB5sMUAdU=;
 b=IB8dcvbXDLFlBPDW+rJkJRh4PMn2V6yrYNTqCyDU8kP0z2cvNa8BxK34sIuwuV23UR
 Xf8zGluZbGZoxWC9frrHlz2wi9g4/cXgmNHoeqpc9qW1PqpNue7TeVjeH3xb6gIJW858
 zdKs2jx9nz5bL01jiie46HBM/CyjyzDMyh4rn7T/hfghwyS6DDdpnhidlnPzOZQ78IuO
 f+dj3HqkYLZp5SWNKhYX64pYerCwZ6Jy9A9lBvBSUZ4MphqbpeBV36sN8kes1AZ4ODoV
 SKmnLpo8CdAmRJAmnwsbqTkYxOEhCORH9WHkZb1SQE5xHlF0piHjCFr439ejMnJ8zwQq
 gI7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774537136; x=1775141936; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wm+cYQQdXtRWanK2g8DoOwqHLD/nkrl33PwHLKdZ7SI=;
 b=G39ld2v0QplyxxRtVbGTLFv2PzeUElvlhnhBDKtycRuwUaC/6DS/fYJ/NsQJKNnO3D
 374z3GxUPMJptSdA8EnBd2KW/SBDN3AYGnkXN7sgu5cTpD21rKckRqpTiJpuVZs0/09e
 iYQN9g+Qa0OyF0bo78rTvQU2C5pZfoLbkak7AuVOA9LX+RuhgpEZig5n8hT061Pip6Qa
 wmHcDRaQ5GQ+ooG4hJAQTd3uHl4DdnBX+89IZE4ufGJwcAfKurvEmnSAGpiFmQcWQiu6
 yVzS/7SresLnJYy9gF69oWj8tRMPHt0Te+7GvNNPyDpHseCRKQ6kUolRNDpGsXnSJpy1
 QajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774537136; x=1775141936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wm+cYQQdXtRWanK2g8DoOwqHLD/nkrl33PwHLKdZ7SI=;
 b=MQjs+dpjkddsZ/oyNpSGbJClErI+6TxZatcQHYf+7rayhAtjz3b4MRqZ9sU2eiV5Fq
 fPclfsT0P65TGAo1VjPwYz3KeBtcHxvSHTZpwRbCHop8ks1PoJIRUL8luQAzltfEOBWE
 /iRZot0Wh8x9IruYG4ZpcVCp0eKTv7V9hgaf6lT+7fIfpikDt84nPitjn8wdFFQYvzM4
 c5T/lNJl8+mc1FKm9fXxymgiJQ0RyhzdANRvZVmxnpGYbDt0ZM3C0bGKm9sipMkf3y3R
 01PES7k0f1Bki1r/pvGhh57fWHdboxwsBiKPYpZ0h9OTnMB1MTJWnJGcfQRRew4KRuE7
 Rt+A==
X-Gm-Message-State: AOJu0YzTx4fqTdKbbV950gQcDezw2T8Fe2weyXmLtEyeyB5N5rdd3Uus
 NdN1r5q0wHtD8mEpbt4cAhhIdwUA7jMF5fodu1TVh48MaVklOIzgbuCidjCAr6K3NOXBXjvSUY7
 X7GRJwXZ/i4tw0FSOmr2kL7jo+oxhi+VhWLzMgVv8UA==
X-Gm-Gg: ATEYQzzhMGs8kC76mJSKtgq7vw7IhizvwCXhNjMl/f3nMzYqxwS6Bk/Ov6DXy+tW1PS
 dBpl75epuc3Ox8Kzm5AJNGQhIaHZO5+S25s/mKBdmZ1dvKaEyNbgCC+FKB9qpAlNIlwskyKcw2C
 czhb+O6ycSpqMprKhoeZzKJAmG1mdpjCxWur5yLFxnsTpwiAYFBa0cos4rBzcq96pBdKeN2FNXx
 vhUxGKs5R8NJhxNI5qV97nqNumxCcyRDIssewYUHq1DTjxLkDgvFg2Gr1e8Z7yPyv98TkIqKxZ3
 fIcm4GijQXnQjAmJCE9zvk7b7+aHDxZxWE0x5wb5VvF3JsvBBskl3sjhVIDvp2iENrs=
X-Received: by 2002:a05:690e:d8a:b0:64c:b242:496e with SMTP id
 956f58d0204a3-64ee609d0famr8204213d50.17.1774537136153; Thu, 26 Mar 2026
 07:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260326082350.17374-1-its@irrelevant.dk>
In-Reply-To: <20260326082350.17374-1-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 14:58:44 +0000
X-Gm-Features: AQROBzCnrSqZjOly1gcjIiu9UVH7BNaf8BPqNKbAKIdizgwa0JcRHyxFKM6tQiE
Message-ID: <CAFEAcA9MULr1GcGhCnZRbK2VCRczaiR2ppCHYeWdddP+LeX9OQ@mail.gmail.com>
Subject: Re: [PULL 0/2] hw/nvme fixes
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 26 Mar 2026 at 08:24, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Hi,
>
> The following changes since commit 007b29752ed06e467d3c830bc2c17a8851f8bcd3:
>
>   Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-25 09:16:13 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20260326
>
> for you to fetch changes up to eb5cc99aff17cbfdad16b18d3503c6f22233eeb5:
>
>   hw/nvme: fix heap-buffer-overflow in nvme_abort (2026-03-26 09:14:35 +0100)
>
> ----------------------------------------------------------------
> nvme queue
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

