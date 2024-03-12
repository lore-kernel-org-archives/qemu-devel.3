Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBDCC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9jQ-0007DW-Ry; Tue, 12 Mar 2024 17:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk9jH-0007BF-9P
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:32:12 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk9jE-0002GO-QU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:32:10 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5683247fd0fso6480149a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710279127; x=1710883927; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E23866kkTNeMhUHhjcQjmnegffW0A45/R4YW6bGH2I8=;
 b=cgVV8SwrynQqPdwuuYwJhrGqMXqtQ608ZM0L+SRcW9valGvwL45mNk9jN2Jb0iemIS
 R/BeBcD0DE4PXFsww7vMJanLo8jTS/T7UJnU+gMq+uHC6A4b7d44tW1wC9fDM1o5NbYm
 x4xFV6HDiHcHseZeKljXKBTR4hHOrs4peDAODBfRuGn4dTvI6WzbzZTfiu1ob7OGqoPv
 VE5bS29exO2FioWoAZqb88kvdDlna6ROOGjv8FG+RwHFW8orwx9Ohp2/KYBiyhexBnHk
 J4YLsih/rhMNLX0x2aUBK5HKsVP0+I6QWCzuGxjB6WLafhwS05oQ8l/878p9hdarGMfi
 o7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710279127; x=1710883927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E23866kkTNeMhUHhjcQjmnegffW0A45/R4YW6bGH2I8=;
 b=iZD7qU4NbicXpyGDOTDDLiV6PlFmgQgSTGjo7bqxHnz3JAlKaXyJh5xiVKz7+Iwknz
 nPYPRtDcAGN++7EIUVW5nPBXx6SjLF0pc1sxk2Tey2VVxXnxu4xVFkBIZWmzQyLQ8hQk
 YEvl1w5hX5dv8xsQWEnUoxykGKa+Lt7v/gOYPidI2+Q1o7QQ+xnLdpwhZG/Lb0bEuRSk
 Azkh1gK/86Q8bTcq0dyD5Mi4LvHqopqwYvhGmgjP8on2gg1LIrEjC9zJ/Mq7UPYSCjxv
 yeMVNRy21o2CAWY1yhf3UeIBf2qDLt9SoVLEn0CDDu5PWHk3sfj9UJDwsxgvmNv1Ort4
 jUaQ==
X-Gm-Message-State: AOJu0YxW8VWRaOpBsz2zcYvYdljbdP0c7bDPlvHxRN0ekgDcRvp7Udfj
 s46uvFEToNebvuXVdlw0axGjz8YOvT4rkwiz1z/0qWPo13oUNdQt9vgf84nUNczdSxVdrM/v2Qm
 T7vPI9hYM3BBklFOfeaAGu/ku5nY+HsZ/7Lhz58StsokQrdes
X-Google-Smtp-Source: AGHT+IFNZM4UZAgWr6K5unCkxxo5I2GJQ4eMPFze9qhTnmtaqRw7RPtNL7g1jl73gxH1dBcOtXH6lXExDjjlLaUKnoI=
X-Received: by 2002:a50:9315:0:b0:565:1049:c013 with SMTP id
 m21-20020a509315000000b005651049c013mr7338401eda.10.1710279126783; Tue, 12
 Mar 2024 14:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240312134108.3030801-1-armbru@redhat.com>
In-Reply-To: <20240312134108.3030801-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 21:31:55 +0000
Message-ID: <CAFEAcA-Z11HvR0TmHHvaf0ezi+eK33eLgD4yN8gR4=FtvbaqXQ@mail.gmail.com>
Subject: Re: [PULL 0/4] Error reporting patches for 2024-03-12
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 12 Mar 2024 at 13:41, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 05ec974671200814fa5c1d5db710e0e4b88a40af:
>
>   Merge tag 'm68k-for-9.0-pull-request' of https://github.com/vivier/qemu-m68k into staging (2024-03-11 18:42:53 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-error-2024-03-12
>
> for you to fetch changes up to 28054406715a90e3fab96d4a29190e8857e57fbc:
>
>   target/loongarch: Fix query-cpu-model-expansion to reject props (2024-03-12 14:03:37 +0100)
>
> ----------------------------------------------------------------
> Error reporting patches for 2024-03-12
>
> ----------------------------------------------------------------
> Markus Armbruster (4):
>       target: Simplify type checks for CpuModelInfo member @props
>       target/i386: Fix query-cpu-model-expansion to reject props
>       target: Improve error reporting for CpuModelInfo member @props
>       target/loongarch: Fix query-cpu-model-expansion to reject props
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

