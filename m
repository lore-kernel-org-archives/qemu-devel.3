Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CF2C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzbU-0005FL-E2; Tue, 25 Jun 2024 02:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horen.chuang@linux.dev>)
 id 1sLzbN-0005El-G3
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:24:26 -0400
Received: from out-187.mta1.migadu.com ([2001:41d0:203:375::bb])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horen.chuang@linux.dev>)
 id 1sLzbL-0007qy-2f
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:24:25 -0400
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1719296654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4bxxUAJuq2rr3KPobPQOBQilwLNETOz0MjNzojnBtM=;
 b=CN5gE+Eq2magNWdd8QrK1zOC3R8bf1KbPZ3NH9ELjsQfumrMQ5gnwKYAZAkzWgr2EYAqBM
 2yVj5cKUrvfKzBc8H6TkGnWbAf8q9duzXXHPtXGf69fs6rCVGhRFZQqAgEZE11RZLM6GES
 5MsvgxqkJjLjP90OPOw5Zo/n8pxt1uM=
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: gourry.memverge@gmail.com
X-Envelope-To: aneesh.kumar@linux.ibm.com
X-Envelope-To: mhocko@suse.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: john@jagalactic.com
X-Envelope-To: emirakhur@micron.com
X-Envelope-To: vtavarespetr@micron.com
X-Envelope-To: ravis.opensrc@micron.com
X-Envelope-To: apopple@nvidia.com
X-Envelope-To: sthanneeru@micron.com
X-Envelope-To: sj@kernel.org
X-Envelope-To: rafael@kernel.org
X-Envelope-To: lenb@kernel.org
X-Envelope-To: dave.jiang@intel.com
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: linux-acpi@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: horenc@vt.edu
X-Envelope-To: horenchuang@bytedance.com
X-Envelope-To: horenchuang@gmail.com
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: qemu-devel@nongnu.org
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 06:24:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: horen.chuang@linux.dev
Message-ID: <acf41fe2246f3696a6fe267b8a23bdb4f855cb4e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] memory tier: consolidate the initialization of memory
 tiers
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>, "Huang, Ying"
 <ying.huang@intel.com>, "Gregory Price" <gourry.memverge@gmail.com>,
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org,
 john@jagalactic.com, "Eishan Mirakhur" <emirakhur@micron.com>, "Vinicius
 Tavares Petrucci" <vtavarespetr@micron.com>, "Ravis OpenSrc"
 <Ravis.OpenSrc@micron.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>, "SeongJae Park"
 <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown"
 <lenb@kernel.org>, "Dave Jiang" <dave.jiang@intel.com>, "Dan Williams"
 <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
In-Reply-To: <20240621183413.1638e7453a0bed2af5f44273@linux-foundation.org>
References: <20240621044833.3953055-1-horen.chuang@linux.dev>
 <20240621183413.1638e7453a0bed2af5f44273@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::bb;
 envelope-from=horen.chuang@linux.dev; helo=out-187.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

June 21, 2024 at 6:34 PM, "Andrew Morton" <akpm@linux-foundation.org> wro=
te:

Hi Andrew,

Thanks for the feedback. I will send a v2 with the patch description
written in a cover letter.

>=20
>=20On Fri, 21 Jun 2024 04:48:30 +0000 "Ho-Ren (Jack) Chuang" <horen.chua=
ng@linux.dev> wrote:
>=20
>=20>=20
>=20> If we simply move the set_node_memory_tier() from memory_tier_init(=
) to
> >=20
>=20>  late_initcall(), it will result in HMAT not registering the
> >=20
>=20>  mt_adistance_algorithm callback function,
> >=20
>=20
> Immediate reaction: then don't do that!
>=20
>=20>=20
>=20> because set_node_memory_tier()
> >=20
>=20>  is not performed during the memory tiering initialization phase,
> >=20
>=20>  leading to a lack of correct default_dram information.
> >=20
>=20>=20=20
>=20>=20
>=20>  Therefore, we introduced a nodemask to pass the information of the
> >=20
>=20>  default DRAM nodes. The reason for not choosing to reuse
> >=20
>=20>  default_dram_type->nodes is that it is not clean enough. So in the=
 end,
> >=20
>=20>  we use a __initdata variable, which is a variable that is released=
 once
> >=20
>=20>  initialization is complete, including both CPU and memory nodes fo=
r HMAT
> >=20
>=20>  to iterate through.
> >=20
>=20>=20=20
>=20>=20
>=20>  Besides, since default_dram_type may be checked/used during the
> >=20
>=20>  initialization process of HMAT and drivers, it is better to keep t=
he
> >=20
>=20>  allocation of default_dram_type in memory_tier_init().
> >=20
>=20
> What is this patch actually aiming to do? Is it merely a code cleanup,
>=20
>=20or are there functional changes?
>=20
>=20>=20
>=20> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> >=20
>=20>  ---
> >=20
>=20>  Hi all,
> >=20
>=20>=20=20
>=20>=20
>=20>  The current memory tier initialization process is distributed acro=
ss two
> >=20
>=20>  different functions, memory_tier_init() and memory_tier_late_init(=
). This
> >=20
>=20>  design is hard to maintain. Thus, this patch is proposed to reduce=
 the
> >=20
>=20>  possible code paths by consolidating different initialization patc=
hes into one.
> >=20
>=20
> Ah, there it is. Please make this the opening paragraph, not an aside
>=20
>=20buried below the ^---$.
>=20
>=20I'll await review input before proceeding with this, thanks.
>

