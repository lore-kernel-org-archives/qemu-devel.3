Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640EAE9A04A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 16:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsk4o-0004oS-KH; Wed, 18 Feb 2026 11:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsk4l-0004np-5A
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsk4h-0006QK-Nu
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771430808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hSK/HsPD34sSMksqQbtztNQ/GGc8Ut+JjwXI0/OPFU=;
 b=SRb2D3qWBPXPsQC/w35gedhDH6DrtK9faBhW2+i8suVd/+oCaMwnr41X9sh9HexPpQCt0/
 /1FOxDQoNrjYbmNLh9lnbwRs3IMbUKB+dwEwdBSKnr89Rk9TFrTixFq6XbGv08Gejvryl8
 Bj8Al0qeHJnQnKnVe01sNl0ImkzXViw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-k4kERAQSPeqyt3hPLhsInQ-1; Wed, 18 Feb 2026 11:06:45 -0500
X-MC-Unique: k4kERAQSPeqyt3hPLhsInQ-1
X-Mimecast-MFC-AGG-ID: k4kERAQSPeqyt3hPLhsInQ_1771430804
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5033c483b74so463343971cf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 08:06:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771430804; cv=none;
 d=google.com; s=arc-20240605;
 b=hDmqpmvwSagDL+kpizwGn5LTO9kC+uBbNW/TgliU2ZFyPzzEJDKBjMPse2xVGSPPo7
 9EE6MbL4qSXfLD1yBljkBZL7dqls5aK+Zh8ua22p9OMmRg8gya5sHRN1IoJAiOHsgSgU
 +V9icT9TAYIDznICoJWzZYoRUE6rXxHRFUlflemBiG88TbTQdyGM92faiYM/ETcYSzEr
 z7IpsAR88EnQIPChArJotB69D4P8bA56FVjXI/OJgAekNYp4CHtYsBAhns5xj4vh2/8L
 qubvO7Jq9Xh6byR7umRzxfjJxbSwnxKyPDvAfZj93qLBaFqVLaJQN3Mb2lnrNkam7sT/
 saAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0hSK/HsPD34sSMksqQbtztNQ/GGc8Ut+JjwXI0/OPFU=;
 fh=R4BDVbA8vsFJfl+ZiWnWh1n8Fwtkny7T4fcfGFVGr6o=;
 b=g0ieS+0/uHG069951kc7e5WlV8GhxJ0YtvmedxkXrVKaeOjeutWIMsGYpkZGKU/Xte
 CqSjKBytlE042GF1CgQg4rmKBHLw18yjqUeTLDdufuFFk+TQaP5wxO0OKWQ9yHyPhRu9
 cX8uhGK0sELVXfPwY1VjNUdOva+GuKENBxEU/JzoMflvNAr1eotlNG/MW4HLzzk15mGD
 8fUEffBgvBmr0ZygRBUYQyD7vgLfmklf72RDkny12O71GGCMlIJ1m9YXc4LeX6ZknUaN
 RzqXov31ANJcz7R+XsjdFNcsaXBZIRijkpIyavqPivDwPpuf36koTk2QL0f0sX/gIPg0
 1o1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771430804; x=1772035604; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hSK/HsPD34sSMksqQbtztNQ/GGc8Ut+JjwXI0/OPFU=;
 b=TGqKc4sLyqEwAawFVbaUuuNAJCzsAw4HUnTQugRIh3ZxM9qVNMMSg7wGb9BbWKc9z/
 EbBlY89a6Cp9JzXyuVVZIITyBvo0gCABC/fFVFlTRwhuSKgINjXNaMwxHwJxUqCTx3uI
 A0X30LS3fz6J/kPtYfBoMnLceEgZpgIfjDbj6i3UdTySPcCsa6H5l8LClUwaDd9Gi9DZ
 PCdN3ATSTEZEUKSTWJncH+e1L7R2BJo6bGxf/feXufBalBfQTnVqtYcNO5zO2xd/Ak2B
 rDoe2miMyNJLB2UUc68Do/aaMgH1ZQ57Go4XjN3dZt+j9kGW3uagydTsdqP3Bq9Ce4KZ
 ISsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430804; x=1772035604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0hSK/HsPD34sSMksqQbtztNQ/GGc8Ut+JjwXI0/OPFU=;
 b=PCY29z+ya5g5dTroLlhhSDquPpR2tVJe5pPrQaJjPrfy7fwTjNB7EkSbNN0KS30YC5
 J9LHD1KLFvY46eO251pU1VGGPrtJxVElpyJLwesnKVS6KmI/aYOWBU0uTrvVzd08vsfL
 9TRRM/bsceP/zb/wIzVZLFqIKkRyeKjmE9YgprREN93cyqQg40iOpNxhiZnGPIr4PZaC
 KWxgPu52YqWyds1mmVDpBkZqqys5h9itoPQ6wy9isv8zDGKFsghIhZyv3Zk7FQnDkZE6
 JBfukp4U4L1kFUKe0SJ1e2ZlEl7I0pd0PcutilfNe9ze4dLpzRdazDw9m6k1EDliFv+v
 YRRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgxlWpCHcETRrZ2fK9ARxxL60ufMjkeqDCNNAd4iKjqhaPq5U2H7M9xd9uE/w793qDclRN+AQKK6Qw@nongnu.org
