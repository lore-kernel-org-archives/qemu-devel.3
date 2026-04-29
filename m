Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7ADFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC8j-0006eu-TR; Wed, 29 Apr 2026 17:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIC8i-0006YP-83
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIC8g-00048r-Ch
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUEe1C0oc6AzIqvcaRVfMRbNBNuRu8Jb5pFq2wi7Dng=;
 b=hhBXaDS32E+44psA3Uk2CjUfg4BzxK2RWlGYZby2i/wbEai5ABzAMoIXj4PgIBpDi5YO8B
 UGBrkY7x/8nK9qnerji0sEn36klwDvIO24PM24JLPJbnE+ILM23kqaf2ySD35WhGG7i65e
 AfypnXOVKGDAIf5XUgjLVlJJ4cozh6I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-NQw8ZljbOaev3XEE50o0uA-1; Wed, 29 Apr 2026 17:08:08 -0400
X-MC-Unique: NQw8ZljbOaev3XEE50o0uA-1
X-Mimecast-MFC-AGG-ID: NQw8ZljbOaev3XEE50o0uA_1777496888
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8ee454b1b8cso35399085a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777496887; x=1778101687; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tUEe1C0oc6AzIqvcaRVfMRbNBNuRu8Jb5pFq2wi7Dng=;
 b=eCnz3zVEel/4Wfw75ThMQcdghLTOSdEu2SdnDtUGZRptKQOAg7bnxVa/ofJWJyKwyB
 DTThXbRpYV4Oyyv+yb9dtudasOXp7z2vogdLnEmfzBWRL5BSpJjQwEE9QkhLWjmSGqMe
 d6NB6OmVpxro6WgVQOEqtjPuvI6JMJhOMvUEF3Sv3eJJbOjq9NrpmTAU3dYrTYddyBIf
 8JFigI1dcRQT21dF/duZDdts4/4c7/l5g3sbEcAlJWVyPAJjxsqBOL+Dfm2lSqMKV0wp
 bTSXMMzfZoe7k7XXC7etiZbt0MKukHGHIkJscEASeKXn/HP3wmM4Ugcyz7eQMIYhtV6H
 beVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777496887; x=1778101687;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tUEe1C0oc6AzIqvcaRVfMRbNBNuRu8Jb5pFq2wi7Dng=;
 b=rTwH41x+KkY5UaG2OsZRfRDNDaGZ5LdWJab6rPXZUs27yh+OlHBuVp2JF3upMGkuEK
 7JZFN40fj9eCcC5kT/ItjOZrr3DopURexsiU6BXDhXWC8uqeDgCPSajh2o1rGX6in3xL
 c91NMGOe8q8lRA/hzh8k4TYXlDKlPfVKRBfS7PpwDkGYTv+RELGjKI5WkE0s0uX1Q6eT
 JhHzpJeL1t6lHlaOnBfq4O/8jdI4zEo4UQgEj3QYh4PLlXioaaQSj3S5uq/v5oRHyqtI
 v46LZ05kXwKFNrWicCiYoqSAdJeHAJtn13IwY1IcsLLaRKGz/CFw7kj5Z/5kOn0mukIq
 pOsg==
X-Gm-Message-State: AOJu0Yzp7NufIUr/Uz0AAGBqrqYTWhestx2c6vg++Y14cvHUeWvQKXar
 wV6MEAtaFqV8DuxoE4LkYWnRTFiW9xqyxfh3Ju8FTbThRxGLNHUQus1RfSNSmVnQCXLhw3qTlwJ
 h2wexG8DHqIlDqdF7neFIkkSzIlqMZtbVUUnswoaG03wA+iICHzdoeo7A
X-Gm-Gg: AeBDietzltJIwupy1cU2NIQuBfE9pjTLIw2qivM+2voLsJaQzm9eTANNdv1i9RrnWV3
 H+iN76e3T6xlLOoZWg5DI4Axb3iJ6rXTNck175IebDpe1vfZ810LDZCT3j2wb6P8pGlIwa271tM
 GBqsWN1qX9IpvUKfCV3TdOwJEq36I/7tzgap7/0hjSB19ntnLZJRRon2cveYd4rqlz5DFqD0+FG
 6ugVr7toJlrGuXlS4vdOuul+2/92YjA8mmQxCUggdbMXWE/ygQC//fG8OmJyZpxzvJPSu4ABd/7
 8K265SOtsQmuPUwUOn2Xvn0wzNJN+QYvyrEG8ERbkwfkp8FgD4gZM/Ha6U0s29vqn08iVBIw7OR
 ZFooCX10UKMTW7wnrUj1/xyaDO8RiimWa2kCS2o39kAPUNuchjkqHUreRTw==
X-Received: by 2002:a05:620a:4046:b0:8ee:21b3:2e9d with SMTP id
 af79cd13be357-8fa8a0de453mr61577085a.60.1777496887408; 
 Wed, 29 Apr 2026 14:08:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4046:b0:8ee:21b3:2e9d with SMTP id
 af79cd13be357-8fa8a0de453mr61571885a.60.1777496886881; 
 Wed, 29 Apr 2026 14:08:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f93fc683a4sm257896085a.33.2026.04.29.14.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:08:06 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:08:05 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 11/41] RFC io/net-listener: move mutex init to
 instance_init
Message-ID: <afJzNWv8efqWTV5_@x1.local>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-11-c413f3605311@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427-qom-tests-v1-11-c413f3605311@redhat.com>
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

On Mon, Apr 27, 2026 at 11:42:10PM +0400, Marc-André Lureau wrote:
> The QIONetListener mutex is initialized in the convenience
> constructor qio_net_listener_new() rather than in an instance_init.
> This means a bare object_new(TYPE_QIO_NET_LISTENER) produces an
> object with an uninitialized mutex, but instance_finalize
> unconditionally calls qemu_mutex_destroy() on it, which aborts.
> 
> Move the mutex initialization to a proper instance_init so that init
> and finalize are always paired regardless of how the object is
> created.
> 
> This patch is just added for completeness, but "qio: Fix
> qom-list-properties crash on net listener object" from Peter Xu is
> basically the same.
> 
> Fixes: 9d86181874a ("qio: Protect NetListener callback with mutex")
> Cc: peterx@redhat.com
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


