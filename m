Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB39ACCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 15:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI6aw-00066m-1h; Sat, 17 Oct 2026 11:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI6au-00063y-7b
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:45:12 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI6as-0002UQ-9J
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:45:11 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6798d4ab549so866163d50.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 08:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792251907; cv=none;
 d=google.com; s=arc-20260327;
 b=Xpd111c4V9zq8ZO3ZF+C9/OCLHZJ6fk21I/bPvQP5MeeUQWMS3yUM/9oSCts9m+aOf
 gyU36k+qG3O0NgTNpEYtJP+YsGYjZlZcd2v56Llj9okqiRrWAjm5COJUrqvayjjl6DP+
 +e8W1ypw/6+9ke0oVvT65n4xI4g9sXXsHrxpdQnbpGI1nz6O0QuFPdU6WVfOgrasRZZn
 VOgB6cHvoRVXPHVaCOKGcOaCQrR9BwL+OiYmhvh1UdPi7qE90DbUb3x1MAwsAj8VbuKA
 mhePplDHPu9ClEJ/F7gQcDae1J1T/nfPdKp+jnraprg0V3AUXMtqDiRaaihnWxP2BksY
 OJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c6ehgLiCBMPM9O9Qv2+tmYJA5l4Z62uEt1Nmq6PsrRM=;
 fh=/K200KhdRibl9C3I1FrjZhAhyRRKNb6olOYm/zlvy20=;
 b=oj7FSKnFpZKRDSyqvN6HyuLp7OzwrKLpcbhizUrqH2oSlSRQfGfj9OtmvCcC56DE+1
 oss3AW8a+WgR74zpjCnnddi4jKt7SMrVh5pidwrW4dFPjbf7KMLzH36HMhFVqMOH60OH
 8hfFaFsE+nlYaRAGCy2crkf2iLC5RsE6cNawDAl8O1qeZqDR9dn7QL9yUCDL8MgVw5cf
 DrP+VUgXA3tnUqAPaO5ysYt0E5VGXMsMnuF19pZBNkg4c7J61Y9/VFKboQASqgQj+Kj+
 mS9Fd5AvWkiwqHUgLb6gNKSPkuR2VBTSlG2bQthPHv7kVWo2mnLjf0q/WQtbfn6yHF8V
 oN9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792251907; x=1792856707; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c6ehgLiCBMPM9O9Qv2+tmYJA5l4Z62uEt1Nmq6PsrRM=;
 b=EiXCip8z9YOAMq7p8YNuQsmO7C5kaHOuQGb/Ks5kqXRGEJvdJmsEcM4w/1BMtXj12s
 iDV6Aeag1wsNo/OhI7YU1qYUuowq8woWzfhJnoJez9CV6p8KE1416PDMGJvjXohr15pB
 HsWs0O3AonUuxMuRtPSH9bOs/NGolwiDLMoS6E3FSZHH8p2vuxdKWi+Un7UPAMitHOd9
 /ikh3O4VXUBR+WTl3WdBrVLIL1xT+Ha3e/sVTVeBUH2OPVytTh0lB15S2woYsskTTZ+w
 6PYYqbYEySAv1NPCG9WNFzB0VYOb29j/PZxqy4F/9fjlaGH7TPclQ2SeslBhJC8/z/fy
 TCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792251907; x=1792856707;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c6ehgLiCBMPM9O9Qv2+tmYJA5l4Z62uEt1Nmq6PsrRM=;
 b=CFoGTzeh399UKp3wnpSimUdrKb5AufaR84G0RUO6cqOnklilX4tPk/4FdslcZ/WUyP
 Eji6JhpsacUtOffT9nzB9DrFYmDgq4S37mNaAtlhFzThfrH7qK/vToQ4wPNPOSI5xPXH
 4r2De0jQgqwRNPslDlHLoAx2dqfWRht/HM+fCy0aVsqAN7aNrF5ajso6KdbOOp9cGqxo
 0dpD3SXhD65DYHDzAZkFvW9OmhsvpC8Gnu0xprq0470bhy3mgfIy03X6MY4/sZVNH78n
 dsHNcdxbTfnklS56ACBR/EmirR6tfT2OX7zRv1inx9G2ZaHQH1RnbAzQ1jf+fgKaO6Ku
 aLnA==
