Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2935C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvTB-0006zP-4K; Mon, 20 Jan 2025 12:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZvT9-0006zE-5f
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:21:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZvT7-0005eS-I5
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737393704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mL5KsaA+J8HX4kylTc2rxPJqKAL2zEPRr2dApSOjV78=;
 b=h/36/RceN6+DKT1oBwIuYG34vLzXv4T8zuVBkR3Ea6Qo3p6Y5ZMUyJjbHGgifztBnRy8Q8
 API8DBVNoth6JVU3ETwfppX2zEPRvd/wJ5BB4s2cT3yhR6IaBsu/SHZahgLvHrI/Bs4vHJ
 pGVCaJcxYKqSKM8Zor2g/RayxqTtqFo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-pgib3oZiMRGfALO17gD8KA-1; Mon, 20 Jan 2025 12:21:42 -0500
X-MC-Unique: pgib3oZiMRGfALO17gD8KA-1
X-Mimecast-MFC-AGG-ID: pgib3oZiMRGfALO17gD8KA
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6eabd51cfso763774985a.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 09:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737393702; x=1737998502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mL5KsaA+J8HX4kylTc2rxPJqKAL2zEPRr2dApSOjV78=;
 b=C5Nlem6JtHytJ+E7SAT6+qSZzSWdG4/TglItNCTzug0K7GZfRGN04g139zyOPXZZzX
 tXElnyFuw//Y7+vR39Bijq/XGPu8wpKiNypJBv/11qQ64HnKDX94Eh6GcoYI9lvEzSiX
 tJt5Imb9qID2AO+h/5kLlhYbpqgtoSgaWbGgOi4fXNpxgzoswvWcSbIEW/2a4QLPYGCL
 Ri/xZZc1LH24dJof/BgUHUkjBNmjcOzCIyd+RxvjJ2YlboLGIfk2HvqW6Eh8ZdL8vQPe
 VMfJ3WLttDqK7KZwxFOZNvC0THmymR+EZJIPnAeoX2PgdeHr2mBnQpKjUZyRmQDBQHES
 SHGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGNfoblNugFco2jHnwuSg99AU3AnfHXZplRVqTl5c9U84o6r9qEJI4j5vStkboiFzi9m4FqoCFGY0C@nongnu.org
X-Gm-Message-State: AOJu0YyS/paXABJF1xMeIn6Ahlg6iZXaGBsPV+NksGymG+R27hhzVELd
 bj7zSUQls/4Xm/pdRPl0dtIVpCGzbNjl1bTKWp3xpip9OE+GfNatKa5hWgGNa9+VQdjvZODab3K
 DW/HGwfe4TSmcUQj5hnFhiMx+jiNIHq1inxf2nV18vHZ/6fJxn1BR
X-Gm-Gg: ASbGncswazYiOduVoBfjFDGzytE1Ekl+5pyiqTPOcTinZ8xuPla40j7XnLpcS2Ys/1r
 adPVjcbTTTrDGNvGUOyywYQlzNmlfZEWy7WGgeL1B8C5/tsCr80nQJLUi9dev7BVl+I2zcVkuSR
 izSd1x2ew/T3tLE0NKBhPWRDChCDewn+UeUQ+DyOZX/AyqHFIBSRvq7QPt7sff/oKsYkF/H62e/
 ZFG7HqixeQzrimafNBJ30n6d9YrqL54J2LcEPRhfO4Ee5PWY3CrdKmpwZAviBRI5RBrkg5Vnm8A
 Bt/DIvaMX3MOgszBy7qFk5Pi2L/XrNU=
X-Received: by 2002:a05:620a:2985:b0:7b6:dc1f:b98c with SMTP id
 af79cd13be357-7be63287f05mr2040737285a.52.1737393702399; 
 Mon, 20 Jan 2025 09:21:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFNnJpd2iFAed03FBPaakMpDwUqsmMGvP5/UDmNrC09ir6dHFykZn418+CNUIU7gSz32XVIQ==
X-Received: by 2002:a05:620a:2985:b0:7b6:dc1f:b98c with SMTP id
 af79cd13be357-7be63287f05mr2040735185a.52.1737393702117; 
 Mon, 20 Jan 2025 09:21:42 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be61486925sm462496585a.54.2025.01.20.09.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 09:21:41 -0800 (PST)
Date: Mon, 20 Jan 2025 12:21:38 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z46GIsAcXJTPQ8yN@x1n>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
 <c1723a70-68d8-4211-85f1-d4538ef2d7f7@amd.com>
 <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

On Mon, Jan 20, 2025 at 11:48:39AM +0100, David Hildenbrand wrote:
> Sorry, I was traveling end of last week. I wrote a mail on the train and
> apparently it was swallowed somehow ...
> 
> > > Not sure that's the right place. Isn't it the (cc) machine that controls
> > > the state?
> > 
> > KVM does, via MemoryRegion->RAMBlock->guest_memfd.
> 
> Right; I consider KVM part of the machine.
> 
> 
> > 
> > > It's not really the memory backend, that's just the memory provider.
> > 
> > Sorry but is not "providing memory" the purpose of "memory backend"? :)
> 
> Hehe, what I wanted to say is that a memory backend is just something to
> create a RAMBlock. There are different ways to create a RAMBlock, even
> guest_memfd ones.
> 
> guest_memfd is stored per RAMBlock. I assume the state should be stored per
> RAMBlock as well, maybe as part of a "guest_memfd state" thing.
> 
> Now, the question is, who is the manager?
> 
> 1) The machine. KVM requests the machine to perform the transition, and the
> machine takes care of updating the guest_memfd state and notifying any
> listeners.
> 
> 2) The RAMBlock. Then we need some other Object to trigger that. Maybe
> RAMBlock would have to become an object, or we allocate separate objects.
> 
> I'm leaning towards 1), but I might be missing something.

A pure question: how do we process the bios gmemfds?  I assume they're
shared when VM starts if QEMU needs to load the bios into it, but are they
always shared, or can they be converted to private later?

I wonder if it's possible (now, or in the future so it can be >2 fds) that
a VM can contain multiple guest_memfds, meanwhile they request different
security levels. Then it could be more future proof that such idea be
managed per-fd / per-ramblock / .. rather than per-VM. For example, always
shared gmemfds can avoid the manager but be treated like normal memories,
while some gmemfds can still be confidential to install the manager.

But I'd confess this is pretty much whild guesses as of now.

Thanks,

-- 
Peter Xu


