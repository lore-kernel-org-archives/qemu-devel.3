Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6689CA0EFF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 00:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urQxU-00049r-Ou; Wed, 27 Aug 2025 20:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urQxS-00049M-1Q; Wed, 27 Aug 2025 20:57:42 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urQxO-0002am-M6; Wed, 27 Aug 2025 20:57:41 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57S0vMlv097170
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 Aug 2025 09:57:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=qXFTcpg3XOa6gJrZvfyLmz6YfhBFcFIEy6JVOQEIHPk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756342642; v=1;
 b=UYP6Q24LMMcrUNITSC4DXa9Qw9EmFK/82YG6pzdxw5GOUbya3qEp/uAzyn9KEaA2
 7vvYGxeqexMKCjKu2kWOEaD6b7uI7qzevMiT+lR016P1Ty7l6QBwtYmSpzTrGMgT
 TxBCFmv+U9lBCKBsL37AXkoSPNqBXf1YDeNi+6+pdiFOemXuTYs4MoLwFqw2/QMq
 DtPTwrGBU3O3FUaGKBlRIGvGAnrXr6Ult07KM1gsnaX6NUbPF6hK/X9nimL5E/Hg
 eopUKL4a8a+E4/ZtdnUDza6j9Z1Y1lPCa76fE2RKvvKqimeKKLr9mCPymWm38EH7
 PT6kE3a+2B2P4XHiEe7zeQ==
Message-ID: <3983904c-9530-4cf5-b294-12ca04658b23@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 Aug 2025 09:57:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: fix SEEK_CUR offset calculation in
 qio_channel_block_seek
To: Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Cc: Marco.Cavenati@eurecom.fr, peterx@redhat.com, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <871pudmlmj.fsf@suse.de>
 <dc23eaca-15f5-40be-89d0-2247cfe1f716@tls.msk.ru> <87plchkaxo.fsf@suse.de>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <87plchkaxo.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025/08/27 6:52, Fabiano Rosas wrote:
> Michael Tokarev <mjt@tls.msk.ru> writes:
> 
> +CC Akihiko
> 
>> Hi!
>>
>> This is
>>
>> commit c0b32426ce56182c1ce2a12904f3a702c2ecc460
>> Author: Marco Cavenati <Marco.Cavenati@eurecom.fr>
>> Date:   Wed Mar 26 17:22:30 2025 +0100
>>
>>       migration: fix SEEK_CUR offset calculation in qio_channel_block_seek
>>
>> which went to 10.0.0-rc2, and has been cherry-picked to
>> 7.2 and 9.2 stable series.
>>
>> Reportedly it breaks migration in 7.2.18 and up.  Which is
>> kinda strange, as it shouldn't do any harm?
>>
> 
> Yeah, this is not it. Unless you're using colo or mapped-ram.
> 
>> https://bugs.debian.org/1112044
>>
>> any guess what's going on?
>>
> 
> The virtio changes are probably the issue. One of them touches
> mhdr.num_buffers, under mergeable_rx_bufs, which is migrated state. The
> flag in turn depends on VIRTIO_NET_F_MRG_RXBUF, which is set on the
> cmdline with -device virtio-net-pci,mrg_rxbuf= but also reset by
> virtio_set_features_nocheck, if I'm reading this right.

I don't think commit cefd67f25430 ("virtio-net: Fix num_buffers for 
version 1") is related to the issue. Commit ce1431615292 ("virtio: Call 
set_features during reset") is more likely.

virtio_set_features_nocheck() shouldn't reset VIRTIO_NET_F_MRG_RXBUF. It 
calls virtio_net_set_features(), which does not clear features. 
virtio_net_get_features() clears features, but it is called before 
migration.

The posted call trace indicates a lockup happens in the control path, 
but commit cefd67f25430 ("virtio-net: Fix num_buffers for version 1") 
changes the data path.

On the other hand, I can come up with a possible failure scenario with 
commit ce1431615292 ("virtio: Call set_features during reset"). Perhaps 
it changed the machine state before loading the migrated state, and 
caused a mismatch between them.

I need more information to understand the issue. A command line to 
reproduce the issue is especially helpful because options like 
mrg_rxbuf=, which you mentioned, tell enabled features, which is 
valuable information.

Regards,
Akihiko Odaki

