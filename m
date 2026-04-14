Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E5DF9D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChXe-0002pQ-WC; Tue, 14 Apr 2026 13:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmeneghi@redhat.com>)
 id 1wCeOU-0006SS-G6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 10:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmeneghi@redhat.com>)
 id 1wCeOS-0003NE-CR
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 10:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776175531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mkQQavxHk9rktK6aib/cIzQJH5DUsOdCQXoImVpnSH8=;
 b=MIrUTu6cNe5789ALGa5K1BS2/xn570HLnNBzQVVz8rouhc9xAdGcBIBtSFofm1q1xjaGZp
 jjiOA1XZPeIIybHIHsO613mFllZbZSCgJ4AGJ2r2xqs1Fvr7GKMms7NVoMG96pV4OmbF8O
 5F8bRxdSFO5aC2HXVQA2T9g9Lzgfr2w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-oUcD_zD3MVil7A2r81LgIA-1; Tue,
 14 Apr 2026 10:04:19 -0400
X-MC-Unique: oUcD_zD3MVil7A2r81LgIA-1
X-Mimecast-MFC-AGG-ID: oUcD_zD3MVil7A2r81LgIA_1776175454
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 541DE180034F; Tue, 14 Apr 2026 14:04:14 +0000 (UTC)
Received: from [10.17.17.11] (unknown [10.17.17.11])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 942A0195608E; Tue, 14 Apr 2026 14:04:12 +0000 (UTC)
Message-ID: <0743e428-cde4-436a-9af4-7477271fd8ab@redhat.com>
Date: Tue, 14 Apr 2026 10:04:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
To: Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Nilay Shroff <nilay@linux.ibm.com>
Cc: mr-083 <matthieu@minio.io>, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 kbusch@kernel.org, mr-083 <matthieu@min.io>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20260414124221.GB111076@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmeneghi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Apr 2026 13:27:13 -0400
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

Adding Nilay who has done a lot of work on nvme hot plug.

Nilay please take look at these patches and let us know if they can work on powerpc

I'll set up a test bed and try this out with x86_64.

John A. Meneghini
Senior Principal Platform Storage Engineer
RHEL SST - Platform Storage Group
jmeneghi@redhat.com

On 4/14/26 8:42 AM, Stefan Hajnoczi wrote:
> On Mon, Apr 13, 2026 at 07:17:37PM +0200, Klaus Jensen wrote:
>> On Apr  9 08:01, mr-083 wrote:
>>> This series adds two features that together enable transparent NVMe disk
>>> hot-swap simulation in QEMU, matching the behavior of physical NVMe
>>> drives being pulled and reinserted in the same PCIe slot.
>>>
>>
>> I don't understand this. From an NVMe perspective you can't hotplug a
>> namespace. You can hotplug a PCIe-based NVM Subsystem.
> 
> Hi Klaus,
> It would be great if someone with more NVMe experience than myself can
> find a definite answer, but I think the Namespace List can change
> asynchronously even on a NVMe PCIe controller as long as it supports
> Namespace Management commands.
> 
> There are instances in the NVMe Express Base Specification 2.0b like:
> - 8.3.1 Capacity Management Overview
>    "a Namespace Attribute Changed event is generated for hosts other than
>    the host which issued the Capacity Management command"
> - 8.11 Namespace Management
>    "If Namespace Attribute Notices are enabled, any controller(s) not
>    processing the Namespace Management command that was attached to the
>    namespace reports a Namespace Attribute Changed asynchronous event to
>    the host."
> 
> I imagine this functionality would be useful in storage offload cards
> (IPUs/DPUs) that present as NVMe PCIe controllers instead of as
> NVMe-over-Fabrics. This makes sense when the host is not supposed to
> manage the storage itself. When the card's control plane configures a
> new volume, the NVMe Namespace List changes and the host is notified.
> 
> Linux and Windows NVMe PCI drivers support this according to the testing
> that Matthieu and I have done.
> 
> Thanks,
> Stefan


