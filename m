Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C598E9B24E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vupz5-0005ai-1N; Tue, 24 Feb 2026 05:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vupz1-0005YA-Re
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:49:40 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vupyz-00047C-UK
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:49:39 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so762569d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 02:49:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771930174; cv=none;
 d=google.com; s=arc-20240605;
 b=fKFKEhUjDnCKtOK/tn71z2CP0XWdlJFiMR9RYUMhmp8vWHhycQdqwAQuEHaFx8XF1J
 fd68g5yyGO+QdyKFQ7L6SpgdTXBVe26tjdrlpglzHumRkqyKo4Nt2YjNL1nZOgfKa0HS
 GR+MXv86gwYbKg4ChR3/BvZFqtTLGPLD92bZBKxpbiCEnmhnCW49FR6f4CoIdGF7/szD
 th5zlmjttLIRNEwkOHP8eSSRXaHnG8HIk/TuerpPfvcBm87BFOMoEiAtON0ymvLv7tb+
 MlTWU4IVwgka1LlAdBiObjht5MUVAYD6xvLerxBGunpLW0vMAKd8u4giNuv8Uj04vLCZ
 BfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3dGSMmqYWMJT8MyYbiGibh3BNEh8FgrkWKcRPtqxlX8=;
 fh=6/PW2K+EINSFuO+9vXfQvnewM1RRi5NRep8wBgTt+Dw=;
 b=WCAxPb4+UQhr77rzp0rMF6/EtyHhQJV66Od1qO/dng/HvvBNdwitdmIe2/47wx62yt
 MZRC5DrQkGx2fELM7A0OlfCkLL4A46Ym8qfDklt6dXBZCxWwuxi2C/gs8og+mDKayV2b
 whooU28scN/TVamiunMf0dPL2PuBfQadS9nSdxBcGovniKGRFkKWG3z/u8M+iZIzb9/N
 owAyZUcIye7qhBz0QuRyTw9gQf8yQIKjykgiq8/djQ6FvQ946REcPtoP6Su9oP0Et3ge
 Z1Cxt62+TYWfU7IiT4fTHRvELOWFRb1Vx4ZwLyjhih8A8iA5gtHWcdhxUuPJbBA6W8ph
 gpAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771930174; x=1772534974; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3dGSMmqYWMJT8MyYbiGibh3BNEh8FgrkWKcRPtqxlX8=;
 b=Mox/gm2fr8xFVkoITCPyFic/1VQW1TYLmNNvyKzgheBbL3c/HZmuQaFtLgXuWovMtF
 lLZ88673sfdRcqWJv7L+sURchCS1UxXiwmJauaJPl7m/hAaXQG3ztc5jyy5CYIrBBb3C
 64uyOD5n1HONu9jV9YCKX6QuResqNKIbx9FCSFG/TRkyE/sUb5K0tOxOyGBFXD5I4mvv
 /oQwz3MYBcAiXcygDJlbkTsJL9gphKhBFUpuytS0YxTjYeWPlqSurZUE17fOTtoVzcDh
 0xU3yVt0H/TrWQZN+zbKDP3r3S2tnM8qB4zJ1sXcEzwX6YmpKw8ppMV3gF7TwieF/T/X
 auYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771930174; x=1772534974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dGSMmqYWMJT8MyYbiGibh3BNEh8FgrkWKcRPtqxlX8=;
 b=CWemIdRTiJ6bcvSJONijhj/H40fEipHmJjSwEF2ajbVHPNK4EbtvXE8ZLMVoGXKOdq
 c/Mq5lhAxjoPsnE21ZA9uQ4rnSEbEo2ZMzy3uiEsoZ49J4i0abZTlII4IKXKKWXPplZl
 BbYscadEle8KULJa45UmfLna4wbC8H+lgZ1FKv1ZQm21UIIUNm6v0bD7W8STUNiXxO6d
 IsMy6SMvY60eCtH4q1iIQk1nzmvoqzU2EW1HWrqGS2r1V7XVHiZAmI04HdSWDWPT+gSl
 BvzaOSDy6Cr/dT7VJlSjufpZbyByT59p+T/hEWKzzvdOHb+lYvQrYJOZYJ6vYqePNJuD
 qALg==
X-Gm-Message-State: AOJu0Yzr/FlZxuG+KXwzblo0hwRSqgFMWh759rYCqgyxcGqImgZhBMup
 JZB2X/KqCkt1qQUpchrGZR6dnyOtqXsjcDcbxW/UNqAb3Q5dlopU4jEu3K1xxPU6pUKJOBCTTVU
 3k3zHuzWbfZHc2JbWS6a0Pts1oYaxFFCQc0/MQ1Vv5w==
X-Gm-Gg: ATEYQzzqNnYB9v0jZeueSxuCzU1yxUFQxx4ij/FAALUzUPCo55V+hGzHFbvZAEIjfc1
 Ao4FEFRPpSsZwvz8GxWmMLIF/8Gb4xqaJPkDp4G7eamXM/XKWv2bJlQC9F4v+BheJr/lcN++qdV
 Wk2aZUZIzy21s4G6aWVzRJkHQM3E8v1fEA1cWcbWBgsG8g9p1hTKIf2uxx6+Tsbq/sJUzs4SyCV
 b/8ll56wB1ALjYBxcME4MZD1tso5Cx6TzxrtqhjL28M/D4+pflZ57xzO5/o2/J6o+NBuAXgodJg
 jdHtuWkEsUyAS5ZUj4AwzOah4vxkdRZ1TB31rUsytSWE4ysTgkcBCHhAsa27iUOYFkQ=
