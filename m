Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1F6C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymPR-00050J-Gk; Tue, 25 Aug 2026 04:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wymPQ-0004zX-0u
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:21:28 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wymPO-0002r1-At
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:21:27 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66c744a00edso2884340d50.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 01:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787646084; cv=none;
 d=google.com; s=arc-20260327;
 b=fnhxwlehy2Pw2kQSrKOSrwU4mfdILsNYPy1g8Sr4h7GhnyD+4wsRNdknGl0Bzy1IEI
 aHTiOY2PR2h18oYvyBmg+WB+39PJDTCGERwN2dduuSD5yrbO4V4/rckspdrrg6AI32Y8
 2AZpgysfc3LMDGKzWrZCzf4zbA25h+RKr/K+Smuf1xtosrXvh7V++TrvBxjDrgWlhMB+
 rlAmqGKo7XEHJkYfX1cFnEa6Zv6vZtgq0ka6BAPr9wJwkRxpcYbAx/i2Mwlx62fc/Ylv
 9MzJAxQ6VZGC/OkHxqTw2boEcA/YPDNV7Xp8/rbrm+6bBi6g0HDYXcUsWLbl0LIcpnrC
 +qGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pEPSFomxKufCzvz5ItOHQfmLHMt5HP2csNzXudy/Br8=;
 fh=34llzRT7kx9T015apr7GyzJplUSuz1zuzcv0Gf9zzyE=;
 b=OmfJbN/gnRYNRYlAfJe5CjXpaOY1T+NafI8By1c84OvHKZnDyNkCoSgT6fiM+vFNTx
 N/h9naZBI0wfnxme67le/GOM6Fw6kjnFa+GaIuroG1KDdXvFkzBBFM1fP3P4oE4bx9mb
 MtZmbislldJJysx8QnfzqsMeu/aLgVwsLbovILU7UN/QOdJ9jj57GdVvZMVaE1Sq2ugR
 s5FPMrKJf7W/IA3kk5UiuOnO0Ch7hvFArQSH9SFJ4P5O5BR4HAw4pJ7Zyhz64wavsZp2
 E0Uwfww5VM4Se3ql+CtQU3osCNsqp5H6sXZgSSU5b+fZZ113GyWszT349QTnuRPJq6Wo
 aYvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787646084; x=1788250884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pEPSFomxKufCzvz5ItOHQfmLHMt5HP2csNzXudy/Br8=;
 b=acbF7cNsCvRXK3b/vPmedc48xTrCSo+Ip4Uliy8IBE+ra7qZ+wFj7BCmND7ZmKPgTa
 AZsJBPfdr314W9qq2QortBYTTQK4Pl2ptFpElbxGBVu4dykY/oqzSX5NJguoJ8aEQu6T
 uLF+ycKTm5YJaLLiO9Z3lSvfBPZsuzWIG0q1SMA860+GLqZfaTR15nLbkyaIWJfaoPFF
 SzZmVZ7bGiTRbHeGNb+9/++zhNf3Bna1SUVFFzm6r2u0aYDCmAuXHXZ5n4GG876310ug
 xiULEEwKw8f1IQczhBatDKUnCUTkiYFjhRYly8dHYtBKwZx4AcFKv7tvEe8eUk2c7tk7
 7v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787646084; x=1788250884;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pEPSFomxKufCzvz5ItOHQfmLHMt5HP2csNzXudy/Br8=;
 b=spvAGj8saBKI//g5YRLasWTLiMAV9hIE9x2zVOrN28eEYaYzQJvHX5ovXU1an8rpmp
 /aDBMdTaqQTrzpdFBejlMXLYk9pRSRB8qAIO+TX5IyiQjjx5FjjDa+mFnoC6JZGVTS1H
 XNxc/jf3MTCEL7cDHnRaWnU4KFNVl2yTuXIFmz7rjyuiaQ7jHitSivpubCIFK3wAbl4r
 5lhDo2sWivjt9WVd0ms6pXh3zxICVtwC+X/XYSYMWSErxYa8VfSUwKJjIMU7iPHkSiTS
 6tnBV9hrjGX6Vu9cwUBWsPIEiAfYXSa4ByX29zGOK/HK9b/n2jHe3Q+mml9rvuShK9Pr
 c3sA==
