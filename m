Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B98CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY4Lf-0006zk-OM; Fri, 12 Jun 2026 12:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4Lc-0006xp-KB
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4Lb-00044a-1c
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781280185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NTMm2D0fEQyJoHj6G9esQdJ55OZeVXOyWjEb3gMZkLE=;
 b=RwNxZgD0J+0rdh9cQk8CWP87bdymkP5gaAeWmlPpTkpfwICUG6NW7/AJsXMwKpnNG1k26Z
 bKL+HD3Ambw4j/mYXKz65ZHhwe/yX+wUUm6Tc49gfHF/LNHcX2MuMOzE//5XW9fQWZLCKT
 n7c1vbvVfxT5hDv/Iwb5xmGL5h06ilo=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-fvfoHAQKNcKtVgGB8Rlb6g-1; Fri, 12 Jun 2026 12:03:04 -0400
X-MC-Unique: fvfoHAQKNcKtVgGB8Rlb6g-1
X-Mimecast-MFC-AGG-ID: fvfoHAQKNcKtVgGB8Rlb6g_1781280184
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5a2afc494efso1296610e0c.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781280184; x=1781884984; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NTMm2D0fEQyJoHj6G9esQdJ55OZeVXOyWjEb3gMZkLE=;
 b=PL7L2tgJlHcXCZ0KsKzyX8Q+1o7m0wIPcayCdQZcyhxEcIti0tvZdPvdzjg8hITg7w
 pHu+PZkOx/ysjdKmwXoF3eJlXNFl3gF9g19VdlPnTHKK3IBh9eYq4ln9uIUfC7NvMcjS
 XnZ86Ue12LYe1VXBA+X8+gRQ7Ui/aYePl2qFuXEdWwfpwxl4Oc+uXAUH6vybxlssK6ra
 U3gIB4T7nIhdIkayAGgaaSb7DVwvFjW/DLteS+e3UJDEQXjPDJc81VbYcoHNCcpJQwGY
 SJAz4YE4LJfCSJJBr104OmTssAe73DuMP9DOFHg45ocgHM1gsvamsNODpSN8/qR70quz
 r7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781280184; x=1781884984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTMm2D0fEQyJoHj6G9esQdJ55OZeVXOyWjEb3gMZkLE=;
 b=lVgU6hofjDEzvxuM4lFx13+5XabnlTWFhE/ZURXGQNex5g1bD/GWwmp5J0UnjHk/Ad
 mQDRrOBTHFn+KaFE6z0PDkmWn4B1QbwgpInukYn/MwFakUiQDdP19h863NgErJgngDnv
 8h+ELXKDpCymr5sZYpMmtNY3ylf9yI/v8O51ecTInrl3y1ZL63tksr8qKTJOJoqNgss7
 axf9nLuXP7msot/LCQmeN5ZTW9niUHcjCGdyfb/gKvFFXB/DHghYFJHHdh3ORlfkoWF1
 mJOyLPrtbCNdqXcIxThzgNC6q8C52Omvbv7JgIw6sowv6WJl7K1aw7lv1wDC+cqufUkR
 SBLQ==
X-Gm-Message-State: AOJu0Yyoy3o//kQoqjaBiBEyjwFyvSXKy+neoi7sXWABLYf1/EQ6SaYu
 1uMnJgbuLiIHb9a+5EQYJah63/GGCarzSBtb/EeqygadY1LUQFR2OpWqlM6SF6lonrkzBYf/JQP
 Sr2j81DAiH5+cxWO8MCaHJn2fRyqpMbkUTDKY/URYk1QqVCqtRy+OSwyn
X-Gm-Gg: Acq92OERWakyry28OyzxNT/wSVIm3hvoOdesYX02DMd+PlLx+n0SnVqweGWzNJO2c1j
 ceY03rOi4HDaiKhhfKvutqxDpa7FXHR7YJLQH4aHFbET9xK7R56m3Tyv/KZiKw0GNpIfh19IOLA
 xV3S8Oh+TYoEDF5Cg6VM66zu2t8MI3G/38qgcHCGMD1LtYAx58XPr0zC9RiPXfLGBACZjiAq72A
 DgZzvAov8cU9HNMD+ryGIZEFm9JS7jGExrey9gsVni+b1Podjz4+r02uMIjqsR/ni3+JuCtv4XH
 WXmZo3OLC16gpUFObfqrzKA1nyj6xbPP2iguKq2DJA852zSU0syHyNqz5Sa7NFaRk31R0EgoU4O
 NPlSA0uGej/RxlPM=
X-Received: by 2002:a05:6122:1da2:b0:56b:9b7b:83e7 with SMTP id
 71dfb90a1353d-5bb6c02821bmr2177762e0c.7.1781280183488; 
 Fri, 12 Jun 2026 09:03:03 -0700 (PDT)
X-Received: by 2002:a05:6122:1da2:b0:56b:9b7b:83e7 with SMTP id
 71dfb90a1353d-5bb6c02821bmr2177647e0c.7.1781280182709; 
 Fri, 12 Jun 2026 09:03:02 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb69270c4asm2844020e0c.18.2026.06.12.09.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:03:02 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:03:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v3 03/14] migration: Run final save_query_pending at
 switchover
Message-ID: <aiwttEue4ssDrwS6@x1.local>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-4-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609075812.32067-4-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 09, 2026 at 10:58:01AM +0300, Avihai Horon wrote:
> Before switchover, the source needs one last exact pending query so
> modules can flush dirty state. This is currently done ad hoc in modules
> handlers. For example, RAM syncs its dirty bitmap in its save_complete
> handler.
> 
> This should be a general concept relevant for any module, so extract it
> to migration core instead by running a final save_query_pending before
> switchover.
> 
> The final query requires special handling by modules (e.g., it's called
> with BQL locked, during VM stop), so extend save_query_pending
> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
> flag so migration modules can tell the last pending query during
> switchover from periodic iteration queries.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


