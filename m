Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D310CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOwN-0004Af-Ef; Sun, 04 Oct 2026 12:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOwG-00045N-JV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:19:49 -0400
Received: from mail-yx2-x12.google.com ([2607:f8b0:4864:41::12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOwF-0001US-6q
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:19:48 -0400
Received: by mail-yx2-x12.google.com with SMTP id
 00721157ae682-8ab42612328so6017557b3.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130786; cv=none;
 d=google.com; s=arc-20260327;
 b=rBdBAXUtIapuhRDKZcPUbqXeIw9GU2lOhkoTYM/0GSEOy/P7VqTChnwd0077psbVDq
 tWd1WktUgoQpEiNq85TuCfp6LIuaU+tQxk55XdnJo9IFVixJRxIuJRiXJAlaXXvpaSTC
 POEkSwyglDNxJIwbngaAz8bTMS8q4lI8Uq4vFd4bfKbzW1/2vlGScWcQe3sa0ZLvPTKS
 9Tc4BlSoQKOevigs3veCEKUrxxJEmCseiThWvPhuZHYcYyyx9qzfaK555bSr/qkFqnd5
 9SPf+Zw8HePg8Wc/9z/Q6oOaplm9MMD70hGlmFJYClyDHg6BRuWtzIRwlVnc5YgtV3PT
 HZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6ovEvkl+LttCxZtAeQ8JUv6rn5rkz22ePRjZzfQwZ+o=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=pFjiV4PfeRmNisEUJZcWlAcNnrM1Idt9wjNKag5DukdBcgRmol/ufAVFA9R9yl54I4
 E/xFOCf95exl86NN6rOdUOhf8QHrEYVRSn6VUGvxD5wjRphQ0xPr0uO2G32GoB+MfP5h
 COqJuP9hk6g5Q9yZ4HaLd7uLio1Qzw76M9P9adkPUbeyNQfqEtQKM/19URjlmi5tL776
 UUnJC/f+PqqQimac2LuDBb4zniyPIuJ3DOLsEdQLYWh98IHtcBzZuwayRa9UW4wL/D+G
 JhIbkq/mrT+adricX5jEeAJtpLver+2cYad/JoO4lGmYIdQVdnmSnMF0QsBxnmTr9R//
 pdkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130786; x=1791735586; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6ovEvkl+LttCxZtAeQ8JUv6rn5rkz22ePRjZzfQwZ+o=;
 b=W5W3ty6jK8dS2VPTUhCgGtZgI94Je3zzIZwnpLFhurhDw6ECEH4IIEO3OEFhFPyqBk
 j5KYn+nD0jMEL7sYiuAfrnDzV+H646hQCAQiFNXDw6NVflvvD2pF+q9QfzThaJbzpEeE
 y319EquAU0eTG122kfZHQQk8TvF4XGUfBtqsiacii42uYof/MsmS0N8AIMwYqMABf7Bu
 94qmvOFcjiGC5kpxQA94MubC8jwIBQdwTER2Epm5BmSE2HJckw+9Oq4hSarac69tIZKI
 M3qTgrm9SWh2W8nbsu93a/XY4QCQA+LeIvEsY/KfiLvtnsNy59vU/9V6TerqKr0aOoAj
 e56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130786; x=1791735586;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6ovEvkl+LttCxZtAeQ8JUv6rn5rkz22ePRjZzfQwZ+o=;
 b=WoC9a4eacEG7rDQonxYneTudDK8ty6OwYfh4ndpG1xfAC+bBO+YspjmdE/VjpVpiBo
 JhKZCa025scVcI2nb0aTzU06IGkIksuS+3u5Yq4rAmm4+GfUFKVwGLQCUxCuDkLZF2cg
 ghv4a+e3UeyCR60ejDFtL2+Zo8VwIJGZJ1oDGaxRnoivi/TtbrroDJ1SHsjFSNsySWtx
 V3TjzpNQ8Ae96Vf/vz6ausxTy6B4umEFlm2sonY1VwJDPZjsM83u/+bvRFDPDcpNq1VI
 t0SAsuoYAbYUYQFWk6Bp1CDN6oAXmr1HBGfN2gq++jkRdB1yoo8nD7WXRITqx6IDPKyu
 2pPQ==
X-Gm-Message-State: AFq9FYLa0ZoZIiYj6Gmm2wmQF6w+JxMMpcM80/TsMi3Ljre3TTCPN4JR
 34fpybKT9mPtQKwwvRuwXz3thIOM/puBPXH0/XAF41vcb1ft6aiJoM0Sj6mdOPPEJhtvJbXWPI2
 xwzwMcePbgX557B4jxfJaBderN7wqc7s=
X-Gm-Gg: AYBFou0JAxgzAZCSYS0M68ZabS4xcgHYL9M6apAyR4TBK43SniTztE9mH888pCIfRUD
 1qiw0LPw0H44mjJQHI0MkM+GalsmFV/iKhOesvHy7h1YWbXO2pSSxKLMvhHWJ2PG9fs+X5XkLxR
 svgz8neMMEMUQECbOG91JueXFAg5SWUXCL1jQL8Kk1aJN+HCt2LK/nqyMV6Y9Gtt9mX3Sr4znDd
 zeCTu83dftvpw2xBk/0ylf1hEoBu6gU8HDRg0khO1wNR3HVWTsO4KGmKTKV8qPrF4pYO7yKmwfN
 S9t87XAhbcWa/i92m3v2tOLknyxln6LOo1nOC8mEnfvPSTshRsbc48vyY39IGVkaeHcpkG+zjHp
 O59fkpDgQjYm6Mk8=
X-Received: by 2002:a05:690c:389:b0:868:505e:b96d with SMTP id
 00721157ae682-8ae36817a39mr28966097b3.2.1791130786056; Sun, 04 Oct 2026
 09:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-19-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-19-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:19:34 +0800
X-Gm-Features: AclHuK-I98Yb2ADAggzBndS-6Txyxgm_HhDfFCFVUK8e4HyuQro_QZ7wRfE-0S4
Message-ID: <CAEUhbmWdcRBdaFdceHnQR-XR-j6tteZ5LZf9kfe1JKwwF1ezMw@mail.gmail.com>
Subject: Re: [PATCH v2 18/30] Kconfig: Extract config IMX_GPCV2 from config IMX
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::12;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x12.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Oct 4, 2026 at 8:29=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_GPCV2 to eventually eliminate config IMX.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig      | 2 ++
>  hw/intc/Kconfig     | 3 +++
>  hw/intc/meson.build | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

