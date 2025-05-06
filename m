Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F887C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHZf-0007DA-Ub; Tue, 06 May 2025 08:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uCHZd-0007Cp-FF
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uCHZa-0001nj-8o
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746535135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=03024538PKqFw1sCBX+EU2COYwqAymp1qeqoDp6AmKE=;
 b=Bp9YNP1qcFrTblJUM49ld12Zm4RcpHMynkI1V5TQSSnRQqS6KeXmm0zU2snCV58jwngHE3
 2eNtZ6jsvO62p3WExvK1kKbqc7isrjPcXUyxZ3mF1qWaCvsWScSGhnlxkZARW7qCUCJI6M
 YIsqKjw5Ihs5rFkjokJCntILNq4i80E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373--tQoE5_gNLO6w9kXHt0fHw-1; Tue, 06 May 2025 08:38:54 -0400
X-MC-Unique: -tQoE5_gNLO6w9kXHt0fHw-1
X-Mimecast-MFC-AGG-ID: -tQoE5_gNLO6w9kXHt0fHw_1746535133
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913aea90b4so1783588f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746535133; x=1747139933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=03024538PKqFw1sCBX+EU2COYwqAymp1qeqoDp6AmKE=;
 b=tct84ecya63yXf2FcW2gq3tkBduu8Y9HZN/TuUbTD/AYs0pt7EYAtTSAVx+OAqeE7r
 hJddxOS3rE70hnK50dBUstGdXpTtPK8C2IWax/leQJkh6iojwNwdOQLgdEP63ox5cquM
 B8HaOTyJ+OZY7BFhEafOjddaULxZRIQUHHVm6DFnFAsrXt2HDNMNlxg6VMTy+UqdCDZe
 W2q40Mk3e2XnGD7dHK08I9Y19gOT0xye/RelG4IlNU28WlrF/LUxBWFFbxy1VLZF8sqX
 jcNvChVEXL005uU0YMlyvm8h7ca4QZXa9ivle7xRDc5r/PCzguzwtbtFWXRu27Yuzecq
 XBjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp/El8fT3d3nqEMglrm9S1CVQ/H3chpWjGPV8Npxs75mUW3zg3iY2Ud1Lf2J2o54B53qeIcoPR64Pq@nongnu.org
X-Gm-Message-State: AOJu0YxC55Wf4uf/rq/HLki22NBKa+8L4YzP4wJ80fck67mFFMnmpDV1
 epxAir++XoSnfHYJ35f8XxZGrWPqA2FAmyqQCtk8CHJTiypSjStDzR50g1rPlgrcTMV60koYGUC
 H5QEAQgzbVKoxqP9eEPQIuWXvHohpaufLruZBS1mKqhhV4/h/x7055Iy2YI04hMdqT9wz1s3bOq
 TGu3sFasooXY/J9SmDVSN6lnWU52A=
X-Gm-Gg: ASbGncv02b92HCOrFn+VqHbYUD+I9/aOt8tk5L8qQBdW2VwCC9sptJz7sWusxU3fj5D
 vh/GtWU/ISm6TaqSS5MTpAlMg9fBH5csUmEjBLKiw/+G7lrV+/8RpykBbowRrlyyWEo1/5A==
X-Received: by 2002:a05:6000:4285:b0:3a0:8295:9e0f with SMTP id
 ffacd0b85a97d-3a0ac3ea645mr2329206f8f.54.1746535132924; 
 Tue, 06 May 2025 05:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQaUqrphdaXpJIKBZ88DnTmAVnWnkr26mT+Z2zLc6djtphGGFGhNmPYC+6aO0K4AoehaCNF3YzgGKPftDRsI0=
X-Received: by 2002:a05:6000:4285:b0:3a0:8295:9e0f with SMTP id
 ffacd0b85a97d-3a0ac3ea645mr2329187f8f.54.1746535132547; Tue, 06 May 2025
 05:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250411114534.3370816-1-ppandit@redhat.com>
 <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
 <87v7qeg9r3.fsf@suse.de>
In-Reply-To: <87v7qeg9r3.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 6 May 2025 18:08:35 +0530
X-Gm-Features: ATxdqUFyx1mNj-tcA-aE_gn3Rth0pP6QavXSo7iXoz7sN2ISEPvbZKZqyYhHUW4
Message-ID: <CAE8KmOzBZd=_FmmJTiwqKw5yPoYR7_+q+umpXBFJGPYZYuMgWw@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, 6 May 2025 at 00:34, Fabiano Rosas <farosas@suse.de> wrote:
> >> # Running /ppc64/migration/multifd+postcopy/tcp/plain/cancel
> >> # Using machine type: pseries-10.0
> >> # starting QEMU: exec ./qemu-system-ppc64 -qtest
> >> # {
> >> #     "error": {
> >> #         "class": "GenericError",
> >> #         "desc": "Postcopy is not supported: Userfaultfd not available: Function not implemented"
> >> #     }
> >> # }
> >
===
[ ~]#
...
PPC KVM module is not loaded. Try modprobe kvm_hv.
qemu-system-ppc64: -accel kvm: failed to initialize kvm: Invalid argument
qemu-system-ppc64: -accel kvm: ioctl(KVM_CREATE_VM) failed: Invalid argument
PPC KVM module is not loaded. Try modprobe kvm_hv.
qemu-system-ppc64: -accel kvm: failed to initialize kvm: Invalid argument
[ ~]#

[ ~]# modprobe kvm-hv
modprobe: ERROR: could not insert 'kvm_hv': No such device
[ ~]#
[ ~]# ls -l /dev/kvm /dev/userfaultfd
crw-rw-rw-. 1 root kvm  10, 232 May  6 07:06 /dev/kvm
crw----rw-. 1 root root 10, 123 May  6 06:30 /dev/userfaultfd
[ ~]#
===

* I tried to reproduce this issue across multiple Power9 and Power10
machines, but I -qtest could not run due to above errors.

> We're missing a check on has_uffd for the multifd+postcopy tests.

* If it is about missing the 'e->has_uffd' check, does that mean
Postcopy tests are skipped on this machine because 'e->has_uffd' is
false?


Thank you.
---
  - Prasad


