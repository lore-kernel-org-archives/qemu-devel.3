Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79CFC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9MdZ-0007EB-I2; Tue, 21 May 2024 06:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s9MdX-0007DH-4J; Tue, 21 May 2024 06:22:27 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s9MdU-0001gj-WA; Tue, 21 May 2024 06:22:26 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 43786432D8;
 Tue, 21 May 2024 12:22:14 +0200 (CEST)
Message-ID: <a9739f06-7620-4e27-b1c8-0e75256ef11b@proxmox.com>
Date: Tue, 21 May 2024 12:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/machine: move compatibility flags for VirtIO-net
 USO to machine 8.1
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, jasowang@redhat.com,
 yuri.benditovich@daynix.com, andrew@daynix.com, peterx@redhat.com,
 t.lamprecht@proxmox.com
References: <20240517075336.104091-1-f.ebner@proxmox.com>
 <87h6esjf7i.fsf@suse.de>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <87h6esjf7i.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 21.05.24 um 00:22 schrieb Fabiano Rosas:
> Fiona Ebner <f.ebner@proxmox.com> writes:
> 
>> Migration from an 8.2 or 9.0 binary to an 8.1 binary with machine
>> version 8.1 can fail with:
>>
>>> kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179bfffe7
>>> kvm: Failed to load virtio-net:virtio
>>> kvm: error while loading state for instance 0x0 of device '0000:00:12.0/virtio-net'
>>> kvm: load of migration failed: Operation not permitted
>>
>> The series
>>
>> 53da8b5a99 virtio-net: Add support for USO features
>> 9da1684954 virtio-net: Add USO flags to vhost support.
>> f03e0cf63b tap: Add check for USO features
>> 2ab0ec3121 tap: Add USO support to tap device.
>>
>> only landed in QEMU 8.2, so the compatibility flags should be part of
>> machine version 8.1.
>>
>> Moving the flags unfortunately breaks forward migration with machine
>> version 8.1 from a binary without this patch to a binary with this
>> patch.
>>
>> Fixes: 53da8b5a99 ("virtio-net: Add support for USO features")
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> I'll get to it eventually, but is this another one where just having
> -device virtio-net in the command line when testing cross-version
> migration would already have caught the issue?
> 
AFAIU, the guest kernel needs to be recent enough to support the feature
too. I don't seem to run into the issue with a Debian 11 (kernel 5.10)
guest, but I do run into the issue with an Ubuntu 23.10 (kernel 6.5)
guest. Seems like it got added in kernel 6.2 with 418044e1de30
("drivers/net/virtio_net.c: Added USO support.")

Best Regards,
Fiona


