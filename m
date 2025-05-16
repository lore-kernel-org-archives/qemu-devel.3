Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F32C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 01:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkCT-0000eo-OD; Thu, 15 May 2025 21:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkCR-0000Ye-VI
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkCQ-00040g-86
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747360161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCFaj9aOW4NKK0J7k7odFUSJkzIMNWdQGxVAA+aEooo=;
 b=MRwZLlskfWF+2N59v8i71R+l2Ma1M383An2ldsyjMDxvVLkgvEDRs3bpyzV+oRkeUSdg/I
 76uczOue64+sS4S9UAA7wKoG8s9lcgJi09DVbgxcmmOk+rBLxww5OxuWJtxKwyTqRWT0jl
 hIduEopFGF8Mp64deuBvdFnQA+Oydwg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-3uyimIdYMGeE-FtoR-wpKA-1; Thu, 15 May 2025 21:49:20 -0400
X-MC-Unique: 3uyimIdYMGeE-FtoR-wpKA-1
X-Mimecast-MFC-AGG-ID: 3uyimIdYMGeE-FtoR-wpKA_1747360159
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b0f807421c9so911765a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 18:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747360159; x=1747964959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCFaj9aOW4NKK0J7k7odFUSJkzIMNWdQGxVAA+aEooo=;
 b=uISR++XEFsqstExKoUez/VEKMqXxaCMgUHxlxM5fF6NsVdVqSNeY2JR+64/M8B0v+q
 JaKK2+eN6nS2lWUIcGNI4VSZLI/MCttbpHKEsuY3zxm+Y/qZF6T0X+V022BkY+uoKocJ
 jXmkj4qXOWcTPWkFyaJ2xfN+C7XUADTh/FV+tlKFtD/z+WqCtt6QLzK7SBs/dKVEI1ap
 yizOLY/Us4FaC7oLvAEmK8uRcp872smmtRevW4LGFIi722VhYhxP9cmE7DnAQ+7JDQGN
 j63YVlSpl/FszjnNfX6qZdlJu490P+AFaExmsEKvDz2aaqBOhPUUNFyPtPgccmRkh2Ry
 4Iug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv1/+lkLuKFdIl/c8pDLVoK41wKuW0L4t6cAaza4KgFWpaBt6jozv60bYcdg3tTDxNGDe3Awz9pPLf@nongnu.org
X-Gm-Message-State: AOJu0YxSn3BwyQTEYZrin02HzOC70+PBAUoTFnLlLNu0b3IiOAye7cFY
 /vkmt0Xklj0FD6R92Bye25bpbxSB6gY47i3HgKqa3siq+hKfKDFUCfvKYIYwNiGmhhojEBP3h92
 nnyu3kKF+hFOKhF4JW8O8YmLP2foxiB+cYwLVEDyYf6qo8o3K19yXgfpZQazNH/opG5ZeNXmdph
 KYpQiz6j1ICZ0g+tRTPeSpLISqrE87kVo=
X-Gm-Gg: ASbGncvS3g2KSr46NQhrrvMgD+xS8OlyLRQd83K7FlGUUfLw0iDrBbehgOeQo7SNvnO
 HGjkR+uG8pBJUgwbgFY6ZKhpdQLYIyHu+To8Z8SGjMIJ84hbO3mfzmU0WD1x8bRJWyUChMA==
X-Received: by 2002:a17:90b:1b4a:b0:30e:77bf:6139 with SMTP id
 98e67ed59e1d1-30e7d4ebdcbmr1750036a91.5.1747360158932; 
 Thu, 15 May 2025 18:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq0yLyJlb9jLXdJUK/iTM5SkvvqpnHKnIGZzbRXgNY7VOfaIY+PiCM4oyzQjgQuSdalsuTKjUThDUpEMZSmGA=
X-Received: by 2002:a17:90b:1b4a:b0:30e:77bf:6139 with SMTP id
 98e67ed59e1d1-30e7d4ebdcbmr1749994a91.5.1747360158435; Thu, 15 May 2025
 18:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
 <8c465eb3-2db9-47ab-b949-e19a176a5fde@oracle.com>
In-Reply-To: <8c465eb3-2db9-47ab-b949-e19a176a5fde@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:49:07 +0800
X-Gm-Features: AX0GCFuGzVXRxARQd2NUc-xSZpvP3gWvY7HBKPZVQQFAnUnqxbhu--jQq2EWb7s
Message-ID: <CACGkMEsC2pE2U4Xus-h_Vk4ZGnCApGeWOF0ioO7xzpzZKzcJKA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org, 
 peterx@redhat.com, mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 15, 2025 at 8:17=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Hi Eugenio,
>
> On 5/14/2025 8:49 AM, Eugenio Perez Martin wrote:
> > On Wed, May 7, 2025 at 8:47=E2=80=AFPM Jonah Palmer <jonah.palmer@oracl=
e.com> wrote:
> >> Current memory operations like pinning may take a lot of time at the
> >> destination.  Currently they are done after the source of the migratio=
n is
> >> stopped, and before the workload is resumed at the destination.  This =
is a
> >> period where neigher traffic can flow, nor the VM workload can continu=
e
> >> (downtime).
> >>
> >> We can do better as we know the memory layout of the guest RAM at the
> >> destination from the moment that all devices are initializaed.  So
> >> moving that operation allows QEMU to communicate the kernel the maps
> >> while the workload is still running in the source, so Linux can start
> >> mapping them.
> >>
> >> As a small drawback, there is a time in the initialization where QEMU
> >> cannot respond to QMP etc.  By some testing, this time is about
> >> 0.2seconds.  This may be further reduced (or increased) depending on t=
he
> >> vdpa driver and the platform hardware, and it is dominated by the cost
> >> of memory pinning.
> >>
> >> This matches the time that we move out of the called downtime window.
> >> The downtime is measured as checking the trace timestamp from the mome=
nt
> >> the source suspend the device to the moment the destination starts the
> >> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> >> secs to 2.0949.
> >>
> > Hi Jonah,
> >
> > Could you update this benchmark? I don't think it changed a lot but
> > just to be as updated as possible.
> Jonah is off this week and will be back until next Tuesday, but I recall
> he indeed did some downtime test with VM with 128GB memory before taking
> off, which shows obvious improvement from around 10 seconds to 5.8
> seconds after applying this series. Since this is related to update on
> the cover letter, would it be okay for you and Jason to ack now and then
> proceed to Michael for upcoming merge?

I will go through the series.

Thanks


