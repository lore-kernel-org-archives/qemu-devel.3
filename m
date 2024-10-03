Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C78CCF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 20:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swSXE-0001Zq-O8; Thu, 03 Oct 2024 16:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1swSXD-0001Zh-F8
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:34:51 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1swSXA-00032o-Mv
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:34:51 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1swSWw-00000000Et8-1I60; Thu, 03 Oct 2024 22:34:34 +0200
Message-ID: <6240036b-f8b8-4592-8f80-21ee6d3eaa1e@maciej.szmigiero.name>
Date: Thu, 3 Oct 2024 22:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <ZuyTjQJujZo6tw9p@x1n>
 <bbed8165-de5c-4ebe-a6cc-ff33f9ea363a@maciej.szmigiero.name>
 <Zu2mvrKOvmD1WtvD@x1n>
 <848ba96d-c3ca-4fbb-9ec4-92023230c026@maciej.szmigiero.name>
 <ZvYCGFnI_68B_w3h@x1n>
 <c013f26f-6e55-4426-9ec9-e160e8179a7a@maciej.szmigiero.name>
 <ZvsesAPD6G4Ef9m0@x1n>
 <927023c9-c8ba-4cdf-9d42-bf1109a139af@maciej.szmigiero.name>
 <ZvxqE0i5qGGiSFk0@x1n>
 <cba181bd-0961-4ea8-962b-2f6bbf09d94a@maciej.szmigiero.name>
 <Zv26LE_2YIjKk4FL@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Zv26LE_2YIjKk4FL@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2.10.2024 23:25, Peter Xu wrote:
> On Wed, Oct 02, 2024 at 10:11:33PM +0200, Maciej S. Szmigiero wrote:
>> On 1.10.2024 23:30, Peter Xu wrote:
>>> On Tue, Oct 01, 2024 at 10:41:14PM +0200, Maciej S. Szmigiero wrote:
>>>> On 30.09.2024 23:57, Peter Xu wrote:
>>>>> On Mon, Sep 30, 2024 at 09:25:54PM +0200, Maciej S. Szmigiero wrote:
>>>>>> On 27.09.2024 02:53, Peter Xu wrote:
>>>>>>> On Fri, Sep 27, 2024 at 12:34:31AM +0200, Maciej S. Szmigiero wrote:
>>>>>>>> On 20.09.2024 18:45, Peter Xu wrote:
>>>>>>>>> On Fri, Sep 20, 2024 at 05:23:08PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>>>> On 19.09.2024 23:11, Peter Xu wrote:
>>>>>>>>>>> On Thu, Sep 19, 2024 at 09:49:10PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>>>>>> On 9.09.2024 22:03, Peter Xu wrote:
>>>>>>>>>>>>> On Tue, Aug 27, 2024 at 07:54:27PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> load_finish SaveVMHandler allows migration code to poll whether
>>>>>>>>>>>>>> a device-specific asynchronous device state loading operation had finished.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> In order to avoid calling this handler needlessly the device is supposed
>>>>>>>>>>>>>> to notify the migration code of its possible readiness via a call to
>>>>>>>>>>>>>> qemu_loadvm_load_finish_ready_broadcast() while holding
>>>>>>>>>>>>>> qemu_loadvm_load_finish_ready_lock.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>>>>>>>>>>> ---
(..)
>> As I wrote above, the kernel side of things are being taken care of by
>> the mlx5 driver maintainers.
>>
>> And these performance numbers suggest that there isn't some global lock
>> serializing all device accesses as otherwise it would quickly become
>> the bottleneck and we would be seeing diminishing improvement from
>> increased VF count instead of increased improvement.
> 
> Personally I am not satisfied with scaling with these numbers..
> 
>    1VF       2VFs      4VFs
>    274 ms -> 434 ms -> 1068 ms
> 
> The lock doesn't need to be as stupid as a global lock that all ioctl()s
> take and it might not be as obvious that we can easily see.  It can hide
> internally, it can be not in the form of a lock at all.
> 
> 1068 is almost 4x of 274 here, that's really not scalable at all even if it
> is improvement for sure..  I still feel like something is off.  If you
> think kernel isn't the bottleneck, I am actually more curious on why,
> especially if that could be relevant to the qemu design.
> 

These are 4 VFs of a single PF NIC, so it's not only kernel driver
involved here but also the whole physical device itself.

Without the userspace/QEMU side being parallelized it was hard to even
measure the driver/device-side bottlenecks.

However, even with the current state of things we still get a nice 67%
improvement in downtime.

As I wrote yesterday, AFAIK it is a WIP also on the mlx5/device side of
things.

