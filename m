Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FCBD3A670
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 17:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5phF-0003mH-SJ; Tue, 29 Oct 2024 13:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5phE-0003lx-NB
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5phC-0004sp-Oo
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730221673;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LeVl8kLvs4Z13P9JSSmTmpqycD8mJls6RN3xy6v75Wc=;
 b=A2APmqhLL8lG6bockFoZVRw8G6n/UexiaCqIfpIWEQg1HChdrzEqLuZmSgUbA1wycfad7H
 umUJxUldJ6GekvyTklubg/S2WabRQPZ+0OtV2RsE80AwmJ0ZS3aXGIZ+jMHk8ONdZxN6ts
 Jf7B+eWlooqlclnRyBSqkIGM52LB9Fc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-ykgY0T6nM0eX1nfooHCW_Q-1; Tue,
 29 Oct 2024 13:07:52 -0400
X-MC-Unique: ykgY0T6nM0eX1nfooHCW_Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 967911955F35; Tue, 29 Oct 2024 17:07:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0673D1956056; Tue, 29 Oct 2024 17:07:45 +0000 (UTC)
Date: Tue, 29 Oct 2024 17:07:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, zuoboqun@baidu.com,
 david@redhat.com, qemu-devel@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>, wangliang44@baidu.com
Subject: Re: [PATCH v2 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Message-ID: <ZyEWXl11ExHOxHKz@redhat.com>
References: <20241009095827.67393-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009095827.67393-1-gaoshiyuan@baidu.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 09, 2024 at 05:58:27PM +0800, Gao Shiyuan via wrote:
> As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
> of VirtIOPCIRegion does not belong to any address space. So memory_region_find
> cannot be used to search for this MR.
> 
> Introduce the virtio-pci and pci_bridge address spaces to solve this problem.
> 
> Before:
> memory-region: pci_bridge_pci
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>     00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
>       00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
>       00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
>     0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>       0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>       0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>       0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>       0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
> 
> After:
> address-space: virtio-pci-cfg-mem-as
>   0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>     0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>     0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>     0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>     0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
> 
> address-space: pci_bridge_pci_mem
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>     00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
>       00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
>       00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
>     0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>       0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>       0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>       0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>       0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
> Fixes: ffa8a3e3b2e6 ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")
> 
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> Signed-off-by: Wang Liang <wangliang44@baidu.com>
> ---
>  hw/pci/pci_bridge.c            | 4 ++++
>  hw/virtio/virtio-pci.c         | 5 +++++
>  include/hw/pci/pci_bridge.h    | 2 ++
>  include/hw/virtio/virtio-pci.h | 3 +++
>  4 files changed, 14 insertions(+)

Should we add some qtest coverage for this perhaps. eg per
the bug report, something like this should demonstrate the
crash:

  static void test_addr_space_crash(void)
  {
    QTestState *s = qtest_init("-device virtio-balloon -machine q35 -nodefaults");

    qtest_outl(s, 0xcf8, 0x80000890);
    qtest_outl(s, 0xcfc, 0x2);
    qtest_outl(s, 0xcf8, 0x80000891);
    qtest_inl(s, 0xcfc);
    qtest_quit(s);
  }


if we add that to one of the tests/qtest/*.c files as appropriate, or
create a new qtest file ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


