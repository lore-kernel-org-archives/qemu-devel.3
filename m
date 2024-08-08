Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEE9C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2DL-0006uH-30; Thu, 08 Aug 2024 08:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2DJ-0006to-Om
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:25:53 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc2DI-0005uW-6J
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:25:53 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52f00ad303aso1124013e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723119950; x=1723724750; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sckCq5i6T3lCsSCl4keZYp0qac1HO24Vz4waECN2WAw=;
 b=VKvek3/0WTbSScljfJb2pmU7vHeAL05u3SzTjghH/F1R05rnu9G9xHrv9Jc4CeXL2q
 F7o7/0vnBDZ8BmFWlTQs1yDGVg1cMXZRfeu+8ro8mKoKcb7LGK3V/+lK2fL2roBNyfLf
 ZvchGkDcxsZdN4bNIf2ZnAL8VRdsXtKM3wQGBFURgLtJtpH7yl3IF51YWE0rDsIFv6Po
 CqClB1ekeUFRhEnf1gq4JhXfOnrmmfd37si15vAAx7Kuqxp7eyuss6waY0GVUpRSzxio
 vc6Cu0jYA8gGToh8e4ais938LtEN0uuBx7ZX2RdUmLe19dPcAspYq1yIsB4QNZbUbpPu
 gzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723119950; x=1723724750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sckCq5i6T3lCsSCl4keZYp0qac1HO24Vz4waECN2WAw=;
 b=GAVUYQyDcZvzc23i6p/uZURpGdqenhqV707qVpqoEnMll5qUwpnv/fxhrBzFrpmitX
 frEdCN4tM7dsnN9qJE0rZoqk9wAkO2Xm/sczj/an/HMNfsRZfuSKs2+CIJmxud8N7Uu7
 xFYEYRwu3mfA+zBkj9toWPDuTJwvG0VrKJQ/DBDNtJOzOi8wNGpl2usdvWQ5Ly23tS9Q
 Ip86TtvWW47PI9HX8tb/nNFRuclHav+9u9qogWilIjeyRpEEGA+v/yh2rF3ugdpZulD+
 ug9GH8kchRTvtUN/DJS5nJdYWp/o4xChw5JQInSR42CDmH0RrLlIzA8arothzXQeiFA/
 r3KA==
X-Gm-Message-State: AOJu0Yyciak5yCN7m9MThB0+2ef1K5jedU7FE3k4A/aELbugbq8DKZqf
 F5tdCWMkn6ybDDCzjnRIW6RjEucwgr7Tg+Wvjh8wz5u04LF/PvdF53YgCVzpsfA3kjQMM+Tjxd7
 ozyeuezcaEAdEHYNXMmtTeVblO6e7Q6LaNT5KHQ==
X-Google-Smtp-Source: AGHT+IFnz01/4nls6WpQ+FhzptZk6DaQNtr4koDUiXZ+EUnsZmTgH0gvTeFV6ub9JTbFqFBdRbHT1ZmPq/pjBPqDvsI=
X-Received: by 2002:a05:6512:2248:b0:530:b760:92b3 with SMTP id
 2adb3069b0e04-530e584506dmr1401086e87.31.1723119950054; Thu, 08 Aug 2024
 05:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-4-jmarcin@redhat.com>
In-Reply-To: <20240806160756.182524-4-jmarcin@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 13:25:39 +0100
Message-ID: <CAFEAcA8ENru8Cb9DKi_PaQYkox397ZxhPjFbf7ioHjKhAHqKXA@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio-mem: Implement Resettable interface instead of
 using LegacyReset
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
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

On Tue, 6 Aug 2024 at 17:08, Juraj Marcin <jmarcin@redhat.com> wrote:
>
> LegacyReset does not pass ResetType to the reset callback method, which
> the new Resettable interface uses. Due to this, virtio-mem cannot use
> the new RESET_TYPE_WAKEUP to skip reset during wake-up from a suspended
> state.
>
> This patch adds the Resettable interface to the VirtioMemClass interface
> list, implements the necessary methods and replaces
> qemu_[un]register_reset() calls with qemu_[un]register_resettable().

> @@ -1887,6 +1897,7 @@ static const TypeInfo virtio_mem_info = {
>      .class_size = sizeof(VirtIOMEMClass),
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_RAM_DISCARD_MANAGER },
> +        { TYPE_RESETTABLE_INTERFACE },
>          { }
>      },
>  };

TYPE_VIRTIO_MEM is-a TYPE_VIRTIO_DEVICE, which is-a TYPE_DEVICE,
which implements the TYPE_RESETTABLE_INTERFACE. In other words,
as a device this is already Resettable. Re-implementing the
interface doesn't seem like the right thing here (it probably
breaks the general reset implementation in the base class).
Maybe what you want to do here is implement the Resettable
methods that you already have?

thanks
-- PMM

