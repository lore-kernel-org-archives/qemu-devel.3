Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA610FCAF0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 22:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w843C-0007RH-71; Wed, 01 Apr 2026 18:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8439-0007Qd-QY
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 18:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8435-0006ax-Dc
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 18:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775082509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zlvF8Y0xzE59VKNYaguPYs8VoY8pGc0i4FcyVlG15Wk=;
 b=hNdhP/MU0mlp6OQVSvdVAsZ0D3wP0ICI3gI0kDthNfDPjJ4vn7DImX8cIUvIuqEvy8KsHk
 1T1/H/S6jhYABt8Rn9mD0AzEvo9E1+fc5VKx+QdrhB6bGJdGh4mVnQjVhzNKNlUSBWZjty
 L34OcNJYjpiQ3I5MTXDTYt3/PHgqryc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-vFPNhyFWNXaIYtwjn4tepw-1; Wed, 01 Apr 2026 18:28:28 -0400
X-MC-Unique: vFPNhyFWNXaIYtwjn4tepw-1
X-Mimecast-MFC-AGG-ID: vFPNhyFWNXaIYtwjn4tepw_1775082508
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4076dc16so10964251cf.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775082508; x=1775687308; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zlvF8Y0xzE59VKNYaguPYs8VoY8pGc0i4FcyVlG15Wk=;
 b=F0Xc0Yc2+4gbRFnlCbsQaphk5x5mnpIAIPLSGC93He4WtfVPN4h08+ZIE3VBuumFie
 vQumxH3apUrCl0KxvVFH07fdrE3/huVKiYpea2xV0fSyRbCJ+smBRTjc7JTMAd1AqspQ
 9tEViLlem4Qiu1QBFmY1I9eAdFqudYRawBHYYI9riNQ4Sp0WX/2yx5jpiB7DpHbYEeJa
 +RSzbWYjkUuiYIMyXNpcsxccGKUMvMihG5wFHBNvxXLJMqxhWm9A2N5qQFwFfQ2dhPdn
 1AwVjtdGT/8S6Ghc16uES777ih86KmgpBpopI8DTUsDSdrx+rhgAY2t9JtP71rCuX5tY
 l3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775082508; x=1775687308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlvF8Y0xzE59VKNYaguPYs8VoY8pGc0i4FcyVlG15Wk=;
 b=k072T8Ag9NZ1RcXPZaKn39KsSp29Wl7aQjv1+hKImDSAcIbVcyEsBwLqsTkMaf2ADY
 htTtGc43v0N32dm9D8vL1i9wvCC4qb9IRKc7seD0nG515MPhQgQGb6aCk9XIaXgiuerS
 Hpox3fUr2HUMndE03Tn9ZeIp4r6dmG4KLcV6ejPUS5mvhAy7NaAE6Z/lzlvgbgqFo5sv
 hCltNX63Kr1cS9jN+M+NdwjdjRbLWCYcu2uwIsd9+F0HiKi2lW9VeGQUFJLkmFJmZZyg
 /1VI5XwvziNITBNSypty4DSH/4qbGcNH1rwBW6+wwHiHYngHteOetJY8PM9/PaQK7AG4
 0JAQ==
X-Gm-Message-State: AOJu0YwD+lQG/yhJ0VFxKj12st4WN6SKaspWC6RHEKriSAPUuvLX33tx
 OaDju7ea0hb6VkT6Joe5oYmu4GkxAmWp+bcYeOMDNCc/g31u4i5RUHv6QwqLGzEZQJDlvNO2d/c
 nyorDdagr1L1OIlzkKlSYQ8/JqVToXHPVZ0+xfx5mA6P2NjUxvtzCJUPH
X-Gm-Gg: ATEYQzwiQY5nPWRqdnHUsUGeJZ3VPrBIVNNx94pTkfHN4e3lrMCUqp8/U6nzajhevDL
 tevTwV4i+8yRy9Zc6paFKGyf2c5qCN7Q8S7NE3VrdGUwazQi7E3W7ENVoW5qS1jS3YZJaj5mL1f
 fGPC/vsNBdX6zQQYZ5uhM/aSuKdXEPRg9x9E/IdqZz1kPU7K8nxnJW9HscX+1qIfM8o6zfj7ukS
 hBFqSw88cd8XnUNj10rfcyop8wNxwoO331gXVkmVMmT69+Lb/g98/sQpsR/OjAdw9szuqJ8cIkH
 8WBAqAxzEfKB0qSAyX6C/i/Q32tzysBAaau+EnmU/svPslV49ciq72HB7loT6W5vTdELFqGV6Ut
 Hcow9qkaa3cZVXy8XmKzXcC0EVRsHnMIUcs30OfLr6cxNjA==
X-Received: by 2002:a05:622a:53:b0:50b:36cc:3350 with SMTP id
 d75a77b69052e-50d3bdaefdcmr77870031cf.67.1775082507821; 
 Wed, 01 Apr 2026 15:28:27 -0700 (PDT)
X-Received: by 2002:a05:622a:53:b0:50b:36cc:3350 with SMTP id
 d75a77b69052e-50d3bdaefdcmr77869581cf.67.1775082507305; 
 Wed, 01 Apr 2026 15:28:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4d9ad4b6sm4181411cf.15.2026.04.01.15.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 15:28:26 -0700 (PDT)
Date: Wed, 1 Apr 2026 18:28:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 06/12] migration: Use the new save_query_pending()
 API directly
Message-ID: <ac2cCLsgG28H-bCM@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-7-peterx@redhat.com>
 <acagIGw8e0RKL2xt@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acagIGw8e0RKL2xt@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 27, 2026 at 04:24:09PM +0100, Juraj Marcin wrote:
> > diff --git a/migration/trace-events b/migration/trace-events
> > index 60e5087e38..5f836a8652 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
> >  qemu_loadvm_state_post_main(int ret) "%d"
> >  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
> >  qemu_savevm_send_packaged(void) ""
> > +qemu_savevm_query_pending(bool fast, uint64_t precopy, uint64_t postcopy) "fast=%d, precopy=%"PRIu64", postcopy=%"PRIu64
> 
> Should probably remove these two trace events, or is keeping them
> intentional?
> 
>     migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
>     migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"

Nah, I forgot about them..  I'll remove them.

> 
> >  loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
> >  loadvm_state_setup(void) ""
> >  loadvm_state_cleanup(void) ""
> > -- 
> > 2.50.1
> > 
> 
> With unused trace events comment resolved,
> 
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

Thanks,

-- 
Peter Xu


