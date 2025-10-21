Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E98CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7ZU-0007rI-ER; Tue, 21 Oct 2025 04:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7ZS-0007rA-KD
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:18:19 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7ZP-0005hR-Tt
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:18:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso3617579f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761034694; x=1761639494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bB/9CtUnLC31a7HvUHu2/lZkhWT9XhDNAGX3inRYSK4=;
 b=e1s9uZ6FbiJCzg0i6Lm48NENDtF4/k1RQ56HF06uLAfFbxQZrHQvT25ROD81GN9BNC
 EXohT3wGgUYsN5Bx00OtErRcPPQ4Qtrr2FeKMHuM+hj6L18z+pu4MXa6t0YxQY1SPhAa
 WSkZ1VfFsfXuwZJALUBNZcG1U4D1WNc+WVYIQAQAV91Kfk1xc/HtrtePNwGvx0GWeTlm
 CsPs2lgt+EBxRCv7eVe+ODlaHNweTjLVX1gXYHE4qE2M7T+/E870SzG25z0oTNrwLDiU
 nIiJ7Q6hZn/mf0UxletR22XaseSZKdlTtgNmwp/KsB9MQXjoRGWNF++AvCIWEa1K2Qw8
 CCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761034694; x=1761639494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bB/9CtUnLC31a7HvUHu2/lZkhWT9XhDNAGX3inRYSK4=;
 b=VyNYmDOGtQTxD73NnrvHukNRZetNaL7ALwm2WT5gWw0pu85uuyhDzRbjSdljO4Sfqr
 RcsaiR3QZv/xEVNLmiU05Os2L5iWCG49t5ig9phrvkdNWACr0YkzLNls1lQmnb8QMIki
 0T6+kvlexrE4jUrBINEeNsWC9bsstq3VRrrW1Nyd20qCIObBaVXoEZ/iOkWdUPxg4sDT
 L2cYpTX3p9428kbNnK/OpK5EFZgAZyuGABuZfg8Zp1vxvNahxvad8uAaptKODpow1htL
 Zp0Vq6QRIZ1Uv4zO/MpjQ78K5+4q/VbR6+w+H1GHnfuXG9wDzgk9akZmP3Hiu6+nbZlD
 huVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNXAWerV0Kj6Gm25sCm4EdVgvbbYJkegGnTrDhYl2uaVjcm/AcfdqgyVRnpzBvgQbyl2mjXjDVreGx@nongnu.org
X-Gm-Message-State: AOJu0Yy/ox/37uxpKPDg2XWElgrshq7dWass+vvpWvFNFHryBSdDVeO2
 Tm4A8tiwLR7Auix/V5zpYp+NbuGF59Hfmx6ssZ+FFjXDex3H0ms/fGU4CY0cDXMsYzc=
X-Gm-Gg: ASbGncvNMuls3u3TXJUW3VAYqLv+sX1HIfux+sXOt0t5KXbUig/vcztHabPQYvZer/X
 GSPh6bpVnpvEDdKB61oU7ZdfwiYtA/QD5prh8CvfhqRyFrivfrNI01C8uZEHETU/KdxgJgxZAos
 lSzjY1Vt4MCv5pfN4rS02phHiitS9UHm94pt9iUbiSi7b00O/fTKNdWpDQ/miXzpeYMNyhW1hTv
 3VqJh+zwVpLEqAfYYXkwD4owdWX9sKU9z5lAB4lVKoELUNPLP8nciaFNdDLiNAh/6NOQdFM96Z5
 o618DVtAJMnbzCuaWpxd2fbdbg1SHPycwobuXITztM/3o0iKehIackvZ6kUN5ZbnhE2bvjtwiOG
 ug1MWpMynZk5WoOnNhwCEwqI65GlCsBYqpbCO/iyh933Br4GG/ncrVUmP++6VH/cqn02mzvsX/3
 Lz6JpNlfz6ed2EaO1Qn89v7NuV+cubGo7YYdciHVLi9bg=
X-Google-Smtp-Source: AGHT+IFnZcvFpcz9rbIcnP+RWGj/BEYOTf4mRGqyyZpPAfOxNqicEDz7TxYwB6KoX1kYOl37xUaSZw==
X-Received: by 2002:a05:6000:26cf:b0:3ec:db88:bf1 with SMTP id
 ffacd0b85a97d-426fb6a747cmr13924695f8f.12.1761034693874; 
 Tue, 21 Oct 2025 01:18:13 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a993sm19195693f8f.24.2025.10.21.01.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 01:18:13 -0700 (PDT)
Message-ID: <a09c3b8e-0768-41be-a710-f0a9fdabdccc@linaro.org>
Date: Tue, 21 Oct 2025 10:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RFC: qdev: add legacy properties only for those
 print()-able
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251015105419.2975542-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015105419.2975542-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

+Markus

On 15/10/25 12:54, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The link properties are not printed in "info qtree", I don't know if
> this was intentional. We currently register legacy properties for
> link/ptr properties, but they don't have PropertyInfo getters (only
> ObjectPropertyAccessor, when using non-legacy properties)
> 
> By not registering a (unusable?) legacy property, "info qtree" can now
> print the link.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/core/qdev-properties.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index b7e8a89ba5..fe260a9670 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1143,14 +1143,13 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop
>   {
>       g_autofree char *name = NULL;
>   
> -    /* Register pointer properties as legacy properties */
> -    if (!prop->info->print && prop->info->get) {
> +    if (!prop->info->print) {
>           return;
>       }
>   
>       name = g_strdup_printf("legacy-%s", prop->name);
>       object_class_property_add(OBJECT_CLASS(dc), name, "str",
> -        prop->info->print ? qdev_get_legacy_property : prop->info->get,
> +        qdev_get_legacy_property,
>           NULL, NULL, (Property *)prop);
>   }
>   


