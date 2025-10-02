Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94BFCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4KnP-0008Gs-72; Thu, 02 Oct 2025 11:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4Kmy-0007qo-7k
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4Kme-00011w-JN
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759417181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMZ20mn2yM9PTyXqN3YAA2c6xt3ZbT5HGmJ6Z4yYTHs=;
 b=AdN649eLhUHBCpPeySNQEOWE9/aGPPEWelMH3HSO4rJmPbcYZw6AWQPkwJgyASdyASEg8+
 E9T5I3fzv6BJIgWgmnCaOTAhBVGgsel8TcaY1vrIAzcryGA0RG5rwlaF8h49oII0Gcd4TO
 u9AmPXHYdJtfsIApxsE2llPOPWNex+g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Qu5anIw-N72K0kmSCZAKJw-1; Thu, 02 Oct 2025 10:59:40 -0400
X-MC-Unique: Qu5anIw-N72K0kmSCZAKJw-1
X-Mimecast-MFC-AGG-ID: Qu5anIw-N72K0kmSCZAKJw_1759417179
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3a049abaso7453135e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759417179; x=1760021979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMZ20mn2yM9PTyXqN3YAA2c6xt3ZbT5HGmJ6Z4yYTHs=;
 b=nn1QeWkkjqb2GUY/JNS3g0a7LY4uz/aN5LPHUzQvideI1mchw2tfjGhXniY+5f1xKD
 HjiLoNH8T5Ie9gkLjBu8T36lVNrZJNxvoG8/Ia38mfFNyLzgg+ie3I9L6N49jShBMr7b
 bLzRQ0/rb/XuVBDPyAlZb4B2ZE1WOzkg8n4I+pzQ1bp6eDXayBPC9Rr6EX6JH51udz3P
 werKADoIORyyUNrq5YXNejRgKtdyO4E1AZQ9aYN9B4ypui2JECsSezwM7JhLyteYBDrm
 yW+qlEF6a0sgM2T73Hxa3MIqQvkd5bHcIuhINoqC/2W5n6MnQlQ5t2r07mgM8jY01xkM
 EwtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+JvtwvXv4vmiEbONF21VghQxs7YVpFXTg6Bg82M+Yauhxi1duJZG0P1QL/UOagyhQsWYzcEoeMZSK@nongnu.org
X-Gm-Message-State: AOJu0YyKU6hrv3+Zc5EGUfrsgGRyB4SJa8ye5qyywUAL3rTLgdbNjDVi
 Ry1ETgApQdU1AP6ObjIYHwK6q2GzeSFMFvdx3DjWTXJsjVavaOJ6G4qkMl1PZa/GeIiAz0xpPf+
 qUvQS/WSbQxz18kwPLrYcGZwKIuWwcLa8V49f6/aHeGdSKT07MF8F/3HH
X-Gm-Gg: ASbGncv9EG8m8AjedcVEAIp9YPqEESM7YLdtzGZXfnUBodCue5OEUS6e6VEbKahcstv
 7Psu4A+R70m8mYXVtbp/1+N+TvgPrgcFqK/o8ZvQHGqL0fj09NVuV3Ic0eg8fsqWpST4WnescGc
 KKk3VdPwtNMu0lVNK3QLeF/8NJbK9m/tfKz0p0A3r5thVzGzZ2Bttbti6jijWWltFcipHD4U+eA
 n+NYjIjRm+vBBhlSVb6gJI25AodzILWWy7qwETY/E+VIk8Rpgcso1VOeHHmRO6/m03NQc1Uw937
 79AhH7MhFABToaEkt4nfwpdPr+Dh2zN2wVsv
X-Received: by 2002:a05:600c:871a:b0:46e:42aa:75b5 with SMTP id
 5b1f17b1804b1-46e612021bdmr68411085e9.4.1759417179223; 
 Thu, 02 Oct 2025 07:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQoHRWItgB5zYhYNXfNqu/Ejy4mz2XBI3KuQ+Uvri3Sq8H99XfzAiRfNugGCfx5ZUBZlmRYg==
X-Received: by 2002:a05:600c:871a:b0:46e:42aa:75b5 with SMTP id
 5b1f17b1804b1-46e612021bdmr68410865e9.4.1759417178772; 
 Thu, 02 Oct 2025 07:59:38 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6b23d4c5sm30679225e9.17.2025.10.02.07.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 07:59:38 -0700 (PDT)
Date: Thu, 2 Oct 2025 16:59:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH] numa: add 'spm' option for special purpose memory
Message-ID: <20251002165936.490718f5@fedora>
In-Reply-To: <aa461a43-0db8-482a-aabc-897cfa619dee@redhat.com>
References: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
 <20251002161140.5b908e06@fedora>
 <aa461a43-0db8-482a-aabc-897cfa619dee@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 2 Oct 2025 16:19:00 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 02.10.25 16:11, Igor Mammedov wrote:
> > On Wed, 24 Sep 2025 18:33:23 +0800
> > fanhuang <FangSheng.Huang@amd.com> wrote:
> >   
> >> Hi David,
> >>
> >> I hope this email finds you well. It's been several months since Zhigang last discussion about the Special Purpose Memory (SPM) implementation in QEMU with you, and I wanted to provide some background context before presenting the new patch based on your valuable suggestions.
> >>
> >> Previous Discussion Summary
> >> ===========================
> >> Back in December 2024, we had an extensive discussion regarding my original patch that added the `hmem` option to `memory-backend-file`. During that conversation, you raised several important concerns about the design approach:
> >>
> >> Original Approach (December 2024)
> >> ----------------------------------
> >> - Zhigang's patch: Added `hmem=on` option to `memory-backend-file`
> >> - QEMU cmdline example:
> >>    -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G,hmem=on
> >>    -numa node,nodeid=1,memdev=m1
> >>
> >> Your Concerns and Suggestions
> >> -----------------------------
> >> You correctly identified some issues with the original approach:
> >> - Configuration Safety: Users could create problematic configurations like:
> >>     -object memory-backend-file,size=16G,id=unused,mem-path=whatever,hmem=on
> >>
> >> - Your Recommendation: You proposed a cleaner approach using NUMA node configuration:
> >>     -numa node,nodeid=1,memdev=m1,spm=on  
> > 
> > that seems to me a bit backwards,
> > aka it's just a particular case where node would have SPM memory only,
> > which (spm) is not a property of numa node, but rather of memory device attached to it.  
> 
> The problem is that boot memory is not modeled as a memory device.

That's historical abomination we currently have.
Question is: does it have to be boot memory, and why?

Also that's why I've asked for use-cases / devices example that would make use of this feature
(VFIO was mentioned here).


