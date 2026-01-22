Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4B1C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virxS-00066U-0x; Thu, 22 Jan 2026 05:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1virxQ-00065k-NK
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1virxO-0002kB-Sz
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769077829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gm3300A4RCzEA5Ws2FiopQD8Zriwzalue3a678idUGY=;
 b=WXWJaYMjHzKDW0E6r+PVl8CUR5ljbIMyIdHH2vj+mE+MqLNHxORSlbiIsAVTAY92UCCXDG
 fp0Swl0/CO6e8nq/IPAUnLjkpq/HXwDDt4TSKc7GdWHb3Vqag9MA1sh2c7ulteDjRDBnRo
 UItQ92WqZcIgNa31fx0Lq+/neY8uSRU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-E6PKq5lTPciW106vDhTH3A-1; Thu, 22 Jan 2026 05:30:26 -0500
X-MC-Unique: E6PKq5lTPciW106vDhTH3A-1
X-Mimecast-MFC-AGG-ID: E6PKq5lTPciW106vDhTH3A_1769077825
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso10197315e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:30:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769077825; cv=none;
 d=google.com; s=arc-20240605;
 b=FGqN1jGYPmG1YFAFWs1m6w0SOSDwByaZksINrorpojPP5aaz5Wzucm3QyqVFOxTizi
 C8dFujOwZe/u8O29Vobu3k1F1p77YTr/ocJISnSkFAyOuV7U1LJ3RBuv6rGuSKCTAkRT
 awWxq4UslZtBSWBn5ovJACWqtmsJEaVWD9nz5MGJ1hdFnDmL3ckKIHpilOBdaFLYHM3e
 RpxtBOuG0z/KWr+Qell0qRC5A6v7coITCD5NeTFdBY1htNICvICrS3WPV9Fdq0plQnqx
 4rRagPH//JLgLIHc4QotSWcoKmj32eb2CEOS+b+3NE/dpBl/TjTEj1vnOCgJ0Rz5IXo7
 pj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gm3300A4RCzEA5Ws2FiopQD8Zriwzalue3a678idUGY=;
 fh=g8lN49QMoUUSNKoH8Ldz7lY609QJW2pnBMIVIA9kdsc=;
 b=iH37OL5N9yNR00q0iCpbltnXif9TXtnNP/uADJbadkqmRGXWANnxVhOhM8Qetr3FPY
 2mYRO1vgLSRmo/LQJs32t3Mm2Mp4Si2l1JF5rCchrATH/Dk6sFEPsgmK51Y4H12GdkaS
 g/27hIlSks+K0mhXRgfDsC8vbK2zuaLecaCBOLXOBvKuv04Hk7kitOXPOCT7++JVC8Bm
 Fnl7THM+8DMiR7ZzT/f2HbPtHHKgl8WNji97H8L/fxhw+KEHeAYZMOW27hwWpn3F85Ir
 5dlTAAgSPqXJsQf0I09WVVVn3wlrLaMgCiMYAMgZQaytHnv2qkVTQgrHgKMECCdsNWL/
 cl4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769077825; x=1769682625; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gm3300A4RCzEA5Ws2FiopQD8Zriwzalue3a678idUGY=;
 b=Ns0zI5YBcRCm3OOyaPnTpAWsqZiB94Z4O8LziohRX1gwusmCQOG2bCGJAsZbF2MHSA
 pcrj2MGl74vP5qNxk4B0/9xHBnpGgFl8qxMmnL3ji69m3zshqUOKq3fknCq1bjPRuxhr
 MwipON+fVCGEANHBmCCQgwwjpSR3I6LfIkc386pmhSQ4TCx2R1xO1UXQnNwdsBkqe9rN
 qxM0aacjUpgAfQ1fP9Ct+klWqaLHAY4xp+xydPk/ZJ10I/5PT9llXTXl4wy9jtD5ttwm
 I0lQ0rzCvEJfFgAlzZi5+5aFedGjt9Ye9GRQpl/DfRxXXB3P4AIEYMZzkNXjfAl3n+mZ
 yiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769077825; x=1769682625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gm3300A4RCzEA5Ws2FiopQD8Zriwzalue3a678idUGY=;
 b=G1umLIMB5zSC6An8gVLOCoy6wR3ohjtYpgfdyyUAIy1wK2ksbu3M6MTpi1iHslwx+y
 3RdXXDobzpDNfEytSmYw14vfmj+O4vIoPeHQtB2PN4YzXuP10/SuESPuIDWGjwNOgfIP
 5s5WEAGtvGDhtQ9etI6o3vbi7d37Ergr5UG02q0PuINfzDYBZVtulyXJpmE7Y3G3037E
 rBpaiRsBBSxPIyKngBw7nQmwF8HhkNuELuWE53obGuuD9yM/SrTvmKbbfEdSUSUkIOTP
 sQWYrwMjzcJV0EgGML4Rxz5Bh5DVLuB19LuTKo7Qe5r4gtzb+Kv3wyOFBXqA+N54FEmx
 /xhQ==
