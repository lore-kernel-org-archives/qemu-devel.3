Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EC7EE209E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLKH-0001lE-FX; Fri, 06 Feb 2026 07:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voLKB-0001kf-GR
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:52:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voLK9-0000YQ-Vk
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:52:39 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6vBN5SBqzHnHD0;
 Fri,  6 Feb 2026 20:52:28 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 335BD40539;
 Fri,  6 Feb 2026 20:52:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 12:52:32 +0000
Date: Fri, 6 Feb 2026 12:52:31 +0000
To: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Michael S Tsirkin <mst@redhat.com>, Shiju Jose
 <shiju.jose@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 09/13] scripts/ghes_inject: add a handler for PCIe bus
 error
Message-ID: <20260206125231.000010d7@huawei.com>
In-Reply-To: <20260121133355.000040d9@huawei.com>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <c7db16aae93a98f3b0675e1010e59f6cefdaf1cd.1768993993.git.mchehab+huawei@kernel.org>
 <20260121133255.000018b1@huawei.com>
 <20260121133355.000040d9@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 21 Jan 2026 13:33:55 +0000
Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:

> On Wed, 21 Jan 2026 13:32:55 +0000
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> > On Wed, 21 Jan 2026 12:25:17 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Add a logic to do PCIe BUS error injection.
> > > 
> > > On Linux Kernel, despite CPER_SEC_PCI_X_BUS macro is defined for such
> > > event, ghes.c doesn't implement support for it yet:
> > > 
> > > [16950.077494] {26}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > > [16950.077866] {26}[Hardware Error]: event severity: recoverable
> > > [16950.078118] {26}[Hardware Error]:  Error 0, type: recoverable
> > > [16950.078444] {26}[Hardware Error]:   section type: unknown, c5753963-3b84-4095-bf78-eddad3f9c9dd
> > > [16950.078800] {26}[Hardware Error]:   section length: 0x48
> > > [16950.079069] {26}[Hardware Error]:   00000000: 00000000 00000000 00000000 00000000  ................
> > > [16950.079442] {26}[Hardware Error]:   00000010: 00000001 00000000 00000000 00000000  ................
> > > [16950.079811] {26}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > > [16950.080181] {26}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> > > [16950.080538] {26}[Hardware Error]:   00000040: 00000000 00000000                    ........
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> > 
> > LGTM. Bit surprised Linux doesn't decode it but fair enough.
> > Seems a bit unlikely it ever will given this seems not to cover PCIe
> > which has it's own records.
> >   
> Just noticed your patch description. This is PCI/PCI-X errors, not PCIe.
Seem this was stuck in my outbox. Please ignore as you long fixed this
I think.

J
> 
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>  
> 
> 


