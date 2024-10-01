Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39644CEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveSx-0001eG-Uu; Tue, 01 Oct 2024 11:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sveSs-0001Xa-Bt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sveSo-0001N3-SQ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727795213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEH3qBVYTHP8CFwTdUPPeaUdYBeTi1xbeartC6vgI8o=;
 b=iF37eSv7SdUUqwQDfs+qBSXHbBtejUis+0Wg7NdGOBUjiYN1tPL6cco4LRjKrrn8Gq3G3D
 fUJ2pyX7cSCwueTHid21ZTNP68NWhysabt96TmmiWqT82p8SZ9nBqekhBYRjoWbZva0F4j
 DGqk6Vthww/wG65sZLpCj52R5PFl6vE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-9bmWCpynMIGBnT49eueoPA-1; Tue, 01 Oct 2024 11:06:51 -0400
X-MC-Unique: 9bmWCpynMIGBnT49eueoPA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a9a85e4a85so1281269485a.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727795211; x=1728400011;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hEH3qBVYTHP8CFwTdUPPeaUdYBeTi1xbeartC6vgI8o=;
 b=gK0Wt9fdCKvB25ab7qbWKFrNGzW9T2dOo3+2QZPQKlqVGuzO3RcpLYYRi7y0nlw4qn
 rQR6bW2P5Uc+S+mX39/xF8uajtL80u9Nhyp2FUOb8kYNw663AYleVbSNhsK02G4vLJc9
 g4oZ0BrBwA1RhmCTOS84jM516W2DVzKBMKa78IRO3CnwVt6bvbaJoW/Fe/qQ4EnvgTvR
 ugSTusEunjn2ynciG+2jnWvosDrbmXPNq6xHhnqQjBxJyxBqzc2i4AFGX4qktM1j6aop
 JOhl3bPXFvDNKCa1THPj5Z1GP3eemoj6ZR3Q1aRQqo70xx6N72Q2iDF7oJ8cLpJ5GUBE
 IgdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBtw+ti4IrSCLImpWmo6aWQpYvuBW4D449Ww1iNwYCGR4BxBiBfv0zpAbYWlBNo9K3cYpAGlyIEdaw@nongnu.org
X-Gm-Message-State: AOJu0YygMNmWMLfdpB6fNMlu32tEOCplQa9GWphQeu1x8qhOlV+lzJ1F
 hdlWlMua6FXQ1UIA1Em+xdz0V7QVClFuGgKPzs7d9qVDH3848v0Z7MK+CRtk6yqSMYQh62Unjlr
 y0BNuI4Cxr5aLKXEToOHofMdbK5nCMzKrtmNf/0Y20Z9RBY2AJIvr
X-Received: by 2002:a05:620a:4624:b0:7a9:b9dc:1b72 with SMTP id
 af79cd13be357-7ae626c2947mr585585a.23.1727795211088; 
 Tue, 01 Oct 2024 08:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh2srrZOw47ZH9X2y/DYSL84I+bUz8CGmxoq4lAyO+S7r2RmU7mGEjfUExjhmKahlztD+CoQ==
X-Received: by 2002:a05:620a:4624:b0:7a9:b9dc:1b72 with SMTP id
 af79cd13be357-7ae626c2947mr580685a.23.1727795210580; 
 Tue, 01 Oct 2024 08:06:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae3783d086sm510953885a.107.2024.10.01.08.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 08:06:50 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:06:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>
Subject: Re: [PATCH 0/7] migration: query-migrationthreads enhancements and
 cleanups
Message-ID: <ZvwQB1Calv407MH0@x1n>
References: <20240930195837.825728-1-peterx@redhat.com>
 <87o744e5pa.fsf@pond.sub.org> <ZvwGSgDnW8KfgFEh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvwGSgDnW8KfgFEh@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 01, 2024 at 03:25:14PM +0100, Daniel P. Berrangé wrote:
> On Tue, Oct 01, 2024 at 07:46:09AM +0200, Markus Armbruster wrote:
> > Command query-migrationthreads went in without a QAPI ACK.  Issues
> > review should have caught:
> > 
> > * Flawed documentation.  Fixed in commit e6c60bf02d1.
> > 
> > * It should have been spelled query-migration-threads.  Not worth fixing
> >   now, I guess.
> > 
> > * What are the use cases?  The commit message doesn't tell!  If it's
> >   just for debugging, the command should be marked unstable.
> 
> It is hard to use too.
> 
> Lets say a mgmt app wants to restrict migration threads to some
> certain pCPUs. It can't call query-migrationthreads beforehand
> as the threads don't exist until migration is started. If it
> calls after migration is started, then there's a window where
> threads are running on arbitrary pCPUs that QEMU has access
> to. There's no synchronization point where threads have been
> created & can be queried, but are not yet sending data (and
> thus burning CPU time)

Indeed, I suppose tricks needed if to work with such model, e.g., mgmt
needs to turn bw=0, start migration, query TIDs, then restore bw.

However that still lacks at least the dest multifd threads, as currently it
only reports src multifd threads TIDs.  I don't see why a serious mgmt
would like to pin and care only src threads, not dest threads, which can
also eat as much (or even more) pCPU resources.

For real debugging purpose, I actually don't see a major value out of it
either, because GDB can provide all information that this API wants to
provide, and only better with thread stacks if we want.

Since I don't see how this can be used right, it didn't get proper QAPI
reviews, and further I highly suspect whether this API is consumed by
anyone at all.. in any serious way.  Shall we remove this API (with/without
going through the deprecation process)?

I added the author Jiacheng too.

Thanks,

-- 
Peter Xu


