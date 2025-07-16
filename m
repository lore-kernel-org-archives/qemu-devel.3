Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672C7C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 11:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0Xo-0004dv-BH; Wed, 16 Jul 2025 07:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0OL-0005u3-KT
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:33:42 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0OA-0003bc-Og
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:33:40 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56GBWqxB026035
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 16 Jul 2025 20:32:52 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ICTS1Ps0EN4b96NtX6XGLQlHBYf4LG/YqpIJ5KhSIUo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752665572; v=1;
 b=mZKsqwvN1S8meHTxAObOEVF3Zxy+Szlfym3D07WhtRGxYD10NZwmjTb2U8JJJClF
 2V2fjZdZgydkpgrefVKcEjybs1JiBVJ/fdBb6NKVZ3qhxV0f7CE4xUtCDQfwLoeD
 EGKwiWvH3+w/yA9eK1skzXaOq4pFIbU1D5lEgyWVdKpEUjEi+qWs93O1/Pj/9b8f
 v71cuBQiqLCNryi3LF1Wb5EPRWEHARzg0HS5j+wwBOEJrXLU4nE+2ZGaXaHeTFXt
 TO2N7wJvTtRugyYX6yWDjZu0v4IrZ5FILnQEw8IWxxYHxfU89N3NBTPuOgx2lNyy
 B0givpv91oc52nHeu1C1Vg==
Message-ID: <f2674001-9489-44c9-b17a-c9d8a66b3935@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 16 Jul 2025 20:32:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/13] net: bundle all offloads in a single struct
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <6e85b684df9f953f04b10c75288e2d4065af49a2.1752229731.git.pabeni@redhat.com>
 <d434b098-aebc-42cb-b589-d84f7bd78c21@rsg.ci.i.u-tokyo.ac.jp>
 <bbf7744c-9340-4d59-804b-87f7ff9bdcc4@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <bbf7744c-9340-4d59-804b-87f7ff9bdcc4@redhat.com>
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

On 2025/07/15 23:52, Paolo Abeni wrote:
> On 7/15/25 8:36 AM, Akihiko Odaki wrote:
>> On 2025/07/11 22:02, Paolo Abeni wrote:
>>> The set_offload() argument list is already pretty long and
>>> we are going to introduce soon a bunch of additional offloads.
>>>
>>> Replace the offload arguments with a single struct and update
>>> all the relevant call-sites.
>>>
>>> No functional changes intended.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> Note: I maintained  the struct usage as opposed to uint64_t bitmask usage
>>> as suggested by Akihiko, because the latter feel a bit more invasive.
>>
>> I think a bitmask will be invasive to the same extent with the current
>> version; most part of this change comes from the parameter passing,
>> which does not depend on the representation of the parameter.
> 
> Do you have strong feeling WRT the bitmask usage?
> 
> Another argument vs the bitmask usage is that it will requires some
> extra input validation of the selected offload bits (most of them don't
> make sense in this context).

I don't think such a validation is necessary.

There is practically no chance to have a wrong bit set by mistake when 
callers specify bits with macros prefixed with VIRTIO_NET_O_GUEST_. 
There will be a compilation error if the caller specify a offload bit 
that doesn't exist.

It is also obvious if a caller specified something unrelated (i.e., not 
prefixed with VIRTIO_NET_O_GUEST_). A real downside here would be that 
we will need to type VIRTIO_NET_O_GUEST_ each time referring an offload 
bit; such a redundancy does not exist with struct because the type 
system knows the bits bound to the type.

That said, 1) I prefer bitmasks much over struct though 2) I will be in 
favor of merging this series if everything else gets sorted out while 
the struct remains.

I'll explain the reason for 1) first:

There are both a downside and an upside with bitmasks. The downside is 
the redundancy of syntax, which I have just pointed out. The upside is 
the consistency with virtio's offload configuration, which defines the 
functionality of set_offload().

I consider the following two factors in such a trade-off scenario:
a) The balance between the downside and upside
b) Prior examples in the code base

Regarding a), I think the upside outweighs the downside but its extent 
is small.

b) matters more for this particular case; there are bunch of examples 
that use bitmasks in "include", excluding "include/hw" but there are 
none of structs that are dedicated for bools. Consistency matters for a 
big code base like QEMU so I want a good reason when making an exception.

The reasoning behind 2) is that having this patch is still better than 
the status quo.

Regards,
Akihiko Odaki

