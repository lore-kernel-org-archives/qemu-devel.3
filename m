Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9C7C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpqA-0004C0-VE; Fri, 01 Aug 2025 09:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhpgH-0003Yq-56
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhpgD-0006HU-Kl
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754054410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H6/Z6CZFEvmF8G2bwq4r0ETXIhzOwodw5kxABTxhT9Q=;
 b=U7mDz6663JHhMatg4/pvMx27LC+M9f/j28C5AC4wF0v/ce7Di7nYKRw+c+EhoUlQr/lGeO
 9IXJDeTchN2pWm1RRl8dDFQL70M+TIGgMgEoObGlQei0wzkacVKtkE56m/neyC0OvNBnX6
 ItmyZnkO5V0d/6+iB/HcoIwLxsRJedI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-qfOOP1CnOgCSyaD-C5hTIA-1; Fri, 01 Aug 2025 09:20:06 -0400
X-MC-Unique: qfOOP1CnOgCSyaD-C5hTIA-1
X-Mimecast-MFC-AGG-ID: qfOOP1CnOgCSyaD-C5hTIA_1754054406
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e03ac1bf79so66235785a.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754054405; x=1754659205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6/Z6CZFEvmF8G2bwq4r0ETXIhzOwodw5kxABTxhT9Q=;
 b=K24f3MzfDkzwdg4vAUJQzOeDHpFw57/UtnDgSFEdFWhsd64TvokZGIs1Rd1wLcFEU3
 oRrf3rpEKKMchOs3P61of0H2F4gN2udzEU9Fy4BljENupMu4GfIdvdQk6julHJz6vw39
 nX4v+cut2jhIaS8Hn35CK7p2oRvsUNn6hrh1o3LqcnpZzaP6F5PGvmF64khn3f/aqSdE
 7X+j95UYBHf60BTaF0y2bDQnsNbLoXASCcLXOEgQNmGvpfpRrJvUHNucx72I9cf1t4/u
 hFSVKNf+uhsx4cwSt61geLQnVTfkFpg+Pm93zbiPE9H85XDTb80SWkEV6zHPjYfJ+TBt
 XPzQ==
X-Gm-Message-State: AOJu0YxRisAatP6GXm5kGHIc/HjpvronZJ+HkjCPOPSsjw7745eV+qHp
 5QELLlUgta7rPs31K5ev47B9W0P/1y0RNNuMHtFIM3ama5IiZKqW9821deSZ/PtOxXuL0UU4xHB
 e3OPFBk9bg2B22nfeUlnxYTOv1hoZHZLKFF3A5erJ/uXW+ab8ovg3Q9/2
X-Gm-Gg: ASbGncsYP/RFXIcUscebgK264lMwcba7BPA6BOjCeVZICOclJzWe/QViJAE6/Y0zKFu
 FiASEGW1iBv0LVzlGVpuSq/FSgzs4ZEHFOLntgmR1l+xecdNylZQVAUluEV+204iLLKYlN6TmBB
 4s6RqZj54GK3E+12Mul2UX470dibPa4299Gp03shXW+HMAhyptxWcUjjsE/XUOiczTIpwscYgm2
 prn2lKdoO9j7LquTuhf8Esl9XD8fRxvsefVg/356SLthCRGaruqd8Fml5i0VyhAbB5CJ8F5iUcI
 E9KFZ9PoDsOG9TKtmSGZ6ie2KpOJSa0h
X-Received: by 2002:a05:620a:7087:b0:7e6:8751:96c3 with SMTP id
 af79cd13be357-7e68751a21fmr573336685a.35.1754054404887; 
 Fri, 01 Aug 2025 06:20:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHFecYoN3dva1gnHhfGpVlTbJcbMy54u96Ehe6nyKFsgp1e3VAA497E1zleAgk+h6bdpF5xA==
X-Received: by 2002:a05:620a:7087:b0:7e6:8751:96c3 with SMTP id
 af79cd13be357-7e68751a21fmr573332485a.35.1754054404362; 
 Fri, 01 Aug 2025 06:20:04 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f5943easm207665385a.10.2025.08.01.06.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:20:03 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:19:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 1/6] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <aIy--MdAUfMwSL6g@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-2-imammedo@redhat.com>
 <aIqTCITI84BNtWnp@x1.local> <20250801144226.3063e700@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801144226.3063e700@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Aug 01, 2025 at 02:42:26PM +0200, Igor Mammedov wrote:
> On Wed, 30 Jul 2025 17:47:52 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Jul 30, 2025 at 02:39:29PM +0200, Igor Mammedov wrote:
> > > diff --git a/system/memory.c b/system/memory.c
> > > index 5646547940..9a5a262112 100644
> > > --- a/system/memory.c
> > > +++ b/system/memory.c
> > > @@ -2546,6 +2546,12 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
> > >      }
> > >  }
> > >  
> > > +void memory_region_enable_lockless_io(MemoryRegion *mr)
> > > +{
> > > +    mr->lockless_io = true;
> 
>     /*                                                                                                                                       
>      * reentrancy_guard has per device scope, that when enabled                                                                              
>      * will effectively prevent concurrent access to device's IO                                                                             
>      * MemoryRegion(s) by not calling accessor callback.                                                                                     
>      *                                                                                                                                       
>      * Turn it off for lock-less IO enabled devices, to allow                                                                                
>      * concurrent IO.                                                                                                                        
>      * TODO: remove this when reentrancy_guard becomes per transaction.          
>      */  
> 
> would something like this be sufficient?

Looks good to me, thanks!

-- 
Peter Xu


