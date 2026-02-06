Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD66EE20B5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 16:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voOkp-0004Ri-9p; Fri, 06 Feb 2026 11:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1voOkm-0004R6-Vm
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 11:32:21 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1voOkg-0003Of-HS
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 11:32:17 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-89545bd3324so4460426d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1770395532; x=1771000332; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zudsOAj0AfzZbqg1Lmjm4tJJgjoNQsiYFBqGBNU0cc8=;
 b=gy7qmSylzYTlP3/snLttnDX1vgJtYR0r5zdNIbDvv7y7AQl+krYNtZBgLJJI7TLnTs
 OMl31oTB4G6q6IKSVZaKo6QUIlOQWK583Tgw1A4RtAQbbuxi5l6o9DWldMvM7uiCYVSd
 gSydiKKAQyDMD+AfbhD1ksFbf0l7n+NDo1AhDuPlCplHQDq86fQ276VY6UbJ9wlhndtc
 7kNSOItA2IybO5FbE1UYRsbAxHQWBQ9edEQzaPCp8krHZlOrtmVl13EeHhSAkFINOE7S
 l7nY9GEDM09tB3HVNdH0vI0WUNS4QwAF2yLc2A/i2w2Wxtw6Vl52yYyeXWUNsmnpiNay
 EmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770395532; x=1771000332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zudsOAj0AfzZbqg1Lmjm4tJJgjoNQsiYFBqGBNU0cc8=;
 b=pgoWqoQ8cqDY1mKMwTH4BVA8id0vCrZR2URMrjWoGAmUE5qJx5CgeZGFc/VmGNwelf
 OpqDGmI+gqjlQr9RDsesz+VTjPnkth/VvWJQ5nr+MhrdG4hdJpr7DGpC1/2XVH9qb2Sg
 3RLz7jxmlOt8Bv14WwvzUjZsteOxkbwNgO6dJmy4xL2opHJ25IDrCx5Pj7O3W1wJsu0r
 Pz1nvXDC2wgpjQPYProNbU2LsPsAW1jUUoZB+F32huA4AYerXH5L6bNHykMG8XjVmU4b
 LzsyTBmIDtrn6v9L7oQ+cfe8Srcl2BdfwQwrSbS306XNkbwPXM1vo/fvtL4r6kKtbHBy
 pjAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo/twcM8gVDZGZnswuk30Ujgr+rnYSJLDrX6tfINVNkUQ/z/uQVp1UIZrh4L0xmeu1az1NTaeYB35S@nongnu.org
X-Gm-Message-State: AOJu0Yxiak1J3MOw7Cpk0F5rqpThHZfGLo140PAld6bgtF28T/g5h9i+
 vs5dP/ZUWDFcuTMIDY4E14MY5baSLnhJVTfZF0PF+QBwWdP9Rs4gQUa08t8l/czemFU=
X-Gm-Gg: AZuq6aLELH3khPRNM3osPzUMu+JQv2VAEc3JszXVdasYNgT2vRoKFbtMI6bm0FFgsss
 Zv7I1E8lLnSQopBtrs4Q/JTbPmrWZDGkv/Ae/yH+PJ3EC16u6ZcCruQP3vLMn6cWrUC/Ixh4qzl
 U1uGbywaaDBnJXjX/WStnqTt/K21b/e78XUf9zL6fkJQwAe2EIJ5dEjPiizEfB5GuwcAAyvjLVe
 2kEGLbsgBOP0K0gryfE1WNmNzxJFKHftyICtd6FFrFAeGD4eYmlZ2LRa9seMWR3Kqb0J7PkH7kn
 dNWYxqLGzQLNlsawaNdAu1cS2WhIMSBLHNRjL61++OMdCaycWXh4BWHWRUOQGjewnSKfBkBQRbZ
 1DdfMrEQbeTSy5akgdyNDD0LvjSuMM/q/P9rwNaGh0y3l8S9mS7DJlGTHhV/C6xAYixw3S1Z2+X
 E+jFIQXjEYIYB+Qm+wLEbgn2PUef4PczmcdIHENBoDCun9/hCdKN9TV8fOszlVZ/SMk4e0NA==
X-Received: by 2002:a05:6214:2522:b0:882:4c83:af43 with SMTP id
 6a1803df08f44-8953c86f554mr44159066d6.42.1770395532119; 
 Fri, 06 Feb 2026 08:32:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953bf37b9asm21134616d6.9.2026.02.06.08.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 08:32:11 -0800 (PST)
Date: Fri, 6 Feb 2026 11:32:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Cui Chao <cuichao1753@phytium.com.cn>, dan.j.williams@intel.com,
 Mike Rapoport <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, qemu-devel@nongnu.org,
 "David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <aYYXif7IPXnXZPnn@gourry-fedora-PF4VCD3F>
References: <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
 <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
 <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
 <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
 <20260206110305.00001fbb@huawei.com>
 <aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
 <20260206150941.000028ae@huawei.com>
 <aYYOZ1TK5dpX_h_Q@gourry-fedora-PF4VCD3F>
 <20260206162644.000050fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206162644.000050fe@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf34.google.com
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

On Fri, Feb 06, 2026 at 04:26:44PM +0000, Jonathan Cameron wrote:
> > 
> > This should fall out cleanly.
> > 
> > The additional nodes won't be associated with anything, but could be
> > used for hotplug - I imagine.
> > 
> 
> That aligns with what I was thinking as a first solution to allowing this
> to be more dynamic.   We can get clever later if this doesn't prove sufficient.
> 

I can get this out pretty quickly, hopefully sometime next week.

I had a long talk with Dan about this topic previously, and I'm not sure
how we get more dynamic than this to be honest.  nr_possible_nodes is
*definitely* expected to be immutable after __init all over the kernel,
it's used to allocate a memory.

Surface area is very large here.

~Gregory

