Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E9BD2FED7
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkni7-0002Ea-7u; Tue, 27 Jan 2026 13:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1vknho-00026s-Py
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1vknhm-0001qV-Nl
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVk9Dp15JwZOJzXvPocbTSstaEBA8KnlKaPMv4Ir+b8=;
 b=YV0MVuhKO0kmMfj1+Uid8sh/8R4zoBK9Y6fDLF+JPwyFgtc6eMKddVNyKgL8iz0Gi3Dwpf
 kaVLdTLvHRJkJDliRSagD1WcwFHyxNAsIfoOZdmypYvF0ssBw+GCE1DSh2563u1JjKZD3v
 0bKfG1geqh5k/sfltXXaxeZTDAjyq4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-PW8_EI05N_i1oJYV4UKF-w-1; Tue, 27 Jan 2026 13:21:13 -0500
X-MC-Unique: PW8_EI05N_i1oJYV4UKF-w-1
X-Mimecast-MFC-AGG-ID: PW8_EI05N_i1oJYV4UKF-w_1769538073
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-480600391e2so24176925e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769538073; x=1770142873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VVk9Dp15JwZOJzXvPocbTSstaEBA8KnlKaPMv4Ir+b8=;
 b=AqVlcGIpphDd3AFDsHaEZZ1YwmPljw80leb8Hte9lKZfkLTx+bQS820OyT03tvYOWn
 OUsfXq0tt/b4uHbBRa9y5cfhgV1dptq0Uyi+m3AONDirPStWhf5XwLjnOjSYn3gtne6v
 Z49O3nvNYYTCtjNDF/W9QmCeCBS/A11Dkl7RM6PVH8MxgRNglztk0b7S2ebh3LZtti9m
 1A9+3bCWJm8h9rel5nKq7dsu31Q010JeDC5Sa1NOEaYumK6vUKfMQ8E4NZ6jZ4la6c/9
 +pMqog+lHasPc/2MH/YTJk+tmmH3QYrXeQD33Fy0DLwfa2UPwwpk5XIX24QW3qlz5awe
 lRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769538073; x=1770142873;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VVk9Dp15JwZOJzXvPocbTSstaEBA8KnlKaPMv4Ir+b8=;
 b=umqmGgqLFTmuiimwCv4OQC/Y6XGuYxd8nNSS68huV9Rc/vgQuxf0lvtCWgA/n1ytEQ
 z8OtoWDi9bztoJfhgu6ztpMPfz8mC6ekoGwumEeypBrYGbGCnJtmIQaZOkel8D/tgW6Z
 uOvlffX4My+DrKDdgwCkDndauY4y2Cxkm+NWU0GLsFlMUQhBo+xqH3hHp1YmbrtZWA5e
 I/WfdHrKiiWbFw6yRNMlLsmYddsbNBF8X5PWYpdHLOEjoveCKAwU+vKstLjKttEk8YQ/
 Ju301W3kni4/NJLGIATNW42JxQLBSOrH6VPIzyhx3RhOuK5JMLRatYNToJXqxAexREtK
 xr6g==
X-Gm-Message-State: AOJu0YwIeOlkJBFl5kFoE69LMeOpqvCUdY3cFhFDmEkBrAXBjsb1qeS8
 plHcflV+Gh7GmMMB7HJEOhEJhujwOi4qV7Y2Y738+ufuJSSdKkgG/0C40FWw94H80v231QSln9v
 uawe5vGnIH5lteR0mAsKO+yFpocpFM+RxCX4cBDtMHbo48Ccix4GcT6nw
X-Gm-Gg: AZuq6aLrTjsmJzFKaG5bySQJnefV+btVqd/Vo/oI6y0Jr1GaVqk8uidZF06/lnVYNdA
 K/yo6y3pvOUomCIXalSFS2IH6nqZg9XLjJi9LDGRTeFs3XrQq1RuyL1hl7xR/WQOMx7ifVlSZAy
 1+JapejGhJjIBcwglXoGVTUfkaPojJnkDJTL0sxGETGoU14hCdOWenPyCgLKs8V4RHlrBmW9b0+
 0tL8QjlkVxfkHiHI/+zydaG+ItT4G7dHXG1Ux8pPu1kFlWKNwjSRSYyVtCuslwTrql1TQm9GWg/
 R7jEzCugI6AuQbB6zriA5nQTG42f5Lmgx/6WV3XgaX1a6dk0NRKayKYm0SY94TLefA/BLnpWWP6
 jTKDk0rlEstR3oYhlXi06ujM+TA/BR1oEk9Atrw==
X-Received: by 2002:a05:6000:2508:b0:435:ae10:cf92 with SMTP id
 ffacd0b85a97d-435dd02bca1mr3629428f8f.8.1769538072468; 
 Tue, 27 Jan 2026 10:21:12 -0800 (PST)
X-Received: by 2002:a05:6000:2508:b0:435:ae10:cf92 with SMTP id
 ffacd0b85a97d-435dd02bca1mr3629385f8f.8.1769538071962; 
 Tue, 27 Jan 2026 10:21:11 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4762sm529321f8f.6.2026.01.27.10.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:21:11 -0800 (PST)
Date: Tue, 27 Jan 2026 19:21:08 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, "Michael S.
 Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Laurent Vivier <laurent@vivier.eu>, David
 Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <20260127192108.216495da@elisabeth>
In-Reply-To: <20260127140316.4187221-1-jmarcin@redhat.com>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

[Cc'ing Laurent and David]

On Tue, 27 Jan 2026 15:03:06 +0100
Juraj Marcin <jmarcin@redhat.com> wrote:

> During switchover there is a period during which both source and
> destination side VMs are paused. During this period, all network packets
> are still routed to the source side, but it will never process them.
> Once the destination resumes, it is not aware of these packets and they
> are lost. This can cause packet loss in unreliable protocols and
> extended delays due to retransmission in reliable protocols.
> 
> This series resolves this problem by caching packets received once the
> source VM pauses and then passing and injecting them on the destination
> side. This feature is implemented in the last patch. The caching and
> injecting is implemented using network filter interface and should work
> with any backend with vhost=off, but only TAP network backend was
> explicitly tested.

I haven't had a chance to try this change with passt(1) yet (the
backend can be enabled using "-net passt" or by starting it
separately).

Given that passt implements migration on its own (in deeper detail in
some sense, as TCP connections are preserved if IP addresses match), I
wonder if it this might affect or break it somehow.

Did you perhaps have some thoughts about that already?

For context, we didn't really write comprehensive documentation about
it yet, but:

- KubeVirt's enhancement repository has a detailed description at:
  https://github.com/kubevirt/enhancements/blob/main/veps/sig-network/passt/passt-migration-proposal.md#live-migration-with-passt

- the QEMU-facing details are outlined in:
  https://archives.passt.top/passt-dev/20241219111400.2352110-1-lvivier@redhat.com/

- usage of TCP_REPAIR is briefly described in passt-repair(1)

-- 
Stefano


