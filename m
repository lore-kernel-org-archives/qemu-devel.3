Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9938EEA4FAE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 12:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUkN-0005qB-DQ; Mon, 23 Feb 2026 07:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuUkH-0005q1-Lw
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 07:09:02 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuUkF-0002Yq-Ts
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 07:09:01 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ae5f0777dso3819946d50.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 04:08:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771848539; cv=none;
 d=google.com; s=arc-20240605;
 b=KmEGZUx72cfCrFroVtivNQo04jtBWrFZXiYFk1r5ZdFoWyUMqaUWTir4nernF48Ppz
 m84XEkUzkPNSfi1dI7EgfxDoZ9b04Ia4eGB1Gm+Wdszdw6TA7iWcG8pV9urjrx3S+Uqt
 H7F4/Qr1Kr7/lSIJqjs8Qno8gNSSvicZp+UzJsct0zT08p2eh/dRn1tUG7+Qy6ynjQ55
 ImZ7oBcdH2n19ljDdDnwuiMiOIZ7f1kGLZWS9lIyTA4Pn8ur3yWxbco4Isiceuxuu6PC
 s0sRWdVWqJa9vwi/oVD7Y4cPpy33D+aO6kzlZ0meZkUqne1SqySGPtI5Be6mkEuA8Jn+
 dH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fy47rQCDR2TY7OE9J8fsqAFH4Saj6dVn2i5RSQkyakk=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=frK5hjtZuWk1FDZPfzO2g6QyQM9cc0JnI8q3Rzi0RXPSUp+aPKgnnb5DrC2s/tm0R/
 NvcCyCAB1kS5E9yoMUr6tzAniIfO/dXVUEB1m25tOwJVsuGyQG640Uaq5//QO4d7f3Co
 ML8qMAdf3a+xzGnFdlSOSJDrQdBl9NIe8oIi+CdtbROycXZzb7FcvOwINSYEVwhdn1AT
 y8cQgzyWu3IZ3HF5HmdXJCk4SlFiOyDayUnzl4WOvFl1h+YolYnELc5vwI58jODC9qb6
 cymYNBys3Z5AenojsJDTHqcKKBYJMm0unsHNYktSWjymg2J74f69ecjk6oWf1RTWZRnG
 SBgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771848539; x=1772453339; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fy47rQCDR2TY7OE9J8fsqAFH4Saj6dVn2i5RSQkyakk=;
 b=clg2uTwkeGP2miXu3QGZo7VW/27MFixJtIJ8zQaT0ZvN8qvS0yPzJt6b+J0wJavGFz
 DV0C3Wo7gxUC0aTQjHOSA2msj2b9hgPUAvwuvpRBz7Wf30i3l23AwoQZBKUicbhydHu2
 1B+HVzXs+SikgVe6xDB2X41G28ktTjrMWe3GhGE1Tw2At/tNNQXGYySQ1TWC6BIR/6Se
 rk8LXieyVk6aIJ8VW4nXaNpXzWwtgcuLm7Nyp3cz051grbmQh3x3ZgB8BN6IcpzC3IgI
 F2tBYXMx1VooRPPhCM3SxTz5ocZB7b+i1z2kviIYHN5te7vGPi+jX3uFtH2cLOK/INDS
 1W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771848539; x=1772453339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fy47rQCDR2TY7OE9J8fsqAFH4Saj6dVn2i5RSQkyakk=;
 b=Djt8lguTy1tRh9XdJCwXurSu2HFMvhMk4J9m/bZKMSxC1QVc2AKUKXoynXdwIjw+eu
 x10GQkI4XAG/Bcrru5JlKzNyem36p0VvW/5JsvzOYNritZdNcMD8yhfVanOzhbn1K2Ek
 reAUiXsOgxyUPF+PgICP1gKOrlEEo5XWBpDJ73VT4jxYmIor6syXlswuIkUqnGoY2qm9
 SfKI+V6JugwLLoykVVR0ocIdZIjTk4EBEuP0YKqbhHagOk3J8nPISbiA5Qp9L3Cb78dQ
 knpHWRIuqqM0fHmoclJNOPYY4IZKHuePi7IoOvHDo023ANmTBBo3PukC4TOLtPDofSbc
 MKFg==
X-Gm-Message-State: AOJu0YzlZLHrGI8NiX7AU/lSRwoVoqvWRDGTaW5GczqUo8IAxrDUy/jp
 UAnH6NRKEfxoOSzkFxVRbr47SrWBuB8oE6mZM33XyMNiZrjNkven6xmJEP6EF1+LoaGr7N8K227
 F3UNgTpD0yyhoSbtCt6Zd3lytfpJDig8/BD1h3x0v/g==
X-Gm-Gg: ATEYQzxuYpnS0jSXXT7LBTi/PbTVbN27zNXaOWAO404e7ooF03uyxE9ohL9/PunPNo4
 d4XAD3npN3Ln+SFrIv3FpRsIqh7VQ8rM3nj7PE6EMHlrSpZmi4yD8mlyVHZ20DWmI7fNLLD8S7L
 lreDey98/R+ED8XA1ThJaiVsqdd3Fzjck2RzHjveXUqLqf1LXZCwXwfDY/BYKiDEXyTLupxQY72
 NW7yELQDIjHtHW1/DHfgd0lA3lj+CDlp8t59OcEV/mCIxuJlcgeTc+ANcj2ISFcSyyqVVIeaz9L
 CluynUIJTDTKczIRtwBvjpEjVf266VKT2dm93iV9f36aNGOYtdtCNVemjHf7y/S4ips=
X-Received: by 2002:a53:cc43:0:b0:640:cccb:1fd2 with SMTP id
 956f58d0204a3-64c78adf122mr4305020d50.33.1771848538541; Mon, 23 Feb 2026
 04:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20260222232222.7183-1-philmd@linaro.org>
In-Reply-To: <20260222232222.7183-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Feb 2026 12:08:46 +0000
X-Gm-Features: AaiRm50sobrqNx74TfsWX48sHTNY8Cq0h0TqQbx-uOpQkdy8I7C7I2MMKXAaqaI
Message-ID: <CAFEAcA90gj6PiozzXGKCh=S3Gc8qk_6suW7xhccftdMYcbU8RA@mail.gmail.com>
Subject: Re: [PULL v2 00/21] Misc HW patches for 2026-02-22
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Sun, 22 Feb 2026 at 23:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 07f97d5da04a9f97e273de85c76f5017d8135a=
6e:
>
>   Merge tag 'pull-target-arm-20260219' of https://gitlab.com/pm215/qemu i=
nto staging (2026-02-19 10:36:06 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20260223
>
> for you to fetch changes up to 7de8587b5317f0bb5f839e2f55855d6c9ee62835:
>
>   net: mark struct tcp_header as QEMU_PACKED (2026-02-23 00:17:35 +0100)
>
> ----------------------------------------------------------------
> Misc HW & Net patches
>
> - Fix trace event name in m68k system controller
> - Constify and rename virtio_is_big_endian()
> - Fix heap buffer overflow in virtio-serial-bus
> - Set graphic display dimensions generically (removing system/globals-tar=
get.c)
> - Mark eth_header, udp_header, tcp_header as packed structures
> - Minor doc / header cleanups
> ----------------------------------------------------------------
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

