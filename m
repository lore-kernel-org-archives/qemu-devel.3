Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A95D41D62
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTirC-0001u2-Gh; Thu, 11 Dec 2025 10:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTiqz-0001tB-Cy
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:45:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTiqx-0000xS-89
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765467912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7S25o2+wfdalGdvIeiQvLXZS+wcCFxVmEVROSkKouI=;
 b=iw3irWslgLvIUr2hEUPzH1f0PCDEwii/plPdzpMTxNN/jtkr4cGEl3Hc+X2ym/itlMR5HV
 kNpvasd9CMFZRtWckZtwjYta71F7m0TknJCRmexqRFDoalbE/TqX6VUbTUFcLiZ2f8v27+
 k3PGJnJtm4gFLFrkDJehkm9WgtZWQlE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-LpVBruUQOYG60B40XSm5pQ-1; Thu, 11 Dec 2025 10:45:10 -0500
X-MC-Unique: LpVBruUQOYG60B40XSm5pQ-1
X-Mimecast-MFC-AGG-ID: LpVBruUQOYG60B40XSm5pQ_1765467910
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8823c1345c0so3177706d6.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765467909; x=1766072709; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U7S25o2+wfdalGdvIeiQvLXZS+wcCFxVmEVROSkKouI=;
 b=aJSUGZx5AH33gsGuk1n+p9xbBrH7epMhSGtRTpTbOI76U8nsPBV65GLPg/FRGC/dXd
 udfw9stRXfvhD2i/n/5QKZMNEImrD8Y/vWl0Z767fuSvmpI+nUbAceHhMzmG5DofpW0J
 cah86IeYrozMXefUd8BHW8+0k10nEL1OwlqraG4wTqgqUmApv6s55WYhpCwlIekDRmrK
 NMURu6q1XH3n7TKhRFd/qpk1mk9GWm5/eXytrhUA4LjBV4OeRURowD7Gy6W9g52y7S9Z
 ubvcT+Wk4D65ThebKbCzK4aww0L68ejz77fDOmhbRwfuxT1+AFl/2/rjngElSlAPLf2H
 qEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765467909; x=1766072709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7S25o2+wfdalGdvIeiQvLXZS+wcCFxVmEVROSkKouI=;
 b=d/lrYLbdX5OkJwBsEwmYsEPJWSvbxa42EB5uYPw0Ki1Q/gM6f6Ff2/gVVA/JgK8pcJ
 KHpN0x6FV0tjedKWmz7vb5ksZdMK/XowMMVOn5cxxlYEH3oG2g2gsOEW5YGIxd/Wap9E
 TTLJZG2SsLnSjW86EGp3UVe8a+H5RnV37DxZutX3ota8K1oSVINSIKirZFTVcBmqGPl1
 E9mz4qYfuurbmuOSkpa+fYDDGrngWUcnTYQmL3xIiAsPPTlo9lpXaLb6+CiF5tsAIt2o
 nLHBHFdHCxKykAF8zybS7Peq+3wT6sBwx0UWUpzHM1hiof3KI5GGt51H9OssQzfrrzWe
 b/Sw==
X-Gm-Message-State: AOJu0YwBFKwdOi93fByw4aR/Jcb/sjSPwssNnQd7PGoyGwhlEBJ/bUq8
 OKOcXPotlA+Q7kr5hsFuKQWHQwJMGpuxR7aiHwbeT+l56dEu9OUl0h6GZBrK8RshONovDAwspuV
 mr/oeZokbpPYwBWWFMX0BVnRhKdEQxFtbLZ6aQ2/bff4aCGmp4d2y5ivMCfQKHTQ8
X-Gm-Gg: AY/fxX4+0ylJZvQuKb7Ls/MBJ66NTtryt9TX8Ob9E/pyVsXKLC3XQjaEIGPXQS0sOpk
 qjIXhz05jY03mBCcOq6rA9mdKldSyyxCocj8P6H8KjcqUpWPJtM0vpM29pwymnufmry/RpOqYgh
 QBoPZ/HWxyitnJqM/nLvMma3hOBTg/paGS1veK87giAwKorYngboWMOPdx6wUI/G5osqo0sfrLL
 sogpUMA8HwI0qxD/hLp4E3aU0jaVoHTNCpwdtWoNkYCACdd+FVzV76zWZ3myevy+gJhLliA4HZe
 jTwz9Qv7oWS1CgSiwg5Qsv1Eyn7GkJ5Xxox0tblaTcix++z3xbaq2wyTAojAZPkbeZgNFPumw0G
 bYi0=
X-Received: by 2002:a05:6214:5191:b0:882:6d1a:eacc with SMTP id
 6a1803df08f44-88863abfd33mr90571536d6.57.1765467908945; 
 Thu, 11 Dec 2025 07:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECdync4+5rotb5SgqXV9I0dZRYlHg0Kdp5lnPa101GsxZgHmqeDXKc2HjUXVlc+qUXdEC0Yw==
X-Received: by 2002:a05:6214:5191:b0:882:6d1a:eacc with SMTP id
 6a1803df08f44-88863abfd33mr90571066d6.57.1765467908498; 
 Thu, 11 Dec 2025 07:45:08 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8886ec567dfsm24654876d6.22.2025.12.11.07.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 07:45:07 -0800 (PST)
Date: Thu, 11 Dec 2025 10:45:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 4/9] memory: Rename memory_region_has_guest_memfd() to
 *_private()
Message-ID: <aTrnAdHv1k5qFaaB@x1.local>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-5-peterx@redhat.com>
 <08309979-8a73-4e30-a574-2bf23124eac8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08309979-8a73-4e30-a574-2bf23124eac8@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Dec 11, 2025 at 03:10:24PM +0800, Xiaoyao Li wrote:
> On 11/20/2025 1:29 AM, Peter Xu wrote:
> > Rename the function with "_private" suffix, to show that it returns true
> > only if it has an internal guest-memfd to back private pages (rather than
> > in-place guest-memfd).

PS: I forgot to update here, I'll use "fully shared" to replace "in-place".

> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/system/memory.h | 6 +++---
> >   accel/kvm/kvm-all.c     | 6 +++---
> >   system/memory.c         | 2 +-
> >   3 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/system/memory.h b/include/system/memory.h
> > index 2c1a5e06b4..4428701a9f 100644
> > --- a/include/system/memory.h
> > +++ b/include/system/memory.h
> > @@ -1823,14 +1823,14 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
> >   bool memory_region_is_protected(MemoryRegion *mr);
> >   /**
> > - * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
> > - *     associated
> > + * memory_region_has_guest_memfd_private: check whether a memory region has
> > + *     guest_memfd associated
> 
> Nit: maybe change it to "guest_memfd_private associated", and maybe put this
> patch after patch 5?

Agree, though maybe I should do this change in the other ramblock patch
(and move that one before this)?

> 
> Otherwise,
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks,

-- 
Peter Xu


