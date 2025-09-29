Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E6ACAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G1a-00012C-32; Mon, 29 Sep 2025 11:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3G1T-000110-84
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3G1O-0007VZ-Te
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759160548;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOARqUcTvT98mGme+kov79qFfzh5RARqViuydc0c43c=;
 b=PYOPMK/ovozJ5G3RS5hh+/IHrniD94XQ8S98ZnVVzUhNtBNDkoPRoQ0KwMPIuhoNuWxsrB
 fp4jEitcOMH0k3/Wq0Rsy0XmR58k1jowN2yt/+hwIIhKT2hfd7B2BEr++23jcupUz7f6VT
 62lKqQGpGETL3xS4E525WkVqgXTnG0w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-6-o01l8hMb2orPGkNRACzw-1; Mon, 29 Sep 2025 11:42:21 -0400
X-MC-Unique: 6-o01l8hMb2orPGkNRACzw-1
X-Mimecast-MFC-AGG-ID: 6-o01l8hMb2orPGkNRACzw_1759160540
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e35baddc1so30643485e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160540; x=1759765340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dOARqUcTvT98mGme+kov79qFfzh5RARqViuydc0c43c=;
 b=h81IuQlDDSniPqXkfxNcb0wj1eJ9JXVzXR8nrPICMPuv/4IbWyckkpLPjGD5dT0dDQ
 4CJkYlWsG6U5C+WvdUK7jg3PYig2C5vGRUq9M/NnVacJD/NH/zCQuxFeE459x3OEByEU
 CIO/Rj0RR/7fykfkTB+qOsm6ig9muCWKimODrZq6IEFN5xbirk6l+/hm7RgiLy7GMFKE
 HfA4wmokuWF6MzPA9n8POXJGlKbkzJYJzTENXjgNyK4jrftqHyywJvTt4bRDo66Ds3rY
 U0SLXhu6gLo7ekmVGTqIPu9bQ0QlQS2sMNu61BWJwaVXGpiLOqednol8BYzVdbacM843
 GMXg==
X-Gm-Message-State: AOJu0Yx6+RjOb6uBAwZV1v+wuTxXBJlEkHnv67BcmVebhfPY700DHvft
 k+vWVGILEd1gifmbGSck20wLhrehBy/J8mH1EoH89Q+4Tt/QAbaqwa7RW0TTMI6YB18Wt6bOzSV
 s6EFSjSeLZbLfvqBGAKyZUTmmfwK4riapTH8L9Y+XxyKZKMDQcvs28lqL
X-Gm-Gg: ASbGnctOkbOqmM2ukTD9diKMMOpoaSE0qYamb7T7kJ+yLECU+RuJOoO6ZZBVfFzqjlh
 ejZYlsiEktHKFVy7ba7CzZGATNHSmSnNu9Q/JMqjoWpCbVh15x4WCXEGyH2x9LQbR7CSXG2gQfg
 mmjtERYJ/gXZEdqnPJcehM9SEQhHlmF1MqqQgBaAvPx3BfzBWIp86/BBMsiVE64s+ehjE798rPw
 KSvXKdy4sMmWG3kQ0+mPldBhANkygO1ZhVsVPWcYHoXKBlG8pmMky8SSlxvjtgado2NRdmhEL+0
 jy0H6nnAcPXJbYLHtpAdIdvQBMY2WDA2nfkJ3uXJlNh99TF6/VaLhF6W1X3wVjm6tODgxaPK3yf
 bqynZG4EdJx4=
X-Received: by 2002:a05:600c:4743:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-46e33b2ca06mr137958425e9.32.1759160540139; 
 Mon, 29 Sep 2025 08:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSnGHcz90rl4d1aZkzvH0OjSS4fgI2vCZkPcjzx8C2zPObejImQsdb+EFx6alHj2s5ZnJ+fg==
X-Received: by 2002:a05:600c:4743:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-46e33b2ca06mr137958145e9.32.1759160539713; 
 Mon, 29 Sep 2025 08:42:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921f4esm18785309f8f.44.2025.09.29.08.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:42:19 -0700 (PDT)
Message-ID: <512210c3-95cc-484e-b8aa-78ceb631264f@redhat.com>
Date: Mon, 29 Sep 2025 17:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] hw/arm/smmuv3: Add property to enable Secure
 SMMU support
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250926032339.1089647-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250926032339.1089647-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/26/25 5:23 AM, Tao Tang wrote:
> My apologies, resending patches 13-14/14 to fix a threading mistake from
> my previous attempt.
>
> This commit completes the initial implementation of the Secure SMMUv3
> model by making the feature user-configurable.
>
> A new boolean property, "secure-impl", is introduced to the device.
> This property defaults to false, ensuring backward compatibility for
> existing machine types that do not expect the secure programming
> interface.
>
> When "secure-impl" is set to true, the smmuv3_init_regs function now
> initializes the secure register bank (bank[SMMU_SEC_IDX_S]). Crucially,
> the S_IDR1.SECURE_IMPL bit is set according to this property,
> correctly advertising the presence of the secure functionality to the
> guest.
>
> This patch ties together all the previous refactoring work. With this
> property enabled, the banked registers, security-aware queues, and
> other secure features become active, allowing a guest to probe and
> configure the Secure SMMU.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index c92cc0f06a..80fbc25cf5 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -351,6 +351,16 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->statusr = 0;
>      s->bank[SMMU_SEC_IDX_NS].gbpa = SMMU_GBPA_RESET_VAL;
>
> +    /* Initialize Secure bank (SMMU_SEC_IDX_S) */
same comment as before, use a local pointer to the secure bank.
> +    memset(s->bank[SMMU_SEC_IDX_S].idr, 0, sizeof(s->bank[SMMU_SEC_IDX_S].idr));
> +    s->bank[SMMU_SEC_IDX_S].idr[1] = FIELD_DP32(s->bank[SMMU_SEC_IDX_S].idr[1],
> +                                                S_IDR1, SECURE_IMPL,
> +                                                s->secure_impl);
> +    s->bank[SMMU_SEC_IDX_S].idr[1] = FIELD_DP32(
> +        s->bank[SMMU_SEC_IDX_S].idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
> +    s->bank[SMMU_SEC_IDX_S].gbpa = SMMU_GBPA_RESET_VAL;
> +    s->bank[SMMU_SEC_IDX_S].cmdq.entry_size = sizeof(struct Cmd);
> +    s->bank[SMMU_SEC_IDX_S].eventq.entry_size = sizeof(struct Evt);
>  }
>
>  static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
> @@ -2505,6 +2515,12 @@ static const Property smmuv3_properties[] = {
>       * Defaults to stage 1
>       */
>      DEFINE_PROP_STRING("stage", SMMUv3State, stage),
> +    /*
> +     * SECURE_IMPL field in S_IDR1 register.
> +     * Indicates whether secure state is implemented.
> +     * Defaults to false (0)
> +     */
> +    DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
>  };
I would introduce the secure-impl property at the very end of the series
because at this point migration is not yet supported.
By the way the secure_impl field can be introduced in the first which
uses it. I don't think "hw/arm/smmuv3: Introduce banked registers for
SMMUv3 state" does

Thanks

Eric
>
>  static void smmuv3_instance_init(Object *obj)
> --
> 2.34.1
>


