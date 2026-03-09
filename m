Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEC7F3C24F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaXh-0002Ba-HF; Mon, 09 Mar 2026 09:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaXg-0002BC-DC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:21:04 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzaXe-00025A-Np
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:21:04 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64c9f7576d4so8579313d50.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 06:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773062462; cv=none;
 d=google.com; s=arc-20240605;
 b=MkexSxbfQcpWmR3jO3ymPTsGtG3i8jWEaqDKI6+zYLo2f+FJZyVK75jPcgZDqgm3pX
 wup7ap+OBuTCTT5ujaHtrcn6GyiULT94I/cbia2Zd7QF/l7Oc7y6MqGIP8HVekLnic1a
 5Uu7PbCJW3VTeDHb4AVlKuQTq2GMeXodntuzttZAQNXOlGwzdqIk4GAOoz2u58/M+hCg
 LpHxmyjx8FayfnoiXh0gg+4oB5Yqcw9mAfOLkYZ1UA34fULh/JZdtXM8kbTuZBUEsNHO
 9uyWryQz4wbpvaUSJ3WcM1y2S/aj3Ubv6XWHZWRuQbfW3DemiSiBpnw+ds3a402+JJE7
 Wagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W2SJ5g1esPpiuxXYMFcA2YYU3D6Qrf7nK/bC9724DZU=;
 fh=uE2Jpq45LWWwPoKgXBdl3FXmpsIufb+Ea/ralj+9VsE=;
 b=Luw8Zs3KtHdcBI5bJ23Hu6wt+WyJyOA08I24421j1aOFzuQDHeIOT42CM8M2qyYtz8
 3MlP0Eya1epYI3tKmSnzIz3mCMAwa9qmMs/+/mCp9MFK2UiFnoyq/hWP6gmYMOR8bM8t
 jP/oXPfHZmMms2yCWWsahAHCr2q1ywki73mr80nlnjyT3tkFb8ZygC86+QHboGzx0SDE
 K+H0pNClE0XNLCHefNbB0XRifJZuL5aaX4hicLL3JF/616ndSQKzywzGaF4A5ZdGJbSM
 kvdX5mc1X5FOPF/pUjIusup8WukCB7vjN0UXUY/ovastDqT+vKdkwZLM9nYZ7mQm3GfM
 gGYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773062462; x=1773667262; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W2SJ5g1esPpiuxXYMFcA2YYU3D6Qrf7nK/bC9724DZU=;
 b=F1rqFRdBfbzGLcygHUaAWY88GAE/xjK1+sZyD6q7CZHpezE3zPKsS/Kec2dw2nkDMx
 lGoUBOqaiB0eHJ67JkVEU8bxQ3Qb/+VvizloO9cXx1ymAOnOaZu4tsrWvAowcpe1xIsK
 o1KbkfiPWajHaXNAmj4zFamf2uBK1lOVskJMVYKrc3sgi+tldNQAdLLTh96PhTCBavEU
 CFKaMKtwpP/Mc6vMwm2afPr6eJhbrF/6Y3/iGCP6R5WaeWI6NRxPC6q1s4TaW0AbnpWU
 nic0XKg4iU4uP8umQcl/gGKVBLmxM6jN87ut0FNrbbuNksF1sGjae67lhmh1L1sAIC8A
 MPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773062462; x=1773667262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2SJ5g1esPpiuxXYMFcA2YYU3D6Qrf7nK/bC9724DZU=;
 b=ozvYb9/3dmpJosmNA6hCu75gO/WSQD5G8Y3+jS6xMgbaSj11UNN77PETJHCXO8i+cE
 NE5ILY+RDcXvHZLSaRDV9XaGbav6aHF0HAC4tBlLxZ3A252A3ThfVbqIn7y2NZSmIYJM
 04egQ2dN3xl1quWxf+FsLx608FO/y6OUQs7CARVElGrD/fD29lnStuL7STibL2B+Ny2s
 wrArxutXD/jGxtnPGvJFBDJM+KPTXpsy2h9pMkjXMCOUGwLFFP51rt3OGyWExnVsWRZq
 oI0MSdoHibk2JjVT+IC8Io0SqQHTLSNhbDC++D8H28tBoB3fuT4WQvYJ46Mheo9CJc4R
 PUqQ==
X-Gm-Message-State: AOJu0YwNMp8lpmX+Z9hr1oxlYdhwZWbEDuH2q12WWbl6yAykpBL9KRDI
 1+YmnBHuQDBE4UcWNZXoWv6qkxyuu3jFlSkHxkam1O27FIZpHShdfv82GLvHVY94ZaYu9KMdG6D
 keuAx0fmfzsY4byOZcmvbUqtI6c3X71rqXd+0JaJh4z4rn3LJ3TGd
X-Gm-Gg: ATEYQzzR8LfCxnWaQHCB/hz8VRCWmtCeb2nT1MplJN84dadMtnpcA8RVYqJGUZaBNsl
 2Yvj0M+KbOegf9fyZXDxuxL5rADZoZNbtrdz76GBwfAXlNuU0u/iftTERNE3/SA2g/N/KdzNOVv
 M1MN3XX/3OrPVLUL/gY3t4jNlSzXGrkynntx6NLqfrBWZey0Apg6XeMjU5eAMWj/jb3/ckwkysn
 IcprYmQ+kZ10lhpNDqdn2+XhXQVXJO3vEnfRlqLXYgaZbLTP942wgwujQ3YEthyCGrTwxIWGX9x
 lvosjk5Wrv4A+i8gVfushjJDNK/Df4UDuhgdWzvCwoNNLptlZHgFfLX7vuDFEjLgNPxnvCTv+C/
 usQ==
X-Received: by 2002:a05:690e:1a9b:b0:64a:f160:2351 with SMTP id
 956f58d0204a3-64d143500f8mr7424473d50.71.1773062461600; Mon, 09 Mar 2026
 06:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 13:20:50 +0000
X-Gm-Features: AaiRm53FntFlLNVEeD568TyIkpDX-IhjEwguDOfdflqroS6dbGgUehVJJ1Qs04g
Message-ID: <CAFEAcA9TSQEVEVeQc4rPtz4HEJJbZUs9LaeVbz-y3=tB9zv4EA@mail.gmail.com>
Subject: Re: [PATCH v19 00/13] HVF: Add support for platform vGIC and nested
 virtualisation
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
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

On Sat, 7 Mar 2026 at 18:03, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
> (tag for this submission: hvf-irqchip-and-nested-v19)
>
> This series adds support for nested virtualisation when using HVF on arm64 Macs.
>
> The first two patches are from the SME enablement series and are present for the
> series to be buildable on its own.
>
> It has two parts:
> - Apple vGICv3 support and necessary infrastructure changes for it
> - Nested virtualisation support. Note that the nested virtualisation implementation
> shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as shipped).
>
> This series doesn't contain EL2 physical timer emulation, which is
> needed if not leveraging the Apple vGIC. As such, nested virt requires kernel-irqchip=on.

Hi; I think at this point this series has unfortunately missed the
softfreeze deadline for 11.0, and we should be aiming to get it in
for early in the 11.1 cycle. I will keep it on my list to apply then.

thanks
-- PMM

