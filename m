Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C992BF47CA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCob-0002Nk-Ld; Thu, 05 Mar 2026 12:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyCo5-000230-PM
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:23 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyCo1-00027x-0h
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:15 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ae222d978so7880442d50.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:48:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772732892; cv=none;
 d=google.com; s=arc-20240605;
 b=BrEvJata5rp63Iep5dhD6CKO6WWZ9v8ZrpsKP2MxnTMrvy9LtRn/Kgswt+bAhvmboU
 x0WOrMBGA9iLXuD43xJvU6MDZQEMvn0jF3xEQ+S3gCwBdEj+UyFfC2cUDZVJaxHBMiuH
 lIeFVc3mhSBQt2e+acW/Xa/YMJKVC4YXrJGhuZO8fEI4U80FMRApci6j4l5Gq720FoSl
 rCwhIjdqgbQIKVByyrRdSssgyCo8V4u4YEmhZFDgc34Fhw/8JvilYCngIFep3ofpjYsy
 v/CeQfJlIUNUQfZsfhZdwxlHjTXa5ogD4HTp8l5fimbJ2sWVyUgfWsiXNA82iHXb5t8r
 GtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ioM9RbY8r4gFoM9g3byEC99MHLUkCN1E+7NCBJ6pYcg=;
 fh=gffcMCOUXtBOrrjZQMiDLavK++hmBvO7zO0yh09tQqI=;
 b=gc9KW9/KkFhJMbiLjzkddIjpcWRJ+7n6WBL+OjzjIqWkA7hm784Tfj66X9jiwYPPCa
 2revyJycomjzvTCieWwekZPiqk958X9hQDNm/G05OaMrV5PePyvvaEmezO/cVVktilwG
 j/AtvXvvr4hKSMH0t18A3eRYgBMTzYYIgEoJt0QR0/ygg0IBBqlvBeGDlG0hkUNGHfao
 TDiWBV29m4D+PlL0InInHLmyH04+C4TTzICYFnVnuQrp/7ft9zkGGDJ2AdOrqGG/RQKQ
 aiBQDHUJ4IFdYpaDPtE3YbIxXr/5dCq6DVrCVvkq1fQ8sqbVDTMXy2UD1u3jg4Re2JMS
 DRPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772732892; x=1773337692; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ioM9RbY8r4gFoM9g3byEC99MHLUkCN1E+7NCBJ6pYcg=;
 b=Gw3qGdql4Cp0MWh48WuqgCjaMQyOevrABRBBwEkQZBcCAYOEpIH7QzUj//1IAKsGc5
 hfBpBCrdK/6qi/QYYg5Q8L1Ya7Gfmsxdg9FURYk2oy8HG+1ReWGdiXLlnhxonisUD/Z8
 7hX+GcTISq4griyQhtCv17uXIGmfH4ayLpi8g62Q1WCaZY5liIOV7hrTCD+dedLIohs5
 uhZn7KTd8XoqAOa+T4a1fdeBFHOIQ6qeUSvqvz2tDozkZsomssBrrYnxPyFxMBAUlxDa
 WM6wzI+lQ128jkvkJbirz103KXOugm9d1EjiecZ3yz9ZvpH5b+udVygnQjXs0Aq2dt9E
 iI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772732892; x=1773337692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioM9RbY8r4gFoM9g3byEC99MHLUkCN1E+7NCBJ6pYcg=;
 b=Br33rtpRR1kp+6fys6QZPGK7mFRqUt7mYo1xJyF7NdMBVPWVeRPCLXN6g3Rn5NNT0C
 IHaPbtQOluSevUJivaryet34D2okhvtEh1DMeFPbnQl+BtinNGN8vttFf0EX3Fxpp/Yf
 71BbYem2heyzBZnnZenkvG1f+FvwnhAugPMMD4NGLdb8gU/AVDvSiUFcYTLbAv96Ds0W
 jMHlgWOiEEfQq7Y/5901Qee8wNQiWSLCHiPJXh+zxUUxQemudYNUUvXSyqhfDER+CyMA
 zKNn3eCQgZVuNCTlO4o7BS2x2ZXiW9VEyf3NNKxm1D23jlwmQ8EZ+/per5nTo5hvVGfh
 KRdA==
X-Gm-Message-State: AOJu0YxMf0BX6qbHbGz7bhSX5GoSxkOP5Hb/LEAbH93cqu+iF+RDlzp1
 JndKbyKL/BYx4oELgWVHs0eHpLNCv5t9xQL3waC/WBxiQgq1ua4JTPObjMPwzvX6jmqd28ThktA
 sXp6/V15nV7rg/xTtiOcJMCmUEt5pCLX4kb/VmYLAKa9xpnJYzL6V
X-Gm-Gg: ATEYQzyo0ujUi8PrWplc7hgFfpkqLS8VuPSAhVQ8V8SAYORaJK75AFZF3u6lak+cp5q
 McWdDkfEQpSQIcQ53Z4uLCiLBT0P3eh7zuI64KC5b+WlMCqjsSiovjl+fFkIzYKMIvB+6fD6qEp
 LzBCf+U6199Yinjyk77f6uQVLZu0/ywM7zavgJxNDRDmBnibycwHxj7z+xTp2yLPpdGZKFH8q0e
 vpOJZZ/xbAW32VOegK8Iwg5/jAEl8AfI4FXdMcB+RXnwiGUgM4/sCaTJigwPh330xt4EDnLl/fY
 HcHOgk1sDYeJA3z3gLZkOpYCWpW8HJPaDyO+3JjjbNB7HTuet7NsK53AZXh27k1sWlE=
X-Received: by 2002:a05:690e:1697:b0:64c:ed24:13da with SMTP id
 956f58d0204a3-64cf9bbef4dmr5918186d50.57.1772732891738; Thu, 05 Mar 2026
 09:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20260305105215.302571-1-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 17:47:59 +0000
X-Gm-Features: AaiRm51q7ttIa4P1IBlIOqQxpJZJ3vdnS1hrSWZbz1Cpoz7wIhjjwVYu2CCMKxI
Message-ID: <CAFEAcA-PhLaic-XVwFpK89UJ0xuhKmOq=9v=fJxOV9LfxsnU1A@mail.gmail.com>
Subject: Re: [PULL 00/28] Remove deprecated pc machine types -2.8 up to -2.12
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 5 Mar 2026 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9:
>
>   Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu into staging (2026-03-02 14:01:46 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-05
>
> for you to fetch changes up to 711de639d571b6ac6981020536ff816130768f58:
>
>   hw/display/vga-pci: Do not expose the 'global-vmstate' property (2026-03-05 10:33:25 +0100)
>
> ----------------------------------------------------------------
> * Remove deprecated i440fx and q35 machine types -2.8 up to -2.12
> * Remove the related hw_compat handling in various devices
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

