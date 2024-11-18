Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D086D591B2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 19:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD7st-0004fn-LY; Mon, 18 Nov 2024 14:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tD7sr-0004fd-K6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 14:58:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tD7sl-0005Mt-Qe
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 14:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731959877;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I+8+4wQtocpBqccWOBpFJbP0H/jKg+Q7O1ioCwGV6OU=;
 b=BboQ6Kjx7U8rInlgBjk05QtvIgCGIaPpZOoH8Frrn6Votu4aRkYxn+YXAQPXXuIVfiYff8
 eqS04nIlwTLZgg3eUjl3BS8lyyNsT5j/CNjLEsEs44VpD/bTK5V19x2tupWPEgCZVvCJZe
 9nOdu/kv6gJoMsQ2G7T2+C++W/lp8VQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-hmYL05v7NuOFtIiVNGArNw-1; Mon,
 18 Nov 2024 14:57:53 -0500
X-MC-Unique: hmYL05v7NuOFtIiVNGArNw-1
X-Mimecast-MFC-AGG-ID: hmYL05v7NuOFtIiVNGArNw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B65B71955BD2; Mon, 18 Nov 2024 19:57:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 148CF1955F49; Mon, 18 Nov 2024 19:57:47 +0000 (UTC)
Date: Mon, 18 Nov 2024 19:57:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PULL 6/7] hw/loongarch: virt: pass random seed to fdt
Message-ID: <ZzucOBWZJYeUVi3V@redhat.com>
References: <20240912125132.268802-1-gaosong@loongson.cn>
 <20240912125132.268802-7-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912125132.268802-7-gaosong@loongson.cn>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Hi Song / Jason,

We're seeing non-deterministic hangs in our functional test
suite 'tests/functional/test_loongarch64_virt.py' and my
attempt at git bisect is blaming this commit.

With this applied, perhaps 1 time in 10, the test case hangs,
with zero serial port output from EDK2 emitted

  https://gitlab.com/qemu-project/qemu/-/issues/2686

I'm not seeing an obvious flaw in this commit's code, so I'm
wondering if it has accidentally tickled some other subtle
pre-existing bug elsewhere. Some general problem with FDT
handling on loongarch64 perhaps ?

On Thu, Sep 12, 2024 at 08:51:31PM +0800, Song Gao wrote:
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> 
> If the FDT contains /chosen/rng-seed, then the Linux RNG will use it to
> initialize early. Set this using the usual guest random number
> generation function.
> 
> This is the same procedure that's done in b91b6b5a2c ("hw/microblaze:
> pass random seed to fdt"), e4b4f0b71c ("hw/riscv: virt: pass random seed
> to fdt"), c6fe3e6b4c ("hw/openrisc: virt: pass random seed to fdt"),
> 67f7e426e5 ("hw/i386: pass RNG seed via setup_data entry"), c287941a4d
> ("hw/rx: pass random seed to fdt"), 5e19cc68fb ("hw/mips: boston: pass
> random seed to fdt"), 6b23a67916 ("hw/nios2: virt: pass random seed to fdt")
> c4b075318e ("hw/ppc: pass random seed to fdt"), and 5242876f37
> ("hw/arm/virt: dt: add rng-seed property").
> 
> These earlier commits later were amended to rerandomize the RNG seed on
> snapshot load, but the LoongArch code somehow already does that, despite
> not having this patch here, presumably due to some lucky copy and
> pasting.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240905153316.2038769-1-Jason@zx2c4.com>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>  hw/loongarch/virt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 76dd29a391..81b1f9486f 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -48,6 +48,7 @@
>  #include "hw/block/flash.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
>  
>  static bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>  {
> @@ -303,6 +304,7 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
>  static void create_fdt(LoongArchVirtMachineState *lvms)
>  {
>      MachineState *ms = MACHINE(lvms);
> +    uint8_t rng_seed[32];
>  
>      ms->fdt = create_device_tree(&lvms->fdt_size);
>      if (!ms->fdt) {
> @@ -316,6 +318,10 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
>      qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
>      qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
>      qemu_fdt_add_subnode(ms->fdt, "/chosen");
> +
> +    /* Pass seed to RNG */
> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> +    qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
>  }
>  
>  static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
> -- 
> 2.34.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


