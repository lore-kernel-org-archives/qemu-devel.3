Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1586D2F024
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 13:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkisy-0003cN-Os; Tue, 27 Jan 2026 08:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkisw-0003aK-Ui
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:13:34 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkisv-0004FW-I5
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 08:13:34 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7947ad38d75so5261367b3.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 05:13:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769519612; cv=none;
 d=google.com; s=arc-20240605;
 b=Ms3UFDEBHCGzLBbd98uCpFTf5HFPIjmCvKitu7D/U7gx66SBW9sl44xboPzk0G4tHF
 DXTnle2TZ0JYYiKmK4Q0CwH7DaEtVrVyUG7is7BGpyzTmqYlMlyBkie/dq0yUbunm3A8
 QZSJrWjyLgREouzdSakDiVYxEPH8ChBO5fnj4Lk2inchZp2vLwMoJatGUUmaQAqttKF7
 BC+d8vnPnEPmVDGLBWumKpJRd1/CRF61o3TFSbOlpzjTMEp82Sgruz6hnpaIjEQnSfU6
 OFD+UqIpL4cEyACM4gQIJPVyQGgIqPizpFD/Ib+Jv0FpH75WyJZ9H3yG83o9lrxVg0xt
 og8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HqOFYjpqXqK/uTfZGMLPsgvgsDMQNGETXteQ5HSMgio=;
 fh=a3IVG1Nltr9p4MF0rHDPbpcAIpy7RM26UASDdQ626zw=;
 b=QgOoEqLqt0VyvFsl9WKVOr2MIz8EMqhr2aYE/tIEGocujE0sT8IKsm0F2HaNSkBNXX
 Fq4xz0Lx8PpOTnn5OFwobn76WCyakPT2qjAIVy3hQI6NhxveikG0kbhpLSdK5n3J3IH2
 dxv1178/Nq0y6eQy/ImX5MqTmfew47zpeEgZZNNA4yZ2K87ubEJChd55oC0/eT9jKSb5
 jOEUDdLQOY+y0TZhecWZuWCu6Zt1yNKEdYmRtjDtVJpeXs/gQRXfaiLZTYsJbBjXOpCN
 Q1sjSpiiZBoi7BbI5S6bT930LLH1QZWQQv6OfIwZ6Pg+grzkoHFq2pLtzC7ZyV5L2cUx
 JaAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769519612; x=1770124412; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HqOFYjpqXqK/uTfZGMLPsgvgsDMQNGETXteQ5HSMgio=;
 b=qI97Z6Isqxr0VmCqJnlMOlOxvttXMetNCkwHnOFO6ho1s2GPLcNxRKiOXArc3PtqWt
 SyjtEn+o0GNUJ49o/TDZwQFiEMqYFZ72cSc2tjB8mpzGIwxICVR+d2tbgsnFzy35+Hbr
 roI6iiDtMtNfa9+M/aBSbu4MR3u70MMgA515hzkUy57QQBIdsdXEBoIAYWR51J+2wj/r
 Wpd5SYGsO82c/4IYIMebX2qRJezg+DupjMhQy3CcSYsOXVZPToLDDsvK/+QQSWgK1Rwg
 uXl2+Is/r+yHhMGP2l4uOhLRlZpWhOf9zPP0UBOmlSc3RrAAgZ4ddVFvhIDOo7CrhYbN
 hN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769519612; x=1770124412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqOFYjpqXqK/uTfZGMLPsgvgsDMQNGETXteQ5HSMgio=;
 b=pF7Hze7vptYMFERZkSARk7CcXHPQrEufMc635GeetTMQ83ZmgPndzYhC6fgApvgla3
 aZifoeXEq++qvgkwi7sSSVMJjNYcSEIGtTL3Ks55gdjkB4qp7EAr1ub0oRWzDXVodSK/
 eh2LcIiFekH6INMRXp30TrC+0xVPX9IgT2SMre7wZjXu4FTM5NupOfMAE4GXVacCMf1o
 pEajY5ee+JRsgXAdrV1Nl3F8vEFXguzf7m+2bQW5A8Mxzd8jYwplXJqNjATUMiYCYjUV
 QkhmE35R+t/3MrI7+MTfdM6ZkEx5+XQxlcr6ltMuA9K9d6zpgmFlVCttDY258i59cm43
 /bQQ==
X-Gm-Message-State: AOJu0Yx/8Aqh6wYHOLy5/IhN2mjGBBP/IX1tEeQXatMqG8jmO1BGTjjH
 JqzwcLnd/M1wAd2wWaH5Pywo0tO50k0CpdBw25DvvxFjClsYdPV14O36Sh7jTPC23a3uZ+WgkF+
 iShRZdAp5OI6XbUHood6R0Zhtv2mmd4SYYDJun4gizA==
X-Gm-Gg: AZuq6aKIEyzTg9Y+NgT0vK5EEMZ7UBgel2mzgUFIKVI74Q4grxOjrsFnzY2M476GGIt
 ZbxEz10kvdmNPHuLxNdhpiQ9zX1DGLgy8Jaj9iu9i3t6+5yTa/gUbrcqUU5kb5jxFvd21cHz23T
 O/DV3+yzeFOlPoPzqUdW+bLLDp17K0YTAZeBDKCIwoo1Ojp6zu0BFYj+hCltVZw79Fi9360XIQT
 yHc+somsIKwhEA6KT/7G565YHdsZ8e8N5CTncQj70GsVaxCJbDp8rxRCW0zVgfirCct/Q==
X-Received: by 2002:a05:690c:1c:b0:78c:3007:dabf with SMTP id
 00721157ae682-7947ab57c4cmr9363597b3.27.1769519611816; Tue, 27 Jan 2026
 05:13:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769362313.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1769362313.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 13:13:20 +0000
X-Gm-Features: AZwV_QhZAdI_7vqt9vlimC2X9VRPT_NvMvbppHJGBIKh66YEOkADcXp82MMOygc
Message-ID: <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Sun, 25 Jan 2026 at 18:36, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Our documentation says that memory regions are automatically freed
> when the owner dies and the reference counting to do this is also
> implemented. However this relies on the QOM free funtion that can only
> be set by creating objects with object_new but memory API only
> provides constructors that call object_initialize which clears the
> free function that prevents QOM to manage the memory region lifetime.
> Implement corresponding memory_region_new_* functions that do the same
> as the memory_region_init_* functions but create the memory region
> with object_new so the lifetime can be automatically managed by QOM as
> documented. The memory_region_init functions are kept because they are
> useful for memory regions embedded in other object or managed
> externally and not by QOM for some reason.

If we have a problem with embedded MemoryRegions being leaked,
we need to fix that. I'm very reluctant to create a whole new
set of APIs which handles MRs in a non-standard way (i.e.
"QOM object has a pointer to MR rather than embedding it")
and leaves the existing ones alone. QEMU already has way too
many situations where we have multiple different APIs that can
be used to do something and incomplete transitions from the
old one to the new one.

thanks
-- PMM

