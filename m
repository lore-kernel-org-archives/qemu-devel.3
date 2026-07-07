Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6927EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6eA-0005Uq-II; Tue, 07 Jul 2026 10:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh6e7-0005UJ-7x
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:19:35 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh6e5-0005k7-SS
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 10:19:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so7003644a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 07:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783433972; cv=none;
 d=google.com; s=arc-20260327;
 b=poqRSARnzO3ogVcRdQSmyB3rwKn7wL6wpqL36sFBTDL9GNL7RY9slVYyJAR10H1Ylk
 BosCqfbASCfQ7ldlq85kWsOIu2SngH/JbDDF/HvkZV0U0M+7Fe+Mra9074uT2SK0IhaF
 JDer671r55tZbNORpLAkToyMR0IRPXuTzdnPcRolCbtaVrKbBcMs5A89IIGNLwU3ZV2M
 iOxb4p1Y96//pp+QAEa6adx5oA/ZJ1t+ezutTPhijaY9GjMHviaWmoFMMtJnnTNdiBB7
 XoGi8zPMNcrKAeAoS3YYtdg6mViTsyXr5tKWE6PCkrQ/AUJ0LcMz58jIblSK5A/zrbBM
 Z8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1Buv0oKvcb7fYhWzCmM2FlZsOK0hbcWx3zkwyyKMA7M=;
 fh=icLlk/VaOJ4vnr3pHMSnP1XBaEbowDr336pCxbF08+o=;
 b=XI052MEQS8/UgK58HQFrCamOJouF9yRkgHjqz8gYyTBlxYxGMGG4u7trwz4WV1OaQP
 YIZTlvS9Ae2wRfU4tT/ZKcMemNiUga1sfyVzeQdfCed+Qw7LHGumLiNJHvTSB73+peNq
 uchecbQnFnzvRX97ZRAWhJwa/HTAvSeFipfr2BShmz5jizVeg5IXGvpe2lMFx62EaGiq
 DcbMivS17Cz670yMIMHyQxQUvvnWlmTdRRLJyoIa0iaqXiGnzgJxdFTLwg9m8sck5Dke
 eMpu5YQoBeDzav2W4kGTZjejXWzD8TOaDaNQ6hLUt+TymNxHIbr1GKtS0YeLrg4JhqTo
 oV2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783433972; x=1784038772; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Buv0oKvcb7fYhWzCmM2FlZsOK0hbcWx3zkwyyKMA7M=;
 b=JRaqgB1n5Vn3Rb2eh5XfKu8X8J2PVNOipZg/8PQDqYQszs+0rjsZbZk5yux9UOLFbG
 WU7jR7Jt053uMZ6f+iYTOmF1CP5gJT8lqHAYb0HHgqCeaUO+VN9BCC/gULrcg4nocvqO
 nZwjPBICaQY/0ZeSTqUlF7uQ16APl1cxedrs9Kng17l0RHyVTOrzNuJxIf0LwM4VUEwo
 tflAycoGsCcpzEG9CIkDqPavW14nBLsaWb/X8KvJHPcDDVDKB8BsRVUkfV7iUY7v98/C
 EFiKDamuWmEgj+a+TR+Pnw1djwVCN/9bQdMjepfnklhpqzRKhSRv81lAYaC6FITb80tC
 yGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783433972; x=1784038772;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Buv0oKvcb7fYhWzCmM2FlZsOK0hbcWx3zkwyyKMA7M=;
 b=CsfCX6wfonD47rZ8rYv7nDdmxGRMHUgUxIqRZ4dtBh/Jwv4t0xld0g3iPXWWyaRwp5
 bFflcMh7Bz8tx/iYKRUswE9MtvGz9OmEJEmwMUB90Hedu6J9YesfFkxaoKCdnMxLORVI
 MPnq3+dH1jDlOhiVIEHySA+my78BZQ0eyDp5gnaE93dKoRLm2lcyQFg428CISLIIp/8m
 DUdzYubC73mSKNBYIvql3vafhO0+q+cdMr5LV02VGiaDtbi7I+g63imk7kBs2VFC7YiB
 owHABJX0igU3+KXYyGn4INTuDrwqJLudEJK9kXTBrDWCc7q8ZOG/kvTzSD6iY0/6tp2T
 oDyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RovQCjBIVOtYV9qHrNa+eRxy7h4yAx94nWUlMNZvpbUFNC4ayuoXAqUIPCRr2Dh5ZdyImF3uGNCVTh6@nongnu.org
