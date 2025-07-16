Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325A7C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0xC-0005mG-Tz; Wed, 16 Jul 2025 08:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0s5-0001tl-CL
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:04:35 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0s3-0001fd-6d
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:04:25 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56GC480g035139
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 16 Jul 2025 21:04:08 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vMV67TVLAh3aCny89PBJAPim2yFAca+LdlfBZ2bhUvI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752667448; v=1;
 b=q9/jU5K/AJKxDpShYA+GUsf7UIpPq8vsDrIu1VnB8/AuFbuvvdWkSple68lsErGZ
 PRMH3kxNZM+bMNXqcuTsx+OzvKpkdQUtB+TCJbeYwEBgIJKMukF7oCBXzYj6YG43
 /EnflSpubosv/A5ZXtVVdfxwrEbXo6cdu7ZEczE/TzPkYhL+qBL6cTLGHgHGjkJQ
 OhV09zIzyBxXSkQ9oCj7K7FTeNhOfUn/E1lK6A56e/LdvyUBN/aMdVHH/kkZgtlt
 NoEEtJbjbC8CRuM7hFPxYtYssj/HuU1lFvaXBOCU4taO+aK++q06upsR6jc/FzeZ
 puwKZchHaO1JlF0Jp2mXEw==
Message-ID: <dc6a7170-3a36-4b9b-b5fe-f05564100049@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 16 Jul 2025 21:04:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 13/13] net: implement UDP tunnel features offloading
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
 <509e49207e4dc4a10ef36492a2ee1f90f3c2c237.1752229731.git.pabeni@redhat.com>
 <f266ffe9-f601-46cc-85be-515475cbfe12@rsg.ci.i.u-tokyo.ac.jp>
 <1d582df4-2995-423c-8b6c-351beaf94139@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <1d582df4-2995-423c-8b6c-351beaf94139@redhat.com>
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

On 2025/07/16 19:13, Paolo Abeni wrote:
> On 7/15/25 10:07 AM, Akihiko Odaki wrote:
>> On 2025/07/11 22:02, Paolo Abeni wrote:
>>> When any host or guest GSO over UDP tunnel offload is enabled the
>>> virtio net header includes the additional tunnel-related fields,
>>> update the size accordingly.
>>>
>>> Push the GSO over UDP tunnel offloads all the way down to the tap
>>> device extending the newly introduced NetFeatures struct, and
>>> eventually enable the associated features.
>>>
>>> As per virtio specification, to convert features bit to offload bit,
>>> map the extended features into the reserved range.
>>>
>>> Finally, make the vhost backend aware of the exact header layout, to
>>> copy it correctly. The tunnel-related field are present if either
>>> the guest or the host negotiated any UDP tunnel related feature:
>>> add them to host kernel supported features list, to allow qemu
>>> transfer to such backend the needed information.
>>
>> Please also update: hw/virtio/virtio-qmp.c
> 
> Do you mean by adding FEATURE_ENTRY() for
> {GUEST,HOST}_UDP_TUNNEL_GSO{,_CSUM} ?

Yes.

> 
> Such entries are added in patch 8/13 "qmp: update virtio features map to
> support extended features". Even if the features are not supported yet
> in such patch, I think the code could already parse their name.
> 
> Do you prefer I move the features entry definition here?

No, I missed what patch 8/13 did. There is no change needed here.

Regards,
Akihiko Odaki

