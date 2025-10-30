Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25997CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWES-0007go-50; Thu, 30 Oct 2025 13:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEWEQ-0007g2-FL
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEWEL-0007TB-TC
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761844468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jke6a7QE4d2MrAKrsqQ4N4lwxKuUS+3LHqHQ5AcNyB0=;
 b=OKGxG6g6uvwjfkgFk+Um0I4EawGZ98ielCdm7ydDTe4/gDmScuAkLNyHynge5LnQP6V33H
 4XypPPGD7Bd1QZ73U1D3IJuB7lDKNSUyI7GM4vZR5XLpSbwZwxOvjAqzjtCkRmApsd8mF9
 ZbZQFLIO4WO4pyZWkdmxk5d04PscObU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-SCTbUrVwP0qB943hR0ucvA-1; Thu, 30 Oct 2025 13:14:26 -0400
X-MC-Unique: SCTbUrVwP0qB943hR0ucvA-1
X-Mimecast-MFC-AGG-ID: SCTbUrVwP0qB943hR0ucvA_1761844466
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a194ded475so146959385a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 10:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761844466; x=1762449266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jke6a7QE4d2MrAKrsqQ4N4lwxKuUS+3LHqHQ5AcNyB0=;
 b=ALpYVUiMQfKgvFFZ+HFxFgGyCi3GKMhOw4vNLVlG7QlWxbWQ1dhoZXUitOlpgZObS1
 VzuNNC2BjRYKU+2Dgj8ifSswfK9/qfcHc/w4bHMgg4QGBrukTAblSVDt/uLC5eyyNmtb
 9SIqgv62FzOQXwwvKaB0IdyjUsc+DWfgvA+6HFHJHCd021BGN3mKeb5Kg6wBYxPSa7TJ
 HoSyoZfu1xBiDdJN17sOMWX/1FiEzNMCjruh0tpg3Hn/M0f4ljgF4e09dblt3SmcjvVL
 yEe9AzYXHlCmai1dZ/hFsZLi4Tsv8YVTKX6po/8k2GFp330rYBr25lrXlXWM7MK/322z
 cMdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb21DOoaQdSxLwEdPYdQ4ivjroBKcIsKfNVa7gAaZ2rRz5zRnGjuSdo/QQuPwvhYvUqnq7mY959D+o@nongnu.org
X-Gm-Message-State: AOJu0YxyKgUzYua6XMWPimVvpj1a4F0pdeT1MqP3pruKfRRtxpn7Cbg0
 MTIoa3ST0nYKRyNkLZQ3ff9oUjH8D2iWN/Yg+3nded2MwZqfk9QYYTtSu7Wik/CgDMRsECzud0L
 Pd0yozMu+KDu22OabZqkFX1kmXaZmti6PCkWTLwEZwBy09Qe7lfwRt3O+
X-Gm-Gg: ASbGncsCZ34pkI2U6Rz2l5ANN0XxwXYwwQkr5Rf15ji7Y6aynxnVtS3zwFY9F78Ss5h
 TjmyuPNakZJhZNKKZqjfouibCIiOdGBY8O7ydYLb8qvegvYgej5Nn8x0bS1v6PfRj4jzEvKjH6C
 yKQQ0dURuW4Rtp2CUgNIFuaNoEi5TYXCPyDMtPdHz1OyBlMw2sxzfgnAZwUVjbvEMtckN3mxu07
 I6yzuRL+Mupw3LsirqrVH3lXdnxN5MaI/JZ5CUirPtvAMpXNjFprhFY7T1rZ6k1RoopGmZ973B9
 9lZZFzIoikWLd0WSreJnpoORloKpsBnvXUhAR028apdYvofnUgVKkpC2nkqbhdU65xU=
X-Received: by 2002:a05:620a:1a05:b0:84e:2544:6be7 with SMTP id
 af79cd13be357-8ab9b88027emr17952985a.65.1761844465978; 
 Thu, 30 Oct 2025 10:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc5i/RYzjusKB+MxHx1krBpREh9fAquwLNsWKu1TqHuPguSlwf1YcJh8BGUagEQMs9Ft7RYg==
X-Received: by 2002:a05:620a:1a05:b0:84e:2544:6be7 with SMTP id
 af79cd13be357-8ab9b88027emr17946685a.65.1761844465164; 
 Thu, 30 Oct 2025 10:14:25 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f243142b5sm1307800485a.8.2025.10.30.10.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:14:24 -0700 (PDT)
Date: Thu, 30 Oct 2025 13:14:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RFC 00/22] migration: convert vmstate_load/save_state
Message-ID: <aQOc7ogTLqs8iML0@x1.local>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 29, 2025 at 02:13:24AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> That's a proof-of-concept for converting vmstate_load/save_state
> to have boolean error value, to fixup this analysis
>   https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/
> in code.
> 
> As many of .get / .set handlers call vmstate_load/save_state,
> let's convert them too, it not too much.
> 
> And finally, while touching each file, let's also use
> new pre/post _errp() APIs.
> 
> So, this series propagate a lot of errors through errp, which
> were simply printed out before.
> 
> Why it is an RFC:
> 1. I didn't yet double check the accuracy of all patches
> 2. Maybe, commit messages need to be more detailed, maybe they
> need more arguments about correctness of the change
> 3. Maybe, it's better first merge new generic interfaces, and
> than send per-maintainer small series, to avoid this huge
> series, depending on many maintainers.
> 
> So, I don't include in CC many maintainers now, to get a first
> look from Markus and Peter.

It's still good to collect more opinions on especially rfc series, even if
the list doesn't need to include maintainers for each device. I added
Fabiano and Dan too.

> 
> What do you think?

In general.. I liked it. :) Thanks for trying it.

-- 
Peter Xu


