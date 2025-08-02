Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08C1C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 09:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui8lz-0006yI-QO; Sat, 02 Aug 2025 05:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ui8lr-0006su-HZ; Sat, 02 Aug 2025 05:43:21 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ui8lo-0000Bb-GR; Sat, 02 Aug 2025 05:43:19 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5729fDB0031085
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 2 Aug 2025 18:41:13 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ovuEvXGyQDw3EIAnC2OBfPaHMeg92Ny3eDfRpSilftM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754127673; v=1;
 b=gLYSRyKDh7uJqUJcPRnC6ewOzIE2Lskd+6h1ChpWAeUAIv92qs8hV8ZAvaQFYFTQ
 i8GOTzKT5RQN5CFGKVlSyWEB01fRUG2s6JbCaM28C1O2yk7elC+Cn9I+JlUbslsY
 Iw+uqkNUP453c+pgs7InQk9Z/3rA35V5yUXQAHw0h2HE9qXzuZvFPv/VQOA49s1C
 b0MSy6GpTJxdy6xIoYgo0fuF5oEPQUvwdJ/9h87vshPA7b2glH5GxUlowuY15TZs
 n6awUJG2EdJLn9GUx5y95zE6zgb2lam4d34LdgeiL+OHgnFBJwzk7hDS2B2fs9Lq
 crHqg0NhEiiCu7Tttk0QwQ==
Message-ID: <91aec5d7-7647-41d1-ae12-c86020be4537@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 2 Aug 2025 18:41:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio-net: Fix VLAN filter table reset timing
To: Michael Tokarev <mjt@tls.msk.ru>, Konstantin Shkolnyy
 <kshk@linux.ibm.com>, qemu-devel@nongnu.org
Cc: yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com,
 jasowang@redhat.com, virtualization@lists.linux.dev,
 qemu-stable@nongnu.org, Lei Yang <leiyang@redhat.com>
References: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
 <7b657acb-7186-42bf-9be5-8c1253c6316c@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7b657acb-7186-42bf-9be5-8c1253c6316c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/08/02 16:26, Michael Tokarev wrote:
> On 27.07.2025 09:22, Akihiko Odaki wrote:
> ...
>> @@ -3942,6 +3943,7 @@ static void 
>> virtio_net_device_realize(DeviceState *dev, Error **errp)
>>       n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
>>       n->vlans = g_malloc0(MAX_VLAN >> 3);
>> +    memset(n->vlans, 0xff, MAX_VLAN >> 3);
> 
> A nitpick: we don't need to init this memory with 0 before
> initing it with 0xff.
> 
> But looking at this, why can't we embed n->vlans directly into
> this structure, something like the attached patch?

VMState also needs a change: VMSTATE_BUFFER_POINTER_UNSAFE() should be 
replaced with plain VMSTATE_BUFFER(). Actually this is the only user of 
VMSTATE_BUFFER_POINTER_UNSAFE().

I appreciate if you submit the patch with this VMState change and patch 
message.

> 
> This, and maybe a few other fields like it?

There is another candidate: n->mac_table.macs

But it is not straightforward to embed this array because it uses 
VMSTATE_VBUFFER_MULTIPLY().

Regards,
Akihiko Odaki

