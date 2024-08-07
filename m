Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9DBC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 07:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbatz-0004mx-UL; Wed, 07 Aug 2024 03:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbatj-0004Hp-3o; Wed, 07 Aug 2024 03:15:53 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbatf-0006Bw-Mc; Wed, 07 Aug 2024 03:15:50 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9F26ACE0FCB;
 Wed,  7 Aug 2024 07:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC95DC32782;
 Wed,  7 Aug 2024 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723014934;
 bh=pK22yhBmwEV9vfaShFs7JJ+yRCbOTFQ+OLTOdkiD5lY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pfAaDdpmjdfduul89ysQ0l2f7W4ME41opDHpPYg7cQztfIoMJJsv5sdsDI2yZak8v
 hdoE8Gc6JjAlyi2rzWDXtBEzviiQ8JbVL+rBzzTvnVsNQrUjFeVC7olTq62TZCMAEz
 8qknts1dyduj0MKngXzluxZX9X0W7ZVj5LJXLGSEf3qTu3ehT+WWRGc2e8wdAFA32E
 3IHB71874NY5pNRk8dRHrxID7MClNff+mtzvWn0RwdSrKZCeX7YhxRScLcd+L2i41Q
 KFTv0fgFzs3Tf7jY68jnTNnMjUdgiIQuqlCbOgP+334HGzpLTp2pAS4fy76kEGgVeE
 s7UfExgWzznCA==
Date: Wed, 7 Aug 2024 09:15:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 4/7] acpi/ghes: Support GPIO error source
Message-ID: <20240807091529.0991b939@foz.lan>
In-Reply-To: <20240806113219.02ba0fdd@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <5d53042ebc5bc73bbc71f600e1ec1dea41f346b9.1722634602.git.mchehab+huawei@kernel.org>
 <20240806113219.02ba0fdd@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Em Tue, 6 Aug 2024 11:32:19 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > @@ -327,6 +330,9 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> >           */
> >          build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
> >          break;
> > +    case ACPI_HEST_SRC_ID_GPIO:
> > +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);  
> 
> perhaps ACPI_GHES_NOTIFY_EXTERNAL fits better here?

Symbol already used to map the 12 possible notification types from ACPI spec.
I did a:

	sed s,ACPI_HEST_SRC_ID_GED_INT,ACPI_HEST_NOTIFY_EXTERNAL,

instead.

Thanks,
Mauro

