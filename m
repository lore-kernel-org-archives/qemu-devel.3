Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4C3C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqAqX-0007rO-HW; Mon, 16 Sep 2024 08:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CK3F=QO=kaod.org=clg@ozlabs.org>)
 id 1sqAqV-0007gc-G9
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:28:47 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CK3F=QO=kaod.org=clg@ozlabs.org>)
 id 1sqAqP-0001hl-Gs
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:28:46 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X6kjJ4TDfz4x8X;
 Mon, 16 Sep 2024 22:28:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X6kjF4s05z4x3q;
 Mon, 16 Sep 2024 22:28:33 +1000 (AEST)
Message-ID: <c488c507-ae5f-4a95-bbb8-c92799f25630@kaod.org>
Date: Mon, 16 Sep 2024 14:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org> <ZuRQirmjwWGj1N2D@x1n>
 <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
 <881df54b-c98c-4ce0-a434-05d055cc27bb@kaod.org>
Content-Language: en-US, fr
In-Reply-To: <881df54b-c98c-4ce0-a434-05d055cc27bb@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=CK3F=QO=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mattias,


> Cédric, can you try with the above patch and/or 
> 
> crash seems gone.
> 
>> share more details of your setup so I can verify
> 
> You will need a Linnux powerpc or powerpc64 image for mac machines,
> which are not common now days, or MacOS images. My debian images
> are big. I will try to build you a small one for more tests.

Grab :

   https://cdimage.debian.org/cdimage/ports/10.0/powerpc/iso-cd/debian-10.0-powerpc-NETINST-1.iso

and run :

   qemu-system-ppc -M mac99 -cpu g4 -cdrom debian-10.0.0-powerpc-NETINST-1.iso -nographic -boot d

Thanks,

C.



