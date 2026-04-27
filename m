Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C4FF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRx5-0006l3-P7; Mon, 27 Apr 2026 15:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHRwy-0006Eh-GQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:49:00 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHRww-0000r6-MX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:49:00 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65075c2ba66so8592172d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 12:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777319337; cv=none;
 d=google.com; s=arc-20240605;
 b=K6kQdXrSg6DvMqZFI/MusHk7rfUovfAADsz/K+5AvezTl2E/FqzUcfZfVMmCzoguxK
 GYnqNWhJz8x5To2+RS/ZS2UGkIbb4TNUiYOKIFT04smCfbeWV3a/wkG5l9DtnuNGxgM8
 IU8DORzi/WCio6WJrwWfUrpZoIdLlgptCvmoSs8IkjLLzFYGyO+m90ZXahBWO2t/4JKw
 MZPvMVMxuZxpDbsgNqX7irnG2ule/CGM0iw8Tcnf45jgmoOkRQ8T98yyk3QAQ6JGzGrY
 DXbIPEp5zu92Q5n3MpNEnPRubMuVz2jPhLhAyC40RNMHAO/baKpUtSlYQsLFIQyPnQle
 49Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FBm86xGK7+6TRBpLb7QFYnm0Z/sJR34iTvyuxs1/tcU=;
 fh=fSx/8zYLPPj7pyuPN3QgN0dHnoUm+Zwly5ZVD+braFU=;
 b=L5qyuItXpAcwCuXmZrmq6cW4KFJEmg6wr1Z3FEGBvKSsE7qtJtTWBS8h3844OsyXK5
 OqspKsC6lXkwno4IGLU76FAm9m4Od4iQVw52iV2goeM+HDySxDS1SiO0vznT/tybv7s6
 EqwIk764LVP/ncJ7CPnSPwx7nmwRhLOUjPxtFWFBcpVA5m0IrJAzboqtkRbuCPgL8bGv
 wh7sWz+isFwE7LcKVFz/jOZzp6TpaVtoJoTU9fINupchxjAMbtrIPScYVswWOk4hHVbR
 wRQjdvMQpSdMoP4lJvTL/vMRwTTBfKjggqedJRfKM5PzbwAQ/XVPSv4RuUgqOlchLgV5
 SxZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777319337; x=1777924137; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FBm86xGK7+6TRBpLb7QFYnm0Z/sJR34iTvyuxs1/tcU=;
 b=rrg0eQUlCX/SW/MAR6GRLyIdW/+zIE5QDBOhF8e34q5Z5l9ebfQdn5CCI7iHZr35yD
 j0m9FTz6yrLVvxyX8NgYIRlMOkqdtT/VmGtNk4n0bs+tj6khpfeKXUm8whMCGbpSLpOH
 9K6I4hbRONHmNZPwkD4bgtTSqxYfuDwcBVH6u0HGxDfKYMZA17Q1v//sClkyU0pxTLAD
 486sIE7Qz0CC+Bskozocf4hCmNDipSbUoajsI86cvWeRgUKS8yIyZHMfN5mG/1ODIr/z
 Pg+sXlJURhOQlO2sOx9ybu+NG/TWFrrtW14f6ZuvRAfa8v+nQWq6XKNfMpR/sXOnHyma
 nOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777319337; x=1777924137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBm86xGK7+6TRBpLb7QFYnm0Z/sJR34iTvyuxs1/tcU=;
 b=fmI/PPR7Y9gL8rXtWliJAHVrzDg2p5nSiCa9dG8rg083TDtlNds47RjT2zC/vJ1DHM
 k0sqmQAFWZL78wXL4Lq3EZAxb1GGBmhbhA9XxbeWgdKiUumCOX/G5lAMbEXycsfe4yeD
 kGkJC7Ox5ji3fBfMhDuspTRuKQsbfm2g6pxih+sIs7kqiqhsSF0svw47wVoLf39KVfN9
 BxB1KVeqEzzMiOtVsUKhMQr2Zn4FVNdE5mGI1FMloXNQLLj+nJYrAnhhNF1te0DPFjao
 o2uJYlealbKDPMZlYj3fGXFlTotqufN1D0MNT0zLQQ1AaYJqlSXWua2VyHK4yNYt7H1X
 WjYA==
