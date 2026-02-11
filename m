Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AA1E9E310
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 14:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqB6H-0002A6-7T; Wed, 11 Feb 2026 09:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vqB6F-00029y-OP
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:21:51 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vqB6E-00012o-1B
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:21:51 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-5014e1312c6so13097061cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1770819708; x=1771424508; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dEL3esNNatCbr/bkbGQf1MBlSa4lnjGnRCnp5HwHRC4=;
 b=JsEFS2qp3opM7Fb3ZUAVG10v/I9Y4ZiOTlWqM5+7yU9TGteOTYxl+3i/eCVNXLiYzR
 04mAiLd+R6rXPZ/By+ZihQnefpZJA0Xk+hG7sUA8CDF//2cZFEE/+Ts5dsPgxRFWFk1Y
 z8V6mOJOfJffx+IKixngN6jIoBlvhwkZzMyOzlrbTqdAgwHG6Ieqh0z0aKahERwQg9hy
 4cXhzJvmdc6mECMNb8xykLojcON8+cwUAf9lWud8MZnxzjmDU+9M5t9mXWFWuGS5j5mG
 zXA+2XlETfvztMKbLtndWRltAds+XTfWcYpHFONVI35T24A4R+NRedhKk7o2NkSSvhAY
 bgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770819708; x=1771424508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEL3esNNatCbr/bkbGQf1MBlSa4lnjGnRCnp5HwHRC4=;
 b=P86PWvBS0hPtuMarnRnRrmuz9K6QAkl4FoEbzThW+xhR1DJbVgMwIrI2cXUonreSHz
 S+Pb6xqmDyeFiP56NR7o81WldEKShbk7teHYkjvmu6cdep/5jie36SsDIRikB3AVroNp
 CkEB3Tm3QwO+48uI1uP2h02lvAd0EFJS2Uxh2D/IxR7WOyTDUl0K1PrgxVXqe0t5Zqqw
 V/zczBtMILW2R2xosKjLP59HRRd8cVa4g6y76Cz1LcRuQs+voQkxMYZEywC6a7apIDeQ
 dqkvkJdvSYJIz6WEWNV3wx8Zk7PbIAYJv89ropDiEUTl8DeN3W8z2s+68hIVDtFs31y4
 e80w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFXpky1YW6PjVYvb2KDBlAC7A4SW4lGokf/UN0OWjQrB7oCcyU8qrpgxzh8JfUrKiefuQlyGrANg6C@nongnu.org
X-Gm-Message-State: AOJu0Yy00Q6hmVcv61i9vAzFuUr79AC2De5pnjiRyD8VmgT0FDzfIldx
 rhtd7bN4e7iSX7JszxySPqWd2rZvjHRuETKuuDZcqt4tov1ksfzdlWM24Lw3bIAfpeNEycH3u9b
 TcEW7
X-Gm-Gg: AZuq6aJ9ZLBeZIYfETlSqn4vvIS+99gQxI/vKHP+f1VI5ZRfq4MQ7gIm/2TgkRhdYXK
 aJQtN0cCTBM18gDkgIfnCrRk7iY/6LYEa94Rmwu7tL+yWPxwvhVkmPQnr8PJ1HFQsbue7c8T6ru
 3sh4y1o8As5+8rnu/apZVC1miSl446xO/IHZ1f4Ib9StLs81jmPRByYnAk/bvonjSASaP/hCxws
 pB3q2ySFbX2aRBnHkDqy07zva8NL3YbOjkpGPRZtxoOmk0lBX53OlKtJkOMUvVkC/p+RZAoJuAf
 j7M8Z2iV/XXU3zKAQYISJgekzxL2MGfFpQjVzBTQOPyVuPGNuJAuDRINxz8Od9TUeEeci/Q7UIi
 TGWOhbhfKz6jS4Lkm4r7LUd6oSoZUmaJ7ZrmwSqg9cdx70kfYj6pKsEdRLVIY0ko9dqlC8BqGsX
 mS+XJzkBzybQoZaLa6t5g6j7nx7Nt7viwr3iMlawFQE7ZD75p1DAYz8WWubN27ieMISAmGsapcb
 0GdF+42Ww==
X-Received: by 2002:a05:622a:646:b0:502:6ed5:7b04 with SMTP id
 d75a77b69052e-50639a199b4mr244208631cf.74.1770819707999; 
 Wed, 11 Feb 2026 06:21:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506847d7bdesm14877131cf.6.2026.02.11.06.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 06:21:47 -0800 (PST)
Date: Wed, 11 Feb 2026 09:21:45 -0500
From: Gregory Price <gourry@gourry.net>
To: Cui Chao <cuichao1753@phytium.com.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mike Rapoport <rppt@kernel.org>,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>, dan.j.williams@intel.com,
 Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
 David Hildenbrand <david@kernel.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <aYyQeSzSjBaUjMCJ@gourry-fedora-PF4VCD3F>
References: <20260211103320.2064211-1-cuichao1753@phytium.com.cn>
 <20260211103320.2064211-2-cuichao1753@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211103320.2064211-2-cuichao1753@phytium.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Feb 11, 2026 at 06:33:20PM +0800, Cui Chao wrote:
> In some physical memory layout designs, the address space of CFMW (CXL
> Fixed Memory Window) resides between multiple segments of system memory
> belonging to the same NUMA node. In numa_cleanup_meminfo, these multiple
> segments of system memory are merged into a larger numa_memblk. When
> identifying which NUMA node the CFMW belongs to, it may be incorrectly
> assigned to the NUMA node of the merged system memory.
> 
> When a CXL RAM region is created in userspace, the memory capacity of
> the newly created region is not added to the CFMW-dedicated NUMA node.
> Instead, it is accumulated into an existing NUMA node (e.g., NUMA0
> containing RAM). This makes it impossible to clearly distinguish
> between the two types of memory, which may affect memory-tiering
> applications.
> 
> Example memory layout:
> 
> Physical address space:
>     0x00000000 - 0x1FFFFFFF  System RAM (node0)
>     0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
>     0x40000000 - 0x5FFFFFFF  System RAM (node0)
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> After numa_cleanup_meminfo, the two node0 segments are merged into one:
>     0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the range
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0.
> 
> To address this scenario, accurately identifying the correct NUMA node
> can be achieved by checking whether the region belongs to both
> numa_meminfo and numa_reserved_meminfo.
> 

Changelog comments after this are a bit much but other than that

> 
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


