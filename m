Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1A3D148A3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdkXA-0003cJ-U2; Thu, 08 Jan 2026 02:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkX9-0003Zo-0S
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:34:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkX7-0002zW-IF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767857653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l1Q9WiFf2qRRISZ4La2p3rs/OKOgR1j73GDgTJVIfK8=;
 b=b0EGfExBd8J8c8TC4YSEL9B+SVnDzQCGTs+gbBL/xiWMYTazFK0gq2QMVzyfeRx2eKblJN
 ftheqS7gbQjAarHvoEIGzxMgAit+br4pXDZYPMm/LMccka5ddb8pSZxd2wAnKDE7x0Hnxd
 m9KM8wByaM+FPl06L7iH7+Gj8rcLivQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-OKAbLbkGN7e4gQTQ-DtSAA-1; Thu, 08 Jan 2026 02:34:11 -0500
X-MC-Unique: OKAbLbkGN7e4gQTQ-DtSAA-1
X-Mimecast-MFC-AGG-ID: OKAbLbkGN7e4gQTQ-DtSAA_1767857650
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so25087055e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 23:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767857650; x=1768462450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=l1Q9WiFf2qRRISZ4La2p3rs/OKOgR1j73GDgTJVIfK8=;
 b=fWgqCs6x91F51ChzfSulVvVdOLuYSDiq7xw7rb8pTuJHJRmNzF7iXKQBFgN2R4p9CE
 68y/dC2P6T39dyMmiwJ13RUG5I7aiW30vmkRdbnKlmCzZL3TYqEv6XXNy5RvqaIinttD
 PfVjqzSp1luFRqdpD2pXrFuE6bE6rlswUSlGWxtznMJkQcfMxSWvqvn+TsirU0eg3Eci
 drPy1KuwY41tyibazpaDcQ48glMSgDjvUp4uCZbqbs1LzcWSRdrBaeVVCh83iuyG4aWj
 1Qv3Fp3biz7CveQ/DBTftB9TkuamWIGbm19UfvaA9jxgSyXA5Obd89hvZwDuoVn2Iuwy
 3G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767857650; x=1768462450;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1Q9WiFf2qRRISZ4La2p3rs/OKOgR1j73GDgTJVIfK8=;
 b=DtDpCzCg9dc6BBLO6xuub5RIZAEX4OZQPJLd0zELoh3cFJOK3PBExHtz39KSypJ3sD
 ImOQ/ivCJVUg763kXHxdO498At0iAYdpOdH+GH/4CE2uQZMbtmi/rdIRVUj8O4ZWvG2P
 ihLazA1tlVa6iKO560y8F9S8xMnpWOxfXIz8sT9nuETbYO1IItgd9cvZO8s0FpkT4lQ3
 +9HL0EKaswv4sOk1zHsX9tRFmT98Eo7Ev4BoFaJ3j63wKOW9Z6wfRloUBs6dpoYAhGBT
 UR/jWDIdOE0r11rZlj130gYUxYrt9kG1L/wtfXOGsJ9TRD2/+pOvIfzUgBBLZYa3IliT
 4Q5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK9oNuAicFfMVUotmCSrTjDMXUI2MMhNsuhVbyAoqkICzKYQKjCAFgLmMviRED3dM+ZyFM+itOIYMK@nongnu.org
X-Gm-Message-State: AOJu0YzVEROHuIF4K3cxyJhoqxRnGuDBr3ATTk7S6YRVvi5uHiUarmUL
 4bOk1TY4ISckSxtUuc2qOQpYxqzU97LjfUyT0D+sHQY0n7beb/z30haxwWGOB5VvWM8gF1Y1P6Y
 VmKFvRqDgiM0UIP3hpBWC269Sfte/bAYY/zkr9R0pSoNml1cIvI31RVNm
X-Gm-Gg: AY/fxX5CQaMiUhjXCFOyhUCxln+9TBRAeym8dBiTVYLWv3ExvJkKqz0QKGHVOfch2or
 vC2vI7jqI1MrPCcL2mqdHEFyVDHJ94Z5JcJWnDsftpnyKIIsYQVfy0o1JNOA2kF2u86Hduc2l0q
 uTRCEzu+rCBXYCD2P8OCsdWX8EIz9slvrAAg7nv9/9b8nfq2DGlM/O4lb/eqr6TUad14XNI/F2G
 cgfX3Tds3kcCNEHaB4iZjpsxX+/Z5/KZ4DpHoz0pScrGcl+aojxMvw03zTRkEVPiewWaoqPr5Ze
 6LO3W/ePkVCiBOjJngLpTpl1tTfJPJdnikS/6Wd0ikRTkX/H3Y7pGsSNMbrogbG0pvznx9s+//M
 SJdJpRq8=
X-Received: by 2002:a05:600c:b86:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-47d84b41007mr62166325e9.36.1767857650310; 
 Wed, 07 Jan 2026 23:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf5gvK27R7QhsjmAy0aM3arcvkhElWSiKuPenP8m9QF+txpjXJgU3pWb2AWjsLOvt0UjejhA==
X-Received: by 2002:a05:600c:b86:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-47d84b41007mr62166035e9.36.1767857649956; 
 Wed, 07 Jan 2026 23:34:09 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e17aasm14981196f8f.15.2026.01.07.23.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 23:34:08 -0800 (PST)
Message-ID: <880beefb-a3b2-4e41-bb05-35de14803492@redhat.com>
Date: Thu, 8 Jan 2026 08:34:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] target/s390x: Remove unused 'gdbstub/helpers.h'
 header in helper.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/helper.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 8d1e03f6768..a6c89ed0af3 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "s390x-internal.h"
> -#include "gdbstub/helpers.h"
>   #include "qemu/timer.h"
>   #include "hw/s390x/ioinst.h"
>   #include "system/hw_accel.h"

Tested-by: Thomas Huth <thuth@redhat.com>


