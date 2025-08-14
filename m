Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B446CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 20:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umeZ1-0006ku-Cj; Thu, 14 Aug 2025 16:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umeYi-0006iL-4s
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 16:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umeYe-0005v8-I2
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 16:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755203296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pqIfSDAFXxXGyDFAjBzP4X8Ehr+OIiChGxR39uJbV8=;
 b=Q/GPO0+7kSv0KNMAm5gYNj9p1GsIIcAFExfwb20+VQ0hwlWu74oOTWN9F7Fb16jJ3Ptn60
 XoGbuW9ixpbXO94J9VJ2C8S3V51TVFv4seUKkP8LM9S8J17XSttTSnCxTFfIJWDXWs1JW5
 GW+Czsk3fgeJlyS6idp1yrYpxwmquJc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-cmQnaPyfOhiw99opzsBnOg-1; Thu, 14 Aug 2025 16:28:13 -0400
X-MC-Unique: cmQnaPyfOhiw99opzsBnOg-1
X-Mimecast-MFC-AGG-ID: cmQnaPyfOhiw99opzsBnOg_1755203292
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70a9281419aso29198986d6.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 13:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755203292; x=1755808092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9pqIfSDAFXxXGyDFAjBzP4X8Ehr+OIiChGxR39uJbV8=;
 b=YUA13HmLvpcd45ckPpHKZwv/cJd8szL88MAax2Nf4TG0mPTnU9NSq/532Kzr81jra/
 ICyXXDFJ3EyIi6gUcIhOUyIrlbHsAGXBZfnNwrufczJAZtlDzP4q/KRpsgpBPocMcvay
 fG4eN0FtUtf0+uvnNo9/5bcqIHMRSW7AeY2oHMPEWXq4ct1zl/ZpBUBF3ajUNyMXvCZg
 abDpyYZaPPlXWVzchAu92LDdR7ZT+qT0rvCV3OA75hHUFZ/aTpSPUK1kAsD+Ggak8uNz
 Jh13cwBd94UgeO+Yhhm58Z73rA8DV64ZkqhkBKhDjybimuXrE3PVtuldyJ4j3S+eFO5/
 JN+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVezKq3T0Lr+Pddpf6VTFERPpyizDzlFbXZMhtf8JZMKxfF0UG8iAOYZhw2JaP2Ea+7MG/KJi5j34C@nongnu.org
X-Gm-Message-State: AOJu0YzuKT77Oj1WUcLpnImFdPbODBZr62PDtd/Rj91+Lbg4+zShXYxz
 TwPZqT0fnBpOFERaVnQVUsi3IkLj6MsT+YZdYuFuEigl08TyurJRPm0uoSVqqM2pv3FhXUVx14v
 bgaRWgkHwmylorI8ljq3kExwoq7YZ8UY7zlXNy6vWodBUXwle3K8tZRAe
X-Gm-Gg: ASbGncuXgMIkSE0TrgMN+hyHh99TcchFEjn+70sx4kc+WI5+Uo9J08amKY4MvYRpYak
 Tz5q317vX1QeGwlSV+/WWOKCeSqquewFnxUCwOBYEl+Bo12s/hywR21hih0Is5Ri/GPb/9/r0DK
 uWELpxrlTPB6SR8FqQt51vmPtuu8x/BcxBG9UZH6VoqzqxVozT+Eu+ILidXbrharqqIAQ17C47G
 f7XKwI7CSRWTv4WQLZVavXZXL7n+dZLHtuSKjLntyGzc7TsY5YMLE7fTsDR949EA4NdMcmPvvo8
 Q/Y/XZGF4QmCUPJAFWWjOD/zHDjKP4k8
X-Received: by 2002:a05:6214:2629:b0:709:7e2e:646e with SMTP id
 6a1803df08f44-70ae6f6804cmr77057846d6.16.1755203291499; 
 Thu, 14 Aug 2025 13:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvz4xFeUhXE1IG6g21+i9HeMkKM8y7HQYe1SjVFQxHrxOw2FugFA5kg8sS/k3qWTmV8+yRcg==
X-Received: by 2002:a05:6214:2629:b0:709:7e2e:646e with SMTP id
 6a1803df08f44-70ae6f6804cmr77057476d6.16.1755203291112; 
 Thu, 14 Aug 2025 13:28:11 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ae6cc98e4sm18267256d6.21.2025.08.14.13.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 13:28:10 -0700 (PDT)
Date: Thu, 14 Aug 2025 16:27:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 jasowang@redhat.com, mst@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, Dragos Tatulea DE <dtatulea@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
Message-ID: <aJ5Gzltr5T4CSQ9W@x1.local>
References: <aJOCiUPp0dckmgAn@x1.local>
 <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local>
 <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local>
 <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Aug 14, 2025 at 11:28:24AM +0200, Eugenio Perez Martin wrote:
> Well you need to send the vq addresses and properties to preheat
> these. If the address is invalid, the destination device will
> interpret the vq address as the avail ring, for example, and will read
> an invalid avail idx.

I see now.  But.. isn't vq addresses assigned by the guest driver?  What
happens if one pre-heated the vqs but VM rebooted right before live
migration decides to switchover to dest QEMU?

> 
> > For softwares, is it about memory transaction updates due to the vqueues?
> > If so, have we investigated a more generic approach on memory side, likely
> > some form of continuation from Chuang's work I previously mentioned?
> >
> 
> This work is very interesting, and most of the downtime was because of
> memory pinning indeed. Thanks for bringing it up! But the downtime is
> not caused for the individual vq memory config, but for pinning all
> the guest's memory for the device to access to it.
> 
> I think it is worth exploring if it affects the downtime in the case
> of HW. I don't see any reason to reject that series but lack of
> reviews, isn't it?

Partly yes.. but not fully.

I don't remember many details, but I do remember the series tried to mark
the whole device load to be one memory transaction, which will cause the
guest GPA flatview being obsolete during that period.

The issue should be that some of the special devices will need to access
guest memory during post_load(), hence one transaction wouldn't be enough,
and I didn't remember whether we have captured all the outliers of such, or
any side effects due to a possible obsolete flatview's presence.

In one of the later discussions, Stefan used to mention we could provide a
smaller transaction window and I think that might be something we can also
try.

For example, I think it's worthwhile to try one transaction per virtio-net
device, then all the vqueues will be loaded in one transaction as long as
the load of the virtio-net device doesn't need to access guest memory.

-- 
Peter Xu


