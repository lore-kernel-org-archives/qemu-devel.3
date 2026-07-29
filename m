Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926CFC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp8Oc-0006yJ-8m; Wed, 29 Jul 2026 13:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp8Oa-0006y8-7q
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp8OY-0006md-GI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 13:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785347321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mImz+Z2+6NCcwhGKAfG7w7RAmJOSLqZsMhNpLJ+UHpU=;
 b=TcYBqQ6l586XYqxJGpk5aPb2/oaCzei0d3Vdc+HA+vSbTl38RAtBexcbutVdCJYCIChdO9
 RW6iv6B5Zb4tT7r1YKz+aWJGq+qx6jzwooRgHhr23DBGc4u3oTDdWLyEHCPVWGjMT3Vf4j
 HjTThB0URh8BBXe6hfFcFZq8/8l4ok4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-EE4Mn80OOtyyTVhmOhk_Tg-1; Wed, 29 Jul 2026 13:48:39 -0400
X-MC-Unique: EE4Mn80OOtyyTVhmOhk_Tg-1
X-Mimecast-MFC-AGG-ID: EE4Mn80OOtyyTVhmOhk_Tg_1785347319
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ec45d9628aso23792636d6.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785347319; x=1785952119; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mImz+Z2+6NCcwhGKAfG7w7RAmJOSLqZsMhNpLJ+UHpU=;
 b=dNzfs1NuU00BQbeF7xQhHBM3NIea545KhK3+MvBCvsveKqcRAIBLIA9DsH3U5zb8VA
 WJ0XhCtmjzBrZ6G6f7b/g66eImRS05Hfx10qLlQzqsb1HxjHjs/tWzbs1UDT6QmqSNOM
 n+HZgehm3vYofUHzrTUFSAj9ACklq0D5fXKdfcV6Ho+jWavDXwCXbVnlS0jyvvl5ZbtL
 MESiO0PpOD4cJmaTKYj+wafkjUxCvDWptteMX7DE13Mrim5EqtBciVH+nIbqlxrwyI+8
 DRXoh+G9rOJvh/QSiTtQ/Cv+OONik7ljgPWKQmMjY5OP2kWF6tAxCe65/fCRJMugVlNn
 NMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347319; x=1785952119;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mImz+Z2+6NCcwhGKAfG7w7RAmJOSLqZsMhNpLJ+UHpU=;
 b=SYH4cnbBaMetR0D8AiAuCeREYo4VN5Swe1pUgezJMvxx2trg0z0QFcxU9w5bqph0Mt
 KJwkch4E1a3Y8tuJQmvCcPEspOmS2bxG2sSSKXbuhQpUMZcEW4wxDOwpwMwkqn/EnpSp
 d3AN500wbWn6UmjLpc0aq8AlB1Nd6PuNTHISRjEZiFP5f22U2OcnEnX20rPfbjulTDun
 aF9BggtAgsWO9HWzgd+yhaVPGhZ67Pg6TsNSgljL5GDlEw22wrfACkmOcl1FEwoTFbIV
 GrtF9/UJ37nMm/O4qIy8l0Tqz0aD1E/B/6gopqW/srYZ2Nf51dyl6r03OU9YCoERr6fa
 WquA==
X-Gm-Message-State: AOJu0YzZ/qivYVV4IP2sRRbCHqUBbVJITsLWJkpidoRFdoI8Fy9nG5/V
 dbdDdRUUEzG7g3PzE+XNGaCJl6kLbLtfLm/6I2E6f9nXOd0GIxP1TeqL5xZeRnMu39ambb+SP58
 rw6Y7JZ0h6uuSfvu+4h6cTaNCwZWt0z8yWPzna7jMjqSwBWUZ3L+aTdj4
X-Gm-Gg: AR+sD10KqN3/HCx+VyHpk2V5WW5RLvlIt/ry6Rmt5q/ZhUzwUB4qDNvC0OTfkXqDO4h
 XIwW1MROOgO4NR6JY0PtZL8y0Tb06DkyF3uHFFmXwEnOK5WAxiI8tqvxKj6JnazULgm2RHtA2wo
 6ddJdCUOgBx5dJxtqSxj/MaHhE0t5j0SubUF1q6gjmUI2w+rVqdvwk5Kspr9gTuiebAz5Wdq1IX
 6x39piVTb6qs+l+pIlK3YAs8LMRuAOBJb+xzOVioIU+0zdsj3intcWmuRov3coshZ3/ALvGbwkv
 ETesw9tekEUl1bO+8yWlTBzxKjf8NRM62SZ9LDSSdCwmXfIyAmRabGjKwFpqrRpW8P/m
X-Received: by 2002:a05:6214:53c1:b0:8ef:7fd6:11db with SMTP id
 6a1803df08f44-908173e0342mr90243806d6.51.1785347317758; 
 Wed, 29 Jul 2026 10:48:37 -0700 (PDT)
X-Received: by 2002:a05:6214:53c1:b0:8ef:7fd6:11db with SMTP id
 6a1803df08f44-908173e0342mr90243236d6.51.1785347317205; 
 Wed, 29 Jul 2026 10:48:37 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dc6b318sm29816146d6.13.2026.07.29.10.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:48:36 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:48:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <amo86cXLNE2uV6Ge@x1.local>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de> <amoHbVsgzkYclCt2@x1.local>
 <878q6toopr.fsf@suse.de> <amof2Vbn_nTHR5H9@x1.local>
 <875x1xojtk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875x1xojtk.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Jul 29, 2026 at 01:13:27PM -0300, Fabiano Rosas wrote:
> I was thinking the vmstate code could define a limit to the size (of
> anything) and always enforce it. The device code can then use some
> custom macros (not yet existent) to limit even further.

PS: one more thing to mention on "further limit":

To me, that was not a real thing that will help anything for real users.
My guess is, it will only be something we can use to "convince" people stop
opening security tickets.. and say "hey, see, we have an upper bound".

IMHO no limit is really fine for QEMU's complex use case, it's because QEMU
is a complex userapp, if it's a daemon and more accessible we may need to
be more careful, but it's not: it's a hypervisor, here migration protocol
(as one of the network consumer) is very dedicated, perf / maintenance /
.. matter more than that upper limit.  There're other things that might be
more risky, like if we have NBD server listening and it's more of an attack
surface.  Even if so, I still think a VM userapp is very special.

If I design migration from scratch, I would allow some migration command to
dynamically create ramblocks, for example, and obviously that can really be
any size: limiting it to 4T will stop working when one wants to create a
12T VM.  So to me, it's much simpler we say migration stream must be
trusted, and I expect dest QEMU can allocate any buffer it needs, until it
eats the whole system memory.  I really don't see much real risk..

That's partly why personally I want us to spend less time on all these
limits.. because then we only handle trusted data stream, we can keep in
mind whenever we want to be safer, but it's not 100% required and it's
different from adhoc network servers. When the protocol allows "arbitrary
size" I think we should just let it happen, and IMHO it avoids unnecessary
work.

-- 
Peter Xu


