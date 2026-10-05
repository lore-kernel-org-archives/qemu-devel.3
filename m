Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB28CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkFj-0007Fn-9C; Mon, 05 Oct 2026 11:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkFh-00078Q-6K
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:05:17 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkFe-0005gR-SK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:05:16 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 956f58d0204a3-67561cbafd0so1524321d50.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212713; cv=none;
 d=google.com; s=arc-20260327;
 b=gLkAKX6tUxM71ofDEwTw7QKcATOJVE7GOG1Oln3IajqzFniGRqt/zFV9qw81Kd7Bma
 1uDINsyBDYgpoAr8R1oQhvOMEW2cEx+1MEjFpdN9GajZQkd0u7yMIZz8exZk7vyeZNEC
 8v5G2WhNvQxNF1O2dgp4bu8rvR6Yj3Pv2XtZWi5nsOG575iTJKe5wRhFh3WHVwrMI477
 AV5FeE/DC2JYkNLDUE1ziwXT8GCntV/gPZMYovw+y8LgiD3iGxzRJHuTDBYjQdZTQo7/
 /t6Rk7iTzZguuaB0aBxlmcnzcEAEK7eQwB8rdhJez5cAfYkinqKp6bi5UD0cdZvHHnkp
 4pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8ro3ouLpcMepwU7npi+EYrB9mABhvxcqlWiph0s+VYU=;
 fh=EjplmlcXR8MWJXDdpR5ncThIs/e4S293bvxZuvqDLMM=;
 b=lZzVACd3DoV0Mo/eZ22HQ4Rd1TreSUmMKneRL/tFe4HwfuIJIpBKbdLzCrV6UWpGL+
 B/Ipj6O3e2wO0dxzDyN3GA8Rzn9HuzwKit513zyY1+n7qPF+ztXEmmuhL+Oje0Wnk9Rc
 me7KuWBmHq7gEmS6gQhnc+tsgJoiCL/3QTAx/26C97uzc8Uz9DxFIc5f4qneUsiiplAb
 B69QIExpi7cYJAL5voDn0JkwOR/w1RWlSQJ10jkdlX1g7bbvBGT+4FbZ8E5ZhKp9jd1t
 DjAtBNN107pcCaeDu8Z8yOeNJRAs22biBAIl0YmyADZqhgU2VyJrECkBmf/k80/D5Bsw
 iOtA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791212713; x=1791817513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8ro3ouLpcMepwU7npi+EYrB9mABhvxcqlWiph0s+VYU=;
 b=sg7f7h2+w5Q2sujV6xBFJjMtJcHALuW/j8m9PSEssi9b3k25dR+kjIvuaIpm/XDVY3
 ZGbW7SPD5d46n2bHg+to6EFdpizldoo2uCQcb5k0HGkds8ReQ65GfCgCd2cnDtC2zVAP
 dVAiXsSPysQnwTdbZMiX8s4jmK12vT0Wk8ITmD1dwqjdKm+UEoLZ4AWIIMZrbkgEP1nB
 plKvEoHzqtwio3jVt4BMloaMQWqrlsHF7xMV+r4X94uzSk+vp4iyUt/y9AXv+RwWBRih
 W5WErGT1Ed1odGEPjGEbj8V5SKurmQjIl/l1ZbhDsHBy20eLDs8MH3tD7UalS82UvCOI
 aC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791212713; x=1791817513;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ro3ouLpcMepwU7npi+EYrB9mABhvxcqlWiph0s+VYU=;
 b=XkPbBF3DuHn1ehIWwtQa3233EQpXVZmgdrZN3DbQ9ZJvuZgqZGMYYhuO01YXxZiOPX
 aP8jqqGH7RalcIjqXAuNMJ/iDDix4i/U+QS0gYkCz5RJ3jHawFJ1w8bkwI3dGYD4G02W
 rXx5hCunDaPXRlJfAe7Hs//kyvBCyT2GlsTvxmP9rhXdgJFKjSVVqaXDkosTs/Te1WQ0
 zBEuAtFuGX/clTX/ymmPA94zVHhA/595mAv80Z0xAoLov63sdBOek/o/tTGwbhsRACIt
 Yq1V5DLmmEWwveKpOFeVILzeQA4mtCZZ8ga29JoDsnvPmb0n2NPWqPQOu50UVJhgDS5r
 /sGg==
X-Gm-Message-State: AFq9FYLdvyPDHjYsEO6KPA/AOI18et/mk+IdOd7GBLgWk9Et4dBIRR9t
 7Ub8/jjNMBl6M3j4DaEBmLbpb0T0VfTI+0tuFXXBt6TJvpsCsX9LUfSuVpQqW6sZmvFP1STxsYF
 pRUFtkMTkaiPn1i36RtVcSatws62x40Mj8I8Ea54=
X-Gm-Gg: AYBFou0PJZRkEJF9EIaKzSg8uQSS+WXug+FS+Nny6wKjWIePxjsSnW5yaLGgRMnET4Z
 IdGUMOEmO40vJCizo70d2k42C5yuiqcr1hfU+ZoRuVev1qT5zZq17DSVsANjLL+F9dfpPF6uQ2S
 1g6wrrd4uDzTU+uzyxxY43xAtRTbH7grHkxhBYGRsy5Th9Zd1rWEp45N8hElDe/JhW1160Uylge
 d3FWW7xt3BZupij+B7widL5+ryXyG1Paoy98lvFlPvdJH1kgJq4wD7TkZ8sGla5omJWyXaWTkkh
 LXBfCdzER2bR20JYQO10Zg6DPF2154NzjtnpkxJNkxBb/fJCXPoigKpC5X4zMFuiNWUytuE1qVK
 wHqLvIhTlrQlHaVE=
X-Received: by 2002:a05:690c:c3c1:b0:891:faab:ff1e with SMTP id
 00721157ae682-8ae3690ccf9mr36088087b3.4.1791212713531; Mon, 05 Oct 2026
 08:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-9-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-9-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 23:05:01 +0800
X-Gm-Features: AclHuK-yqs1FD5anwNhAanO0PQX9KeMjF3ZhrgqC-Wk-swzSZ_3G_5Fw2s9kigQ
Message-ID: <CAEUhbmXu2fhLKD_-LUp-xdQ85LB_A80mW7nNGPNNGARem1seAw@mail.gmail.com>
Subject: Re: [PATCH v3 08/31] tests/functional/arm: Add console test for
 `sabrelite` machine
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x2a.google.com
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

On Mon, Oct 5, 2026 at 6:23=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> The test currently exercises the Linux kernel and waits for the first
> daemons to be started. At this point, basic hardware is initialized and
> if the log message is reached, no driver ended up in an endless loop,
> thus the system should be usable.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  MAINTAINERS                            |  1 +
>  tests/functional/arm/meson.build       |  2 ++
>  tests/functional/arm/test_sabrelite.py | 46 ++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
>  create mode 100755 tests/functional/arm/test_sabrelite.py
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

