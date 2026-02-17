Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF08E909AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 14:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsM0S-0006xX-Q8; Tue, 17 Feb 2026 09:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsM0Q-0006v5-Lp
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:24:50 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsM0P-0004jS-0h
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:24:50 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-649df393c04so3716319d50.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 06:24:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771338287; cv=none;
 d=google.com; s=arc-20240605;
 b=a/W7vawlWjuFkaUsGYJ0arkhFwaiyU5A59q1d+vEkBLr+CbLnZIcp1RQAF7Us/DCAH
 ymDao5//pEVQBlfJNrERu54n5neHVgJLp3LBQUUV7HOXP7xKgVTWSYp8ELLvGNJ2i2jv
 B2Hap6PLPUYn8virY00jz2p8rrCY69c+11lNXx4qjPLuVPnd9b1dQZJJKKL0rjshrbHS
 EY7lg8C2sNvJzyUc+VoGepZgWa+q0wrW06sq4Y+Q7/wE/c4SnmeH1fV2ZDA67w7Z94+U
 zCB70tekcWx5hMpHZURKfU5h/CrXPi53+yZ+TG0oAs2AxRCzNAEcHhqLlcqWrJvlewIL
 7jyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RJhlzFYeinT9K32+dkA2FzKvYK9zoEX87hrTuJqHSYk=;
 fh=Nu3cw6gGXG9gVRFXyozVPi4y8ypLPBn7yqTxSacWp3E=;
 b=lDHL+t9TkmeFPlhcytgqXGuJ3uuumt+d80cUZzngM+eHPyugJwfrdBrdn1IuD+BZ0W
 CuGxVFwZWNivlX2x/uvX1SY0x+/rn4snw3VvT8xmdZS1QzGKj6iljvAAJnoxGEXsm2ft
 H2PmVs9c+O4ELx5sBgoGaXFqowV5GZu46kZGkLWalkdRnTuP1WF6I0TEfRoGdLc/yMKy
 plKnhTHU5j1eJF/b9/3EnEqM5RhAhtWIiqU6V5gn02biyoF1ALb/pfsYw3Tx7GQHiITt
 X8e3e821FBrJD7uk0KlpcHwMtkvXI2qK8JjhbSZO/Zav0pMNwIr0ae2mIIc5+O8OfCYn
 yz3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771338287; x=1771943087; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJhlzFYeinT9K32+dkA2FzKvYK9zoEX87hrTuJqHSYk=;
 b=uWsAH1R5Fos+dw8rGQlu6hoien2cEW8E2NlwvH1aGRL0SnoEpyvp/pxPo2RdM2Mihf
 nLPBOPkXw3sSEpD3k8Ku5UO92NfglQcs9bOCa9sGCFlTwHuKlerghxPJmExoqu2bhsQm
 CVszkJ0FWEW7+gSpbazc+Cbsnw/OBLeBldJk4Zyq1AorXBeA5bZwV5cPg569tKASvYqq
 tAlrr42WMyvnAFQEaHz0raBdZBuVHh6VkIHebjPVAWbTIndQUQVWJCKgY9bSeP8GP2El
 AYOeeU3rwkzE5rhDzdWQC9MB2TeV6JF8eYJtl/b8gSeZ6AhGchS83/QzZbte3eMYSqQr
 UZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771338287; x=1771943087;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RJhlzFYeinT9K32+dkA2FzKvYK9zoEX87hrTuJqHSYk=;
 b=bK4fDK3yWTrULuYfGDD5wKxFyoDe9jA+R1Sd+eX21FwkUZzVK0Xbui+DyZtr62WdYL
 Za0vOY8a/GmBmUK90wWKG6xjoVpMIDOT7w408H9N6QLpZRMFT6K04vAB0XKvLxx6yDJE
 tntlMz081MJj+xYeJmWMAX6MfyrGVMmdIKHIz8qKez0XgXqsJ+VPEHHEhkh/N2Ayo2NW
 kGcqk77uEkAddCP8PdWC1RcReDvcGvwaT/jY8GxNY2XXSGRfJFBtIKaMhh7XOzK6Ke0i
 HpAtrN+JccJwr1xI883CJRfqAupURCec9jrwugCL1X7oF2lev4AYki6ZcO14LrmSFiXZ
 xYGA==
X-Gm-Message-State: AOJu0YwgV317yvieh/rpu/aIxE+Mf943CY2YgTf4+SrXfkaE3BOSg53v
 TpcN0xtE4LpdQ9aVTR3uUD4Uph6TAlvUDox+MOuwq3rmjVMNJkRV1O7Gq4cVk1OviJD/R4Ebo7d
 MT70bwMpCt9bhC7Fhj7S+PdwSity7U3F5OP54wgsP7AENR4lKhGSX