X-Forwarded-Encrypted: i=1;
 AKwUvByKRI3817Gosriv0Sq5SqD3M+WEWACodxN/5QUQAtVHpgt0+4+VRR5lkrjJPW9l0AmkJbB8oOYas1IB@nongnu.org
X-Gm-Message-State: AFq9FYLiTo9jwnxDX2c15pqyrL00HG+MxyQpDhT+zedisLQzd6ML/itI
 x7qaId3uHYm59S5LW/Qy5Y3sDELGF5vI3CwY/Q3LgFJn7ORC08ZNtzhpVQBteYVipyB+8JrloiZ
 bKRrIjAM9w0WogWH229B648aDbT2K4SLH2+BEubS4dQ==
X-Gm-Gg: AYBFou0MyD3JnGgdoF7fe+IUCuvY1UtL/LfXlGMikGxFZhWR+9AUdms6GEEzI0TZIz4
 yi+WkDghU7l4bq42vtlO97WIp8FIWNaU6cRHTzfm3PZGZPbmr5XDi56Xj4UqwHMUK/Tl/FBi67y
 FPDhOD8R2AFqtDTorKe1TVCKqIlIRXdbnPuq4H+w+FahoooKuFmPSW/heeA2v0IJdIVySpzDhXN
 N0bR7C7pk282jGmdb/f+V4aYGAmr64RI0lHATXwep5GrN8SObed9WbMLe6ZApvxWTJMJCzhwL/W
 tQFBWidUblwSD7R2uc0s/2lst9AfwnyTMVWwqNev4KShc2f+sVLrioiEjNnBWradmbrnsxOEWHd
 ax8RuYSCJq+6w2LEazL3LVpMdj6VLqiYt/qPfnrY=
X-Received: by 2002:a05:690c:f08:b0:8ab:3d1d:af0f with SMTP id
 00721157ae682-8b0f21ae8ccmr13223277b3.44.1792251907392; Sat, 17 Oct 2026
 08:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250929165230.797471-1-clg@redhat.com>
 <20250929165230.797471-17-clg@redhat.com>
In-Reply-To: <20250929165230.797471-17-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 16:44:56 +0100
X-Gm-Features: AclHuK9E6vaOTj7kImr54MM0WYpFKQ-bnz8zOqwxViKhFvMMoBFKEFQspXT3Nws
Message-ID: <CAFEAcA8OKABUH8S_F4HrWLKDC9XYqWGxD5_xMAPOPmc614u4UA@mail.gmail.com>
Subject: Re: [PULL 16/32] hw/pci-host/aspeed: Add AST2600 PCIe config space
 and host bridge
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Marcelo Manzo <marcelomanzo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 29 Sept 2025 at 17:54, C=C3=A9dric Le Goater <clg@redhat.com> wrote=
:
>
> From: Jamin Lin <jamin_lin@aspeedtech.com>
>
> Introduce PCIe config and host bridge model for the AST2600 platform.

> +static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *da=
ta)
> +{
> +    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->desc =3D "ASPEED PCIe RC";
> +    dc->realize =3D aspeed_pcie_rc_realize;
> +    dc->fw_name =3D "pci";
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +
> +    hc->root_bus_path =3D aspeed_pcie_rc_root_bus_path;
> +    device_class_set_props(dc, aspeed_pcie_rc_props);
> +
> +    msi_nonbroken =3D true;

This sets the msi_nonbroken global in the class init, which
is run for every type compiled into QEMU at startup. That means
it's effectively forcing it to 'true' for every machine type,
whether it's aspeed or not.

You're supposed to set this in your 'realize' method, so
it only takes effect if your interrupt controller/PCI controller/etc
is actually being used.

Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>

thanks
-- PMM

