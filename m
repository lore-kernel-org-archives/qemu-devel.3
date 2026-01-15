Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99A6D3CCB7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 07:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgHlZ-0007LB-8d; Thu, 15 Jan 2026 02:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vgHlC-0007EE-Hy
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 02:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vgHl9-000280-3m
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 02:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768462027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvoAKgsE73kNnN6felFwMSdwWu1uRU6x6fwETDLTjj0=;
 b=GXHT3fhNcxA6zcmSDGOxVENCn2OIgdpQtONThqfsTO9Uh9G4j6xHUj0Ru2M7uAs98Ha3H0
 VFh5oargnZNfxokVYFeEmYjvYvOWw43GwtX/3rAR1bG4iJux5Wvi9l0XkncEsEeSMG0l+q
 SDrPM+aooK3YMsnc4DdBDFcvAprfGIc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-4qt9jMYROQulHWUc-Di3wQ-1; Thu, 15 Jan 2026 02:27:00 -0500
X-MC-Unique: 4qt9jMYROQulHWUc-Di3wQ-1
X-Mimecast-MFC-AGG-ID: 4qt9jMYROQulHWUc-Di3wQ_1768462020
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b234bae2a7so183022685a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 23:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768462020; x=1769066820; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvoAKgsE73kNnN6felFwMSdwWu1uRU6x6fwETDLTjj0=;
 b=bSBQ+AJ89PVpZEIVp047i3MaqLJQWVOjKQMa+WIDk2CxR9dkVSdmlWt2cU+COPAM0V
 eDK4IMnnuCzp3yYUn1EMi0FcknSa5l4/2Ph/D42diPR8rwYqcenjEAHHzFv6zusU+/J4
 VKX6yaoVyhnRQ1Du1gYF76B2vvW8XJ18oy/RF0P9KMs+lkpKEEG8zBScfsc5h7nhi2BH
 5wjcHVlZfi8yWAue1yFzO/mVokmFDfaQu/ARbVnKOp+Z50tNB9v1PVPNeQ0gRHPj2qel
 6YhwMYUYOz4OJB6XsJErsfXNt7vpj4cLeqgMFWNIKo3xghpiJXYEv/txqWoKjcBICrCu
 S/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768462020; x=1769066820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MvoAKgsE73kNnN6felFwMSdwWu1uRU6x6fwETDLTjj0=;
 b=Jkoh5yZDBWLhT0KuHG+LHZDN3E1XiK0H38ZRs6dMGx4vNbrKlDoFHXxizMXw/C7WI1
 dEOqZg4D9naXTxzSQzDmJ31bydrVy9Sobeyu8J5L6Mq6p2P+210NqEvVLW/u3BwQVdzU
 6gUbuuM7DKS9cV2o+vb9WO82eh2YfSpkuVHXImkOgZHbyTTgMngB1l+30GJ01pZUKCGb
 2oAlOwJwKB3kb/RjTY15SEpH8ZnySWVlNg/Oc+nHL+XpaV8MPIUxp0hgGdO50wQf6zd4
 wrDKoCtXbX11okiodT/vKrHN42Ak9nDV9z5BlZj+OoA5oYmsyus6B2YXcKoUzHeaVZTd
 vtsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/smtNU5GbIGsX2OrVAqeyoLm4hJ9ejQJHPXmSdNXVTqNFsEqooWFd7VyRRzWtfZRL6/SqfL0MZ4Nm@nongnu.org
X-Gm-Message-State: AOJu0YzXR8vUmpS8BI4/Pnjg5yNmCXl4J0HMW0mTUIwlhfvgMS/7e5YS
 ZoPuWoNMJqPh79rMbo9GQ0rBqddu7B6RmVxqwtVmxXFm5H6vBxLfHodQUe25+wj+Cqhw8ZNFiTp
 2cMNn1x+wFMmZ6Jyx0yIiLVdhALYx3165PfNtPd+STkKF3xjrjFOzXDTsvg/kR60pwLeKMC04Ed
 KNsN5Bj4T8n2385jhJU4axxAbUQbkzRV0=
X-Gm-Gg: AY/fxX7/a09rG2ZtXnDinm+4EYVYhUcmlKHeK1s8nTGVAC/04gAwZ0kMiG6gg1r6M1c
 7HjErV+OUaegfR7rANYo4tex0af0o63+wf1y8MQj+qyRgrerUe+fexeFQkjiUUeMKhNNUzcUdrJ
 ggfgOM4BXBPj33enzw3KIjW2pja7Y/bcbMTv3c24neOp5z5OsJXm8XKxJhAs5mxtreiEvCusy2Q
 oe5oDZRnkH4vcFARLc45ITrMmE=
X-Received: by 2002:a05:620a:2844:b0:8b2:e704:5626 with SMTP id
 af79cd13be357-8c52fb67aa4mr695148085a.38.1768462020050; 
 Wed, 14 Jan 2026 23:27:00 -0800 (PST)
X-Received: by 2002:a05:620a:2844:b0:8b2:e704:5626 with SMTP id
 af79cd13be357-8c52fb67aa4mr695146485a.38.1768462019641; Wed, 14 Jan 2026
 23:26:59 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-24-anisinha@redhat.com>
 <cbfdd456-76c9-4280-8d58-b5a2d38b3900@maciej.szmigiero.name>
 <aWedNoIHcSJfTm4Z@redhat.com>
 <6cd62ebe-8a2b-4993-a1eb-e1a381d540c6@maciej.szmigiero.name>
In-Reply-To: <6cd62ebe-8a2b-4993-a1eb-e1a381d540c6@maciej.szmigiero.name>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 15 Jan 2026 12:56:48 +0530
X-Gm-Features: AZwV_Qi9hbimr4ZUt-d4w-uaT8_j3n87qyg1yLNJFz0eQf977W-YbJNG_mqvY8Q
Message-ID: <CAK3XEhM=inRLCCgQ6-+hXdyqqNFVfhTS4c7KEzpOVjvBm_Rj8Q@mail.gmail.com>
Subject: Re: [PATCH v2 23/32] hw/hyperv/vmbus: add support for confidential
 guest reset
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 14, 2026 at 8:10=E2=80=AFPM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 14.01.2026 14:42, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jan 14, 2026 at 02:38:54PM +0100, Maciej S. Szmigiero wrote:
> >> On 12.01.2026 14:22, Ani Sinha wrote:
> >>> On confidential guests when the KVM virtual machine file descriptor c=
hanges as
> >>> a part of the reset process, event file descriptors needs to be reass=
ociated
> >>> with the new KVM VM file descriptor. This is achieved with the help o=
f a
> >>> callback handler that gets called when KVM VM file descriptor changes=
 during
> >>> the confidential guest reset process.
> >>>
> >>> This patch is untested on confidential guests and only exists for com=
pleteness.
> >>>
> >>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>> ---
> >>>    hw/hyperv/vmbus.c | 30 ++++++++++++++++++++++++++++++
> >>>    1 file changed, 30 insertions(+)
> >>>
> >>
> >> Quick question: is this patch set targeting QEMU 11.0 or which version=
?
> >
> > Patches are always assumed to be targetting current git master unless
> > the cover letter / subject line explicity says otherwise.
>
> I was asking more what QEMU release the submitter thinks this patch set
> will make rather than against which git tree it is based on but thanks an=
yway.

Looking at https://wiki.qemu.org/Planning/11.0, I am not sure if we
will make it in 11.0 since the soft freeze is March 10. Perhaps 11.1


