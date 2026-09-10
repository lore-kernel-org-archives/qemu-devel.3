Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C39EC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lQJ-0004Cc-Kt; Thu, 10 Sep 2026 16:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4kzg-000657-Co
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4kzI-0004Fq-Ll
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789070535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BZcx8FVaWz44fKyE7nQm55vKc/26X7J8ZKRRJh4Yc8I=;
 b=VuNtqN4NlNA3IZCIInCw0ldVzBxV4bHVb+8j6QQ2J6oOY/YkddG7bKCZv3Ij0G2qyprzdx
 78qyqPQxHp9t8Kni74oqmr2H2Qme1/gpJbRqZRdwSuFaa5ZBWysmgMPEsvL0DhkR2gG6OX
 dqurL3VQHaTU21A++HGbLPES0XVxqTI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-HNoUIdUBOkWDrbQTy4WgCw-1; Thu, 10 Sep 2026 16:02:13 -0400
X-MC-Unique: HNoUIdUBOkWDrbQTy4WgCw-1
X-Mimecast-MFC-AGG-ID: HNoUIdUBOkWDrbQTy4WgCw_1789070533
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9106fce784dso1919456d6.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789070533; x=1789675333; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BZcx8FVaWz44fKyE7nQm55vKc/26X7J8ZKRRJh4Yc8I=;
 b=uLRmBJyM7uT4qGi5RT4qDBGWZ2gUYyj93mo5QTsi/cFb5m8Lm5VxKT/F/RJHjJQomw
 PiEIsPZlniUY9jeH81JKdD86QtCS8gh8e0DMd0j4TRsvUY7SAkV91SAtARWt1S8Jnj0L
 rLA+/kFZ4sX/+l9sDwpIl8facsRxdxHanvpBglIzKW44ohiHuzfce+MLy6EkjZBlaBsP
 GBJRz0C+wM0r9+8bhLc35T6i6mXIJ0qSEvobz8xpEbKwN41WtYUypwEJdqtP7uwBHJLq
 pcn6Ey0NoGroMoD0pCvLNbgSIZATwE2h2sLkiKcalYPNYbrlWbyD17TVn67z5IcXPvXp
 Hp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070533; x=1789675333;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BZcx8FVaWz44fKyE7nQm55vKc/26X7J8ZKRRJh4Yc8I=;
 b=RfaLiaKXERyk4M13C00Lb5H7+1kOMi6upTTx0uMRoQ6LYFusmmgOf4n4F8eaE41uOi
 0XFOlohdaqksPtV15wUDMIUW3/ulLe1gynT2/ewHL/q2/S2pIqdO662uTBl7SfNa0qCp
 eH4uS7r7yrZn8AqcbBDQC9Cbb3Fi8W+QEm+7nrLMHYtTg9q4qwJw4riXUAJdpu8o5zFq
 PobSXqZw3KwlRWPrLdKukw29jHfn+sjHL0NRkep0zn8LV1dzmRSC+PW15wEufuOQu+1o
 tPHCkKe06aTrV+0PYrK+MbkiQjilGFA98GrlITF96QepCjUW0g5WB2cO+4tnUfQmQjRQ
 9ruw==
X-Gm-Message-State: AFuF++kWIeAe+n9Ax1xUx3SWjEy1wrgF53yHDCb2Vp+OnXxll/eoCIEH
 Ys0zy69FW5wy25EanYsZPdTa3ofoAubKVjjqZtNBnhmGiQMHfEPNAxpoEZ5z6Mz+wX8gWUtw2hx
 IaIXghMP5oky+b/a2EadQhp8ednJHaFi7X7Otdg8nokb2uwWJxXv9n12u
X-Gm-Gg: AYBFou0fF7m2Qw0F5VFtpQoHY4veWK2zMn6B+APTYLrw4PK4HXTSnnbmuMazfgfiYpl
 6NbhM+BOpLykPfRzDFpCDOv9Fl3iKz371lo/Xtts3dUjmrnpZmVPnKNX+YDg1jkNJCvl8VCKSud
 lhQkgvMwFtGs11XggL09bIOlQyw4cw1qdo/LW3AbdGg4aookAeh0Kc3oUb0Kuz/GrjdwqvROJwg
 K1EZU+gphQMQFRyvOPCSAm1S/LL37M1V5uO4v975CLxcjerMwcjrh+Z7/teXqOi2cuJ2tih4PI6
 Ioh15m/s/rceU2S+gSrIqatjGvssDzg29IFbSiZwHDHkyflsAgBMbyqUc9MR0+013jaV5v7ZVPT
 bn+EqdogNT5+i8H3O/MDkXLn7u9NSok5kFXI5fLcO5cb+urI+ZMtq5WOSBMI=
X-Received: by 2002:a05:6214:f64:b0:910:3452:d57f with SMTP id
 6a1803df08f44-912120efc7fmr8280836d6.31.1789070533215; 
 Thu, 10 Sep 2026 13:02:13 -0700 (PDT)
X-Received: by 2002:a05:6214:f64:b0:910:3452:d57f with SMTP id
 6a1803df08f44-912120efc7fmr8279436d6.31.1789070532723; 
 Thu, 10 Sep 2026 13:02:12 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f2032d4sm4028506d6.5.2026.09.10.13.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:02:12 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:02:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, isyanfei.xu@gmail.com
Subject: Re: [PATCH v2 2/4] migration/rdma: Drain writes at RAM round
 boundaries
Message-ID: <aqMMwjJYCbTDsG5E@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260830012750.1567524-1-yanfei.xu@bytedance.com>
 <20260830012750.1567524-3-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260830012750.1567524-3-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Aug 30, 2026 at 09:27:48AM +0800, Yanfei Xu wrote:
> rdma_registration_stop() runs after every ram_save_iterate() call, which
> can stop before a complete RAM scan because of rate limiting.  Draining
> there ties the completion barrier to a SaveVM section rather than the
> point where the scan wraps and a newer page version can be sent.
> 
> Register an RDMA RAM round notifier that drains all outstanding writes.
> Keep posting the buffered tail in rdma_registration_stop() so it remains
> ordered before REGISTER_FINISHED.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>

Suggest to split smaller changes out if possible in the future, e.g. on
adding errp for qemu_rdma_write_flush(), which is an improvement on its
own.  Future, rdma_registration_stop() can be converted too.

But that's trivial and ok, not a real issue:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


