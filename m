Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5F7C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpO5r-0001jQ-6w; Thu, 30 Jul 2026 06:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpO5p-0001j5-7P
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:34:25 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpO5n-00062m-OI
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 06:34:24 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81ee41aaec1so29352137b3.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 03:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785407662; cv=none;
 d=google.com; s=arc-20260327;
 b=WpSPD5tudvuDQVD7xCDhbyaY/mAVQpTBZdksohqpP8Mg/tubx0URSmcdklI878HkEt
 R/izEBdHOpMNb/l6JeAROU9n1ILUjOn6Wlnn96wxHnhKaBFR/CPWI1o1YR5SKj/QRji7
 cYCMrYEWH071N8xoVVmuIg6fJtJ+BDWGvWRfLgRclBQ+kto8YRiKJPr5GB/YFgy789Tk
 BAckyw//oMy7m57ReMQByU+Sb1yJvdnh6oNIit9CIiYVL7tME/vhka29MFM7Zo8yvYy2
 xp3x0+D3wQMGPzsMM9aljyk4/IvQwn2/EbvUQ9NgNXa6ADWP7jc4fdzac2WBDueaMUEm
 lVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wUfthRHiqBb3xBsLHBxGBaZMfDAbD2HSehNMN9I2q2Y=;
 fh=oa7Edr1eZgSY5VWv3KBc54lviIojwgspf9aEbhrWUoI=;
 b=DTo8RpD/42ocBfhxPeJCwijwvHJRLH/amDuA0VfPS6OaTZjcy+hLpe3aP9lmC/xmJD
 WuEp5Ys/sXUDhsCFq1RpX22hdV1o/GfggR/t021Z5nvglsOY9YXY5AL4Qdwt1SafwaHG
 zAgrJcWLNEbWtpE3f30jTnaNxq5E+SZiHb5+dh7Egz3ujqkbiHBHPFoi/20uAPIOK1fE
 e0Z5my/egjIOLHlto+BhwnuENCKNz05t7WfmYGP/G8i45wahuJWxpHOWdRS/1AOe7XFV
 mFpEwbcg0S4PAHZB+IJL1PIkrNLoxc3S/yPYosWZv//64qTE5hN36aFHeosswLAsUb9F
 khqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785407662; x=1786012462; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wUfthRHiqBb3xBsLHBxGBaZMfDAbD2HSehNMN9I2q2Y=;
 b=XaWKPk/flAT/2qLrdYdhckBWLlVvdpqTbJiQDccZJUANHCtJ8v4fwmuguSvgzH1RE3
 h0zPiYTsY9nK0ZaL0amUKJfzAk4wyjVx1nVeQUBRPoUpMBKMpVDzYbqECZWn797PiCB5
 UHw8DLSIBU+uumh7SIVzIPR9HPoUtrAuSkzBqOmN2+AaIvWXzphOOlXSXI12phJHINgy
 3e9HC+SG9OyYyWQO/el7STI6IuO5EAuQD3E9rkiggHaf0evT6oph2B6CUJr2LRkOilTw
 n6xIKkTvNHXgvRwEHJJQkYwHKlQD8MS8ODRTCC+Hk0g6WZSUPvcuJWfE/b7xLhha6yPN
 bhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785407662; x=1786012462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wUfthRHiqBb3xBsLHBxGBaZMfDAbD2HSehNMN9I2q2Y=;
 b=sgXzwb4G7WBuvgvnj+rlocBLgzd9Q05IcWo596q13TUEpoBOutgMt9Q3Ggw5BWLxds
 O9JkDCzWB8aCvZVggGqXdrkp9gR5rGDIX1aGFl2ZUlbOENLmkKbSfznjUbBzq/gvr1mq
 VNNxQ7gLPTtVGv/6am3SY7usZ7zmdkiz4eLL7bG0FdCaJj5CV1pc8lYyBG3D5H054MtC
 WGoJnlmClRMBCYT2gxLnnwgdy+fOPZzb46Lz/w7XtUMYYrSslUsp8c9H8fYPdvHqyUnt
 Pti/EFVLFvy8xkzn2tvVqe0o9YEI0xCmEB1uy+isI379gO9v+1gi7bjN8uTE4D/w0Np4
 kLKg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6Nr3LM6Rk+sYlMo+CpPfhtLCIrkwWhgOQl6aVDrF64jl4qlfKSligVmFKh8fruFx4t1omDZ75/Pe3@nongnu.org
