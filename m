Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42BDCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyzn-0000OB-Lm; Mon, 01 Sep 2025 03:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyzQ-0000Jp-Jn
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:30:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyzG-0005js-HU
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:30:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ce772ce0dbso2604968f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756711796; x=1757316596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zF+E6sFRDG4qEjOuWazrMaQqjRHp8jyQ1y3Xa+nPEfc=;
 b=A1P+KVj8RCUDAu1Gqj9XgHjcs1K8MuIKWHXdMTAWP9CP4CQSme42fLjjzM7zBH2Y+G
 rpbDAVRmJmDwhHH9R7aC296wMpdi84OrzEoq9C2sDprqOTx2KlAP+m6TSetAuWD5UqKz
 eTmTWrkvMBGKSBaAKAWSlRhMOhZy1r7+tbv60woe1EwanaPnFlFJ/U+nYnHMxZWOUhUw
 XXDSGc/uJ2Km1ApMfafJAvgl9CXAahr+7Vt/ORTEnO/U0aI+ZxagJ62kmHrZml0iYfrN
 faDnHtlhvq8bbNFtJ9xLVGELo0/0gWIBZ2V/8P880c3xGio8UikywvDokW0CQCyi/zTG
 sagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756711796; x=1757316596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zF+E6sFRDG4qEjOuWazrMaQqjRHp8jyQ1y3Xa+nPEfc=;
 b=q71aJPWvbU/FAUwDcXauUPh1UU8H6mdnRPSO+daDbJTMo/Qgej8smnP6d1yZf3Ssfc
 0eWiYsGnhdhNZxECZEBw78ixtBzCfNZmsYpHfFOyUyJZcalRUtYvoZ0O8ZE5Kgj5Kc4/
 +HbsCFmIZAW+KxgebAjOvsKr7ga80l/DJwUfsVyqd30XXiGDVUjrJDzAVbQhoKUfIFO9
 T+8RROTktZbAcseoiNZpcyCtV6Nq5se6OtwsS6whHS8P/HIaCQoTbYlGI7aluYRS7IAF
 JXR308k5yHGSfykhB8Sy22q3WAJ3KWgwanfIZbcZW2Q7X2BthP7YhX1APnysmLsA3ksf
 TOUw==
X-Gm-Message-State: AOJu0YxQvt360qjj0hi4wTiwWeJ1dwucuN9y2Q0coRzjC7ISZxawD3NO
 CgiARsTEi7nLsSiM2lImaMMdDf20JnK/s6D5iQd52nJWAO8PLXuHFnYJOv4ar4qr8Wn63wiz0GU
 1a2/k
X-Gm-Gg: ASbGncsZO4pO6pEzVKiKgAnhlgo/VuON7OoYNn9Wa3af9RfKXTzMUBfSUCq0fD3NkIV
 TiP6nir2Ae6nHydRNCgflGOCXoi+gxdIp4x4bcuk799ciQhlodyQ7jB+cRuzARnUN8EWfOH2mEw
 x1Btp2AZSnE02UMgitZ9eVAWM+GUPdVIkF/WzQgs9UYOJ0Vau4oIIutf4SmdretQX2rniALG3Wv
 k/PNwPkNEHmkrOVR+x+aFgjE1wIEBV0h1nNFDpB+Nr1Rqt3jNlonp42gQ5qmec4n2s1GIq08CyP
 d9FSMQ/wlu5gcKgi+2qpk9SdcQil2s0/gugY4TEy50VXu9Iu2wlb1M0Siy3+Dz6JVlfneLWthTw
 KuYdzPhzluslPRPoQyP2SDPXmf76oPDl3adgniu4aEVw2aOv1VfJxyvGLCx4uhcx2FhSftGm/VQ
 NK
X-Google-Smtp-Source: AGHT+IFcf+vX89Wc5BcqxKAFCtJfOtIj5CU3Q4ZGcESyX50HWtPkbswzdMF6pcxXvY3NpkR9d47Exw==
X-Received: by 2002:a05:6000:420b:b0:3b9:13e4:9693 with SMTP id
 ffacd0b85a97d-3d1df34f200mr4538449f8f.52.1756711795612; 
 Mon, 01 Sep 2025 00:29:55 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d64ba4ff83sm3659361f8f.4.2025.09.01.00.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 00:29:55 -0700 (PDT)
