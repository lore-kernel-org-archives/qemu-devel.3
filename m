Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9912EC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD5M-0005tp-31; Wed, 26 Aug 2026 08:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzD5C-0005oA-Qf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzD5A-0001So-LU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 08:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787748619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4MsJwYdptdz56bdGvmniU6Rr/YDRvpUe0mRDiYPstvY=;
 b=d7gNDyuUF2J7QcnrX22nNrSl5YwL4BLsTe3Q4Cjo6C22/RJVg/gRhZ7qHDhZq21l/HZBh/
 VkSO/k89bzNlG5bQk1ZDUTlZYWswy2XOgrpbX+313+6NWad9SfwtP6su5jXQ9nz80oFzXR
 1O0pjAOVddBWOFFfERgZn6xt7uh5LpQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-1N7fN5IFMhWLveFSfovfGw-1; Wed,
 26 Aug 2026 08:50:15 -0400
X-MC-Unique: 1N7fN5IFMhWLveFSfovfGw-1
X-Mimecast-MFC-AGG-ID: 1N7fN5IFMhWLveFSfovfGw_1787748607
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A7C01944DE1; Wed, 26 Aug 2026 12:50:06 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3661A180034C; Wed, 26 Aug 2026 12:49:55 +0000 (UTC)
Date: Wed, 26 Aug 2026 13:49:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 03/12] hw/arm/virt: use unique QOM name and target filter
Message-ID: <ao7g8Aka-FbbbJlv@redhat.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <20260823150731.896-4-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260823150731.896-4-luoyonggang@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Aug 23, 2026 at 11:07:21PM +0800, Yonggang Luo wrote:
> - Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("arm-virt") so ARM virt
>   no longer collides with other virt-machine types in one process.
> - Register TYPE_TARGET_SPECIFIC with is_available = target_base_arm on
>   the abstract parent.
> - Keep -machine virt via mc->alias on the latest versioned machine.

While this solves the headline QOM name clash today, it misses
the bigger picture - the arm virt machine is versioned:

$ qemu-system-aarch64 -M help | grep ^virt
virt-10.0            QEMU 10.0 ARM Virtual Machine
virt-10.1            QEMU 10.1 ARM Virtual Machine
virt                 QEMU 10.2 ARM Virtual Machine (alias of virt-10.2)
virt-10.2            QEMU 10.2 ARM Virtual Machine
virt-5.0             QEMU 5.0 ARM Virtual Machine (deprecated)
virt-5.1             QEMU 5.1 ARM Virtual Machine (deprecated)
virt-5.2             QEMU 5.2 ARM Virtual Machine (deprecated)
virt-6.0             QEMU 6.0 ARM Virtual Machine (deprecated)
virt-6.1             QEMU 6.1 ARM Virtual Machine (deprecated)
virt-6.2             QEMU 6.2 ARM Virtual Machine (deprecated)
virt-7.0             QEMU 7.0 ARM Virtual Machine (deprecated)
virt-7.1             QEMU 7.1 ARM Virtual Machine (deprecated)
virt-7.2             QEMU 7.2 ARM Virtual Machine (deprecated)
virt-8.0             QEMU 8.0 ARM Virtual Machine
virt-8.1             QEMU 8.1 ARM Virtual Machine
virt-8.2             QEMU 8.2 ARM Virtual Machine
virt-9.0             QEMU 9.0 ARM Virtual Machine
virt-9.1             QEMU 9.1 ARM Virtual Machine
virt-9.2             QEMU 9.2 ARM Virtual Machine


At some point the riscv64 virt machine is very likely to become
versioned too at which point all the versioned machines will
clash.

IOW, the change to unique naming needs to be applied to all virt
machine versions, not just the unversioned name.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


