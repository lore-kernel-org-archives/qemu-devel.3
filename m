Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B74CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vES2b-0004it-HB; Thu, 30 Oct 2025 08:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vES2V-0004id-Sx; Thu, 30 Oct 2025 08:46:04 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vES2N-0008Ab-09; Thu, 30 Oct 2025 08:46:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 272E45972E8;
 Thu, 30 Oct 2025 13:45:44 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id mUiIBmrMKMEj; Thu, 30 Oct 2025 13:45:41 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AF2235972E4; Thu, 30 Oct 2025 13:45:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AC1385972E3;
 Thu, 30 Oct 2025 13:45:41 +0100 (CET)
Date: Thu, 30 Oct 2025 13:45:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, 
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
In-Reply-To: <CABgObfZ5fa40SStxMb+OXmg1k2iup1391n+doQNVyZWnR=_v-w@mail.gmail.com>
Message-ID: <ca7728cf-075b-041e-c109-01d6cf8fa48a@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
 <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
 <db06bf5e-b7f5-4980-a054-393529e188eb@rsg.ci.i.u-tokyo.ac.jp>
 <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu>
 <aQJpDE6FvkIF6GgE@x1.local> <318bf988-9035-4012-9708-40c3783803f8@redhat.com>
 <b525a0c5-bcc0-7349-a925-6827591b7a34@eik.bme.hu>
 <3849eccc-ca94-49f9-87a4-4c5aad496976@redhat.com>
 <ffde4e42-58ae-3338-e056-dcfea5d43475@eik.bme.hu>
 <CABgObfZ5fa40SStxMb+OXmg1k2iup1391n+doQNVyZWnR=_v-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On Thu, 30 Oct 2025, Paolo Bonzini wrote:
> Il gio 30 ott 2025, 12:01 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:
>
>>> Not sure what's different between
>>>
>>>    MemoryRegion foo_mr;
>>>
>>> in the struct, versus
>>>
>>>    mr = g_new(MemoryRegion, 1);
>>>
>>> in the realize function.  It's one line either way.
>>
>> Please read back in thread. An example here:
>> https://lists.nongnu.org/archive/html/qemu-ppc/2025-10/msg00785.html
>> from this series
>> https://patchew.org/QEMU/cover.1761232472.git.balaton@eik.bme.hu/
>
>
> I did read it of course.
>
> There's four people in this thread telling you not to do something. Just
> stop arguing please.

I've already stopped and wasn't arguing just trying to answer your 
questions.

Regards,
BALATON Zoltan

