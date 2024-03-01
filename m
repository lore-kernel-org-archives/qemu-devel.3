Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C767DC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 07:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxWa-00065u-4t; Fri, 01 Mar 2024 02:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rfxWP-00060x-L7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:41:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rfxWN-0001n9-SF
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709278887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SET/gY4O+c0RTYCUg3ln0vH5yO38NdGt1UwtYgJk6d8=;
 b=f7bf0TukeVUe9Gl/BnjLpwapFzKxFE78pxe91HH1BIPbLDOioM+BAYRDOYt5cWqwight/6
 EiCPFu3ij9QOIBxzBMPwgUEom/aacWi8ZFMemHghoPPjoORea+UfHthz5Yw8DXWjqBfpMW
 SpHYJ2o/5ZI6XKH2ozOrRCumphVW6Gw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-oVQcBqXlPNqWWRs9c55F_w-1; Fri, 01 Mar 2024 02:41:26 -0500
X-MC-Unique: oVQcBqXlPNqWWRs9c55F_w-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dcc05887ee9so2840180276.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 23:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709278886; x=1709883686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SET/gY4O+c0RTYCUg3ln0vH5yO38NdGt1UwtYgJk6d8=;
 b=LBG9fld6JbWGF8PPl7yNok9KpKKWN9ct8c2kKE4QEHZ+IHX7tOy5N9BXRBMoeniKpC
 Osn7sIZASEAnFeXJOHN3bmOb82kyDkjg52kX36zXmm7vS54j6dUzWjUEwdyDiGpjUjk6
 2yeMIh2FiJsEn6qR38uxAJ8zQZrtJCMsp40L1IVYZpk2/OjRhEUAIZbHn727FBMaSbJS
 yjQ4AC6ozVLZ6++G05FCLlRM564SuqIi+p+8OdnGXpGgVuJINtmQt5R+7VC+3BIL9+NO
 CD/UL6f2Aq3S+3QZ6vRN50Sp/7ssrUquM+/rbPSZqfI0zGnlzpFfdKYEYVN3v3Byu3J7
 Q3Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7dW905VAc20vcHKr1u+5gURquWzjsA/RbVs4II8iEUYO5KDzXYtALBn0OKS2mkuYTQySfiRbsKqEodnIuhUc37P/Bk9I=
X-Gm-Message-State: AOJu0YzJIJfYMwFjbGcEwOL0tHhiuqdzFCiJ1HY0oEz+eXDVSfz6EG+J
 hH3uazpDhO3HgPSCecVY/K6q5d4bFj/X2Ed7q6vm7UCFJVwwqlTyZEVk98l5L75g+Zlf0QLNEkq
 wi54i7u32hV0vdPLaN+v0ptu/KB57wpg6NJ/I6l2Z4RIBeC4/OTjb9nbzu4B4ODan7Cdoj8yqUU
 DzBklTBcD7aoRUDe7XsyL3DybfIOs=
X-Received: by 2002:a05:6902:2406:b0:dcc:41dc:116e with SMTP id
 dr6-20020a056902240600b00dcc41dc116emr738738ybb.35.1709278885894; 
 Thu, 29 Feb 2024 23:41:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA9hg3oHMsxwfKtHKVNIqZyhW7II3AGrKsqWkM44hEErQ1rCklYGa69qIbhtW5XktlsqpX4isZnkHwUE7vDVA=
X-Received: by 2002:a05:6902:2406:b0:dcc:41dc:116e with SMTP id
 dr6-20020a056902240600b00dcc41dc116emr738734ybb.35.1709278885607; Thu, 29 Feb
 2024 23:41:25 -0800 (PST)
MIME-Version: 1.0
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAGxU2F4jx5m5_ijNoWZpVK_MepvtDBY8L70-dSZmRUPmTskCNw@mail.gmail.com>
In-Reply-To: <CAGxU2F4jx5m5_ijNoWZpVK_MepvtDBY8L70-dSZmRUPmTskCNw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Mar 2024 08:40:49 +0100
Message-ID: <CAJaqyWfOaYmX-6qo-O2xWjge5av_2MDLnQVO41XLskLQC6nXsQ@mail.gmail.com>
Subject: Re: Intention to work on GSoC project
To: Sahil <icegambit91@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 9:32=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> Hi Sahil,
>
> On Sun, Feb 25, 2024 at 10:38=E2=80=AFPM Sahil <icegambit91@gmail.com> wr=
ote:
> >
> > Hi,
> >
> > My name is Sahil and I go by the pseudonym 'valdaarhun' on Github. I ha=
ve
> > never contributed to QEMU before but I have used it a few times as an e=
nd
> > user. I developed an interest in virtualization during my internship at
> > VMware and would like to dive deeper in this subfield.
> >
> > My current full-time job does not allow me to take part in external pro=
grams
> > that are paid. I would like to work on one of the proposed projects out=
side
> > of GSoC.
>
> Sure, not a problem at all, also because for this year QEMU was not
> accepted in GSoC, so anybody can work on those projects if they have
> time
>
> > I have gone through QEMU's list of GSoC '24 projects [1] and am
> > interested in two of them:
> >
> > 1. Add packed virtqueue to Shadow Virtqueue
> > 2. vhost-user memory isolation
> >
> > Based on what I have understood, they are somewhat related and are part
> > of the migration subsystem. I feel the learning curve of the first proj=
ect
> > will be less steep and will make me better prepared to tackle the secon=
d
> > project as well.
>
> The first project is for sure related with migration. While vhost-user
> memory isolation is not really related to migration, but both are
> related to virtio devices.
> Anyway, your plan looks good to me!
>

I agree with all Stefano's answers above.

> >
> > I have read the "Getting Started for Developers" [2] wiki page. I have =
also
> > built QEMU from source.
>
> Great!
>
> >
> > I think my next step should be to read the documentation on the migrati=
on
> > subsystem [3], the blog posts attached in the first project's descripti=
on
> > and virtqueue's implementation.

You can add the recently published
"virtio-live-migration-technical-deep-dive" :) [1].

[1] https://developers.redhat.com/articles/2024/02/21/virtio-live-migration=
-technical-deep-dive

> > Would you also recommend that I work on a
> > QEMU issue that is open on Gitlab and related to virtqueues/virtio to
> > familiarize
> > myself with the codebase? I went through the issues tagged as "device:v=
irtio"
> > [4]
> > but can't really tell if any of them are good for beginners. One of the=
m has
> > the
> > "bite-size" tag [5]. It also has a patch attached but hasn't been merge=
d.
> > Shall I
> > work on getting that merged?
>
> Yeah, "bite-size" issues should be better to understand how to
> contribute to QEMU.
> Feel free to work on any issue, doing the work or helping to complete
> old patches.
>

Right,

There are few other tasks pending for QEMU in general and SVQ in
particular. I'll add them as gitlab issues by today.

Thanks!

> >
> > I have worked on a few smaller systems programming issues in other
> > organizations (eg: strace [6], htop [7]) in the past.
> >
> > I look forward to hearing from you.
>
> Feel free to reach us if you have more questions on the projects.
>
> Thanks,
> Stefano
>