X-Gm-Gg: AZuq6aJiZxeASAjloYlosONoUDSrdTtx35iyochDucnlkODRT/mGNSeN90UL4+Fo3Zp
 tmUcuXX71H0UP/gziZ/0xS6pQwsFFd0r3KYB5ryWOEKQCnJc4RaOyyLsqO1L1AccAfEeOYtVDUQ
 mG6z+Dd+Tp9WVYKonttZv2HqTJrCsMI8eUhSNGCslJpMRFlrAN+fQKO/03roSb4w1GW3pHHt8xI
 ZvrwVP9sobYK+ePWyRjcvBvGMGfkLhkN51fMyUYKAAbUX4JBGlv2K65isXwHQ3ExQiKABfTgqky
 pe7vRwAQAHp2U4ZQtGzRwmVTt8ImiqDQEd8Z0E3J1nCogU8logvopwS9l03BA/hskMU=
X-Received: by 2002:a05:690e:4184:b0:649:412a:dd11 with SMTP id
 956f58d0204a3-64c19b5585amr10536743d50.74.1771338287299; Tue, 17 Feb 2026
 06:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
 <20260129160917.1415092-15-peter.maydell@linaro.org>
In-Reply-To: <20260129160917.1415092-15-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Feb 2026 14:24:35 +0000
X-Gm-Features: AZwV_QgkyMJFoET1qakm-f-NNSglkvs1QLTaaUAHH-FP4S9VjTpvp8b6Aq69l5I
Message-ID: <CAFEAcA-AoJmHpcAydqk9x_Y6M8_7N=7-izYFPxerLuTdYUKsNg@mail.gmail.com>
Subject: Re: [PULL 14/43] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
To: qemu-devel@nongnu.org, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 29 Jan 2026 at 16:09, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> A device placed behind a vSMMU instance must have corresponding vSTEs
> (bypass, abort, or translate) installed. The bypass and abort proxy neste=
d
> HWPTs are pre-allocated.
>
> For translat HWPT, a vDEVICE object is allocated and associated with the
> vIOMMU for each guest device. This allows the host kernel to establish a
> virtual SID to physical SID mapping, which is required for handling
> invalidations and event reporting.
>
> An translate HWPT is allocated based on the guest STE configuration and
> attached to the device when the guest issues SMMU_CMD_CFGI_STE or
> SMMU_CMD_CFGI_STE_RANGE, provided the STE enables S1 translation.
>
> If the guest STE is invalid or S1 translation is disabled, the device is
> attached to one of the pre-allocated ABORT or BYPASS HWPTs instead.
>
> While at it, export smmu_find_ste() for use here.

Hi; Coverity points out what looks like a missing
deallocation on an error-exit path in this function (CID 1644832):

> +bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
> +                              Error **errp)
> +{

[...]

> +    /*
> +     * Install the STE based on SMMU enabled/config:
> +     * - attach a pre-allocated HWPT for abort/bypass
> +     * - or a new HWPT for translate STE
> +     *
> +     * Note: The vdev remains associated with accel_dev even if HWPT
> +     * attach/alloc fails, since the Guest=E2=80=93Host SID mapping stay=
s
> +     * valid as long as the device is behind the accelerated SMMUv3.
> +     */
> +    if (!smmu_enabled(s)) {
> +        hwpt_id =3D smmuv3_accel_gbpa_hwpt(s, accel);
> +    } else {
> +        config =3D STE_CONFIG(&ste);
> +
> +        if (!STE_VALID(&ste) || STE_CFG_ABORT(config)) {
> +            hwpt_id =3D accel->abort_hwpt_id;
> +        } else if (STE_CFG_BYPASS(config)) {
> +            hwpt_id =3D accel->bypass_hwpt_id;
> +        } else if (STE_CFG_S1_TRANSLATE(config)) {
> +            s1_hwpt =3D smmuv3_accel_dev_alloc_translate(accel_dev, &ste=
, errp);

In this function we allocate memory and return it, assigning
it to s1_hwpt...


> +            if (!s1_hwpt) {
> +                return false;
> +            }
> +            hwpt_id =3D s1_hwpt->hwpt_id;
> +       }
> +    }
> +
> +    if (!hwpt_id) {
> +        error_setg(errp, "Invalid STE config for sid 0x%x",
> +                   smmu_get_sid(&accel_dev->sdev));
> +        return false;

...but in this error-exit code path we don't free it.

> +    }
> +
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> +        if (s1_hwpt) {
> +            iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
> +            g_free(s1_hwpt);
> +        }

Compare the error-handling here which does tidy up s1_hwpt.

> +        return false;
> +    }

thanks
-- PMM

