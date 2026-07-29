Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82048C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 18:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp9Tt-0002c9-2u; Wed, 29 Jul 2026 14:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp9Tl-0002bW-DQ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 14:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp9Ti-0001yN-U7
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 14:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785351485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lIpYCkpXgEF+obROEw7E1i1zD0b+0HgqEnr6pukCyrM=;
 b=TTx2ITzlyKCSC2vq7qpUO7sM8fUNF23p//L7v2MH5XyZhZdwXu0YzQPggGePp047z5D6kg
 uDfBYRf+qTelTjebvaqUavv0hXkedz73WGjQcxQnXnOed0+tOvhL+xvPF5ynLbZ1sXlRsu
 e7CiyJVA1GguYxB2uV/EoJ7HxltlTmU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-AwvM16sYO7i5I-QnL_hj_Q-1; Wed, 29 Jul 2026 14:58:03 -0400
X-MC-Unique: AwvM16sYO7i5I-QnL_hj_Q-1
X-Mimecast-MFC-AGG-ID: AwvM16sYO7i5I-QnL_hj_Q_1785351482
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-69c20d12deaso19611a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785351482; x=1785956282; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lIpYCkpXgEF+obROEw7E1i1zD0b+0HgqEnr6pukCyrM=;
 b=V/7b5dMLJkPVCj/bqVf1Pwp7k0TMODnGA2wiIpl7OL5nFYopGDrqt9oFGi1vL8fFG8
 KK7vMG3XTWzTiyc0zBmrNxAh9aoN5onC6Sp46tQI1BMN8LfXI8k0Vv9bq7FQwQZdQqrq
 8Q/6hH+DnD9eIT0Dp6YUco8eFn/a7SoNGinznM5lLHJQtnUDM1WEjG2Txf2yXBUxeVfU
 t9eK2jYHChzA06T/0oHqR4mYVRdvU/hHem6JUrRrAnXP/Id5hWAu08JH2WoFFrIogkhL
 2KgtIMZS1pXRTUrpbj/S62VvR9sw7h354/Ld3kiCASSEmbwUT7eHsqb4HOW4XcmXCSjd
 DG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785351482; x=1785956282;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lIpYCkpXgEF+obROEw7E1i1zD0b+0HgqEnr6pukCyrM=;
 b=deQ4qf4rfZid9jGJM5Jf3+qc0F3xJ/VM1Trb+B+zsHMQS9ctwlyrrRiV73WEzbzMHN
 Kk57lJOjYqrRWkmAv/FiSirRSGgBQHgnObQszuixR6OpWkYeDspNcmop38gjf9BBIxkk
 S39Cy39qyX7NuSELTw3N74jx5r1YfPzRIurNywUFPzPUkb1QgWxbBp6G7HbGclu0IdOC
 8XMdsznBVBtex2DT+5EnhNjGqO8DyZhfyDauKkdn8pDrVODBSeRq3GSl6pgUzshWYtHl
 j1WWt7ga6t8OJ5nZoYj9BguLZfo0KuSzBH7yNmCv2cZQxPnRuGin1iKVqnSo0I/HukuR
 DCIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeAhhtqPttBGUBt7HycpaN0yZdENgXD/dxQVA1vIK5QEA0qu61sT9xPJRAAZKlnkB1nGQJIXkN4NJs@nongnu.org
X-Gm-Message-State: AOJu0Yw2UYP6SUkN2aFu8nynxIK+w+uIbQ35KJkkAEBzzwMq1HbehwTV
 i8uXBV4X0uD2dVjaPBx/eqX5tWB/bznEw0Zc15llKLI/TOgDjKnNPbsjZVST4ZLdZlLkGBgCwBz
 O0toHLkdFH/YZE5ItoxD4xt4IxJoOuTWsr5Mr5R/57GfGTmgkpPQUokUV
X-Gm-Gg: AR+sD13FfJ3VG9TRUvzuqRQxp88zRUQBInAd+Qv7VcJIsIjGZxsa/62P/BFJ3AR+i4a
 snEErigAtC1+K/LXxZSjIBXJmc9hmdVELvpOTcr75TxdjHLaYlRSJ+ZghEEOABCEm8a9QKUySNl
 Qgo8q1Cau/2wz4A0t6K5Qsvy5eTwHmX1ZwJAxYy8sJH9nIjf7YSAgLPeMefKZPqL4Gm2PHVVrL9
 t8q6mf7ALOjmBuGYDAyufRsOU3qonAgXA1CqwnG3cVMF7t01FZ3oJbb/lGfNFjgyOKGMUw/DO9M
 B29GIMfA89RGFO3P/UTkBXlBNl+dhNI+I3VJ45Hipizzr8XOuZsKSl+GnpHVm4M6Y1j31Q==
X-Received: by 2002:a05:6402:a145:b0:69e:821:b193 with SMTP id
 4fb4d7f45d1cf-6a052fda8fcmr1415286a12.11.1785351482411; 
 Wed, 29 Jul 2026 11:58:02 -0700 (PDT)
X-Received: by 2002:a05:6402:a145:b0:69e:821:b193 with SMTP id
 4fb4d7f45d1cf-6a052fda8fcmr1415277a12.11.1785351481988; 
 Wed, 29 Jul 2026 11:58:01 -0700 (PDT)
Received: from redhat.com ([186.247.166.227]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050c5cd97sm1146714a12.22.2026.07.29.11.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 11:58:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:57:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <20260729145247-mutt-send-email-mst@kernel.org>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de> <amoHbVsgzkYclCt2@x1.local>
 <878q6toopr.fsf@suse.de> <amof2Vbn_nTHR5H9@x1.local>
 <875x1xojtk.fsf@suse.de> <amo86cXLNE2uV6Ge@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amo86cXLNE2uV6Ge@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Wed, Jul 29, 2026 at 01:48:25PM -0400, Peter Xu wrote:
> So to me, it's much simpler we say migration stream must be
> trusted, and I expect dest QEMU can allocate any buffer it needs, until it
> eats the whole system memory.  I really don't see much real risk..

It's not risk due to migration, specifically. But making qemu
drink up terabytes from the guest would be problematic, right?

Putting qemu in a cgroup with restricted total memory
would be one way to prevent this class of security issue,
and a robust one.

But that, in turn, is impossible if qemu insists on allocating
unlimited memory at the drop of a hat.

However, migration is hardly the worst offender here, and I am
not at all sure we need to start with it if we even want
to address this limitation.

-- 
MST


