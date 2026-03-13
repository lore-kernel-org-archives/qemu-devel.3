Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1D3105F7AF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13AY-0004I7-Ur; Fri, 13 Mar 2026 10:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w13AX-0004Ht-0W
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:07:13 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w13AV-0005Tw-Ba
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:07:12 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so2612878d50.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410830; cv=none;
 d=google.com; s=arc-20240605;
 b=cqbkcfXb3u+rNWcTi+fdEwWACQy6gT08VVdjvvI59970C5BW1BDRRGuJzTy54fDkGd
 1yjfnAqOfYBzqVXvDT/e8FLOg5lHJ/RyIXM3+2fL/QFZzbzV/u0yk1ZeonEjYeaXO1HR
 xvKOEZqIKC9hz7bVY2itxr/nM/d5rWRDzgMqH7Dn4YfpKnl4GsFQ1Eb6o1tKgzD/E/nO
 ORPNXerqoenLWFr4a3ZLH64gX5xFWxnzhDhS6c9R27B4bF9YycBqj79/N12V/hqyNCfw
 kB2A30ZU7Fr2HfJzJTaoKvroP6nQsZbRKFetcBfmUISS0FkTNt3zZ+hiYL/petOiM1qb
 5w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y+zuGy+MFzukn9l58gdbAvWkuD1F7QusTmtCwzvXv6Q=;
 fh=0LmUg25AFIwdJ24y5G8GWy2tfPQPIF/7wiZ8alceX1E=;
 b=HLX8tE/IIDfIdj4VIbnK1hGx6nl1KlbkD7kJwB34eqO1s6NkXwwEPZDQvu7TY3/kVL
 OC0qXDkj7X0WUmBU86E5ahxT+fx+z45mxsjjuLK+33w6UQECtgK29mG59PB0mYjS0kNx
 Yjs3d5TxdTGJpyn+xhcKyedN0V9B9TiZAzyoqXffIyx6mm7qfNJu5OWYOH0pBZoqMnSg
 iY7wn81J/6bn8fE2Sv14C1IwpyYBYuOx9EbFB3TDvVWftgurAg8wqkl+5/85qHm/lw7O
 3ysxVUA6/crZSEEIqymWLLqJdCpQ4FJwne6vGJ3Mnvt5CqGPaUZsEl2dH/jrQlKprbz+
 N/4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773410830; x=1774015630; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+zuGy+MFzukn9l58gdbAvWkuD1F7QusTmtCwzvXv6Q=;
 b=GmYDThp8rN4ekESrP6x78xIOMKwp885krVoML9k5H/hB2tPgxLsHYDEbRED5osPwU/
 F9e5mmuzVpl84ZxPnc2jYTyMLLmeOUrzHb3COur6gconiCp0AIiA35sBAWbxnAVw2QjT
 roWSFIVJEE1bI/N4HuGK7beMZKsaPxIIH6mLZJJntUwQGSP51iouh/LyZDO161G+p7ny
 HOxtQYwdmcxWi6ri3fLocv9VGDjfvo+lUFZicULgx9gY4Jb2jxy8bJ1aV82eECL7wRtR
 JAxCW+MRSE7jYH3/4kNoAi46qipk0RzyCH5kmWQcoeKHr64RHcz81TrJ+dzRVQP6cVN/
 1Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773410830; x=1774015630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y+zuGy+MFzukn9l58gdbAvWkuD1F7QusTmtCwzvXv6Q=;
 b=fm6/PhLcYoj9hDCAOkg+yy1CpUD7RRXhHwkMZv9xlytRiMQYp9GfjpkI4sjq2I1SKa
 VdADw9P+EIDi0nKTd292NOHciQCdwWYdKX+MomwzITmK2eXKfAXcH+qqVBNoMRdsELUd
 ojvyWn6CwM5d8CD678cDeu64ml/LXXbVDQF6oQEBAkUzWVoK+5NLzqA/vWaKZyTUdzSy
 haRKrfmVXDD3ZZ/rV4uLNa6TgIedf7tcMsIGPxXDCJoX0iybJFPbBpmwn4NcINA/9/4e
 7gJi15akdn54/VDEnOaxZWAZPGrOMSa3eKRn0/NpcxjBstdXG07c3eQxzEKUlCLo0W4S
 m6dQ==
X-Gm-Message-State: AOJu0YzV00fh3w2RJ17KgusP0uhbLI3CorNVnkZTjcrHlHOVbf3GeIDu
 FQL1eiFVokqjWhqbYERxxFX7leqTdjRG4LfBcTkizbMzoBw/fxFu/Nk8umkxPbj01Hyzidu2ibz
 avaev/xpaGvxJDNCSfnIndsvZgZ6e7Ku6xGj6WM6T3F5xpDYr8uEJ
