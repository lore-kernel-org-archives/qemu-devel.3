Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED684CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGWYD-0002YS-3s; Tue, 13 Oct 2026 03:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xGWXu-0002Y2-SB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:03:34 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xGWXt-0006M7-89
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 03:03:34 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-885cf67963eso19021587b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 00:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791875011; cv=none;
 d=google.com; s=arc-20260327;
 b=X9bp14SAHFlVoVdMwQrSeRXROi+rf5MvmBcR+jEea3nrv/JJYJe7ofbNBDduZi9lX3
 It4Op9KjZ/Brvv6GAkms3Ixdrv+aNY6jQT2249i6AeOuTWVJUqAFbUVaSNO7DzQQ+K5o
 s4m41UmQpExf+T17qRIUF9MXXw4Th7weX19PuWUrxXkpMVu0+eGEzqiZ+Hi6UBYPkzka
 GUmWxwgi2sigOrG4pxyR38BayZ75GeJBf9vs41iTq0/FGAWTss99WGfQBRNPqVPfv1TG
 va+gX8xvkWn30mq5LPrZlZVtRZK/SeBFlWLvtv20b+MMwKyZKwmh6YxKWXtwy37CYdp0
 i6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GNSlNRRkQ5Nlg0w7H8dAOtfaTCclFtQeHENZr3xuAU0=;
 fh=+fgCq3kvB7YxezhfavlPQTuMgPjCaNHeAfq5hiOYvPY=;
 b=n76Y18Yx78jhYacvrDKu+ejSUVhzX/UWBVXvJX/UHCOJF/zfE4JGHypPoE45Ponxy6
 mD+37DBdpxa0w0IgJzfeNWF4LGzDmWuZVLFhMYG4FHPDw7nrAmCel3WBu0Osjl83uLUu
 dtvRAqUs0C2zNUyc8kkBi4WkMtAptQQ35ihqQMwpDWqsaCt//2OhNZ9NoIPB4d/ok/eh
 fnW9c8fPiCNueSH+cbU1vmYPr5vfUpeLf/Mte3OuEeKi7mw/nQ4HXrCotM2yps2LAjCt
 JmYXHutCiN8L08K1IR3A0yWNfY78hPadBHVx/ao16TI4lAwXQCDS37xD84ojpehRWlH+
 rf1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791875011; x=1792479811; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GNSlNRRkQ5Nlg0w7H8dAOtfaTCclFtQeHENZr3xuAU0=;
 b=IINQYFI1pqHtaQdxvgh04iFIrrse8Q3r05Au4QwM6EftQnBF9g9ASsoPuDLJP/7J0y
 NAzsWQCsID09kyK70jLpCsthDSgNxnb2PxuM5Odz/HR4kjh5hrK+eUjBZ/0N7zqz01qG
 G7/W1K/wkZHC7pPA3UG3rN2qe80NH1V6dIkc9VH3/B9on1OzzIyh+Fdi13L54tBZ/CAL
 P5Ty2uI+qbdu9bTUPi+B5ZEXSa4E1UjwamN0400uXbfqBcJaIf6LmnB4ftmqn+IEH3Eo
 z+u3dG7QwK4C/EdRtsWRfWPpvK9zMIRy275H5ixxoVTFOVIrVA2EVWdzYw9B7pQvUNcx
 rk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791875011; x=1792479811;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GNSlNRRkQ5Nlg0w7H8dAOtfaTCclFtQeHENZr3xuAU0=;
 b=NyqmHqxi/RtBHI4XfmOID1fOpT1g/AKl4Aga7S6ruHWxYZgiHlByH/fr4ClxwnRjWm
 gIJgT8XzoAGHPDTl8Uk7p2Q7n5b2epypE2DTB6gLjP84QZpuD7mQS0NCIO1988K9v7CK
 Ip5wmf+FgmDMwfUKLIXjj7mBNYB7HoZ9vHBSJznIMI/XKGflx8EPheA5QsW0ZkFTUSaW
 OaCO9LFIPZJNWZQb/1IpX8mffy9wYR7VseWYtDcQy7DlixtNqH9u5oBvSjfTShVt+SIp
 QtWqIaG8dYAYFCUMsWGVIOSIRtop1zF3i8gCIsTR52QLryjFsNcy7ThZOBDltle8z6H0
 akTQ==
X-Gm-Message-State: AFq9FYLx1FSatUanL+N9Y0UiU4nRYCce3m9p84ia6V+c2y4We2HNbGEp
 zNtFrzS+3Jc97hu90Rvoa8haGmTCN2c5gARhfr8QB9R7Eclmyrs4MI6f6eGobgqAz7duaPWW/Dj
 IfzSJEAkb2vlBn9BmQghrDpH4eGTGjUk=
X-Gm-Gg: AYBFou1jWqhNy+ZQc2becCd8Sf16GSckpZi5mtByB/RgH2qHGUsX6D7Tc5Ste2YLNoc
 0D+LYcWruvJ0snpcdMhogBGR4DrALebWgtK0XqwVYz4Xkurw5VlHPxZYh7PnsmTmwiHoFM/klHC
 cDC/KGnC1gmWwRXuF18sqMiSNjL0Ur+WyBLkfvzHFXUMCPOUdE6tV7J6W1PX4XEniNdiAEOS/Yd
 3OJ53f8HhQDc/9SYTkThi58Ew708FsSMPD1vEd9imbqPEpL+VBRWH2/ICKsoAbJkZxTQKamPzNs
 7+AGS56VSlBL/pxGRoGmv9CJxFmor8vOl4gNORWNMzCIpckAyfIFtckCGku2rhLR998gtx/LMRM
 ioCdZFh6pp0Zs5AI=
X-Received: by 2002:a05:690c:9988:b0:8b0:9f2c:cfa0 with SMTP id
 00721157ae682-8b09f2cd2c0mr22491647b3.44.1791875011595; Tue, 13 Oct 2026
 00:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261006094921.110871-1-bin.meng@processmission.com>
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 13 Oct 2026 15:03:16 +0800
X-Gm-Features: AclHuK9K7SXgZn0MnZUuZDTJvvl4U2gdeYMeqyEpbAiU40vl2E6Ra_64fGEoLdI
Message-ID: <CAEUhbmXs02wsAnEQKfAG1LXPSnWhcH4YvZtNhLA6z1K1gshLHQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] target/ppc: Correct Freescale Book E CPU models
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Oct 7, 2026 at 4:31=E2=80=AFPM Bin Meng <bin.meng@processmission.co=
m> wrote:
>
> This series corrects SPR access, cache configuration and instruction
> availability in the Freescale Book E CPU models. It also adds system
> TCG tests for e500mc, e5500 and e6500.
>
> The patches are grouped as follows:
>
> - patch #1-#4, bug fixes to PIR write access, the MAS5 SPR number and
>   cache block/line sizes (qemu-stable cc'ed)
> - patch #5-#6, complete e500mc/e5500 L1 cache configuration and
>   remove redundant e6500 cache geometry bits
> - patch #7-#11, register the missing cache, MMU-assist and sevearl
>   control SPRs
> - patch #12-#14, split the PowerISA 2.05 instructions to several sub-flag=
s
>   controlled groups, due to differences seen on the e500 series cores
> - patch #15-#17: Add TCG tests for illegal-instruction exceptions, byte
>   comparison and parity results, and FPSCR field-mask handling
>

Ping for review?

