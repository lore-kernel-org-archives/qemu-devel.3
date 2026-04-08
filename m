Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E604410F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXho-0002BI-A8; Wed, 08 Apr 2026 14:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wAXhl-0001yQ-Er
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:32:45 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wARQn-00052a-86
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 07:50:51 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5a3d42263e4so3802097e87.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775649047; cv=none;
 d=google.com; s=arc-20240605;
 b=QMGk7pMGxc+nG3QNMSZsVUGPXV54EOLr0vbO1P9i0Dmv/E1oBvnR3xmtAumytQIn1n
 NFuipS0Z3Kd26kLMHcCbMMo4hfGyCPZIl0emw1QjusXBNh75tYcr8rCnxKW77N1X5fDk
 cag73BLbPZiKR9W1ND8xMxWkrBHbtO4naL36Ng8S0+s8uphY26lqDGNvjY12Bw0NA20f
 Bi56ig4DenKQk4XiiTdJU+5gbpPeqbpTa/dy96uRYXKtoKlfAHyao7DPQjYO7ef4Jrqf
 0AFy3Dkt+S7O1a9FfFnEnDptQ4+O7Tt++JNOZ30Ozxke0alcnHEQ8gyb/MHTVAWiNC/J
 c+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rJtZ217dFYwaP9NuDmJ84KqOQLdVhFcZuCS9eCTgbwU=;
 fh=BfLvu6zkJEKcJCq3aYN6BV9K+TmS+MZ9LewvwOghvo0=;
 b=eUhHXZ5lw/Or/lQEsfAUInnZC18qpTMGDY+vZj84HidFnVRHAG4YucRHo4WnSNU9hv
 ZMhu+98e4cARMe1e0rp9H0CnIJ6KlO1q5rh/y1iWscDI+RNzsaUkXwNQpl4PDjGpXSjk
 cYp8yfCupzj197zmDvcgGhahViOyMqAql0a3FHPerDf3G3jvMK2/jmfyM1p53LzVpI/T
 BPRYOa1Ye/8iZYRhk85vatVaTReMYhKcLb+HgaRn7gB8NGfxAssXeRXsOSzgJ8OIO0Rw
 JWjDUUpI6KHXXkDdARY+7F9ZJx6PKHlvBxtFtgXvC+lt+MqbaoZ95v/f9nlqMBWCVpml
 kQjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775649047; x=1776253847; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rJtZ217dFYwaP9NuDmJ84KqOQLdVhFcZuCS9eCTgbwU=;
 b=LO0MZ2vV6FGG0Bssa+RmsEdNluUin9Hzb1IKLVlyTuYvdQBt0Lu0UaeBAOpP1ZXt5f
 htRgvKiw6OEwC0KdIEI+y8TVbXCYzCVirFblr52Q7u3IxFhkPfhm6lrhO6dMy2Sshfa6
 k8olnNn1IXBaXnRRA9x0WvdyU3AxJLjT4iMiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775649047; x=1776253847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJtZ217dFYwaP9NuDmJ84KqOQLdVhFcZuCS9eCTgbwU=;
 b=q94cNr2b4fGPJNLnNFbGF+jHb+6khtRUy8BcJyA6xAwQr7gXf2CcA15wAUUVNlvUTH
 ZcM53A65VY88EhUqx0Op7HhTWqg3a75c70d0kH4BzHNbOWengmZKyPzl+LHFcCrFXpef
 GrTa1P9At/wWJimTR8gFL+GQozNib4UteYc5/HWVuptinmo+zEknU9Vqtoj2yKfClKTp
 cJn5m3asnO1tBRiFh7nSAOxnKP6462QHBvRz0RTQA98mYSTx8JWlkeuk8HD/BCCJDQDa
 JnxggMDUyiCTQuiH5WvJg3/MJelp/vTTVcKA2bjtbokagCjGjJNu8kEEyuGloTbdcJcv
 FGCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj1rr9IXnpqY2Bo7WUraTisgot7BAwe3BUZJIERPXAbW0/Rmfl9/AFKlsLKQrfl+qbFN9D3ILPPZNa@nongnu.org
X-Gm-Message-State: AOJu0Yyu7aLPaWCpMnByz+zbWpj2MFxHUQD5tN5lJxi5CGEA7Bol+cly
 hWsXc/O8KA89MjNu0VHLXYE6I+Y5vplHUgDxBN0YUvN1P5NW0+WYsMXNHYQKzyrGLuBBy4tWGeG
 l9z7mxB7DIxUyglxSmBkVVQ0H8YleGCyqauvO1xqNWA==