X-Gm-Message-State: AFuF++nJ0arhS/fLbjYL7ou20d3xPvk4EHS5sNywptVTbe+VDH2S78O6
 HQ8nhWiEA7Bi/o0rkcaszdfRXA91bFuPQvGOo6yuBXnlAOT+M6gro3PctCA3ElBmPPknX54Nv68
 bWfTUy7Zv0xR2qJTHHZxk+VZziS+nit4=
X-Gm-Gg: AR+sD10ZtsdNV87+dJ5LQchfGb+GA5lDQFCKAfPYXgd6PlOm4Z0Ve0ojk7rPv4Neeow
 Ho05weg5lQ00ePmCD1vGkCZvDLoMOfu3SB/MQsbTThbAUSSYTKwd2PzCvn+Hf+HGTuNdzagcDXe
 H6rHiX9UN0J17qDtGEwwxV7UJ5AHf+SB+kXgwE0brH3ZS8JlAnZd+56sZ9BvwFhMDAnAoDmzb/1
 iaizmFCkhlTS+BdfpZvywSCjrTKP6CfAn3ppM02mrU+B//bRn8acpaH/KcsXcqi7n+gwdXSz00m
 SFMVFrjCp4FmJBefwVFOpmR/36fvDaWL8+yJ2bbv2VzQsA==
X-Received: by 2002:a53:a484:0:b0:66c:5045:d9aa with SMTP id
 956f58d0204a3-66d14abf74dmr1432354d50.29.1787646084428; Tue, 25 Aug 2026
 01:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
 <20260820024834.3286721-2-kylefoxaustin.github@gmail.com>
 <CAEUhbmXjTHjw3v90p9eg4Pv587kQxuiEcMwkwT1XT-ZedWhbMA@mail.gmail.com>
 <CANqqvPcoZjxDBXEWW0Ns82YXpzxDnE_1pauY-mvjyzd3pf14Qg@mail.gmail.com>
In-Reply-To: <CANqqvPcoZjxDBXEWW0Ns82YXpzxDnE_1pauY-mvjyzd3pf14Qg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 25 Aug 2026 16:21:12 +0800
X-Gm-Features: AcwNN1X47ZQlsQBkaAb_uF2VHo7zzOWCOWHRh0t3Qb6VfmXq6ABPQNQOQimazKU
Message-ID: <CAEUhbmWn-fnwhJBuYg+vRvMf=QNW3zT0Fb+-Mh+SjO0v9cYSHw@mail.gmail.com>
Subject: Re: [PATCH 01/16] hw/sd/sdhci: add i.MX uSDHC SDCLK_AUTO_GATE and
 NO_SDMA_BOUNDARY quirks
To: kylefoxaustin <kylefoxaustin.github@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb131.google.com
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

Hi Kyle,

On Fri, Aug 21, 2026 at 2:27=E2=80=AFAM kylefoxaustin
<kylefoxaustin.github@gmail.com> wrote:
>
> Hi Bin,
> Thanks for the pointer -- I had not seen series 518052, and it clearly su=
persedes my patch 01. Your 06 (honor uSDHC vendor clock gates) and 08 (skip=
 SDMA boundary stops) cover the same two problems more completely than mine=
, with the RM citations and a functional boot test behind them, and 05's mo=
ve to a sequential QEMU-local quirk namespace is the right call over the to=
p-of-word bits I picked.
>
> The part that makes this easy on my end: you set NO_SDMA_BOUNDARY (and CL=
OCKS_IN_VENDOR) directly in imx_usdhc_init(), and the i.MX 95 machine reuse=
s TYPE_IMX_USDHC -- so once your series lands, my uSDHC instances inherit b=
oth behaviors with no machine-side code at all.
>
> I'll drop my patch 01 entirely and remove the quirk-set line from the SoC=
 patch in my v2; the i.MX 95 series then just depends on your sdhci work.
>
> On sequencing, I'm happy either way and will follow your preference: I ca=
n hold my v2 until 518052 merges and rebase cleanly on top, or post v2 now =
marked as based-on your series so the dependency is explicit for reviewers.
>
>  Whichever is less noise for you.
> Thanks again for catching the overlap.
>

You can send v2 with a based-on reference to my sereis. Thanks!

Regards,
Bin

