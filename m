Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D323BE64AA4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT73-0004fC-8E; Tue, 03 Dec 2024 08:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tIT6y-0004NW-4K; Tue, 03 Dec 2024 08:38:44 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tIT6w-0001WS-G1; Tue, 03 Dec 2024 08:38:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9801CA4154E;
 Tue,  3 Dec 2024 13:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C710C4CECF;
 Tue,  3 Dec 2024 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733233111;
 bh=7rxcTbvnhbMVz8ygNphkbF86kDtn0YCOEk/Z5XEkOIQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uqc9GqaJAwLMEfMTl1Uxxddq28fOYmkab+8EZHajCB9nJkl6YKkV66Rn8EIv7hZVT
 /8RMKl+agEt1aQ6br0aQDLMDzW3UB6JE7QL30/BEmsTJVySuu9EkHoRsQHoYWyYwhk
 7uJ4i5yV/ydkkycCttziqNqxlF1PdQ3hPAPZrAE/ZMw4qcizb7lHR+cCWHun4toi1l
 zDmxacGiTGVe6QIvi+WYeAgY/EPFyFQ3NNT8ae3iMl4KPY69BpOsXOs2iywSthl657
 jJ/vjf1/nsH+cac7j92JCCdpQU+jgO8SCeoXuA787bz8Xf0jbjt/V/csJ+W+hRLpyH
 p/aGkoLSnWEkg==
Date: Tue, 3 Dec 2024 14:38:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241203143826.4fd23e48@foz.lan>
In-Reply-To: <20241203124232.7948b2fb@imammedo.users.ipa.redhat.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
 <20241203124232.7948b2fb@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Tue, 3 Dec 2024 12:42:32 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +    /*
> > +     * Clear the Read Ack Register, OSPM will write it to 1 when  
>                                                  ^^^^^^^^^^^^^ typo?
> > +     * it acknowledges this error.
> > +     */

Yes. I'll add this hunk there:

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 68fb30c2d5c1..4b5332f8c667 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -403,8 +403,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     read_ack_register = cpu_to_le64(0);
     /*
-     * Clear the Read Ack Register, OSPM will write it to 1 when
-     * it acknowledges this error.
+     * Clear the Read Ack Register, OSPM will write 1 to this register when
+     * it acknowledges the error.
      */
     cpu_physical_memory_write(read_ack_register_addr,
         &read_ack_register, sizeof(uint64_t));


Thanks,
Mauro

