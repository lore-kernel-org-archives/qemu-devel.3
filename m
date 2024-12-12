Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A886BE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkRT-00006y-Eh; Thu, 12 Dec 2024 09:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLkRR-0008UI-Rq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLkRN-0004Sf-7W
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734014718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oKaCihk9UQ4tddycHJ1zxQPzvGSomyjFd6ar/iBmvgU=;
 b=b5mFTpGhtEQT9WgFvX5OySI+eIMkx9md/p5+Gv4wkEPPwih5ulF9a5fR7uiZBbYPMJ3k4M
 d5CVrIFDZF4eWmg4r9QfZAYJWZgFqzwYo8vIwzz8Q6+7ynqUZMWs+XUSTksiD8A2g80izK
 cziun0XznQlDaQma2bf+fumWiWjlecs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-q2D2c6dDNV-8przlxqjSzA-1; Thu, 12 Dec 2024 09:45:17 -0500
X-MC-Unique: q2D2c6dDNV-8przlxqjSzA-1
X-Mimecast-MFC-AGG-ID: q2D2c6dDNV-8przlxqjSzA
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4679db55860so9951631cf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734014715; x=1734619515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKaCihk9UQ4tddycHJ1zxQPzvGSomyjFd6ar/iBmvgU=;
 b=glCoI0bu7K26K3g3t9qAdyo9b4SB1aqpkljp2Wd0h2pXucIB2c4zfe3Fb7mZxxcIi4
 VwyhYaDEBDgpWYlALDGhuvGdiR4CakN9OWdFtBShTwUg4l8zlayGkKCccZo6wILSMt8g
 8kQuVXabNt+9zVC/SniysdJXwfHb6jg4ZN5+BtdFGrcq+RhzDks/pWDm9VSlwdbEBFNx
 XPkrOmh1bhnMFPSuyEk/0Tx4Hw+VyZvIsAiQ0sIXbn5kIWKL2rA9DBNXfjV57ONJYAkM
 7o3ZYWAUXWE6sSn0NcHVqgn9i1Asmr2sU/NqlINa3wbjHI4LEDTIDW3jk9SXabi/1LCd
 0PSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAj7nHQz0aFaBWdO17ehLQD3LH3hT/9AD97fkFXNYLfKLVQG5xuE8n7O9mglNoqid+IwNZJR51eptV@nongnu.org
X-Gm-Message-State: AOJu0YwErsNEXLc4TEd4J52HuZdgnn71arLB5gjZzR5/iyPdWDamH+kY
 PaKbQWH5Cu0pRodHO1YmKY8sPrNxjdhWesMJTTNhIjGiQM2fawLtF4iknppJkkqpZApcNGT4Kgx
 OvyVmBZKHFXefHJeQPcUjHW16jo8+ge1e0tHnpjOCdqX71wN1cWwF
X-Gm-Gg: ASbGncuR15/ItvxkGdsGDyhHV2kwv5cxZdzdnCOSCNYx4eJkplqBE2FFb/iAzCiTH9E
 QiCGFGnMU09v+IRIvUt3GAxccuHwKGR++j9Zt6UV+B0eXVF1Fhapq1XCBdXfSzF9aXJ/AoTrsyx
 XBExTWT6rucTNou7jkwI+AhU4yhH491SBLOCIhSxqHaMGN0Y0d9BO16ifcDtBMr2qeKSdvGb0QM
 PolJ/PzIEyBJh07eiLTxhggrBluZ8ypiDZrgvtoXaHFHX3MHzfauaW7SshnluNcLRcjSNUtDATM
 XXtmwicyX+vMS2vArg==
X-Received: by 2002:ac8:7f0a:0:b0:467:63fb:68d7 with SMTP id
 d75a77b69052e-467a16e8f98mr9154061cf.50.1734014715528; 
 Thu, 12 Dec 2024 06:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYKpgMJMSWzP9Tg+uGgtsOkAeiE+XmJ6XRDmI2wIMwn0HdJxms7NlLelqlZ+xF+ycXkYDQnQ==
X-Received: by 2002:ac8:7f0a:0:b0:467:63fb:68d7 with SMTP id
 d75a77b69052e-467a16e8f98mr9153471cf.50.1734014715113; 
 Thu, 12 Dec 2024 06:45:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4677fd42b1csm27757851cf.82.2024.12.12.06.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 06:45:14 -0800 (PST)
Date: Thu, 12 Dec 2024 09:45:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, s_sourceforge@nedprod.com
Subject: Re: [PATCH 0/3] scripts/qemu-gdb: Make coroutine dumps to work with
 coredumps
Message-ID: <Z1r2-MPZ5sZZ8Qpf@x1n>
References: <20241211201739.1380222-1-peterx@redhat.com>
 <87pllyezmh.fsf@suse.de> <Z1oGrWlUaB5O3n5X@x1n>
 <Z1q65CpTxqRtMes_@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1q65CpTxqRtMes_@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 12, 2024 at 11:28:52AM +0100, Kevin Wolf wrote:
> Am 11.12.2024 um 22:39 hat Peter Xu geschrieben:
> > On Wed, Dec 11, 2024 at 05:25:10PM -0300, Fabiano Rosas wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > Coroutines are used in many cases in block layers. It's also used in live
> > > > migration when on destination side, and it'll be handy to diagnose crashes
> > > > within a coroutine when we want to also know what other coroutines are
> > > > doing.
> > > 
> > > Not sure if you've seen this message on the list:
> > > 
> > > https://lore.kernel.org/r/f0ebccca-7a17-4da8-ac4a-71cf6d69abc3@mtasv.net
> 
> Let me add Niall to this thread.
> 
> > No I didn't.  I only started looking at this because I got a bug a few days
> > ago that I need to look at the main coroutine where dest crashed, then
> > Stefan told me this script and also told me it only works with live session.
> > Ideally I'll need coredump debug-ability, then I figured it isn't too hard.
> 
> I agree this is useful at least in the current state of things, and
> possibly in the future for QEMUs built without support for new gdb
> magic.
> 
> > I saw that it didn't yet land gdb, and it's much more involved even if it
> > could be more generic.  Not sure how the block developers think, personally
> > I prefer this much smaller change because it works on old systems, where I
> > can easily install gdb with package managers.
> 
> I don't think this is a question of preferring one or the other! Your
> simple change works today with existing QEMU builds and has fewer
> requirements, but it's also more limited in functionality.

Ah, definitely..

I had no intention to mean that we should only merge one, but more of pure
thinking what I would like to use in the near future, even if the solution
landed at some point in both gdb and qemu.

I'll still need to look at the old systems that miss the generic solution,
so I'd still prefer using the scripts (which currently satisfies most of my
needs..).

> 
> The gdb changes look really nice at the first sight, debugging
> coroutines as if they were threads is exactly what you want in most
> cases. So I'd love to see this. Of course, someone would have to first
> understand what needs to be done in detail and then implement the QEMU
> side of it once the gdb side is merged.

Yes, I wish that could happen some day, that by default gdb on top of QEMU
can dump coroutines.

Thanks,

-- 
Peter Xu