X-Gm-Message-State: AOJu0Yw4EOfVJLBjgeIKBcpgcQJwytI7/lzqnEabtUw0nDEZ9Myvg8d7
 hNNMK87WbHv7Zu7F+73QYwqfNTZsRAa41ztpSHpGZL2WgF1v2S9w/MWqpjYlBvHphifjAbaTu7R
 9SZFDCXkp3UoaSjwPGzXxB+KcOBWSM+X8Fv3p9fk2JQ==
X-Gm-Gg: AeBDievt1bCyiSM6F0MHZpQ05I3Hy3ROcPX83kqTh5n7lRmR5ztkokvLKhGrJ54Dnfx
 dUjafJT49/d9kuE5tc8U4Re68Z7coc+vNJQ5UCw9Gw4gStwgHm87X/stLEcuuMCqt+pVedlBd/+
 qg1x+CQ7P+P3aPVvOkVzaLdIExT7VslweUL0BbgWfuDAdDR03vRgFcfy7dWbvBjnMPwSfFThdAK
 pDcmIBu7n8hCXiWkwifm8rGaBB7uGeI60QJ5kur0j6S6JVD/laoolQq8FUrlSasYDKjx4EbzwXm
 BAjWlV4dKjLmdIgp/RQ9zHs1cdMjD9A2+rKog2u7BS2vU5duGxMNRztQy9yRqaerSUqU4fYWboe
 jFh6ew/SySIca
X-Received: by 2002:a05:690e:2018:b0:650:5f31:2334 with SMTP id
 956f58d0204a3-65be0d8de80mr598625d50.32.1777319337271; Mon, 27 Apr 2026
 12:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260427162700.89750-1-jag.raman@oracle.com>
In-Reply-To: <20260427162700.89750-1-jag.raman@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 20:48:45 +0100
X-Gm-Features: AVHnY4I8JTe1CW78ri5F-0PmZhWj7HrCMRC60d0QqdGrcgFo27BTKMZ6cxkDjSU
Message-ID: <CAFEAcA-mJdZWWGRhFteoFiEJ=v_F=7UEH5NB9O5W9KPqQRkzTg@mail.gmail.com>
Subject: Re: [PATCH] qdev: test if DeviceListener is in use
To: Jagannathan Raman <jag.raman@oracle.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
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

On Mon, 27 Apr 2026 at 18:43, Jagannathan Raman <jag.raman@oracle.com> wrote:
>
> Adds a function to test if a given DeviceListener object is in use. This
> is necessary to confirm we're not unregistering an object that is not in
> use, which results in a crash.
>
> Fixes a crash when we execute "qom-list-properties" QMP command on the
> "x-remote-object":
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg1185472.html
>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  hw/core/qdev.c         | 5 +++++
>  hw/remote/remote-obj.c | 4 +++-
>  include/hw/core/qdev.h | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index e48616b2c6..97b09f6e7f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -208,6 +208,11 @@ void device_listener_unregister(DeviceListener *listener)
>      QTAILQ_REMOVE(&device_listeners, listener, link);
>  }
>
> +bool device_listener_is_registered(DeviceListener *listener)
> +{
> +       return QTAILQ_IN_USE(listener, link);
> +}

The approach used by memory_listener_register() and
memory_listener_unregister() is that the latter is a
no-op for a MemoryListener that's not currently
registered (we test for listener->address_space is NULL,
and at the end of unregister we set it to NULL). Would
it be possible to follow the same API pattern for
DeviceListener rather than introducing an is_registered
function ?

thanks
-- PMM

