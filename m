Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAD3E81BDC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTrW-0004QU-6E; Mon, 09 Feb 2026 11:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTr8-0004K6-Fg
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTr0-0007NQ-Fm
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770653469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ucLwseeoIXi70+67cNzXtw5vOlYmzqWkcRa4nBUFer0=;
 b=Pubz5nn8zhoW36y8E9g+Z2mudhObz1A6BDt0HyCbSzFrNw/3RrzlpAxdr8b87GofxTM44d
 1V23XmwTiaysTNerQchkP7U/Lu2g2g85/UUaqOH6A8b/4M+7q/I58MZ4i8sh4QE9ixRsIU
 X456QmlgHbKvVS24mDN+43BJwBrgRAk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-FLw3u4uuPeyPfSbL9fYD3Q-1; Mon, 09 Feb 2026 11:11:07 -0500
X-MC-Unique: FLw3u4uuPeyPfSbL9fYD3Q-1
X-Mimecast-MFC-AGG-ID: FLw3u4uuPeyPfSbL9fYD3Q_1770653467
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c70a08daf3so1206268085a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770653467; x=1771258267; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ucLwseeoIXi70+67cNzXtw5vOlYmzqWkcRa4nBUFer0=;
 b=Pv0DFABRvJdnRHhvvFOJ+qNJ5DRKqQY2fW5pQmzdnpCrprtNBHyRP/UK4aY5yUztBX
 dB6c9fIDTs9wlG8p0FwoA63qZbKSjOIVnrGHcj7mQ7DwXMcPYkdCinTlb/jCyilF9eBR
 dLnFhYWd9LYinHV1YsK78wgDDnssflSfKNlvF4wemIQc1snyEvQfzUTsPhYRYNV52mqr
 eQVifQZ4w37QYD2+LSxfm8+PBHLM7Kl4BwT8Eaksw0b7OyFoVwcf6IhXCzRmCEvg2HOn
 7D5W6+bSWofn7MD4H0Dj27sEDE6hQHrToj+oZJHbr4xN5yhmZnH7Xjta3AvKzd6RmztZ
 XABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770653467; x=1771258267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucLwseeoIXi70+67cNzXtw5vOlYmzqWkcRa4nBUFer0=;
 b=BhfADSM8YtoxM2C2v/KzMmRACEVKRQxR+jJqXKBdqTh8enjgqaRGsWDwx7918c+wyB
 Yd+gSzxWoZzTYybBBu80qqyxGACzcjm92w6p6JzwWbB2BjuLPPVICvh+SHVClUTBlR14
 M+UcqzcJc8NoytWsVLyYbCPTvIilfkFipNPxuhJ7+P4axaaHWdV1VVeskjCA2eDObP8W
 k31Pj8hQ+5K+qhTtowOsfRNkFPAIZ3bpzgy3jioBqU06eRK23x0Mx+AvaMMZ6/0CpLjR
 MGLWsYiCqvgolzw9DCe+/Vd6R9lf9GZZWVL7EVWA6enbVmWhlhD9XtYAgd2eQWlOx4lH
 GYzg==
X-Gm-Message-State: AOJu0Yzm1/eDxbfhCdLfIKdTyKGmXvHKVpBVIZfW3vHVcZ68HMPG4Pbn
 aBN4oS1KDOklskV1d6nPZ0gFFbKakF/lXJgjZcc4PJNDQvMXxkrVcX6sYNzMjG/r9piXExPuunx
 MWevP3KBBJw+7bVz0jVpMwfLlIcYzl4LS3DTYPU/7jZ6ogaLmduVHE/H/
X-Gm-Gg: AZuq6aKgAAtAHcT4+QVxytI24JQn4lrs+17Vmx/A6LmCPm90YM+r9ILaVTS+V2AuQk2
 u7rV23vXlZDbw6WFQIJcRJ4U0r9T/yv6ymXin2cIAlhTcb+mRcDZcTT5Bily36TMfeR8VoD/Il2
 WD9vAUKXbOeXVl/+b0ApXhvD0EhI/c3cXcd5H1QTFGNBUh8brzxlMmEH1+oM/jKPklTGNt4iv2C
 8/+Aas4+Jr2TsvN1hXsbM2wVC8B880/t8NmLuNfwX8ElzFWGBwh+Fua3DrJ+8RcNGwOrMnffAbV
 ipTXWhhzTgBo/u7RULM10jjtzvzXmx0exiyoV3U1gpAM57L1d/BROYcRNsPXXpchnkIqffwyf3k
 /0ig=
X-Received: by 2002:a05:620a:410a:b0:8b2:598d:6e89 with SMTP id
 af79cd13be357-8caf1accd1emr1585667885a.45.1770653467122; 
 Mon, 09 Feb 2026 08:11:07 -0800 (PST)
X-Received: by 2002:a05:620a:410a:b0:8b2:598d:6e89 with SMTP id
 af79cd13be357-8caf1accd1emr1585660485a.45.1770653466564; 
 Mon, 09 Feb 2026 08:11:06 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9ee8662sm904431185a.37.2026.02.09.08.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:11:06 -0800 (PST)
Date: Mon, 9 Feb 2026 11:11:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 04/16] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
Message-ID: <aYoHGYNzpQOoxh0Z@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-4-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203-colo_unit_test_multifd-v5-4-57508b7389f6@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 03, 2026 at 11:15:10AM +0100, Lukas Straub wrote:
> Since
> 121ccedc2b migration: block incoming colo when capability is disabled
> 
> x-colo capability needs to be always enabled on the incoming side.
> So migration_incoming_colo_enabled() and migrate_colo() are equivalent
> with migrate_colo() being easier to reason about since it is always true
> during the whole migration.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


