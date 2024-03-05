Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3111BC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXAW-0005Ix-Sj; Tue, 05 Mar 2024 10:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhXAR-0005Ib-U7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:57:23 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhXAP-0000Ov-Os
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:57:23 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d3ee1c9ea9so13056041fa.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709654240; x=1710259040; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vOurYOO2KrUO1ZqLCskHuMsZvwtTlPIoZKO3KPvPGZc=;
 b=cP99PVxZquRgnOUtDjSkDQED4E0i6Dh/QIsgf7Xf/BSJeRyBEEglT7yoq+bCIgHeEe
 wOz9U/Qro7lU0Hbr00RlgR2ykIOLc771/d9SJosq3YqzRFmAu+nHKEIZ0+M7YUNlIeZC
 Dw7yMWi88gRdlPlYytAZl+Wfde58hVKF8V7kPlRnGXiRxaI/85J7MK2/onekWl4h03h7
 zqDVuTLOdX2f/0LjzDbeEGjQdqSSgzwyZHjnJC8e5KBRShB1Y4MzBHPVROcUn8fxQYSL
 j0QSSzunPVB8eGbJN7bZGF28rhZKoqiXRgQ0933UXzYYpkP2Hm+KgCqV2cSF57NAAYNq
 QMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709654240; x=1710259040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOurYOO2KrUO1ZqLCskHuMsZvwtTlPIoZKO3KPvPGZc=;
 b=wcu8mJYvr6SPT2wJjAximxI0HACa7wWkpIjRF9s5yjbYZuCElA+Kf17sbZ/2kIvtE3
 jffemu7q4vH4klnziG0eWjD/yVyWKTcxFV77sgt/VV5hxckCuy08VMDlg6mFHppBTL59
 4W0XAyq4/9MXqUd90NhWa+zxRaLgYkFi2Eka4u/zmbEFGYNdFCHa9N998pOnE4hi4GN6
 d6S+oCJxntBpwzInu9bzRofh0vtd6md2zdvE2xGA34uWZWtSCszx6Rwaj6fnxFt319wB
 HzhpkM/k7ui2jvhc5IVMbGZaub4gpLbvvBPnGOZm2qpXwQMqVZD4d8FooId1H7SH4x8T
 4bzQ==
X-Gm-Message-State: AOJu0Yy1Cmiy/FGwsNdPSFwMxBPN/cuqtEDSOyrGBHJeXD880Ddefgp7
 qqlN/RbtIc7qfgJVWx1uqP+pJHBvrRZRB4Tfty2Y2qpTPgcAoW3x/ePVEZYe8/Mu0VFLlAaRhbA
 S0wc72ZLn+FY5hF7y9/IiL20QIW/PtrxqxIttAg==
X-Google-Smtp-Source: AGHT+IHx4Nwf4RHg4K8kGw1QM3wmqBxTsaHJQKpJX8jjUVro83fVXEvVPH1DwazjolLCpRE3MOUZZVbMd2SOqZzLmHQ=
X-Received: by 2002:a2e:a4a3:0:b0:2d3:1172:c07f with SMTP id
 g3-20020a2ea4a3000000b002d31172c07fmr1471321ljm.17.1709654240031; Tue, 05 Mar
 2024 07:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20240303185332.1408-1-shentey@gmail.com>
 <20240303185332.1408-2-shentey@gmail.com>
In-Reply-To: <20240303185332.1408-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 15:57:08 +0000
Message-ID: <CAFEAcA9tzgAetYu8QcR+CgN1L_1ZcCS3mYHbD9oPe5py7Tw1iw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] hw/i386/pc: Remove "rtc_state" link again
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Paul Durrant <paul@xen.org>, David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 3 Mar 2024 at 18:55, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Commit 99e1c1137b6f "hw/i386/pc: Populate RTC attribute directly" made linking
> the "rtc_state" property unnecessary and removed it. Commit 84e945aad2d0 "vl,
> pc: turn -no-fd-bootchk into a machine property" accidently reintroduced the
> link. Remove it again since it is not needed.
>
> Fixes: 84e945aad2d0 "vl, pc: turn -no-fd-bootchk into a machine property"
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Ah, I did wonder when I was working with this code whether that
rtc_state link was really necessary.

We could now remove the rtc argument from the pc_cmos_init()
function, because we can guarantee that it's in x86ms->rtc,
which the function already has access to from its pcms argument.

thanks
-- PMM

