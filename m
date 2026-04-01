Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB7810FCAD2
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82Na-000615-FO; Wed, 01 Apr 2026 16:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82NW-00060b-BW
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82NU-000517-Ct
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775076086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5GuELcmKh2tX/e/g8eRLuvhrRPGmGPw8zl9XaURh8E=;
 b=KMs8gFMJe3DGlFjSLEckZqzCQyi+4vQAguWhc4CRCi4Ao5EYzWCehezNESWNI0thhkbJpn
 puPXrDbpGbfySa+clipXdzwS56H4AQvVcheey5Q30DdUdHcODWH8/L+nppXAS4MkrAjxpi
 JNCpCuPiMi04WGIN/toA3bn4rHiK4M8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-WbylE-oAM6yoA3C_q1Vwxw-1; Wed, 01 Apr 2026 16:41:25 -0400
X-MC-Unique: WbylE-oAM6yoA3C_q1Vwxw-1
X-Mimecast-MFC-AGG-ID: WbylE-oAM6yoA3C_q1Vwxw_1775076085
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd7ea0bb20so64679885a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775076085; x=1775680885; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G5GuELcmKh2tX/e/g8eRLuvhrRPGmGPw8zl9XaURh8E=;
 b=rltdXg3pvcXRwnF8FQMvLj0POpReoPY20loyCXowTMxjR8tFHnTetwcJkXBURMVbd/
 qBV4+Z63G2im3VE+oGwb44BCQ4gebz9mn4VhUerCda6wEP50dzzQh6ZO2Fuz1LM61myW
 q029YMHeX/1Isdqz+I9pvegHE+jMHfWdzIzhx1P0B3uYTueDox5yfk1IEW7pAUQDSOBc
 6Y2j3znDl7oiksITCiUPEGjhCbDf8CFcDoAHHM3gymjFyMY2/YE9UokDOIMt2wHN6UuE
 TQiQNaLtCGvi8G8Y46Cgd9oiDW1OH8vXrYpP5dLfHYU7M/jgOEJBlkL/alqlcN8LZPXi
 S2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775076085; x=1775680885;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G5GuELcmKh2tX/e/g8eRLuvhrRPGmGPw8zl9XaURh8E=;
 b=qoV0GCvX5yJM3c/3M37AS+rt6sZcnq5VVLuEI5l9Css08h0ARCJtqc0ywOh0OldGAD
 jA0jCW2B9npvIl9ZytzSqqT96U6KaqH8BNcpMUdj3zLWLpOZYQiRSw1wfI1T+/nYqPTC
 FOW6togaR+G4t+fPmQFMEFVIdIofIsaxTI0i3WHQBfum/SzJHE203lytF3dxB1KtQ93p
 sIht7599FIQmgFVacvKCLxbzAhxU/YVkm6T/2rwHw8vUhH2NThG83LSp+IPaVW1b/zqs
 PAUD8ndu9Vy0OdeRnaFAHeaoKtP8AI71iilTR+jA/ajc78roAbb19jbHG+7x8KRXJVR0
 FMew==
X-Gm-Message-State: AOJu0YyUcCSwMUh8Xs2ZYWyYr3D9wpwob5iMLtk5+2cDt9shar8/W/Iq
 TnSTGaEvBST4P+v4+wrnT/KaxZ7ZBBfOc9HukJcKC23sfzL8NDkdl79Gngbjk1MC8VbamEdK3dG
 nqZocb1iKW3duyBNTSqu+9DNvuxjkZxmsac7m8RsI9mcwe3v0tFkuunR7
X-Gm-Gg: ATEYQzw2Fsc9cxo7LTqka6M5L6nQEF1kYHjEzzDoWu0AtpoawsEgbT5jlhfhtQJnrsg
 s+AjOlrsqFq7dkEm9r08taBxFZt7k+vZA4ExNx6X1rLin9D/CgoEIWzcCe6TkUSBhA4aMCRvey1
 YsIuAmqS6eV7joo6qV5X7jCp6MJimy4tUk92kqxp2Ukc8vdkd9qCW40WXy5hkk/eXi+thifEazm
 zanU8+VcZuiLT90JH7rkHHXuFeeU8VtRCl/8RnsPr/GTdTyySjDPsDeRba8PUyiEhtghdYL07Lk
 fnLuajxvRYAz56/kM+1WhuETIuOmSwKeMjkznvYfOITtha4cyC6dIdPuPxg6xXLHw1s2Zt8U0pj
 BLTG7tmjH5eXf/hv1/P+lsZxAXk8/t2tPIwyoyOAALo9Mow==
X-Received: by 2002:a05:620a:280c:b0:8cf:f215:24c6 with SMTP id
 af79cd13be357-8d1b5ae661cmr776026385a.21.1775076079871; 
 Wed, 01 Apr 2026 13:41:19 -0700 (PDT)
X-Received: by 2002:a05:620a:280c:b0:8cf:f215:24c6 with SMTP id
 af79cd13be357-8d1b5ae661cmr776020385a.21.1775076079212; 
 Wed, 01 Apr 2026 13:41:19 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5392d1dsm75239085a.1.2026.04.01.13.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:41:18 -0700 (PDT)
Date: Wed, 1 Apr 2026 16:41:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 04/12] vfio/migration: Cache stop size in VFIOMigration
Message-ID: <ac2C7b21mdR8phDl@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-5-peterx@redhat.com>
 <894ad48a-6779-41f7-bf9f-08008c8e4bde@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <894ad48a-6779-41f7-bf9f-08008c8e4bde@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 25, 2026 at 04:15:45PM +0200, Avihai Horon wrote:
> > @@ -415,6 +426,9 @@ static void vfio_update_estimated_pending_data(VFIOMigration *migration,
> >           return;
> >       }
> > 
> > +    /* The total size remaining requires separate accounting */
> > +    migration->stopcopy_size -= data_size;
> 
> stopcopy_size is also an estimation, so I think it's safer to have:
> 
>   migration->stopcopy_size -= MIN(migration->stopcopy_size, data_size);

I believe this is very relevant of the question in the previous patch, on
whether reported value can be shrinked.  In this case, it's about
VFIO_DEVICE_FEATURE_MIG_DATA_SIZE instead.  We can discuss both ioctls there.

I hope it's clear to you on what I wanted to do with this series, which is
to have counters cached in QEMU so as to align the estimate/exact reports.
The counters should (in my hope) be 100% accurate reflecting the current
status of VFIO device, not necessarily the latest.

Thanks,

-- 
Peter Xu


