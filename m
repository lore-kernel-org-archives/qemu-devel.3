Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438CAD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ41-0000ky-3H; Fri, 11 Oct 2024 13:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1szJ3z-0000hu-45
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:27 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1szIu0-0000Ot-J1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 12:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Ny+BSiVefvk0ZMxyxY5jJ/ox0PnbAIotPo5Wo2LKZTs=; b=A+gz1v79zbYY8F2z
 GIoA5M4hlx3+UQfnBxbtaJFeUnuHTz9/kKSUtayM6WazHwSf0QfQQ+XxYmUirY6v4y8x379ObIAvb
 jAnnBuA6qC8oIcjdeKvlUVFRoaiJSfgybsF0QGQqP/6kvdnn+J3tfCKx6sxnbu5kq0WSsapyIq++N
 yT4FeNmCqANyeD/aC01BPuEaBDIH1O1vwluPL5LdVnIe5Mqawc7sd+jakPRZi6wiIK8bs48r5d0ey
 ztR7XfcEpXONdQJa4/NgMkDZCX9ySg071DwXGPKAFb1sbGzvJz47rQ96zgaMdysw9C/tjXyqU4TfA
 gBQIVhwnEeagAicTGA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1szIto-00AZ2q-2i;
 Fri, 11 Oct 2024 16:53:56 +0000
Date: Fri, 11 Oct 2024 16:53:56 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: Yichen Wang <yichen.wang@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v6 00/12] Use Intel DSA accelerator to offload zero page
 checking in multifd live migration.
Message-ID: <ZwlYJCpoNB_TkIBR@gallifrey>
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
 <ZwlTCgqjbFbJduyI@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZwlTCgqjbFbJduyI@x1n>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:52:40 up 156 days,  4:06,  1 user,  load average: 0.03, 0.03, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Peter Xu (peterx@redhat.com) wrote:

> The doc update is still missing under docs/, we may need that for a final
> merge.
> 
> Are you using this in production?  How it performs in real life?  What is
> the major issue to solve for you?  Is it "zero detect eats cpu too much",
> or "migration too slow", or "we're doing experiment with the new hardwares,
> and see how it goes if we apply it on top of migrations"?
> 
> There're a lot of new code added for dsa just for this optimization on zero
> page detection.  We'd better understand the major benefits, and also
> whether that's applicable to other part of qemu or migration-only.  I
> actually wonder if we're going to support enqcmd whether migration is the
> best starting point (rather than other places where we emulate tons of
> devices, and maybe some backends can speedup IOs with enqcmd in some
> form?).. but it's more of a pure question.

The other thing that worries me here is that there's not much abstraction,
I'm sure there's a whole bunch of offload cards that could do tricks like
this; how do we avoid having this much extra code for each one?

Dave

> 
> Thanks,
> 
> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

