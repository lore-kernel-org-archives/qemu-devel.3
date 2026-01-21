Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB88C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viZ5Y-0006Cx-Kl; Wed, 21 Jan 2026 09:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viZ5S-0006B8-AG
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 09:21:34 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viZ5P-0004Uj-KI
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 09:21:34 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7941423e94dso16020327b3.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 06:21:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769005290; cv=none;
 d=google.com; s=arc-20240605;
 b=BT8C6FOCxAJi9Vmag7bIy0fGEHh2JIOMvuh91MqIknEm9lq3/hAOzF44qWDi7QBDN0
 PzCT+4nXvcsZPk45nOTyOzVrMIZh335bSJXMlfLTiyysZjH4sGOnRggf/I0tn0wZBqYd
 v2yqShpycIn+OLDMNUuvkMRxd5IzrdyqM2AbWuudySO1F/kSLcvm8pQnIucxsjAdUvXv
 plazgy/eyrjJBgiFwIvPf21WlWg65pTxvb31ddg3RFcFIJqyjgotsPW3AciLamSgXJs/
 6EL7lfFYVewsW0ivMwHRezXgD2x0zp4w8VLDQgb/BX4qqS4b6X4pThk0B/YBS9IyT4Gw
 VbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GlT8dArKU3arklwG0KQOI8CrTV3x3mdeAWBK+R0CWvQ=;
 fh=5lzRtJ9WteENmz88smNxJoTH1xjm88QLP0kNJmm9QuA=;
 b=TD0s2CQqldjq6xAIdVhONZhk7hwyidtM9zqKpF8kc4BzcpqbnW3VrJItl0cbrdPXLY
 ONw9vQDnd51oySCKigS5sVTcGrdqkU16PxQUWc6fVjSRKU4U6U+TnMkDLnt0XsrqrlSC
 nIuaI1Rafe4FIFbbq1bsD8N6+JZkrEAMK14FP1U1kTQO5J48+65hZl0VHNUjOvzsWXg9
 1uL5ZoC7TytOROqf+aTNVWcHMsonkS5OsXazkIyQe3/8UnV8jR1ONkMnNfjCH0mgt7Oc
 qVetG5Kmt4hDbUqEohxUiLLX9opEMWRRLSzGviSXEqtNxAXTm3EiOfF6laX9XcUbWoQu
 npaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769005290; x=1769610090; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GlT8dArKU3arklwG0KQOI8CrTV3x3mdeAWBK+R0CWvQ=;
 b=aEUuqkWNTbTqCSqo3wrlvmbmJABA8Ps08Fc1Eemry6R/zdTDRrXeanU+f5k/hUUxyC
 23vYrJIFwOdrhNLiTnttEtgPql/lUxf680bTiqKXcbC655UgKFCoUlVZQzAqdhmK3Q/x
 boJOu+oMEEQUFjtrO5k7X/LfKX0i5v6XIDLnIkIa6I12Iq6oEOa1zQi3OzltUlxutiOd
 SrkpNXT4GWos7x1qSizM6/UFxyANtEI2uJpwSacl1k1AhyD9abmih4jUoQVgU6XwUq9R
 DTusShtJxXB549yQH7ebcPEazu+kegGzy/9icpos/aM1PtAKJuqV6y1S96dNmMtoHLSf
 vB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769005290; x=1769610090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GlT8dArKU3arklwG0KQOI8CrTV3x3mdeAWBK+R0CWvQ=;
 b=MyRk6Zc+5AShDLQvuUZFe7kIfzmXSBX/jmMSl3uyZZ+6Y1nlolLKtfoWdLHOO4ibIZ
 anBrstGtkdRSAJgytAw1PZGMy+5cgOgX5gH7ByGjfHeTjXxwQpW4twvLqafp9pNath/g
 3oCRg38bCuK0aBVMzBQm/jZqLJ+QOGXd00AhaePYimCWAfMOABpqbNX1vCSBVQuwfGBD
 YhdGPqZwF92bWDNtieiZLArPJzugQ9bu/V1lVZPwpqcP42d0BLxe7f0V7d0Do1V+6i8K
 B2EqwxOrJI1e2jccnp5JEfXkOB6gFuQKoNRnjsjKShKnTAGwTT5NE9PNvlcIX6FNTrVX
 yIFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOCn6TE4EQ7DvX58cgcODqvL+wZ/YOL/BoS+upo0jtjRKU4g6PU4Lw3VCQpLdXByZve2nBTod8CQHO@nongnu.org
