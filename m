Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F7EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhuj-0004oz-I7; Fri, 04 Jul 2025 11:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXhue-0004na-7u
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXhua-0006wr-8L
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751641268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B6lE4T3M1cFk1K2ualP5jiq/XmsFrTrnW6SmMmBJ9TQ=;
 b=XPA3eeT8ubY6cezOtKOjy+B1lBb2Q31pGfAUtyM7Rwn++dFAgCqpK0tuzc7qSQTpAspO+8
 i6xCiJvUCaVj86eHPv7HN6dLTLX+wEXukUeyaQNz78QB+bhhuDnU+tt74Fnnpgh6HCADll
 2nYxJBrLa3SV/MpMSdx6cnJ/FOK2PCI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-kCKFKPiuPwy0UGxZenS01Q-1; Fri,
 04 Jul 2025 11:01:05 -0400
X-MC-Unique: kCKFKPiuPwy0UGxZenS01Q-1
X-Mimecast-MFC-AGG-ID: kCKFKPiuPwy0UGxZenS01Q_1751641263
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65C811800366; Fri,  4 Jul 2025 15:01:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F4BD195608F; Fri,  4 Jul 2025 15:01:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B86F321E6A27; Fri, 04 Jul 2025 17:00:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>,  qemu-devel@nongnu.org,
 eperezma@redhat.com,  peterx@redhat.com,  mst@redhat.com,
 lvivier@redhat.com,  dtatulea@nvidia.com,  leiyang@redhat.com,
 parav@mellanox.com,  sgarzare@redhat.com,  lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com,  Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
In-Reply-To: <69bc738c-90fd-4a48-9bee-bb7372388810@oracle.com> (Jonah Palmer's
 message of "Wed, 2 Jul 2025 15:31:27 -0400")
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
 <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
 <87frgr7mvk.fsf@pond.sub.org>
 <dcbf9e2e-9442-4439-8593-dff036a4d781@oracle.com>
 <87o6v6muq4.fsf@pond.sub.org> <8734cimtqa.fsf@pond.sub.org>
 <1e58dd8c-3418-4843-9620-3819e9ee31f3@oracle.com>
 <87o6uau2lj.fsf@pond.sub.org>
 <69bc738c-90fd-4a48-9bee-bb7372388810@oracle.com>
Date: Fri, 04 Jul 2025 17:00:59 +0200
Message-ID: <87frfcj904.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Jonah Palmer <jonah.palmer@oracle.com> writes:

> On 6/26/25 8:08 AM, Markus Armbruster wrote:

[...]

> Apologies for the delay in getting back to you. I just wanted to be thoro=
ugh and answer everything as accurately and clearly as possible.
>
> ----
>
> Before these patches, pinning started in vhost_vdpa_dev_start(), where th=
e memory listener was registered, and began calling vhost_vdpa_listener_reg=
ion_add() to invoke the actual memory pinning. This happens after entering =
qemu_main_loop().
>
> After these patches, pinning started in vhost_dev_init() (specifically vh=
ost_vdpa_set_owner()), where the memory listener registration was moved to.=
 This happens *before* entering qemu_main_loop().
>
> However, the entirety of pinning doesn't all happen pre qemu_main_loop().=
 The pinning that happens before we enter qemu_main_loop() is the full gues=
