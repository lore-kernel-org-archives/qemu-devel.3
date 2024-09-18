Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B75CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzIw-0004cR-JB; Wed, 18 Sep 2024 14:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzIu-0004bu-Ki
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqzIr-0000Md-V3
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726683684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZaBxsrxRN039Ex1T/MxR+FVVF7dfo1GiMz1bAo9eUFw=;
 b=L4/er9dgYsTlqNSCKUfYI8JApOiHM0xFkjXx+FYBauXgRcn16JQq6S9k+VnOYW3flyrnQf
 XqCtnFp2HE3mCU7xzJdc2/bndwGU4crrAQNKcL9D3yAcbIKPnRMMj5ovwzJs0bE7e9NLGb
 GMETrzbzMRH6KOomETDixMQE5T5XO9I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-BW1TPbtRMAiJQ1GDnxTinw-1; Wed, 18 Sep 2024 14:21:22 -0400
X-MC-Unique: BW1TPbtRMAiJQ1GDnxTinw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-45834f5927aso199691cf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726683682; x=1727288482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaBxsrxRN039Ex1T/MxR+FVVF7dfo1GiMz1bAo9eUFw=;
 b=gU7/J9C6BbdPZRqSVQ7iaZpXTN6VCO7bUgFFwma8vLm4/vtsP+YBbfBa5msLAalav3
 7m+yPPcF18WEy9cRZAP1Y+rYRe7z6SFkDNdMI6g19GfRbEka/LFuYs7qM62B4495cyxJ
 BiECQMT7X+0K4VV+qbN2mRnt8oZoI9W1q4K9rzKoMQNEUtJt2beWmp6VYodJMxpJf2hc
 ln+5A8n3HVBqxeHW7koDW5Ldd1AUIBxACQEdMtW4furPAItZDt17N4Q8sUh0C+WOBc1W
 GwvXaa4xKtlBzEMfZSJGfRwj6adrqHudJ8TXK2ni4tdSLG6Sg1185ZzqhYY7UmRaoSfc
 Hb5A==
X-Gm-Message-State: AOJu0YxV0KZsrjHtGHeGhkjGna4Spyltf2TOANeBVklcnvAtxgvftxur
 dWGqLHrs+TNBTmP6Ilveuwl3cr/1BfxbNeTBE2WcMqx/Ifx70W26FMKPScIvOVvZj8bJ0T1p/tn
 xqYe9p0dw42TXOcciO4umeBbnL5VUXkHUgUbkvYI8g3M0QpBbobSz
X-Received: by 2002:a05:622a:1189:b0:454:ec22:dd79 with SMTP id
 d75a77b69052e-458602cdc3emr368334881cf.24.1726683682093; 
 Wed, 18 Sep 2024 11:21:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTV6cnIrZgiJxsH0EvUfb5XM4+ZRfqJlUJ+C+g53UjbbKM426z5IsnOHTcj06OV1BVDLTNnA==
X-Received: by 2002:a05:622a:1189:b0:454:ec22:dd79 with SMTP id
 d75a77b69052e-458602cdc3emr368334641cf.24.1726683681733; 
 Wed, 18 Sep 2024 11:21:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aacf56fbsm50748371cf.69.2024.09.18.11.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 11:21:21 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:21:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 0/6] Migration 20240917 patches
Message-ID: <ZusaH3Kp3lJnaXHL@x1n>
References: <20240917215506.472181-1-peterx@redhat.com>
 <CAFEAcA-vBV0DieO=-bwdV46T08A6pR0EnRUNNrE_Q++SAC0Uxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-vBV0DieO=-bwdV46T08A6pR0EnRUNNrE_Q++SAC0Uxg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 18, 2024 at 06:53:31PM +0100, Peter Maydell wrote:
> On Tue, 17 Sept 2024 at 22:56, Peter Xu <peterx@redhat.com> wrote:
> >
> > The following changes since commit 2b81c046252fbfb375ad30632362fc16e6e22bd5:
> >
> >   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-09-17 14:02:18 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/peterx/qemu.git tags/migration-20240917-pull-request
> >
> > for you to fetch changes up to 7b8b4c0e59d2b7928836072536a5528820d8a041:
> >
> >   migration/multifd: Fix rb->receivedmap cleanup race (2024-09-17 17:50:45 -0400)
> >
> > ----------------------------------------------------------------
> > Migration pull for 9.2
> >
> > - Fabiano's patch to move two tests to slow tests.
> > - Peter's patch to fix qatzip builds
> > - Stefan's multifd-zstd fix on unsigned diff comparisons
> > - Fea's bug fix to consistently use memattrs when map() address space
> > - Fabiano's bug fix on multifd race condition against receivedmap
> >
> > ----------------------------------------------------------------
> >
> > Fabiano Rosas (3):
> >   tests/qtest/migration: Move a couple of slow tests under g_test_slow
> >   migration/savevm: Remove extra load cleanup calls
> >   migration/multifd: Fix rb->receivedmap cleanup race
> >
> > Fea.Wang (1):
> >   softmmu/physmem.c: Keep transaction attribute in address_space_map()
> >
> > Peter Xu (1):
> >   migration/multifd: Fix build for qatzip
> >
> > Stefan Weil (1):
> >   migration/multifd: Fix loop conditions in multifd_zstd_send_prepare
> >     and multifd_zstd_recv
> 
> ERROR: pull request includes commits attributed to list
> 
> specifically:
> commit ebb47ddce00a1d681124f2e248022a0a5310daa8
> Author: Stefan Weil via <qemu-devel@nongnu.org>
> migration/multifd: Fix loop conditions in multifd_zstd_send_prepare
> and multifd_zstd_recv
> 
> (git log --no-mailmap will show you this. The check in my scripting
> that catches it is:
> if git shortlog --author='qemu-.*@nongnu\.org' master..staging | grep .; then
>     echo "ERROR: pull request includes commits attributed to list"
>     exit 1
> fi
> 
> if you want to automate finding it.)
> 
> Can you fix this and resend, please?

Yep, will resend, sorry for the noise.

-- 
Peter Xu


