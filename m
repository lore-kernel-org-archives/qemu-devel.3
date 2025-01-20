Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9712EC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyg9-0004Cy-Hm; Mon, 20 Jan 2025 15:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZyfF-0003YT-GR
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZyfD-0004VB-3u
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737405982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3TVfm1hWW+SQ2qvpmt/ExAOGENiWUkkTKRie7+29lk=;
 b=MAl2SoDwdiCTCmrkAkJRIBzjKiZDEIHI+zuwYY7rDNkqmGqPYxK9DYeL7bMzpt73KKk1F1
 hXxDgVPqBTyE67/xlRh2B+i+n+5rZh/fr30rLmg2mOfSwEyR1XS6+HhrqPrT7NnKNzda46
 L9PgO7IWwM8MNorD4alP6QTfXWxAPaE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-XxR1HyNwNnihjxoAHxxVNQ-1; Mon, 20 Jan 2025 15:46:19 -0500
X-MC-Unique: XxR1HyNwNnihjxoAHxxVNQ-1
X-Mimecast-MFC-AGG-ID: XxR1HyNwNnihjxoAHxxVNQ
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b93c7ffaeeso849017785a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405978; x=1738010778;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3TVfm1hWW+SQ2qvpmt/ExAOGENiWUkkTKRie7+29lk=;
 b=MMV/JUn6bF/td2ZTdkHB4S5o/YQjdERm3dJuTY6VQuQKt/uZqAedx74bM63z2OgvB7
 nFOCupP2j+UIrTeO5g4coset0DPfOxX20i4gTIjWwfr76mVTaF/1MGI+6f0NKrPxaThV
 8F5iEtJUDurpRRI49qFGBldX0o3qOgaBRGTJQy4y4nb4bEfm1Jta1XlF287dLqlNQA6v
 z3nFCLkDaf3hXRSQHv3oQ3V4oRPqhUi0hT/MkSzm4NgKF66tKxGqy6HVmNVPaPZDQL5R
 fdha0Qvg4Ms8Jni5CkmS/+xESi+hpL8E54yZGHeQKDgDWXqKubr60tLxgum13CWzULlP
 R3cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/xxIUzCq8KW5bvwibjOqnFPUWvtCr/irv0I4IermEBkVzA+s5snX1nA3UT/hGOfjL7S86+62PvKiI@nongnu.org
X-Gm-Message-State: AOJu0YyBpo+Lsm2QQWG/T6pYzuRsopMDXpmy8t2JJHI98p/Eer//Ykhp
 IMsdyBgTM64whjCEreIxCTkbM7Foutgdt8f0XL5k1Smu6s3QGoK/Xazuw3mJlc8ZLci5y0O6wxJ
 MChDhC+cuT7IxWTEE3ynsfYLj38SeQqny9HNNtk/KGkVV+l6LfiER
X-Gm-Gg: ASbGnctSh4Cv+Oci/u7CDXkCTBk978oqHml/aS4rzCFTgmodqTsBnUYEp2tMZ8qdG7I
 E2mygK9JtGnhRy6vsjPkcq/90l9KYkdqSMfHNLNvHwhGWx/mjvxUDvt5rQVQyr+JAvtiuA3H774
 Wdk9wS9+ryT5gDfpObD7wg7Vdf8oafrhCrIbOW9F4KfevmpfmgTThGZ6JTOOanBXQlpFV9D0Pf0
 HF0N3GgGpnEdLmkBv46FmArOXPkAbwO6AKaHqlytYQyF6dYJvAiQW0JLMmwdJpjCMIsHXrEGY3r
 o6EOfbe0Mu/uXgwEk4hv5wD/Ws9TESU=
X-Received: by 2002:a05:620a:410e:b0:7b8:5511:f72d with SMTP id
 af79cd13be357-7be523e28e0mr3531522485a.17.1737405978532; 
 Mon, 20 Jan 2025 12:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDCqhLZKUng+MCpmPy4o7DYVS+UaJHWrKhBKL4yg61rr9grwttwSS0WeRORTYCHwN3m8s3MA==
X-Received: by 2002:a05:620a:410e:b0:7b8:5511:f72d with SMTP id
 af79cd13be357-7be523e28e0mr3531520385a.17.1737405978257; 
 Mon, 20 Jan 2025 12:46:18 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d9af2sm482989285a.77.2025.01.20.12.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:46:17 -0800 (PST)
Date: Mon, 20 Jan 2025 15:46:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z462F1Dwm6cUdCcy@x1n>
References: <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <219a4a7a-7c96-4746-9aba-ed06a1a00f3e@amd.com>
 <58b96b74-bf9c-45d3-8c2e-459ec2206fc8@intel.com>
 <8c8e024d-03dc-4201-8038-9e9e60467fad@amd.com>
 <ca9bc239-d59b-4c53-9f14-aa212d543db9@intel.com>
 <4d22d3ce-a5a1-49f2-a578-8e0fe7d26893@amd.com>
 <2b799426-deaa-4644-aa17-6ef31899113b@intel.com>
 <2400268e-d26a-4933-80df-cfe44b38ae40@amd.com>
 <590432e1-4a26-4ae8-822f-ccfbac352e6b@intel.com>
 <2b2730f3-6e1a-4def-b126-078cf6249759@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b2730f3-6e1a-4def-b126-078cf6249759@amd.com>
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

On Mon, Jan 20, 2025 at 09:22:50PM +1100, Alexey Kardashevskiy wrote:
> > It is still uncertain how to implement the private MMIO. Our assumption
> > is the private MMIO would also create a memory region with
> > guest_memfd-like backend. Its mr->ram is true and should be managed by
> > RamdDiscardManager which can skip doing DMA_MAP in VFIO's region_add
> > listener.
> 
> My current working approach is to leave it as is in QEMU and VFIO.

Agreed.  Setting ram=true to even private MMIO sounds hackish, at least
currently QEMU heavily rely on that flag for any possible direct accesses.
E.g., in memory_access_is_direct().

-- 
Peter Xu


