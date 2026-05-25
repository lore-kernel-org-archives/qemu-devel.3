Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A73CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 20:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRcMv-00047v-Ou; Mon, 25 May 2026 16:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRcMu-00047P-AB
 for qemu-devel@nongnu.org; Mon, 25 May 2026 16:57:48 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRcMr-00081V-KZ
 for qemu-devel@nongnu.org; Mon, 25 May 2026 16:57:48 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 182EA5968DC;
 Mon, 25 May 2026 22:57:41 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id q0p-rLpd-CRO; Mon, 25 May 2026 22:57:39 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 12194596858; Mon, 25 May 2026 22:57:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 104065966F5;
 Mon, 25 May 2026 22:57:39 +0200 (CEST)
Date: Mon, 25 May 2026 22:57:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 1/7] memory: Export memory_region_set_ops()
In-Reply-To: <CAFEAcA9Nh9qZ1k_Pq04ajdP8ObrNpen4aYeu-mPNiYbRc9ho3Q@mail.gmail.com>
Message-ID: <ec2a907a-9fab-d56a-83a2-409254146209@eik.bme.hu>
References: <cover.1779723483.git.balaton@eik.bme.hu>
 <d6fff532607b5153094cd6c72f78a2de5672aaec.1779723483.git.balaton@eik.bme.hu>
 <CAFEAcA9Nh9qZ1k_Pq04ajdP8ObrNpen4aYeu-mPNiYbRc9ho3Q@mail.gmail.com>
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

On Mon, 25 May 2026, Peter Maydell wrote:
> On Mon, 25 May 2026 at 16:47, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> Make memory_region_set_ops() function public. In some cases such as
>> when devices have configurable endianness or different behaviour based
>> on settings it is necessary to change the ops callback after the
>> memory region is created. Export memory_region_set_ops() function for
>> this.
>
> If some other CPU is in the middle of using the old MemoryRegionOps
> when the device swaps them out under its feet, what happens?

In my limited test with PPC and ati-vga this seems to work and the switch 
would happen in device register write so nothing else is expected to run 
accessing the device at the same time at that point. I can't tell for all 
possible cases but that would then be a problem in the caller not in this 
function. Callers are expected to call it when appropriate which I could 
mention in the doc comment if needed.

> You could also remove the old MR from its container and add a different
> one with the different behaviour when the guest changes the config,
> or have both of them in the container and toggle which is visible
> with memory_region_set_enabled(). That might potentially be more
> awkward but it would avoid having to look into the memory region
> API internals.

That could also work if I had a container but it's switching the 
endianness of a PCI BAR which is registered with pci_register_bar() so 
it's easiest to switch the ops on the region than hacking around it using 
two more otherwise unneeded memory regions as I also can't swap PCI BARs 
so it would need a container aditionally to two regions using the same 
callbacks just with different endianness. Allowing setting the ops of a 
single region seems simpler.

Regards,
BALATON Zoltan

