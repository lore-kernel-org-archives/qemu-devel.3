Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33551C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 01:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdei4-0001Yt-PD; Sat, 27 Jun 2026 21:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wdei2-0001YK-5P
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 21:53:22 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wdei0-00048t-Lt
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 21:53:21 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-664ce3000e6so131461d50.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 18:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782611599; cv=none;
 d=google.com; s=arc-20260327;
 b=mVcGR2itJzv6i+i2zdzrSxYOTB9Fw8Ztod8AC2ejV7hn1IeNPeAS0TK4wPdE2Z5c/n
 THzr7D6hu7Kvvh4Fj88qBN5RaWsnoyzggos8WkDzCgrSp5HC24G/ktzsf2J3tVEx5oE9
 pPRWGSvG+CpJK1G6dXdTgfg98fWlMoF0SWOKCfuZesYL4zWxt/mVo4mpGTwsjTvSQk4x
 2LM9kfw+tG4OhfWK1+7lITMpul2JBqp8avveUtIB+DvGbsDNjQC8x72btodiki0BO/fP
 TD8Sd1USwObfJGboj5bJNO6SMz14laFSioyjnoarfxWqcIpAh3WfKIm2cOWNVu2mQ/3R
 yniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oa3EY445Xm3vq1WBLUQ1mJJXFbKUlHgKxrRyZUE2BaQ=;
 fh=f+RMEvWAVQU6OpFxtAqzJ+qKCv5Dm/Od3C2+aQNC4ls=;
 b=DneoEbW+atRtYO6RJ/hp2zIIiJu8gmyl9rrlAbSdqetkLKFOfKQ8gV9DwHVrjVQMPs
 6DvpwhZ8imtn1tAKLs234U4oy0/0fOLPeizGZR670VLGntt4qp8VeojJS0J3TrJsItbx
 jFbOhjiZBQRa9vYFXPvO1P+kROsE/nNK7Ntjdyws7ujx47CVJJQvVSEdl+5x/v91I+E5
 DOrESmP2/8N45PORXQStJclPah30yKg0nG7pPnfRj+C9fYs4GQu/wxh/gLHOvEh/pNnb
 hldGZL5U3MJP1bo0LBW18V1QjYT3MeY2ylFVYGfNZCP/3XBzLpO7LsxiISbiMjoWE8Vb
 WGEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782611599; x=1783216399; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oa3EY445Xm3vq1WBLUQ1mJJXFbKUlHgKxrRyZUE2BaQ=;
 b=g9moiV1xIhVNJNF72zY+34kVvKI8i7YmI7lDDEI6X8uo2I17RhhrbBFV7tlyCOzpbK
 4BKT5p2QdEGNCtnDkgDQGrK6dv8XtUKcrjZz+oQLmDF/J4poT72JjyX61bE94h6MnNkJ
 r8YkiNRNJPeo0LlpkE9J11F7g9HrNVCE7gZVYu7t0DmS6xYlYrad0ZlY1pLT5sZR4fqd
 HUViIvc8yGBbPXKpxnzee2W1uSlEr+gtHfhTH18ghzBWrk7uel7LU/1boai4NjMbAMiL
 LcE3Ysvl9N5GbC0LGZpTVqAKjWvVvjRpNZOUehBkTA0onbUq5P0HFLDtvmdtWVGNx/QT
 DCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782611599; x=1783216399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oa3EY445Xm3vq1WBLUQ1mJJXFbKUlHgKxrRyZUE2BaQ=;
 b=gYjDmwHxKg25p+DFptnln8HGKMcl89iBWbs+ltt8Fq0CAS2fTVQd1mxjDQ+VIHK25A
 oOClLYKA/9zzC6n1KgJ//X4MpeeYT5FR/RJisrufYL6cu44olIXiqtazoqlozPKrOGe+
 g/zOlYVYYD5jytJga8/Ds/sSslRHanzHb4aEBXteE+t3u50NizENucgWBj1Pp1KIv+rA
 U4Y9hnij9lhE2/NVljI/Zec9xMInt546/FhdxTiJ1YV72d+avwAOXg2G9YBhiAbiBlTL
 HPjACdrSrUyDCzvo+GzvB/tOJXyFtcCS2357QGCrzZKJlGP1Po4pB+4WDgEewLTvSGI2
 i7cA==
X-Gm-Message-State: AOJu0Yyjgv6wrekansuuL9bb7frLBpvZXLK3Y5RgMqN8O9TlJCJjadu8
 WcDjNvWiMXQqTwgrVijEdzCR2Z/ffG10108d7XJEFP18mVlUeTr1fiQ/bmV7GdspUvMV+GF4puI
 bYEHEhavCfWx//9VtuL86rtWRfLzY7/EKSr26bcGkPxfGnVY=
X-Gm-Gg: AfdE7cl7OQ8uhkkLVnZj0rLKf5iM93R2Tpn6rXjPgUl0rCOl7V+orNCEiWq5CB2HfIb
 uduZvJal35o1cBZuqiI56EQe/D3vCD81SQCaCKsVycq4gvhm7uMi5TJvu/tLI4fBAFX0UZtM0FI
 WqBCySw3Gf3D99NqGChEDGjCbPmUWtO1y2+yU60RV1fhQ7sglLkG4+2wqrMzD6bGgc7FMAOjcno
 Z0sNkKwKvqmTQmdIZwF568KMbGHrdwwfwg5Tc81sMYRjXQpgKgddVeiblnaBiZaVdYE38y99URm
 yw6vlAfKvg==
X-Received: by 2002:a05:690e:419b:b0:660:eff5:e8e3 with SMTP id
 956f58d0204a3-66487f419camr10401712d50.2.1782611598076; Sat, 27 Jun 2026
 18:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260627055848.28279-1-bin.meng@processmission.com>
In-Reply-To: <20260627055848.28279-1-bin.meng@processmission.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 28 Jun 2026 09:53:06 +0800
X-Gm-Features: AVVi8Cd6KHeCx2COg5v5AYAlEBqCqyNTdt8HlRudpD7ymvk3KME45mdGtlgxK8g
Message-ID: <CAEUhbmUPpS6VBiCncdKDgr2T+22L2u8Ldz8zVtzDRTBQODeeVw@mail.gmail.com>
Subject: Re: [PATCH] docs(arm): Update Nuvoton OpenBMC image guidance
To: qemu-devel@nongnu.org
Cc: Hao Wu <wuhaotsh@google.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb133.google.com
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

On Sat, Jun 27, 2026 at 1:58=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>
> Describe the current OpenBMC target naming and release status for
> Nuvoton machines. The latest 2.18.0 release no longer includes GSJ,
> so point users at older 2.14.0 sources and explain how to find
> Jenkins MTD artifacts.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> ---
>
>  docs/system/arm/nuvoton.rst | 54 +++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 5 deletions(-)
>

Superceded by https://lore.kernel.org/qemu-devel/20260627063208.33642-1-bin=
.meng@processmission.com/T/#u

