Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00F0C369A4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 07:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stMWF-0001fX-5S; Wed, 25 Sep 2024 03:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stMWD-0001WS-MP
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:33:01 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stMWC-0008U2-2C
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 03:33:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 816C6A43C06;
 Wed, 25 Sep 2024 07:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39B2C4CEC3;
 Wed, 25 Sep 2024 07:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727249578;
 bh=AtqSt6iODFs/wkU/c1FCnNaPM9X0N32dQ/Eiwhzqvb4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=quR6G069Xt6tN2WI9D20M4Dt6UMDedqLTUIGYgI6MZEJtnBX4OoIDg6A37Ty7p6gf
 Mt3mg7v4ynWhYkRmIO4bsMQjywI51z14nkNbHa+Ggee/ym7A297qovlKb29ImjkY5Z
 pU1w/p2xdpG5mLNfYAKVpPrfmTEV0o1Wz/iFy5eK0x+lKedSzb8Z1E55wAPh2qNwrs
 xrNYXYgxZeaiZRyjvJoz/yTrgP3WIi6xJt/AU3M8givXrgg6d35hUtmRjq/SuzhoOq
 2ft3SiJdoTBUazOjKNVPqC5rwGDykozRdoxZMyBnm8Ism4JwEZIxhnY5+yL5qtzQgQ
 2gofeVQQULncA==
Date: Wed, 25 Sep 2024 09:32:53 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 02/21] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20240925093253.758d4064@foz.lan>
In-Reply-To: <20240917140146.56c9d581@imammedo.users.ipa.redhat.com>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
 <20240917140146.56c9d581@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Em Tue, 17 Sep 2024 14:01:46 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > @@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
> >  static bool ghes_needed(void *opaque)
> >  {
> >      AcpiGedState *s = opaque;
> > -    return s->ghes_state.ghes_addr_le;  
>                             ^^^^^^^^^^^^
> another thing, perhaps we should rename it to 'hardware_errors_addr'
> to make it less confusing 

At the cleanups, I added a rename patch. I opted to a shorter name:
	hw_error_le.

Thanks,
Mauro

