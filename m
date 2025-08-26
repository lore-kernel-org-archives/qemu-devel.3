Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC595CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 17:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqxv3-0002xo-IK; Tue, 26 Aug 2025 13:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqxv1-0002xC-9l; Tue, 26 Aug 2025 13:57:15 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqxup-00007o-TQ; Tue, 26 Aug 2025 13:57:14 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3366f102680so22035611fa.3; 
 Tue, 26 Aug 2025 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756231018; x=1756835818; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+hgdD7CAsA+Eh25EhCPIf+itA2Cx8A7NuRe+2OLbwE=;
 b=VUk+OwroTrHsZakGKDCpKfd6uengi6g74lgK/T9B6jBD3NQ6Z/Zry+kMAiRyrBrRpp
 Bg9GgO/IxTwPKEsxt++Q1kc+TvxFWkGfEwy2uAS5hCpW7FTzrIJXtXwTmHDQew9iiWRA
 av3bnprg2Q34L+lu0P1NIjxKa8Q/h8EUEJ6+Adv3wwEJ5o+9UjLjNaWq37eCvQ5mUy8C
 oTQA3OZv5A8658buU7Jo3Jo+fGZT1BZ5ryf9xWO+f5HO4TRGmwxf5k+oBtW6jxtGnwww
 aTmOceiRfDSdsMqW6GT9jW2VHGpzN3MHZPe6J7aA0ZGhDhma4bl29WY8TrUr9sRQizz0
 Pj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756231018; x=1756835818;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+hgdD7CAsA+Eh25EhCPIf+itA2Cx8A7NuRe+2OLbwE=;
 b=sQMfpGnx3zocODX0kCIqkGbV/SEpJBpRNkJ71rifETDel8E/OIuUGtr4qKgEkKm+dk
 og5dg8j0Vt96I64PYoH7yb9dgRBKNLRUozW1EnT6HlusgnRI0We0aihmzgrxVPagBweK
 VG2UqjGsqjJ+jX6PMLE7kryJ+vMPF/ts2dRPldXmv553rCOhfT/mKR/+7JKQYc9tZzWh
 WppTGc/YidQMLJqqJ/cj97AtSjmXNYNcXB0SunSgGirQQcUMKI/yN5sux96Wu2xRLrnX
 i3R3xBMzBSYlGA6lLRcHyLHQhQqKhaFx5Pmr08j9ydFnX4ghuDzfbYmuv83xaAlLnNaB
 +agw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlfVX1968r8g5aMyWht9jMP3/2KauERGY8WHIO+j5zelX7RREWpId6GnMb1aSc6A65OYT0flGlv8br@nongnu.org
X-Gm-Message-State: AOJu0YxbM55BLFYyvK52mhfzrc8hEWFF6nmrmzASQcu9Zc8wj+B1Pbb5
 ysmZ9KHkx/ZNky9C/eMziaU/ylifugnGRTuv7PxTR12kelShH27azDiq
X-Gm-Gg: ASbGncvuPWzNqM71gM4OY1aMqjsiS1vQi1qj47AITUEjs/a0juc2grRRV6ozCM+uF96
 MADhCABni8TEzENbgzgqJcPaxHHhck8LR/P6AcTMEjYxom5xfHploYmTNjN4kFPNmReuH09a/HO
 ecQg8xAqQe2SPpV5ZaH6fDMpVZ5mlvnjk96Hmj/KQIo5dfVz7+pTtSmjoWEDDhiuXlj+BONSCM/
 R3iPz6I/PdS2WswxPcvzo7+13BeEyS7W+VxsB+QakmN6JQ9Xs25m8FFyrizKAvmYob9u/TdkP/7
 K8QhMZIh4I9GH9/h3OB+hKWanJecVMFrZklnX545goXk+kJJJ6EcbrS0SoSg2Pdqy8RsdOjslNR
 m/bEbXxvy4aDWWZvhdwgz/FjMiksD5J/R08uVBcCGfKDgVoeC9HhcXUAgTbmD2AeZTcanrg==
X-Google-Smtp-Source: AGHT+IEt/jkTxS+Q5We37S0sKdSPKAZznRyxWhjyAhAcbt1CkTBTUDMM2sdQLFnuj8IS2LWzgE85Fw==
X-Received: by 2002:a2e:bc27:0:b0:336:904e:7292 with SMTP id
 38308e7fff4ca-336904e72camr3042801fa.13.1756231017958; 
 Tue, 26 Aug 2025 10:56:57 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3365e07d4b7sm24284381fa.0.2025.08.26.10.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 10:56:57 -0700 (PDT)
Date: Tue, 26 Aug 2025 19:56:56 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Re: [PATCH 1/2] hw/misc/xlnx-versal-cframe-reg: Free FIFO, g_tree on
 deinit
Message-ID: <aK31aHeiT08YmMD5@zapote>
References: <20250826174956.3010274-1-peter.maydell@linaro.org>
 <20250826174956.3010274-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826174956.3010274-2-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 26, 2025 at 06:49:55PM +0100, Peter Maydell wrote:
> In the xlnx-versal-cframe-reg device we create a FIFO in
> instance_init but don't destroy it on deinit, causing ASAN
> to report a leak in the device-introspect-test:
> 
> Direct leak of 400 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c53fecd904ba5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5aded850059d in fifo8_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/fifo8.c:27:18
>     #3 0x5aded582b9e4 in fifo32_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/fifo32.h:35:5
>     #4 0x5aded582b326 in cframe_reg_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/misc/xlnx-versal-cframe-reg.c:693:5
> 
> Similarly, we don't clean up the g_tree we create:
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c5
> 3fecd904ba5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x71fbfaccc799 in g_tree_new_full (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x93799) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d7
> 5)
>     #3 0x5aded582b21a in cframe_reg_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/misc/xlnx-versal-cframe-reg.c:691:18
> 
> Add an instance_finalize method to clean up what we
> allocated in instance_init.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/misc/xlnx-versal-cframe-reg.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
> index 1ce083e2409..95e167b9213 100644
> --- a/hw/misc/xlnx-versal-cframe-reg.c
> +++ b/hw/misc/xlnx-versal-cframe-reg.c
> @@ -693,6 +693,14 @@ static void cframe_reg_init(Object *obj)
>      fifo32_create(&s->new_f_data, FRAME_NUM_WORDS);
>  }
>  
> +static void cframe_reg_finalize(Object *obj)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
> +
> +    fifo32_destroy(&s->new_f_data);
> +    g_tree_destroy(s->cframes);
> +}
> +
>  static const VMStateDescription vmstate_cframe = {
>      .name = "cframe",
>      .version_id = 1,
> @@ -833,6 +841,7 @@ static const TypeInfo cframe_reg_info = {
>      .instance_size = sizeof(XlnxVersalCFrameReg),
>      .class_init    = cframe_reg_class_init,
>      .instance_init = cframe_reg_init,
> +    .instance_finalize = cframe_reg_finalize,
>      .interfaces = (const InterfaceInfo[]) {
>          { TYPE_XLNX_CFI_IF },
>          { }
> -- 
> 2.43.0
> 