X-Gm-Gg: ATEYQzyE4Fy5Yp+9dPItJuSZdh2/v0W8BlQj6CrgnnNqB0EQPD9m4RrsuRf0s5H4Zso
 GVZCx51HvlfYKbNkWhgBN0p/Wfuf9fVQtUBugbzx7X1bBt6B94f735AKaJDlDT5Nd4j3zwq02t9
 TkEVi8k87XXxu/IiqZlblp56CoCaBmdIutJFIkgXP8lLC+fp4Drx3LLsWQIhV/EBxK+NEV8yNRH
 jEyo0BPJHxPcnS/4nXUNcbe06eh0ycNGRkXWSBibNACohoma7zb+IaP8hDfbogAfXMmCRvzuUWG
 jlL0/BXYyaI8JkeVh7raq3sBYie7Ap++G1fEXT1I/BZb/JD5T3Yp2o3mY+zyPwRnB+8=
X-Received: by 2002:a53:bc89:0:b0:64c:ec30:9dd8 with SMTP id
 956f58d0204a3-64dc71d1b75mr4761619d50.47.1773410829911; Fri, 13 Mar 2026
 07:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
 <20260129160917.1415092-15-peter.maydell@linaro.org>
 <CAFEAcA-AoJmHpcAydqk9x_Y6M8_7N=7-izYFPxerLuTdYUKsNg@mail.gmail.com>
In-Reply-To: <CAFEAcA-AoJmHpcAydqk9x_Y6M8_7N=7-izYFPxerLuTdYUKsNg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 14:06:57 +0000
X-Gm-Features: AaiRm53jN_oDkWXRQlWTMXwRFUhk2XVAC2zVMrX-A7BcL88OilZcMttaY77dH9w
Message-ID: <CAFEAcA99c+-qQX+wfVTZ5bKeYozm+WrFHsb=GEQriu_SuWjhWQ@mail.gmail.com>
Subject: Re: [PULL 14/43] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
To: qemu-devel@nongnu.org, Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

Ping for opinions on whether Coverity is right about a leak here...

thanks
-- PMM


On Tue, 17 Feb 2026 at 14:24, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 29 Jan 2026 at 16:09, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > A device placed behind a vSMMU instance must have corresponding vSTEs
> > (bypass, abort, or translate) installed. The bypass and abort proxy nes=
ted
> > HWPTs are pre-allocated.
> >
> > For translat HWPT, a vDEVICE object is allocated and associated with th=
e
> > vIOMMU for each guest device. This allows the host kernel to establish =
a
> > virtual SID to physical SID mapping, which is required for handling
> > invalidations and event reporting.
> >
> > An translate HWPT is allocated based on the guest STE configuration and
> > attached to the device when the guest issues SMMU_CMD_CFGI_STE or
> > SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.
> >
> > If the guest STE is invalid or S1 translation is disabled, the device i=
s
> > attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.
> >
> > While at it, export smmu_find_ste() for use here.
>
> Hi; Coverity points out what looks like a missing
> deallocation on an error-exit path in this function (CID 1644832):
>
> > +bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int si=
d,
> > +                              Error **errp)
> > +{
>
> [...]
>
> > +    /*
> > +     * Install the STE based on SMMU enabled/config:
> > +     * - attach a pre-allocated HWPT for abort/bypass
> > +     * - or a new HWPT for translate STE
> > +     *
> > +     * Note: The vdev remains associated with accel_dev even if HWPT
> > +     * attach/alloc fails, since the Guest=E2=80=93Host SID mapping st=
ays
> > +     * valid as long as the device is behind the accelerated SMMUv3.
> > +     */
> > +    if (!smmu_enabled(s)) {
> > +        hwpt_id =3D smmuv3_accel_gbpa_hwpt(s, accel);
> > +    } else {
> > +        config =3D STE_CONFIG(&ste);
> > +
> > +        if (!STE_VALID(&ste) || STE_CFG_ABORT(config)) {
> > +            hwpt_id =3D accel->abort_hwpt_id;
> > +        } else if (STE_CFG_BYPASS(config)) {
> > +            hwpt_id =3D accel->bypass_hwpt_id;
> > +        } else if (STE_CFG_S1_TRANSLATE(config)) {
> > +            s1_hwpt =3D smmuv3_accel_dev_alloc_translate(accel_dev, &s=
te, errp);
>
> In this function we allocate memory and return it, assigning
> it to s1_hwpt...
>
>
> > +            if (!s1_hwpt) {
> > +                return false;
> > +            }
> > +            hwpt_id =3D s1_hwpt->hwpt_id;
> > +       }
> > +    }
> > +
> > +    if (!hwpt_id) {
> > +        error_setg(errp, "Invalid STE config for sid 0x%x",
> > +                   smmu_get_sid(&accel_dev->sdev));
> > +        return false;
>
> ...but in this error-exit code path we don't free it.
>
> > +    }
> > +
> > +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> > +        if (s1_hwpt) {
> > +            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
> > +            g_free(s1_hwpt);
> > +        }
>
> Compare the error-handling here which does tidy up s1_hwpt.
>
> > +        return false;
> > +    }
>
> thanks
> -- PMM

