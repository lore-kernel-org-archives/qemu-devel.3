Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9A2FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABQW-0002P1-1Z; Tue, 07 Apr 2026 14:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wABQU-0002LR-2Y
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:26 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wABLJ-0004Sb-D7
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:40:07 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a2a70bb66aso5169977e87.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 11:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775587202; cv=none;
 d=google.com; s=arc-20240605;
 b=cGb46psBYSH+EW5G4Wh6LihCc+OwcrDL1yAY8ynVyschU4JZMHk+6Wca639WcWGj8M
 RoKgHtBTtl1USwMdOjLOY/gsWejvX/JDSs6uW0LEVBpoE8pLkIz3HraL90rdMyYLpQFZ
 TN+2QMTHOqpEQiqFKaNR4m8Bj1jL8oKttM4/fpvMPrrjyUTYbDKhSUBXVmsOqyQbMXdu
 Upi6YOTo93fwdaXpk7VdDsrUPKUlOSpbgIluUFDPoC8jc52duVus6L9mlS/sTiQ0ozWK
 UgGGKnfFcVqH9WSpEPjUnV5niske8DDp0rcM/q9eqhM5cJwhc4JE+j1br9Ps0kgoJEm4
 GgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=blbjAKQGlSrDyH90YVt3oPB63zyz8GaSZA3XvZBZq8s=;
 fh=j8cjR5BSdb9oxrjVMaCJViji+r96qovWS4bV9/nXBtU=;
 b=WyDWUB9JP+faTU7N2pueQO4zfPrr0Z+Pk2JTj1o8voh8VmABGc0IoK+ZHC9hDjiV20
 hKQm3Gl8X0AwswjGiqEyDd1Ijig/oK49km5CqE5k/VAsQq8ihesoa+1AvKyf7WnKOpEz
 gLboapYJM7+T/M5v7eAsV4XCDk8/Z8MtxTVOb6BGvJqYpY1xIWZf6Y5TcHRhp7IebBF9
 ih6mD0XCgW/5KQMycKkmoqYAjZlLw0MJXt8u1BEArHqCo32C2ytY9tI6iQvQ1zkcqB/0
 muGodqP2KX9fky4yMrBlMLRa4QG5jpi9bXfmGps47IVItUwvAvNUKa2PzZY8SXF4/CG8
 k3sQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775587202; x=1776192002; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=blbjAKQGlSrDyH90YVt3oPB63zyz8GaSZA3XvZBZq8s=;
 b=fB0x8YY12wJ3jQYhAEbVYLwRR9MtmeRJyUBgVmCOfrLRLztSZagky9kqxG1xzxr+RK
 hTY2GhtgGXZCFcsdHPf3CIDTQX7TmzBs9OSt+M2wMbgVWVS+CMPOG8F+pUJEds3aF5fz
 RWQyD3z5+IF0wp1T9BwqjIv6sBgv1c2NJIj9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775587202; x=1776192002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=blbjAKQGlSrDyH90YVt3oPB63zyz8GaSZA3XvZBZq8s=;
 b=LSkxFiwSteeNys7ra2FUTA7QkEfXDyXLOZMoWgm0iN2Erojfg53KcW7SAI1BkeudNh
 VS/Ji9tjoJX0K2N+7+OvyBYeoY2Tfy+rXxZ5EkSvrHkaGmHfss01/stf681Mdqb7Slgu
 vGuXmEc8zn0xQCLExNz7NeWD7O3mkboMiMsMfGL/8xMXegP2y6Ot8LswfI3CplhJkX0w
 gYLEtUPOw48aOrhNYyPu00s3H31iNnoOtFz9t6GVrF9BPzMRId+X9l8nfbiQaJH6bfmE
 H5D1DY+5fqiloAry3PbfNJMmU//60xvDJagjwgYtKUy4B5+vxsZnhtDkAQQ5JLy9KPl2
 boIQ==
