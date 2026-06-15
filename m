Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875B5CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDdQ-0003sc-Td; Mon, 15 Jun 2026 16:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZDdP-0003rH-1x; Mon, 15 Jun 2026 16:10:15 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZDdM-0002qD-R3; Mon, 15 Jun 2026 16:10:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 30740596944;
 Mon, 15 Jun 2026 22:09:57 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Pc0OjRH2YniV; Mon, 15 Jun 2026 22:09:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B25A4596941; Mon, 15 Jun 2026 22:09:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AFDDC596858;
 Mon, 15 Jun 2026 22:09:54 +0200 (CEST)
Date: Mon, 15 Jun 2026 22:09:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org, 
 Peter Xu <peterx@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, 
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
In-Reply-To: <acb64b89-2a5f-4f7c-b5c8-8c31667908c2@nutanix.com>
Message-ID: <117144f2-b9d2-f66b-84ea-601df4a61ed6@eik.bme.hu>
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai-z14dMCK33_pis@redhat.com>
 <CAFEAcA_nFiQyXyCuvwUrJ+-0fhmGoMfswK-+KsZbxahAGatTXw@mail.gmail.com>
 <ai-5M6FF7CoJc_re@redhat.com>
 <CAFEAcA_52oFGv7cC11jbpj9pwBq-x2O-R_aOGkYzaRWW7t-K2g@mail.gmail.com>
 <acb64b89-2a5f-4f7c-b5c8-8c31667908c2@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 15 Jun 2026, Mark Cave-Ayland wrote:
>> But embedded MemoryRegions are enormously common, and devices
>> that embed other devices that embed MemoryRegions are also
>> pretty common. So I don't know how much of a gradual approach
>> you could take for the issue descibed in this patch.
>
> Zoltan did post a patch that allowed for adding externally referenced 
> MemoryRegions a while back: my reason for not supporting the approach was 
> because it added yet another way of adding MemoryRegions to work around a 
> particular legacy use case. However if there is agreement that this is the 
> way we should do things, I suspect that the series will have solved most of 
> the problems in this area.

That series was blocked by Paolo saying no: 
https://lists.nongnu.org/archive/html/qemu-devel/2026-05/msg06665.html 
without ever explaining why it should not be allowed to create ref counted 
memory regions. even though it's documented and implemented that way 
already, but the current memory_region_init() functions don't allow using 
that and forces every memory region to either be embedded or leaked. I 
still think that using QOM to manage memory region life time with ref 
counts is useful as it also makes device models simpler and my series 
allows incremental conversion as it only adds the functions to create QOM 
managed memory regions leaving the exising embedded regions untouched so 
they could be converted one by one when needed. If there's more interest 
in this now I can update and repost it again or I'd still like to see an 
explanation why it is not wanted.

Regards,
BALATON Zoltan

