Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48E5D2F036
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjmF-00030t-RP; Tue, 27 Jan 2026 09:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkjm8-0002tl-P5
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:10:38 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkjm4-00080c-PL
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:10:36 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 052E25969F3;
 Tue, 27 Jan 2026 15:10:31 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id fMIS5rJ5D-mx; Tue, 27 Jan 2026 15:10:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E8A915969F2; Tue, 27 Jan 2026 15:10:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E6A7B5969FA;
 Tue, 27 Jan 2026 15:10:28 +0100 (CET)
Date: Tue, 27 Jan 2026 15:10:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 00/10] Implement memory_region_new_* functions
In-Reply-To: <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
Message-ID: <0118dc9b-d467-7f6b-92a8-4f42760ecb6c@eik.bme.hu>
References: <cover.1769362313.git.balaton@eik.bme.hu>
 <CAFEAcA_jS3hef=dhxZ5s7MReSW4ir+jMUGwu+RjD_JP7ZRrRXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 27 Jan 2026, Peter Maydell wrote:
> On Sun, 25 Jan 2026 at 18:36, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> Our documentation says that memory regions are automatically freed
>> when the owner dies and the reference counting to do this is also
>> implemented. However this relies on the QOM free funtion that can only
>> be set by creating objects with object_new but memory API only
>> provides constructors that call object_initialize which clears the
>> free function that prevents QOM to manage the memory region lifetime.
>> Implement corresponding memory_region_new_* functions that do the same
>> as the memory_region_init_* functions but create the memory region
>> with object_new so the lifetime can be automatically managed by QOM as
>> documented. The memory_region_init functions are kept because they are
>> useful for memory regions embedded in other object or managed
>> externally and not by QOM for some reason.
>
> If we have a problem with embedded MemoryRegions being leaked,
> we need to fix that.

I have a problem with embedded memory regions (and embedded objects in 
general) because:

- they are making state structs unnecessarily crowded obscuring what 
should really be there
- leaving the fields to store these memory regions in the parent classes 
and the QOM way of lifetime management unused
- exposes internal object implementation to the outside
which is against encapsulation and reuse of object oriented design.

Therefore, I consider embedded memory regions as a hack to solve leaks 
because the intended and documented way of using reference counting to 
manage the lifetime of these regions cannot be used due to missing API to 
instantiate them in a way so it works. This series tries to resolve that 
not add new principle or standard.

> I'm very reluctant to create a whole new
> set of APIs which handles MRs in a non-standard way (i.e.
> "QOM object has a pointer to MR rather than embedding it")

But this is the standard and documented way if you read the life cycle 
section of the memory docs and the embedded regions became more used 
instead of resolving this problem in the way it was originaly intended. 
The QOM subclass does not store a pointer to these as it's not needed, 
they are managed by QOM so they are created and can be forgotten about 
without littering the state struct with fields never used in the object 
methods just to manage the memory that QOM could already manage. (The 
parent sysbus or PCI class keeps a pointer when registering them as 
regions and Object stores them as a child but that's already there and 
needed for those classes not the subclass so we can avoid duplicating it 
in the subclass.)

> and leaves the existing ones alone. QEMU already has way too
> many situations where we have multiple different APIs that can
> be used to do something and incomplete transitions from the
> old one to the new one.

This series does not convert everything but opens the way to do that and 
simplify objects by only storing things in the state that are really 
needed by the object and let QOM manage what it can. I'd really like to 
avoid having a list of unused stuff in the state struct just because I 
can't use something that works and documented just no API to actually use 
it. Cf. sii3112 state after this series:

struct SiI3112PCIState {
     PCIIDEState i;

     SiI3112Regs regs[2];
};

vs. your standard:

struct SiI3112PCIState {
     PCIIDEState i;

     MemoryRegion mmio;
     MemoryRegion bar0;
     MemoryRegion bar1;
     MemoryRegion bar2;
     MemoryRegion bar3;
     MemoryRegion bar4;
     SiI3112Regs regs[2];
};

First I thought we could use object_new then memory_region_init but it 
turns out that does not work because memory_region_init calls 
object_initialize which removes the free function installed by object_new 
and since there's no other way to set it other than by calling object_new 
a split init like in macOS (i.e. alloc+init) is also not possible so a new 
set of memory_region_new functions seem to be the easiest way to use it as 
intended and avoid changing every user of memory_region_init functions.

As mentioned in the docs and cover letter both set of functions are useful 
in different situations and they are otherwise the same so it would not 
make the API much more complex as these are basically variants of one set 
of functions only differing in dynamically allocating object or 
initialising pre-allocated object that are not managed by QOM (which is 
what the embedded objects do: take object out from QOM and let the 
subclass manage it instead of using the infrastructure that's already 
there for it). If you go the embedded way then the registering memory 
regions as children should be removed and everything converted to use 
embedded regions but I don't think that would be an improvement.

Regards,
BALATON Zoltan

