Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC08CED62A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syS9c-0000AJ-K8; Wed, 09 Oct 2024 04:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS9Y-0008WN-Kl
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS9W-0000j7-Kw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728462876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Zi4LPCJ+gFipaWFztHkvBNKM6HH7+/tXxNNMbWDLQk=;
 b=Zz3jOPdZIAA+r7HkHHWFRpHwo66lqAzhzQ9ra5sXbHHMrQc0+9wHNyI/ukiws4YksPq8s/
 hARB3oHhf0VFrIv8jt1iDzEEzfFPeieBK5gl6MH90SsTQeSU9xk7EUXLgiH8RDsL3ttFEh
 v+hAV3tG0Wy56Mt+mLBVq9NZRcE0kYk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-3f4_A3WXNc2JQo1b732bDg-1; Wed, 09 Oct 2024 04:34:33 -0400
X-MC-Unique: 3f4_A3WXNc2JQo1b732bDg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e0d77c602aso6546543a91.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 01:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462872; x=1729067672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Zi4LPCJ+gFipaWFztHkvBNKM6HH7+/tXxNNMbWDLQk=;
 b=g31q80beh4MWGx4qvXqF0MI2kf5Zg89AfqUR2YYyIL9JVrpN8dyueCtCwENStnSY2u
 FDRUd1UATTNcueXwQFCkLWJchFTI5jOIy38jYgROg6b2lerviJOSFDc9wjyVQg93Rixf
 v2H9cISTC1xUSZbIEYZ+NNCQ6+oAPFyJ+Kz/CCgIYYCvk/HIE0x0bngn9D0pyX0hjpCm
 4M8e/x0uR2ywhyHPm9d6QY6rZozc9C+JZY5ePIL2yCUDNZSfaWHde8QSDDrHUcKLL5AJ
 mHSrTkFV1/f0GTPPC4ch9ZY9ZNdEx+hW+z9GuaMU03f5ssa269A4IVnhI4zCIcmlhSGp
 X/vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs38+lruK855bFFzZsWaL0Hem4JthqmIy9zrMGAdtrK+9hX/8lS8T1NMVRcJhgYmh11YzrWyI50wkH@nongnu.org
X-Gm-Message-State: AOJu0Yw3PQTaixYB8ekofGw8dbYYdh5RHzrJtkUw4QsGTNZ4v+j51LFL
 hISJMXvm9pGxS/gzDHqBHG7OTS+J2tXoiaZjN2riypXvUPZZJXjbuZtmjORoU0ZDFyz5nyC9sk4
 ms5cujpsggcH6mTHSwzl9kUQUMFl802DmN3bsmJmRorFw5UaxOnCcOyudz08qESQTpl0Ida2Az6
 4ZojiIlKKQ6AIZkgybcTWhFULK13M=
X-Received: by 2002:a17:90a:a409:b0:2d8:f99d:48d2 with SMTP id
 98e67ed59e1d1-2e2a25546abmr2031537a91.29.1728462871964; 
 Wed, 09 Oct 2024 01:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+DaEzEKHvAZmgXxk3rogIakzH58R6/JVfrGmXdw7KJI47o+cZW0JEaLDv5VvNReNykq65FDQEFidHtYlG8/c=
X-Received: by 2002:a17:90a:a409:b0:2d8:f99d:48d2 with SMTP id
 98e67ed59e1d1-2e2a25546abmr2031523a91.29.1728462871542; Wed, 09 Oct 2024
 01:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240912165408.234447-1-eperezma@redhat.com>
 <20240912165408.234447-3-eperezma@redhat.com>
 <e3d8e5eb-39af-4cfd-85c6-96f49441f757@oracle.com>
In-Reply-To: <e3d8e5eb-39af-4cfd-85c6-96f49441f757@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:34:20 +0800
Message-ID: <CACGkMEtxR2Swfb51uCeyDs3zRdHJ5xWLaK=R-WEMnuofXZ_vcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: move backend cleanup to NIC cleanup
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-devel@nongnu.org, dtatulea@nvidia.com, mcoqueli@redhat.com, 
 mst@redhat.com, qemu-stable@nongnu.org, leiyang@redhat.com, 
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 18, 2024 at 11:57=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
>
>
>
> On 9/12/2024 9:54 AM, Eugenio P=C3=A9rez wrote:
> > Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> > structures if peer nic is present") effectively delayed the backend
> > cleanup, allowing the frontend or the guest to access it resources as
> > long as the frontend is still visible to the guest.
> >
> > However it does not clean up the resources until the qemu process is
> > over.  This causes an effective leak if the device is deleted with
> > device_del, as there is no way to close the vdpa device.  This makes
> > impossible to re-add that device to this or other QEMU instances until
> > the first instance of QEMU is finished.
> >
> > Move the cleanup from qemu_cleanup to the NIC deletion and to
> > net_cleanup.
> >
> > Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net struc=
tures if peer nic is present")
> > Reported-by: Lei Yang <leiyang@redhat.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

Queued.

Thanks