X-Received: by 2002:a53:ee41:0:b0:64a:e959:b3c0 with SMTP id
 956f58d0204a3-64c78d2492emr6825357d50.54.1771930174322; Tue, 24 Feb 2026
 02:49:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771770471.git.mst@redhat.com>
 <5e5a86bab8308a9d5db09cbfdf12cc3751dce0f7.1771770471.git.mst@redhat.com>
In-Reply-To: <5e5a86bab8308a9d5db09cbfdf12cc3751dce0f7.1771770471.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 10:49:23 +0000
X-Gm-Features: AaiRm53rLSNXP-fDJQ4EIIkqEdz64vTfiw-xJT_4LzdhJCJPM5GgavCsFCN7Z6E
Message-ID: <CAFEAcA_CsVe4TUVm3o_-BA4hXvi2xAThGX5T97amgTQKW_kiYA@mail.gmail.com>
Subject: Re: [PULL 13/33] hw/cxl: Add support for Maintenance command and Post
 Package Repair (PPR)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>, 
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Fan Ni <fan.ni@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Sun, 22 Feb 2026 at 14:28, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Davidlohr Bueso <dave@stgolabs.net>
>
> This adds initial support for the Maintenance command, specifically
> the soft and hard PPR operations on a dpa. The implementation allows
> to be executed at runtime, therefore semantically, data is retained
> and CXL.mem requests are correctly processed.

Hi; Coverity emits a warning here (CID 1645325) for use of strncpy():

> +static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
> +                            uint8_t maint_op_class, uint8_t maint_op_sub_class,
> +                            CXLMaintenance *ent)
> +{
> +    CXLEventSparing event_rec = {};
> +
> +    cxl_assign_event_header(&event_rec.hdr,
> +                            &sparing_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(event_rec),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
> +                            1, maint_op_class, 1, maint_op_sub_class,
> +                            0, 0, 0, 0);
> +    if (ent) {
> +        event_rec.flags = 0;
> +        event_rec.result = 0;
> +        stw_le_p(&event_rec.res_avail, 2);
> +        stw_le_p(&event_rec.validity_flags, ent->validity_flags);
> +        event_rec.channel = ent->channel;
> +        event_rec.rank = ent->rank;
> +        st24_le_p(event_rec.nibble_mask, ent->nibble_mask);
> +        event_rec.bank_group = ent->bank_group;
> +        event_rec.bank = ent->bank;
> +        st24_le_p(event_rec.row, ent->row);
> +        stw_le_p(&event_rec.column, ent->column);
> +        event_rec.sub_channel = ent->sub_channel;
> +        if (ent->validity_flags & CXL_MSER_VALID_COMP_ID) {
> +            strncpy((char *)event_rec.component_id, (char *)ent->component_id,
> +                    sizeof(event_rec.component_id));

Since this does a strncpy() with a length parameter equal to the
full size of the struct array field:

> +    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];

it might result in there being no NUL terminator on the end.

Is that the intended behaviour ?

Conversely, in this function:

> +static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa,
> +                                   bool has_channel, uint8_t channel,
> +                                   bool has_rank, uint8_t rank,
> +                                   bool has_nibble_mask, uint32_t nibble_mask,
> +                                   bool has_bank_group, uint8_t bank_group,
> +                                   bool has_bank, uint8_t bank,
> +                                   bool has_row, uint32_t row,
> +                                   bool has_column, uint16_t column,
> +                                   const char *component_id,
> +                                   bool has_comp_id_pldm, bool is_comp_id_pldm,
> +                                   bool has_sub_channel, uint8_t sub_channel)
> +{
> +    CXLMaintenance *ent, *m;
> +
> +    QLIST_FOREACH(ent, &ct3d->maint_list, node) {
> +        if (dpa == ent->dpa) {
> +            return;
> +        }
> +    }
> +    m = g_new0(CXLMaintenance, 1);
> +    memset(m, 0, sizeof(*m));

(Side note: this memset() is not wanted, because g_new0() is
specifically "allocate and zero this".)

> +    if (component_id) {
> +        strncpy((char *)m->component_id, component_id,
> +                sizeof(m->component_id) - 1);

...here we do limit the strncpy size to one less than the array
size, which (together with the fact we're doing it into zeroed
memory) means it will always be NUL terminated.

Are these two things really supposed to be handled differently ?

> +        m->validity_flags |= CXL_MSER_VALID_COMP_ID;
> +        if (has_comp_id_pldm && is_comp_id_pldm) {
> +            m->validity_flags |= CXL_MSER_VALID_COMP_ID_FORMAT;
> +        }
> +    }
> +
> +    QLIST_INSERT_HEAD(&ct3d->maint_list, m, node);
> +}

thanks
-- PMM

