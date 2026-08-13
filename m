Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE54C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuUhs-0002SC-TD; Thu, 13 Aug 2026 08:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuUhr-0002S1-B4
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 08:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuUhp-0006h3-Ds
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 08:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786624724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=trjjxngqOpieTGmWouobpunznjp2FlaDHq4aAAMCK6E=;
 b=gx/k8aWPUeLtnKKlJ1JliyigmFMVUjcX9Sb7jCKRyBG2+CxdHAFTqZujHHQGSJfomVQj1A
 L74iN9D8yfbOPx+M3wd4Su67lMNdbA0ufOHectI2YcwHdmeY5oPF4uzsuw6L174OXU361Z
 hOLegEVjbIG+1ENHMZBv7CeMlp/f7X8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-x2xQd9D1P-euMe0ZYsJyYw-1; Thu, 13 Aug 2026 08:38:42 -0400
X-MC-Unique: x2xQd9D1P-euMe0ZYsJyYw-1
X-Mimecast-MFC-AGG-ID: x2xQd9D1P-euMe0ZYsJyYw_1786624722
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84870e7f498so814635b3a.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786624721; x=1787229521; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=trjjxngqOpieTGmWouobpunznjp2FlaDHq4aAAMCK6E=;
 b=t3b5W1OtOGbQoKyhvtZjPkuOKIWJ/NOZuP47+VYCSQeoXRc2OTGFAgDQ6vgJzNGGnb
 +45tepaM/z7R32BxdRMzKcyjfbOdBWLOAkDdvYBMrMNBrZB6Au5NDy8jPPFmeDWEfWcp
 H/VGV60SAOTR3sN2rtga3tCiJECcNyXzJK4yLaOvcv/zEnrWOcLQhcQM0CEcv2J32CCw
 /QywVpT5Ixs5AIW6GnLoSRTZ2czymdu+ITcxMV/h078OCnsqHvGuHYdFoWWdUfoIAV9X
 r6rf2qokr0a6lj8NhrPMZl5VnI7cbioUeogJy8rpjkY6DK3vyLj7q8Q8xjLPeembhxJy
 ykHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786624721; x=1787229521;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=trjjxngqOpieTGmWouobpunznjp2FlaDHq4aAAMCK6E=;
 b=PytNyk/xloYrqxL5Us8Ly4CNIplgJaANBbW+nl0F+VjZtDJYztleGqtwPxhJODmADf
 j6UtzPFynPNgipi4jzkyDUWjZ4RiaB4MZjKzGTzU2PGL0lo0REmujv7GZ5us10VMnB6D
 Iz1+kDAB6xgNYkyS2LZw3pCPttoqiLtwpncuvNobR3GGQjDy5VeMBYUwXMlrWny42W9z
 jcntxyZKZj2RiTh+RtqgNDz0mIKHnCfOIX7cLTlWNRb7FGImtkX+TcQSJtZh/66ZzXaG
 DaEPSBljAiYV9TS61Yk8eSctg0mFt7N17xB94QSz3WNQfEq/O2PAU1jJDL9zSnN7qP3m
 ak1A==
X-Gm-Message-State: AOJu0YzSXg01WFlQUx5t97Am32bNOiMb158XEqvsfJ3J8jt9yBZioIyX
 p6NdcMtNcDsi9P7iBkWWcizq8+5c1Ld0ioJdnEzQkRm0f+FdmTO3ELMlroo2dyrmzhK1bVgmElI
 euiE4McIuAWEtVSZ/ZTWi+v3ro2FRfWM1BwnetTO5GUKkISCinaP1NLVl