Message-ID: <8d9521aa-b7cd-4f93-8d36-bb286f8a6bc6@linaro.org>
Date: Mon, 1 Sep 2025 09:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 3/3] hw/sd/sdcard: Remove support for spec v1.10
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 devel@lists.libvirt.org, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
References: <20240627071040.36190-1-philmd@linaro.org>
 <20240627071040.36190-4-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627071040.36190-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Kind ping :)

On 27/6/24 09:10, Philippe Mathieu-Daudé wrote:
> Support for spec v1.10 was deprecated in QEMU v9.1.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/deprecated.rst       |  6 ------
>   docs/about/removed-features.rst |  5 +++++
>   include/hw/sd/sd.h              |  1 -
>   hw/sd/sd.c                      | 12 ++----------
>   4 files changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 02cdef14aa..ff3da68208 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -362,12 +362,6 @@ recommending to switch to their stable counterparts:
>   - "Zve64f" should be replaced with "zve64f"
>   - "Zve64d" should be replaced with "zve64d"
>   
> -``-device sd-card,spec_version=1`` (since 9.1)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -SD physical layer specification v2.00 supersedes the v1.10 one.
> -v2.00 is the default since QEMU 3.0.0.
> -
>   Block device options
>   ''''''''''''''''''''
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index fc7b28e637..dfe04b0555 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1056,6 +1056,11 @@ by using ``-machine graphics=off``.
>   
>   The 'pvrdma' device and the whole RDMA subsystem have been removed.
>   
> +``-device sd-card,spec_version=1`` (since 10.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''
> +
> +SD physical layer specification v2.00 supersedes the v1.10 one.
> +
>   Related binaries
>   ----------------
>   
> diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
> index 2c8748fb9b..362e149360 100644
> --- a/include/hw/sd/sd.h
> +++ b/include/hw/sd/sd.h
> @@ -56,7 +56,6 @@
>   #define AKE_SEQ_ERROR           (1 << 3)
>   
>   enum SDPhySpecificationVersion {
> -    SD_PHY_SPECv1_10_VERS     = 1,
>       SD_PHY_SPECv2_00_VERS     = 2,
>       SD_PHY_SPECv3_01_VERS     = 3,
>   };
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index d0a1d5db18..37a6a989ee 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -168,7 +168,6 @@ static bool sd_is_spi(SDState *sd)
>   static const char *sd_version_str(enum SDPhySpecificationVersion version)
>   {
>       static const char *sdphy_version[] = {
> -        [SD_PHY_SPECv1_10_VERS]     = "v1.10",
>           [SD_PHY_SPECv2_00_VERS]     = "v2.00",
>           [SD_PHY_SPECv3_01_VERS]     = "v3.01",
>       };
> @@ -371,11 +370,7 @@ static void sd_set_ocr(SDState *sd)
>   static void sd_set_scr(SDState *sd)
>   {
>       sd->scr[0] = 0 << 4;        /* SCR structure version 1.0 */
> -    if (sd->spec_version == SD_PHY_SPECv1_10_VERS) {
> -        sd->scr[0] |= 1;        /* Spec Version 1.10 */
> -    } else {
> -        sd->scr[0] |= 2;        /* Spec Version 2.00 or Version 3.0X */
> -    }
> +    sd->scr[0] |= 2;            /* Spec Version 2.00 or Version 3.0X */
>       sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
>                    | 0b0101;      /* 1-bit or 4-bit width bus modes */
>       sd->scr[2] = 0x00;          /* Extended Security is not supported. */
> @@ -1241,9 +1236,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>           break;
>   
>       case 8:  /* CMD8:   SEND_IF_COND */
> -        if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
> -            break;
> -        }
>           if (sd->state != sd_idle_state) {
>               break;
>           }
> @@ -2231,7 +2223,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
>       int ret;
>   
>       switch (sd->spec_version) {
> -    case SD_PHY_SPECv1_10_VERS
> +    case SD_PHY_SPECv2_00_VERS
>        ... SD_PHY_SPECv3_01_VERS:
>           break;
>       default:


