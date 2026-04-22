Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CDAF9EDC4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXTb-0004JL-KV; Wed, 22 Apr 2026 09:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wFXTa-0004J1-Kn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wFXTZ-0005ub-1r
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776863924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNyFqTHx4UXjE/XDN2rjkEy4wsvy1WU2NWc+wQB2ffo=;
 b=TSAI7HODchQnNMDi3RJY9Md3DOH8CltX8ui0vK9uIEfKzc4drX+HQKnte8sHIMdeeQF8w5
 ti5NqPGa+2dEshlg5oB1bOgzFb69jenhdWfwu9v/SLZo58v/RHgU1Vog5jAbUIl9gBfHcE
 U93t3nvJaxuJDgTOqVjNGcdWyDF0yDU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-AF10AIt-Nn64lDSHR-UmEQ-1; Wed, 22 Apr 2026 09:18:42 -0400
X-MC-Unique: AF10AIt-Nn64lDSHR-UmEQ-1
X-Mimecast-MFC-AGG-ID: AF10AIt-Nn64lDSHR-UmEQ_1776863921
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c79907d4c57so1256719a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776863921; x=1777468721; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNyFqTHx4UXjE/XDN2rjkEy4wsvy1WU2NWc+wQB2ffo=;
 b=ZYEp+QGwD2NIYbY7ojTVMeqZN/kfG3M+Ze1Uc8dav25AuHH9rI/sX9vEjYf/dHegM3
 Cy+a8ohd+efCB0H9x0T8xKidz6fpWJZ/A1Ib/63pnTEkUySK6LWjxEz4h1Lf+ydYtESd
 +qtfWIrWNZivsCh1LkuI4rjDhkZ/v+rAPETyQJwpLDmRoY/iHsB4N2lx+UEDm92NCoHX
 w5jDtcvuuIMnf0eKeeViiVfRvUJk7ALOH2asxwjD+EURGuGpxwy5euBPqpckJBtXw1u+
 //TRBXlt7Gw0IGhZ0VWREyXVisOfWhps1wLZZ9Jc0S04SFDiUBKV2gMUhKqKFbFWud1T
 IZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776863921; x=1777468721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNyFqTHx4UXjE/XDN2rjkEy4wsvy1WU2NWc+wQB2ffo=;
 b=sn4UdX4VjPIHM6fL/nyWnF0zraBSe8iw9IcFfa2YwMy9tlOehToHCnW4Sh6X9hoyL+
 6TUJI2gAbM+ZinQOzYfzdZBiQae06vF4SFy+IFzClmjgXR+CXqXVX98w18x0/MTflmaf
 P9Qt0iuGxiUs+vlaeEdEWV+e/4PBuUsz6PNmJRibeSS7mjRW1FCTFfX+8oxLy6Iv9euJ
 Tq2XI48l4W+pllltyRJyulLz6F7XzAfmPuxRiCtdyeCE9HNMboyOo4NQgpkITBSVIC+h
 GoeDHQib4ppvhr/PE5GfHJy5IRKy5xAWDdgAmWE1Xia/D92P91TuAahbIAUveR1FN3gP
 fRSA==
X-Gm-Message-State: AOJu0YzDc6zURXjI/PanVDt2VpAg7fOwDsitnmS8uyqf36jv1eTWctu/
 MG5lMe3BTbXNScYDs7bYKGGbIs5c2SVDvbbvjJBn1Keq7UgIZF+ECPPEnOJJDsc4usnH9yCrsVR
 Zg11rURpr3cIwaQeedO7zeWt5xWKhfWajb5PNVd/xxvqy9REMmrCcIO0j
X-Gm-Gg: AeBDievtkS/BtOLELGSfcQ1MhrUqRL/BaF5sSdZVUlzNBQ3v/yJMeDBLJR+JpTDcSsM
 T7fiU/R4S3MajItapJbTEgr2JktWHTI2/N7yPgIl0RVm4pcRPGqkAussL18vSiN+d47tVx50DWv
 K2lEJrv2cXNa12pdd0HwVA9QlDHQwJo2ozl30CNammkvHrIH3OMc0FrvwZjZZa8LJnSHcJ5MjFP
 j1mTvWTCjNka8hKNJrWWqrM/YUP2bn7PMw/Vko++EAcvuIhjUexyWZMm1fdfQy7xuyjKnvVRRIW
 UnQwIASnC1s5xbSkVEaokGjqR0flUVHRzQXWduyHG3nSHOHI2bKPUxEieN86GqnrjErfhta1u7C
 R2zZcbMgzwU+q1iF/g6GBQUHczzTSvDUl+fYLFuICE7BH5NNTjTkufn8f
X-Received: by 2002:a05:6a00:1715:b0:82f:95d8:6c79 with SMTP id
 d2e1a72fcca58-82f95d873a9mr15544619b3a.43.1776863920909; 
 Wed, 22 Apr 2026 06:18:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:1715:b0:82f:95d8:6c79 with SMTP id
 d2e1a72fcca58-82f95d873a9mr15544589b3a.43.1776863920291; 
 Wed, 22 Apr 2026 06:18:40 -0700 (PDT)
Received: from fedora (193-179-61-20.customers.tmcz.cz. [193.179.61.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe40e5sm15978742b3a.42.2026.04.22.06.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:18:39 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:18:26 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>, 
 Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 13/16] migration: Remember total dirty bytes in
 mig_stats
Message-ID: <aejKcOtHWJwzHDt1@fedora>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-14-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421202110.306051-14-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2026-04-21 16:21, Peter Xu wrote:
> Introduce this new counter to remember the total dirty bytes for the whole
> system.  It will be used for query-migrate command to fetch system-wise
> remaining data.
> 
> A prior attempt was made to not use this counter but query directly from
> all the modules in a QMP handler, but it exposed some complexity not only
> on migration state machine race conditions (where the query may be invoked
> anytime of the state machine), or on locking implications (where some of
> the query hooks may take BQL, which is illegal at least in a QMP handler).
> For more information, see:
> 
> https://lore.kernel.org/r/aeZMtxqrKWAMKzdN@x1.local
> 
> This oneliner will resolve everything, except that it is not as accurate.
> The hope is it is a worthwhile trade-off solution, after knowing above
> challenges.
> 
> Now, there is one more reason we should make each invocation of
> save_live_iterate() to be lightweight, because this counter will only get
> updated once for each loop over all save_live_iterate() hooks when present.
> But that's always the goal.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-stats.h | 7 +++++++
>  migration/savevm.c          | 7 +++++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