(..)
>>>>>>
>>>>>>>       - How qemu_loadvm_load_finish_ready_broadcast() interacts with all
>>>>>>>         above..
>>>>>>>
>>>>>>> So if you really think it matters to load whatever VFIO device who's
>>>>>>> iterable data is ready first, then let's try come up with some better
>>>>>>> interface..  I can try to think about it too, but please answer me
>>>>>>> questions above so I can understand what I am missing on why that's
>>>>>>> important.  Numbers could help, even if 4 VF and I wonder how much diff
>>>>>>> there can be.  Mostly, I don't know why it's slow right now if it is; I
>>>>>>> thought it should be pretty fast, at least not a concern in VFIO migration
>>>>>>> world (which can take seconds of downtime or more..).
>>>>>>>
>>>>>>> IOW, it sounds more reasonalbe to me that no matter whether vfio will
>>>>>>> support multifd, it'll be nice we stick with vfio_load_state() /
>>>>>>> vfio_save_state() for config space, and hopefully it's also easier it
>>>>>>> always go via the main channel to everyone.  In these two hooks, VFIO can
>>>>>>> do whatever it wants to sync with other things (on src, sync with
>>>>>>> concurrent thread pool saving iterable data and dumping things to multifd
>>>>>>> channels; on dst, sync with multifd concurrent loads). I think it can
>>>>>>> remove the requirement on the load_finish() interface completely.  Yes,
>>>>>>> this can only load VFIO's pci config space one by one, but I think this is
>>>>>>> much simpler, and I hope it's also not that slow, but I'm not sure.
>>>>>>
>>>>>> To be clear, I made a following diagram describing how the patch set
>>>>>> is supposed to work right now, including changing per-device
>>>>>> VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE into a common MIG_CMD_SWITCHOVER.
>>>>>>
>>>>>> Time flows on it left to right (->).
>>>>>>
>>>>>> ----------- DIAGRAM START -----------
>>>>>> Source overall flow:
>>>>>> Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable                                                                          -> non iterable
>>>>>> Multifd channels:                                       \ multifd device state read and queue (1) -> multifd config data read and queue (1) /
>>>>>>
>>>>>> Target overall flow:
>>>>>> Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable -> non iterable -> config data load operations
>>>>>> Multifd channels:                                       \ multifd device state (1) -> multifd config data read (1)
>>>>>>
>>>>>> Target config data load operations flow:
>>>>>> multifd config data read (1) -> config data load (2)
>>>>>>
>>>>>> Notes:
>>>>>> (1): per device threads running in parallel
>>>>>
>>>>> Here I raised this question before, but I'll ask again: do you think we can
>>>>> avoid using a separate thread on dest qemu, but reuse multifd recv threads?
>>>>>
>>>>> Src probably needs its own threads because multifd sender threads takes
>>>>> request, so it can't block on its own.
>>>>>
>>>>> However dest qemu isn't like that, it's packet driven so I think maybe it's
>>>>> ok VFIO directly loads the data in the multifd threads.  We may want to
>>>>> have enough multifd threads to make sure IO still don't block much on the
>>>>> NIC, but I think tuning the num of multifd threads should work in this
>>>>> case.
>>>>
>>>> We need to have the receiving threads decoupled from the VFIO device state
>>>> loading threads at least because otherwise:
>>>> 1) You can have a deadlock if device state for multiple devices arrives
>>>> out of order, like here:
>>>>
>>>> Time flows left to right (->).
>>>> Multifd channel 1: (VFIO device 1 buffer 2) (VFIO device 2 buffer 1)
>>>> Multifd channel 2: (VFIO device 2 buffer 2) (VFIO device 1 buffer 1)
>>>>
>>>> Both channel receive/load threads would be stuck forever in this case,
>>>> since they can't load buffer 2 for devices 1 and 2 until they load
>>>> buffer 1 for each of these devices.
>>>>
>>>> 2) If devices are loading buffers at different speeds you don't want
>>>> to block the faster device from receiving new buffer just because
>>>> the slower one hasn't finished its loading yet.
>>>
>>> I don't see why it can't be avoided.  Let me draw this in columns.
>>>
>>> How I picture this is:
>>>
>>>      multifd recv thread 1                     multifd recv thread 2
>>>      ---------------------                     ---------------------
>>>      recv VFIO device 1 buffer 2             recv VFIO device 2 buffer 2
>>>       -> found that (dev1, buf1) missing,      -> found that (dev2, buf1) missing,
>>>          skip load                                skip load
>>>      recv VFIO device 2 buffer 1             recv VFIO device 1 buffer 1
>>>       -> found that (dev2, buf1+buf2) ready,   -> found that (dev1, buf1+buf2) ready,
>>>          load buf1+2 for dev2 here                load buf1+2 for dev1 here
>>> Here right after one multifd thread recvs a buffer, it needs to be injected
>>> into the cache array (with proper locking), so that whoever receives a full
>>> series of those buffers will do the load (again, with proper locking..).
>>>
>>> Would this not work?
>>>
>>
>> For sure but that's definitely more complicated logic than just having
>> a simple device loading thread that naturally loads incoming buffers
>> for that device in-order.
> 
> I thought it was mostly your logic that was implemented, but yeah I didn't
> check too much details on VFIO side.
> 
>> That thread isn't even in the purview of the migration code since
>> it's a VFIO driver internal implementation detail.
>>
>> And we'd still lose parallelism if it happens that two buffers that
>> are to be loaded next for two devices happen to arrive in the same
>> multifd channel:
>> Multifd channel 1: (VFIO device 1 buffer 1) (VFIO device 2 buffer 1)
>> Multifd channel 2: (VFIO device 2 buffer 2) (VFIO device 1 buffer 2)
>>
>> Now device 2 buffer 1 has to wait until loading device 1 buffer 1
>> finishes even thought with the decoupled loading thread implementation
>> from this patch set these would be loaded in parallel.
> 
> Well it's possible indeed, but with normally 8 or more threads being there,
> possibility of having such dependency is low.
> 
> Cedric has similar comment on starting from simple on the thread model.
> I'd still suggest if ever possible we try reuse multifd recv threads; I do
> expect the results should be similar.
> 
> I am sorry to ask for this, Fabiano already blames me for this, but..
> logically it'll be best we use no new thread in the series, then one patch
> on top with your new thread solution to justify its performance benefits
> and worthwhile to having those threads at all.

