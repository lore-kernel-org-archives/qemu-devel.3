Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7724EC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 15:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tma5A-0000uA-8l; Mon, 24 Feb 2025 10:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tma59-0000ty-En
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tma58-000388-1A
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740409756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AnaJftMFclCrSxC5aUGg1BtFa2lSpRNBENTROrZlrPQ=;
 b=E2UJwUTe/MlKwnUYDuSNdwXZpi4+seo8Yj1AKTcDr+JgZQ7qDyr6ZmXbj1cAd3eW25TiGp
 FPBL4dXwPWRzb0MJnlbQ5FSWniAcj6TJQxPsADi3TdNooBZT4w2t2GEhLDCu/T28QP2Ze9
 6uLdw/9K2gezBuJOvN9PaXFb3pSfhrE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-6F8mEdKCMou9ktLq-5uv0A-1; Mon, 24 Feb 2025 10:09:13 -0500
X-MC-Unique: 6F8mEdKCMou9ktLq-5uv0A-1
X-Mimecast-MFC-AGG-ID: 6F8mEdKCMou9ktLq-5uv0A_1740409753
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3ce7aa85930so3780075ab.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 07:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740409753; x=1741014553;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AnaJftMFclCrSxC5aUGg1BtFa2lSpRNBENTROrZlrPQ=;
 b=q2LoTzuvMrZenIAUwap/0sBwj9df4KNVjl1MIs9T6ULBTwx4EaAe0d21TGPlDrU7GG
 GcNnhjOc6W47374n5PwP+ElME3vYzz+rIyvNxg9zs8PEIbj5sf8L6OVlSLROQYteLNcg
 29v1Wm+IaM0LsWgIk+x4SRCB2b7tgQviy8K8ayBUWys3YiB2AiPsQIQirkwbh2bcnZTH
 WJk6cdcSVeoux7VkGGtLzuMqf3/TgQP57AsKN4PLn+VZzCYJL6NpgHadhBS3Pcik7wvZ
 PKYYO6gJv1ASdNQV/PsgrCRM3dGmRCR/2ciBxYSeSV1CKZ0DMMHx3vBTeJOmVNbnnRx/
 C8RA==
X-Gm-Message-State: AOJu0YwCiJGAcaMoH/e8zm2R/s7+0fRQ/g42a4V9mmUtSqH5j/Ilc2Pu
 BbnTTOyI9+ia16iup+MsDwR0NohUThATq4JKknKg9clvA1svqZi55CytAnQxYN3aEvDS819SE0D
 vjBKLiYoy1LBgnZwJJhrleYY7HTNbqmdiCTdNy+wHT2FiUn/5eRfl
X-Gm-Gg: ASbGnct6CusnoQFnI0sj2FhlMAlzAZa40xgYfNQQiXs5//bid+v2gksuHOcqU7ouDgQ
 YGOgndFTtlniCiue69fqrMyfurc5cy7H20aOiLhpVZMlnEniFtOsYuB7FpYI/2AWXYZcQwueBJX
 gjNMOzRpeMogHAiF8BjBSa6mtY65AvcsMnKRXmAryHwoE35mRV4B5rk9J+6YFGbOBa6uXfBJZNU
 eflc1uvEfmNQyzoQPfdakjQTc5KYWKppKRsqNdY1KEyyP4N38wn1l0gv3wDz2Y4vY9bYG1zn7/Z
 9GNU3HjOLnQqjjuwojs=
X-Received: by 2002:a05:6e02:1646:b0:3d0:4ae2:17b6 with SMTP id
 e9e14a558f8ab-3d2cad72c9fmr35205445ab.0.1740409753104; 
 Mon, 24 Feb 2025 07:09:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBHYYLl8fl9qeOVd9G2tLtpzjtBoicEtCsO52ZKmI/sBVmD/sHYTr3x/FH1gWDnvU2qQ7u7w==
X-Received: by 2002:a05:6e02:1646:b0:3d0:4ae2:17b6 with SMTP id
 e9e14a558f8ab-3d2cad72c9fmr35205365ab.0.1740409752802; 
 Mon, 24 Feb 2025 07:09:12 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d18f9d5c01sm51596725ab.33.2025.02.24.07.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 07:09:11 -0800 (PST)
Date: Mon, 24 Feb 2025 08:09:07 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger.pro@gmail.com, eric.auger@redhat.com,
 zhenzhong.duan@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: Re: [PATCH 0/5] PCI: Implement basic PCI PM capability backing
Message-ID: <20250224080907.3647dac8.alex.williamson@redhat.com>
In-Reply-To: <905d2fc4-c537-4c05-a759-6434af2b4406@redhat.com>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <905d2fc4-c537-4c05-a759-6434af2b4406@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 24 Feb 2025 09:14:19 +0100
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> > An aspect that needs attention here is whether this change in the
> > wmask and PMCSR bits becomes a problem for migration, and how we
> > might solve it.  For a guest migrating old->new, the device would
> > always be in the D0 power state, but the register becomes writable.
> > In the opposite direction, is it possible that a device could
> > migrate in a low power state and be stuck there since the bits are
> > read-only in old QEMU?  Do we need an option for this behavior and a
> > machine state bump, or are there alternatives? =20
>=20
> Should we introduce a migration blocker when a PCI device is in low
> power state  ?

Blocking relative to the power state of a device seems relatively
non-intuitive for a user to debug.  Logically there's also an
opportunity that any device could support migration while in D3 if it
indicates a soft reset is performed on D3->D0 transition, regardless of
underlying VMM support for the device to migrate.  So that doesn't
really feel like the right approach to me.

FWIW, the emulated igb device will enter D3 when idle and bound to
vfio-pci in the guest, so we should be able to test migration in
various states with purely emulated devices.  Thanks,

Alex


