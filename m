Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B79DC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 20:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tigI6-0001e7-FA; Thu, 13 Feb 2025 15:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tigI2-0001dZ-6G
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 15:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tigI0-0001B6-I4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 15:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739480304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIwv28Eg9o+8B62iOwIAut8oKASTwz+J/sQ3Qky9Q8c=;
 b=DIp3YZ6qLJqMe7kckhUft4TSqpVChtyNKhmU9pjfY65dLi2bSYgZRVYcCBocVLxC3zB5rs
 7JHkFIBMOkFgR8fbx090UIM40axugwOFfQ+SYScLs420N8z05aHR7BmDPlEfDk0AXpEIRB
 mvdYeg3OulXC4BtvKLJn8jlxvGaiJYE=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-MwLK_SjCOX-ZO61arXSTzg-1; Thu, 13 Feb 2025 15:58:23 -0500
X-MC-Unique: MwLK_SjCOX-ZO61arXSTzg-1
X-Mimecast-MFC-AGG-ID: MwLK_SjCOX-ZO61arXSTzg_1739480302
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-2b880ef5905so443593fac.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 12:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739480302; x=1740085102;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vIwv28Eg9o+8B62iOwIAut8oKASTwz+J/sQ3Qky9Q8c=;
 b=Is2X4rM21DgxX5kZFFpGZpdSWn8VnBGInZVN1M5tqTWVyVJBYraYSS4XO1kX5hdbOd
 Go6WO86ENz7lGap8AaGPj8vbWVNyhpxE92MrDM9Bwi4d4IH0Zb1XvWIqFKLzBtQpY7gY
 yxxFNubdK4UHyXePeBYN1QNlolKNXB/xB5SLi/IkODyLwjUVhjSt8MFw/K5jC9KAmtS9
 LOipwoB7XlDyAlRavC+s9gvsYXJjH3BGkbevagXrC9OQ1NUP3/P2PIXpBRnndi18XNdv
 4FqMKgLvit3JLOqAnH62EiK8l4F6rJSa18Fsyx8d9u9AnB5ew7ObDiUZyM7KtC0ez4zD
 zuIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRZIywyesAfEOxRaQpnOr04TFoNh4oqKfPWdw9xUEEVAFYi7F8CyQSCdg2pXHhTdCVAo7KB7HioGow@nongnu.org
X-Gm-Message-State: AOJu0Yw5rfRgBq7CgaCg52qDo+oWaJju9K2nwcRbADXF8mQq2MFMpis5
 7VYbzKvnB+n96GuM1kkBCB70N55z3C4AkKvPiT8fru2bAlCffStic8hW6Rsb1vcxOYkli1m04KB
 3IF8C3mW+7hU8VhAtot9pjOpXTCPqHMr1MpbtNAkRQ6QpTENLD5cQ
X-Gm-Gg: ASbGncvWMjAZVrq3Ujf60oYmTV50HKI81H6+VEuz571rPA/njZXXgf8XSM8CPCIxOGB
 PaLiYrfl54g76yj5e0zrFulPtROUxNewMfeCuBXMA9dnN4+7JRNcEyR5kY8rFEYTZ4UDdrPIjkX
 nuK1VjrD/z9d0zxqTCiJVsx5lg60wasFV2CeWrvzpFr7QWk5Pculbh/YFPM5XiOPpVtNOh5/cv/
 zqNVtFtX7xvru7pwMpFGh/5juZQG601BfjiYwEUFbdb/zEihE4CqSogwOk=
X-Received: by 2002:a05:6871:1c5:b0:2b7:f2dc:a4c2 with SMTP id
 586e51a60fabf-2b8f8c0129emr2590467fac.18.1739480302170; 
 Thu, 13 Feb 2025 12:58:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWzzqKiybCYxvoqt0ORZNtG9ikfVTTgFeeveX24Fss5WGPD09ZaJPAoqXeH/7rIazijBOQ7Q==
X-Received: by 2002:a05:6871:1c5:b0:2b7:f2dc:a4c2 with SMTP id
 586e51a60fabf-2b8f8c0129emr2590455fac.18.1739480301793; 
 Thu, 13 Feb 2025 12:58:21 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b954820707sm1112555fac.10.2025.02.13.12.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 12:58:20 -0800 (PST)