X-Gm-Gg: AR+sD11n1wAQFicvXpdx27RPNfiLA6wgJ9XUcrzs7J/wwRg63ubeOzBVO+1HYPtiQyG
 O1rVemwBkoYEhHkmZa7WzaPrZ1LEgPSZr1FKecT6vB/2GLrftncS0E93/CvUOeonXuvL7TAfrRo
 ggm87OYvcQGutWDP8KFwBevCCYLphixSQTIsMjwCrSTRqHlCqz2ljgxyBk/bybt2x/UspFqOYIe
 AuWfE5nS5mkRINp9kGIokjG5Zs3u80ACd1rr7fzo75tJtxBT8FHWxMxHksqvLDNgTZcfgors1T7
 1DfcJdCun8YSTTpXe07aAYEQ4EhfkTzpPAYSPPrmqaaLYlrSVPaGvA0McegheyUA8zMYb3VEG9J
 3zB2Ci1GpPl9CfXUrKJImE/3HtLZBcL8zWofgsw0ynuyxqtkCZoVlWmqyAVY=
X-Received: by 2002:a05:6a00:1398:b0:845:eb88:3d74 with SMTP id
 d2e1a72fcca58-84fc716682cmr5189285b3a.29.1786624721427; 
 Thu, 13 Aug 2026 05:38:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:1398:b0:845:eb88:3d74 with SMTP id
 d2e1a72fcca58-84fc716682cmr5189210b3a.29.1786624720779; 
 Thu, 13 Aug 2026 05:38:40 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc5aa1d51sm806114b3a.58.2026.08.13.05.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 05:38:40 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:38:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/10] Next patches
Message-ID: <an26zg9zVW-JrV9f@x1.local>
References: <20260812151444.2611689-1-peterx@redhat.com>
 <f0a852af-1859-4133-9d96-be8b9231888d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0a852af-1859-4133-9d96-be8b9231888d@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 12, 2026 at 03:01:14PM -0700, Richard Henderson wrote:
> On 8/12/26 08:14, Peter Xu wrote:
> > The following changes since commit 84f07211cc5b4fc6a371559bf8a5de4fb068e648:
> > 
> >    Update version for v11.1.0 release (2026-08-11 10:04:46 -0400)
> > 
> > are available in the Git repository at:
> > 
> >    https://gitlab.com/peterx/qemu.git tags/next-pull-request
> > 
> > for you to fetch changes up to 2375e9b1239eb6ad794eaae29245b94f429c87c5:
> > 
> >    migration: Fix rare hang of migration_channel_read_peek() (2026-08-12 10:42:09 -0400)
> > 
> > ----------------------------------------------------------------
> > migration/mem pull for 11.2
> > 
> > next 11.2:
> > - Dongli's patch to add cpr-transfer support for HMP
> > - Fabiano's doc update for migration on security issues
> > - Gavin's fix for MMIO access support for memory APIs, reverting ram_device ops
> > - Sam's migration test build fix for !ASN1
> > - Peter's a few migration hardening fixes
> 
> MacOS build failures:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/15865084063
> https://gitlab.com/qemu-project/qemu/-/jobs/15865084064
> 
> ../migration/ram.c:4291:54: error: incompatible pointer types passing
> 'ram_addr_t *' (aka 'unsigned long *') to parameter of type 'uint64_t *'
> (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
>  4291 |         if (usub64_overflow(total_ram_bytes, length, &total_ram_bytes)) {
>       |                                                      ^~~~~~~~~~~~~~~~
> /Users/gitlab/builds/qemu-project/qemu/include/qemu/host-utils.h:552:70:
> note: passing argument to parameter 'ret' here
>   552 | static inline bool usub64_overflow(uint64_t x, uint64_t y, uint64_t *ret)
>       |                                                                      ^
> 
> Note that ram_addr_t maps to uintptr_t not uint64_t.
> Which should be functionally the same, but is probably
> an 'unsigned long' vs 'unsigned long long' mismatch.
> 
> Perhaps we should just be using __builtin_add_overflow via a macro instead
> of inlines so that we get the full functionality of the types accepted by
> the builtin.

Ohhh I almost missed this email... somehow it lost all CCs include myself.
I'll see how to fix and repost, thanks for the hints!

-- 
Peter Xu


