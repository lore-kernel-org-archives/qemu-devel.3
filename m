Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2814C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZVMR-0000YM-1b; Thu, 01 Aug 2024 08:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZVMO-0000Qm-Pv; Thu, 01 Aug 2024 08:56:48 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZVMN-0000L7-2s; Thu, 01 Aug 2024 08:56:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 58ABF6125E;
 Thu,  1 Aug 2024 12:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A953C4AF09;
 Thu,  1 Aug 2024 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722517003;
 bh=yUOmIatsa2JxbuH+5SkDj8HGMvb+bCebLi05n30xnAk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZJmYrJzN4tAnymj5rYqbuo7vESrmbmpWK93FqK7UY+T3aU26iBz1tMvEvtdWu7pKY
 4X/yWHt8lYHKWrsYo1KkRgrJdjgf8buhYSDnaQXlrKKo6zbugs3y5VigRBUHW51ebi
 mxRlWMz+PgMR1sXXNSPjEv+Y0GEznSW3qxvgA3BAehJ95JMwUaXTn6kW4Z9VG+4u1x
 2SMSbY2fRmUT7vAJUEwUqkG5avwLE4gRGo9iIgNC7CPysortKI2QHMxXEwQpIXcNVE
 pqDo2XyZSu7PbNzke8huMKfs2YIsmEGIdfj5JiHf0MhY+mvr88DR3g5j0WKtLLiikm
 X9E67YJQ5n8PQ==
Date: Thu, 1 Aug 2024 14:56:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/7] acpi/ghes: Support GPIO error source.
Message-ID: <20240801145637.03c34fd3@foz.lan>
In-Reply-To: <20240730104028.4f503d91@imammedo.users.ipa.redhat.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <64a31a09fe6b11bebad1c592ad20071a9d93fee5.1721630625.git.mchehab+huawei@kernel.org>
 <20240730104028.4f503d91@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Tue, 30 Jul 2024 10:40:28 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > index 674f6958e905..4f1ab1a73a06 100644
> > --- a/include/hw/acpi/ghes.h
> > +++ b/include/hw/acpi/ghes.h
> > @@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
> >  
> >  enum {
> >      ACPI_HEST_SRC_ID_SEA = 0,
> > +    ACPI_HEST_SRC_ID_GPIO = 1,  
> is it defined by some spec, or just a made up number?

I don't know. Maybe Jonathan or Shiju knows better, as the original patch
came from them, but I didn't find any parts of the ACPI spec defining the
values for source ID.

Checking at build_ghes_v2() implementation, this is used on two places:

1. as GHESv2 source ID:
    /*
     * Type:
     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
     */
    build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
    /* Source Id */
    build_append_int_noprefix(table_data, source_id, 2);
    /* Related Source Id */
    build_append_int_noprefix(table_data, 0xffff, 2);

as an address offset:

    address_offset = table_data->len;
    /* Error Status Address */
    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
                     4 /* QWord access */, 0);
    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
        ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));

So, if I had to guess, I'd say that this was made up, in a way that
the size of the table will fit just two sources, starting from zero.

So, I'll change the code to just:

	enum {
            ACPI_HEST_SRC_ID_SEA = 0,
            ACPI_HEST_SRC_ID_GPIO, 
	    /* future ids go here */
	    ACPI_HEST_SRC_ID_RESERVED,
	};

To remove the false impression that this could be originated from the
spec.

Thanks,
Mauro

