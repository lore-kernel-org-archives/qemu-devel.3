Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C236F4BB65
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwRy-0001Bc-Iy; Tue, 24 Feb 2026 12:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwRx-0001BC-6D
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:43:57 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwRu-0004mV-No
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:43:56 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so659445d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:43:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771955033; cv=none;
 d=google.com; s=arc-20240605;
 b=Rz3C+5FhIW72XxK7bcuCdCpe9h2mCNWhSVYSmbZMv+YoPZc7WV5KVHu2Ka2wVfxSZL
 MHpUH+GTBtDkmDgCyCnQRzfapSQkW2cFv+c+NpOM6o+NoRC+FzM9mHqNZI5mnmJxAH2e
 NKJrZXFzzfHcH9YmYf/H5jeY0yNSJVTeWLAhPA9zYkDKUCagN5UJkDNRxD3PJta/Q5Ba
 /YJnvQ2dd0swiRCfY7nB5vkM2AL73MjBtsMWODsqrQdHBoEUGdXTOtYL5dS3DO8PyjDD
 h7X/dUBKgkUQ/tM9C/qwEZ4Y5F8f7fS/IjgyxT4LSoYFaJ0Rjcl3kbf4vxX4+IH94FkD
 L9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bvlXZJbrhd0UjHZmAuDCJh18ioMIHHmNpbs0qCxkYDY=;
 fh=R84pXDYvJznuJb5dunrikqaEeI9MgwuEGgEYHxBIZ1A=;
 b=askScvQtI6VCI7p/hyq/73DReStX7O8uaDqxVs8ejz7R0n9GgAF3VpRXAdG5utDNcO
 ZuaHj1GMdhn0E8OZuPS3dXAf9BI03BKhpQz3ncXMs4P9dewXjVBE4hJY79q7EO2pudTQ
 wnjVgA0GR1JpisCShHxkG4mYAPvJVKIuatV//gHkl76YcZYcKMixoE3YxV30ZC0F+yUA
 WxaYnhCIoqg3xOenWUO/FlN+mTAZW6NzCsSELFo3VEbsxfOWiMTJtA4sbcdqr2o09uQr
 ghSpIn+eytruGIGx6IYiTa3RZ6YBYstry0ujJi3A7wDFFKkIXMeJsI7ePXYfjoHYv7CO
 R8Dg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771955033; x=1772559833; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvlXZJbrhd0UjHZmAuDCJh18ioMIHHmNpbs0qCxkYDY=;
 b=q6Gwzop6na32UIGFha/no5yqlLIL0RBSkaoVfILWdr++3Pa/IzDyZ2c5AL7t6dJRpn
 3w3Gx6GHqqKhYJBGdlkkoKgIuOUcEctIBsVy49ovv2m4UIPCungWDXdGZfmCoMdRmS9M
 6abHaaYzZq5+lNvMMMSymWBbyOKh8ErKz8fzE9pd7Lq6Jz8Y7l+v079FsdTEJyOOMTrZ
 dRgryh62V3oOPRAEZUM0J2+Bq4K2o9s2Xtau0rUwgNmXTuk/kTG+xq6LJ3Skn9U3VDHM
 rXRFofOJXV5bHWhcdKx+6xaNlFo+/e2hffPt4aTrHmHUZthgD8zOfrRGdmyM07RjMD5j
 pG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771955033; x=1772559833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bvlXZJbrhd0UjHZmAuDCJh18ioMIHHmNpbs0qCxkYDY=;
 b=kewNxHaecajZMhEasaEWGyyo5MElZbrSb3m3oa9Vpeg9Ex+md/Ptw7ZVE4ZXqJhRrN
 Bp1ST12mfrToP3Jl6Vr250u1j/Fl2YTnFHXJ8gt2XA15W4r8ZnQh+iJJgoGD6kEywdkw
 1ExIzwkSs0+8Udj+mQy9Em0PnjxBO+vN/GiRruOS+2fQP65/ZwMMMqzQkBCRG3ldi/ba
 L71pWL3vABGP/+dSu/aK62cHZu2wmvtn/Sj0GnGoDSxMHwyK2FNMZt2IgD9PmLAVFii2
 YvEOZJGyn3GSdLA+x1qGFmmiCO0ZbAuvDpZf7cpllnnwZ/PClUvoks152hCMyCqrw/Tc
 Xm7A==
X-Gm-Message-State: AOJu0YwdZkOYqk/qItww9ikgo9zGzgoKKKONFe6rdpxnfzhlMPkyDuu2
 qxAxWhQYsqL9sSSNkrQmHVyZW6JY/wu/CE6xYGhtaC834WZpEuaqoDGfOKmp4fTmVLAD+b6tjyr
 qKaQkv2dw71VDN29bfWr3KIlKTUMxt2387oozpa5Dhg==
X-Gm-Gg: ATEYQzzrtOiEGHHs+YmebO+jSjrLvAVZHrzkSeqDcLuMikYmJzclY5HkXYnRITGmkT/
 Yp5A66b9C9/QJWZWkFlMrpYbunNLTBKbgj+I4HsesYsSfLE7SgHhoIxUxm7D0Kmv992hdLXHICg
 s0W+mMEEtXj9bTv120QEiW4INuxht5rWMLHnKy+075Z7DLKhLFACHhxJmc2p7cUUXgaSavkmgVq
 4vw0IyUhR9idtI+Wz1lzBeaVq2RnMpFYBccUNoJE1rkHBs3hZQSwTDjtW/LyFnjdHL2rWiUj+ze
 XXwOaK/Zt/P+q8Dl05IAKaEwchUsK56knHnyeDLlBy50xFBWUCRA0nfPlNbUjbERPDKATDau5Km
 R5g==
X-Received: by 2002:a53:cdcb:0:b0:64a:f2dc:2863 with SMTP id
 956f58d0204a3-64c78e3f4b2mr8694716d50.47.1771955033419; Tue, 24 Feb 2026
 09:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-11-alex.bennee@linaro.org>
In-Reply-To: <20260219171810.602667-11-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:43:41 +0000
X-Gm-Features: AaiRm52TuCRfIzNNGpZsyRSrbSfYPgjiMv87KBHufhgW597nJjYYrby_ozTNI9w
Message-ID: <CAFEAcA8gvXGAhTZ+PuegZJucBHa6pYcDPxZYfUJfUjSKBme9TQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/14] target/arm: remove extraneous cpu_reset from
 realizefn
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Yanan Wang <wangyanan55@huawei.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 19 Feb 2026 at 17:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We already have do_cpu_reset called when the system is reset so there
> is no need to do it here.
>
> By removing this we now only do (smp*2)-1 calls to cpu_reset. Once per
> core as part of qemu_system_reset and then once per secondary core as
> PSCI calls are made to reset them.
>
> Message-ID: <20260108143423.1378674-12-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 10f8280eef2..dadc48e06e5 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2198,7 +2198,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>      }
>
>      qemu_init_vcpu(cs);
> -    cpu_reset(cs);
>
>      acc->parent_realize(dev, errp);
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

though it would not surprise me if there was some obscure ordering
requirement that we run into by removing this. I guess we'll have
to wait for the bug reports :-)

thanks
-- PMM

