Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C07C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 15:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiD73-0000sU-Eo; Fri, 10 Jul 2026 11:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wiD70-0000qz-FJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 11:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wiD6q-0003uN-B6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 11:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783697138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/9UJOclM0qjWuIqNTg3Kp+hUdS6wHGjNe0ibCsQIdXM=;
 b=FQMuDZyJGVtiBq0s1JeSrM/yPbNjmum/HZaiAHNO5t6oV/ObHxxS3+b0LNrcVQ7xhoHY5q
 FCJpj9R0zgDOv9VBLf3E/6WTMBqF8R0x1gEHJndWHfrGSDUX8s8SDLoyldNmPuRp8WVzKH
 WjXggeIU5cRoXcI31X8c/whCdhPxhpY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-owYi1dIKOqG1GOpIRlM19A-1; Fri,
 10 Jul 2026 11:25:35 -0400
X-MC-Unique: owYi1dIKOqG1GOpIRlM19A-1
X-Mimecast-MFC-AGG-ID: owYi1dIKOqG1GOpIRlM19A_1783697133
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8DAF1956055; Fri, 10 Jul 2026 15:25:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DB041956045; Fri, 10 Jul 2026 15:25:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8913521E6920; Fri, 10 Jul 2026 17:25:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Steven Lee
 <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,  Jamin Lin
 <jamin_lin@aspeedtech.com>,  Kane Chen <kane_chen@aspeedtech.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,  William de Abreu
 Pinho <williampinho@meta.com>,  Emmanuel Blot <eblot@meta.com>,
 qemu-arm@nongnu.org,  Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v5 6/8] hw/i2c: parent slaves created with
 i2c_slave_create_simple
In-Reply-To: <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
 (Emmanuel Blot's message of "Wed, 01 Jul 2026 19:28:36 +0200")
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
 <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
Date: Fri, 10 Jul 2026 17:25:26 +0200
Message-ID: <87pl0uyihl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Emmanuel Blot <emmanuel.blot@free.fr> writes:

> Slaves created with i2c_slave_create_simple() were left unparented and
> showed up under /machine/unattached with no stable QOM path. Add each
> slave as a QOM child of its bus, named after its I2C address, so it has
> a deterministic and addressable QOM path.

Could use an example.

Doesn't tell which machines are affected.

To find affected machines, I captured output of "info qom-tree" by running

    $ echo -e 'info qom-tree\nq' | qemu-system-TARGET -M MACHINE -S -display none -monitor stdio

for all targets and all their machine types.

This fails on my box for a number of machines: misses some image file,
needs Xen, ...  These are

    an5206
    boston
    boston-aia
    canon-a1100
    leon3_generic
    loongson3-virt
    mcf5208evb
    microchip-icicle-kit
    niagara
    nitro
    q800
    sx1
    sx1-v1
    xenfv-4.2
    xenpv
    xenpvh

Testing them manually would be possible.  Not by me.

Of the ones that run, output differs for

    anacapa-bmc
    ast1030-evb
    ast1040-evb
    ast1060-evb
    ast2500-evb
    ast2600-evb
    ast2700a1-evb
    ast2700a2-evb
    ast2700fc
    bletchley-bmc
    bpim2u
    catalina-bmc
    cubieboard
    fby35-bmc
    fuji-bmc
    g220a-bmc
    gb200nvl-bmc
    kudo-bmc
    lm3s811evb
    mpc8544ds
    npcm750-evb
    npcm845-evb
    palmetto-bmc
    powernv10-rainier
    ppce500
    quanta-gsj
    quanta-q71l-bmc
    rainier-bmc
    realview-eb
    realview-eb-mpcore
    realview-pb-a8
    realview-pbx-a9
    romulus-bmc
    sam460ex
    supermicro-x11spi-bmc
    supermicrox11-bmc
    tiogapass-bmc
    tt-atlantis
    versatileab
    versatilepb
    vexpress-a15
    vexpress-a9
    witherspoon-bmc
    yosemitev2-bmc

Looking for one with a short diff, I found realview-eb:

         /device[26] (versatile_i2c)
           /arm_sbcon_i2c[0] (memory-region)
           /i2c (i2c-bus)
    -    /device[27] (ds1338)
    +        /0x68 (ds1338)
         /device[2] (realview_gic)
           /gic (arm_gic)
             /gic_cpu[0] (memory-region)

The QOM path of this ds1338 device changes from

    /machine/unattached/device[27]

to

   /machine/unattached/device[26]/0x68

The new path still isn't stable, because the parent's path isn't.  This
caveat should be noted in the commit message.

An example of successful stabilization is tt-atlantis, where the QOM
paths of ds1338 and tmp105 change from

    /machine/unattached/device[21]
    /machine/unattached/device[22]

to

    /machine/i2c[0]/i2c-bus/0x6f
    /machine/i2c[4]/i2c-bus/0x48

> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/i2c/core.c        | 3 +++
>  include/hw/i2c/i2c.h | 7 +++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 54f6bdca88..0bbce45d48 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -382,6 +382,9 @@ I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr)
>  {
>      I2CSlave *dev = i2c_slave_new(name, addr);
>  
> +    g_autofree char *childname = g_strdup_printf("0x%02x", addr);

Is the hex address a satisfactory child name?

> +    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
> +
>      i2c_slave_realize_and_unref(dev, bus, &error_abort);
>  
>      return dev;
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index dd5930f4b5..dc557bbf3f 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -166,13 +166,16 @@ bool i2c_scan_bus(I2CBus *bus, uint8_t address, bool broadcast,
>  I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
>  
>  /**
> - * Create and realize an I2C slave device on the heap.
> + * Create and realize an I2C slave device on the heap, add the device as a
> + * child of its parent bus.
> + *
>   * @bus: I2C bus to put it on
>   * @name: I2C slave device type name
>   * @addr: I2C address of the slave when put on a bus
>   *
>   * Create the device state structure, initialize it, put it on the
> - * specified @bus, and drop the reference to it (the device is realized).
> + * specified @bus, parent it, and drop the reference to it (the device is
> + * realized).
>   */
>  I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);


