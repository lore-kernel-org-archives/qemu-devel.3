Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD50CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 15:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCK5o-0007PH-4B; Fri, 24 Oct 2025 11:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vCK5l-0007Ot-70
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vCK5j-0004l4-BD
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761321154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j6n53AlBvvrnmvaH3YLABuQFzSbHe1/KCxxyv8CfaaM=;
 b=OmPsySAb3pfLAV5NAAhDB1kNRdI0hg+Qt2aIsv4xLcJO4syPBjRIC9m87mmX/qBE4Xc4o6
 wpSUIi5iBMi7Cee1qi9GnY+4W4Eq4XGsbfx43mMTBtqBjk20xGBEdORCsW11AQGw1BGQAq
 Vc1cz6gD4yN3AJx7JJFVwLrLWwbZJ5Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-AAsq6LQnNNykkf0hAdHOgA-1; Fri, 24 Oct 2025 11:52:32 -0400
X-MC-Unique: AAsq6LQnNNykkf0hAdHOgA-1
X-Mimecast-MFC-AGG-ID: AAsq6LQnNNykkf0hAdHOgA_1761321152
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-87c1115d604so55653296d6.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 08:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761321152; x=1761925952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6n53AlBvvrnmvaH3YLABuQFzSbHe1/KCxxyv8CfaaM=;
 b=bL5QzRneYhLtwGGKh0LdAthH2/ix6Jjum5GYsFCBFXzjn5U3IqxP9/XJkJjr36zLXl
 IKNho0BDL3vUZ9sS54C8Ota3W76kcaEpWtzODpKmu4kzz/8meRb06B2MJI3g8dgYY94j
 jY4QnmgarkBEBQPi4fln07zM1s8rnQZv4CdY157MielIicLsKNfZnHYuv3BaG7gCH+ci
 nWgPDQaJgSgvBdGRmbYtNyZlqthqYA0CxuXJ60Fs4dVRUPOa4kCgt0dxr8mqtGAxhuWe
 mWiPpMxL/brCbfdXD7+/Tru2im0oXDsP+oBVmpJOR6GPaAZ18mMFkejC4ez3ag/jJYWm
 qgpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjYDM4UK88UmB8i3JHk3WNGu2AVUYinaIRJtqdTEVF60bCA/9uj9AMjAkqPifu8Z2s9+wTWovGIdVm@nongnu.org
X-Gm-Message-State: AOJu0YzxFX1dTJxRUcFvEYy2D720wSdtEwIUOk2FdqTNsjxK87bHQzyy
 coEOkvD4kNTZqhGU+wIMy8BUlG1AhapplZpjqNkMAEtRwefiQMBRIsQ17dbLWBIZXeToR3OiZOt
 gU7vc+lG8zcQRxxhmr1Igyl/SfHLe4YyIuM8UF7aQb9zIhRsLb4hURVbq
X-Gm-Gg: ASbGncuhY0l4QY4Pui9amv/+1JFvwNAyZcBNbpAE44U9h5AUSq8tmm2LyHGqRs4p0KK
 17z5DKf0bWulriA1HE748m/6+fQa6za+28kUYCQ6EdxljS8flU0nSSOOZ6Mp16wa1CYBvM9UPwx
 IleedwoOnq/tJbz99LjvVXrV2DYXG1foO5R0tD04912CzLOQpK8q0H8wQ0raCZmeQfuhu2azSIp
 jNbaE2xc2GSaF+vzOyTqmpfqaySJiFnWB5CGS8KkqAf7V3ztKorOFbuCPpvusELtktdrZieL03v
 gRiEyCH779cKzkEhvPx5aBuRWOmg49PiD00uJkAL38jHXzAma1PuTrOzhUi0KyJ+18o=
X-Received: by 2002:a05:6214:3f91:b0:87d:f2ea:6758 with SMTP id
 6a1803df08f44-87df2ea69bemr156171526d6.44.1761321151674; 
 Fri, 24 Oct 2025 08:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrtqHNuj50s+/BTpKOQlICGaTes3uoIDLiw5WiovLi6BkaMH9iRmgfZvoVg71vZJI3aOU4cg==
X-Received: by 2002:a05:6214:3f91:b0:87d:f2ea:6758 with SMTP id
 6a1803df08f44-87df2ea69bemr156171106d6.44.1761321151062; 
 Fri, 24 Oct 2025 08:52:31 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87f8fb6bddcsm39224066d6.11.2025.10.24.08.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 08:52:30 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:52:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] hostmem/shm: Allow shm memory backend serve as shared
 memory for coco-VMs
Message-ID: <aPugvDibWCyorBoW@x1.local>
References: <20250721065220.895606-1-xiaoyao.li@intel.com>
 <f38c961d-9c5a-4e45-a42e-fbafb7e5e88b@intel.com>
 <b1263375-8fac-4452-9c4f-983ef8870a44@intel.com>
 <f59ba5d2-e205-46c7-90c0-8e02ab91f5ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f59ba5d2-e205-46c7-90c0-8e02ab91f5ae@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Oct 24, 2025 at 08:51:35AM +0800, Xiaoyao Li wrote:
> On 9/12/2025 1:45 PM, Xiaoyao Li wrote:
> > On 8/14/2025 5:45 PM, Xiaoyao Li wrote:
> > > On 7/21/2025 2:52 PM, Xiaoyao Li wrote:
> > > > shm can surely serve as the shared memory for coco-VMs. But currently it
> > > > doesn't check the backend->guest_memfd to pass down the RAM_GUEST_MEMFD
> > > > flag. It leads to failure when creating coco-VMs (e.g., TDX guest) which
> > > > require private mmeory.
> > > > 
> > > > Set and pass down RAM_GUEST_MEMFD when backend->guest_memfd is true, to
> > > > allow shm memory backend serve as shared memory for coco-VMs.
> > > 
> > > ping...
> > > 
> > > Paolo, will you merge it for QEMU 10.1? I think it's worth it.
> > 
> > ping again.
> 
> ping++,
> 
> + Peter,
> 
> Maybe you can queue it in case it gets missed from Paolo again?

Yep, queued now and I copied stable, let me know otherwise.  Thanks.

-- 
Peter Xu


