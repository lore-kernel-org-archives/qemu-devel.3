Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93696F8D746
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDNIK-0002Uk-Aq; Thu, 16 Apr 2026 10:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDNIG-0002TC-Nk
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDNIE-0002cQ-0U
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776348124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGCd4YAh356yXebzqu1v4k3/gQA1ObuKDjhA0KpwQmA=;
 b=fqHkvJShuvBK/LkM5xOwAauLEWj5m2cEpit+SYTwHZeirFI+KzyRMs56OBnTHlMqTB+fSJ
 EGFcl9babLYRft7+Z9tZql/W0deOgauXam7zKxE/SHonXAPuq52YaSvZaA1tTael/aVelT
 jbOvXQ8EAtacgwdBu9Xx9jiQ93oanYU=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-3G-_L70bPrOPR7-5BTBE1A-1; Thu, 16 Apr 2026 10:02:02 -0400
X-MC-Unique: 3G-_L70bPrOPR7-5BTBE1A-1
X-Mimecast-MFC-AGG-ID: 3G-_L70bPrOPR7-5BTBE1A_1776348122
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-60fe90d2340so2254686137.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776348121; x=1776952921; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uGCd4YAh356yXebzqu1v4k3/gQA1ObuKDjhA0KpwQmA=;
 b=TU6H/ajV6DtsnfUhtXMr/qJBz2fNJiV89377HuINMVQ6jGLurmxdzzwYLN+F/CsIMj
 Mp8KY77jvf8leqShMSHUMml5+864wFzHMKgOeAHbNrR7CUxG/osxjtjwZPg4+v7rlK15
 GGvIK2bPjsBGc/tqIluSXvHYKJOsNKIY5m4U2RlGHKt0YOZevEHdiFyPRLW6Pl7BFPOg
 hB8wOtD0/ewmxxy8SS4y1kP03FlAJJcKJI562jzLXDQp72TsEeD0UtJqjZpBEeVPjFfU
 HmdbjNom68kXcCkZQMp18QdezcHSB/j7SJ1mJxjabosAc50rk12Q0RGx/MXXJEG5jjT3
 GrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776348121; x=1776952921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGCd4YAh356yXebzqu1v4k3/gQA1ObuKDjhA0KpwQmA=;
 b=p2QkRAUx2Y7gJ7rsXtEYKWXliQJ7W71ND5P6MbbyiS+ddzgDHxgEjv5d17spxa6Z1n
 Q6oaOEAXuwZc2eebaAFj7H5J/d8IZQh4IlUbcqqeP4lrOuecC8UkIhKg+8g/ZitbVhLK
 99kHK08+avxZN3pioY+n64uD68YAg488EbjyGjfEh0Nh+ajoL9yUguzEW8/UQbaTs0lO
 q/qgros4UqK2OzgzZzCZ0i54JKFY1SFWP6z3VNv4I+Dw+4WJL2xpnq7AauZeRZ6pdms0
 HeZHCiVM542RtCnlWO6dRyZAiGzG7iWVLdpcyiEF8IfU7RgkRmAiGhOfQ7y65fwGLcFF
 nxmw==
X-Gm-Message-State: AOJu0YzQasfxLpsl+1JtNbSM1cgAxYqk+9z/yVCvY/76kTXhcHsSU7Bb
 fIJz05HAHMKJ8zpyQaCfrlgjox2UUi3rYaXDOXiP9ktWQJ7vu+ewkgdfSQCYLtewhbFl3Vh2Sg9
 W1ub9ULK/kBohNdA4njULuhVB/wp7eLIaefKT98avBgktZkDbYbGViTCa
X-Gm-Gg: AeBDiescgmp+R2GGbASDwhtPVBxGbFRQIChcUVnViB3FPnDwZrnoOx5vhrMFc7sWcF6
 ZhTNouW/kzbGEcf/CsT4ncrKUYB4Q9F82EWOWUxgZgz5gkLOp6NDil76kT6l7b9p3y5mOk0aqP5
 rnuVaS+j8eVxdkzNKG6ny4AOPgK4sRSZ6OPNTWs/h6cRMrhnsjEKtmhCXNQFGRBlQHRa4S/YEtl
 kSh9WG0d6K+/O2/BJzpf0s7NGJMAUoqBgXnNV0HCTtFLnQymAT1hXG+ULo7EmZyDa9gcmBNOoY+
 1tkcCcl0TQc77IOnFhz6LU1DVb7fYo7yme723stiwS6j1YnIdPmRCmZCLOVG+hrhNUoxhXfiEFe
 KHqw0HhaLzZEodT7/6yJKemaMrOoT/8GwgzJDiCjwuE+0fl9tqBsFuE8e3A==
X-Received: by 2002:a05:6102:38cf:b0:610:2912:adcc with SMTP id
 ada2fe7eead31-6102912e1eamr7953677137.30.1776348117591; 
 Thu, 16 Apr 2026 07:01:57 -0700 (PDT)
X-Received: by 2002:a05:6102:38cf:b0:610:2912:adcc with SMTP id
 ada2fe7eead31-6102912e1eamr7952620137.30.1776348110785; 
 Thu, 16 Apr 2026 07:01:50 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c976a5asm38159486d6.20.2026.04.16.07.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:01:49 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:01:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 04/14] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
Message-ID: <aeDry3y_G9WUTdc9@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-5-peterx@redhat.com>
 <3d818473-3c5b-42fc-9cdc-e074394e0103@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d818473-3c5b-42fc-9cdc-e074394e0103@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Apr 13, 2026 at 12:57:17PM +0300, Avihai Horon wrote:
> > @@ -50,13 +50,8 @@ VFIO implements the device hooks for the iterative approach as follows:
> >   * A ``load_setup`` function that sets the VFIO device on the destination in
> >     _RESUMING state.
> > 
> > -* A ``state_pending_estimate`` function that reports an estimate of the
> > -  remaining pre-copy data that the vendor driver has yet to save for the VFIO
> > -  device.
> > -
> > -* A ``state_pending_exact`` function that reads pending_bytes from the vendor
> > -  driver, which indicates the amount of data that the vendor driver has yet to
> > -  save for the VFIO device.
> > +* A ``save_query_pending`` function that reports the remaining pre-copy
> > +  data that the vendor driver has yet to save for the VFIO device.
> 
> Maybe drop "pre-copy" since we also report stopcopy bytes?

Sure.

[...]

> > +    pending->precopy_bytes += remain;
> > +
> > +    trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
> > +                             migration->precopy_init_size,
> > +                             migration->precopy_dirty_size);
> 
> Let's also log "exact", I think it can be useful.

Sure.

> 
> With this and Juraj's comment fixed:
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>

Thanks,

-- 
Peter Xu


