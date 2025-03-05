Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB87C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjaZ-000776-Hb; Wed, 05 Mar 2025 02:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjaW-00076a-TV
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:54:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tpjaU-0008SF-Uu
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741161281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7DkCkmO8U8g9OOfNxeuo0GNIXTWvqYCqVOv+vO5BLk=;
 b=HU6oa/5uFH/V8Wi235+UUC13mPAzYEIPAWMxtoWpVxdpqatRIhXfQEyiP4Ao18haktq/uP
 6C3USMgfS/ciYSmgLrp7s3HjkFmqV+jQlr972t/HWm9Z/50gprcIx79aheS0Ck219xS2oF
 Oa8J2VQIoX33xUUQsItfwEsZMDBdrns=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-hPpOye2ZPrOW-wJsZb1qKQ-1; Wed, 05 Mar 2025 02:54:39 -0500
X-MC-Unique: hPpOye2ZPrOW-wJsZb1qKQ-1
X-Mimecast-MFC-AGG-ID: hPpOye2ZPrOW-wJsZb1qKQ_1741161279
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac1ea5c94adso246553166b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 23:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741161278; x=1741766078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7DkCkmO8U8g9OOfNxeuo0GNIXTWvqYCqVOv+vO5BLk=;
 b=SSjfc5pE/4I0aievDvnmENfr41FKFAy9lWkiYiwE1KUTP9/mna7R7EAArnYjppOEXz
 rK9AYVfr55me9GFnh8PtD0SVwXVa3Rp90vwcTZP1/selaop1yFMZBWb04rq48MLUOdsM
 24Jnaj+aHBS8g3W9qtfUwSoOR1Vtqt9HMfdFCgGQx1OyDv/e+09QHwgodZaYbJvpSa+3
 u2kDNBAfSD5GNx0ca84zO/ZiwZ3O+LNtsswupkUUQB97vSI143e57uDtbdYE4g49h5MU
 n39dKH+H4XhqUnn2GPZBWQhV4j17FaMNVQa8nd8JhTqCOy7OCBRZ9tmUAiQFYLSYNaLk
 9aAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVK6spGZ1kXo/pQAAoJOEuijUIe+dSeF3SvN1ZX67fJ8EoKlIvsMCnb4x1Ns4qtkaPLVzZRsaN5ztp@nongnu.org
X-Gm-Message-State: AOJu0Yw0YXx7uwZQBP7HzdpDj8g2OxVYU00ogZhp9MBcituQzl67bIkw
 BbpaRPUtCY2/yfnRHfVua8+8xHXz1YVrOCpnVbAa9qyFWB2Hahv0f/ugHL6aB5vKQI8SdTeTsfN
 iKXd6WFXcpN4AMZcno+nnsyU6762V3TbrpHwizbyrEoC+RRziMVBLQiYYfSyhm7+iDdElaKF8ck
 QRcBDkv1qYB5NRMSgeEF9WgYs62IQ=
X-Gm-Gg: ASbGnctCSWgaM090E+1MFJps93qDEmfiZ/29tgTsdSSqj9RJLbrbcW9gaxy+4An5dXf
 Ez1qMpmqGDkV/uRnMXd0lAzf5DQ/LtSlXbbMePITZFLEwk3qYcNugUujVZpqUATeZX1HeZjiy
X-Received: by 2002:a17:907:c28f:b0:abb:e965:1264 with SMTP id
 a640c23a62f3a-ac20d97e6abmr203259866b.4.1741161278588; 
 Tue, 04 Mar 2025 23:54:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAtBcJk2QVOwiP1AxyEve7f2l+h08sUew3Ld2ZiSX6qZofifbq4NDp78+jfSOm/Yz21Y+VxJgxrhWWjtR77LE=
