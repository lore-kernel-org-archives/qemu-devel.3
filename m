Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6677ECCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 04:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGrGA-0003UA-Ut; Wed, 05 Nov 2025 23:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vGrFx-0003N4-B4
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vGrFv-00010V-0g
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762401949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLCHF2XuXvn0xb4ZmI+5MP+bJp3VZCBuyiVnUCjv2P4=;
 b=ElA1F4yS7lYTmNOOkQG9+myVLP/jgbmZEhDKlrhGxO00GdGTUUDveE192vz/jDIt4X55hr
 vhLjQBwXcrgDu1t6HUEO8tKxHKuLHEpJiYvzyyNmQKBfkziF89xAKI2Q7ikXKBeU22JpNK
 i7xkc9EODQQYUa99G2sQnaXezpdIv0Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-sMIaLFGON_WElXzPrTKxQw-1; Wed, 05 Nov 2025 23:05:48 -0500
X-MC-Unique: sMIaLFGON_WElXzPrTKxQw-1
X-Mimecast-MFC-AGG-ID: sMIaLFGON_WElXzPrTKxQw_1762401947
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29557f43d56so6996725ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 20:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762401947; x=1763006747; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLCHF2XuXvn0xb4ZmI+5MP+bJp3VZCBuyiVnUCjv2P4=;
 b=cMhQep8wlOFdF/BBVxyamwGCKSdy2H5uZ8BKMJBgMr7+D9yO/opfICLmHbXEtSlEDR
 kNy3sdXFOZITyd2kbxkjbXtjYSAgE6MCNIprG0uVfGU/jD1UmlReFCqvZp9nS9AfQicE
 YLZxcetQuY23M88grVfTVXy2OeaeejGaAazYpB5LUTHCtRnyY0xhcolt1vc57CBxX7Ab
 nO2ENZxwet/2UsYuP3GxmEex1LRMdKDwN2d3v34vC577a8YZTxDXgcXnSoDqyN2FGgeO
 8b3jg5f4qy4TGgMx4+oEOVhRq/TLP4T4meaUpho/rSxYqSRfuqkYX9yiVhW8WWyMWmnv
 qCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762401947; x=1763006747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLCHF2XuXvn0xb4ZmI+5MP+bJp3VZCBuyiVnUCjv2P4=;
 b=tfHtsw8laf20zhz20+aLBDuGXxsD6srMZnTu9WGa+b8M09q1QN6E59Eoi3zaKvt0Mj
 gKEHfNfGfiE77qmjEtGJpqdfYyqCpOAdaG4plqJAU62pirPzP+2Xx3HJtoDDb7k0S0AF
 oyUHIWOYF7SlGbgrRn0YVjNnVCEwgm7mTxGOzcFeG7DtB6hEPmhHqEXObinFYHbkbi0q
 QGnrQKux/kwyLcQyyPgvZSudYGPYP3CTACmaHkxjWR2y8LuJEXopAunoD/U78nd7fImH
 RKDtjE3IhWExmitp6ffDRGb5NUFnc/4eOUOEQw9l6oojuO7WNscYEeRsw/VhiBJ9pxko
 MX8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBdClMLBzzrubpyXvibXI5vU9naCjnZipLdNadonp8NE2ypXQZR8poMUu1c56R1YDTCGfJZf4NJ3Qc@nongnu.org
X-Gm-Message-State: AOJu0YxHJu1MmQLxyqpkkGWjWdn/868SeZ/Qnz1/OFrbhH/E1UwHizHA
 dtlObvvCrdLAeZ9kOrlj7dI4JWSNQRV88upgILe1/NpolPi7j5FwGnzUq0vTeVY7jo+91h632nH
 XBTgqWizTK+b95RFctINlIc0tmg0+BrsgzlBrdAJ3VlqBeaJzwCKN06+ZgSOavNO/AsPIM4WLnd
 RbjRmT709+YpB2RiFiUNl53CFD5bnNzX4=
X-Gm-Gg: ASbGncuKX+d+2v1K5QyJDtGPFpqzb8USSERVtfSiffCHGwHz7VJeE6Fc38wdHfAOaKL
 odLiPMiX/I7mZ6deYERcXPQe5YTWFIBWGTOjQAZSNh0Bi0OKRxPwu04xeys+pgTQxEHUVUO9K1h
 9OCDvllaur/ZMv4vfTgB5ET31412RPFe2FBxNMnOcnxhvIt1ehWvN2v0cn
X-Received: by 2002:a17:903:228a:b0:295:9b9a:6a7f with SMTP id
 d9443c01a7336-2962ae755c1mr83045395ad.49.1762401946931; 
 Wed, 05 Nov 2025 20:05:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjBqG+gRyEo1DCsgmusQT446k5ZvcUx4Divd46fkn5cG8qjad7VINwbtHSLw9Vq08kxm6GF0MX8QTN5Lv34bA=
X-Received: by 2002:a17:903:228a:b0:295:9b9a:6a7f with SMTP id
 d9443c01a7336-2962ae755c1mr83044985ad.49.1762401946512; Wed, 05 Nov 2025
 20:05:46 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
 <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
 <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
 <aQvM6l04VeZwbUOf@x1.local>
In-Reply-To: <aQvM6l04VeZwbUOf@x1.local>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 12:05:35 +0800
X-Gm-Features: AWmQ_blKcIbPAd040m9YsABFslwarM5beCY1vPbhd2M7AvT2AYhwZEpSBqZR2Qo
Message-ID: <CACGkMEs4ES0a_Dzn7LmnthGuL=96XxOmncb5VDV195cxWTCChg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8?=
 =?UTF-8?Q?=2E2=2E10_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESE?=
 =?UTF-8?Q?T_=2F_USO_features=29?=
To: Peter Xu <peterx@redhat.com>
Cc: Jinpu Wang <jinpu.wang@ionos.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

x

On Thu, Nov 6, 2025 at 6:17=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Nov 05, 2025 at 10:27:59AM +0100, Jinpu Wang wrote:
> > > > These are not present (or not supported) on QEMU 8.2.10, which caus=
es
> > > > the migration state load to fail.
> > >
> > > Interesting, we've already done the compat work:
> > >
> > > GlobalProperty hw_compat_8_1[] =3D {
> > >     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
> > >     { "ramfb", "x-migrate", "off" },
> > >     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> > >     { "igb", "x-pcie-flr-init", "off" },
> > >     { TYPE_VIRTIO_NET, "host_uso", "off"},
> > >     { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> > >     { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> > > };
> > > const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> > Yeah, I noticed the same.
>
> AFAICT, this is a known issue..
>
> Thomas and I used to suggest we should not turn on USO* by default by
> probing kernel, but only allow user choosing it explicitly in a VM
> setup. IOW, dest qemu should stop booting at all when kernel is too old
> (when user chose the feature).
>
> See:
>
> https://lore.kernel.org/all/ZqQNKZ9_OPhDq2AK@x1n/
>
> Thanks,

I see, so the reason is that the destination doesn't support USO in
the kernel. For those kinds of features that depend on the kernel, I
agree to disable them by default. But I'm not sure if it's too late or
maybe we can do strict peer feature check like this in
virtio_net_get_features():

     if (!peer_has_uso(n)) {
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
-        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
+        if (n->strict_peer_feature_check) {
+            if (virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_USO) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO4) |
+                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO6))
+                error_setg(errp, "virtio_net: peer doesn't support USO");
+        } else {
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
+            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
+        }
     }

So qemu would fail earlier than fail the migration.

Thanks


>
> --
> Peter Xu
>


