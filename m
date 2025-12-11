Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D3CD41D66
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjKS-0003M9-6h; Thu, 11 Dec 2025 11:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTjKJ-0003LW-4E
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:15:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTjKH-0007xx-7i
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765469731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OQ5pVZ6PfIRAN9O6i28Gb8fyK3YyoXo0nVZkQXQyzuE=;
 b=Qmg+KkJSqn5P5RgqMUKbi4sV/+NDzxiyKHCKDSa7ndVBgtT6cw7DYACJnlfFyQRyZGf64R
 TBSxIDWv33ckRP+TuWNgc5DG8rbAwJrvN/WhgpOhGrYOJuXo/+PlP7l/n8dXdmRhB4rJpb
 3rM7AySnJRYujmC36GBL9UmZraRw1Uk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-XB31zk9CO82jI5-LtVuL0w-1; Thu, 11 Dec 2025 11:15:30 -0500
X-MC-Unique: XB31zk9CO82jI5-LtVuL0w-1
X-Mimecast-MFC-AGG-ID: XB31zk9CO82jI5-LtVuL0w_1765469730
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b5c811d951so53535285a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765469730; x=1766074530; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OQ5pVZ6PfIRAN9O6i28Gb8fyK3YyoXo0nVZkQXQyzuE=;
 b=VNRtFaEF6pF5Z9PFtJjPegbCeXMCugabbiCYZPZSAVmw0HWbhU108Ql9orHDwZgAdx
 Yuedc49+N8kxXNoIcX2LSrsOAPY5Z3Us3GmJDmpz9M7gEipQ3KHGp5xLmSGabwAkb0du
 pCANX/ni9RD206hyi0ooAkegvT3RaCxPyA5f/kTsQ4QEYZhNJyGpTm1lRzg0N5lRpYDS
 lB7hFSfrw2ajGe8y2ztQ8F0vciUP882HTL/lx8mwWdCBReKFEmcnW95VeKmPE9uLOT2b
 iu997JL9AhT/gV4O23i3okSy9xKg4P/PXbQFqcFVQLGK/sBMYCYAEo0yYEAjSLY90tzR
 WzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765469730; x=1766074530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQ5pVZ6PfIRAN9O6i28Gb8fyK3YyoXo0nVZkQXQyzuE=;
 b=Dya2LHrZubaErgvI5yBJ4XDz3jSP7Jyk96zCEe71Liy2WxhJYLuAcrIURoUqUgRKuv
 BDU6NcLDpKIapZp215gKT92BNiiW3F5mWq0Fhe8b8Mjf/oUBSWjBYLOyYdqjgkKtLtHX
 H/Fshcc6aZMNU37TUc3qMb9TvNG4+uztWDGtNuWtImSwL01BSYh0VcTFpX4mEZAeyYsg
 DmjYQW9U4MdDUEaRv7KG8o++x0e8aYPZ5+SlzSdhmVu5EeKhSjHcY06ALrBf19c9bAZA
 /TawDbHhoFXzYsYfzx0MUtt8p4QdfdzrzAOMH9wBEdd5CdGR5j36Ok7Rn5qNw6G2Xi+9
 eL/A==
X-Gm-Message-State: AOJu0YyVk35pdma7GG6YrRuXzJO3JCH01iTl/LAJSwGShqSfae23SDH2
 +Uk3qm1qIohTHwNDUTjav/qcjSFs5Ogn7lWzXSoVEvfOItNdKHmlHNOtvFz5l5XBmHEDUzmvCMR
 KhIE/qy+7CBeZgVt60x2UZ7H7gay9V9q6KTfJHP+rP1w/1+19DZR7ZI3Y
X-Gm-Gg: AY/fxX7bEOvdZ6os23W6iWOz2VwaYo8JSHgxxAV2qrPm+foMqUOKKgH+72ianP9nKcr
 HQZodLeWLvdkfg+KM3ti2GmXWfxs1kmDd/bnN0Erb7we6Tw630kMo6MHKdUr3OYe67lPHVd/Vc2
 QuEh8kIF0cx6d/iJbt5BS7ag0nJoUrJT9f5rX9YlcqG0JoFPDg1YapmZpBD7Tz/kouFr+Zfc+a1
 6NMcxJPQnN9FJDH34k+JJsrV38QzJOv9gGRuR1B6bRB8Da+TQfHHti58Iln/mKEhrkdV4Q4pZlA
 e0GJYFD/Jgcue3AHhanV4eMvbZz4JUC+PAiF97uEKrMzNj2dU4zWxT14lpniEVii966oaNgBG9o
 aOJ4=
X-Received: by 2002:a05:620a:179e:b0:8b9:d2cc:cded with SMTP id
 af79cd13be357-8ba3a349df1mr1045832885a.52.1765469729544; 
 Thu, 11 Dec 2025 08:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1tVctTF9ox62K8IdA4ld782fckgclJLy/jRCx9JiB6nPfItp3Y6CmgpiP2MhzIVzhbAYFqA==
X-Received: by 2002:a05:620a:179e:b0:8b9:d2cc:cded with SMTP id
 af79cd13be357-8ba3a349df1mr1045823685a.52.1765469728843; 
 Thu, 11 Dec 2025 08:15:28 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab5787d5fsm248101785a.24.2025.12.11.08.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:15:28 -0800 (PST)
Date: Thu, 11 Dec 2025 11:15:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 6/9] hostmem: Rename guest_memfd to guest_memfd_private
Message-ID: <aTruHymUNQKcPzPu@x1.local>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-7-peterx@redhat.com>
 <4305e09e-60e1-4ba1-b8ac-d4e562cc5455@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4305e09e-60e1-4ba1-b8ac-d4e562cc5455@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Dec 11, 2025 at 03:16:52PM +0800, Xiaoyao Li wrote:
> On 11/20/2025 1:29 AM, Peter Xu wrote:
> > Rename the HostMemoryBackend.guest_memfd field to reflect what it really
> > means, on whether it needs guest_memfd to back its private portion of
> > mapping.  This will help on clearance when we introduce in-place
> > guest_memfd for hostmem.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> <...>
> 
> > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > index 35734d6f4d..70450733db 100644
> > --- a/backends/hostmem.c
> > +++ b/backends/hostmem.c
> > @@ -288,7 +288,7 @@ static void host_memory_backend_init(Object *obj)
> >       /* TODO: convert access to globals to compat properties */
> >       backend->merge = machine_mem_merge(machine);
> >       backend->dump = machine_dump_guest_core(machine);
> > -    backend->guest_memfd = machine_require_guest_memfd(machine);
> > +    backend->guest_memfd_private = machine_require_guest_memfd(machine);
> 
> btw, how about a separate patch to rename
> 
> machine_require_guest_memfd() to machine_require_guest_memfd_private()?
> 
> and another patch to rename memory_region_init_ram_guest_memfd()?

Sounds all reasonable, will do.

Thanks,

-- 
Peter Xu


