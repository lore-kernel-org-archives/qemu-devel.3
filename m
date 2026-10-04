Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93364CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDP0n-0000Sg-BZ; Sun, 04 Oct 2026 12:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP0k-0000Ok-K7
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:24:26 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP0i-0001vl-Ud
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:24:26 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8ab37e44643so6344567b3.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791131064; cv=none;
 d=google.com; s=arc-20260327;
 b=JhazLKqyzXmqGm/Pre9S/hVV2J7Hk6dXmX025nGDlWjc58OvGmUDMrpIuFUi3cxrsK
 JKg9f8O3lItgXyZBYt7mo+Iug1HORhlaM9VXq1TFcH6OS5RHZkwU0tVviDVkyiYEGKi8
 wLeESCIZCo+ENiVU7LayrkGHXJKH1v+/D7SeThQYBJEvBwsE/b0divU6aS9VCGyxBAhM
 9hmPlwBK7WeRr9GihPso20zWk5OnLx5QYVxz14WxG8Ri/hDaAbkPNU+GQdnPA4KiLhsc
 Uh2ap4OYe7OZOWaaa2H7SIofoi6EpX5DlMktEhJvonF500gNb7EoTSbT7NpMcSn1kLIx
 U/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uOVDhL85kyGJGKff+y9FATncWkUC3Lv1pByLBJzSctc=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=MKlJNYQymVP8pqGRYAKcdHeFLRMpHxBuyXRynP+9DT29oAYgRgj6acfoC+0wAYSpFq
 0L4+MK7ONQtlXiJoywUxilKpRCNPGJFl6H4liO+iELeM2WLxY5vcZvoPLDbPqPp/Dvrc
 Sks2AxxbLbqcprA51QDIBP/VLFDKZCifpp4xkK5OMRJ6BzbiWyFU1HQL+CzRS17BrP7i
 ABiUhG1B1xVRhV3cyTaYQiJMv9tiQ/wpi/rjWFdgg648CH8+epGqHvD/a50OZjr2cJXf
 Ygr67ygyPZkz2XU12flPtbi+w8qMNtIS5zkC6KOjtUOEEG37OVPeRJgl0pBWB0+UHE6L
 elog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131064; x=1791735864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uOVDhL85kyGJGKff+y9FATncWkUC3Lv1pByLBJzSctc=;
 b=VHatxNG4CNaocu5seIrN69vQ0tjIojIA750o7GowqgoW4NnG/pT22Ufr1WGZufOpQ2
 fpmu+15ZFBcq1IQzUQx9FTnNQ2hdfMyAUJRNu1hh6CCr8XaKxdVTkT9nsWGoKxEN9qs8
 Bl+VJZgqP5oIaGzWdeA/ZjMr+Bb1oNj5wW95XEhPyFAxCEtRhxEzCkzPpVqVe7lf2WgH
 on/XLZVgVofG5gzGdUtti2eLLy5c1ZSggMdQ0+e9Se4dJESq2elhOpIKop8Yt8Yl10nb
 T6o/MD+gJlJxQnJ33HbvWr6bM/TNygWsv+C4l/K1DrveH4CZmsLLUn8bfJg6Sag9EcgC
 otWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131064; x=1791735864;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uOVDhL85kyGJGKff+y9FATncWkUC3Lv1pByLBJzSctc=;
 b=NO0Ze7/WOBPi1Y9S4uDAie+a/Ip4mVeUzfeQeKZmq4BuBqQ9aJVSSZo11vh5QWFRtk
 p4zbCAUODKeQBUM2kbIO8Zc8w5uOd/lRIlRS31IDHfYC5j2FYAILSu8zm7oWM0nlCYgX
 zDFqbIqT5Vd9XLeFEkta5JbDcgY22o4sGdFJtUIKpgZV3oQomj/DLjsY2etHPpHmRSNV
 ikuJbhL5ut0YfOQ+cshIyGvIYBZmYmxZ8T5A0Ym5wllMmbwSEr+keUJO2aDSgHwVQfMB
 2URbvRUDMiu4yG1bE38sf1KV2k+PtPdTMTFLFf2S/LX0gExOfANkjRZUgtcTjL5bJlN6
 2aMg==
X-Gm-Message-State: AFq9FYLA92R3R8Oh5/XJ68mbap3xPT12LpTHeJp1vIJIrkWDZNh9zVJP
 RZQcXApV063hAawbvs4xUqJRm+d2bOr28Ua42adNdKChxvjEowzbTbkiM26Zk//hQxwtnoK4m7c
 2N9PG1yWadJ166aKGuYkKS4FaEdr76PQ=
X-Gm-Gg: AYBFou34g37qYeGXaQ/wgaoLbm8f/sfXMLZSgYb/8ebYXs4i3Z0owJ3/bS4Q44wpuZk
 G8hY+v8e/+HOtm0/BiCdEBPLHhvjOg25IdAbrMoHnJ0eYMNmUePtuokBG47fxIdfvOIAAXbTlja
 NR/6l3W5jWe3eBrI2Ub9aUXiQwqzp+SI8v9kK3lsW3+dxDSq+pcGGxRaS0xGilVFxDgxqyKrkhG
 W6/oJ1Qd1zQ9+QntrKUUXhDRCZsid8t0SS94ZXflZWRSK9g/CZVrsqLKeddhJKB5IGgZXkcgoRe
 fKI0nv09rV7ACqPmWOjUXGE2m2xDJoxunudD/cWGnr+QrEMx4hvuCDsK/G6QX4T0v5vKX7D7tqy
 MO01aoibHEJHRY4I=
X-Received: by 2002:a05:690c:39a:b0:89a:63da:faa1 with SMTP id
 00721157ae682-8ae95b38df2mr18880947b3.92.1791131063901; Sun, 04 Oct 2026
 09:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-27-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-27-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:24:12 +0800
X-Gm-Features: AclHuK-l4UZbwFjPn4SSfsmg3UdRvYIPSrjZHKRJklgoiQtrgBR2mAsrIUIlPcw
Message-ID: <CAEUhbmXb5eOzmrVho4SNjMdA75s0VepBL7_eNEPYRMZeFG_PZg@mail.gmail.com>
Subject: Re: [PATCH v2 26/30] Kconfig: Extract config GPIO_IMX from config IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112a.google.com
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

On Sun, Oct 4, 2026 at 8:36=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config GPIO_IMX to eventually eliminate config IMX.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig      | 7 +++++++
>  hw/gpio/Kconfig     | 3 +++
>  hw/gpio/meson.build | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

