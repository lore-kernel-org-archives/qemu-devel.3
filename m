Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F93C282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhfz-00039w-QR; Thu, 27 Feb 2025 12:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tnhfp-00030G-3H
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:27:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tnhfn-0007Nj-Hm
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740677264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uC0pwgrzKHTG7DweqtpRl58oo7lJOV2lIkzcVgWy6/A=;
 b=BbfNEhohec+zaHVJy0pVSgt3tew/QUVUKu7cu0+Y3XcFdzR4THjG+fPqhdbczEFJu2fTtr
 KriamzX8sA33X0fZ/UzhWlMqXEp9LRj08mTyB4bv2RrJmMTLpGy1xHrMHgVz9LaJjL2gl7
 D0LWC8EKcntCoxWMsgYP5J9wkZlThow=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-VXwp1axNOb21f5UZPqOOjA-1; Thu, 27 Feb 2025 12:27:42 -0500
X-MC-Unique: VXwp1axNOb21f5UZPqOOjA-1
X-Mimecast-MFC-AGG-ID: VXwp1axNOb21f5UZPqOOjA_1740677262
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-855a922b214so19452739f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740677261; x=1741282061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uC0pwgrzKHTG7DweqtpRl58oo7lJOV2lIkzcVgWy6/A=;
 b=wU6yUQ9JJ6BHBaA2aXHyLiT7vY1cyGfPhMaPi0SDiiio0BHYdoSSJEGdtWETNUWMX+
 hkkL6aX1M7eTOVoNVWRIm1KEnLCzO7+ZtjxWsEzQEvZH8r0Gtr8x2m8kr4wLm4qA62hb
 9fVwpncP0G5ikovik3BAFoiKSE/iLUadoea7mJH5wqeMB0/orMiKvq3te14IdfqXUdYB
 jItZ1m61EHIbNzKfXxj0L5YgnRFJ1lG9J9fgcilai5K0iP/CUeOqIF/QJ/AmHUB64djq
 ZqzBMEiRMGtJOOxUMZP3I0pc9Z/pj+vTvAYYWo7VRVDHaYVtoMGBYU4T+s0LqvzDrdO3
 vu7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjLY46ZYF11JzwFE5EQdCekt8c5ggmxfsnb4wfOKSYswnqbhBHvCgagW8vrACvP/qUC+RwJPo0V8pJ@nongnu.org
X-Gm-Message-State: AOJu0YwCqMnCnql5QgE3/aq2nlYuyXlxeOzJ4PFjRqsn4t4sbF2Yc/Y4
 aeLbfEWI/CA0JDrxoB1klIKGjbDVCJ+jGs5vBABMnnnvr3STCR1HQ3OVJbfHM9M3CKBQAPXwVIK
 I12b13MTKvKwYA8fMom39n7MXHqCzhPliSAZUe1RYCyOYMuNAIhaJ
X-Gm-Gg: ASbGncuv+OxGl8QehdPYXsAMFmoftjCPg5yx3aGSJS5iBFFadxBSi+Iiu/dFeB08w00
 qsKNA93P8RQkD7cXa26ZrkOZX0rUWlmYYm/2Py89xINp/Bg/Y0Gx/4eOReOcppmQzrbhaV+B/UE
 zt5gRCewxi933GKJQU0kXwhFoDb48idfiR6jdsWDyOIOZyeVeCihujufq2G3T2u7Ei2klbn/EmR
 d1MCnkVeGjDetiasIJLQn57+WO5wIAxPAm+CCr8drNpJc6NScGL0buJMS3RsOuKUmxnevTp0VLo
 mXfQm8Oaz5IIXUHX9s4=
X-Received: by 2002:a05:6602:1593:b0:855:c476:8b89 with SMTP id
 ca18e2360f4ac-855da7d9dbdmr800123739f.0.1740677261637; 
 Thu, 27 Feb 2025 09:27:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlhryQrGxX2HeKxYDM4qT0Mjg635a9DQNe+OIH9k67q9wd9HU18tTuMrAUp5XYN0P4MRrPCQ==
X-Received: by 2002:a05:6602:1593:b0:855:c476:8b89 with SMTP id
 ca18e2360f4ac-855da7d9dbdmr800122839f.0.1740677261332; 
 Thu, 27 Feb 2025 09:27:41 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061f39017sm452554173.76.2025.02.27.09.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:27:40 -0800 (PST)
Date: Thu, 27 Feb 2025 10:27:37 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Will Deacon <will@kernel.org>, Peter Maydell
 <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/2] vfio: Make vfio-platform available on Aarch64
 platforms only
Message-ID: <20250227102737.197ab32b.alex.williamson@redhat.com>
In-Reply-To: <291bf12d-18bc-444f-b09d-3fb80e0f144a@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-3-clg@redhat.com>
 <291bf12d-18bc-444f-b09d-3fb80e0f144a@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 27 Feb 2025 09:32:46 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Hi C=C3=A9dric,
>=20
> On 2/26/25 9:47 AM, C=C3=A9dric Le Goater wrote:
> > VFIO Platforms was designed for Aarch64. Restrict availability to
> > 64-bit host platforms.
> >
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com> =20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>=20
> As an outcome from last KVM forum, next step may be to simply remove
> VFIO_PLATFORM from the qemu tree.
>=20
> We also need to make a decision wrt linux vfio platform driver. As I
> can't test it anymore without hacks (my last tegra234 mgbe works are
> unlikely to land on qemu side and lack traction on kernel side too),
> either someone who can test it volunteers to take over the kernel
> maintainership or we remove it from kernel too.

I think it's more than just a kernel maintainer stepping up to test,
there really needs to be some in-kernel justification for the
vfio-platform driver itself.  If it's only enabling out of tree use
cases and there's nothing in-tree that's actually independently
worthwhile, I don't really see why we shouldn't remove it and just let
those out of tree use cases provide their own out of tree versions of
vfio-platform.  Thanks,

Alex


