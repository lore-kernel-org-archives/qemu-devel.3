Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9F7CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 16:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ63H-0003Bc-HW; Thu, 21 May 2026 12:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1wQ639-00033o-RK; Thu, 21 May 2026 12:15:10 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1wQ637-0001Oa-RK; Thu, 21 May 2026 12:15:07 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9DA4B838A3;
 Thu, 21 May 2026 18:15:00 +0200 (CEST)
Message-ID: <94607853-59af-44ec-9ec0-ab750f66d1b9@proxmox.com>
Date: Thu, 21 May 2026 18:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 3/4] qcow2: Fix corruption on discard during write with COW
To: Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20260427170520.101242-1-kwolf@redhat.com>
 <20260427170520.101242-4-kwolf@redhat.com>
 <414848c6-3829-4120-b760-6db8d43c1ab5@proxmox.com>
 <ag8MzS2ULm8UTFlb@redhat.com>
 <2fa73e56-f4b5-436e-ab25-5654e0837bce@proxmox.com>
 <ag8YGeNoYB-sanMh@redhat.com>
 <0131584f-2470-471d-b4c1-13881e913eca@proxmox.com>
Content-Language: en-US
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
In-Reply-To: <0131584f-2470-471d-b4c1-13881e913eca@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1779380082826
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 21.05.26 um 17:14 schrieb Fiona Ebner:
> Am 21.05.26 um 4:35 PM schrieb Kevin Wolf:
>> Anyway, as it depends on a specific pattern of discard and cluster
>> allocation happening while a write request is in flight, it should be
>> possible to use tracing to find out if anything like that is happening
>> in your case.
> 
> I will try to do tracing. With the following program, I see that the
> corrupt memory reads back as zeroes:
Hmm, looking at qcow2_co_pwrite_zeroes(): could the cluster state
observed before wait_for_dependencies() drops s->lock differ from what
qcow2_subcluster_zeroize() then operates on?


