Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7406D68BCF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 18:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC1RG-0004B5-UP; Fri, 15 Nov 2024 13:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC1RE-0004Ae-Qf
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 13:53:00 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC1RD-0005e7-3X
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 13:53:00 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb50e84ec7so17540201fa.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 10:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731696777; x=1732301577; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=POlGhVqbKLcRAaF7e6O2qVZOHv77YRD5dBH4fjc3JhE=;
 b=xfdjrOu4TnXGPfely9rfR5sZNNDsV0FbLK0RIP8uDobF52gYEZz/455iQnV5FiNTfP
 vmfIyFt44EPgZUlRAqzxDQLHeymDtD8P61JW7m9WdfiZcUzl0XtSYdIZ7063D4V2Qv/l
 TH3uUMhkcy8cWuFsXEX6Hw7Copcmg+nUO6L3zY0uhqMx66p/l6JWhPFOorntSUVH5ATP
 KM8S1JrqDnvWTa4rKOYIy2dIzSfeTxF+KHm37M60sJu0mRfO/tSzyMsa3cjh1Vgzt2Vf
 TN5/GaZG3hJiKjXGirKHl+4k2wkYoo8VwL2V8WRJ3MTPuHFnPft91nl3j/M3GHj5KKTm
 I57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731696777; x=1732301577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=POlGhVqbKLcRAaF7e6O2qVZOHv77YRD5dBH4fjc3JhE=;
 b=e3j4l6sD4I3MhWObWGfgSFoXdu5o3sDWBdUO59whz8mLDt61I2gRH9I40jvk2sxfZj
 jhF7kn01y8R3fbCcwemmH6iuKHyXaLEIwHTaRKCN336hWC1/teES4kiV58xm/QEcQ5PU
 L/UN82FDyNH4EuPkClBebYtPEFKLRkEJVKfXOTPa+H2UbFb+JOnOc6BCQJZ6UEedkrky
 oJMBg2yUt2y+e7FEHeP7zLV1SNeW+kOkXFIu6VGJzU40q8awNXOp6m07QckRQcHYzdVr
 p3dI4jPX5G6NwTvncuRcltAJVTr9DijZHz0KJ0a3HMOqfhYwgspHqFJ1twfcOjcwvwql
 MxPg==
X-Gm-Message-State: AOJu0YzXdEJri1C1CuDqoEK03quh1ejub5cZtfUxROIFISoK5K9BwpQM
 DGz+6g4aiADz/eI+94za50qI4FT/aQKigD8eYjrHLdUGIo2Ja+VwBN0l5WixzrdYNFVAfXumPXT
 HdltNAj0ZWG/NHM3lVa5XRNcH184O7xaDQYbjcg==
X-Google-Smtp-Source: AGHT+IEZ27rzlY88V8UGEq+a0EupL6b5LiuWpP4qGtCClt/XnpHIDoBqtEd/CSuzqa9l8c9QpvHLdIM0FsQNptB32vo=
X-Received: by 2002:a05:651c:b0e:b0:2fb:2b5d:215d with SMTP id
 38308e7fff4ca-2ff60920855mr20295611fa.7.1731696776601; Fri, 15 Nov 2024
 10:52:56 -0800 (PST)
MIME-Version: 1.0
References: <20241113201631.2920541-1-peterx@redhat.com>
In-Reply-To: <20241113201631.2920541-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 18:52:45 +0000
Message-ID: <CAFEAcA_94tL5e_HDFb2gxEnc-35xL-ZEd-73d5WqPxCx6ep5Kw@mail.gmail.com>
Subject: Re: [PULL 0/2] Migration 20241113 patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Wed, 13 Nov 2024 at 20:16, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit f0cfd067867668870931c9411d96cd518564b7a8:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-11-09 12:34:01 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20241113-pull-request
>
> for you to fetch changes up to 0926c002c7c71749a781de13f28b0481e029d323:
>
>   migration: fix-possible-int-overflow (2024-11-13 13:02:46 -0500)
>
> ----------------------------------------------------------------
> Migration pull request for 9.2-rc1
>
> - Dmitry's small patch to quiesce a warning in possible uint32_t overflow
> - Peter's fix on a recent regression to iotests (and potentially elsewhere)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

