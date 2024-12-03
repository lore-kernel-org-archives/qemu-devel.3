Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819B9E64AA3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tITC2-0008FH-Td; Tue, 03 Dec 2024 08:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tITBz-0008Ea-Eo
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:43:55 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tITBx-0002Fm-01
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:43:55 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so9799254a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733233431; x=1733838231; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kam1F/qEZ7VKMdr+MkV+t/FmwgnY48JaJnpbN0LYgGk=;
 b=p/5vkpOLJM2esvqYV6WbT4X9KhTNyPA/KwX9qACy/tH1m9qOacMzfudL48uuQMM408
 AAq+u6qcDuuYlwbB6uL1tjeSwd13YyIOHok6XWF2CYtiacwwzW1KxqypIrjPE//Io0VQ
 wBN6p6K22NbvUSklwsVMVBOpoh2ZRJLNTAUeAlHB4igglxrE+tl1ATavyuO6Sj/LQsm2
 C00pFyi9Y+q/NeyhC3MIlvmpwY7K7No2SbTmJOb6GVYENWVxVnRmbI052CXIJrX6huqw
 9y2kO1zEO9iw+R9fiXIzCQ3+ZJnXkrbZTT5RbSdAAyZkIRPzPDukn9FI2jIlr5XdQ4pW
 kV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233431; x=1733838231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kam1F/qEZ7VKMdr+MkV+t/FmwgnY48JaJnpbN0LYgGk=;
 b=LjREkyrpk0eKFB6AljykEslGPpldx02v9icdSzGnc/FCEVeN7e8u5xI5KmFZHqy9AN
 ZG1XA1Kw/4fithAk1Jg+sKkDFDEsWkgTk5DO471zBKKS/Yh7Y8oMY8uBIyV2gsqfbzt3
 Culn4LUKh36m5+LbuDDky2fvWndB+zIoa2B+8xIT5vHOXo/ygqYeP3C0Xb/BBb9grXGo
 OPDkaCh8Eteq5F+97bd9eUkheJidJlx3AanpPMAgHjkQpc07zsNAFHleRcfmqhavH284
 FpcyLGL9AbAVO5UqmVicIRaPM33Tb5VWLKcH4znYzZ5+4gPTYQh53tD5iNnWs055yFjU
 D67g==
X-Gm-Message-State: AOJu0Yzx3rAXFYTMDOt9ZVtqy/rDVHQSx7kBXY9I8TRHiPTRE7WuiRdp
 oTGxQklVOz03/D9+l3JBzGinNwCoGHkAEpNlFl+6M6D59uwe8NlzVGrC06Ag4ioEaPiqDDjJnU+
 bmFuDk1pdAOr2J4hvaCKc6OdY6Cm+PMVtBF6ilDr1hwMCOaIB
X-Gm-Gg: ASbGncsm+VJk0LBMlNdoGsv9GWLdryK0rH5hpOmHgGp579UUciuv3+MQ2Qbgo3ypBvi
 ZwwBThWry7E2hyMlS64fyh26EZ/+wavvb
X-Google-Smtp-Source: AGHT+IGLZSUB3651OxTjP9BnIYJXYoPR0hRomYdilj6VSeBDEjSZ1+EwtCMVjxFSYu7WB3t9We8IJZx2TJr/rOeXb1Q=
X-Received: by 2002:a05:6402:5009:b0:5d0:f8e9:6796 with SMTP id
 4fb4d7f45d1cf-5d0f8e96a49mr8450608a12.2.1733233431364; Tue, 03 Dec 2024
 05:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20241203063112.9135-1-its@irrelevant.dk>
In-Reply-To: <20241203063112.9135-1-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 13:43:40 +0000
Message-ID: <CAFEAcA_N72LvxtNCh51XEN7USq5OWXpuH_yWYwVcMXWGLUOU7Q@mail.gmail.com>
Subject: Re: [PULL 0/4] nvme queue
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 3 Dec 2024 at 06:31, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Hi,
>
> The following changes since commit eb22a064455aeebc105cc89bf77f48aa18b52938:
>
>   Merge tag 'pull-request-2024-12-02' of https://gitlab.com/thuth/qemu into staging (2024-12-02 16:16:15 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20241203
>
> for you to fetch changes up to 6651f8f2e5051f6750c2534ab3151339b3c476a2:
>
>   hw/nvme: take a reference on the subsystem on vf realization (2024-12-03 07:28:27 +0100)
>
> ----------------------------------------------------------------
> nvme queue
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

