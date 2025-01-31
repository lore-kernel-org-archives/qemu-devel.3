Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7CBC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 18:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvqB-0001zj-Vl; Fri, 31 Jan 2025 13:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdvq8-0001uy-FX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:34:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdvq6-0006AP-M3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:34:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so26896325e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 10:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738348441; x=1738953241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1D+FCFTB8BtTwBlKT8TVGB9qJrpM7llucuSHbkutsqc=;
 b=T4cKenK7LhqBx38W2NZT5GsF/Amdlrb6DMQAK2fUClYtu1R/KenI0l+/XiQ6+bKOP+
 nHbJxqZi8thIOTozOT18rzWILWRFx7lXEHqyEoRRDk4RMCloJJB650S1eNu+yIVLNbgJ
 CTU/QSXG43yW3Ot48+S2xCf0aa/MhhBULLB80wkfX/re977ZVAdt+uxT2gZKjCMZVFTW
 29KnfPWGLDO9mvFrQH/6z+yTSZI0M0V8Ph6rNfh0J8t5k5QpUMuPncHT6wsw5nC0Gy9d
 lI64zLrpOu29z56rBuMEeHYUkHAqaJVr6xclA8hV6aASRpQKmNpJCY8jevjIMPCkqQGp
 FJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738348441; x=1738953241;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1D+FCFTB8BtTwBlKT8TVGB9qJrpM7llucuSHbkutsqc=;
 b=o0b2SNWnRVp+uJp7WL42xL2WdVewrwExUs3Obn6/EWMLyq4XEQvv+ENMLDjYDpSras
 u9K/5GB6QS6b6rL+2GytPfgzKwso+mNWkc9bvQHPgKr461nTjutSLt2jnUmPzO/YZHzR
 Mz0TvjIty62z5vENDZXMljixJ8mDQyFau9m/uoY+Qcxrg4/tef9g4fCCArr286qTSyua
 hHIW3LOBhelzXKeDMl4ooOkU98z9yy5WoYjgwyEBzOU3Q05KfDp7xbW76AK879qWmjVF
 exkMTAuFnGldlt/05gbY4ehiTGw2KvzrKnSrkgxoZp0JmsOBAM3WwVlG0XODkyFuRJZi
 kFzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/olK512Ib/LUE8eGRVLYvinP0ysi/KPVOR/f6MRcD06KmolEQMX+8/O0vnN25j4LQDWHxjDTH2cKG@nongnu.org
X-Gm-Message-State: AOJu0Yxm4XPstwZ6xpoW4vU3HiHJ6HQyBCHhM6ZWixhdvKIq9oIlrCeC
 GPpWw4jy3IjbO8ko23vtnEwcH61XBy8RB58YrzaaGqyJJifGvYK3L8byQS+uS38=
X-Gm-Gg: ASbGncs2Hh4CMfzrqegy/eFOnPO4jncq5DTIortwN6GTCV6DPwthEj88fmUirYINLOe
 v6/1qGNZ2tzn4GHCf22nN2lFPyXUqT//+qLOV9ChsTPr1/PLip7rQCZgWUmn4P1DSSm48bQI/Po
 cxDEXqOziZAS8VT6tA0eB7pJPYm2Ks5dcNTv4cR47M3438CBdLGUNVsdKqOvTN73e9JFkkTqtag
 O0l8sLEbQvwI/bX/VRFW6ijXhbUPmeqOK75k22ObvH6j5/ohz5xDaeOikFbF2QWS60QDydMZOzu
 GqMBvx0/um2K7k59TBHGI/M5GNOa3Ir3t6jd/aFtItEY1wXmrcJ2ChOYVLo=
X-Google-Smtp-Source: AGHT+IG+R6CwbDMJPuZr7KHT5zR/+ikzI14PcFIX5ca81Oi9vDgmpvd0d2BXZkO2vk2y0dfgsY0Lfg==
X-Received: by 2002:a5d:6c66:0:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-38c51932163mr10470236f8f.2.1738348440961; 
 Fri, 31 Jan 2025 10:34:00 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c12164dsm5242509f8f.48.2025.01.31.10.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 10:34:00 -0800 (PST)
Message-ID: <f16985e1-ecc5-4439-ba4c-f9a6a4d06d10@linaro.org>
Date: Fri, 31 Jan 2025 19:33:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add me as the maintainer for ivshmem-pci
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com
Cc: alex.bennee@linaro.org
References: <20250123012212.716499-1-gustavo.romero@linaro.org>
 <35e2dcf5-d1d6-4326-90cb-22dc82023bed@linaro.org>
Content-Language: en-US
In-Reply-To: <35e2dcf5-d1d6-4326-90cb-22dc82023bed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 24/1/25 17:22, Philippe Mathieu-Daudé wrote:
> On 23/1/25 02:22, Gustavo Romero wrote:
>> Add me as the maintainer for the ivshmem-pci.c device, the ivshmem
>> server, and the ivshmem client tool. Also, adjust remaining parts left
>> behind after ivshmem PCI device was renamed from ivshmem.c to
>> ivshmem-pci.c, like header files, Kconfig, docs, and build scripts.
>>
>>
>> Cheers,
>> Gustavo
>>
>> Gustavo Romero (2):
>>    hw/misc/ivshmem-pci: Rename remaining parts for consistency
>>    MAINTAINERS: Add me as the maintainer for ivshmem-pci
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> and queued, thanks for volunteering!

Failing to build:

docs/specs/ivshmem-spec.rst:17:unknown document: '../system/devices/ivshmem'
ninja: build stopped: subcommand failed.

docs/specs/ivshmem-spec.rst only mention PCI, so I could squash in the
first patch:
-- >8 --
diff --git a/docs/specs/ivshmem-spec.rst b/docs/specs/ivshmem-spec.rst
index 2d8e80055b0..e326d024487 100644
--- a/docs/specs/ivshmem-spec.rst
+++ b/docs/specs/ivshmem-spec.rst
@@ -17,3 +17,3 @@ get interrupted by its peers.
  For information on configuring the ivshmem device on the QEMU
-command line, see :doc:`../system/devices/ivshmem`.
+command line, see :doc:`../system/devices/ivshmem-pci`.
---
But then I wonder if this document shouldn't mention the flat
device. Since I'm unsure I'm dropping the series (patch 2
depends on 1).

Regards,

Phil.

