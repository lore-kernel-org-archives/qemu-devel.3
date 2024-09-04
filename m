Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EDACD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 08:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sllSb-0003qU-53; Wed, 04 Sep 2024 04:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sllST-0003nq-Bv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 04:33:47 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sllSR-0006Pt-FS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 04:33:45 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7AAEC45B4B;
 Wed,  4 Sep 2024 10:27:22 +0200 (CEST)
Message-ID: <71d526dd-dcbd-42b8-9815-2d70edaa4777@proxmox.com>
Date: Wed, 4 Sep 2024 10:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: add 'qemuutil' dependency for block.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 thuth@redhat.com, philmd@linaro.org
References: <20240814100052.263060-1-f.ebner@proxmox.com>
 <Zr4liA5Kr7qV8aj3@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <Zr4liA5Kr7qV8aj3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 15.08.24 um 17:58 schrieb Daniel P. Berrangé:
> On Wed, Aug 14, 2024 at 12:00:52PM +0200, Fiona Ebner wrote:
>> The macro block_module_load() used by block.c is a wrapper around
>> module_load(), which is implemented in util/module.c.
>>
>> Fixes linking for a future binary or downstream binary that does not
>> depend on 'qemuutil' directly, but does depend on 'block'.
> 
> Such a scenario is impossible surely, even in future. Every file in
> QEMU pulls in osdep.h, and as a result effectively gets a dep on
> on qemuutil, not to mention the block layer using countless APIs
> present in qemuutil
> 

Yes, you are right. Sorry, I missed this dependency. The sources for
both of our affected downstream binaries do include "qemu/osdep.h" and
thus have a direct dependency on qemuutil. So my patch can be disregarded.

Build for the mentioned binaries broke after, IIRC, 414b180d42 ("meson:
Pass objects and dependencies to declare_dependency()"), because they
didn't explicitly specify the qemuutil dependency in meson. The error
message I got was about "module_load" used by the block layer.

Best Regards,
Fiona