t RAM pinning, which is the main, heavy lifting work when it comes to pinni=
ng memory.
>
> The rest of the pinning work happens after entering qemu_main_loop() (app=
roximately around the same timing as when pinning started before these patc=
hes). But, since we already did the heavy lifting of the pinning work pre q=
emu_main_loop() (e.g. all pages were already allocated and pinned), we're j=
ust re-pinning here (i.e. kernel just updates its IOTLB tables for pages th=
at're already mapped and locked in RAM).
>
> This makes the pinning work we do after entering qemu_main_loop() much fa=
ster than compared to the same pinning we had to do before these patches.
>
> However, we have to pay a cost for this. Because we do the heavy lifting =
work earlier pre qemu_main_loop(), we're pinning with cold memory. That is,=
 the guest hasn't yet touched its memory yet, all host pages are still anon=
ymous and unallocated. This essentially means that doing the pinning earlie=
r is more expensive time-wise given that we need to also allocate physical =
pages for each chunk of memory.
>
> To (hopefully) show this more clearly, I ran some tests before and after =
these patches and averaged the results. I used a 50G guest with real vDPA h=
ardware (Mellanox CX-6Dx):
>
> 0.) How many vhost_vdpa_listener_region_add() (pins) calls?
>
>                | Total | Before qemu_main_loop | After qemu_main_loop
> _____________________________________________________________________
> Before patches |   6   |         0             |         6
> ---------------|-----------------------------------------------------
> After patches  |   11  |         5	       |         6
>
> - After the patches, this looks like we doubled the work we're doing (giv=
en the extra 5 calls), however, the 6 calls that happen after entering qemu=
_main_loop() are essentially replays of the first 5 we did.
>
>  * In other words, after the patches, the 6 calls made after entering qem=
u_main_loop() are performed much faster than the same 6 calls before the pa=
tches.
>
>  * From my measurements, these are the timings it took to perform those 6=
 calls after entering qemu_main_loop():
>    > Before patches: 0.0770s
>    > After patches:  0.0065s
>
> ---
>
> 1.) Time from starting the guest to entering qemu_main_loop():
>  * Before patches: 0.112s
>  * After patches:  3.900s
>
> - This is due to the 5 early pins we're doing now with these patches, whe=
reas before we never did any pinning work at all.
>
> - From measuring the time between the first and last vhost_vdpa_listener_=
region_add() calls during this period, this comes out to ~3s for the early =
pinning.

So, total time increases: early pinning (before main loop) takes more
time than we save pinning (in the main loop).  Correct?

We want this trade, because the time spent in the main loop is a
problem: guest-visible downtime.  Correct?

[...]

>> Let's see whether I understand...  Please correct my mistakes.
>>=20
>> Memory pinning takes several seconds for large guests.
>>=20
>> Your patch makes pinning much slower.  You're theorizing this is because
>> pinning cold memory is slower than pinning warm memory.
>>=20
>> I suppose the extra time is saved elsewhere, i.e. the entire startup
>> time remains roughly the same.  Have you verified this experimentally?
>
> Based on my measurements that I did, we pay a ~3s increase in initializat=
ion time (pre qemu_main_loop()) to handle the heavy lifting of the memory p=
inning earlier for a vhost-vDPA device. This resulted in:
>
> * Faster memory pinning during qemu_main_loop() (0.0770s vs 0.0065s).
>
> * Shorter downtime phase during live migration (see below).
>
> * Slight increase in time for the device to be operational (e.g. guest se=
ts DRIVER_OK).
>   > This measured the start time of the guest to guest setting DRIVER_OK =
for the device:
>
>     Before patches: 22.46s
>     After patches:  23.40s
>
> The real timesaver here is the guest-visisble downtime during live migrat=
ion (when using a vhost-vDPA device). Since the heavy lifting of the memory=
 pinning is done during the initialization phase, it's no longer included a=
s part of the stop-and-copy phase, which results in a much shorter guest-vi=
sible downtime.
>
> From v5's CV:
>
> Using ConnectX-6 Dx (MLX5) NICs in vhost-vDPA mode with 8 queue-pairs,
> the series reduces guest-visible downtime during back-to-back live
> migrations by more than half:
> - 39G VM:   4.72s -> 2.09s (-2.63s, ~56% improvement)
> - 128G VM:  14.72s -> 5.83s (-8.89s, ~60% improvement)
>
> Essentially, we pay a slight increased startup time tax to buy ourselves =
a much shorter downtime window when we want to perform a live migration wit=
h a vhost-vDPA networking device.
>
>> Your stated reason for moving the pinning is moving it from within
>> migration downtime to before migration downtime.  I understand why
>> that's useful.
>>=20
>> You mentioned "a small drawback [...] a time in the initialization where
>> QEMU cannot respond to QMP".  Here's what I've been trying to figure out
>> about this drawback since the beginning:
>>=20
>> * Under what circumstances is QMP responsiveness affected?  I *guess*
>>   it's only when we start a guest with plenty of memory and a certain
>>   vhost-vdpa configuration.  What configuration exactly?
>>=20
>
> Regardless of these patches, as I understand it, QMP cannot actually run =
any command that requires the BQL while we're pinning memory (memory pinnin=
g needs to use the lock).
>
> However, the BQL is not held during the entirety of the pinning process. =
That is, it's periodically released throughout the entire pinning process. =
But those windows are *very* short and are only caught if you're really ham=
mering QMP with commands very rapidly.
>
> From a realistic point of view, it's more practical to think of QMP being=
 fully ready once all pinning has finished, e.g. time_spent_memory_pinning =
