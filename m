Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F56CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68n4-0007Ip-VT; Tue, 07 Oct 2025 10:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68n1-0007Bz-IO
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:35:44 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68ms-0005zd-ST
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:35:43 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-72ce9790aceso64632897b3.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759847730; x=1760452530; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l817tQ0CAOwMh1yGmq7kpTPFN6crwASh92hQQUobZVc=;
 b=XEFJZ3K0SBA1cd8mgdaPt8jteachicwDWRcs9sI9Knz1TqPT3CW1g+JjjetnW2qZRZ
 iUb2XbkmbwkUPUm80l1FsBKG9miIsLEBrttwoyt0s69/gtefuoUU3YhDsBVSTA5ObSPe
 S2TRGVFicmoSn8Dg5n0+8P8MP7teJQpQ00zI1SQeXWGABSIbr98VhdeI6zDKvBp/7dA6
 X8NLDtw2QZViiaOfV2h4lHPnBPMyP7XlmzXvFD6TVY6nTWsART8QUApUcSXpOY1L/00Y
 3zc8F0XQSv7qPgS3jgMI7Zx4zz7HdnLX/hYeLyKoy+BE8HCOxC5jEnzbw6XezWrmajZW
 MlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759847730; x=1760452530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l817tQ0CAOwMh1yGmq7kpTPFN6crwASh92hQQUobZVc=;
 b=WWR8bO5CRiLUHBMkjbzHi6NS3sWYUXlD/n+/KmuZdafzBRdTYOIhy8aTiPQf/Ro+1w
 6hiMN6YsTtp6mO2eHdm7sgo3Z0sGFjyCczq2s1SRSdO7Ioh8YGJD+G6IrGfM1mlYEci7
 KsKkW79/P3zKJo+8yBzYRR7Bfs/GmJG3UDi6HDqt7I0O4G9F9iqemlXkrWi4zwb694AR
 APW+lKB1r+0OvYyOD1m01nv8hKDIx4rfiFgd3ztTbDCjxrhoz3liII2WnxmyBYTJtsDZ
 dBAtaTtsZ6tLpxBz7EhHTv4d0hx6lrpte9elMfBwGp1lYyqUZ/e9zWvv+mSb1/gRKAwt
 ibtA==
X-Gm-Message-State: AOJu0Yz0sr1FKH2z+rHm/aWASYYNEJlMKUZcuGH6DnUOXiZZRf0lTqhQ
 FXjWYKhsO0WbX6luQK9uYKdY84QFmTCN9V/9XaInGzqTHoMjEnG0aSjMfhoMS2K6ELxtKeOunQJ
 eRjYVLW6DGHflq0wB1gYm8KCg40ywJ49yA36sEuSJEw==
X-Gm-Gg: ASbGncvbQhUAKfnVOJdAMvtMRu5tDqVwBgT5LYwV+RNdB5bmmdHcAotKYY6H3mJN83w
 +/auu/1taReJTUNHZBOCanuS0nIGRxAjdXhjF19rYVC9DqS6p3lacyUYb+uwnP2EsGg3BHAzCsw
 12hrO40FGIXNuW+G8HH4ZNlHCCm0s3yt5JvD8WTJwCd7j4tkgsZ+85HmgW5hM2l6TeNCBqeg2Dn
 dlUepk0ZiNfT1zzLP/YEO1HOzDjJsrdBVjh
X-Google-Smtp-Source: AGHT+IFUypfGJZrFx9+ilj7+5Wx0ivve6ifNZ6S3vwiCSAx5xYNgofLxnJbLr9wfojC3ciDIpBspEdH5hnjJchecucY=
X-Received: by 2002:a05:690c:3383:b0:72f:d215:60a2 with SMTP id
 00721157ae682-77f94591e37mr265330207b3.7.1759847729743; Tue, 07 Oct 2025
 07:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251006001018.219756-1-gustavo.romero@linaro.org>
In-Reply-To: <20251006001018.219756-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 15:35:17 +0100
X-Gm-Features: AS18NWDTXZhYUUWImV8sYrX00LSfivqjE_Q37Tx5cuqnUwkM9_kG3aUZ3gs0K0w
Message-ID: <CAFEAcA-S-U0nsDcEV9cYyZiyShRLN_yuKkUD9XJ_GrOiGh3=-Q@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] target/arm: Add FEAT_MEC to max cpu
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Mon, 6 Oct 2025 at 01:10, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> This series adds support for all FEAT_MEC registers and cache
> instructions to the Arm64 max CPU.
>
> It includes the FEAT_MEC registers and cache maintenance instructions,
> but does not modify the translation regimes to support the MECIDs, so no
> encryption is supported yet. However, software stacks that rely on
> FEAT_MEC should work properly at this point.

I only had minor tweaks to suggests to comments in patch 1,
so I can take this via target-arm.next and make those changes
there to save you having to do another respin. (I've just
sent out a pullreq, so this will be for the next one, some
time next week.)

thanks
-- PMM