X-Gm-Message-State: AOJu0Yw8NBHUR4es8cgs1cm0oVjnr5fucjkjVe7UrNMCrI58YlwfAio9
 GBz0NSD4cXrpSanynwjwhfTdrQ4SZJevXLzvtykhZDi/9Jx1bc2DkYXWx2DkT1VZPo9V4rZ2Fsc
 rYE9Uqp6i2mJPpW7225UidnntPcNTmnT+cEfVXxiZ7g==
X-Gm-Gg: AR+sD12KI1J2H6oq6MOu721EdP/IC07H1TAXqhK43pNykGi17tiidM4wynftrZUHqwo
 DlM+dVnzz/GMmE1uUDKHYbcBb3QCWFA592Yel7NYQTr0Acc8x4oM+jdsBWHA5xGHwBsa+iwYJWe
 0kav2oEatioKIBGtRuepxlksQ3p7Hh/nO9evEszi0H5TZWLArmHQcttYpVZNL9BG+vqUA32SDcD
 3uDR2XiYiuHB7M/9t3sX6IWKkz2ePsDgHiU2qOOtK8e/XiYhXK0vtN6/0xgOEUT6BTmvfiL1JFR
 nVx1h1q6oeCYjL2WVLLbG7KC2nDPRI2CEPUIldGVNMk0nJwQWrVG0l5aD765ZKesHKTmWVj9bSi
 jX2iLhud0skwhLeorGXYxSzcMylAUe/ATbe5kfhI=
X-Received: by 2002:a05:690c:6a0b:b0:80d:5ddd:1989 with SMTP id
 00721157ae682-81fb891e18fmr12463087b3.10.1785407662413; Thu, 30 Jul 2026
 03:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260728031731.286666-1-gshan@redhat.com>
 <20260728031731.286666-3-gshan@redhat.com>
 <20260729182316-mutt-send-email-mst@kernel.org>
 <CAFEAcA8nxsXNPuqOoc4DGnHbCKQ-pBJib4JhXnYkzMg79GMfAA@mail.gmail.com>
 <20260730062155-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260730062155-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 11:34:10 +0100
X-Gm-Features: AUfX_mwJ2MI7LWs4BECwMrgTBZakM1zAATcqiS8nddtqW6Hd7PF_7BUI1NUnB0Q
Message-ID: <CAFEAcA_xWqomb6jPf_9RmAfaf77uHajMkQk4biOcK3xR+Rgunw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, richard.henderson@linaro.org, 
 alex@shazbot.org, berrange@redhat.com, philmd@mailo.com, david@kernel.org, 
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, 
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 30 Jul 2026 at 11:27, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 30, 2026 at 10:24:32AM +0100, Peter Maydell wrote:
> > The idea is rather just to ignore the unaligned-access-to-not-RAM
> > case as "only a theoretical issue" and default it to memmove().
> > If anybody reports an actual problem we can think about it then :-)

> Well given the only reported case of virtio DMA into vfio memory we have is
> GH100 and that one is mapped MT_NORMAL, I'm fine with that.

> I feel extending vfio to report the mapping type to userspace might
> not be a bad idea down the road, though. "Directly accessible"
> is a very rough approximation to the rich variety of mappings
> available across architectures.

Yes, this sounds like a good longer term idea. If userspace doesn't
have a way to know what the mapping behind something it's mmap()ed
is then it can't know what operations it can and can't safely do.

-- PMM

