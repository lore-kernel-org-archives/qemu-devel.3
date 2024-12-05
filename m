Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63949E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJK5l-00016Q-2o; Thu, 05 Dec 2024 17:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJK5i-00015w-9f
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:12:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJK5f-0002Kz-Fa
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733436773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejo99kFZ79g3QDgmaqFisuW9XLtdhS+94MaKulN3Pb4=;
 b=YMu9XNKj6gF5ZWtUMDdt89DZg3TcNMFASkQV+p4LkwukfHZXRSqUH1Yg9fezkML3DXGm0w
 her+wPQhfU4Hj8CeFhT+ESiLjhgV0rcrP/k1eNNZ1aHLLpYaNOJcl5xFHxhrAYPo29YYT1
 39KhErVNLSmUHuGsx84V617hBREkfVg=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-1qR39LgvNpqtrL431YFtvA-1; Thu, 05 Dec 2024 17:12:52 -0500
X-MC-Unique: 1qR39LgvNpqtrL431YFtvA-1
X-Mimecast-MFC-AGG-ID: 1qR39LgvNpqtrL431YFtvA
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-71d4a8ede26so1144569a34.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733436771; x=1734041571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejo99kFZ79g3QDgmaqFisuW9XLtdhS+94MaKulN3Pb4=;
 b=HQDu5B/tryWgBKcy0tT9stZuYrPmIaDLttJsUBuiTlUCnT3bL1DUv/ImJll5Zr1i8p
 RjKcAMKW9yxbevY9OzffVmMJprAag3OoPnOOqZWsui3qpyLzOPNZ5FF2Lyj6IwHyVV/4
 NqUwh5ANARSaQDxYO/p4UGVi+/AKVQwSt9wE6vESEncoecy+LuLqC3pY6i0az8d1GX14
 qDtxpQVAAqYiWlxzEuB/GTVNVTymI7RCWMEE6XZg1zGqzo1vsnnM2OjuysdPicekglMA
 zhWDAH0cyEtJj+WKMla3puIjxaJREpICDZePl1wJxih4+yPEb6WC0rHII6SR3jC3UcYB
 N+Bg==
X-Gm-Message-State: AOJu0YxhD6JR2llzVJu+g3bbAbmXH0WyAb8TA3qJwI/aaSuDnclV1owP
 +LhEP0wVGGWv9a4B7x1igf/okXJMH2IhOT0dIs9fjnswiNY2/OaHbgXHF5UOUCejF07JExrhk6B
 wg58MRVYYuZVdmIU8aYdZGZy7ukiTtqmJjeU92E3SMnOr/7Q0PZJg
X-Gm-Gg: ASbGncttqw4xU50qF9tqkvBXLuiq6GE1SqtK7oSmfFMzr7LY8q0DZvechHPX38Z/10Q
 vm7pDMqEXnCwmOfR07q9g+DOKydbjRbimpmJJFQTGNU5pVL4+4/gpL/EBDQRCjCv2BN+6AEYjtl
 kkXG6JcQWURq5ridXglucAj+4/KYs/GpZx2br4EZp0AqonWYGCAjVCTjJry5EzVX+O521h1R1Bm
 ttKCOOSfPIpV9m/Z1psegvBZNEb/WkAkjhnJ3f/Zy5G//h7aOnogI2RAua9YO6wl/JgCCIaxg/z
 8kJUg4vRTpc=
X-Received: by 2002:a05:6358:5281:b0:1ca:c929:6a63 with SMTP id
 e5c5f4694b2df-1cb170fd7dfmr79038755d.13.1733436771412; 
 Thu, 05 Dec 2024 14:12:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs+YijSDMjKwikvMvrWke/g7ODdstQZUVLMT6Txkbzt9q7/CaqIiNgd3vzSuUE28QAXw6efA==
X-Received: by 2002:a05:6358:5281:b0:1ca:c929:6a63 with SMTP id
 e5c5f4694b2df-1cb170fd7dfmr79036255d.13.1733436771107; 
 Thu, 05 Dec 2024 14:12:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4672969db45sm12594131cf.2.2024.12.05.14.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 14:12:50 -0800 (PST)
Date: Thu, 5 Dec 2024 17:12:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 2/2] migration/multifd: Allow to sync with sender threads
 only
Message-ID: <Z1IlX3Vp1hWmQjbT@x1n>
References: <20241205185303.897010-1-peterx@redhat.com>
 <20241205185303.897010-3-peterx@redhat.com>
 <875xnxj37e.fsf@suse.de> <Z1IOlJemNxrhOg3z@x1n>
 <87h67hdckg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h67hdckg.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 05, 2024 at 06:50:23PM -0300, Fabiano Rosas wrote:
> I think I remember now, what's needed is to release p->sem and wait on
> p->sem_sync (one in each of these loops). We don't need to set the
> pending_sync flag if it's not going to be used:
> 
> multifd_send_sync_main:
>     for () {
>         ...
>         if (remote_sync) {
>             assert(qatomic_read(&p->pending_sync) == false);
>             qatomic_set(&p->pending_sync, true);
>         }
>         qemu_sem_post(&p->sem);
>     }
>     for () {
>         ...
>         qemu_sem_wait(&multifd_send_state->channels_ready);
>         qemu_sem_wait(&p->sem_sync);
>     }
> 
> in multifd_send_thread:
> 
>         if (qatomic_load_acquire(&p->pending_job)) {
>             ...
>             qatomic_store_release(&p->pending_job, false);
>         } else if (qatomic_read(&p->pending_sync)) {
>             ...
>             p->flags = MULTIFD_FLAG_SYNC;
>             qatomic_set(&p->pending_sync, false);
>             qemu_sem_post(&p->sem_sync);
>         } else {

How do you trigger this "else" path at all, if without setting pending_sync
first?

>             qemu_sem_post(&p->sem_sync);
>         }
> 
> Is this clearer? Then we avoid the enum altogether, a boolean would
> suffice.

So one of us missed something. :)

In case if I missed it, a runnable patch would work to clarify.

-- 
Peter Xu


