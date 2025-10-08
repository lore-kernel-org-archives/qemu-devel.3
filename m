Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE80CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WDD-0004BQ-Et; Wed, 08 Oct 2025 11:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6WDA-00049w-KC
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6WD3-0007JR-Jr
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759937763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MezzK3irIPwwezulJQCI55e/Ye15lkL77Yp9Mf88s1w=;
 b=cNiVirfQo7dsVP6/3EYOhwpge4yazej8iFK6d4LSZZEX9B24Uxj3vFGQmmvXUXYxuSbj9q
 TNVDwzHc7yeOdwstaK4KUfU+gax9qs+yeFU5tzRUDv8bzYM3RSLc12tpixmtUrUAswktjW
 fRMsybrx9xYHMgNQs+UgM6+Nb1A+0Aw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-KwV7o6T3ML-igD4C_Z1uyw-1; Wed, 08 Oct 2025 11:36:02 -0400
X-MC-Unique: KwV7o6T3ML-igD4C_Z1uyw-1
X-Mimecast-MFC-AGG-ID: KwV7o6T3ML-igD4C_Z1uyw_1759937762
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e0fcbf8eb0so198139031cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 08:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937762; x=1760542562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MezzK3irIPwwezulJQCI55e/Ye15lkL77Yp9Mf88s1w=;
 b=uEtTU13TMGhMPUCPjpzMv52Ftrt8LV6XMfy3fo7meSN75rPhqE1O+uhHlZr3O3juH7
 0gJIP6TaK1oNvMO9NDJjaVOsXgU5hn32y8Kfr1vtr+xViV4tWhVQjQqTuqjIRv/1Pu2M
 HSvO4OfmyjKIMe5UgIPQa+dFHpIffz68PjFh2lKKSMChAUi5bUlP3MCS8bQKXcekLZe1
 Co4d+/KZbo+KizbNgbxVzA4AMSk2GZIEoFg11/HghULKfcL1Y962pXHPJ7VUZXr3vVNR
 tCLvHnger+t2hYdnOZqE0gBJfoX0r+XF0uBleAQighIs7ndFFzKlvz5SG3dhTCqOtSIl
 A3mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYraCI+yjc8j8p+PyHAkoYH1JOyoIvOO1eoRLRhBpBJ8yxVrwg4LzLtyyzYCWNFu38BHkiStkak3Lw@nongnu.org
X-Gm-Message-State: AOJu0YxJ6+CVgzEtUpZwXGzgbGwpdmsas3PV1EHpYDM1Hs/r/lG+GlUG
 VJDRAOGa+LvUCpcFqhH3LR7PPp0OAkEF/SvfxzVAP04bl8uZK7lu2m7nHwjgTRoEWy9I1OAOJw7
 hS3cv9bMe0k/Boq3T3PevDEDnOgEPJVgC3TMFJ5ak/sQh5Ra2zl86k4pC
X-Gm-Gg: ASbGncucj1H+ajKOYuwMnljf2KOKMs1Ju0uuCVO8OGCh17UWRkYfPUgQzy8ZRQl6GA2
 CYDzl0h1Rl8XUfX1rtJsYpmdkEzBlDp6+9Ra2ll/NICkOZw2YwSZFnB1FNw+oC7m1jcVOBKpKGB
 IJ83lrBuQAEjpgRa/p3cS1+4Psj1gYczVLeRt7HnZu9Qs0XEIZmFNEHXas1cgoE2q+MPT48WH3h
 SfgdmGiHMCsqiEAPTe5y6i7QCOsXVcWf6WsfEBVg1oN4BmEtPS7LCKRQcnL5SHcwdZ2+/x3w0Lm
 hR6HYqKdy7u7oh8GxaSewL36q4u3CYrnXXzQng==
X-Received: by 2002:a05:622a:2cf:b0:4b4:9522:67a with SMTP id
 d75a77b69052e-4e6ead12f0amr56661561cf.33.1759937761617; 
 Wed, 08 Oct 2025 08:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESo/YtINgRPB2VgJJenYFGSNcEHDVXfPeWAN8BQG4MnNfVi8VzdP6HaD6z3gZw3eRx2b9fGA==
X-Received: by 2002:a05:622a:2cf:b0:4b4:9522:67a with SMTP id
 d75a77b69052e-4e6ead12f0amr56660861cf.33.1759937760979; 
 Wed, 08 Oct 2025 08:36:00 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e55a34c706sm167855561cf.8.2025.10.08.08.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:36:00 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:35:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] migration/vmstate: remove
 VMSTATE_BUFFER_POINTER_UNSAFE macro
Message-ID: <aOaE3_qs8N24b-UN@x1.local>
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <20250802142115.41638-2-mjt@tls.msk.ru> <aNqsXPt3LGJv4F1O@x1.local>
 <78e722ee-cd01-43f4-abfe-efc019cce48f@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78e722ee-cd01-43f4-abfe-efc019cce48f@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 08, 2025 at 11:10:19AM +0300, Michael Tokarev wrote:
> On 9/29/25 18:57, Peter Xu wrote:
> > On Sat, Aug 02, 2025 at 05:21:09PM +0300, Michael Tokarev wrote:
> > > The only user of this macro was VirtIONet.vlans, which has been
> > > converted to regular VMSTATE_BUFFER.
> ..
> > I'm scanning over lost patches on the list.  I suspect this is lost when
> > you sent v2 replying to v1.
> 
> This hasn't been lost due to v2 vs v1, - the reason was that the first
> patch in the series was trivial, while the second (this one) is a bit
> more than trivial, - so the first patch went through qemu-trivial, and
> the second went nowhere :)
> 
> > Wanna repost with a full v2 to catch Michael's attention once more?  I also
> > always would suggest a cover letter..
> Yeah, re-sending it is ok.  Dunno what's the reason for the cover letter
> though, for a single patch.
> 
> Thank you for your attention - I'd lost it myself without you ;)

We might have lost each other somehow.. :)

I am looking at this series that contains patch 1+2 on v1:

https://lore.kernel.org/all/20250802142115.41638-1-mjt@tls.msk.ru/

v2 of patch 1 was sent in a reply here:

https://lore.kernel.org/all/20250803085443.318611-1-mjt@tls.msk.ru/

As of today's git master branch (commit 37ad0e48e9), I still didn't see
patch 1 (v1 or v2) lands..

Thanks,

-- 
Peter Xu


