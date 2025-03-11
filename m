Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991EDC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 10:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trwQw-0007mt-Ja; Tue, 11 Mar 2025 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1trwQv-0007lW-79
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1trwQs-00045w-S9
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 06:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741687311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yAGwSDaMJBS9fxU4WJUt5uscLzrST6sqLjPfctabkuM=;
 b=YGvHw7ZOwHCSXSud15doJKZAbHPxFZ6+s0QizR88wbi80Rlx1HP7Xg1DDMaxqfdA6F1Ac7
 QBRRtuqhZnRLa+oZ8veBhXpu/cockXyKXAdskCLWGV8/OEt9poPfcQPf4ifxMvQ4cqbZ48
 bb9TajMkj/QttamBA1Ifo+qjB6ZkGqk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-4uPXz2WcMxOJrFfwnygdoA-1; Tue, 11 Mar 2025 06:01:50 -0400
X-MC-Unique: 4uPXz2WcMxOJrFfwnygdoA-1
X-Mimecast-MFC-AGG-ID: 4uPXz2WcMxOJrFfwnygdoA_1741687309
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso2135762f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 03:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741687308; x=1742292108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yAGwSDaMJBS9fxU4WJUt5uscLzrST6sqLjPfctabkuM=;
 b=bJ5OtcgH7oG8p5dQAI9itXffWC/K1jkW6HrzqykMBjpXc6Jx+5CQQkGoYNAyVKjnYh
 lEZp/2u/8/ItOJNEI9IJ0DvcRZqI7+sUnVdelDsQxtl2ZDH1KUMX/ixa8wmF3dTq+6fS
 LB+eXAYP1jHwvOPLPzmk3cU6tgeSZUgt01mwMf33eZovFGF6c078F6niguoLg3OrxxZ2
 MIOhpzFrEXrACZzom9q8Yj5JmJcp14LWye5IUskP9l9Qq2zmv+DRt0NXksuYnLg5KIul
 6l6NbzSgIKHqrpfctNM62FQcUila0jv2ed/H/aXbGd5jDNcDArlqGeSXZ+Mvm5km8jjJ
 2a5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUneMMGztaEf+px/gU+G4oEvemQiduasKNg44Kv2DaWTg/NK7ROHNRAE5tkWShGxgIFpeKIVhZoCFaO@nongnu.org
X-Gm-Message-State: AOJu0YzFF2pVLcdUhZjHjhkU5g1cSUe04tHHQ03To2btv8EJLalrkOhU
 J2l06jXyPJoGsIbmVKs7Qqdo7mzG5LhX5f5f3Q2suKB2sHFNtNBaOXEx+4DMXFdq4+oDEkWttrE
 w9NEDv5tZxgz3Xyja+RD0zCk/KMFJTDZGevPOJKa2dE9T1TYjV+cXGzw9HG3qIR2d/27xfjwpeZ
 r4LyvVHapX11Qp5jYQC0gOqap9y5MRDp6PtSjyFA==
X-Gm-Gg: ASbGncsiY2cCI0PMSaEdyFQdl7GEKhP633R/VHFoADejpfxJvPPg0kr82SaarG3BTQq
 lbkR0Io/LX0CUPCvnSSJG3XgPcbJ44nIfHHKsmHgiFsnrPUFiq/6W13xqwAAYC96M3+BGyOdulu
 4=
X-Received: by 2002:a05:6000:18a3:b0:391:32b1:9458 with SMTP id
 ffacd0b85a97d-39132d05bb7mr13821157f8f.3.1741687307956; 
 Tue, 11 Mar 2025 03:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdABgJl0jNHz2MN3iGXc+n0/34I0GIIWUngJlc7GLL47MmOAQS2zgTLgs2eCD79EoCb5XClG0/eaqdjw9dXx8=
X-Received: by 2002:a05:6000:18a3:b0:391:32b1:9458 with SMTP id
 ffacd0b85a97d-39132d05bb7mr13821130f8f.3.1741687307660; Tue, 11 Mar 2025
 03:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
 <Z8t4YoPEnwJO0sFP@x1.local> <87ldtdt0g3.fsf@suse.de>
 <CAE8KmOwrbJnxS7How7=dhk2hnUUUjKzgEmvT2iTh+BpUa7n1WA@mail.gmail.com>
 <87bju8ac9v.fsf@suse.de>
In-Reply-To: <87bju8ac9v.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 11 Mar 2025 15:31:28 +0530
X-Gm-Features: AQ5f1Joa2Yk7JXJ9jNgwfa7gVt7SsKaigODiAIUltg-to-aCfV6iq1L7L85RKlM
Message-ID: <CAE8KmOxB-5xOtyz5-5g=3v7nF=z0bzhqVfax3Bd--zshQu8CjQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
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

Hi,

On Tue, 11 Mar 2025 at 01:28, Fabiano Rosas <farosas@suse.de> wrote:
> They occur when cleanup code is allowed to run when resources have not
> yet been allocated or while the resources are still being accessed.
>
> Having the shutdown routine at a single point when it's clear everything
> else is ready for shutdown helps not only to avoid those issues, but
> also when investigating them. Otherwise you'll have the same code
> running at (potentially) completely different points in time and one of
> those times the system might be in an unexpected state.

* I see. It's not clear when this would happen in a production deployment.
===
     if (migrate_multifd()) {
          multifd_send_shutdown();  <= [1]
     }

     postcopy_start(...)  <= [2]
===

* There was another scenario regarding multifd shutdown as: the EOF or
shutdown message sent via [1] on each multifd connection reaches the
destination _later_ than the Postcopy phase start via [2]. And this
may result in multifd_recv_threads on the destination overwriting
memory pages written by postcopy thread, thus corrupting the guest
state.

* Do we have any bugs/issues where these above things happened? To see
the real circumstances under which it happened?

* There seems to be some disconnect between the kind of scenarios we
are considering and the minimal requirements for live migrations: a
stable network with real good bandwidth. If we test live migration
with guest dirtying RAM to the tune of 64M/128M/256M/512M bytes, that
assumes/implies that the network bandwidth is much more than 512Mbps,
no?

Thank you.
---
  - Prasad


