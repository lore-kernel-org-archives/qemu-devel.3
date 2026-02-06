Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFD5EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 15:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voO96-0007pm-BB; Fri, 06 Feb 2026 10:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1voO92-0007pX-Ng
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:53:21 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1voO8x-0002Uf-OP
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:53:19 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8c7120353f1so84970685a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1770393194; x=1770997994; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7podOaUCjU/O3I21k18RXk2UZLq1mKBY8Ro47wlihIQ=;
 b=UFOzuINtEpzvbaatcXrQm+wRU2x6gqqprd/tMvj1c7Vgty2roKc8ub0neL85kOdJvd
 eD5eciLttDtVdSRyRLTMS+z02DO65meeT/WCFED4gMRhxWMQ3TnCcxpKl8wyOQ81EbzJ
 NxOZTi0tjU3hpObicSjTVpiCg5MQoDorCHkzXGpNRZPPIFCA1oCcrsr+RetcV66yDw2x
 Oq3Ite0u7ARUr1M7pjPQiRpx8pjUUoQ3+3zJYgP1WnXo8u/UtxYXbXQNt76jgCJT7g8a
 1ou6YwkHkEhCtrEBo03UE59ZTdO6nPGjQ+b/n7GpAjJ6fxYsq5zTLvYoqH0ooXx8E7cm
 9FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770393194; x=1770997994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7podOaUCjU/O3I21k18RXk2UZLq1mKBY8Ro47wlihIQ=;
 b=ESdGC1PK9uNCSqgQ+Eta7vbUDmLa5vztEiLmHbE4HN8g+xHxOgTDsME5b80Dx3/LWz
 E4BGx82pNyb3JfXpy0iK28Yj+ddYCH1g+FEnFre422KxL+0qlBIExgAvx+s6MLQA/7Fh
 3mlPpTskuhP9a5NbXqgcVt3UZCqOEcDo15SOdGiudxnP4VUkjp1q+h+lVWh+w0/SqVxM
 J3ZVd0EBOKNo6yt1guJwMmVcGMJqdTeqAul22M+rmsT55XRNgGi3OMqWrT4cqgWuzX+k
 h83JEyfkP99lyC9pJwHRLlGWVrzc5nw+VlYJ7tKPRb/UUwVCEIobgRV60BhXsa6JEUIv
 LLkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8wcobZHPThJ8YkffOpEjtfC1442IAmV+2q2qcN/qRKngMqeocC8W1zoatipfknbR++mywxgmnRhC1@nongnu.org
X-Gm-Message-State: AOJu0YwziK1k1+BU4jfCg9XKaoX0k+S+/nTWpRbTsanNPXwsgKcnT6j7
 bOQmkqrc2DGrrmDzT14TLoHSo9GDwCkTA/zEyaURM7chIa+4UeW6uCqePHI8cqHuUCA=
X-Gm-Gg: AZuq6aJMsAnAsyxpPQiqY6KWmvjiufXpRoPDZRn5ZOnD5/LG64ShmqO/FFinXJJIS3E
 NZks0KPzI1cJ1pNIhsFG8nZQwBoO8Moc+2vcrST+KwKyCsL7Dp/AeFKeVry1+ayoYdZw6yi58cN
 VWe9zjc1FOEOElcXYRI8qmRA7qqo5qT/8TMXKQqNHyYnf1Ja0u6sVbVfah5HCMeifkMHX37kNcv
 wC5A8D2QYoJ/d/f6SJhTbP1HhJK3bDMjecEDIgBu4Z9GxR6wQAY6NPzf52eZC0DrJ1zlzeKh3Np
 cl88ffAs0HkmiAp6HsVPtLbqgurdHDP3Dqr1Z/z2oV89R2wnIzw+1moHN4OW6vRZ39uGcHuRYGZ
 yvChT5GI+sGHIElAkVRObo2jP3F0oL+bP9qNpe2B7Sq9rpOZJDZ5d/Vzjl2IgbotxdV4VDGoW/H
 haHBcK/wYYCWaqiXax+GXk1wy7rOSR9h8KDZTet/RmOmb3abDVBfQWRiGIIwcsq8Cje7FEtoGTs
 CL0KTDB+A==
X-Received: by 2002:a05:620a:44cf:b0:8c6:a1d5:47e1 with SMTP id
 af79cd13be357-8caeeb4e117mr380491485a.9.1770393193829; 
 Fri, 06 Feb 2026 07:53:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9fdf739sm176815485a.41.2026.02.06.07.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 07:53:13 -0800 (PST)
Date: Fri, 6 Feb 2026 10:53:11 -0500
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
Message-ID: <aYYOZ1TK5dpX_h_Q@gourry-fedora-PF4VCD3F>
References: <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
 <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
 <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
 <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
 <20260206110305.00001fbb@huawei.com>
 <aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
 <20260206150941.000028ae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206150941.000028ae@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x732.google.com
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

On Fri, Feb 06, 2026 at 03:09:41PM +0000, Jonathan Cameron wrote:
> On Fri, 6 Feb 2026 08:31:09 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> Now a fun corner is that a node isn't created unless there is something
> in it - the whole SRAT is the source of truth for what nodes exist
> - so we need 'something' in it - a cpu will do, or a GI, probably a GP.
> Otherwise memory ends up in node0.  However, fallback lists etc happen
> as normal when first mem in a node is added.
> 
...
> For now I 'suspect' we could hack things to provide lots of waiting numa nodes
> and merrily assign HPA into them as we like whatever SRAT provides
> in the way of 'hints' :) 
> 

look at ACPI MSCT - "Maximum Proximity Domain Information Structure" ;]

I don't remember reading anything in the ACPI spec that says something
has to be ON any of these PXMs for it to be accounted for in the MSCT.

Platforms can just say "Reserve that many Nodes".

(Linux does not read this value, and on my existing systems, this number
always reflects the number of actually present PXMs)

---

We probably want to ignore that and just add this:

CONFIG_ACPI_NUMA_NODES_PER_CFMWS
    int
    range 1 4
    help
        This option determines the number of NUMA nodes that will be
	added for each CEDT CFMWS entry.

	By default ACPI reserves 1 per unique PXM entry in the SRAT,
	or 1 for a CXL Fixed Memory Window without SRAT mappings.

	This will reserve up to N nodes per CEDT entry, even if that
	CEDT has one or more SRAT entries.

then in the acpi/numa/srat.c code that parses srat/cedt, just track
the number of nodes over a CEDT range.

for each srat:
   account_unique_pxm(pxm, srat_range)

for each cedt:
   nr_nodes = unique_pxms(cedt_range)
   while (nr_nodes < CONFIG_ACPI_NUMA_NODES_PER_CFMWS)
      node = acpi_map_pxm_to_node(*fake_pxm++);
      if (node == NUMA_NO_NODE):
      	err("Unable to reserve additional nodes for CXL windows")
	break;
      node_set(node, numa_nodes_parsed);
      nr_nodes++

This should fall out cleanly.

The additional nodes won't be associated with anything, but could be
used for hotplug - I imagine.

~Gregory

