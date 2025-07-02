Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9869C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtw2-0006cc-5F; Wed, 02 Jul 2025 05:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWtvz-0006Xl-BY; Wed, 02 Jul 2025 05:39:19 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWtvw-0004oS-Tx; Wed, 02 Jul 2025 05:39:18 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 664AE47302;
 Wed,  2 Jul 2025 11:39:12 +0200 (CEST)
Message-ID: <948aea4b-b2bb-4061-b472-073f402a4584@proxmox.com>
Date: Wed, 2 Jul 2025 11:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: include child references in block device info
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com
References: <20250701162124.1313813-1-f.ebner@proxmox.com>
 <aGT4SoV76ViyN6XS@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aGT4SoV76ViyN6XS@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 02.07.25 um 11:13 schrieb Kevin Wolf:
> Am 01.07.2025 um 18:21 hat Fiona Ebner geschrieben:
>> +##
>> +# @BlockdevChild:
>> +#
>> +# @child: The name of the child, for example 'file' or 'backing'.
>> +#
>> +# @node-name: The name of the child's block driver node.
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'struct': 'BlockdevChild',
>> +  'data': { 'child': 'str',
>> +            '*node-name': 'str' } }
> 
> Is node-name really optional? I don't think we have nodes without a node
> name any more, do we?

I'm not aware of any, but @node-name in @BlockDeviceInfo is marked as
optional too, so I went with that.

Looking at the git history, missing node-names are auto-generated since
15489c769b ("block: auto-generated node-names") or v2.5. The QAPI schema
says @node-name was added before that in v2.0. Should it be made
non-optional in @BlockDeviceInfo too?

> Same with your check for child->bs, I don't think a BdrvChild without a
> bs can exist (or only while creating/destroying the BdrvChild, which
> holds the graph lock and doesn't allow monitor commands to run in the
> middle).

Okay, yes. There are other places that access child->bs without checking
already. I'll drop that check.

Best Regards,
Fiona


