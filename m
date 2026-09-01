Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D2AC624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OPf-0008KS-4V; Tue, 01 Sep 2026 09:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OPb-0007rW-C1
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:20:27 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OPZ-0007qI-2B
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:20:27 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8588583a7c3so10759437b3.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788268823; cv=none;
 d=google.com; s=arc-20260327;
 b=alcJH27mpJXUYVWDPJYmL68wvMF5Mtyz1/ZeNEBV6AViXB2If5HRpHyCvN4y/IlxN0
 e3M2ph7FM8l+k8jqYN+Pmy/lIt9iw2TN++80r4eYzX/Xh4UeH5hEjMxt8UzbPuZPMnkO
 5aEG5uhIAHFWcYO753bM3X7ZrBxUf/Xg0T3O3+cW4LYvw5iGvLSZ58lRHtshfefBnoRA
 nMteANUuseonLProXOzcL1KmVgfrXT6n2UhkWlNB7z7CKOP/9xP4PAmftadMJzdpvR4l
 BXoJ2JWbt2FENwiNjTS//nlvpZA8Agx7+kKTdNmlHimW7YLnG4I1vWVz3h+aAj6ds22z
 BrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ct7+AnY8V0yf+2DAzDh9P0UCIPmmGup+l7IAwG1zyUA=;
 fh=nMjTaNQZtwlGLqK0OnR7VDm1+9cMmYC6ReKXas8Av2g=;
 b=QEObw9Izt+huLzY7o727qxgTnhbRqKTON99EGpa4z2uN4NE+MPMD1ITjscqaNQSLaK
 jty67zwg4qFGLmcsXFSXSMKfoiD79PMZJC4t1Z2u7kPSQQ7M/DbueE2kaOt10Kj/WAVi
 7941VJgsblkokzTgRkD171bankqbn60ZEci8sIzZnTqTmlFuxOh2H2hJOLd8OQY8e+/a
 334dpBgJeUu1b7EAK7YzfmVZ9j2/kQcrnvQgB5KiRV+3TcAjoJ+dOhfmFwutxe2aCKKa
 Xc7/CZydia0kpdNZvt44rkA29gPI5UnpLMxqZMOf7UlEVEUQ1REi8rNgguH08QmJEnKZ
 ooMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268823; x=1788873623; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ct7+AnY8V0yf+2DAzDh9P0UCIPmmGup+l7IAwG1zyUA=;
 b=g8U03ifUn2IxhhuWOyDYvoeE2bIXlpfCM0ogvjM4k9zyRY7H6AmOjcmPvTzYW1VM9s
 EPjo0N17EsqFjzLgC2el+poJhKoYHsXyAWuvjAvguS8z5EuGdM65OrCipr9E7JS7RJvm
 qvkpFXHXUSxEmHdpsp2HVY0c1B5TIoZ6SJKwCX99iScZ0F24IJaieCgvi/F1XBzDjc05
 vd5QB72H3WCPnujxpypklgBF91lz/2VWbfgaG7LgV1UvG9cUHSDWHeCQVC3bW493U1lx
 WuC5f79a0viR6jDjgBX9BztGsVTAMtGsk1c1Gdh2t0c2VpQYGfMcrtgFRwsGwgMK85ps
 s6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268823; x=1788873623;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ct7+AnY8V0yf+2DAzDh9P0UCIPmmGup+l7IAwG1zyUA=;
 b=J7loC08FGyK5DGOMbTLJZW17d12x48bIHc1PWWvQV5tSYYSxGOUTo1fRtoyA4NJGC6
 iDQBMZSkU4XoBLdnKLZUkPvXvu9IdJZM7yxnAj8ancLaQSThzX3HYMdNtqxJ3o7Sh3jj
 W8D9WRZHLKlT/Dh+k/qfUydH3bKrxovg9EfLdAD8TvIdMInlOde/bpsIgsFdWG50c5e3
 YA7DX58TRXpVHla4JsGAF8Cf1dW7ihjSvz1uFoJ7r77h5k++S/6SxsXPA4MtZ0sVupwl
 gidd/26zRDnR/7W/kKHkKt9QVbcAGUBg7B7Q3clyk5WhARRKqQq7u97qDoIKt9ZpUITW
 4Qrw==
X-Gm-Message-State: AFuF++k9lyUJEvK5T10ih/HuNpp6UiSXm7BKfq+f49g/Uo/hQssppoop
 VKGvBLvl18uIYam5XhvWY6Q4y/bx8KTW44O0Yar6h3ZaWIJDhfbbyhcpBRnJx0JvlhgzLqy8k/o
 0mTi2EMAOqatqo74UXa7zJ45oV2dRq4dVx2n2/iti9w==
X-Gm-Gg: AYBFou0G5/hPw77e7lUpcRIssEqTtp7RMZgm8qKpm5VAPRcS8/simjH8eZLAdiJQNW6
 1knzHT03MTPTryrWIa2BXQLlpCD4+SK1zjddDFCkif8xU579JrG4+p3mk5OJ+TcN5L763bEbINf
 z1tst8m6ghXb81eTMnEiymERZCB5A+q1w3u4ir2ns5RwsL5y5q2zmuSWrlF30wi6JwlT+BCel2U
 z06jLDuIIDvPnMVkhJfII7zhelU87TwQpayVnvk6Dpedm73oPNs2pvon6QABgbVLoONFZqT4jo8
 AkddmU6pdU//ASy2k0xcdc24TL8z8OB8qeQpiFroJLCklEPWVhMBcC8vMSbFK9rqE5IHd+/iIn9
 SWxFomzhj+sOtXScTClEdxbtwca7T
X-Received: by 2002:a05:690c:4f89:b0:80d:15a3:7b1c with SMTP id
 00721157ae682-85d68a8ebdamr105327067b3.4.1788268823229; Tue, 01 Sep 2026
 06:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260901082554.804169-1-kraxel@redhat.com>
In-Reply-To: <20260901082554.804169-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 14:20:11 +0100
X-Gm-Features: AcwNN1WIFltK8mA7V5QJnNGttCl8kCJEF3mi0T7-1Lb-yQkejh_hgoNIFvXtGIY
Message-ID: <CAFEAcA_Cc8DmDDw4Ea9EW_Ph_24=YghTXWkty9RmjShxek33xw@mail.gmail.com>
Subject: Re: [PULL 00/13] Firmware 20260901 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, 
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 1 Sept 2026 at 09:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit d2e570cc0f97b936902a5b1b86b73c0f5998b475:
>
>   Merge tag 'pull-ppc-for-11.2-20260828' of https://gitlab.com/harshpb/qemu into staging (2026-08-28 15:17:04 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/firmware-20260901-pull-request
>
> for you to fetch changes up to 5ce32f7fdb786014255d4cfff749de307cdfdbfa:
>
>   hw/misc/vmlaunchupdate: do not clear control bits upon fw-cfg select op (2026-09-01 09:25:53 +0200)
>
> ----------------------------------------------------------------
> - edk2: update to 2026-08 stable tag
> - edk2: remove 32-bit platforms (following upstream removal)
> - acpi: test updates for the new edk2 firmware
> - igvm/vmlaunchupdate: fix control bit handling
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

