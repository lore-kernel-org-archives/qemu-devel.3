Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71D7F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAssO-0001yr-7P; Thu, 09 Apr 2026 13:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAssN-0001yi-Hg
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAssL-0006qx-U4
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775754543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xs8dHgTIT3VPtBwLkEDPFYsQ3ENWvEYIuaPUAJIbha4=;
 b=K+UACx1qzXOR1XL0lZJoR99W4kZv0iUDii3nEf2MSK47fKM3PglVBq1sIs/ZBMkicky9nR
 MISYwXybbN8YPVQLugIs0hAZHGSCvmxUIfqIFoh6jqWJfuO5PHrA4En6Kyo5iX3FItiZzf
 NTPETJYQ45cBMIxKBYTWBduLntCWdpA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-nJU7SKdrNGmxi6GYLtWLBQ-1; Thu, 09 Apr 2026 13:09:01 -0400
X-MC-Unique: nJU7SKdrNGmxi6GYLtWLBQ-1
X-Mimecast-MFC-AGG-ID: nJU7SKdrNGmxi6GYLtWLBQ_1775754540
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488ba2919b9so9287005e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775754540; x=1776359340; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xs8dHgTIT3VPtBwLkEDPFYsQ3ENWvEYIuaPUAJIbha4=;
 b=GJ5pwzXQdcf43Rm/59ha2ptIDsmdz55Is2OB1ew68mw7A2dkgkbjPEbKWIQdMEjjh9
 5ppZ6R1UvctRA/WBT+UkRqArAx1glnwZ7+fpvZfthy7yoVkDoZ3Dc5PJPY9l897cokPc
 jMBHbx3vU//p+GA8ds5MLSNY05bRvT0VunkYdOJu65UN4NVv/yWpYyVkaVIOeSU4gKoR
 V7jLrS9KfkpaKEWUgt8j+jgsm+bLUTRFb3OENW5IDMvfRh1PjJGuylzHTf4+I25ZjFi5
 AkpcT6yRxVtG3Rof4qhwnamKwJzA05RJS9OM8tgDuPjCqS3OOeetZqMYA8BggWdHgr52
 mbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775754540; x=1776359340;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xs8dHgTIT3VPtBwLkEDPFYsQ3ENWvEYIuaPUAJIbha4=;
 b=NPMXQQZa7//+HHmKF/sqCkYnQpkDNuqHT91qvLI7ybipZnep/VKt5kYfPZmaN9d2pA
 VLXDRx2aaFy8pjzr87pLkz1VVXTHHTtUMu8EwVQgkFJhjjRF5LOKDwSpL9Gb5HCJT4C7
 refJOLe0c7XUfMkFHKE6dredkZUzZs+MbNU0LMqus43zod4WiFMnFN/a9+xd92HGghNd
 fbTWvsIZQSRHC2RN5PB1s/nmIEKdyzdjK9AJ+4zh7pV0Cdlfpgus+20wxq3vHJlOYvVU
 b9kVl2P6E9cDnJKLw04HYvB+Jyrxcu8X4AIdkLfvfwchIPTmLiPrXJfDL4iscJuiyVbI
 uF5w==
X-Gm-Message-State: AOJu0YzEv2iUBJv3QJ6TIQCj1zwFbtQ1GJBztRJZGnqJt+V/TeSFY8s0
 URomB6AtpwEvJ/byvit4Hpy276PJXHfTGy/j6IEtx9aeUp0tKXcT1YpPw0FlAq848wd7hsJ4HIQ
 aPn6ZYZkDrOOuqy47ZxD9Lc8ckoV9/KTvN9Tn5hSXXzvMutM9lKC/aqgT
X-Gm-Gg: AeBDievmSknNJJqx9QEHas82urENO00S7jgjZ8b9i6olGhiYnl9L7MfF2zyQtT9Yaml
 ++2boZdrdvlXAXJOyhJhUTUNOWgaO4G+/9bw/QGa54a6/akFNvHaq5od6zQxe1RuP6djJ+SUFau
 AxqX16ZbgULKImPw5gW0uSnvp6FligPwvxthKLhsqRuwyKYJa6juzik6dyY3QdFqbkFawY6pkw7
 lcc0hNRprvQ1JeBWuPtJ/tVFj+Qd6mLob+lemuMMS7S2PiDR5tDK3jm6WQbdwq4VgPvZVtmMA1+
 nQ+d53Rm5jjz77MHMRGm3BwGd8RwwLpD0AfOK/lUPQNfmlvI1FNon+62EBu/pQ608VPIbgIpfyo
 Uo3O4euLvTrImkXxw8O/qzHYjMChSFreZTEBaQoQ=
X-Received: by 2002:a05:600c:37c6:b0:488:b196:d249 with SMTP id
 5b1f17b1804b1-488b196d280mr245657665e9.5.1775754540296; 
 Thu, 09 Apr 2026 10:09:00 -0700 (PDT)
X-Received: by 2002:a05:600c:37c6:b0:488:b196:d249 with SMTP id
 5b1f17b1804b1-488b196d280mr245656965e9.5.1775754539685; 
 Thu, 09 Apr 2026 10:08:59 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5344e28sm10224515e9.7.2026.04.09.10.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:08:59 -0700 (PDT)
Date: Thu, 9 Apr 2026 19:08:56 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>, devel@lists.libvirt.org
Subject: Re: [PATCH 02/14] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
Message-ID: <adfdBOQfc8-Nhxuv@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408165559.157108-3-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2026-04-08 12:55, Peter Xu wrote:
> This stats is only about RAM, make it accurate.  This paves way for
> statistics for all devices.
> 
> Thanks to Markus, who pointed out that docs/devel/qapi-code-gen.rst has a
> section "Compatibility considerations" stated:
> 
>     Since type names are not visible in the Client JSON Protocol, types
>     may be freely renamed.  Even certain refactorings are invisible, such
>     as splitting members from one type into a common base type.
> 
> Hence this change is not ABI violation according to the document.
> 
> While at it, touch up the lines to make it read better, correct the
> restriction on migration status being 'active' or 'completed': over time we
> grew too many new status that will also report "ram" section.
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: devel@lists.libvirt.org
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/removed-features.rst |  2 +-
>  qapi/migration.json             | 10 +++++-----
>  migration/migration-stats.h     |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


