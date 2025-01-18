Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E3EC02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 12:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ8HD-0004nv-7b; Sat, 18 Jan 2025 07:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZ8H3-0004jR-RQ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 07:50:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZ8H2-0004a4-4L
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 07:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737204598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8l/d5KV/8s3wkPJfWcuVSPM8mpiW0Rb/pYFHFNKELfk=;
 b=ajBpJ3oCrOHelRwzM/LeHgxVsTDb1Np7G5D6PlcMo6Gdqqdb9WIKvooM9YwxCcvHAGL5Ua
 RpGxHck15lVlYy4TZk7M5iqIh3vdF7ElHFoR0lxFdzJrpvFM4N1zI/aebeE2o3SMeH/FH3
 ccZlu/DptPDRQIRiQPT5v/X+hmGscn4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-_t_zxh6kPcSFTxk0W1s84w-1; Sat, 18 Jan 2025 07:49:56 -0500
X-MC-Unique: _t_zxh6kPcSFTxk0W1s84w-1
X-Mimecast-MFC-AGG-ID: _t_zxh6kPcSFTxk0W1s84w
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b93c7ffaeeso583989385a.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 04:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737204595; x=1737809395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8l/d5KV/8s3wkPJfWcuVSPM8mpiW0Rb/pYFHFNKELfk=;
 b=H7SeTm2lc5XP2b8qyGmw75nLsG7w7YXty68mjz7XPxD6Hc8lYpPA6qU51nt/MXuAub
 BV9A4P5H/Mze4WGbp+9AjR+o6JpMVpXMm4aB6sbzO0VMFuD3I3pwufYHRZR/8yLfCJ6i
 f4cUFVhRWjAfG5yKZP06xauwXm3hfbkTv486lh+Mof7On2Xywg2MQzA55VwS6QFn+NZj
 afVFXvWRhRhvHjnHh7Faf/CEJAYAtXhqJx9/yS0Hz2Ox7oBUF6/6PqmtIQtIE6WUWMFi
 ANoqUlF7gc6JWZoLvtCrRFc1FWVygMoJKceo7+6r9SmAAp3pdOfZCmdvnJtx2DHZPI7g
 bqQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQYS0ZxGupkZrhBn6YdHTDl4l9Bi1puHq45ae81yQnkZG7HwbI1UytbVUETvCHGKgzapfCdsak+7sc@nongnu.org
X-Gm-Message-State: AOJu0YyBEQqD5gwfzy6vyNQmFkkuffDSt9bi9T0eJ0fvBsDka8/mHaLm
 khdrtqi7w7jdEgkrQonA33yJSdLpEXVP4It5Cy4KZuH72M5eYHk9VYsr3ztsu/xTW5e192bEAiu
 piAcTshATxisw6F7fD8pCZfZgOGyJ4FuGqkyxnhsqIbxGc1+16U6b
X-Gm-Gg: ASbGncuAa9ZtYXCDbRVQlkh0kqm6+kTjX+yvVWNbe0pc0+t7ug5neK5RcLRRjqf2Yve
 KMGbgyAs1q4ZhPKpvR7MpjIjnPzVy/RPxeiK0UWh5XOvvyI0T0Q45esZsLb6bp2UapUGIQoM+8p
 Y1T/in34zcmqDiBzddhCdAEoQM7aBhOyfRJ6mzfwXI4fxPew4zbUcaSxxQoFOdYdeNia1xba4Nl
 mJbQl5Qjk+CdpZOrp+k8HcaPsKI4S0AkJcnT32KT6e8nAZrqHVkMKOuFgbYMtDt2JvbRaNdIVNR
 PtgmaM+3QR9X83NXsbRi2C7eg7UKFsE=
X-Received: by 2002:ad4:5bee:0:b0:6d8:f005:b573 with SMTP id
 6a1803df08f44-6e192b813fbmr230261276d6.1.1737204595561; 
 Sat, 18 Jan 2025 04:49:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXkf0h8fhUvSFDdW/CX0+VS3jBI8cELMSP9+v1TYSKY7yulhB6lNXIKatQkgaABHWRw+KFEA==
X-Received: by 2002:ad4:5bee:0:b0:6d8:f005:b573 with SMTP id
 6a1803df08f44-6e192b813fbmr230260796d6.1.1737204595132; 
 Sat, 18 Jan 2025 04:49:55 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcf7023sm21727486d6.122.2025.01.18.04.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 04:49:53 -0800 (PST)
