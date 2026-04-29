Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488E7FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICOn-000566-Ul; Wed, 29 Apr 2026 17:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wICOm-00055o-9z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wICOj-0006nT-UH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777497884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5y8TeMtdNznKKpUdVfMdXd80k+gmfFERAnAoUgTP0Q=;
 b=ANLxVFZw9hm8iPRU7JJ/IL4Zmb4t8Pk/DJ9UBiz5FaX7nfKI7lKRMEs0j96UKN7vVve4xf
 pF3oQc2Fk4cxiakVR2JFv+XseZVJsFVYM0dMoJE9Pz3g6x49a5ITSvn2nlgwY/HnbT7v8d
 I6RhkXwU8M37T/3fzQYbP+N1C/R4r7s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-EDR21c2TNEe6G3RxqtfmPA-1; Wed, 29 Apr 2026 17:24:43 -0400
X-MC-Unique: EDR21c2TNEe6G3RxqtfmPA-1
X-Mimecast-MFC-AGG-ID: EDR21c2TNEe6G3RxqtfmPA_1777497882
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8ed08aa4so5885611cf.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777497882; x=1778102682; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E5y8TeMtdNznKKpUdVfMdXd80k+gmfFERAnAoUgTP0Q=;
 b=HmEDueNpbBCJS5RKlDn61e2Z2HAZ2jCknJs8bGClt8tWxcAKyb5+oeu5jiacyGuKFF
 YFQQvvboHMjzUkBqcMbhi+VvYx8T8mj1BFGIC1NoxcVpyaBK/oGewUInBs30yOMLfZfr
 Z4mgO6unynLYewz2ciB+u88neDP0slVsn6O/zbRRdJJnDlbXVWtnVUIaL1Kmnxu43zxy
 H+JMGw13LZly0Pnp707GIX3VbsJNPuag0VfMlvhT7fx1NpfiFzeplylKIbzjty5nCfIi
 jiVCWzrgqgPJOL0T01OQh4xRDWZXsD1HqA50F6UmNpjgkNLSzLyPhi9+mwzbkfk3e9Oq
 KOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777497882; x=1778102682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E5y8TeMtdNznKKpUdVfMdXd80k+gmfFERAnAoUgTP0Q=;
 b=YswTDCwGo8mzxsMmQemIa7IKx7c/Xwpe96kwbnb4ut7pztyWF8tFVCT+moSkV0HZjg
 ZoCm9xu7aBiqCgtA3E7gm4VuLAbLzyKeIJ0v6328mf/n0Qrz/uvxHntzFJhJntBJP1P0
 kpu7iUAva6/LuukrDY0rYtkcnxaFB/lx7r1JRCL9/CHIHoSxxpEhq63Cz4EyHxq2KE1F
 G8r5xm8bNKttbLywrvwt1agh8JAdy9vy8d7zLcaE0wrTTo911Z1i62x92+oNvmfsFa2h
 lcQQqDS9HNWiPENd6JrlWe3opHBBEZV1GRnA0xtdZsE/oVpQIRas39pgG8i/inasTR4u
 Eg8A==
X-Gm-Message-State: AOJu0YzK5LcehZ57liSaCJLwLHC1dvOgKZXAl+0uTanwOC17lxPQMt9I
 iT0q3bes0Zuez/TKuBu1E+e9ChOMftLqt9/SCVUxUqZtCs9f/U/YnIhglUnoN4ciS26JMdDxnax
 kZ39/0/QGYecG1bJEGcR3nZmDD/qM7+FqIuYejrfZ/Z8m4jQk1RaziEGU
X-Gm-Gg: AeBDietyFSFd6k2LO8X+XcLBBk48Tllwbe6adCzodzXiq7QaiY92odmLbEwQUvW/1mU
 n20kBKvQQYmgBFudoJyYZs/aHfzQaCnSA2V0d4Mv/JCka+PT6owOsxH2YHVIvOwwYHWhudOuJKE
 zcdKFia1hDx7koJdIUX2e7RM45O2JdQK7luN1Ezbg8+b0Xb1I1cWkEYEvJhIxD9y6caRkPNHA76
 yS8NuoStj934PIa7G/5npyeKfHU5S41/S2fy84ziH6yuh7i+FzqDkhZMKWgElFDgEH6AKy0+ZRU
 1Pt/mDktipnYni/GlNdBjTa+DZ6Uxudr/3y2X0q+qZh1CMPkAB6WS5e8KzJCi57cwDIr5q2xEr4
 X4P2wsV46xReZ2QoiQvPYPhUaeaS2rzZxrpOYPMhoqhHTk02yvFIYNBeiEw==
X-Received: by 2002:ac8:58cf:0:b0:50d:9b2e:7ee3 with SMTP id
 d75a77b69052e-5102ada8b4dmr2236611cf.38.1777497882419; 
 Wed, 29 Apr 2026 14:24:42 -0700 (PDT)
X-Received: by 2002:ac8:58cf:0:b0:50d:9b2e:7ee3 with SMTP id
 d75a77b69052e-5102ada8b4dmr2236221cf.38.1777497881919; 
 Wed, 29 Apr 2026 14:24:41 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101accd24asm31447431cf.9.2026.04.29.14.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:24:41 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:24:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH v1 2/3] tests/qtest: Individual verbose switches
Message-ID: <afJ3GLYIcN9qeOyU@x1.local>
References: <20260429003130.15164-1-farosas@suse.de>
 <20260429003130.15164-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429003130.15164-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 28, 2026 at 09:31:29PM -0300, Fabiano Rosas wrote:
> Allow logging to be set for specific parts of QTest. Having a single
> QTEST_LOG knob creates an output stream that is almost useless due to
> spamming from some operations.
> 
> Add a backward-compatible way of selecting which parts will be made
> verbose. Reuse the existing QTEST_LOG variable. The new options are:
> 
> QTEST_LOG=
> fuzz - fuzz.c
> qga - unit/test-qga.c
> qmp - libqmp.c
> qtest - QTest device, i.e. -qtest-log option
> test - generic term for usage of all tests
> 
> E.g.:
> 
> QTEST_LOG=fuzz,qga,qmp,qtest,test
>   equivalent to QTEST_LOG=1
> 
> QTEST_LOG=qmp,qtest
>   enables logging of qmp operations from libqmp.c and logging of the
>   qtest device.
> 
> QTEST_LOG=test,qmp
>   enable test output and libqmp.c output.
> 
> QTEST_LOG=-qmp
>   enable all output, except for libqmp.c
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Ohhh this is nice..

Acked-by: Peter Xu <peterx@redhat.com>

Some quick thoughts, doesn't need to do it immediately or at all: make the
parsing of QTEST_LOG var only once might be nice (e.g. switch to flag for
qtest_verbose()).  The other nitpick is would the word "test" too hard to
guess for what it does?  Maybe "misc"?

-- 
Peter Xu