X-Gm-Message-State: AOJu0Yz4+VUOx1wKvIStjsi0JHpGARZRtj+u8u2BYPAWA2RKB9b6E8qn
 xMDsa6vgfZktbTdkCkvVBZcmwWMm7iHzXLetFVFHTH2Hh2RN5TiuoQ20iZTQLGgbkRNSUP974KQ
 wJ0KsPKea2NFYA5B2FJVh3jq3sts6eDZTjkeSou7zkA==
X-Gm-Gg: AfdE7cn37KuDnXYPNUZtMnW/gO3rUjm/f3lJj4Wra63pNMBe8kk6BOSkXyaCBzrWbZw
 q9tTdapULyERtaywld0D6b+8weAse2ErTUCS2FaG2LLRd4IPPo154I9NwmvFcvFQC1XFH4Zl2cM
 rBJAb9wcfP2XHkr7SRmQbjiRl89trofUT2n3QOlUx+UnsbfLBceBOvJq1uJRFO5IGI/0xV0XCy8
 IRN9Is4y/BAzlqSUBQhuJ6e6nH+FxLp2sfdVZoi3Np9RBbZ/DEfQyqiBqf0xum3dkZuJdjBEuRe
 lqKIT4j0ldk1ZznKzlKl0NlvihaostE3/8fm4vh1lzYiOpe6fllZhiJT
X-Received: by 2002:a17:907:787:b0:c15:8fb4:e600 with SMTP id
 a640c23a62f3a-c15a66f68f5mr327995266b.20.1783433967763; Tue, 07 Jul 2026
 07:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
 <20260703135512.3213964-2-mark.caveayland@nutanix.com>
 <akzrbOKbBwZAKK8D@redhat.com>
 <40fcfa42-ff8a-49a7-bc69-6a3c2ae03e38@nutanix.com>
In-Reply-To: <40fcfa42-ff8a-49a7-bc69-6a3c2ae03e38@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2026 15:19:14 +0100
X-Gm-Features: AVVi8CeE7MRu0L39dpl-NoAczGJPxBQzD95FWQN32i1K0SU5anSXw4AEAsLGB4A
Message-ID: <CAFEAcA_kvoyrUUUL=1b6xd6=aO-XKvkhmMyrmd33d0OwSGHkQQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] qom/object.c: rename
 object_class_property_uint*_ptr()
 to object_class_static_property_uint*_ptr()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com, 
 aurelien@aurel32.net, pbonzini@redhat.com, richard.henderson@linaro.org, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 7 Jul 2026 at 14:08, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 07/07/2026 13:05, Daniel P. Berrang=C3=A9 wrote:
>
> > On Fri, Jul 03, 2026 at 02:53:03PM +0100, Mark Cave-Ayland wrote:
> > I wonder why "line_size" isn't merely a field in the machine class ?
> > External code ought to be able to fetch the current machine and read
> > a line_size struct field, surely ?
>
> It certainly looks odd from here: one of things I wanted to discuss on
> the call was how to approach the conversion.
>
> My current thinking is that the aim should be simply to convert
> everything as-is, and avoid attempting any refactorings or converting to
> a device class prop via device_class_set_props() if possible.

Oh yeah, I was going to ask how device_class_set_props() fits in here.
That is a much nicer API for the cases where it fits. I would like
any QOM-level API for setting up class properties to be as easy
and convenient to use as that is for the basic "there is a property
and it just sets a field in the object structure" common case.
(Obviously the more oddball stuff will need finer control.)

-- PMM

