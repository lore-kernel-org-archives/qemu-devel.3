Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E660EC35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuJT-0001ER-17; Wed, 19 Mar 2025 10:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuuJR-0001E7-Vk
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuuJP-0002ds-Cy
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742394145;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BP8EqSZrr3Vq1d0hvjEvE6xsqbStCbFVF3oG7FBTK50=;
 b=O4zVy2p2B5Fke+3Mfp4Kxo4vhLZUjuZW3V9jjFrSDeNQpQ4UbAMR1h4/Wkndt+Xf2FKV4l
 ZKWckSkGo8QbUWavWaXuxUlOQjp6oSsgMteC9TEnaiP2lZUmEOFQJ+KyCkaz8ThTe79UwA
 Uka8B1VXLQ3hcrScVuvXFH5gN+PfOPo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-b2XKgxQMMBqXxZFDpHDFAQ-1; Wed,
 19 Mar 2025 10:22:22 -0400
X-MC-Unique: b2XKgxQMMBqXxZFDpHDFAQ-1
X-Mimecast-MFC-AGG-ID: b2XKgxQMMBqXxZFDpHDFAQ_1742394140
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E49A619560B9; Wed, 19 Mar 2025 14:22:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0D1C1956095; Wed, 19 Mar 2025 14:22:15 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:22:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v3 4/6] hw/uefi-vars-sysbus: allow for riscv virt
Message-ID: <Z9rTFKFPFgnLPR-c@redhat.com>
References: <20250319141159.1461621-1-kraxel@redhat.com>
 <20250319141159.1461621-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319141159.1461621-5-kraxel@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 19, 2025 at 03:11:56PM +0100, Gerd Hoffmann wrote:
> Allow the device being added to riscv virt VMs.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/riscv/virt.c | 2 ++
>  hw/uefi/Kconfig | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