X-Gm-Message-State: AOJu0YxeqOKyQmg/8cQ0A6+l2Bwd3AvHGaxRMzgOH7IaKCnd5s8KHRaa
 JiBnctXCzv/gvMhANTDVdCxywDbhQeiKG50yV0Hk/bTasr3Jn67x7o0uUG8nksksX0hHs6/Xoa7
 oUMwL1DjPQ+Gy20MDFWv1JDy/gUYdAtF6XaLepu3fxg==
X-Gm-Gg: AeBDies4xvJXcuUNUBGUL+1rwksTeGHkY5MdihMyhzMsfXeUYy8wkn5LdXkTTXozNa+
 wuvVCFj/xT2kYvBakNiULDFWDjeOPjr5saQ/oK3TbsajWWs9WGoJhUxuQhcEFE3lcoodE0HVEnU
 faQdEaeQc/oCeTLc9lrI/TcWnnqlA7tQHyaiHZblwTknU8opGj0wyq3pJFvAS3ZUwVIGUEoVH6D
 RnujLFka8izj+8bWOMVlwl2fnhVpcfLf5L0pXA42jw2bvphf6CVgEdXktQ+iAJJFHo1r8jkH0Rg
 FmznK0Kgt/nM7eiWhqg=
X-Received: by 2002:a05:6512:3b9e:b0:5a2:9cb4:9729 with SMTP id
 2adb3069b0e04-5a33754eedbmr6624956e87.2.1775587201817; Tue, 07 Apr 2026
 11:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-6-alexander@mihalicyn.com>
 <20260407153426.GA238768@fedora>
In-Reply-To: <20260407153426.GA238768@fedora>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 7 Apr 2026 20:39:48 +0200
X-Gm-Features: AQROBzCd7WQmHJ9DySlXO58mldofN7JbB_WmD6KpsLT4DHXImMO450s8xJq_fxk
Message-ID: <CAJqdLrpzZjs0Zf52sB0R149D6hCVYEDqAW36BYAaPW+uhK=g6A@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] hw/nvme: add migration blockers for non-supported
 cases
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12b.google.com
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

Am Di., 7. Apr. 2026 um 17:34 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.com>:
>
> On Tue, Mar 17, 2026 at 11:27:05AM +0100, Alexander Mikhalitsyn wrote:
> > +static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
> > +{
> > +    uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
> > +    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
> > +    bool adm_cmd_security_checked = false;
> > +    bool cmd_io_mgmt_checked = false;
> > +    bool cmd_zone_checked = false;
> > +
> > +    /*
> > +     * Idea of this function is simple, we iterate over all Command Sets and
> > +     * for each supported command we provide a special handling logic to
> > +     * determine if we should block migration or not.
> > +     *
> > +     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is always
> > +     * available to the guest, but if there is only 1 namespace, then it is
> > +     * safe to allow migration, but if there are more, then we need to block
> > +     * migration because we don't handle this in migration code yet.
>

Hi Stefan,

first of all thank you for looking into my patchset.

> What would be required to migrate multiple namespaces?

It should not be very complex, and starting from v4 I've added
VMStateDescription for nvme_ns, but I'm trying
to be extremely careful here, and keep patchset as small as possible
(and easy to review), because I it is my first
contribution to QEMU and I'm newbie with NVMe protocol. I wanted to
avoid any non-absolutely-required features
on the first approach and then add all extras after and on-demand.

My current understanding is that to support multiple namespaces we need:
- VMStateDescription for nvme_ns [ done ]
- add logic to handle (NvmeCtrl)->namespaces field and save info about
attached namespaces
  to some temporary field (use VMSTATE_WITH_TMP?)
- on restore we should iterate over namespaces attached and call
nvme_attach_ns(n, .)

Feels like this is it, but I can miss something. Please, let me know
if you believe that implementing this is absolutely
required and I'll look closer and add this in v6.

Kind regards,
Alex

>
> Thanks,
> Stefan

