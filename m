Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFADC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 08:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVp1J-0006Q2-E4; Fri, 02 Feb 2024 03:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rVp1H-0006Pn-KP
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 03:35:31 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rVp1F-0007CM-JF
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 03:35:31 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 25359424F2;
 Fri,  2 Feb 2024 09:35:20 +0100 (CET)
Message-ID: <a912519d-e83c-460b-ab89-931e83e2ee44@proxmox.com>
Date: Fri, 2 Feb 2024 09:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qemu_init: increase NOFILE soft limit on POSIX
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sw@weilnetz.de, t.lamprecht@proxmox.com,
 berrange@redhat.com
References: <20231218101340.35053-1-f.ebner@proxmox.com>
In-Reply-To: <20231218101340.35053-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 18.12.23 um 11:13 schrieb Fiona Ebner:
> In many configurations, e.g. multiple vNICs with multiple queues or
> with many Ceph OSDs, the default soft limit of 1024 is not enough.
> QEMU is supposed to work fine with file descriptors >= 1024 and does
> not use select() on POSIX. Bump the soft limit to the allowed hard
> limit to avoid issues with the aforementioned configurations.
> 
> Of course the limit could be raised from the outside, but the man page
> of systemd.exec states about 'LimitNOFILE=':
> 
>> Don't use.
>> [...]
>> Typically applications should increase their soft limit to the hard
>> limit on their own, if they are OK with working with file
>> descriptors above 1023,
> 
> If the soft limit is already the same as the hard limit, avoid the
> superfluous setrlimit call. This can avoid a warning with a strict
> seccomp filter blocking setrlimit if NOFILE was already raised before
> executing QEMU.
> 
> Buglink: https://bugzilla.proxmox.com/show_bug.cgi?id=4507
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 

Ping


