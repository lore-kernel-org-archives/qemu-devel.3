Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EEBE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 18:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX2Ir-00064c-IF; Sun, 12 Jan 2025 13:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX2Io-00063l-LH
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 13:03:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX2Ik-0003Fe-Dh
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 13:03:09 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso25694825e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 10:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736704984; x=1737309784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ckv0ZWFqv9cvKjhFZ8F28eYMCGigyV9kLOgoIM9p0IM=;
 b=Qrf3HwfLJ2YfwSTZ1A9h3EwdQXTCk85ZonatTim7DUmv9RvOffOv9laKhXlkteLuqX
 5NstWNfMXlp38S7pdsYoo2AfesViK87nrripljOwPB5pVWy0jDyT2UM8OvZNJT919pmT
 secTrs7/jZMiJOvMt9gT0ZR5/6W8njsFAkrWKZInZCMe1C2zTY1qGaW7EoZkOQWOZOvy
 H5bf9eeziseOunc/mjGrtqAzs9ZFdJ8ub8k0ypBwAKaEIBvMmcbBFXwowk5XciCAVFDZ
 0G/Mfk3jYsLiwqzjqFiOj0Tx2E5PKNnGRDiQgSdNi+8pg5K7bU+XWXpmZ2KqES2vIePt
 l+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736704984; x=1737309784;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ckv0ZWFqv9cvKjhFZ8F28eYMCGigyV9kLOgoIM9p0IM=;
 b=RUxfRnr3+zpy1JNfQp0SK+cLWSFGDvUJAuRy76yllhHVCVstS/7/wfdkkJzo46bldW
 9Q3Py0qfo3gHRKnwUaQGaBm/FCIpOQdn5/e5OquUGG+z01puNAvLucGS6HE6jbWk9pQe
 3jZh9FkA9Pl581dKY0yMQRlog8pbBfygzhGM4qa8mTGgvYzh7kscrJaSruxBkXAw4s1X
 cXDGqc0JWUUjJAh1rMY4A9CHb1DI9yZymqlmBba7JUyYgxGkbhDHcsARGhJtRSfCtQ5g
 OuInZl/oMQryyoK0MsYgDT+YzwqOLIL8XF7UZMWTH2i/KwA36/q93uGv6k1uHh5TB/UX
 GSOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY18uGGP+4ZVx1+aCBmAd+3dC/uDPBkiPhs2oqoJjtYPMt3NVKS13++aTD2cgMtYvNnDpRjeMZSKJc@nongnu.org
X-Gm-Message-State: AOJu0YzN2+5asH6ajpXzVQy9dCaHqSybNXeldBXCcV3SVaXvzDy7k334
 HEcp65oLGxTvXOo/z0V3mlmAvcSq34F5YamY24WJdnWx0OZAzKxReAij0TuF1M4=
X-Gm-Gg: ASbGnctgz1QdaPz5WS6GWGGSs5n7RHO7zK1U7DbASsevtnTUR2UJo9GPhK6YZCmjX9g
 +3FaC97VQq9F5eTNq5hccfh3qYSgam4QUmaKISsVJ6fsfIv3rMRHpTk91fvslLrIav4xkA/m10w
 Zd6AZ86JmnYBBQO9MMxzj2VOtj/Cd/38/xRhSLMsJkF7ptsT1TVI/1hz3PZp0Nlu+AWQKVIofVn
 DBhWNVSv+ObYLqNNGHtYC/d0VLXWIoFmARyb7sfWM8eD9CAC5IqfxsD+zm7dLCsmumMiKSDhoXk
 MZv56xZFX67X2F8YvZKKSh6y
X-Google-Smtp-Source: AGHT+IHAp+PVDTIW9axVX3Ngf6oEC0zL3D+8eLsGhicrbKoBGZP83klyAaEMKP6Kr9HWc13QGUQsqQ==
X-Received: by 2002:a05:600c:a09:b0:434:f1e9:afb3 with SMTP id
 5b1f17b1804b1-436e267863emr153977885e9.3.1736704984108; 
 Sun, 12 Jan 2025 10:03:04 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da65a3sm154716235e9.7.2025.01.12.10.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 10:03:03 -0800 (PST)
Message-ID: <faa861b8-6bac-4410-a5b2-032c5207c148@linaro.org>
Date: Sun, 12 Jan 2025 19:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <73fd2f38-76a0-4274-875a-6f96faed79f6@linaro.org>
 <bc22d713-201e-414c-838e-6c0dc1fb3807@linaro.org>
Content-Language: en-US
In-Reply-To: <bc22d713-201e-414c-838e-6c0dc1fb3807@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/1/25 16:47, Philippe Mathieu-Daudé wrote:
> On 10/1/25 21:37, Pierrick Bouvier wrote:
>> On 1/10/25 12:33, Pierrick Bouvier wrote:
>>> For now, it was only possible to build plugins using GCC on Windows. 
>>> However,
>>> windows-aarch64 only supports Clang.
>>> This biggest roadblock was to get rid of gcc_struct attribute, which 
>>> is not
>>> supported by Clang. After investigation, we proved it was safe to 
>>> drop it.
>>>
>>> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and 
>>> aarch64
>>> hosts.
>>>
>>> v1 contained warning fixes and various bits that have been upstreamed 
>>> already.
>>> The only bits left in this series are the gcc_struct removal, and 
>>> fixing the
>>> plugins build with clang.
>>>
>>> This series is for 10.0, as we decided to not include the gcc_struct 
>>> removal is
>>> 9.2 release.
>>>
>>> All patches are now reviewed, so this series can be pulled. I'll 
>>> report that to
>>> MSYS2 too, so we can enable clang environments for QEMU.
>>>
>>> v1: https://patchew.org/QEMU/20241031040426.772604-1- 
>>> pierrick.bouvier@linaro.org/
>>>
>>> v2:
>>> - drop attribute gcc_struct instead of using -mno-ms-bitfields option
>>> - add a section about bitfields in documentation
>>>
>>> v3:
>>> - explain why gcc_struct attribute matters in packed structs in 
>>> commit message
>>> - reword the bitfields documentation with suggestions given
>>>
>>> v4:
>>> - edit for bitfields doc requested by Philippe
>>>
>>> Pierrick Bouvier (3):
>>>    win32: remove usage of attribute gcc_struct
>>>    docs/devel/style: add a section about bitfield, and disallow them for
>>>      packed structures
>>>    plugins: enable linking with clang/lld
>>>
>>>   docs/devel/style.rst                      | 20 +++++++++++++++++++
>>>   meson.build                               |  6 +++---
>>>   include/qemu/compiler.h                   |  7 +------
>>>   scripts/cocci-macro-file.h                |  6 +-----
>>>   subprojects/libvhost-user/libvhost-user.h |  6 +-----
>>>   contrib/plugins/meson.build               |  2 +-
>>>   plugins/meson.build                       | 24 +++++++++++++++++++----
>>>   tests/tcg/plugins/meson.build             |  3 +--
>>>   8 files changed, 48 insertions(+), 26 deletions(-)
>>>
>>
>> It would be nice if a maintainer could pull this, so we can get this 
>> merged upstream.
> 
> That'd be Thomas or Alex I suppose.

(That said, I don't mind to merge if they are busy).

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