X-Received: by 2002:a17:907:c28f:b0:abb:e965:1264 with SMTP id
 a640c23a62f3a-ac20d97e6abmr203252066b.4.1741161276755; Tue, 04 Mar 2025
 23:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20250220065326.312596-1-anisinha@redhat.com>
 <Z7bZBsqO6MxhFKVp@intel.com>
 <CAK3XEhM505AFFND17_SOOJnTPB+u2+hKXDdo01oyza9T1=H2ww@mail.gmail.com>
In-Reply-To: <CAK3XEhM505AFFND17_SOOJnTPB+u2+hKXDdo01oyza9T1=H2ww@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 5 Mar 2025 13:24:25 +0530
X-Gm-Features: AQ5f1JqPtjuNOvEaNDhlNXo_nq-oblSqlBii2ewqTva1DTMLwASTdRblk5pFhDo
Message-ID: <CAK3XEhMbLHKt8-kV=BzKgZpdbtmRDC+qM3bfqz9BYfupR13t2w@mail.gmail.com>
Subject: Re: [PATCH v2] microvm: do not use the lastest cpu version
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Mar 1, 2025 at 9:04=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wrot=
e:
>
> On Thu, Feb 20, 2025 at 12:36=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> w=
rote:
> >
> > On Thu, Feb 20, 2025 at 12:23:26PM +0530, Ani Sinha wrote:
> > > Date: Thu, 20 Feb 2025 12:23:26 +0530
> > > From: Ani Sinha <anisinha@redhat.com>
> > > Subject: [PATCH v2] microvm: do not use the lastest cpu version
> > > X-Mailer: git-send-email 2.45.2
> > >
> > > commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> > > introduced 'default_cpu_version' for PCMachineClass. This created thr=
ee
> > > categories of CPU models:
> > >  - Most unversioned CPU models would use version 1 by default.
> > >  - For machines 4.0.1 and older that do not support cpu model aliases=
, a
> > >    special default_cpu_version value of CPU_VERSION_LEGACY is used.
> > >  - It was thought that future machines would use the latest value of =
cpu
> > >    versions corresponding to default_cpu_version value of
> > >    CPU_VERSION_LATEST [1].
> > >
> > > All pc machines still use the default cpu version of 1 for
> > > unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> > > changes with time. Therefore, if machines use CPU_VERSION_LATEST, it =
would
> > > mean that over a period of time, for the same versioned machine type,
> > > the cpu version would be different depending on what the latest was a=
t that
> > > time. This would break guests even when they use a constant specific
> > > versioned machine type.
> > > Additionally, microvm machines are not versioned anyway and therefore
> > > there is no requirement to use the latest cpu model by default.
> > > Let microvms use the non-versioned cpu model and remove all reference=
s
> > > to CPU_VERSION_LATEST as there are no other users (nor we anticipate
> > > future consumers of CPU_VERSION_LATEST).
> > >
> > > Those users who need spefific cpu versions can use explicit version i=
n
> > > the QEMU command line to select the specific cpu version desired.
> > >
> > > CI pipline does not break with this change.
> > >
> > > 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> > >
> > > CC: imammedo@redhat.com
> > > CC: zhao1.liu@intel.com
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > Reviewed-by: Sergio Lopez <slp@redhat.com>
> > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > ---
> > >  hw/i386/microvm.c |  2 +-
> > >  target/i386/cpu.c | 15 ---------------
> > >  target/i386/cpu.h |  4 ----
> > >  3 files changed, 1 insertion(+), 20 deletions(-)
> > >
> > > changelog:
> > > v2: tags added, more explanation in the commit log.
> >
> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> >
>
> Who is picking this up?

I sent a pull request for this and a couple other reviewed patches
myself. Two reasons:
- wanted to see this in the upstream sooner as some other bits of the
work is pending on it.
- I never sent a pull request before and wanted to go through the
process to learn how to do it in case I needed it in the future.

i hope the PR is ok. If not, I can resend after corrections. I used
Peter's script https://git.linaro.org/people/peter.maydell/misc-scripts.git=
/plain/make-pullreq


