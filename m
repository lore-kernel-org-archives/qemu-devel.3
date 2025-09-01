Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E10CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4ax-0005Is-A7; Mon, 01 Sep 2025 09:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ut4aN-00053w-Um; Mon, 01 Sep 2025 09:28:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ut4aG-0001Yd-Tg; Mon, 01 Sep 2025 09:28:39 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 581DRHjO077628
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Sep 2025 22:27:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=hYOYKXMT+9NN1Mp5XIgVZVN9s2bnkJKcPL4oOuaWXog=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756733238; v=1;
 b=DqLp99J9HngRFLonQKOELQaZRBhcUNzpKPAj/eliyE2d0bNEXNgSfzqMksQ/ZMgg
 mzXknxD5mT8uF+e6nxlWeZ+GzTrh6xtSUcvKrILBfUkwYn+ehKWAeOWmqXm25U1K
 +D2rV6IH6JeZ3W5BtneVc7Vwk20qFGob0AWywvV3p53BN3k0mqDBZpXYMOqcaTM6
 alN4qIt+Sez/Fau2YiH/2NUkWG2sj37rFs5fGAFWnmVhQw0bPwaXVs4X9i5HLWWr
 k+9byw/kR2wk0JQcW9d1qYxsznpFYrGD9VQe3g/l0LfnAmAo6ysXGkk6jkDmf1TH
 uC3892L1csZQhBnH5R48tg==
Message-ID: <a46467e0-4984-489a-945a-b1049d1e31c2@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 1 Sep 2025 22:27:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] memory: Stop piggybacking on memory region owners
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA89xRp51q2T4M3R=pOuHcGE9zJCGDpbXOz4cBhxrcU00Q@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAFEAcA89xRp51q2T4M3R=pOuHcGE9zJCGDpbXOz4cBhxrcU00Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/09/01 21:35, Peter Maydell wrote:
> On Mon, 1 Sept 2025 at 07:11, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> Supersedes: https://lore.kernel.org/qemu-devel/20250828-san-v9-0-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp/
>> ("[PATCH v9 0/2] Fix check-qtest-ppc64 sanitizer errors")
>>
>> MemoryRegions used to "piggyback" on their owners instead of using their
>> reference counters due to the circular dependencies between them, which
>> caused memory leak.
>>
>> I tried to fix it with "[PATCH v9 0/2] Fix check-qtest-ppc64 sanitizer
>> errors" but it resulted in a lengthy discussion; ultimately it is
>> attributed to the fact that "piggybacking" is hard to understand and
>> forces us design trade-offs. It was also insufficient because it only
>> deals with the container-subregion pattern and did not deal with DMA.
> 
> Unlike Peter Xu's proposed patch and your v9 patch you reference
> above, with this series I still see leaks doing a 'make check'
> on an ASAN build of the Arm targets. Here's a sample leak
> detected during the device-introspect-test:
> 
> ==3769612==ERROR: LeakSanitizer: detected memory leaks
> 
> Too many leaks! Only the first 5000 leaks encountered will be reported.
> Direct leak of 120 byte(s) in 8 object(s) allocated from:
>      #0 0x61e094196de3 in malloc
> (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f2de3)
> (BuildId: 9b33a0e2d440e084929ae6a2821eacb977772688)
>      #1 0x79c9d0e06b09 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId:
> 1eb6131419edb83b2178b682829a6913cf682d75)
>      #2 0x79c9d0e1c4d8 in g_strdup
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x784d8) (BuildId:
> 1eb6131419edb83b2178b682829a6913cf682d75)
>      #3 0x61e0958b6749 in g_strdup_inline
> /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
>      #4 0x61e0958b6749 in memory_region_do_init
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../system/memory.c:1224:16
>      #5 0x61e0958b6551 in memory_region_init
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../system/memory.c:1250:5
>      #6 0x61e0958bc097 in memory_region_init_io
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../system/memory.c:1568:5
>      #7 0x61e09494b6d0 in stm32l4x5_gpio_init
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/gpio/stm32l4x5_gpio.c:402:5
>      #8 0x61e096a36371 in object_init_with_type
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:428:9
>      #9 0x61e096a1d8db in object_initialize_with_type
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:570:5
>      #10 0x61e096a1d220 in object_initialize
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:578:5
>      #11 0x61e096a1dbdc in object_initialize_child_with_propsv
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:608:5
>      #12 0x61e096a1dab7 in object_initialize_child_with_props
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:591:10
>      #13 0x61e096a1e607 in object_initialize_child_internal
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:645:5
>      #14 0x61e0962c7f9a in stm32l4x5_soc_initfn
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/stm32l4x5_soc.c:150:9
>      #15 0x61e096a36371 in object_init_with_type
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:428:9
>      #16 0x61e096a36242 in object_init_with_type
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:424:9
>      #17 0x61e096a1d8db in object_initialize_with_type
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:570:5
>      #18 0x61e096a1f1fd in object_new_with_type
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:774:5
>      #19 0x61e096a1efc9 in object_new_with_class
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:782:12
>      #20 0x61e09709cec5 in qmp_device_list_properties
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/qom-qmp-cmds.c:206:11
>      #21 0x61e09594492c in qdev_device_help
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../system/qdev-monitor.c:313:17
>      #22 0x61e09594ac2c in hmp_device_add
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../system/qdev-monitor.c:989:9
>      #23 0x61e095b17b2d in handle_hmp_command_exec
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../monitor/hmp.c:1106:9
>      #24 0x61e095b12035 in handle_hmp_command
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../monitor/hmp.c:1158:9
>      #25 0x61e095b2549d in qmp_human_monitor_command
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../monitor/qmp-cmds.c:179:5
>      #26 0x61e09720c44a in qmp_marshal_human_monitor_command
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qapi/qapi-commands-misc.c:347:14
>      #27 0x61e0973140f1 in do_qmp_dispatch_bh
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qmp-dispatch.c:128:5
>      #28 0x61e0973f01ad in aio_bh_call
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/async.c:172:5
>      #29 0x61e0973f0ee6 in aio_bh_poll
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/async.c:219:13
>      #30 0x61e09735c8b8 in aio_dispatch
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/aio-posix.c:436:5
> 
> (there are many more after this one)

This approach is clearly not working. The problem here is that there are 
devices that never get realized (so never get unrealized either).

I'm thinking of a solution that fixes all possible circular references 
originated from owners without breaking anything else, but I don't have 
one for now.

Regards,
Akihiko Odaki

