Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C8DCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDel3-0005ss-Mg; Mon, 05 Oct 2026 05:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDel2-0005sd-78
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:13:16 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xDel0-0003ga-Hi
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 05:13:15 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4aa8d882so928087d50.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 02:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791191593; cv=none;
 d=google.com; s=arc-20260327;
 b=lah12Pf243Jj9OiUumxutdw8w7wwCloIpxNZ+x2Wb0pxNXPzT8sSLBmHM4zQLbaSOG
 TnmVe170aQKbA11h6ilqVpeRPoAPC4Z/aeI/+pykfx52wpplq5N3F2Wgc02rMGYOTyAU
 vdnqHgoTvK7z/fz2Hiv5chJl0yQaQls7Z4zgzjLFp8evbQ7I0qKzIUHdTE64ExREr+D8
 +d4eCFTEf2C/mcFEzkPLTUCzC0soZeEBDSY9hscBkcX1S3UFTnKYpuI6cy/9+p4UeC/c
 oiVINE6+0kvZh8dys4TSngrbhGq/uYzUCaVIDxRQ5cOFoO9XY8YYyVfJfves/LyMROOU
 JGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rvsL6d7Y7qYYJOpgIq1vbHAvLMaylbujZr0RzSPO6HU=;
 fh=oyYVkTN2tOJZ6Sy7PlWjXoqNIc3llQEvujqG4Um5lp0=;
 b=m6C34EMJmHDj1S3qUAfc1uSK8R5XaguZrHu2o2hnW/hGlg4pFTAxsjoZGwAcrZUCgQ
 kklqhMPwhBb7KwJp04vmv4scTLaboOEk9rFflbd5aw7GQylOx/dgIH7uPAADgW430QMU
 5+7wvrW2/gsUZrlnFRZF5ktSvCklTmE5FHiA4aUmaZfhg/4eGjRYnWUdD5Mqjw6nyZHr
 OtNN4kV7NUCGYAjeWXb7GeaNc4Nc5xrd05C2Vy9wyGp8YNgRrn4v16weL1seI0esGRmh
 0MaxdX9RbvQIKn0/kPcs58ubxwlAV0GA2T7RIFdgYdZBESGAH8Hqer2r7SO9DJg7qYAv
 z9tQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791191593; x=1791796393; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rvsL6d7Y7qYYJOpgIq1vbHAvLMaylbujZr0RzSPO6HU=;
 b=ghHoEC1r7gsGynZqtlNILptlq+W+3qmc8dMQXwVE5HFXbcUidBI9BCQZrV81NJEZvu
 q6F4i0sb11GF73IcAVTsOfV4XkxzdDhpr2Gzds/b9ZwBC4WduUgiLzGRrFB529YfmYGe
 A5Z93KlHvy4coAxSQfSQGKJCuqSpBBLM+3A/jRJoBQn6yXprwEswpvTR2lRkC3xmY7le
 AnSmtX4dje5knxCeVtldt92cKnfShXz0tPF58F6TL5h5QEnDWbK/2hHEJskGn3DhS4DK
 +s+rhMPh3DPBoMSBYEPU2/c/KKHlQUJEonniQY511y5sv8DxZhzssXGfBAD9Mpdnxjs5
 6CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791191593; x=1791796393;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rvsL6d7Y7qYYJOpgIq1vbHAvLMaylbujZr0RzSPO6HU=;
 b=Mepjw2sheCyCqUgmJ7nujQKMJDqjAYGeQ6REm+qOP/rmT2ovQboJMiBWOXd+GOtIF8
 GFtNAuMYISmhKQUZwtnYUrM5fxYjx3kiZoRMIkU9uSsLZwaOqav748kk54gmV8TBGkQL
 Xbb/qesAwuRcn0FDQLnt1nus6aST0CUAlNY22i5rpk5VuZ1WIULZpR9PZOK9jknlAWMi
 SZTa4EKHt16xZul7pPIXP6aXkKuJG1ba0d21F2X9AOj8z91USpBjGKVCOaeMrswAiI0A
 6pjqfCtbkuwT8RxBeAQNQ0dgUtKIcnjMGStiF27Ir6omoycV8p/GJQ7DQssvAhGqarx6
 yVMA==
X-Gm-Message-State: AFq9FYLt9zN9gTp54xdjoU323OeuLEginU5VH8qZwAEpFlVGISCvoYmc
 541vrSKabEJwxQlw2+VwCYF+Wq0A8Xdg2AxBTuAkOsy+/jFd2GnFP/j6V0F6/2/1KDAQAfM+RUb
 P3VWKoN7Km+ca9vuRCFIH9aFHr4IX7AGPSBrVpZNFpA==
X-Gm-Gg: AYBFou3LkyuQ/xUX8QQXWB2Xx9B3vnlXAVeHQPj45k8PeG0tOczjw5Ry4v/wJMEgSdx
 cFnWQ5ViD5m8aP14FOMzje5ShGte2b/BllO3TFxhMMlMR45hurf2TAZpfQ2EHibae14PFpsrA27
 NgJ+sKxwavTkVD36FtjWxO45A9vp+ZkOS3Yse3k0lCuRemSzZRjN734XOFB/SY1KlJr5D5rLCEd
 21BdAn4Fy5CLdw92tOi9jPuHToIo+QrNnHXMkcEG3ELl+A0dsLpXUO0gUafBBll3/CIHwFvVLlB
 wT7YXV8YyRjzikwEqE9HrLZLnQyxCoiIWBQr2MhRXoH+I+6LnmW4bdrPKtfDaHERLkB/2ulKNG2
 DDdquMcKsYvt6Kt1VO7jlf8qmcw41M1A/F//p920=
X-Received: by 2002:a53:e193:0:b0:674:1f9a:401e with SMTP id
 956f58d0204a3-677ac04b689mr2823053d50.60.1791191592690; Mon, 05 Oct 2026
 02:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20261002165039.212819-1-alexander@mihalicyn.com>
In-Reply-To: <20261002165039.212819-1-alexander@mihalicyn.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Oct 2026 10:13:00 +0100
X-Gm-Features: AclHuK8TqJ2SXl8zXFnx6DS-OhbRFzF1a9ohfktfyuNFoJjy3iInRGbNumWXvsw
Message-ID: <CAFEAcA-JWf-KxgdTj5wuT7140ZY2=RXcnkCeAZkFx=t3OEoyWw@mail.gmail.com>
Subject: Re: [PATCH] virtio-snd: don't use virtio_snd_pcm_get_stream() in
 virtio_snd_post_load()
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
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

On Fri, 2 Oct 2026 at 17:50, Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Coverity suspects nullptr-deref, because we don't check a return value
> of virtio_snd_pcm_get_stream() call in virtio_snd_post_load().
>
> While, techically this code has no issue it's better to change it and
> as Peter has pointed out [1] just follow the same pattern as in other places
> of virtio-snd code:
>     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
>         ...
>     }
>
> this way it's perfectly clear that an index is always within the bounds.
>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com [1]
> Resolves: Coverity CID 1687010
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

