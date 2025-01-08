Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82DFE77197
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 02:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVLzY-0007qe-0Z; Tue, 07 Jan 2025 21:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tVLzW-0007qP-3e
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 21:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tVLzU-0005k2-IX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 21:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736304014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOGxQw41GnUX9dD5EXoyZr3lyow8GwrF2BwB8YaAuy8=;
 b=Y398WUIKKt/4nCH+38OiP6W4k8Ytx7NowpyIcu/7wiexvQXTBCxv6gSRkoVPHVD7Cmu3df
 wU+E1iI5qFh8XBfZJdYvDUmUOSugYAN0Pb4QiUftuxibTbHbD3Y9BKr970s2ucm+a6s6i6
 Sf+gtrtCuPHdnEuEk1bLjFkXYzIxtDA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-SF7wKyYIM4mrr4KlBJaT2w-1; Tue, 07 Jan 2025 21:40:10 -0500
X-MC-Unique: SF7wKyYIM4mrr4KlBJaT2w-1
X-Mimecast-MFC-AGG-ID: SF7wKyYIM4mrr4KlBJaT2w
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-21648c8601cso198285575ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 18:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736304009; x=1736908809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOGxQw41GnUX9dD5EXoyZr3lyow8GwrF2BwB8YaAuy8=;
 b=peH7MoZZmZyZwtV+tIz7Qa1nST8uJPg0wJxAcJUx0a+K8Zy21f69UeV1L00uEDOJWt
 LBl3ZT/0x1n84qaHpWjYAY+AzdJ17Xnw0NdEHuJ6Gl/VPhuqrGK/DTn34u91w22lQMcv
 G5eDMrojdkgDuK04A2aObCbAR0LuCToFAyI/oIeGFh9uDfagQVff4+01hwOHrdm7n3rG
 iJz+7uJLL7BITPGVtgMAQL+lkkT6wVTEcSziA6GMmbzG0S/A0Q1haAWGwXVdlJtQ0R8U
 BbVG17OJ1p393ALpGSI2gsfemQIP3/35cvljJTLNGYyfo9lP9yeuv8UvDuCtlwAKvQH5
 P2Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwxX8KvuUTi0E5cXwP/CZg2v6v3MVkhupVNGf/79f+yNfLYLD52l9WHr5lDejuohkFJrwEAGNAZ1BP@nongnu.org
X-Gm-Message-State: AOJu0YwfrEkpq3CRhBh8CJY8J8optj81aw9Csp7ttVvg/DzifJ0B8yPc
 wE8LnthE037Eyz+lvyAXHJ5Y1R2AKHO2vCtYbKpAvAZ2rHX5WcPwu5WDoMPKIuaCvjRGcAVTVhG
 eb8981Wb1J/i3X4CuOnI96+VV3B2gb6vRbqSkLrfK7LEARdWR+HQeXyX1+Dm8pFZBXyO/NY8O+4
 N584RBlQLk+3ySqmAFR1QDOCd26zY=
X-Gm-Gg: ASbGncullwisgdFLhP8bKYhfi83c6wqbZMWmhOKwkWUCAklGHOuYF+qS9I8Xu06YEXL
 /TjWdzRBg1gsbLcEU1z/hJIsfsr1BZiD9vpzdcgc=
X-Received: by 2002:a05:6a21:7898:b0:1e1:ae4a:1d50 with SMTP id
 adf61e73a8af0-1e88cfd3cd9mr2671872637.25.1736304009062; 
 Tue, 07 Jan 2025 18:40:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoSmTia/xO/ku0TZt1PxPpohbTQXs1CMJ80ggh89U5UpcNeO/+OjzbMW9wEV2MDKoYnH7mSrnIDdQEGcgdcx8=
X-Received: by 2002:a05:6a21:7898:b0:1e1:ae4a:1d50 with SMTP id
 adf61e73a8af0-1e88cfd3cd9mr2671832637.25.1736304008616; Tue, 07 Jan 2025
 18:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20250106155737.976977-1-jonah.palmer@oracle.com>
In-Reply-To: <20250106155737.976977-1-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Jan 2025 10:39:56 +0800
X-Gm-Features: AbW1kvZns1q9sdA-0K3oQrH9E8lNif4dBeWF3dzJBS63i7C1gX8WRJaOlSIqwTE
Message-ID: <CACGkMEu1-SccNTxd9EXuAa7TpgeQFCosGYO7D0csjMepi1m9Ow@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Move net backend cleanup to NIC cleanup
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: eperezma@redhat.com, qemu-devel@nongnu.org, dtatulea@nvidia.com, 
 mcoqueli@redhat.com, mst@redhat.com, si-wei.liu@oracle.com, 
 qemu-stable@nongnu.org, leiyang@redhat.com, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, Jan 6, 2025 at 11:58=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> structures if peer nic is present") effectively delayed the backend
> cleanup, allowing the frontend or the guest to access it resources as
> long as the frontend NIC is still visible to the guest.
>
> However it does not clean up the resources until the qemu process is
> over.  This causes an effective leak if the device is deleted with
> device_del, as there is no way to close the vdpa device.  This makes
> impossible to re-add that device to this or other QEMU instances until
> the first instance of QEMU is finished.
>
> Move the cleanup from qemu_cleanup to the NIC deletion.
>
> v3:
> Remove shadowed declaration of NetClientState nc variable in 2/2.
>
> v2:
> Remove NIC peer also at net_cleanup. vhost-user trust all the
> backends are clean before qemu removes char devices.
>
> This is not a requisite introduced by this commit as
> system/runstate.c:qemu_cleanup shows.
>
> Eugenio P=C3=A9rez (2):
>   net: parameterize the removing client from nc list
>   net: move backend cleanup to NIC cleanup
>
>  net/net.c        | 44 ++++++++++++++++++++++++++++++++++----------
>  net/vhost-vdpa.c |  8 --------
>  2 files changed, 34 insertions(+), 18 deletions(-)
>
> --
> 2.43.5
>

Queued.

Thanks


