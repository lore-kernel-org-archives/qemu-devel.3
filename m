Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FB0D24442
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syz7w-0001Im-RO; Thu, 10 Oct 2024 15:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syz7s-0001IV-7y
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syz7q-0000mB-55
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728589624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGTXn71lUCdWA14hvnNyvE/yaBY/pamjvpDOeK4zFaU=;
 b=ZWIm3fqhkscT594HtgEOEN9i526IyaedQedNdpyqInOmFrKQJfXhCppwFELmRnZifmUgzM
 WvaWecUGtM14yS/i27UxLfa02yeAkQmySRYb9Ru0k5+I0a58gr6BN3fwNI+o+TA5sGaWwB
 jBs5J1Rgz2vQuURGPBeN48f79iO2UOY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-0pOojUiFOCSm6dqfNfkqTQ-1; Thu, 10 Oct 2024 15:47:03 -0400
X-MC-Unique: 0pOojUiFOCSm6dqfNfkqTQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b117fc111eso82437085a.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728589623; x=1729194423;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SGTXn71lUCdWA14hvnNyvE/yaBY/pamjvpDOeK4zFaU=;
 b=qp1L+toP2g7RIloePAAWO69hiReMfCDs/kgLC+N7eV7+oQJj7bE9sQaxotUic85YUs
 umYIPGRK01BG+TRO2aV/fT3qdTotrHhsBqPwGjjmPzQX+QAe3pVamWLtaa6fHI0+hUVl
 bbREq6wxKuY1Qp8NZR3Nne8zMCKmEWSLg+n+WkISb7pKtbhnTGjIFj+rc+4yRa9O7Vqd
 d8fZob6zYNZnFZkds3nu6Kpt7Dc7DHc4iO+A0S/3A9Gfrp0DZ70DuuaF8Djs4olf/ygv
 1W1zcn1Z6dKLBfVRP7O14cVDuUGsY9TaNftu5s9IBlqlvaQ+wQ/vjjySR8xN1OAE6Yld
 pipA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJIYkb+lDiphcO+axyN0/jjXBhsc9abOpsHkB40W4h5IvD+9YtKdzAcTrVwB7zTtXNkhzs6MhWCCpG@nongnu.org
X-Gm-Message-State: AOJu0YwtKIC5HuGUbSF+di1p2e3VNTU2xZO+ap/RmBKQrnYJG8eYtuos
 bfrpfaJwu5QnatFsvu/sG1JggVuIqXMlpN2LWUGqncV9HPqNb7PraUGizXLmRWsBCGy67iUJtEk
 vJGpKmazwfnyFeax8MScHLTFEiITBW4AdlPmZulAYjLIHg/ptSQnI
X-Received: by 2002:a05:620a:17aa:b0:7b1:1223:5a02 with SMTP id
 af79cd13be357-7b11a352e20mr30162885a.8.1728589622718; 
 Thu, 10 Oct 2024 12:47:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfhh8cCraLCqIggyKvtDRVlLNszpE0Gk8YslB9tV5zeuEUSX40/6DgVVfClTlDTj317bwsKQ==
X-Received: by 2002:a05:620a:17aa:b0:7b1:1223:5a02 with SMTP id
 af79cd13be357-7b11a352e20mr30160785a.8.1728589622168; 
 Thu, 10 Oct 2024 12:47:02 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1147aec68sm72903285a.0.2024.10.10.12.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:47:01 -0700 (PDT)
Date: Thu, 10 Oct 2024 15:46:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>, qemu-devel@nongnu.org,
 Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 0/7] migration: query-migrationthreads enhancements and
 cleanups
Message-ID: <ZwgvMzB3JZ1y3_WC@x1n>
References: <20240930195837.825728-1-peterx@redhat.com>
 <87o744e5pa.fsf@pond.sub.org> <ZvwGSgDnW8KfgFEh@redhat.com>
 <ZvwQB1Calv407MH0@x1n> <87h69vavvr.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h69vavvr.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 02, 2024 at 07:58:48AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Oct 01, 2024 at 03:25:14PM +0100, Daniel P. Berrangé wrote:
> >> On Tue, Oct 01, 2024 at 07:46:09AM +0200, Markus Armbruster wrote:
> >> > Command query-migrationthreads went in without a QAPI ACK.  Issues
> >> > review should have caught:
> >> > 
> >> > * Flawed documentation.  Fixed in commit e6c60bf02d1.
> >> > 
> >> > * It should have been spelled query-migration-threads.  Not worth fixing
> >> >   now, I guess.
> >> > 
> >> > * What are the use cases?  The commit message doesn't tell!  If it's
> >> >   just for debugging, the command should be marked unstable.
> >> 
> >> It is hard to use too.
> >> 
> >> Lets say a mgmt app wants to restrict migration threads to some
> >> certain pCPUs. It can't call query-migrationthreads beforehand
> >> as the threads don't exist until migration is started. If it
> >> calls after migration is started, then there's a window where
> >> threads are running on arbitrary pCPUs that QEMU has access
> >> to. There's no synchronization point where threads have been
> >> created & can be queried, but are not yet sending data (and
> >> thus burning CPU time)
> >
> > Indeed, I suppose tricks needed if to work with such model, e.g., mgmt
> > needs to turn bw=0, start migration, query TIDs, then restore bw.
> >
> > However that still lacks at least the dest multifd threads, as currently it
> > only reports src multifd threads TIDs.  I don't see why a serious mgmt
> > would like to pin and care only src threads, not dest threads, which can
> > also eat as much (or even more) pCPU resources.
> 
> Sounds like there's a use case for management applications querying
> TIDs, but query-migrationthreads falls short of serving it.
> 
> > For real debugging purpose, I actually don't see a major value out of it
> > either, because GDB can provide all information that this API wants to
> > provide, and only better with thread stacks if we want.
> 
> True.
> 
> > Since I don't see how this can be used right, it didn't get proper QAPI
> > reviews, and further I highly suspect whether this API is consumed by
> > anyone at all.. in any serious way.  Shall we remove this API (with/without
> > going through the deprecation process)?
> 
> If we decide we want to serve the management application use case now,
> we should provide a suitable interface, then deprecate
> query-migrationthreads.
> 
> If we decide not now or not at all, we can deprecate it right away.
> Removal without deprecation is also possible, but I doubt breaking our
> compatibility promise is justified.
> 
> > I added the author Jiacheng too.
> 
> Users of query-migrationthreads, please speak up!

I'll go ahead and remove it.  The current plan is I'll skip the deprecation
procedure for this one because I don't expect anyone would read the
deprecation notification at all... aka, no real user I can ever think of,
who only cares about source pinning not dest.

I'll pick patch 2 out and send separately, which is still a cleanup without
the query-migrationthreads API.

We can keep the discussion going in the new patch.

Thanks,

-- 
Peter Xu


