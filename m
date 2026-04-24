Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614DBFED3D9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGHrb-0005VS-6f; Fri, 24 Apr 2026 10:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGHrY-0005V1-TY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGHrX-0004rq-0o
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777042233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KCXDbZgtAm7lVyKya+bTZ8qucF4E8+y/GvCHycvUWpc=;
 b=hlIE/b9aPNI7cKhNiHnPXj12AxUEvVh9dhRPb99QSZVmFW7s5HvFMSj7Jc9LKjr8aDsOl2
 dKQAbGWmRgU8k8DleWfOkwwpRX/8+sGzWGbYSZctCvE8kmyhGAFKmjci2E//BQSNfGnjaX
 11QPYFtQ5GN6piTNMl7MS/8Lkchhh00=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-PAmd63h6NDey1bec4bzxmw-1; Fri, 24 Apr 2026 10:50:32 -0400
X-MC-Unique: PAmd63h6NDey1bec4bzxmw-1
X-Mimecast-MFC-AGG-ID: PAmd63h6NDey1bec4bzxmw_1777042231
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8ed2c173d3bso1081037985a.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777042231; x=1777647031; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KCXDbZgtAm7lVyKya+bTZ8qucF4E8+y/GvCHycvUWpc=;
 b=EEtLgD/hPtKTMogE1PGEXZ2cF/3nyzAqrXJu9Kb6KKiB0HDFWVdUmnLA7/myksMYiS
 1sxvYAk6rgJ797m99xkl/jHFQh2+H/cOe7LM8vQG6x/hNFuH4SKGNNajsiuBlIuDJTKz
 8Am/SOQ7ZdciBBjA+dYCveuJWuW3w6n1jHv7/43QIkIuO+6terIaeuHAnrhncILBdSC1
 P/h++NaQneCqbcbO2X3DOHQ2pLY6ZceRMl0VGg4HuB9Fi/XqV8UC3+Xn2hjeQElMawRJ
 LzsdjHCi7J9diawSWTBOncllWKwnLsp+W2dVihmWFcGANLvrJVpMHLsVwJJCCZok8dU2
 niuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777042231; x=1777647031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KCXDbZgtAm7lVyKya+bTZ8qucF4E8+y/GvCHycvUWpc=;
 b=YTs/uzdxEckfWhwb8l/Pk3Xnr97PwHEFriCnvE9QIVrLOy7unUg7QtzhimEyYq8rtk
 a/ZNGxQsZbNwIKrT7RSuBt2ntCoVKhxe6bTqIIBA8MWlN/1wk3jNjqBdt3QUViwRgKAr
 6PsOWVdcMR/kRp5abwAPMfjQawn7aURztcZiB6FIdyjyZ/uKhqedRNjNSh+GTRTCqvXM
 bExBwELeOSgKCvyo+UlN3mmyBqe17KwHVVvNcLwflKZza9rL/sfmHp8RYdxF6xMzyHur
 Y3E349UHZ7OJ1LsYBJHMhEF2B04zu2zQUtUABO2fdSzenVNVI9WaRjvZBnVNyWs9byCa
 UG1g==
X-Gm-Message-State: AOJu0YxOpvK7tp+mP786v2Lupx28MXyfLb/SgiDCjR2PICZ0AUVV0l4W
 HKFor7brZegFHfhxuxobtS8Dt5G3uO3mazviSVnRxmVrqOKv1Qw9SGakkqqSA00OWYbrt708/TI
 hzbw/T3481wPJe837lH3/3fCTOnjsExHiCMGt4y5pmN72Pg6byLVSXPB8
X-Gm-Gg: AeBDievzfeYn7fgc9lokPBHzgvIQxo0/KJK5aDKiY7Sl6myJNsYCF46Px6JzkvtZYO/
 yqs9GdUYdBnROR89Hk44Lok+GsITArokFq4aaEd8Pb8BjPyQPb4xerJLrhHprdLn2mD8mAbJv0g
 zU6yB3UnqFnp5IvYzV0H7Z67Op93ma47T3d9VeL0djaBMiwdeZ+XQT2FLxBCdWCeLnPy/CCARM6
 7xYEiw9nQm1QTCcEBYGxn1qvne+biToS03+3Qzeifd3nnsuwvQ/tSBVtgdQbdJN4sSmWovU5ASG
 QQeMTg7P1BLD10//uBVHSLy88MihTEiaWISLm04b9DjxWyPsnqQLpuXCWBRw2VG+e43KMxYVLdj
 7OvUUR6PZgkUHKFfffG+Wg6Sf4cQg2IVUtVx3YbjIprGjt/D5jDcj9yJDTw==
X-Received: by 2002:a05:620a:1726:b0:8eb:c501:3348 with SMTP id
 af79cd13be357-8ebc50137d0mr2967469185a.2.1777042231474; 
 Fri, 24 Apr 2026 07:50:31 -0700 (PDT)
X-Received: by 2002:a05:620a:1726:b0:8eb:c501:3348 with SMTP id
 af79cd13be357-8ebc50137d0mr2967460485a.2.1777042230859; 
 Fri, 24 Apr 2026 07:50:30 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d64caf37sm1859674885a.11.2026.04.24.07.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:50:30 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:50:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 01/16] qemu-iotests: Add query-migrate test for
 dirty-bitmap
Message-ID: <aeuDNFloM0DqeSI3@x1.local>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-2-peterx@redhat.com>
 <19b36c4b-1aed-43c0-9eca-4fbd3688d877@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19b36c4b-1aed-43c0-9eca-4fbd3688d877@yandex-team.ru>
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

On Wed, Apr 22, 2026 at 11:08:56AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 21.04.26 23:20, Peter Xu wrote:
> > This helps me to identify a hang issue with some recent change in
> > migration.  Add this into the test suite.
> > 
> > Cc: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> > Cc: Eric Blake<eblake@redhat.com>
> > Signed-off-by: Peter Xu<peterx@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks, Vladimir.

I just noticed Kevin and Hanna are not copied in this patch.. I was
expecting git-publish and auto script did it..

Kevin/Hanna, do you want me to pick up this patch together with this series
if I'm going to queue most of it?

-- 
Peter Xu


