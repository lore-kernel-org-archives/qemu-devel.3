Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AEFCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 16:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzdv1-0002Uz-L3; Fri, 19 Sep 2025 12:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uzduz-0002Ue-AX
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uzduw-0007yQ-Ek
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758299095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRUAEAWt3oXjfTnzOYFiDniOxVnX1UjTQK/4wQnwtaM=;
 b=bWQw402PNs6deG/Kdne9wj2M/ylIvnsCytPaceyK0XdyGca5bwURLJSMbUsJQee1DhL4DX
 LDgYfWwvlz2sF0S5CKZEN1WoXfRQyPBB6xAMQfHWv5vI7l1QKBjzMZVsOf93lScM3aQnOo
 LrglbS5miyI1e9FfWcdEjEh/4OiNK1U=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-bLUxeY2bO0iGuVmBX-2pxw-1; Fri, 19 Sep 2025 12:24:53 -0400
X-MC-Unique: bLUxeY2bO0iGuVmBX-2pxw-1
X-Mimecast-MFC-AGG-ID: bLUxeY2bO0iGuVmBX-2pxw_1758299093
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-4240abfbce2so4041475ab.1
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 09:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758299093; x=1758903893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRUAEAWt3oXjfTnzOYFiDniOxVnX1UjTQK/4wQnwtaM=;
 b=U6OsiIKdbF/bNa9JlfHcPbEBxMUUX17Bah1nlNpaV1whDBJyrwAFAWpVGZrtRbXqfS
 P+3JOM8XB2D2VWXliMgl5PawxFsLvP1X11xDGVptqVl3A6pRcK0i6HvKtiMQ8hJ5oYaQ
 7wSLp9ZHLDTi4kYMNn4KjfLm0DG3eguCSwRwIC9IO2ym9pK9URPnlp8oJg/lLjwsoSZ/
 XvjKmLI9RywBNlfVG70tYHZx0Nkrr48bcqsemu3ICBnhbnP2qjnuog7HS5zUBADbJegK
 j7L5v1mQT9gqYkh0WPp54UvqOs5C8TC4vXTXVEVkjY+q99v70pqqWjOBMzXtUfmhxf5T
 ZsSQ==
X-Gm-Message-State: AOJu0YxY8myGedbpQmrl5ZsR0drX43GiXjsqbfopS3rekQQ8atQjqKZn
 R+oHDDafhryBFpAJ+z8VQbmh4HAE7nfn8ffq6X/420gfafWRF2GRFK2ERPcJ8yNWzqMayKZrLbi
 uAQz6ZzSOfX39Qi79aKFDYPylJfYZxXzKvsZczEUup2sJgoQJPWxUNoqm
X-Gm-Gg: ASbGncsPgKIKc/Tc1Z9bLvSgqVmaTi29MJ5VyuwRZTw2XU/6rf34NsrsGgZYEDSqS0d
 MfYu3x43/PF/ve1PoZ1bCdTMQ0hqY9Y917Tfsqvz+S3FZVX2d9sH+PJtis9guYU4bxeWshb6HzX
 34C+KHu1CNznOiR1ntSCvCHUX5DFHpU5g6Mfj8NE/7Pb8D426TD09nyZgb/c134IPZHd6WCbDfi
 J1M2AlHOjR9TWG4itimCfgDMuBvLLLXqr56GPK5TQBPd84862ANoXL+tfQUxYM6qtQ840w3yWzp
 gcq0s9H6zYXL0pb9+egQX2zvUnrTpYfKhHw3rYe2PUo=
X-Received: by 2002:a05:6e02:3786:b0:424:7ef5:af5 with SMTP id
 e9e14a558f8ab-4248187d2fcmr22705775ab.0.1758299092735; 
 Fri, 19 Sep 2025 09:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7KpOGQ3786XuDFNM7xxyrFt8OQu+ItxeJ4xEeATgRnvr+l5tM5giacr/f3azmIlONB/adig==
X-Received: by 2002:a05:6e02:3786:b0:424:7ef5:af5 with SMTP id
 e9e14a558f8ab-4248187d2fcmr22705625ab.0.1758299092286; 
 Fri, 19 Sep 2025 09:24:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4245169ea7dsm23171505ab.18.2025.09.19.09.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 09:24:48 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:24:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com
Subject: Re: [Qemu-devel] [PATCH] vfio/common: Work around kernel overflow
 bug in DMA unmap
Message-ID: <20250919102447.748e17fe.alex.williamson@redhat.com>
In-Reply-To: <cd287f5c-796e-4172-9537-b00991a95391@redhat.com>
References: <154707542737.22183.7160770678781819267.stgit@gimli.home>
 <cd287f5c-796e-4172-9537-b00991a95391@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 18 Sep 2025 22:55:47 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> Alex, Peter,
>=20
> On 1/10/19 00:10, Alex Williamson wrote:
> > A kernel bug was introduced in v4.15 via commit 71a7d3d78e3c which
> > adds a test for address space wrap-around in the vfio DMA unmap path.
> > Unfortunately due to overflow, the kernel detects an unmap of the last
> > page in the 64-bit address space as a wrap-around.  In QEMU, a Q35
> > guest with VT-d emulation and guest IOMMU enabled will attempt to make
> > such an unmap request during VM system reset, triggering an error:
> >=20
> >    qemu-kvm: VFIO_UNMAP_DMA: -22
> >    qemu-kvm: vfio_dma_unmap(0x561f059948f0, 0xfef00000, 0xffffffff01100=
000) =3D -22 (Invalid argument)
> >=20
> > Here the IOVA start address (0xfef00000) and the size parameter
> > (0xffffffff01100000) add to exactly 2^64, triggering the bug.  A
> > kernel fix is queued for the Linux v5.0 release to address this.
> >=20
> > This patch implements a workaround to retry the unmap, excluding the
> > final page of the range when we detect an unmap failing which matches
> > the requirements for this issue.  This is expected to be a safe and
> > complete workaround as the VT-d address space does not extend to the
> > full 64-bit space and therefore the last page should never be mapped.
> >=20
> > This workaround can be removed once all kernels with this bug are
> > sufficiently deprecated. =20
>=20
> Have we waited long enough ? what does "sufficiently deprecated" mean ?
> Is it related to the linux stable updates ?

It was fixed in Linux v5.0 and I believe the oldest LTS kernel is v5.4.
Therefore I don't think that upstream QEMU really needs to continue to
carry this.  v4.20 was the current upstream kernel when this was
introduced into QEMU.  Thanks,

Alex


