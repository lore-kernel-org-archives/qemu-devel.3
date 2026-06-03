Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19368CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsXE-0006tT-Cu; Wed, 03 Jun 2026 16:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUsX6-0006pv-OD
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUsX5-0003MC-62
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780519784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CslwtjtZL1TZl0Wovmj9ybAydPIyg4oN0jWiRyjeC8g=;
 b=jIG0C4t19hTN0HT9lGjK1A4hrnPXg7hr+DP5jAAiZdvxrrpFTZ0OWlU7lmHwVD4iAxCWul
 1VRhwZBx45Cw1Jvme+49FB+DO4EyCU4zt6Du8Zn+so1NJz6Q7f5P1+VtYPHcx8kxcVxVNB
 DrA6LPxFgY+gDqrWeXgu07rkNSY/VoM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-_S-JCh7sNRiZYAqg9MneOA-1; Wed, 03 Jun 2026 16:49:39 -0400
X-MC-Unique: _S-JCh7sNRiZYAqg9MneOA-1
X-Mimecast-MFC-AGG-ID: _S-JCh7sNRiZYAqg9MneOA_1780519779
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8cce1c3c26bso131111616d6.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780519779; x=1781124579; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CslwtjtZL1TZl0Wovmj9ybAydPIyg4oN0jWiRyjeC8g=;
 b=ftGV7AN6/ofF86Ey8y78ZECkGVzZ0ZqUBb9qBmv2v4G3FhgYdaLBNvMBfsMJR4bk+7
 erOFgUhrRXEWIyH8sktgZffLMUzWg9yCLmwkbx9QAfehb6ostie9R0h1wJ2kChQHJ179
 J0v2hiIuuKWYha0vPVOZdXhr936CJMBVDybubL9UgKSOdiO/kmngrn7mc8uDgLDHxoxx
 gF5F7SJ5ELMl18+vIuCtEkco17QzgdVsj8lywWgvuan/SFsSowDcDW31qwDKFjpEfckA
 ooPGcrGBla8BC4aSJ2rplZECfb/n2rVtouMk6FhwIPAKxk51U7HeXe04oTaFW7IY3lYG
 6JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519779; x=1781124579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CslwtjtZL1TZl0Wovmj9ybAydPIyg4oN0jWiRyjeC8g=;
 b=ZbwyU5oJ2sQehpe5yvgdPhQ3528pmOILX6oMZo6SpQbomjzwPxR+C6cCLAmsaNk9/K
 qlKeLom+J1h1SK5ssEKFthBAjI763CPYz/Yf5gny3dieXoZnIRi3iUE4b0vQOCMReNw0
 bf4NMniqj/9iQsoIvgGjWQx1ek7O1DgtCPDut+v51pjWEnQlniKY5cjQNngCl2QgEqQx
 V8yWnhjwD6t2Pt59gEkAcRfG9DRH91WBaZWgol4iGbG/i2p9FN5sq/L/dionaVJOFLRy
 /RyjUOVhGIHpFjSqnqBF0qsI49476oX9T12tVqiLy2SxZjKbpfsMPqS3g7QrIOU7pSjy
 QtsA==
X-Gm-Message-State: AOJu0YyIJ5dajDMA7LzLfJU/fuXtinSW7xb7JJQUugaQq2rgCBnT2W3e
 XBRUj9YjWd8KV6421F3YjF///CVHgDWubBNgdWxTAgjoDDS8KvN3gw7MYTiLNjx6k8vVNG2wN91
 TZh8Zo4igG6NGxhcGitBQPmUWUDkAKAYQ8jabNBQauKSDInsn7/t/cv3e
X-Gm-Gg: Acq92OGhGTIdlzpRZEqAOPcdzuVkSij7UHVl/aZbvAAsHq97pnpOc80EmWkj/9ERD2M
 lGtO9kvMt50a8YbvusFa1jo17PRm2rkHpQrLTgKDX6X+QoDjOQV2DqvQ2su3U1abnm+EPFRL4YO
 YcHv/vjrJT+uifozigce/MI2TZZU/lEUFKZbXmwBaBp7rWiCFhYu169YQxCsuaQ/2wWgyIR7FuU
 QvcGSHjXgf20fUJr/UB/8ayzSqisa+4kfawcirjUrT43T/Y1Mfgxa4APlvBFKF7T1Lmc90WvctF
 yYZF2VEknjldOuhG8MDEeNNda7FudGSHTbxYsYYYvtHJpvRDt94+d4Gk+52CXaQmD2AtPigDJAr
 MfIPrlZbaQg49xGmTvEBz5vfVvw==
X-Received: by 2002:a05:620a:6908:b0:912:c0b3:7d99 with SMTP id
 af79cd13be357-9158a674e2fmr865919985a.2.1780519779108; 
 Wed, 03 Jun 2026 13:49:39 -0700 (PDT)
X-Received: by 2002:a05:620a:6908:b0:912:c0b3:7d99 with SMTP id
 af79cd13be357-9158a674e2fmr865915185a.2.1780519778587; 
 Wed, 03 Jun 2026 13:49:38 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3e35dbsm351132085a.42.2026.06.03.13.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:49:37 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:49:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
Subject: Re: [PATCH v2 11/13] vfio/migration: Implement
 VFIO_PRECOPY_INFO_REINIT feature
Message-ID: <aiCTYBDbpx_og9Ug@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-12-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602092621.382-12-avihaih@nvidia.com>
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

On Tue, Jun 02, 2026 at 12:26:19PM +0300, Avihai Horon wrote:
> According to VFIO uAPI, precopy initial_bytes is considered as critical
> data that should be transferred and loaded prior to moving to STOP_COPY
> state to ensure precopy phase would be effective.
> 
> As currently defined, initial_bytes can only decrease as it's being read
> from the data fd. However, there are cases where a new chunk of
> initial_bytes should be transferred during precopy.
> 
> The new VFIO_PRECOPY_INFO_REINIT feature addresses this and allows
> reporting a new value for initial_bytes regardless of any previously
> reported values.
> 
> Implement VFIO_PRECOPY_INFO_REINIT feature:
> 1. Opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 to make
>    VFIO_PRECOPY_INFO_REINIT available.
> 2. Request a new switchover ACK if initial_bytes increases post of a
>    previous switchover ACK. This ensures the device is not moved to
>    STOP_COPY before initial_bytes has reached zero again.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


