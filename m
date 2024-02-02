Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC257C48286
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 00:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVhJB-0004oO-6Z; Thu, 01 Feb 2024 19:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVhJ9-0004oC-GJ
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 19:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVhJ7-0002ll-N2
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 19:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706833284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8HMRuJ/ngJuQKkTAyX1XnxVQfQymhSpLZrg/IjAuj4s=;
 b=RHQD1bHYVU2bL8GyDB1M/C8wmVDL3uuboW3MGXUBQIOG7fsi72LeoEvzlR9M4LbzFPkqO+
 LQW647WSWxeVCvl4Un1fvUMUzkkwV9Z+xdAvGGelxIKIfClocRcKpe6YSZIJccYbjfn0md
 MovjPb4DSN+w5fAllSJdtF5s+do187g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-gmsZwJ6AMZm3FrL24nIbHQ-1; Thu, 01 Feb 2024 19:21:22 -0500
X-MC-Unique: gmsZwJ6AMZm3FrL24nIbHQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2961d20fe78so341126a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 16:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706833282; x=1707438082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HMRuJ/ngJuQKkTAyX1XnxVQfQymhSpLZrg/IjAuj4s=;
 b=LVfLwf02GoV4hEb51M9jds1B7PuxX+M+1UQ3Z7lSywlq1Mq+wFDGpTFV1FqokPH/77
 y58y5TEfTc82BcsuNhr3CcZXdPhhmvuHujr907fcsJZvis1X1+KRHhZbcZCDjWZupNTb
 oLELuP7+3s8kXdBnbd0MTBBEvRKarIr3MX2Fb/twuDMw+ee6jiggVwIdWc7EBlE02Z74
 zmOacwQ3p3kQteOKXAe62PEUNXtcS4bixUKIhxDYNfmVSnlKhXlA4tBY14pABDS96dKn
 xoxenucXh6LoJuc0Qp1EdPFGJL/bTvDuqY3MB0B/35txioy6JKH9AJOCGY4PFzUi3Itz
 sQyw==
X-Gm-Message-State: AOJu0Yx/0ILkl1gl5idMjN/Dr9fBfjuUAQq3vpvsAfnVSfImhKNiStDe
 VqMGACVXkA1bkhoW8GGgVfJuxAq52809HKU2GFrrs0aty+RaW9fbBw//YgF4PcMj+EPlhe+lDdD
 f9LdY34/G7rLih2hYCRx6t/plxaHBA0D33NWJMPVvwJgNLo7WfkGW
X-Received: by 2002:a17:90b:4c06:b0:296:3cfc:8655 with SMTP id
 na6-20020a17090b4c0600b002963cfc8655mr500977pjb.3.1706833281924; 
 Thu, 01 Feb 2024 16:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL8h+IWciXeMFXjK3UF7KipUF/+M1ekkLXtKR+VqfIqRl72Gre5d/7FKS7kfA+BCNTh/ckBw==
X-Received: by 2002:a17:90b:4c06:b0:296:3cfc:8655 with SMTP id
 na6-20020a17090b4c0600b002963cfc8655mr500959pjb.3.1706833281523; 
 Thu, 01 Feb 2024 16:21:21 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCURhDPsO2XyXUlZKZfc4zJa5wETtypVgpzvcXfPnn1dQNHB9/C1CnBxT6rOIyfFq4u51IoLZ1fEXVpO1QlEgl6cQlHl/iS8bsjTUw4hTFMMGeicQcEgzWltp31QN+yH10b6GrChCee4NSLV6PO5CFX621YmS/xzKN4BMXhidsX7nqjPPbBM03lz3/L8WIkjiaIHlbBAD+uVmfs1ESuHi1o=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ja11-20020a170902efcb00b001d8921f2058sm379460plb.205.2024.02.01.16.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 16:21:21 -0800 (PST)
Date: Fri, 2 Feb 2024 08:21:11 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 03/14] migration/multifd: Drop MultiFDSendParams.quit,
 cleanup error paths
Message-ID: <Zbw1d9WXALaMAupe@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-4-peterx@redhat.com>
 <87zfwlk0gr.fsf@suse.de> <ZbtkQLnPJDmXK912@x1n>
 <87sf2cia6s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf2cia6s.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 01, 2024 at 10:30:19AM -0300, Fabiano Rosas wrote:
> > @@ -586,7 +595,7 @@ void multifd_save_cleanup(void)
> >      if (!migrate_multifd()) {
> >          return;
> >      }
> > -    multifd_send_terminate_threads(NULL);
> > +    multifd_send_terminate_threads();
> >      for (i = 0; i < migrate_multifd_channels(); i++) {
> >          MultiFDSendParams *p = &multifd_send_state->params[i];
> 
> We could then move the qemu_thread_join loop into
> multifd_send_terminate_threads().

Sure, I can do that.

When at it, I found that maybe I should cleanup more things in this
function to provide small helpers.

I think I'll keep this one alone, while I'll append one more patch to do
it.

> 
> (and fix all the bugs we have so that we only progress past
> multifd_send_terminate_threads() once all threads have exited and no
> more thread is going to spawn)

I guess this will still take some effort.  I hope that we can avoid some
threads from being created at all for either async/tls purpose.

For now when I'm doing the cleanup I'll add a TODO too for this.

I'll repost a new version for the whole set today.

-- 
Peter Xu


