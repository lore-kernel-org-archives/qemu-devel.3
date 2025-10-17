Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D4ECCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9fi3-0000I9-Dm; Fri, 17 Oct 2025 04:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1v9fi0-0000HU-Ao; Fri, 17 Oct 2025 04:21:08 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1v9fht-0000tj-L6; Fri, 17 Oct 2025 04:21:08 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 43B6E8980C;
 Fri, 17 Oct 2025 10:20:42 +0200 (CEST)
Message-ID: <07150a24-d155-49c9-958c-361ea7ae6ced@proxmox.com>
Date: Fri, 17 Oct 2025 10:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hw/scsi: avoid deadlock upon TMF request canceling with
 VirtIO
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net,
 mst@redhat.com, kwolf@redhat.com, qemu-stable@nongnu.org
References: <20251015134351.380079-1-f.ebner@proxmox.com>
 <20251016175857.GA1174862@fedora>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20251016175857.GA1174862@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1760689238141
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Stefan,

Am 16.10.25 um 8:25 PM schrieb Stefan Hajnoczi:
> On Wed, Oct 15, 2025 at 03:43:50PM +0200, Fiona Ebner wrote:
>> RFC, because it's a naive approach, maybe somebody has a better idea?
> 
> Another approach is the one taken in scsi_device_for_each_req_async_bh()
> where requests from this AioContext are collected into a GList and then
> processed after releasing s->requests_lock. It's safe because the
> function runs in the request's AioContext and we know nothing else can
> modify the request while we are running. The same constraint applies in
> this case too.
> 
> That solution is more localized because various function prototypes
> don't need to be extended with holds_requests_lock. Either it can be
> open coded inside virtio_scsi_do_tmf_aio_context() or you could extract
> a helper function from scsi_device_for_each_req_async_bh() in scsi-bus.c
> and call the new helper from virtio_scsi_do_tmf_aio_context().
> 
> I slightly prefer a localized fix so that other parts of the codebase
> don't need to worry about whether or not requests_lock is held. Do you
> want to try implementing that?
thank you for the suggestion and pointers! I also feel like a localized
solution would be nicer. I'll try this approach.

Kind Regards,
Fiona