X-Gm-Message-State: AOJu0YxuXYxVhvSWEF2XkBO7I47U9Ej2ybxae63Ro/pbxw3BxDygwtaR
 88oh6mag5Iie9fYovszFOgGs7oXrV/2957DkzawNnHlSuLK1BgftKWW9tVWg97tdYUad31qgWE2
 12xoe0cLpu7wHl9HCnl5TCQtz6ocEqdA/PUW/q479yvl/tnaz2LZXzSKMr/Mw+RO5Gh6U5C6tcf
 GZngdXAQrWQko3vezLAGymy8STNaSczus=
X-Gm-Gg: AZuq6aKXmgqt4WYdRi4THbGlqw1+25XOXFirB24Kj9WdujEChB2K+APyb6j6THvC5eI
 SezkeYqzf8+X+LE4YWjRbHGqAwGllDbCHKhrGQB3BD+auWyUS19gC5W7fPhjIKfjJHE5I+l+cOC
 jCEUHRU79LiS9qm6ET3Qm5UTy5DwmwavfKVMK4ihiWBKpu+HwgF7n93nxbbL9f+V/rBxm7UAPLG
 t1qyIOf/Y0RKBYHmRaf04cfPa4LvlGHX/nq
X-Received: by 2002:ac8:5a45:0:b0:4ee:1f22:3613 with SMTP id
 d75a77b69052e-506a8341309mr227981401cf.62.1771430804546; 
 Wed, 18 Feb 2026 08:06:44 -0800 (PST)
X-Received: by 2002:ac8:5a45:0:b0:4ee:1f22:3613 with SMTP id
 d75a77b69052e-506a8341309mr227980871cf.62.1771430804044; Wed, 18 Feb 2026
 08:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-23-anisinha@redhat.com>
 <96665575-c28c-43fb-af7b-41be109dc959@redhat.com>
 <20472A29-B096-4407-B144-74C3804CC315@redhat.com>
 <0f5f1157-1ac4-472b-9c30-5e0c61d18f83@redhat.com>
In-Reply-To: <0f5f1157-1ac4-472b-9c30-5e0c61d18f83@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 18 Feb 2026 21:36:33 +0530
X-Gm-Features: AaiRm51tTZd5ClAtBZEN2mHOgEFdX5x481GB_U33TFI9HNVSJCH_POrRoStLfGQ
Message-ID: <CAK3XEhPVMABDZ85wiMMW7bVHzytaOrw=kf8avu7rNvqLiZnH0A@mail.gmail.com>
Subject: Re: [PATCH v5 22/34] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 18, 2026 at 9:00=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> On 2/18/26 16:07, Ani Sinha wrote:
> >
> >
> >> On 18 Feb 2026, at 7:37=E2=80=AFPM, C=C3=A9dric Le Goater <clg@redhat.=
com> wrote:
> >>
> >> On 2/18/26 12:42, Ani Sinha wrote:
> >>> Normally the vfio pseudo device file descriptor lives for the life of=
 the VM.
> >>> However, when the kvm VM file descriptor changes, a new file descript=
or
> >>> for the pseudo device needs to be generated against the new kvm VM de=
scriptor.
> >>> Other existing vfio descriptors needs to be reattached to the new pse=
udo device
> >>> descriptor. This change performs the above steps.
> >>> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >>
> >> There is a regression since last version.
> >>
> >>
> >> 'reboot' from the guest and command 'system_reset' from the QEMU
> >> monitor now generate these outputs:
> >>
> >>   qemu-system-x86_64: info: virtual machine state has been rebuilt wit=
h new guest file handle.
> >>   qemu-system-x86_64: info: virtual machine state has been rebuilt wit=
h new guest file handle.
> >>   qemu-system-x86_64: info: virtual machine state has been rebuilt wit=
h new guest file handle.
> >>   ...
> >>
> >> and QEMU exits after a while.
> >
> > I have only seen this in SEV-ES with more than one vcpus. Never with TD=
X or SEV-SNP (single or multiple cpus).
> > On which host/guest type did you see this?
>
> SEV-SNP on a RHEL9 host. Same guest I used before and host says :
>
>    [1816531.409591] kvm_amd: SEV-ES guest requested termination: 0x0:0x0

Ok so the guest is SEV-ES. most likely you are also using > 1 vcpu.
Try with one vcpu and/or enabling SEV-SNP.


