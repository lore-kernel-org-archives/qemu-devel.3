Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC78C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkVgx-0006H4-Qr; Tue, 18 Feb 2025 17:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkVgw-0006GU-AU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:03:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkVgu-0007ww-Cl
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739916222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sC4i6GZ94d9ZvRQs2CIiDkPIVfWV0UXKGIz1obnXpmw=;
 b=RUlq046/T3utPo/JClBNxjHU5sO+3UUUFjUrUxeG7E+2Vrb7wKgA15bKPP996B7dOIcCn+
 HwJ3jVF53OiqneX4loOTAJ+hemB3LjPOBhXRO2zdhbtDGmv9+lTZgSFuUw86gqk5u1pRSI
 s5JyS7Im53hhzhT22w88n7XWkdKSuh0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-dZPzX3uKMgyCXxbJlg3Fpg-1; Tue, 18 Feb 2025 17:03:40 -0500
X-MC-Unique: dZPzX3uKMgyCXxbJlg3Fpg-1
X-Mimecast-MFC-AGG-ID: dZPzX3uKMgyCXxbJlg3Fpg_1739916220
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c09be677e7so48556385a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739916220; x=1740521020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sC4i6GZ94d9ZvRQs2CIiDkPIVfWV0UXKGIz1obnXpmw=;
 b=C9cOWqp518vBwaqIhuxXk/hCOnVRAgx1u+0od3O84DP7JpcIE3yyeoKq1PAgJIt3H2
 O1N0mppr3O6RR/EHY9BeEoH9fXRdNsO1zx/Y3LtMrYwW/eOBWkNaU2TKuLClJ9XSFt62
 a2BOGYxKRAwBhH1VsyAkKG64/SAbK7bIc5CuxqQ0IKa240lhuR7GUUr01s1fTHndgnzx
 UpGEfacM7qSQwhRlyRIB+C2lOJKlVtj+YOyQoLArrNzI0f7ybAapTfd9wOi/bd1qqMHC
 tB3g4HMgB/gU7+0bwVAWg3LN+r8z2/gSgI3BcUAiNJ+fLIPm8oGIwcLQx6lM06R36tM1
 LO8Q==
X-Gm-Message-State: AOJu0Yz1IrkZXETHpXGW5camSn8fzijXNg9xofxCtawRqgnRDmM1CPXH
 tGCtcjlwv9yuynvogX1goOShyzuPBaxrFxg1RXJTZypTN5UrkYyX49txfWWFsJCtaRJngSJgz4Q
 29lwQnOyzhLnxwx/F7FAK1eXoI/mKwFx1sczLlHytkqF7HWDa2Rme
X-Gm-Gg: ASbGncuL29zD3ukUpRBjNNMPI1qoRAZLtxHgysuwd8xxzGxyaskbYe5RyZpVhZi7fTw
 tuECVq/r4GSy+vAuJPWvzbYMybUmDKgyy8IxOzQvi72gsdImrcQ26HRaEmpkR4BqFmDpn/vK6El
 LnttcL215zlbV0urb5csXNE2g+MTzLfaSx90C9eT3UjnuEpKA3I8B7g4l4NGWvQMcTd0wUBs23o
 dgxClVWmUzwvraiqyHO/h2HV538ivRhk5UCI699lEfXXbQgQzMLqwWqnNs=
X-Received: by 2002:a05:620a:640a:b0:7b1:44ee:644d with SMTP id
 af79cd13be357-7c0b4cfa745mr202439485a.10.1739916219968; 
 Tue, 18 Feb 2025 14:03:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjxnrSTV1hOw6DFott4ZdcB943FTkV0HKdmEGeRcXt+aR8EsMhcTMbjzzIvTBktXel0Av5vA==
X-Received: by 2002:a05:620a:640a:b0:7b1:44ee:644d with SMTP id
 af79cd13be357-7c0b4cfa745mr202435885a.10.1739916219541; 
 Tue, 18 Feb 2025 14:03:39 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c0b1027932sm88071985a.115.2025.02.18.14.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 14:03:38 -0800 (PST)
Date: Tue, 18 Feb 2025 17:03:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Li Zhijian via <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/2] migration: Prioritize RDMA in ram_save_target_page()
Message-ID: <Z7UDtxdNSS-Jqm-y@x1.local>
References: <20250218074345.638203-1-lizhijian@fujitsu.com>
 <8734gb9erz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734gb9erz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

On Tue, Feb 18, 2025 at 05:30:40PM -0300, Fabiano Rosas wrote:
> Li Zhijian via <qemu-devel@nongnu.org> writes:
> 
> > Address an error in RDMA-based migration by ensuring RDMA is prioritized
> > when saving pages in `ram_save_target_page()`.
> >
> > Previously, the RDMA protocol's page-saving step was placed after other
> > protocols due to a refactoring in commit bc38dc2f5f3. This led to migration
> > failures characterized by unknown control messages and state loading errors
> > destination:
> > (qemu) qemu-system-x86_64: Unknown control message QEMU FILE
> > qemu-system-x86_64: error while loading state section id 1(ram)
> > qemu-system-x86_64: load of migration failed: Operation not permitted
> > source:
> > (qemu) qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
> > qemu-system-x86_64: failed to save SaveStateEntry with id(name): 1(ram): -1
> > qemu-system-x86_64: rdma migration: recv polling control error!
> > qemu-system-x86_64: warning: Early error. Sending error.
> > qemu-system-x86_64: warning: rdma migration: send polling control error
> >
> > RDMA migration implemented its own protocol/method to send pages to
> > destination side, hand over to RDMA first to prevent pages being saved by
> > other protocol.
> >
> > Fixes: bc38dc2f5f3 ("migration: refactor ram_save_target_page functions")
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> >  migration/ram.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 6f460fd22d2..635a2fe443a 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1964,6 +1964,11 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
> >      ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> >      int res;
> >  
> > +    /* Hand over to RDMA first */
> > +    if (control_save_page(pss, offset, &res)) {
> > +        return res;
> > +    }
> > +
> 
> Can we hoist that migrate_rdma() from inside the function? Since the
> other paths already check first before calling their functions.

If we're talking about hoist and stuff.. and if we want to go slightly
further, I wonder if we could also drop RAM_SAVE_CONTROL_NOT_SUPP.

    if (!migrate_rdma() || migration_in_postcopy()) {
        return RAM_SAVE_CONTROL_NOT_SUPP;
    }

We should make sure rdma_control_save_page() won't get invoked at all in
either case above..  For postcopy, maybe we could fail in the QMP migrate /
migrate_incoming cmd, at migration_channels_and_transport_compatible().

> 
> >      if (!migrate_multifd()
> >          || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> >          if (save_zero_page(rs, pss, offset)) {
> > @@ -1976,10 +1981,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
> >          return ram_save_multifd_page(block, offset);
> >      }
> >  
> > -    if (control_save_page(pss, offset, &res)) {
> > -        return res;
> > -    }
> > -
> >      return ram_save_page(rs, pss);
> >  }
> 

-- 
Peter Xu


