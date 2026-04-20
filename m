Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E2EF557EB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEkk0-0001sj-9B; Mon, 20 Apr 2026 05:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wEkjl-0001sL-04
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:16:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wEkji-0005MJ-SY
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:16:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso7262555e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776676561; x=1777281361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Nb7VfJlQCS2VPYr2RKbo0dKViqUgICWijeSIk9nu7g=;
 b=ECvtbXnN35C0ne9FIf3o/TkaeiSADPBSgmlWpMJqtzfxRQklk690/isiVtZ7u0YEyI
 884YraTCJNWWyakHNOBiNNH9YdzdDV8/MllKw4DT6Fa4i/CxNSjOZkbldwDX2rBUxn2q
 f449Sv+JDdgttkGztz4o87D/mPVcO1tPa9IMai66hz53iaU2zcBdIQSNN6FhCgU+F06+
 a0uPXbVQESiJZU87S5TCZWRfQWq9lGEaliAYf8DHEdqVtu6ze27JpFHQ6o/9wtQ/N1Ds
 e/r4+zMabZ2HGvQs62l02l2B3X7Gviemdz+OSOPlPbq5bRL3p3d2dQYW84I6yPpq1QsZ
 6hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776676561; x=1777281361;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Nb7VfJlQCS2VPYr2RKbo0dKViqUgICWijeSIk9nu7g=;
 b=UdNGSOakn/G1pyq+/lxFcCl4Rpdec0pw5BqoRguwlhI1L+E+T/mj0V07o/8eS7KUHx
 8WFPZfenECV0NgRNB9ONr/eJ+hc+b6szA9HvLfsrACcW+Gq7ikefY2gbXnwC9j6qWQ/v
 AGmjhogDyP9/f6/hJ4K+XsrCtfLxOIqPqjZjUIb1378sVE62ZW/4mQPWea0uRKOZZwvt
 akz5lpoYmJ3MvRwBNIlS0CF7KPBBq2oHWK4AZCD+I113qCAxWxLqRtlet82STWJTXazD
 VMuDZLREUPPwr7tEJ1mPApq/ChXccnY3th/CJUu+89t6vSGtbn8KAvHXVZ5XqCf7FOXV
 dwhA==
X-Gm-Message-State: AOJu0Yy65byYnjbcyr/HdAWtlmmGzi4avEtRwy1xPaJLF1301kCEsP7K
 ln97Uos5ZQmOWpSkMZJSde1C1LkiwsX3Qng+2QB45hTbm7VMl347+Z3i+glQiW/bP4M=
X-Gm-Gg: AeBDieuxmrWcLyC+NB3CzATPc+YkXOSnLMFYyYONnhsfXrg+cu04p4VFlywZfnje8Nt
 I0uW1T7ueMjxWH4T4MNBGNQHhB73eQUnxSI1PJY92gQjZz0xHAxJmoh8SqLtfsbiRLOZwmq9MP6
 ffhPKmCm8uNWk3J7nPvOJWHnjiJsgOb1mIe8tDWu5D5Kpk9aBo0PKcG53roZVS8UZFx1sU9hWmR
 OPHkKDYqB2T9+fZgFIc7zFnndfAFUlb0sD0aQRC9UImsxgMBQjyiitw678whjtU8ecX++i11kYN
 9W/vGMnlJRG2vaVtxRzhQ/wPnjplD4DrPhOoU+wNWbcMjxj2IiiJewmHEeCV6HrPiCy8BBPFMFD
 b6p1g1WhzOGCH0sprJtK0rs9UAOn3omJpyvxPYqBFRse1UNfkVZBswzqpNXnYea/hMYfc3ZIfnB
 BQXyFckhgnHff1WxJgqmS+xMzpjOisqAEk3A==
X-Received: by 2002:a05:600c:8183:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-488fb765ab5mr201757445e9.14.1776676561292; 
 Mon, 20 Apr 2026 02:16:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm336865275e9.4.2026.04.20.02.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 02:16:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61D415F88E;
 Mon, 20 Apr 2026 10:15:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Mitsuya Ikuya (=?utf-8?B?5LiJ44OE5bGLIOmDgQ==?=
 =?utf-8?B?5ZOJ?=)
 <mitsuya.ikuya@jp.panasonic.com>,  KUZU KAZUKI (=?utf-8?B?6JGb55SfIA==?=
 =?utf-8?B?5LiA5qi5?=)
 <kuzu.kazuki@jp.panasonic.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio: Add vhost-user-rtc and vhost-user-rtc-pci
In-Reply-To: <20260416-vhost-user-rtc-v2-1-100a53bfc6ce@linaro.org> (Manos
 Pitsidianakis's message of "Thu, 16 Apr 2026 11:00:34 +0300")
References: <20260416-vhost-user-rtc-v2-1-100a53bfc6ce@linaro.org>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Mon, 20 Apr 2026 10:15:59 +0100
Message-ID: <87jyu26lgw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

nobody writes:

> Authored solely by me for Panasonic Automotive Systems Co., Ltd., but
> based on existing vhost-user devices I wrote in 2025, so the copyright
> is mixed.
>
> ---
> Changes in v2:
> - Explain "unusual" authorship situation
> ---
>  include/hw/virtio/vhost-user-rtc.h        | 22 ++++++++++
>  MAINTAINERS                               |  6 +++
>  docs/system/devices/virtio/vhost-user.rst |  3 ++
>  hw/virtio/Kconfig                         |  5 +++
>  hw/virtio/meson.build                     |  3 ++
>  hw/virtio/vhost-user-rtc-pci.c            | 70 +++++++++++++++++++++++++=
++++++
>  hw/virtio/vhost-user-rtc.c                | 64 +++++++++++++++++++++++++=
+++
>  7 files changed, 173 insertions(+)
>
> diff --git a/include/hw/virtio/vhost-user-rtc.h b/include/hw/virtio/vhost=
-user-rtc.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..6b7b53c28f93032886d826871=
99585aba0edd917
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-rtc.h
> @@ -0,0 +1,22 @@
> +/*
> + * Vhost-user RTC virtio device
> + *
> + * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
> + *

Hmm not sure why my mail client kills your copyright line, but minor nit
be consistent with using (or not) (c) for both lines.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

