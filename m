Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587ABC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 06:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSru2-00027U-DQ; Sat, 21 Jun 2025 02:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uSrty-00026m-ON
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 02:40:35 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uSrtr-0004ya-Ri
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 02:40:30 -0400
Received: from [192.168.201.189]
 (210-129-16-52.radian.jp-east.compute.idcfcloud.net [210.129.16.52])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 55L6dxHY023048
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 21 Jun 2025 15:40:00 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=sQ5HBubaVzS9alROnnwYulVopNaYIRZAwYAFvpmKye4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1750488001; v=1;
 b=rEPtcr4YMWhKjRdhXqTPGJUTt89EcmxdxsNLnN8LZHS1Cwk5DpW2JTOjwGvdRJ5g
 gKVs6LSiphxd0iCDSHzqy46saNGzrPcIRPhzQBxAoNLu78/VYYfxQkGmMq52SZXH
 Akee09nRbaTsMaNLR0m3xMTRai27xaJaWeoYzNu6l6QzahFxec6pSVbomGs66ZxB
 YWOO3eo8QJCqdBOIiyJhCw9LP+J+IEnDnw386LBYTNgZhkQM6zrA8Ts20T553f0R
 tKRH6ekt1ttscZw5xTB+I/CwtriI76laljlAkIjCFpPTSTujCj9yimJ7kgumPwKd
 Njhgu71eWWdwzIIxZ6ny4w==
Message-ID: <5f60626f-3f11-4f2e-9c82-4c356b7b4bd5@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 21 Jun 2025 15:39:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/16] virtio: introduce support for GSO over UDP
 tunnel
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <29808015-f8b3-4e18-8d1d-5280bda4ee3d@daynix.com>
 <5a4579c4-2569-4642-99a2-23ae29aa80c6@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5a4579c4-2569-4642-99a2-23ae29aa80c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/05/23 18:43, Paolo Abeni wrote:
> On 5/23/25 9:19 AM, Akihiko Odaki wrote:
>> On 2025/05/21 20:33, Paolo Abeni wrote:
>>> Some virtualized deployments use UDP tunnel pervasively and are impacted
>>> negatively by the lack of GSO support for such kind of traffic in the
>>> virtual NIC driver.
>>>
>>> The virtio_net specification recently introduced support for GSO over
>>> UDP tunnel, this series updates the virtio implementation to support
>>> such a feature.
>>>
>>> One of the reasons for the RFC tag is that the kernel-side
>>> implementation has just been shared upstream and is not merged yet, but
>>> there are also other relevant reasons, see below.
>>>
>>> Currently, the kernel virtio support limits the feature space to 64 bits,
>>> while the virtio specification allows for a larger number of features.
>>> Specifically, the GSO-over-UDP-tunnel-related virtio features use bits
>>> 65-69; the larger part of this series (patches 2-11) actually deals with
>>> the extended feature space.
>>>
>>> I tried to minimize the otherwise very large code churn by limiting the
>>> extended features support to arches with native 128 integer support and
>>> introducing the extended features space support only in virtio/vhost
>>> core and in the relevant device driver.
>>
>> What about adding another 64-bit integer to hold the high bits? It makes
>> adding the 128-bit integer type to VMState and properties and
>> CONFIG_INT128 checks unnecessary.
> 
> I did a few others implementation attempts before the current one. The
> closes to the above proposal I tried was to implement virtio_features_t
> as fixed size array of u64.
> 
> A problem a found with that approach is that it requires a very large
> code churn, as ~ every line touching a feature related variable should
> be modified.
> 
> Let me think a little bit on this other option (I hope to avoid
> discarding a lot of work here).
> 
>>> The actual offload implementation is in patches 12-16 and boils down to
>>> propagating the new offload to the tun devices and the vhost backend.
>>>
>>> Tested with basic stream transfer with all the possible permutations of
>>> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support
>>> and vs snapshots creation and restore.
>>>
>>> Notably this does not include (yet) any additional tests. Some guidance
>>> on such matter would be really appreciated, and any feedback about the
>>> features extension strategy would be more than welcome!
>>
>> My proposal to add a feature to tap devices[1] simply omitted tests and
>> I wrote simple testing scripts for my personal usage. As you can see,
>> there is no testing code that covers tap devices, unfortunately, and I
>> think adding one takes significant effort.
>>
>> [1] https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/
> 
> Thanks for the pointer

By the way, I did write selftests for the kernel-side change, which you 
can find at:
https://lore.kernel.org/r/20250530-rss-v12-0-95d8b348de91@daynix.com/

Perhaps you may be able to steal and tweak it for the UDP tunnel feature.

Regards,
Akihiko Odaki

