Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418A5CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsdM-0008H1-U3; Tue, 09 Jun 2026 05:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wWsdL-0008Gt-8R
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:20:31 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wWsdJ-0005qE-EN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:20:31 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1B75580A3E;
 Tue, 09 Jun 2026 11:20:26 +0200 (CEST)
Message-ID: <566e0cc5-9a50-43b8-9866-f599a4657004@proxmox.com>
Date: Tue, 9 Jun 2026 11:20:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/14] virtio-net: Advertise UDP tunnel GSO support by
 default
To: Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gabriel Goller <g.goller@proxmox.com>,
 Stefan Hanreich <s.hanreich@proxmox.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <cover.1762698873.git.mst@redhat.com>
 <1c79ab6937ae938d3dfd4da1c01afc7eb599857e.1762698873.git.mst@redhat.com>
 <077647f6-d569-4918-9aea-c0597a6ddbc8@proxmox.com>
 <39100539-1c43-431b-886d-7d42850bc4c5@redhat.com>
 <127b6887-f93a-4081-a264-1bc63f37921d@proxmox.com>
 <375064ee-5a6f-44d4-8192-09f39804be69@redhat.com>
 <20260608160546-mutt-send-email-mst@kernel.org>
 <935be681-4920-4361-b54e-3c14da9fc368@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <935be681-4920-4361-b54e-3c14da9fc368@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1780996780541
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

Am 09.06.26 um 9:03 AM schrieb Paolo Abeni:
> On 6/8/26 10:06 PM, Michael S. Tsirkin wrote:
>> On Mon, Jun 08, 2026 at 07:12:14PM +0200, Paolo Abeni wrote:
>>> Thanks for the data. The bug is in the virtio_net driver; non GSO
>>> packets requiring inner header csum are handled unmodified from the
>>> guest to the host, and the H/W NICs has to compute the inner transport
>>> header csum for the encap packet.
>>>
>>> Could you please try the attached kernel patch? You will need to update
>>> the kernel inside the guest.

I first tested 7.1.0-rc7 inside the guest and the issue was still
present. With your patch on top, the issue is gone :)

Thank you for the fast fix!

Tested-by: Fiona Ebner <f.ebner@proxmox.com>

Best Regards,
Fiona


