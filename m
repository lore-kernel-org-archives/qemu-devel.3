Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449BBC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNBx-0001aS-K4; Tue, 04 Feb 2025 12:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfNBv-0001a7-Oq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfNBu-0003hM-Ba
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738691909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=owgwA1AqBMYapk1PTsUUK3tzyPfXfho6a/nVAj1EryA=;
 b=SAkBfgKjRSb6NPVdq4kAHjYeHqinujoRKKG6mCGB9ltjd2z35jxft/CwzJP08kIQkY57bd
 T1kVJFXw2/OAdlB85MAnzvTy+nrxK2hQ9lTMerH7mEXbQFBtAvRdfteh1JTmUIF07vwOL4
 hJ9p214s0cfkJevvXPZya94FVX8PlDU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-vwjtAyTBP8ODPugBiMHwPQ-1; Tue, 04 Feb 2025 12:58:28 -0500
X-MC-Unique: vwjtAyTBP8ODPugBiMHwPQ-1
X-Mimecast-MFC-AGG-ID: vwjtAyTBP8ODPugBiMHwPQ
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e42d3a0638so6362076d6.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738691907; x=1739296707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owgwA1AqBMYapk1PTsUUK3tzyPfXfho6a/nVAj1EryA=;
 b=XGBDU4ZoA8di72YRPNdLLOYjbhDIoOSSxC7ubEoYs1pj6IpQ+tfjARBVDvuRQA1PP2
 dL7xUncp1fqLE66wzqxmmTOUEh3BoFQv/smAVCZq7K8EXHypuQbaAA3mVDJXtrmQW2zs
 QUxKvnVYoAI18vUK1QfzCi7wmKvRXjDzEJ+lTMq6Bmo7lEQ3DeQmhWC0Gvmv5becLeMF
 1TNkt/uBIkk1mSIHsBP6Dy6X+ASFDqdVtL935lciXAJtLSEC/S/1QRbQesztK+ILRE4J
 0wIRjpT4HReuKCPFAB3ngpE7TtQTYt/J+KYnLF23OhL96RidyvPbAPdNm/BkqCiHAwSH
 6oYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsviEjefxhrm6Jek62hKl+6MU+uArOg3WGJGN8O1nRCPUvTazR2bbIFVi14lC1JL02WjEolAUZZ8O7@nongnu.org
X-Gm-Message-State: AOJu0Yz4rkt0t4/B548StDiOZhjO4gtv9KIVJVR1rsKxQr/G06X2TsJo
 HeQtaUxfpyw5C6Rj08jRMOSvd9ei71DBggrJsoILpqK2UTjI5YJ8/+wzDhYiSant8u0Rf2fmBzf
 F8YtCEoBw/MVrLg3hiQeaNj1Q9+2qs23NGe53Hn/3+ChknSdYUZyX
X-Gm-Gg: ASbGncu9xlZlZG5oz3kWeoNhO+4xdc/DLjz1W86dr20BHqPQPMJVyHMp82fQePXRTQG
 9ZC8GOOB/vdnQqswyRhEi/8tXvkLxxNPYcpxSg1ZBpR8y2hHGQjTKJn8aS1uJ7vvYIyAt/ZN2Br
 Zt16Lj3W8CMggdN+mQboKLL4BEq71s9IowVoex7XjnM6SUqpm3s91uJytYrGPoXn0NWxp9yNihK
 i0DQneLF+w9hA7PUVVs3qXi0AsHbkvSaxRNecx500uHpzuNftExq8gjEkAswnX1a1Sxhhd6WfL0
 vNs5ZEoHBa8RS7tla8Z/hYf86Tdtgdbhj5tcIQPKK/0G8UAj
X-Received: by 2002:a05:6214:412:b0:6d8:a84b:b508 with SMTP id
 6a1803df08f44-6e243bb84e7mr355731816d6.12.1738691907532; 
 Tue, 04 Feb 2025 09:58:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsBbFLhsCyjIAwuNBepekrivhkbXxnck+KxUvJ5AOfxPYiO0WeaioI/at4/vOf7bsHdBhEqw==
X-Received: by 2002:a05:6214:412:b0:6d8:a84b:b508 with SMTP id
 6a1803df08f44-6e243bb84e7mr355731546d6.12.1738691907241; 
 Tue, 04 Feb 2025 09:58:27 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f3e17sm64619076d6.22.2025.02.04.09.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 09:58:26 -0800 (PST)
Date: Tue, 4 Feb 2025 12:58:25 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 6/6] hostmem: Handle remapping of RAM
Message-ID: <Z6JVQYDXI2h8Krph@x1.local>
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-7-william.roche@oracle.com>
 <7a899f00-833e-4472-abc5-b2b9173eb133@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a899f00-833e-4472-abc5-b2b9173eb133@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 04, 2025 at 06:50:17PM +0100, David Hildenbrand wrote:
> >       /*
> > @@ -595,6 +628,7 @@ static const TypeInfo host_memory_backend_info = {
> >       .instance_size = sizeof(HostMemoryBackend),
> >       .instance_init = host_memory_backend_init,
> >       .instance_post_init = host_memory_backend_post_init,
> > +    .instance_finalize = host_memory_backend_finalize,
> >       .interfaces = (InterfaceInfo[]) {
> >           { TYPE_USER_CREATABLE },
> >           { }
> > diff --git a/include/system/hostmem.h b/include/system/hostmem.h
> > index 5c21ca55c0..170849e8a4 100644
> > --- a/include/system/hostmem.h
> > +++ b/include/system/hostmem.h
> > @@ -83,6 +83,7 @@ struct HostMemoryBackend {
> >       HostMemPolicy policy;
> >       MemoryRegion mr;
> > +    RAMBlockNotifier ram_notifier;
> >   };
> 
> Thinking about Peters comment, it would be a nice improvement to have a
> single global memory-backend notifier that looks up the fitting memory
> backend, instead of having one per memory backend.

Yes, this could also avoid O(N**2).

> 
> A per-ramblock notifier might also be possible, but that's a bit
> harder/ackward to configure: e.g., the resize callback is passed to
> memory_region_init_resizeable_ram() right now.

Yes, that can be some fuss on code to be touched up.  We could avoid
passing that in when create the ramblock, instead we could allow ramblocks
to opt-in on hooks after ramblock created.  Maybe we could move resize()
out too like that.

Either way looks good.

-- 
Peter Xu


