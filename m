Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDE6CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 12:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up440-0007gQ-5q; Thu, 21 Aug 2025 08:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1up43m-0007eT-50
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 08:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1up43Z-0003yG-OK
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 08:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755777965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W7ePDPZtFOyie7Xoq8Sr/Nyvy229UeRBnB12FjONwrY=;
 b=KvRaLyy+7t/gm/X4tw1rxidFXvosUcBXDNNHfu1Lgob4snc1wSjReh75+KlpClpxrN44Rz
 ajYetYeu16cUVuiTnuJe65irxA4LJxLxyynwO6BXVnbDcyxiTlxmMUk2a79/MldIJ9IR3a
 7DrrWBFAcu5qtKO2tiyXHSHLwk1uZRY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-aiqG6eRuPbq52w7CLCLSoQ-1; Thu, 21 Aug 2025 08:06:03 -0400
X-MC-Unique: aiqG6eRuPbq52w7CLCLSoQ-1
X-Mimecast-MFC-AGG-ID: aiqG6eRuPbq52w7CLCLSoQ_1755777963
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70a94f3bbdbso20196436d6.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 05:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755777963; x=1756382763;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7ePDPZtFOyie7Xoq8Sr/Nyvy229UeRBnB12FjONwrY=;
 b=svNpLGGX399h2WgfzJpLr9zDJxaZXRaot9BdKnocb/6qZlxK+gfSD2ZEQr5pq1AoSI
 32DNB1+RbQHdsPAQHcPrXMnilPzHDLFrcHipSPB8MS+UFIR7GLmZj1QFCWjNCnCpCavd
 NVZuvPuMb/LxXNnvc3gIVXyCmNKPNI5GuXDP15PManMkqk8YrgY53Q+2w+d9+qK+AN+r
 LlM0m4VVm2bMmkNnBv5HKyQdEeGHAFAkA15ELJqex5d7rFVt+W3cNR39ZXKD5ZuaW9ws
 Xnmtdf/jKbWJ1penUoYvEcehOn8pE4rhTMtcvClpU2ugsabDv/Tx1LTVx8Lr5gimTSr+
 B1Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCz5RcLMeGPNMm3CWn5fv8gaP5dweFb8kJ8hr1oSDOzSY4nFxRuwmeMp56qe36YI1+MH+TS2orcPIk@nongnu.org
X-Gm-Message-State: AOJu0YyXwnqgzsB1ck+nCF7eWh8AVJ94300nF62eAi7fiJ6W9ltCXFJM
 jU/mjA/yXMyE5ZJRbBjCdHhyQWm+kuJ5Wy2EH3SKgOrMe8O+M1IhdYt4hAtIFv77oHNEhOYkuNf
 MTxAKiTRVZlFbHtg5S/i+UOMjqiHuxz/EILjU27HKm8mIC5E32SECrUEe
X-Gm-Gg: ASbGncvxYbXHZrALzn2lCvqMTdeOIUW+rUnGfGJRRTSiLqcxWQWduXjtCa16tGhvfMZ
 sBbI2wYT4pIhEFVPVTmazLhVLsaMreizusotVcY6SnWN3BRpIgfNMy7Pr7/UAFx6Eh/ZsBNc4Cs
 KQgWcE3YnAQwGDoNz8KKjZyIryTJGGXt2VUB0EX5xvnaT2wm9sJQHrwKBguJKm9eEdo3758Fc4h
 IDjLY347Yxiq8PMv/xHL8r9fGF6klWFMJ0dDoprq/5XkZvwxgOHVV/GBBRyzKxXuBxwp0Oo+2am
 WLZfhe0TPOfU21plbrBRAC64itgnTz+q5Dkrd/fFwu23nikp+5lgS9TWcYPoJJP/KeoHhM8GIDP
 073M=
X-Received: by 2002:ad4:5cec:0:b0:70b:a0c5:5688 with SMTP id
 6a1803df08f44-70d88e725f3mr23057026d6.8.1755777963195; 
 Thu, 21 Aug 2025 05:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK7674djb/kJDq8AThR2+k5RjpictDvH2XYahN5w3VaUjk3A4G6cjl8kKagcM8yoD78wAGBA==
X-Received: by 2002:ad4:5cec:0:b0:70b:a0c5:5688 with SMTP id
 6a1803df08f44-70d88e725f3mr23056266d6.8.1755777962578; 
 Thu, 21 Aug 2025 05:06:02 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-073.pools.arcor-ip.net.
 [47.64.112.73]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba959f401sm103670276d6.69.2025.08.21.05.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Aug 2025 05:06:02 -0700 (PDT)
Message-ID: <f7a8b91e-e2df-4c11-818e-f244f8e648ad@redhat.com>
Date: Thu, 21 Aug 2025 14:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
To: Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250820122516.949766-2-adityag@linux.ibm.com>
 <3xbdwul3qwdb246pk5xeeduotfvyeyjr6qkozzatb7h2zdrxlb@pcuu3ewglrjj>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <3xbdwul3qwdb246pk5xeeduotfvyeyjr6qkozzatb7h2zdrxlb@pcuu3ewglrjj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/08/2025 12.53, Aditya Gupta wrote:
> On 25/08/20 05:55PM, Aditya Gupta wrote:
>> Currently when CONFIG_POWERNV is not enabled, the build fails, such as
>> with --without-default-devices:
>>
>>      $ ./configure --without-default-devices
>>      $ make
>>
>>      [281/283] Linking target qemu-system-ppc64
>>      FAILED: qemu-system-ppc64
>>      cc -m64 @qemu-system-ppc64.rsp
>>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_load_sprd':
>>      .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined reference to `pnv_chip_find_core'
>>      /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_store_sprd':
>>      .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined reference to `pnv_chip_find_core'
>>      collect2: error: ld returned 1 exit status
>>      ...
>>
>>> <...snip...>
> 
> The following is also sufficient to fix the compilation issue. Wasn't
> sure if #ifdef POWERNV looks good there:
> 
>      diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>      index e7d94625185c..a8e55b2937c7 100644
>      --- a/target/ppc/misc_helper.c
>      +++ b/target/ppc/misc_helper.c
>      @@ -323,6 +323,7 @@ void helper_store_sprc(CPUPPCState *env, target_ulong val)
>       
>       target_ulong helper_load_sprd(CPUPPCState *env)
>       {
>      +#ifdef CONFIG_POWERNV
>           /*
>            * SPRD is a HV-only register for Power CPUs, so this will only be
>            * accessed by powernv machines.
>      @@ -361,11 +362,14 @@ target_ulong helper_load_sprd(CPUPPCState *env)
>                                         TARGET_FMT_lx"\n", sprc);
>               break;
>           }
>      +#endif

I don't think this is a good patch, it likely always disables the code, even 
if the POWERNV machine is available? At least it lacks the #include 
CONFIG_DEVICES that would be required here.

  Thomas