X-Gm-Message-State: AOJu0YzHwvecG/r3GjqdLf2Bjbq10co+R4jN2tj1mtbpU7M0yx+ekWWD
 nKsO/EgjwxJPfdKvSgmP/evOZCehzWemQAgrawG4pTKGGFZ7asgs5YODJzX+Req5imL4lQts0Zy
 +zj/a5epOMhfPCQRDThowEdo9e1/zYPtyf3J6Mfbo9w==
X-Gm-Gg: AZuq6aJOK0+nfPM64CEF5YnrOBenW4/MLSMqmLGuoOEpBjHE6ksHYNTDNgYwZZu5uhP
 C9tubJXrfktVv9mz54/8fv8K2MB+wCjJyi0pzZ0507LvzBUU7BzWN5L5+s1kzypO2oM47d1g0Ho
 us3NHrWzNm5KFF+UZfJaHN/g3Z46XBcd2FegbOmvvtcpSiibReU5fKdKrH984WvQdDTVMkjqgLi
 ixRy7ov/5n7BEZBaqMmzcVCRJ/xqgWCKBhgSVrsf+03DUTlFqZ27vXToMAtzw9rx5yf3A==
X-Received: by 2002:a05:690c:6f13:b0:781:64f:2b63 with SMTP id
 00721157ae682-793c685d462mr147503457b3.63.1769005289673; Wed, 21 Jan 2026
 06:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20260121114111.34045-1-skolothumtho@nvidia.com>
 <20260121114111.34045-2-skolothumtho@nvidia.com>
 <53a51440-c7a6-49f9-bf2f-b71c8e9f32ed@redhat.com>
In-Reply-To: <53a51440-c7a6-49f9-bf2f-b71c8e9f32ed@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jan 2026 14:21:17 +0000
X-Gm-Features: AZwV_QgQY1nQxR_5dNIh4i-jKjPzlL0pgVwIGHpAV_0s5-sVr4HkllWqHIPKZSM
Message-ID: <CAFEAcA9+kp7K4cGeMx2PTGp1V3SkKoqyHEOZhFD-QQ2Y4WZHPQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] linux-headers: Update to Linux v6.19-rc1
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 eric.auger@redhat.com, alex@shazbot.org, cohuck@redhat.com, mst@redhat.com, 
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jgg@nvidia.com, 
 jonathan.cameron@huawei.com, zhenzhong.duan@intel.com, 
 vivek.kasireddy@intel.com, kjaju@nvidia.com, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 21 Jan 2026 at 14:02, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 1/21/26 12:41, Shameer Kolothum wrote:
> > Mainly for adding support for VFIO DMABUF. While at it, update all
> > headers.
> >
> > The header update breaks virtio-net due to virtio_net_hdr_v1_hash
> > changes. Include the virtio-net changes to avoid build and bisect
> > failures.
> >
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> > Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >   hw/net/virtio-net.c                           |  11 +-
>
> Recent commit 503eb470e087 ("scripts/checkpatch: more checks on files
> imported from Linux") added a check on the imported files and checkpatch
> now complains with :
>
>    ERROR: headers imported from Linux should be self-contained in a patch=
 with no other changes
>    #101: FILE: include/standard-headers/drm/drm_fourcc.h:978:
>      *               2 =3D Gob Height 8, Turing+ Page Kind mapping
>
>
> I suspect there is an error in the name of the file in question.
>
> Anyhow, feedbacks are welcome because I doubt this check is
> valid in this situation and I am ready to apply this change
> as is.

The virtio-net.c change should not be in here. The change should
be staged in a way that virtio-net.c gets updated first so it
can cope with either the old header or the new header.

But it looks to me like this is a bug in the Linux headers:
they seem to have changed in a non-backwards compatible way,
and possibly even in a way that makes it not possible for
userspace code to use ifdefs to handle "maybe the header
is the old version or the new version".

Ideally the kernel headers should be fixed upstream to
revert their compatibility break, I think.

thanks
-- PMM