Date: Thu, 13 Feb 2025 15:58:17 -0500
From: Peter Xu <peterx@redhat.com>
To: William Roche <william.roche@oracle.com>
Cc: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, joao.m.martins@oracle.com,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 0/3] Poisoned memory recovery on reboot
Message-ID: <Z65c6W98c9hruUIE@x1.local>
References: <20250211212707.302391-1-william.roche@oracle.com>
 <Z6vQvr4dCCsBR2sX@x1.local>
 <6e8aedfc-f270-4fa8-a1d3-df0389e505cb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e8aedfc-f270-4fa8-a1d3-df0389e505cb@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 13, 2025 at 08:35:09PM +0100, William Roche wrote:
> On 2/11/25 23:35, Peter Xu wrote:
> > On Tue, Feb 11, 2025 at 09:27:04PM +0000, “William Roche wrote:
> > > From: William Roche <william.roche@oracle.com>
> > > 
> > > Here is a very simplified version of my fix only dealing with the
> > > recovery of huge pages on VM reset.
> > >   ---
> > > This set of patches fixes an existing bug with hardware memory errors
> > > impacting hugetlbfs memory backed VMs and its recovery on VM reset.
> > > When using hugetlbfs large pages, any large page location being impacted
> > > by an HW memory error results in poisoning the entire page, suddenly
> > > making a large chunk of the VM memory unusable.
> > > 
> > > The main problem that currently exists in Qemu is the lack of backend
> > > file repair before resetting the VM memory, resulting in the impacted
> > > memory to be silently unusable even after a VM reboot.
> > > 
> > > In order to fix this issue, we take into account the page size of the
> > > impacted memory block when dealing with the associated poisoned page
> > > location.
> > > 
> > > Using the page size information we also try to regenerate the memory
> > > calling ram_block_discard_range() on VM reset when running
> > > qemu_ram_remap(). So that a poisoned memory backed by a hugetlbfs
> > > file is regenerated with a hole punched in this file. A new page is
> > > loaded when the location is first touched.  In case of a discard
> > > failure we fall back to remapping the memory location.
> > > 
> > > But we currently don't reset the memory settings and the 'prealloc'
> > > attribute is ignored after the remap from the file backend.
> > 
> > queued patch 1-2, thanks.
> > 
> 
> Thank you very much Peter, and thanks to David too !
> 
> According to me, ARM needs more than only error injection messages.
> For example, the loop of errors that can appear during kdump when dealing
> with large pages is a real problem, hanging a VM.

Maybe it'll be better to post arm patches separately so that it can attract
more attention from arm developers specifically.

I see that PeterM is in the loop, besides you could also try to copy Eric
Auger <eric.auger@redhat.com>.  I have Eric copied.  I'm not sure whether
Eric or the team would be interested in this too at some point.

> 
> There is also the remap notification (to better deal with 'prealloc'
> attribute for example) that needs to be implemented now.

Right, this one should be easy, IMHO.  And I hope if prealloc is the only
concern then the impact is low, I mean prefaults for hugetlb pages is less
important comparing to small pages - fault one 1G page which used to be
poisoned may not even be detectable from guest as long as there're still
free 1G available.

> 
> And finally the kernel KVM enhancement needed on x86 to return a more
> accurate SIGBUS siginfo.si_addr_lsb value on large pages memory errors.
> Qemu could than take this information into account to provide more useful
> feedback about the 'failed' memory size.

I confess this isn't high priority for now.  Before hugetlb pages can be
split this isn't providing much help indeed, as QEMU knows whatever the
kernel knows.

It can be more important until someone allows hugetlb pages to split so
poison may only affect 4k out of 1G.  In that case it must report with 4k
of part of 1G.  We'll see how that would work out at last, we may need some
new mm interface to tell the userspace that "when I say 4k is poisoned,
it's really only that 4k..", or something like that.

> 
> I don't know yet when I'll have the possibility to come back to these
> problems, but at least we have the recovery of large pages mostly fixed with
> the 2 patches queued.

Yes, thanks for fixing it.

-- 
Peter Xu


