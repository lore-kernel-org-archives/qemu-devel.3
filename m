Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BE4C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6SS-00080u-6P; Wed, 29 Jul 2026 11:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp6SQ-00080R-6v
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp6SO-0002sb-IA
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785339871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RW27TioWKCtgxn+Hlq0mWzCew5tdmgWGfVRWA5qPSvw=;
 b=bt+uRtNglDFawKGm0u2SmK9CERzMisQ2DAOhuoR9RPphekkCGSRc/yKXum0lAVo/4K3Pvk
 q3rEdbslp6ucD5x2PmIa5uZ8JRey134LJtEKIEuCBeY8sDv+mWSVn4zgVzTHnP3AYx0irK
 pCMZg+wutjvdtZ4CGxmHSoTQXvYcoRk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-WNJvZBuONHGLCu2PWpNdtA-1; Wed, 29 Jul 2026 11:44:29 -0400
X-MC-Unique: WNJvZBuONHGLCu2PWpNdtA-1
X-Mimecast-MFC-AGG-ID: WNJvZBuONHGLCu2PWpNdtA_1785339869
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4a41e3d6fe9so1229374b6e.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785339869; x=1785944669; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RW27TioWKCtgxn+Hlq0mWzCew5tdmgWGfVRWA5qPSvw=;
 b=dV0U21Wru2ZobCg3mGEiuSluCJp4qgskKr5RWLmBs97umHeeGOVvQ+rXc8+2GVDArh
 zgU0B5ERu/I7mSS6x7MNXi/r0dCpwYgHnrVqpFeWJtydOCPPGSxz9A3cknwKFq27Jdj2
 dmifFv9Dfbg89SZWvLtYloC2fRijqXzCHy6Uk9qy2dYBsJGqmVD2z4LKnRFycaH9jC/P
 7gH7s9D/1XGEwvQ1WZaHY15Qi6ERQhd/CtgCfFQuhc3qLnkc00/IveWc9bctlRy/cXc9
 NpiyLGRylob9FhL9fxthq2OUjS4AIMeWp/IwVMkwTnzR9DorVJO+waYG4sjc7Zv3R7F6
 HsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339869; x=1785944669;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RW27TioWKCtgxn+Hlq0mWzCew5tdmgWGfVRWA5qPSvw=;
 b=Lz2N18ccEiE6+hK/2BLolOFYuDeYvFPyp4Ju5/am2iPnsHOfSr5nbmdyY+5CmjN0t1
 c63tEC6n+Xu2AtZ8mOl8pUGmHfA+kfIQJkAj3gnAkBE20X8W0QJTKDLvnVeE+TE3LwoF
 w6pYeVLLC1R42TGYJ9FIFytDtlVTVoWl2ngIygfmejBbDD2zFEDTOao+nwkPQCweWAVl
 GM0OGnaT4TzJ5XdNAehZ8G4l8D5vcz//Y4S0cm7QeFgM8cP5vmM245HT0VHBust40SQy
 W2MYZFwJ0zAzwUxgWqrRd+cHn1EKHMMXsbPF077uxLNtRQXXZy92lF+rllN7vqBGhJ9Y
 ZLnw==
X-Gm-Message-State: AOJu0Yx4GwX69222RpjL6O6HPq8Ar9Pt0WaPTkHTtXqUWeFujxNQla1M
 PXiFKGNy0tDUJ3FNaMkaCHoeXNfpefNABQiBCxfr/Raxq2clXGZA18eIj8FRsRGjj3Xn31xdlM3
 LRX7feCDCtKWngx0iTJoSTMLRZnJiWLYcVhLt8w42BrbMkoXesUWh90j0
X-Gm-Gg: AR+sD11FNl7Iaq6HLvj5IOSYrhTdN+FbRU9MMEfO02WMymMHZIYJtiIrVOL89gczCL8
 KIBI+SdVxCWITsK69bH0BqBShs0W01ER9g+QicA4vlt8II27yRUP/6vDCdofM6zM8nmZTFcl7Y6
 85/efBDoHeNiPitjGiygow16pPVeCbucSghz0KUfXfcRksE4jFrIuodN1txB0Qsqs76HIlENanK
 V+Yfqm7xBNIMOqsAqZtnWZMjJj0K1ptBqmyfZ/HKHIoQSHp/BvVcYntvbJ+SNEAUQjKzWYU6qc2
 2i086uqPYY0/+cUIWBKZbpnrf8fdguYdYDqFoWV+klEpbtmsh8A+5jDa/vzLXa993aNkuH3JG33
 8oyWsv/ArJeWhKxrgmYjp2FVGPVs2scRx1ThGPawFkoFgfvazf6y84R4tC2I=
X-Received: by 2002:a05:6808:17a1:b0:490:315d:e0d5 with SMTP id
 5614622812f47-4ad5b9dbf94mr4808106b6e.16.1785339868631; 
 Wed, 29 Jul 2026 08:44:28 -0700 (PDT)
X-Received: by 2002:a05:6808:17a1:b0:490:315d:e0d5 with SMTP id
 5614622812f47-4ad5b9dbf94mr4808081b6e.16.1785339868058; 
 Wed, 29 Jul 2026 08:44:28 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6efc8631sm2018100b6e.14.2026.07.29.08.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:44:27 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:44:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <amof2Vbn_nTHR5H9@x1.local>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de> <amoHbVsgzkYclCt2@x1.local>
 <878q6toopr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878q6toopr.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 29, 2026 at 11:27:44AM -0300, Fabiano Rosas wrote:
> Hm, but isn't it better to have a global cap anyway? So we don't need
> every device code to change with similar checks.
> 
> > If we go this route, I'd rather merge Michael's version to support u64,
> > even if we don't need a u64 size.  But I really don't want to introduce yet
> > another VMS flag just for this... we'll have no real use if we have noticed
> > this problem when the vhost inflight patch was reviewed.  It will be a
> > uint32_t or int32_t already.  I just can't come up with some users need
> > size >2G.
> >
> 
> I agree with making all u64. I think we can actually remove all the
> extra VMS_VARRAY_* and VBUFFER_* flags and instead doa single type-check
> of "int <= 64bit". Give me a couple of hours and I will post an RFC.

I confess I don't yet get what is the global cap you mentioned.. but sure,
I'll wait and read the RFC first.

-- 
Peter Xu


