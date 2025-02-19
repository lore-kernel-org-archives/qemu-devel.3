Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4C4C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp0J-0001aD-VK; Wed, 19 Feb 2025 13:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkp0H-0001Zq-SB
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:41:01 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkp0G-0003L1-58
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:41:01 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f378498b0so111734f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739990458; x=1740595258; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/OtqSjXbagUnsCid0/oHn9PhLNKMS6msEvvBfVR4XB4=;
 b=TX0uxCbSpn7NfwwMhX3idX1nJkCD2wCrUvR+3tpk9xrUKgB1jHebUifOfjZhoEP2LO
 ZiLB0dq4/koC8Wa0SmqCtqMiHmJAqo5xYUuWwFOGN1EPHV028yYjX+ht2WJrq/cvLRSp
 GG7OspGQ5DLwa5JY1H4Eszrm5VaKBM8ZWZXvMy9BO1V++6CcZRAosZ4JiHyFdNR/MkWD
 ogmGB3wB4mAywlMM5ovHlltUOAGNtObEFlpRgqmlwQW3mXnU9m4LfR2/LvyuesMCdra0
 p+OIP07ERUAKTkNO6eGINAlyg+htHPzgLowvKoruDEftD18kTueFNOQpF6nakHUTmcBh
 A2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990458; x=1740595258;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/OtqSjXbagUnsCid0/oHn9PhLNKMS6msEvvBfVR4XB4=;
 b=fXX11e+hiLi/GboMZDwQ+fXMjuyBFcWD63R594z7tOxyOzjNuaOZzG+N2hE3SmAV4R
 OX3pRKP7Pryl6ZPvpnYQQxCAI4tlGijVS1dO8n2SifJjk0RQL27dkM2lwp58GA9571Qj
 ++mRf4TmzyiDoypa5FeMMjX5ZwjsvBFPKkX+pp5hdZsnMJLRkjJB0/3eNuR9qQvAXnIl
 niTelBwpbtb0H4AoNo6qmNNQHEs9uxv1WsqfRCfiZymFsOvIB7jFaw+WZTDliZt2Bldf
 DTLZpp5DjDiT1ag0Ceqy71a1i6+uWovTe4F9njVgTuvF8Niu5O55ODAjsXECJ6zb3fbF
 oNEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgpd1sJNVCgrmjQ7aFQ85EkmNE+0JNj3g4SJAv8lOprhUjF/UwY1xiDOK8w+PuVmiUVteceWFour9N@nongnu.org
X-Gm-Message-State: AOJu0YxNpUJyd5JDjYWLNIig2J+AjE4lr1IVxFMDoma52VGACMQbyaG0
 fVaZWMeHKy7DH+XqKVyaGeKimxll/TW3XsVC+xFBUpJL8/mMh8Ru
X-Gm-Gg: ASbGncsfriw2uDQeCxA8alXGfsvpqu1Buqr7yZBnZT6E/XCEM/212ahgv7Bh3D9irZ2
 er9mR35x8bWvqMvPUkXRC4AJiK268tZu056o3CQIjWKeuwaLp7FfFj2+pvCXzXEXyUyOxjYD3vG
 WzjP/IVn+2rA8BTPf+L8QeX8biZV4IyycO/M1orZjUldw46stfAsoBV0KHUeTeBxcxFotVgGCvh
 AvHMvcfqOx3nPGRZOP3BCM4N+yBxFdxm8A6fhdsN2pDYTYtpxQbyTwxWhvImSeTlCS6NGMLmGY5
 LcogjnbSx+n4fbLOsqZ3/d0lI4M4YZbpfK2YQaJ7Ft/ojNaskwnr7tCc36M7WznW9Iw3q6bQ
X-Google-Smtp-Source: AGHT+IHNWff6bm6fcfE+5ecgPtRmmGb/q23mIiPvzoYQd4Fg1YiKPesnVQ/LkhSh+kZVSeG/Z0273g==
X-Received: by 2002:a05:6000:1bc1:b0:38f:31b6:4f30 with SMTP id
 ffacd0b85a97d-38f587ca52bmr4213709f8f.35.1739990458369; 
 Wed, 19 Feb 2025 10:40:58 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:ee78:9ac0:bfb1:1189?
 ([2001:b07:5d29:f42d:ee78:9ac0:bfb1:1189])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4118sm19010299f8f.18.2025.02.19.10.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 10:40:58 -0800 (PST)
Message-ID: <4ec0652b387427cfadaef796ae9162921115bf43.camel@gmail.com>
Subject: Re: [PATCH v7 19/52] i386/tdx: Track mem_ptr for each firmware
 entry of TDVF
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti
 <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,  qemu-devel@nongnu.org, kvm@vger.kernel.org
Date: Wed, 19 Feb 2025 19:40:56 +0100
In-Reply-To: <20250124132048.3229049-20-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-20-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=francescolavra.fl@gmail.com; helo=mail-wr1-x433.google.com
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

On Fri, 2025-01-24 at 08:20 -0500, Xiaoyao Li wrote:
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 73f90b0a2217..8564b3ae905d 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -12,10 +12,14 @@
> =C2=A0#include "qemu/osdep.h"
> =C2=A0#include "qemu/error-report.h"
> =C2=A0#include "qemu/base64.h"
> +#include "qemu/mmap-alloc.h"
> =C2=A0#include "qapi/error.h"
> =C2=A0#include "qom/object_interfaces.h"
> =C2=A0#include "crypto/hash.h"
> +#include "system/system.h"
> =C2=A0
> +#include "hw/i386/x86.h"
> +#include "hw/i386/tdvf.h"
> =C2=A0#include "hw/i386/x86.h"

Duplicated include

