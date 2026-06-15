Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9626BCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7T3-0000aA-1w; Mon, 15 Jun 2026 09:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wZ7T1-0000ZV-Db
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wZ7Sz-0007Cz-OJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781530504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFkYARnoXZofasJbdBAJALBB1op6Hut98FtjeDtEYT0=;
 b=H0YB0K04VUtrNF/FQ/QEF8/MyBHe9P3Zmvei0Z2GmgskMXsb3zDCwNsATHVYh6zd3o6X+t
 xh7j45qyVWhlNIRlGk4SLwHJU3D7PgKsjtSjHJZn6Pd6SmKIAowrSXL5prR5q0RP9+A+Et
 WJFhH46IeJV0gd+4wzoqW/67CgPlRVg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-VQfPae8vOcmCQVxCbQMtVA-1; Mon, 15 Jun 2026 09:35:02 -0400
X-MC-Unique: VQfPae8vOcmCQVxCbQMtVA-1
X-Mimecast-MFC-AGG-ID: VQfPae8vOcmCQVxCbQMtVA_1781530502
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9159c4b210aso551077885a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781530502; x=1782135302; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BFkYARnoXZofasJbdBAJALBB1op6Hut98FtjeDtEYT0=;
 b=PXFnenyaU4xxjt08zguNmttEH/hYieCM53KWTDyP4U4ZRaiyrbTmfwz4KqDdSyzNyt
 D+YQxhbU6YRvnGwe06QzHIcA28gaWm08AyFs6J9fJpOZWGaN4xkvmdjlpZ5RIgE2uDTN
 nFpkNelbLWcrZZVaDFZPHvgOTvf0tcL+VjPrxQGAN17kL36lOkVwt4zlFabKEEVEjRcf
 2rh4LdhSyQlkebeNcnweCkH3ARkohnXcJM8/ggEolvStuSs4L5Bf9U6HgFHXDi5/ToMO
 2XE4OTnEdqhkDTfy7t9bUy2tYZi1FHMdDi5qKBkmSMFd4zaVM8LzpHYmmLLd73CAEFjc
 78Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781530502; x=1782135302;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BFkYARnoXZofasJbdBAJALBB1op6Hut98FtjeDtEYT0=;
 b=fqsDS3uoim5eDO/TlfNfCJ8dGl+eSscmagVE70EMKONVSDZRl3LKdv5XaHGAt7s63o
 rvr7rGRC+Om9nkDYToyWCh/dQn276M0ALM7Tg2/DJZ7QHUgT5zdsr3r0D/hm3BYBZxeQ
 LGmzx833XTeF31Pfjwedo4KDWD4KlwapHhfVC2imOGSrdNNdRpf1WnaUnJ/l0ETAV+vy
 VwwdfW2k6GDReqjjW6/8ZTmOxcUZRaCWyl3bnKwqJvwv+9mYPoThKP/3myfb1LOXAtpe
 M4X9zoTc0Tg+sVQ6alGItJ7jRvcyjgTkhpWP/h0LO4un+aCDL1ZGvl9XC+AcRBMgnRO3
 1ybg==
X-Gm-Message-State: AOJu0YwYWsB6WawduYGZq+X4yMOXF52ZNWD3YoXWu3BCBgKZxKhtiXml
 wvem/jY9GYjkez3NRT9Sd5SYZwDRFAT/0W9kn1vRnUmrQ5BsJAZjIPGHE9vG5W5ZrosHL5CH/Do
 pt0unpnWWms8MsKRaXNJHCpkFu1L1qBxbsBIGEdJiXM6Bv5zt/ONolPzW
X-Gm-Gg: Acq92OFCNy8dQtNAiW33+yQGlEY+/aghZOI2uLCuTfMiYAwRsFHdgNYTo9qMKpVEpcA
 211ypikgyAmIrz5t4iNegRxqHQEJ+t3ZLp4JyEL0ZIXxA3VTRClVLZVEuaNjr/M0QIq705pwkCJ
 WniquVBx/6VqL1qDc7zBlnH7Gvy3pZH2SASBTzA7FmKHrv0ANa43m98S6BZUxL3FAJup5zmComS
 nI9Kp29yfLPuGmsObltkY+AJYBPXDrf53QbPCWNHS7beo1C1sm1IgRNQM5NO+I7tHQLiN8QYlV7
 /efmRF3MlGwRu7k17GIgb/VOskl7PLooTTYlZzjNGdPspLs10Sri7FiBL55YGWM/KVw1bgK8lGJ
 2SySrxBtt68VwWYI=
X-Received: by 2002:a05:620a:a408:10b0:915:e8fc:153a with SMTP id
 af79cd13be357-91619e344e0mr1297867885a.14.1781530501982; 
 Mon, 15 Jun 2026 06:35:01 -0700 (PDT)
X-Received: by 2002:a05:620a:a408:10b0:915:e8fc:153a with SMTP id
 af79cd13be357-91619e344e0mr1297861185a.14.1781530501059; 
 Mon, 15 Jun 2026 06:35:01 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619ed7857sm1110416185a.4.2026.06.15.06.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 06:35:00 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:34:58 -0400
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
Subject: Re: [PATCH v3 07/14] migration: Make switchover-ack re-usable
Message-ID: <ai__gjsVcZs_ecLc@x1.local>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-8-avihaih@nvidia.com>
 <aiww8tN6dRLA3t_R@x1.local>
 <e4d00894-990b-44b3-b89c-7cd1b0398a0a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4d00894-990b-44b3-b89c-7cd1b0398a0a@nvidia.com>
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

On Sun, Jun 14, 2026 at 12:50:14PM +0300, Avihai Horon wrote:
> 
> On 6/12/2026 7:16 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, Jun 09, 2026 at 10:58:05AM +0300, Avihai Horon wrote:
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index 4d8b15d99e..8219f13779 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
> > >       { "chardev-vc", "encoding", "cp437" },
> > >       { "tpm-crb", "cap-chunk", "off" },
> > >       { "tpm-crb", "x-allow-chunk-migration", "off" },
> > > +    { "migration", "switchover-ack-legacy", "on" },
> > >   };
> > This line needs to be moved to the last patch, or people will get very
> > confused on last patch flipping default without caring about old behavior..
> 
> This patch Implements the compatibility flows for legacy switchover-ack
> which use this property, so moving this line to last patch sounds even more
> confusing IMHO.

My comment only applies to this one line to change hw_compat_11_0[], not
the property itself.  It won't affect this patch.  It's common pattern to
do this in one patch to "update default value, but let's keep the old
machines unaffected".

Btw, since this value still has a default value ON in this patch, moving
this line to the last patch won't change anything except making last patch
clearer.

Thanks,

> 
> The last patch should not be viewed standalone, it's tightly coupled with
> this one. Plus, it doesn't make sense to have the switchover-ack-legacy
> property if it's always off.
> So I personally don't find it confusing, the last patch simply enables the
> feature once everything is in place.
> 
> If that helps, I can extend the last patch's commit message to something
> like:
> 
>   Now that VFIO has implemented new switchover-ack, enable it for new
>   machines. Note that legacy switchover-ack is still used for
>   compatibility with older machines via a compatibility entry for
>   switchover-ack-legacy property.
> 
> > 
> > After move, feel free to take:
> > 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > PS: If Cédric feels comfortable updating that while queuing it'll be fine
> > too.
> 
> Thanks.
> 

-- 
Peter Xu


