Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356BBCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 14:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH134-00014o-8M; Thu, 06 Nov 2025 09:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vH131-00014E-W1
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:33:12 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vH130-0005pT-6J
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:33:11 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6317348fa4fso161003a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 06:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1762439588; x=1763044388; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aczDR7nigJTr/WMjm4rvSSwF1N1Z13omCpKsegCJWII=;
 b=P4YMcr6FqMuRL1oPZQKtjMxoxDZ9y+uSn1gRCtOKKUl/2eK0twR+yQH/Cg3XEoJ2+2
 GfLYEZjEngJ+LtAhi7Z9oYER8k6LEj5/FxPvGPzquU7fQ3Zk0C3cXmqE+T0iAdUIIjkD
 PshdSZi8AKok5CXEa1ETz2yBzdxVge8XYAOXNArqdLhPVKMypf+uZR0hC3W577PZZOh1
 haVqZZR6KoSc1kNlOMqd10FNMqycJ6Tcf54gqla/1yqqgV9pl1tuyrKpim+WBxOjOt3a
 cpBhaJKuJ0xFusex+TGPMX4P4MdzLeduVqxyO16huRqXp+PvR9yHdxVFky5g7H21Qj1T
 upXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762439588; x=1763044388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aczDR7nigJTr/WMjm4rvSSwF1N1Z13omCpKsegCJWII=;
 b=VSkR/EZ5gQjwSCYWkq+a/Z1eMZgdtCksCXKX0itN/9r7mwI1zEmaDnxxihagvktM4D
 BJYLJFHfdS9KNosRBvswb+eS1eqtgXT2LV0FTo4P263r2zL9U6hBAswTdA4UUu3GWsYG
 1HP7x2J7R5iQfSqgHIyJ4GcZkxhoVJvBnPvF13vJxmdTwEjGGPcn0e5h9mfwKqhICAOj
 LNF+YPv/JYtUeEtkoS5cDLDEQLMlSnabVW4oM2cyg9TrWXG/ZV++OfXoJFhuPL6AFRd8
 aKCLQzoYAPfpBeOm5SmsN5qdMB3fRC6DfglNPmQy4PpZlrLec+w5H99cW6uPOaU9dCZx
 H2MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsbnRSKTYsx3z5EIdoodTUOOj7o1kHsIfiJvSLaOXgJuGHUyrwTinYsUUyUrY7t4FIBqE5KD6p7gsy@nongnu.org
X-Gm-Message-State: AOJu0Yw0aCNxWqeuiRDrtqCypr41+UJWoE4DyPb5L9lA912oimZchUSH
 6IxEH/MRddbAwfLQzm0qGh3iEB7+HrCBNV3jnZekZ8MHhAVCSTlYdvSnyJESXkBrCIY+qNB/3lY
 oHnN//7i96uRnMBcxmNXBM8fqXb72LrJEGiHVLJpdHA==
X-Gm-Gg: ASbGncvvxkhbMfCG5vwrd2icJpf5Y+QaJVmumO5ubKkquyapQYOpvjOL5xRO6cb0921
 HA8V26Rt2axgtb1kGeXF7etneYKFsUzRwp7NxXgsTXbQFYrOhYDX1iI9ZTrp+4FpZnGl2/KXhH8
 lC+N8VcyKSbpxnuCFbba2Q/J0HSOO8Z5hjfEWZjzwSvJAAjN7/6g3X4dk/u1TpFyirmw50MqcGG
 Ro7X2unyfo2R4OuCEQ6uupQcrbwbTNIsdvyF/741LwrYyV6NREIBAIVwskH
X-Google-Smtp-Source: AGHT+IGXoQuDMdZ0Et/Fj17i1LWehSIhmSQYKmJ0vS21HKZQktf+04kOz4GCpFATgTBazOFpM+oeON/pm01DVsr/E10=
X-Received: by 2002:a05:6402:2689:b0:640:b6ef:9dce with SMTP id
 4fb4d7f45d1cf-64105b80238mr3522055a12.7.1762439588504; Thu, 06 Nov 2025
 06:33:08 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
 <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
 <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
 <aQvM6l04VeZwbUOf@x1.local>
 <CACGkMEs4ES0a_Dzn7LmnthGuL=96XxOmncb5VDV195cxWTCChg@mail.gmail.com>
In-Reply-To: <CACGkMEs4ES0a_Dzn7LmnthGuL=96XxOmncb5VDV195cxWTCChg@mail.gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 6 Nov 2025 15:32:57 +0100
X-Gm-Features: AWmQ_bmKXjSXD-TpuL_l7-OwF2CX0DLCMufiHOzFohd7eLZDmyy8_tpLECL6yhw
Message-ID: <CAMGffEm+eh9jv_CUPb_WAmfJ+dQRRp_ecvSJm60uQSnvS63Acg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8?=
 =?UTF-8?Q?=2E2=2E10_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESE?=
 =?UTF-8?Q?T_=2F_USO_features=29?=
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::52e;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jason,

On Thu, Nov 6, 2025 at 5:05=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> x
>
> On Thu, Nov 6, 2025 at 6:17=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
> >
> > On Wed, Nov 05, 2025 at 10:27:59AM +0100, Jinpu Wang wrote:
> > > > > These are not present (or not supported) on QEMU 8.2.10, which ca=
uses
> > > > > the migration state load to fail.
> > > >
> > > > Interesting, we've already done the compat work:
> > > >
> > > > GlobalProperty hw_compat_8_1[] =3D {
> > > >     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
> > > >     { "ramfb", "x-migrate", "off" },
> > > >     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> > > >     { "igb", "x-pcie-flr-init", "off" },
> > > >     { TYPE_VIRTIO_NET, "host_uso", "off"},
> > > >     { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> > > >     { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> > > > };
> > > > const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> > > Yeah, I noticed the same.
> >
> > AFAICT, this is a known issue..
> >
> > Thomas and I used to suggest we should not turn on USO* by default by
> > probing kernel, but only allow user choosing it explicitly in a VM
> > setup. IOW, dest qemu should stop booting at all when kernel is too old
> > (when user chose the feature).
> >
> > See:
> >
> > https://lore.kernel.org/all/ZqQNKZ9_OPhDq2AK@x1n/
> >
> > Thanks,
>
> I see, so the reason is that the destination doesn't support USO in
> the kernel. For those kinds of features that depend on the kernel, I
> agree to disable them by default. But I'm not sure if it's too late or
> maybe we can do strict peer feature check like this in
> virtio_net_get_features():
>
>      if (!peer_has_uso(n)) {
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> +        if (n->strict_peer_feature_check) {
> +            if (virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_USO) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO4)=
 |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO6)=
)
> +                error_setg(errp, "virtio_net: peer doesn't support USO")=
;
> +        } else {
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> +        }
>      }
>
is there any document to learn how the feature checking works,
function like peer_has_uso, what is the peer exactly in this context,
is it the migration target or host kernel?
> So qemu would fail earlier than fail the migration.
>
> Thanks

Thx!
>
>
> >
> > --
> > Peter Xu
> >
>

