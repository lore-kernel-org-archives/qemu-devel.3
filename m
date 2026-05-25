Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7AECD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX2C-0005fq-OD; Mon, 25 May 2026 11:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRX28-0005eU-Jm
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wRX26-0006hW-Dq
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779722157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8uPW8yoYG7iov/RDNWk+gQwfpGK8GYqT1zDdSX4WBVY=;
 b=i+5MzDa4VlZuKVy7JsJAcltNv5w4z3f6pMqSIN3MGOGe4LIVouc38CRFcAqL/Ll6hUmHk/
 TJ4BgU2/m2+lGyJzdJy7aNajRgk7PJ18oQUNnt2reVoVU2ie5JqIt7d5jyMVGhTKfw26fn
 txNybJ0ZpbTYVuLIyF8MqmJkVT+lUCc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-3uwtZ1OgM8ebvOr1bnqzLQ-1; Mon, 25 May 2026 11:15:55 -0400
X-MC-Unique: 3uwtZ1OgM8ebvOr1bnqzLQ-1
X-Mimecast-MFC-AGG-ID: 3uwtZ1OgM8ebvOr1bnqzLQ_1779722155
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516d53eeb8aso74680681cf.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779722155; x=1780326955; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8uPW8yoYG7iov/RDNWk+gQwfpGK8GYqT1zDdSX4WBVY=;
 b=SR+29jLItCSP0teyMsUVooY+ZI3y3R30vOk45Sy83mTG62C8JTcpf94fuUFoTjNIyt
 lMEVMk0s/SCxfE/oOUfXDgBcMLUjCUc+N7EenOGtM4vWFNQXgfekCogvXr38JCg/aI4A
 zjFiyP/1LMlduzOiSvyTIjoruZ0+VUMy9zySEnE0b+HTFQzMezqdAvFCaAUXUGlLapIK
 DKoSOIDTbPbcPjB0NS/t6ShevXqlJETu6fKF4JWud7JR87xE4fIaGsfcGI0X3vTa4VTO
 9G3omuPqIYd6lsTAuC8XiLUQo4kzHb7u/ZCcWk1o04HqA2+10ablEYgljvoLMRbsJfuE
 bhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722155; x=1780326955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8uPW8yoYG7iov/RDNWk+gQwfpGK8GYqT1zDdSX4WBVY=;
 b=iZ8VQh7Qc++OAHAFv47rK1o1dBpDB7aP30YJ1KmJX4iP2pZQAfmAWtBiGq0pVSwBZz
 VIGPd5sCByBfUXiSCCjK9NqbCebSRyIZxBzhNp0OBQpeF168v9udJXrIdyt5Z9QaeiSJ
 tq2qMH53dkCbrSc0otc6nDbSFjzWjS1m8msfbtL0zKmP8RoD6DhudvDji4mPIRqusw+l
 1x7STXgcaAOJwYYImpbiQnoLAbYjywTIg3DXHQvy52VqxLYUbKFNm6w2cptGspR3Mq5N
 2xOAAlq8FEuX7dWwoPXi0gm6c17MpDI+EysGWDN0+maUvO/82ODh4s1wC+TwGLgIaxqK
 I8rw==
X-Gm-Message-State: AOJu0YwgYnDjehzTBJAoFRpaFc0y93YuPUK/eJ3ky0YxiEaFr0+HytLD
 DdI+RpEBmdLy2Gb0bWWJyekRVrN/skPHYtB94sT9eKRuJidt3Ib8OYuX/z4Qxz1Iv/DWAzt/gGS
 DREhdM9YBAbAsy0qDXtPnVCe73CK5t6Hojn/6g/lmZJxCMWZ2L0Gm7g0X
X-Gm-Gg: Acq92OELMLdSfJsIwbqFvxxdCUuefGCLgAFUttyoMakgZ2d1EX7yB3vAu/FDjSnYQFw
 SgpS0tsCb7WGEDn9CyOG0lq0rqBSOxRRytp9rxfLlkx0NnMb6epmRsN97JWMf+9GyINS6s7nCq8
 0z7gPr7k+tm2jCN3a1kulBgxQ/fWlcI1Eci2o/ixWmXuqSwrv8BTWiAAZpuMN9xbdhKXfr/BcAf
 bzj2udwm9IEhV2M6u14fQhl7bYSzR0jPLfhwpynpNnEs9eheQ75ghHtr8GX5RlmFESP4S8N9Zvu
 UiISJFGVSSzK48WxuE3Pb4ZTBSFVDqyTJxewUcTInhjcjPkPSiZSDIkqvTm3RvSlsXYVYZhn8bJ
 whN7gn8LNrbkaacgR2jcEW8P52K2Ip/2soEqAdZhAJKJto0A=
