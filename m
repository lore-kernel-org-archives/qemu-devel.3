Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D02E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 11:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKc4U-0006Qf-R6; Mon, 09 Dec 2024 06:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tKc4R-0006Po-AV; Mon, 09 Dec 2024 06:36:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tKc4J-0007HU-SO; Mon, 09 Dec 2024 06:36:58 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y6KTR5qh1z6GC63;
 Mon,  9 Dec 2024 19:32:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D6AE1400DD;
 Mon,  9 Dec 2024 19:36:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Dec
 2024 12:36:42 +0100
Date: Mon, 9 Dec 2024 11:36:40 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Shiju Jose
 <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 08/16] acpi/ghes: don't check if physical_address is
 not zero
Message-ID: <20241209113640.000055ab@huawei.com>
In-Reply-To: <95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733561462.git.mchehab+huawei@kernel.org>
References: <cover.1733561462.git.mchehab+huawei@kernel.org>
 <95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733561462.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat,  7 Dec 2024 09:54:14 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The 'physical_address' value is a faulty page. As such, 0 is
> as valid as any other value.
Still not sure on what faulty pages are :)

Given I tagged previous (after you'd sent this)
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index edc74c38bf8a..a3dffd78b012 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
> -    if (!physical_address) {
> -        return -1;
> -    }
> -
>      start_addr += source_id * sizeof(uint64_t);
>  
>      cpu_physical_memory_read(start_addr, &error_block_addr,


