Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D98DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1zd-0001HM-LD; Thu, 08 Aug 2024 08:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc1zX-0001Bn-FJ; Thu, 08 Aug 2024 08:11:40 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc1zU-0003S3-Qo; Thu, 08 Aug 2024 08:11:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 85D2ECE13B5;
 Thu,  8 Aug 2024 12:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B0DC4AF10;
 Thu,  8 Aug 2024 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723119080;
 bh=okDt0GF8kFCoft7LCpimb0DlLgYHkqdTo2/807i2Izk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eY5IkJARG4aA/YFX2VkVMgRviMYbTYcnncqt4Al0e87J3bJPWSZCs+elDKgmYOAIC
 cdUXuDTislz46dDFhM4mOzRm74/CWxkVsuMLrTX9v1gTKXTDgMOonjjPaETlrooKK+
 E7Did2Cxy4wAQa9MaGwCujgwPVc8OugUizkFvZ8j3pRGF388GDiPGsiY0nk2a7vib5
 1H8DL2+zY1Iajvup3N+uT0GyQDDoASreEpRit4UrQt1l6QuDRbU046SXyg4D8oPC0k
 krIP9LyhZZu5PwpUcl9ECVpbieBU+iJZltj6ilOoSY0nbT+3CBRTNuLcXI6KSKhC66
 aYup7vo7S0EeA==
Date: Thu, 8 Aug 2024 14:11:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240808141114.3b021f80@foz.lan>
In-Reply-To: <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
 <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Tue, 6 Aug 2024 16:31:13 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +    /* Could also be read back from the error_block_address register */
> > +    *error_block_addr = base +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> > +
> > +    return true;
> > +}  
> 
> I don't like all this pointer math, which is basically a reverse engineered
> QEMU actions on startup + guest provided etc/hardware_errors address.
> 
> For once, it assumes error_source_to_index[] matches order in which HEST
> error sources were described, which is fragile.
> 
> 2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
> in RAM migrated from older version might not match above assumptions
> of target QEMU. 
> 
> I see 2 ways to rectify it:
>   1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
>        in guest RAM, like we do with etc/hardware_errors, see
>             build_ghes_error_table()
>                ...
>                tell firmware to write hardware_errors GPA into
>        and then fetch from HEST table in RAM, the guest patched error/ack addresses
>        for given source_id
> 
>        code-wise: relatively simple once one wraps their own head over
>                  how this whole APEI thing works in QEMU
>                  workflow  is described in docs/specs/acpi_hest_ghes.rst
>                  look to me as sufficient to grasp it.
>                  (but my view is very biased given my prior knowledge,
>                   aka: docs/comments/examples wrt acpi patching are good enough)
>                  (if it's not clear how to do it, ask me for pointers)

That sounds a better approach, however...

>   2nd:  sort of hack based on build_ghes_v2() Error Status Address/Read Ack Register
>         patching instructions
>                bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,                
>                    address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),                      
>                    ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
>                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^
>         during build_ghes_v2() also store on a side mapping
>              source_id -> error address offset : read ack address
> 
>         so when you are injecting error, you'd at least use offsets
>         used at start time, to get rid of risk where injection code
>         diverge from HEST:etc/hardware_errors layout at start time.
> 
>         However to make migration safe, one would need to add a fat
>         comment not to change order ghest error sources in HEST _and_
>         a dedicated unit test to make sure we catch it when that happens.
>         bios_tables_test should be able to catch the change, but it won't
>         say what's wrong, hence a test case that explicitly checks order
>         and loudly & clear complains when we will break order assumptions.
> 
>         downside:
>            * we are are limiting ways HEST could be composed/reshuffled in future
>            * consumption of extra CI resources
>            * and well, it relies on above duct tape holding all pieces together

I ended opting to do approach (2) on this changeset, as the current code
is already using bios_linker_loader_add_pointer() for ghes, being deeply 
relying on the block address/ack and cper calculus.

To avoid troubles on this duct tape, I opted to move all offset math
to a single function at ghes.c:

	/*
	 * ID numbers used to fill HEST source ID field
	 */
	enum AcpiHestSourceId {
	    ACPI_HEST_SRC_ID_SEA,
	    ACPI_HEST_SRC_ID_GED,
	
	    /* Shall be the last one */
	    ACPI_HEST_SRC_ID_COUNT
	} AcpiHestSourceId;

	...

	static bool acpi_hest_address_offset(enum AcpiGhesNotifyType notify,
        	                             uint64_t *error_block_offset,
                	                     uint64_t *ack_offset,
                        	             uint64_t *cper_offset,
                                	     enum AcpiHestSourceId *source_id)
	{
	    enum AcpiHestSourceId source;
	    uint64_t offset;

	    switch (notify) {
	    case ACPI_GHES_NOTIFY_SEA:      /* Only on ARMv8 */
	        source = ACPI_HEST_SRC_ID_SEA;
	        break;
	    case ACPI_GHES_NOTIFY_GPIO:
	        source = ACPI_HEST_SRC_ID_GED;
	        break;
	    default:
	        return true;
	    }

	    if (source_id) {
	        *source_id = source;
	    }

	    /*
	     * Please see docs/specs/acpi_hest_ghes.rst for the memory layout.
	     * In summary, memory starts with error addresses, then acks and
	     * finally CPER blocks.
	     */

	    offset = source * sizeof(uint64_t);

	    if (error_block_offset) {
	        *error_block_offset = offset;
	    }
	    if (ack_offset) {
	        *ack_offset = offset + ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
	    }
	    if (cper_offset) {
	        *cper_offset = 2 * ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t) +
	                       source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
	    }

	    return false;
	}

I also removed the anonymous enum with SEA/GPIO source IDs, using
only the ACPI notify type as arguments at the function calls.

As there's now a single point where the offsets from
docs/specs/acpi_hest_ghes.rst are enforced, this should be error
prone.

The code could later be changed to use approach (2), on a separate
cleanup.

Thanks,
Mauro