X-Received: by 2002:a05:622a:8407:10b0:510:1b61:d0e4 with SMTP id
 d75a77b69052e-516d45f9c81mr118700691cf.35.1779722154784; 
 Mon, 25 May 2026 08:15:54 -0700 (PDT)
X-Received: by 2002:a05:622a:8407:10b0:510:1b61:d0e4 with SMTP id
 d75a77b69052e-516d45f9c81mr118699991cf.35.1779722154130; 
 Mon, 25 May 2026 08:15:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d8cc6212sm95617951cf.25.2026.05.25.08.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:15:53 -0700 (PDT)
Date: Mon, 25 May 2026 11:15:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 00/14] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
Message-ID: <ahRnp0Q18iTZZJ0H@x1.local>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <agzDdH5vClAqwjAs@x1.local>
 <3a1d0bc7-7656-43f4-b763-5114d9dc57a0@nvidia.com>
 <ag8iwiwMz5IapU5i@x1.local>
 <2756b13a-498a-4e2d-a218-10b756e0bf5b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2756b13a-498a-4e2d-a218-10b756e0bf5b@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, May 24, 2026 at 09:58:57AM +0300, Avihai Horon wrote:
> 
> On 5/21/2026 6:20 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, May 21, 2026 at 04:53:54PM +0300, Avihai Horon wrote:
> > > On 5/19/2026 11:09 PM, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Tue, May 05, 2026 at 11:14:09AM +0300, Avihai Horon wrote:
> > > > > Performance tests were done by migrating a single VM with:
> > > > > * 8 GB RAM
> > > > > * 4 mlx5 VFIO devices:
> > > > >     - One device with 1GB of device data (stopcopy data) that runs
> > > > >       workload during precopy so VFIO_PRECOPY_INFO_REINIT is exercised
> > > > >       (generate new initial_bytes chunks during precopy).
> > > > Could you elaborate a bit more on what workload is executed, and how that
> > > > will affect REINIT reportings (e.g. is only one REINIT generated, or it
> > > > keeps generating)?
> > > Basically, I create and destroy RDMA resources (MRs, QPs, CQs, etc.) on the
> > > VFIO device in a loop for several iterations.
> > > This generates several REINITs.
> > > 
> > > > Can I understand it in this way: without REINIT, device is forced to put
> > > > those data into stopcopy size; then with REINIT, some stopcopy size is
> > > > essentially moved back to precopy phase?
> > > Almost:
> > > Without REINIT, the device is forced to put this data in precopy
> > > dirty_bytes.
> > > With REINIT, this data can be put in precopy init_bytes (and do the
> > > switchover-ack dance again).
> > Hmm, then I don't understand why moving some chunk of data from
> > precopy_bytes to init_bytes helps downtime.
> > 
> > Essentially, QEMU makes the switchover decision based on the math of:
> > 
> >     init+dirty+stop
> >     --------------- <= downtime_limit
> >           bw
> > 
> > The possible min of above is:
> > 
> >          stop
> >     ---------------
> >           bw
> > 
> > Here whether some data would be in init or precopy portion shouldn't matter
> > for a min downtime, since both portions are allowed to be moved during
> > precopy phase.
> > 
> > OTOH, if stop_bytes unchanged, min downtime is still the same before /
> > after supporting REINIT, if we try harder.
> > 
> > Say, with below testing results:
> > 
> > With VFIO_PRECOPY_INFO_REINIT:
> >    1335ms total (~520ms from the VFIO device running the workload).
> > 
> > Without VFIO_PRECOPY_INFO_REINIT:
> >    2352ms total (~1600ms from the VFIO device running the workload).
> > 
> > What is the downtime_limit you specified for both cases?  Have you tried to
> > specify lower downtime_limit than what you specified, so that both results
> > will become even closer (until they become, statistically, identical)?
> > 
> > In general, I can understand the REINIT will stop converging too early, but
> > it'll be the same IIUC just to turn the downtime_limit smaller..  IOW, I
> > may still miss some important piece of info that how this REINIT feature
> > helps downtime..
> 
> The init_bytes are special in the sense that it's crucial that they are
> transferred before switching over. Otherwise, VFIO precopy may not have full
> effect which could make VFIO migration slower.
> Accordingly, their contribution to downtime may not be just the time it
> takes to transfer them.
> 
> Specifically for mlx5, init_bytes hold a small portion of metadata used for
> time consuming pre-allocations on destination side. So, we may have 10MB of
> init_bytes which would take a fraction of a second to transfer, but once
> reached destination, it could take even a few seconds to load them.
> 
> When moving this data from dirty_bytes to init_bytes along with
> switchover-ack, we guarantee that this long pre-allocation doesn't happen
> during downtime. This is the time difference you see in the test results.

I see, yes that's what I missed and this makes a lot sense, thanks.

Could you put above example into some vfio.rst doc when repost, when
describing REINIT feature?

Thanks,

-- 
Peter Xu