X-Gm-Gg: AeBDievVvEMQkpMpW3msK4WK0wzpvx1dBP5ikvF4A7uudniB+3x8wQaOBqT7SBpXi7w
 FhiHttV1+TZmi9XAlXm6HR/M8KZCd2qJ+sWNvnbN7KkmjVeIVi5Bs5ElCFhVgRIxy9rrRNOnTpl
 VewAG3YElleVVJWVo+6w65qZZvd0ZNMZRGKIYLo2/IeKZBvADcDN7j9iNhLRkCFb6Wf7yPym75M
 WYZIXrnpKCLe5yT84DRn3O7/wqXYo4rW3mmCB9lhZTJj4jtZgc3BJIbZ3J0zJx8ocz+z9l3Utvg
 kx4TANDsfemDVpS7oD6Shv7sPsMk0AkQQ57O5w==
X-Received: by 2002:a05:6512:6d3:b0:5a2:b304:e95 with SMTP id
 2adb3069b0e04-5a33f93cecfmr6773773e87.45.1775649046608; Wed, 08 Apr 2026
 04:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-6-alexander@mihalicyn.com>
 <20260407153426.GA238768@fedora>
 <CAJqdLrpzZjs0Zf52sB0R149D6hCVYEDqAW36BYAaPW+uhK=g6A@mail.gmail.com>
 <adX2hv2WOpt9ZFzJ@AALNPWKJENSEN.aal.scsc.local>
 <20260408114731.GA289215@fedora>
In-Reply-To: <20260408114731.GA289215@fedora>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 8 Apr 2026 13:50:34 +0200
X-Gm-Features: AQROBzD3SaTpXEgUKSe05g2G8IQVRbvqgQ9DX-pYnxfqu6ACGEDQF26qd3sGnZw
Message-ID: <CAJqdLrpofM1tdQmvBODGD+dUah6Lk68CA8y0sVShV-6X=aVrGQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] hw/nvme: add migration blockers for non-supported
 cases
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jesper Devantier <foss@defmacro.it>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x129.google.com
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

Am Mi., 8. Apr. 2026 um 13:47 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.com>:
>
> On Wed, Apr 08, 2026 at 08:32:38AM +0200, Klaus Jensen wrote:
> > On Apr  7 20:39, Alexander Mikhalitsyn wrote:
> > > Am Di., 7. Apr. 2026 um 17:34 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.com>:
> > > >
> > > > On Tue, Mar 17, 2026 at 11:27:05AM +0100, Alexander Mikhalitsyn wrote:
> > > > > +static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
> > > > > +{
> > > > > +    uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
> > > > > +    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
> > > > > +    bool adm_cmd_security_checked = false;
> > > > > +    bool cmd_io_mgmt_checked = false;
> > > > > +    bool cmd_zone_checked = false;
> > > > > +
> > > > > +    /*
> > > > > +     * Idea of this function is simple, we iterate over all Command Sets and
> > > > > +     * for each supported command we provide a special handling logic to
> > > > > +     * determine if we should block migration or not.
> > > > > +     *
> > > > > +     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is always
> > > > > +     * available to the guest, but if there is only 1 namespace, then it is
> > > > > +     * safe to allow migration, but if there are more, then we need to block
> > > > > +     * migration because we don't handle this in migration code yet.
> > > >
> > >
> > > Hi Stefan,
> > >
> > > first of all thank you for looking into my patchset.
> > >
> > > > What would be required to migrate multiple namespaces?
> > >
> > > It should not be very complex, and starting from v4 I've added
> > > VMStateDescription for nvme_ns, but I'm trying
> > > to be extremely careful here, and keep patchset as small as possible
> > > (and easy to review), because I it is my first
> > > contribution to QEMU and I'm newbie with NVMe protocol. I wanted to
> > > avoid any non-absolutely-required features
> > > on the first approach and then add all extras after and on-demand.
> > >
> > > My current understanding is that to support multiple namespaces we need:
> > > - VMStateDescription for nvme_ns [ done ]
> > > - add logic to handle (NvmeCtrl)->namespaces field and save info about
> > > attached namespaces
> > >   to some temporary field (use VMSTATE_WITH_TMP?)
> > > - on restore we should iterate over namespaces attached and call
> > > nvme_attach_ns(n, .)
> > >
> > > Feels like this is it, but I can miss something. Please, let me know
> > > if you believe that implementing this is absolutely
> > > required and I'll look closer and add this in v6.
> > >
> >
> > I do not think multi-ns support is a hard requirement. Multi namespace
> > support is among the features that are mainly used for driver/host
> > test and verification purposes.
>

> Adding it incrementally is fine as long as it can be done in a
> compatible way. Most of the time that is possible, although adding
> something in a compatible way can be more complicated than implementing
> it from the start.



yeah, I understand.

>
> In this case it sounds like the extra state can be added as a subsection
> and it won't be too complicated.

Kind regards,
Alex

>
> Thanks,
> Stefan