To be clear, these loading threads are mostly blocking I/O threads, NOT
compute threads.
This means that the usual "rule of thumb" that the count of threads should
not exceed the total number of logical CPUs does NOT apply to them.

They are similar to what glibc uses under the hood to simulate POSIX AIO
(aio_read(), aio_write()), to implement an async DNS resolver (getaddrinfo_a())
and what Glib's GIO uses to simulate its own async file operations.
Using helper threads for turning blocking I/O into "AIO" is a pretty common
thing.

To show that these loading threads mostly spend their time sleeping (waiting
for I/O) I made a quick patch at [1] tracing how much time they spend waiting
for incoming buffers and how much time they spend waiting for these buffers
to be loaded into the device.

The results (without patch [2] described later) are like this:
> 5919@1727974993.403280:vfio_load_state_device_buffer_start  (0000:af:00.2)
> 5921@1727974993.407932:vfio_load_state_device_buffer_start  (0000:af:00.4)
> 5922@1727974993.407964:vfio_load_state_device_buffer_start  (0000:af:00.5)
> 5920@1727974993.408480:vfio_load_state_device_buffer_start  (0000:af:00.3)
> 5920@1727974993.666843:vfio_load_state_device_buffer_end  (0000:af:00.3) wait 43 ms load 217 ms
> 5921@1727974993.686005:vfio_load_state_device_buffer_end  (0000:af:00.4) wait 75 ms load 206 ms
> 5919@1727974993.686054:vfio_load_state_device_buffer_end  (0000:af:00.2) wait 69 ms load 210 ms
> 5922@1727974993.689919:vfio_load_state_device_buffer_end  (0000:af:00.5) wait 79 ms load 204 ms

Summing up:
0000:af:00.2 total loading time 283 ms, wait 69 ms load 210 ms
0000:af:00.3 total loading time 258 ms, wait 43 ms load 217 ms
0000:af:00.4 total loading time 278 ms, wait 75 ms load 206 ms
0000:af:00.5 total loading time 282 ms, wait 79 ms load 204 ms

In other words, these threads spend ~100% of their total runtime waiting
for I/O, 70%-75% of that time waiting for buffers to get loaded into their
target device.

So having more threads here won't negatively affect the host CPU
consumption since these threads barely use the host CPU at all.
Also, their count is capped at the number of VFIO devices in the VM.

I also did a quick test with the same config as usual: 4 VFs, 6 multifd
channels, but with patch at [2] simulating forced coupling of loading
threads to multifd receive channel threads.

With this patch load_state_buffer() handler will return to the multifd
channel thread only when the loading thread finishes loading available
buffers and is about to wait for the next buffers to arrive - just as
loading buffers directly from these channel threads would do.

The resulting lowest downtime from 115 live migration runs was 1295ms -
that's 21% worse than 1068ms of downtime with these loading threads running
on their own.

I expect that this performance penalty to get even worse with more VFs
than 4.

So no, we can't load buffers directly from multifd channel receive threads.

> PS: I'd suggest if you really need those threads it should still be managed
> by migration framework like the src thread pool.  Sorry I'm pretty stubborn
> on this, especially after I notice we have query-migrationthreads API just
> recently.. even if now I'm not sure whether we should remove that API.  I
> assume that shouldn't need much change, even if necessary.

I can certainly make these loading threads managed in a thread pool if that's
easier for you.

> Thanks,
> 

Thanks,
Maciej

[1]: https://github.com/maciejsszmigiero/qemu/commit/b0833053359715c604070f64fc058f90ec61d180
[2]: https://github.com/maciejsszmigiero/qemu/commit/0c9b4072eaebf8e7bd9560dd27a14cd048097565


