Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E622ACA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 17:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqxwh-0003ai-4O; Tue, 26 Aug 2025 13:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqxwH-0003Sw-2r; Tue, 26 Aug 2025 13:58:33 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqxw8-0000K2-KB; Tue, 26 Aug 2025 13:58:31 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-55f4410f7c9so2602212e87.2; 
 Tue, 26 Aug 2025 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756231094; x=1756835894; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOlXbiinGmPs/nZN5QJP75eXz0530Uo/GjyL8/O13ng=;
 b=ksOOd3XKEtbJZPxoTbNrJ2HeC6SUhO2tovCYBiqNbibSJ8oLtDd+vMt4cGE0os5yk+
 IVEPZpo7mbLnNKLQiOZy6SxnvRi5fSk4H6Mb0HDBYiCDf5FF9EGPbY5eJvGhRyVmk6mD
 ioJ09wz4QnRZ8K3LAWTQmcXs+pxaztz3+3ik6d/dC9WPExa/J7H9MscVXObilZLhjyqc
 y3vSEAwS3dEzs0Yqvnmb7RbZQlpDlMaFvguKkmI0930dE4PESVe2P5dUWTEMAhgZfC3T
 RsEc6oB+GU+IVlHchkxovAjH60CeuJ/FVKMngAufHAOQq1e8OB/0C6YgTXADZlF9h8Cf
 wD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756231094; x=1756835894;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOlXbiinGmPs/nZN5QJP75eXz0530Uo/GjyL8/O13ng=;
 b=gLzTYoVJnxc2kG1li4Q8IAZpcIXvF4dgNH7w1YdA+qugnGWDWIeCut0/mlKTXCs8NJ
 8pi/28+QEY/3O2pkUxjVGSLMCtwcX7YNB6IaW4DEHpWAISsnD5A2/OCBkvv2r667bmfw
 V7xxlbXCk9JE/uxuRv8aqO9n9uSLXp7hNUIRzvOWONRV0tw3DdtTwYP0VN0ZLpkDEosL
 FmES9574Rc6aC8B7uYe2dUV3P4YkFDsXYp3Jyq+KzuDlbIT15jwZo+/G2t1DZDQCcmcH
 Lg2yqN1EOAfsCiCzCqYNw/G0cIDlNmOyAUgzpSg+Xvv0RE9acvkn019jHHZNE1PedmFx
 7jyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX8kjjQudKfvFBQGvkAEuHq5WdIA8puFey0g5CKX3HoxSsq7bcK2jfJPfJpbZtVJPJnSmDql+KKrpJ@nongnu.org
X-Gm-Message-State: AOJu0YzJxZ5h+9T67mU+qCeyhVkhwe78IqYw2A7Nkx/z78bJX2fWreLT
 9unlrua+NVbmM0zVvlT0TEB6b06JymOpydp5Ol6eXU5YE5kQdsDOzzbX
X-Gm-Gg: ASbGncsTFP2QEWmPrdHo8G4GHXPyUEVvgplhMjF9fHe79IHIj+rVJQxIZCPEiY6oi0v
 nMd+4GYYXe5Gy5uc3+NE7A1wEZHa7FCOyIR7jmlCDe6R9n5EBYsL5+ciX1REkjgej8OJMtxnObz
 lj6Z4dQlHp4UAHrpF38zdFMr0pJdBqwHqEMxmYp0pNxsTRtWemOeZOkxPJ8355C7Z7TA3SwJvWq
 4AI9wd49kcTn4MNpuOP5vUxeGfccoAwFryNMdnwvNT94Q+s5Zh9Uhs8s1OMCpGNvxtfoC90plMO
 szYRN4OPcABgNmo40jLvOUl6Pbpk/6+u9zAwDCjhzVrjxvHUr/+5gxQZE+gWQ2vByAzr8u4uL7U
 nBP1DsVna1afh7SEIOrtwjlF4CMgBiT4ZWr5xeM+AgEt5B2nebgk57uEXeToC8EcCQuYe4BiGmY
 Tg1p0w
X-Google-Smtp-Source: AGHT+IEnz3uQsNs3l1uvTP7+Vgfw8NhB81upi19lpDWPI21W7qWTgii9uXGOIq1fKe75mibmAVJuaA==
X-Received: by 2002:a05:6512:6610:b0:55f:44d5:e517 with SMTP id
 2adb3069b0e04-55f44d5e6fbmr2542022e87.43.1756231093281; 
 Tue, 26 Aug 2025 10:58:13 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35c12193sm2366605e87.50.2025.08.26.10.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 10:58:12 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:58:12 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Re: [PATCH 2/2] hw/display/xlnx_dp: Don't leak dpcd and edid objects
Message-ID: <aK31tNa1pRjKuolb@zapote>
References: <20250826174956.3010274-1-peter.maydell@linaro.org>
 <20250826174956.3010274-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826174956.3010274-3-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 26, 2025 at 06:49:56PM +0100, Peter Maydell wrote:
> In the xnlx_dp_init() function we create the s->dpcd and
> s->edid objects with qdev_new(); then in xlnx_dp_realize()
> we realize the dpcd with qdev_realize() and the edid with
> qdev_realize_and_unref().
> 
> This is inconsistent, and both ways result in a memory
> leak for the instance_init -> deinit lifecycle tested
> by device-introspect-test:
> 
> Indirect leak of 1968 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c5
> 3fecd904ba5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
>     #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
>     #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/qdev.c:149:19
>     #5 0x5aded54458be in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1272:20
> 
> Direct leak of 344 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c53fecd904ba5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
>     #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
>     #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/qdev.c:149:19
>     #5 0x5aded5445a56 in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1275:22
> 
> Instead, explicitly object_unref() after we have added the objects as
> child properties of the device.  This means they will automatically
> be freed when this device is deinited.  When we do this,
> qdev_realize() is the correct way to realize them in
> xlnx_dp_realize().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  hw/display/xlnx_dp.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 7c980ee6423..ef73e1815fc 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1267,14 +1267,18 @@ static void xlnx_dp_init(Object *obj)
>      s->aux_bus = aux_bus_init(DEVICE(obj), "aux");
>  
>      /*
> -     * Initialize DPCD and EDID..
> +     * Initialize DPCD and EDID. Once we have added the objects as
> +     * child properties of this device, we can drop the reference we
> +     * hold to them, leaving the child-property as the only reference.
>       */
>      s->dpcd = DPCD(qdev_new("dpcd"));
>      object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
> +    object_unref(s->dpcd);
>  
>      s->edid = I2CDDC(qdev_new("i2c-ddc"));
>      i2c_slave_set_address(I2C_SLAVE(s->edid), 0x50);
>      object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
> +    object_unref(s->edid);
>  
>      fifo8_create(&s->rx_fifo, 16);
>      fifo8_create(&s->tx_fifo, 16);
> @@ -1311,8 +1315,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>      qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
>      aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
>  
> -    qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
> -                           &error_fatal);
> +    qdev_realize(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
> +                 &error_fatal);
>  
>      s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
>      surface = qemu_console_surface(s->console);
> -- 
> 2.43.0
> 

