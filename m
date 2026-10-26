Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517CE606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BniglHSU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJzj-0001dQ-Pl; Mon, 26 Oct 2026 08:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLJzh-0001c9-TB; Mon, 26 Oct 2026 08:40:06 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLJzg-0000oo-ED; Mon, 26 Oct 2026 08:40:05 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEF2E6022B;
 Mon, 26 Oct 2026 12:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFAA1F01828;
 Mon, 26 Oct 2026 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793018402;
 bh=ligm0L7VzDEsKwwiCZjUWtBzsMVz+qIupxwj5wdS1R0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BniglHSUJjSueSYuQGvOu2RtB3dJAYj+VxQFeQ0DwnZtjIruK7H4P9yCECnJi0QUN
 duDkWmhjlfnjMiReFAfT3j7KzQ4rIMeFZLBDsxsILYqEHnfwqAtCl2po8ORzphssD0
 nDYxf/sjpS32fPIYoABHnYRy4w2zl2x8eZ3FDygJoFaX9gxQj1lvGbXpk21V7oJDBB
 2fQ4gx2WZYcqwocLOgDmJYgNO8OYiwwgU8WEmN0I1WxK0JjFbDHJfkN9/G8jgO4eVp
 DOpndy9RPUmWTjIqI4PvLekUtW7Rwfsgg26mjWO/uT5tKWHIEJKLdW3yq14Myt+VAy
 o/qvjVwCqyxQA==
Message-ID: <85edb886-aa9a-4fab-a60f-ba73e00f7d25@kernel.org>
Date: Mon, 26 Oct 2026 13:39:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 0/7] hw/nvme: lift IOV_MAX limit in DMA path
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
 <at9AJGxUZvRoBrBw@AALNPWKJENSEN.aal.scsc.local>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
In-Reply-To: <at9AJGxUZvRoBrBw@AALNPWKJENSEN.aal.scsc.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=da.gomez@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/2026 13.03, Klaus Jensen wrote:
> On Oct 26 11:11, Daniel Gomez wrote:
> 
> I've been holding out on this because I'd really like an Acked-by from a
> Memory API maintainer (system/dma-helpers.c).

Paolo, Peter, Philippe,

Can you take a look? FYI, patches have already been reviewed by Keith
and Jesper early last month.



