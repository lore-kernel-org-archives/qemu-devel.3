Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1AACD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8Vs-0000BE-Up; Thu, 04 Jun 2026 09:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wV8Vc-0008Qi-Ov
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:53:20 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wV8Va-0005Ug-G1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:53:20 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68c19f1f3ceso1117702a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 06:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780581194; cv=none;
 d=google.com; s=arc-20240605;
 b=Z3tPk72BB1OpGmJjC0BHeE8KMK5ZKFhOpYBLUAqZdHcIOtboyEv3gnuZmC5B3QkowH
 SF43B+shCKBECgy8lIC901KyPVtziNe4PQvazcD4nulcRipQKV+ham+/Qmg/n0y4+21D
 bCP9hPGwfjWkqIzLhRWT13C0q6e2ygb6nNlI83VFZo1S9bOBBAKtlSd9Q16yFh4v2EXQ
 CskV0fajwaquQiXZCBZyvvjLMD6xAxs0cULGx0+3CQnOFPiWhyo8VrfxEfRVF2ZeR3rP
 G5qZji0fnU6EVCrkYPFFt3Af627bzCbf25fGc3iLF4w1+IM5y4RxI8XR8xUlVFoKEfhX
 ZnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LtIBAOOVAcAoAONJBiqgdQFjZthaeVmr/1Awuk2fuDU=;
 fh=I4bPGmFuSJAUDPPBcEbiWZt2Bp8JKDYHn7NU1zWWO5c=;
 b=DSG12ECG+2fy5z24VYlXn8Zzztx7ORPDtsKWrmZhnlZNV6ov/qCNMcM87n0gi4cdJc
 MsEYJPXaFCcgA3MM9LyZPZuBE5y8uqremUSlOmvOTowxUu7hLRWaOkta5xv1jKrXwSoe
 Wc+C32sPUq+6+Br24tPIA2PXQeEHXSIXYEFZ7mAYnxgRRoo6qf03lc7TeBix848p1PsS
 SXy5p7/v3eZ46BBhS1FQWNsvaxAjVOFRoJVv/L8So8JBL/aFNWtQT3vrnysoVvbeei6a
 WcBvuHxOQOqCQ2NxiTXv0IfoL63nza3TkzoU96Ubq6X7xxibj6ZuPwuJPZ4fXLNj5obU
 EBgw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581194; x=1781185994; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtIBAOOVAcAoAONJBiqgdQFjZthaeVmr/1Awuk2fuDU=;
 b=tIwzW3/j8hR3ayfk5UwLJXqmX7nZw6ouhRpJomNWnyiRJava6HFWrhszb7SBVoyWNf
 jMmnXDvAXUNeCp4YrXH3FA6AGu2rZqA3H/vACZWxN2E07D6sOgDfbHLrFTnleut4YUpT
 1+MYysXOBPTSIeXuIRRhi9DLn0vvBZplrkY0ME57lJmrP9IZK2ZeOBHffaFIkwmYMGsH
 kKAFOFANN6leZ7l5M/iSJ6yWVS2QMjccqLf/ZId098c+cezfIlKQ2GIA7YlrPYJoUhIp
 HzSV1nKMJTRExLVE0bW+fQToQuuQDNvPUEx3jJzrNql9bpNMZ8DWxNQ/HMUz+crPDh0w
 vtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581194; x=1781185994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LtIBAOOVAcAoAONJBiqgdQFjZthaeVmr/1Awuk2fuDU=;
 b=AMrlZkRkkK68HyAGmxp5c2lOlItcsgAX7L09gJYNs4ir5CahWf86jiMyUzMQk1RiYo
 aNnrvtgLnJCLX3mH4tK7P6bu1CbluMDVfUjV1VqF3gjFkQTSd6Yy7D+Pt0h6RH5iFMm5
 P5qjoYKPbVhR6H73yqatXDSUKnGcuFIgWicColPaiYbNJHT5AZ/gI4B5+9l3sTBAtQPP
 DkYMqtqvtASPPLRvtUXBC9fN/kbjR4pS/1guYqn6QufUa9v3kruFx8P/LAoRBb3ndPwz
 XKRlu+pqZSe6YaO0wd2XF3ew8om7hgeb36DX2VNg448A0CR9HrKmnKen+/xM+pd9hdwL
 jT/A==
X-Gm-Message-State: AOJu0Yz2D4bPiYKW0xfSleu6dXEBDuKUoOPUpq1i1gukaFmDe7WSIiR1
 72/uBqLTKcCeZLWRBXjJJl/4aQ2a8et1n1j+0WV65JOYpMVBmXlTvj06HhA5nePgmbUsBCnwApN
 +espFQX+omdqBAtA3x7Y7v3Dz/Oy6050=
X-Gm-Gg: Acq92OFQOBrb8bpjyRnh8W66BqsYNxDHeLg3nIJRnAZcKMoaezopk73nvUBCBPRfrSy
 Ucgio/21CpRr3wiyt+y2Sp7m4ROUtLE8ZHVcL+3u1T/fCbJ3mm8kltY7haRXRuaZXNPSaiiETnD
 RcTqDYM1L/rDZOsxViMCMrr1Xpq4c/G6cBbbjbfwdIWa6KLucIOScxqvBhwPHfl9OOrvtF6YP9W
 0sL2D+ycApRG5dwGXktMYKzBLtwA5M436aDT2cZ6ktsBb/f+HhKwl34JqZ/ER2Y45osJsdCEy5Q
 OKKWG+KxNkMJViLtTieQ60tyqhUhSzPC5HNV3sc6z7hQ8+XYtIyk
X-Received: by 2002:a05:6402:e06:b0:68d:651f:ccf6 with SMTP id
 4fb4d7f45d1cf-68e6f5a9f7fmr3740231a12.4.1780581193779; Thu, 04 Jun 2026
 06:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260603223430.3311916-1-connorkite@gmail.com>
 <20260603223430.3311916-2-connorkite@gmail.com>
In-Reply-To: <20260603223430.3311916-2-connorkite@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 4 Jun 2026 09:52:58 -0400
X-Gm-Features: AVHnY4I6sBJECJaFrIhgnlaUJquKbr31HqPXd_z9zbWoe3GXUduG9KtrSAjm5_g
Message-ID: <CAJSP0QXPBEXb+w0eh8p7a1F5r_q_ryoQVZnOHQ-nyjRX0UJymQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vhost-user: Consolidate chardev property definitions
To: ConKite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jun 3, 2026 at 6:34=E2=80=AFPM ConKite <connorkite@gmail.com> wrote=
:
>
> Move chardev qdev property definitions from children into
> VHostUserBase. This reduces code duplication and allows children
> to simply inherit the property during initialization.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
>
> ---
>  hw/virtio/vhost-user-base.c        | 9 +++++++++
>  hw/virtio/vhost-user-gpio.c        | 4 ----
>  hw/virtio/vhost-user-i2c.c         | 5 -----
>  hw/virtio/vhost-user-input.c       | 5 -----
>  hw/virtio/vhost-user-rng.c         | 5 -----
>  hw/virtio/vhost-user-rtc.c         | 4 ----
>  hw/virtio/vhost-user-snd.c         | 1 -
>  hw/virtio/vhost-user-spi.c         | 5 -----
>  hw/virtio/vhost-user-test-device.c | 1 -
>  9 files changed, 9 insertions(+), 30 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

