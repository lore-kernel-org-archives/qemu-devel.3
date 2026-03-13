Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAFE106FD6D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0tE0-0007iV-Ol; Thu, 12 Mar 2026 23:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0tDy-0007h6-JQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:30:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0tDw-0005Gt-Sn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:30:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48534b59cf3so15144225e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773372603; x=1773977403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uILkvwObm2UG4BpSSPgUi+Ar6Tw4FxgxPpSYUomHeQs=;
 b=oy4U/yzqFrmgbALJUU87ud2DoKRtCj4V4p/iUApMDnHF9tvy0Rug6/zEF6w7+Op5yu
 iWbqj89GJ2UFGSLvt5s1jJ2q2t8qvSm4HTnZwYhtn8uzNZPfkiIHfa/ZNkm4irH6FLNI
 D4xm9ujCNv0jNieAUuCGe9ueQugDa6znqQoFUQ0GFj1fUO49gHD/7y+7MXRe2Kz8I/F3
 GftLBsHGR/Nrq0FX9LeNSwNMinO5NIDxrHFc/2xzNNLXKrTlO9qjQs7bTt52QWgsCiVq
 ubXcE/rjq7JHGc8Ygjdq/oC58Y10kI/HmV9OY0CqhU0BgNKwx4JZ9x1CPuNvQG+pOhkb
 CetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773372603; x=1773977403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uILkvwObm2UG4BpSSPgUi+Ar6Tw4FxgxPpSYUomHeQs=;
 b=O1Elcus9msPSovzY4HnIcs3LLi9yxTSuekCmwvIEF4YlMmHg+n3EBL/LImb41xpIPB
 pJOKEnXUcoepbZENH7qVCzbDQpooF/5RIFFcR0iC35Dpd4fg7Rr+bjBhQiaaHtp6BYbu
 uGakHvoM2HkY8ByxqeI9V/GmUuQl0wqV9qYrxtd0kUNx6MVRZoOFXiiHN8Js6VNQF+ll
 esZ1dpSShS6mhzFDBC4rHFjFJWLOIBYH/IK9Q/4/zQ+RDRwot/WhpjSj1YoDINE5eYEC
 Ko/sCDp/SnhUT3PpsCcgQvG4Br2ZC3cZKCM9L6thAwpo5Pk9UMPeZR8FYTZx9w7oTybg
 xEUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJbusYrE0X4flys613ikq6cPU/yxsw44u/bGOeYly4lBcL1HDkSXQBCnc5Wj/+oxVFNSEnEubYuqH7@nongnu.org
X-Gm-Message-State: AOJu0YzLmhz1u/RD2f0OIWf0656ctAH/v7EofgNYOcktvUMokyJ2CE/G
 BEw35wmdNxgK9DNidk63ElNig/p/91utmTH09KuWocLIKa4aIYOakzx55TTEpMbum2w=
X-Gm-Gg: ATEYQzwQMaa+zW7wwYEDWjN6Y9N5nV9GZNY4qlYlODso+I/0kZ3mhayQtkdT3aknNn5
 kclyudpvO5SuGOXfWmvk/nZEvSo8Y78zvnU+kTpjyDMqlQ1OTC0zHmFTfIZ+eXuW3ESWNvyxG3/
 O/gxM8dUJ6HqYZ9+H8gQOd98JRWwE4+fkZ8x3S9Q+6CLPULEiis7ikqbHoeM/FzgVF8BUXp28WN
 7XW2SGPpQB3GOsn1ZLW/gZI/g2Fu+pEjUH/XBeWyYn+4kxkUmJqRVMvPcXBDFm4WS7Z0iGXgLo5
 GsSRlAHKEdjD5ko49qCnAG6DPnp/RESI1WIiB1VA80XM2yCt1Jec25Pel3BODmcPX09CzIcfw+5
 Mhkukmnyn0XFBmV9kY4MDpXa58lKcL/lIDOQCt0vxIvj7Q6Sb54Zc8GXTsYRq/uVpIxd4XBSHE1
 TMUctq8NXxeAOwfq33I6RfmEhi2oz91g/CWlh8BVp8Cj90nagli+vu6UcBL4ZwfVpLfnh4/3iZT
 IUA
X-Received: by 2002:a05:600c:a09:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-485566ddac0mr26777885e9.14.1773372603045; 
 Thu, 12 Mar 2026 20:30:03 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fd3dsm180089255e9.10.2026.03.12.20.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 20:30:02 -0700 (PDT)
Message-ID: <b884f2d1-51a4-4d41-8892-d5311e09b219@linaro.org>
Date: Fri, 13 Mar 2026 04:30:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] hw/vfio: all vfio files can now be common files
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-9-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224449.1605071-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 12/3/26 23:44, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 06e24122c5c..4553aed6a6f 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -20,7 +20,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
>   vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'),
>                                        if_false: files('igd-stubs.c'))
>   
> -specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
> +system_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)

Yay \o/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