X-Gm-Message-State: AOJu0YzkMultHCXYPDmsdF7s50LL6kPG7kffa/lFrJXvI6ly9ExDhNmv
 a76MrTjAzQc59czwNoybqXr24SNCVOKmkVzb094M2BBYTPSEni6uOW8NAyBqa+Bo9MGbWKoCCbO
 urO1pRiwFHsb0OnAYA2OplP++ufGnAbRaUWvJMaEQVhbchYjLu9cfZZrSZigUp29J7E0YYl731q
 +A38na2zvEGCRo/iXqonHUfm6G5332M2g=
X-Gm-Gg: AZuq6aKGCB6mirg03E3p5mBqFrFB0nlpU+8SPJBdxQHgIbgAoYF6eJC2+vGQgzMJCiV
 5Fro+YslRpK2uOO9sCKOSaxXxVkG61FbqeU52jckTdLxlTBpsS9rel1BzIKRguaUGE9+kj2RW37
 LsOMja7R+mHV68fx7Zh0xSGMlS7fRibrITjwpRzuSP7HoBLc3pXx+nY8S3C+v+YRFlPKc6S35ea
 WE58IBkPHehT4rS9e0oXEiDbXd5+m3GCqh27q77VK1Q4hnHBSBUQLFK
X-Received: by 2002:a05:600c:83c8:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-4803e7e8555mr123267255e9.19.1769077824674; 
 Thu, 22 Jan 2026 02:30:24 -0800 (PST)
X-Received: by 2002:a05:600c:83c8:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-4803e7e8555mr123266785e9.19.1769077824251; Thu, 22 Jan 2026
 02:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-20-mohamed@unpredictable.fr>
In-Reply-To: <20260121134114.9781-20-mohamed@unpredictable.fr>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 22 Jan 2026 16:00:07 +0530
X-Gm-Features: AZwV_Qiub1mRjDBw2NVb5xUjTSD0YffUAr6Ypyx4_qhURJ7RXzPDMy1LTGd8JQI
Message-ID: <CAE8KmOyFeo38s=HPbdc=gDXFg8-hH4BWUOKissvHGADPBF75OA@mail.gmail.com>
Subject: Re: [PATCH v17 19/21] whpx: arm64: gicv3: add migration blocker
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Alexander Graf <agraf@csgraf.de>, Igor Mammedov <imammedo@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 21 Jan 2026 at 19:14, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> GICv3 state save-restore is currently not implemented yet.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/intc/arm_gicv3_whpx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
> index 9bc036d1ac..a2f8e3c5fb 100644
> --- a/hw/intc/arm_gicv3_whpx.c
> +++ b/hw/intc/arm_gicv3_whpx.c
> @@ -17,6 +17,7 @@
>  #include "system/whpx-internal.h"
>  #include "gicv3_internal.h"
>  #include "vgic_common.h"
> +#include "migration/blocker.h"
>  #include "qom/object.h"
>  #include "target/arm/cpregs.h"
>
> @@ -204,6 +205,14 @@ static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
>          error_setg(errp, "Nested virtualisation not currently supported by WHPX.");
>          return;
>      }
> +
> +    Error *whpx_migration_blocker = NULL;
> +
> +    error_setg(&whpx_migration_blocker,
> +        "Live migration disabled because GIC state save/restore not supported on WHPX");
> +    if (migrate_add_blocker(&whpx_migration_blocker, errp) < 0) {
> +        error_report_err(*errp);
> +    }
>  }
>
>  static void whpx_gicv3_class_init(ObjectClass *klass, const void *data)
> --

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