Date: Sat, 18 Jan 2025 07:49:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4ujbzFJbRWTmOPK@x1n>
References: <Z4e7gFSqdhcmJPYb@x1n>
 <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com>
 <Z4fW_rI7Mfrtc1Fg@x1n>
 <af018f8a-ce00-4ce2-9fe9-b6ba3f97bfa1@daynix.com>
 <Z4fezdR1ApN8ZLTS@x1n>
 <99016684-b5f9-446c-b85f-0dc21d1edae6@daynix.com>
 <Z4kYxLsIbzq7jWzz@x1n>
 <627beb0f-e6f7-4733-997b-038b70195485@daynix.com>
 <Z4qXfgJMAySLFeOm@x1n>
 <d8ab7a88-cf34-4989-909a-bf5fad502f15@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8ab7a88-cf34-4989-909a-bf5fad502f15@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Jan 18, 2025 at 07:15:56PM +0900, Akihiko Odaki wrote:
> On 2025/01/18 2:46, Peter Xu wrote:
> > On Fri, Jan 17, 2025 at 03:24:34PM +0900, Akihiko Odaki wrote:
> > > On 2025/01/16 23:33, Peter Xu wrote:
> > > > On Thu, Jan 16, 2025 at 02:37:38PM +0900, Akihiko Odaki wrote:
> > > > > On 2025/01/16 1:14, Peter Xu wrote:
> > > > > > On Thu, Jan 16, 2025 at 12:52:56AM +0900, Akihiko Odaki wrote:
> > > > > > > Functionally, the ordering of container/subregion finalization matters if
> > > > > > > some device tries to a container during finalization. In such a case,
> > > > > >                          |
> > > > > >                          ^ something is missing here, feel free to complete this.
> > > > > 
> > > > > Oops, I meant: functionally, the ordering of container/subregion
> > > > > finalization matters if some device tries to use a container during
> > > > > finalization.
> > > > 
> > > > This is true, though if we keep the concept of "all the MRs share the same
> > > > lifecycle of the owner" idea, another fix of such is simply moving the
> > > > container access before any detachment of MRs.
> > > > 
> > > > > 
> > > > > > 
> > > > > > > removing subregions from the container at random timing can result in an
> > > > > > > unexpected behavior. There is little chance to have such a scenario but we
> > > > > > > should stay the safe side if possible.
> > > > > > 
> > > > > > It sounds like a future feature, and I'm not sure we'll get there, so I
> > > > > > don't worry that much.  Keeping refcount core idea simple is still very
> > > > > > attractive to me.  I still prefer we have complete MR refcounting iff when
> > > > > > necessary.  It's also possible it'll never happen to QEMU.
> > > > > > 
> > > > > 
> > > > > It's not just about the future but also about compatibility with the current
> > > > > device implementations. I will not be surprised even if the random ordering
> > > > > of subregion finalization breaks one of dozens of devices we already have.
> > > > > We should pay attention the details as we are touching the core
> > > > > infrastructure.
> > > > 
> > > > Yes, if we can find any such example that we must follow the order of MR
> > > > destruction, I think that could justify your approach will be required but
> > > > not optional.  It's just that per my understanding there should be none,
> > > > and even if there're very few outliers, it can still be trivially fixed as
> > > > mentioned above.
> > > 
> > > It can be fixed but that means we need auditing the code of devices or wait
> > > until we get a bug report.
> > 
> > We'd better have a solid example.
> > 
> > And for this specific question, IIUC we can have such problem even if
> > internal-ref start to use MR refcounts.
> > 
> > It's because we have a not very straightforward way of finalize() an
> > object, which is freeing all properties before its own finalize()..
> > 
> > static void object_finalize(void *data)
> > {
> >      ...
> >      object_property_del_all(obj);
> >      object_deinit(obj, ti);
> >      ...
> > }
> > 
> > I think it used to be the other way round (which will be easier to
> > understand to me..), but changed after 76a6e1cc7cc.  It could boil down to
> > two dependencies: (1) children's unparent() callback wanting to have the
> > parent being present and valid, and (2) parent's finalize() callback
> > wanting to have all children being present and valid.  I guess we chose (1)
> > as of now.
> > 
> > So I suppose it means even with your patch, it won't help either as long as
> > MRs are properties, and they can already all be gone in a device finalize()
> > even with your new patch.
> 
> The owner can object_ref() to keep the memory region alive.

Do you mean explicitly (rather by the add_subregion)?  Why an owner need to
do it at all, if it knows the MR is part of itself?

-- 
Peter Xu


