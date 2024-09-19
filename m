Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A724CE8D5F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 09:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srD9g-0001oo-Na; Thu, 19 Sep 2024 05:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srD9f-0001nV-C8
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 05:08:51 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srD9d-0003pT-Lu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 05:08:51 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53660856a21so539268e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726736928; x=1727341728; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WZZTdW5IM9H3BJtV2HMjAaknCf+SKGFMIVGVXnEZP5Q=;
 b=iYZbSLF9PcIqzCtDNpgSLBiGYfFqrre9/CBAxoQstcL6AQrMX2bTJB9cNNjSPqnx8W
 5H4Wd88RLTDWJ2srUY4FLlUpYtSj5Nb7pO8dVIM4X2p3OVk/UjmS1p3XOL3baxfUaFdC
 cpyN7MHheZj+LQIxzvOq7EZAJeripNc8ip1gJl4nIPXSDceBZPc8GFO4zNsJCXvVvvFM
 87j15BIDn94u9JrryvIw6y3cfQA80raohwHdsvxW1vM5I/QwDcDhkI0XAWwmFSV9SdZu
 tn6lEpBASEWi1lSGWsf85/4X5daxv2IMYsp8P7TUrGCliaCbtVRbufpfBamrp3xzSsrg
 QbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726736928; x=1727341728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WZZTdW5IM9H3BJtV2HMjAaknCf+SKGFMIVGVXnEZP5Q=;
 b=EmAbvKMZ6lK4bKLHwuUHkwXTmy0zGTc8If0ITVDb7gt3qW9ArR9zrORBm72LWI4DAG
 3ZSNMSEVuICn55tLnAiT2ieLve/NFzkGCbqxUzmJ6RLQYOCZ6mt2Vyfa52F9Shd4gRw5
 inZaacmIZkXAqHcPtUeYBr36IxdJQwwSFbLfOKBxi3C4AejphCdEGfkQZIRL5SW/q/jw
 W4GPiHWfcX8jlxnazAwF3W+UwlvSRGGir0qpub9th1P2wismeO0Mso3OOL+6P6WXjqhH
 3ukSXJ9HdiXSPcygFnHbXLv0/oa+bTZgRAUh9pHtz/JKLaWp6tIhJA4HRqy5lKdpmioV
 d8tg==
X-Gm-Message-State: AOJu0Yy0u+Zhk6kS0djBW+kIz+Z4w2dqNcmz/gVO3LNGUk3/9FFJuMMt
 5iRZsvTWBTM1MVg8ahY8g4AUgAn/p3Nx2onNbTUHT2DLhnSM0BWRlCtHc4JXwU9QFk7Y1hOKmuT
 iclNPCV/4ZvYXzosoMDPfuSHQT+tSjjhBLrsgWB+PUghHYvyE
X-Google-Smtp-Source: AGHT+IGIxy6wnU2uzuWd91792U5APtJr/ICWKDSC6GMOlFbvkMSOe48rU+w1p/p4qdpJk3Wj0yQxTaPeM0r0uKW/CM4=
X-Received: by 2002:a05:6512:3ca5:b0:535:6cde:5c4d with SMTP id
 2adb3069b0e04-5367feb9b81mr13551733e87.3.1726736927589; Thu, 19 Sep 2024
 02:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240918094624.938242-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240918094624.938242-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2024 10:08:36 +0100
Message-ID: <CAFEAcA8Z01m_-M4TzHW56in7ydk2NR7jrsdg1CTD_GzURW5nug@mail.gmail.com>
Subject: Re: [PULL 0/1] qemu-macppc queue 20240918
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Wed, 18 Sept 2024 at 10:46, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit 2b81c046252fbfb375ad30632362fc16e6e22bd5:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-09-17 14:02:18 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-macppc-20240918
>
> for you to fetch changes up to 2d0a071e625d7234e8c5623b7e7bf445e1bef72c:
>
>   mac_dbdma: Remove leftover `dma_memory_unmap` calls (2024-09-18 09:31:56 +0100)
>
> ----------------------------------------------------------------
> DMA fix for macio IDE device
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

