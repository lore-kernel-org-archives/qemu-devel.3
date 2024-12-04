Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBCBE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 07:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIkC9-000890-6R; Wed, 04 Dec 2024 02:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tIkBH-0007TD-W7; Wed, 04 Dec 2024 02:52:25 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tIkBF-00029K-4C; Wed, 04 Dec 2024 02:52:19 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 15A20A419EF;
 Wed,  4 Dec 2024 07:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28C5C4CED1;
 Wed,  4 Dec 2024 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733298732;
 bh=6rcAR5fx634iJHuLmG3RpP1qjECcf4AuZFK+vo0BkYs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=h4Bm708aGOwWi+sLdeoBl9r2YU87vdRoZ6A1uP2smaNA3Ov57u+rvrYCzwOWjEoA0
 Pn3BCI79QhR+EMfVLApskVeRtEPCKYPLLJfBJRM5Jp+b+eZ9JOs5NkT23zZShE/YX5
 kX/pMa8uti42JCL9M1ZXQ4DUPFg9CWPt1Wc8r+0DbXzSHFqdjD6ot+99Myl115VWJC
 YyPCHgYmzH4F3kNXuyDwv7+BY+OULBQ9tuJpgxQ0DpmK+yJspBTHlq31UfFkXJHvBl
 1P9o2RchNryrXJoBYXlTm5heVJZ2jskqdxyXtvp39YYocn/kff7Y9WfaM2gbXkOdt7
 BE5ElJxo6oXKA==
Date: Wed, 4 Dec 2024 08:52:07 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241204085207.0ecae6ae@foz.lan>
In-Reply-To: <20241125115643.00002923@huawei.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
 <20241125115643.00002923@huawei.com>
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

Em Mon, 25 Nov 2024 11:56:43 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Fri, 22 Nov 2024 10:11:25 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Split the code into separate functions to allow using the
> > common CPER filling code by different error sources.
> > 
> > The generic code was moved to ghes_record_cper_errors(),
> > and ghes_gen_err_data_uncorrectable_recoverable() now contains
> > only a logic to fill the Generic Error Data part of the record,
> > as described at:
> > 
> > 	ACPI 6.2: 18.3.2.7.1 Generic Error Data
> > 
> > The remaining code to generate a memory error now belongs to
> > acpi_ghes_record_errors() function.
> > 
> > A further patch will give it a better name.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> One trivial follow up that is enabled by the change you are discussing with Igor.
> Up to you that one.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > +
> > +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> > +{
> > +    /* Memory Error Section Type */
> > +    const uint8_t guid[] =
> > +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> > +                  0xED, 0x7C, 0x83, 0xB1);
> > +    Error *errp = NULL;
> > +    int data_length;
> > +    GArray *block;
> > +
> > +    if (!physical_address) {
> > +        error_report("can not find Generic Error Status Block for source id %d",
> > +                     source_id);
> > +        return -1;
> > +    }  
> 
> With this error check gone (as per discussion with Igor) you could use
> g_autofree to deal with freeing block.
> 
> That would bring the errp check right next to the call that would result
> in errp potentially being set and slightly improve readability.
> 
> Mind you there are no uses of this in hw/acpi currently so maybe this
> isn't a good time to start :)

Yeah, I prefer to not do such cleanup now. As you said, this isn't used
right now at ghes, and there are still two series on the top of it.

IMO, such kind of change should happen afterwards, and checking on
other places were memory is allocated in the driver.

Thanks,
Mauro