=E2=89=88 time_QMP_is_blocked.
>
> ---
>
> As I understand it, QMP is not fully ready and cannot service requests un=
til early on in qemu_main_loop().

It's a fair bit more complicated than that, but it'll do here.

> Given that these patches increase the time it takes to reach qemu_main_lo=
op() (due to the early pinning work), this means that QMP will also be dela=
yed for this time.
>
> I created a test that hammers QMP with commands until it's able to proper=
ly service the request and recorded how long it took from guest start to wh=
en it was able to fulfill the request:
>  * Before patches: 0.167s
>  * After patches:  4.080s
>
> This aligns with time measured to reach qemu_main_loop() and the time we'=
re spending doing the early memory pinning.
>
> All in all, the larger the amount of memory we need to pin, the longer it=
 will take for us to reach qemu_main_loop(), the larger time_spent_memory_p=
inning will be, and thus the longer it will take for QMP to be ready and fu=
lly functional.
>
> ----
>
> I don't believe this related to any specific vhost-vDPA configuration. I =
think bottom line is that if we're using a vhost-vDPA device, we'll be spen=
ding more time to reach qemu_main_loop(), so QMP has to wait until we get t=
here.

Let me circle back to my question: Under what circumstances is QMP
responsiveness affected?

The answer seems to be "only when we're using a vhost-vDPA device".
Correct?

We're using one exactly when QEMU is running with one of its
vhost-vdpa-device-pci* device models.  Correct?

>> * How is QMP responsiveness affected?  Delay until the QMP greeting is
>>   sent?  Delay until the first command gets processed?  Delay at some
>>   later time?
>>=20
>
> Responsiveness: Longer initial delay due to early pinning work we need to=
 do before we can bring QMP up.
>
> Greeting delay: No greeting delay. Greeting is flushed earlier, even befo=
re we start the early pinning work.
>
> * For both before and after the patches, this was ~0.052s for me.
>
> Delay until first command processed: Longer initial delay at startup.
>
> Delay at later time: None.

Got it.

>> * What's the absolute and the relative time of QMP non-responsiveness?
>>   0.2s were mentioned.  I'm looking for something like "when we're not
>>   pinning, it takes 0.8s until the first QMP command is processed, and
>>   when we are, it takes 1.0s".
>>=20
>
> The numbers below are based on my recent testing and measurements. This w=
as with a 50G guest with real vDPA hardware.
>
> Before patches:
> ---------------
> * From the start time of the guest to the earliest time QMP is able to pr=
ocess a request (e.g. query-status): 0.167s.
>   > This timing is pretty much the same regardless of whether or not we'r=
e pinning memory.
>
> * Time spent pinning memory (QMP cannot handle requests during this windo=
w): 0.077s.
>
> After patches:
> --------------
> * From the start time of the guest to the earliest time QMP is able to pr=
ocess a request (e.g. query-status): 4.08s
>   > If we're not early pinning memory, it's ~0.167s.
>
> * Time spent pinning memory *after entering qemu_main_loop()* (QMP cannot=
 handle requests during this window): 0.0065s.

Let me recap:

* No change at all unless we're pinning memory early, and we're doing
  that only when we're using a vhost-vDPA device.  Correct?

* If we are using a vhost-vDPA device:

  - Total startup time (until we're done pinning) increases.

  - QMP becomes available later.

  - Main loop behavior improves: less guest-visible downtime, QMP more
    responsive (once it's available)

  This is a tradeoff we want always.  There is no need to let users pick
  "faster startup, worse main loop behavior."

Correct?

[...]


