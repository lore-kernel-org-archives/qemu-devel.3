Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAB8C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 15:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgn00-0000Rx-NU; Wed, 21 Aug 2024 11:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgmzz-0000Qj-BK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 11:11:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgmzu-0002fV-VW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 11:11:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3719753d365so3926913f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724253100; x=1724857900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=er8A533SFJPEQI2xww8SF3EOOQMNUn1xFXlrcQOB35s=;
 b=vWcpltaGnDk6Roeqj0tJk2PfGcIsdD6gqaGdv+2fP/FI6KfIWdRvQNxuxiVzCepzbW
 lcIG71j0FuWbmVn5NnhcLeBdL3vAscWAd21B69KAC8xFyCLSV7At0lPjvBLFPVVqgW40
 6osTTqQMb0SpQCMGgIvmn5246NqUfcD3Y7FzpEKuqt6NUxVHwVlYbCKev5SkgYr6nYla
 7tYBlJg8UayGyPvNAjSCFUg3IzBXD2Y38IY9aSO6NvA9y+mxm2Sd+ZoJCcBJzaTxkQRP
 R5jh+a1OZ3KIYoKO/xfUPXbhLxxKRrA2SoJE8Nd8dfhKUa42ylWVyloYpylQIWLvWNLX
 ic/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724253100; x=1724857900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=er8A533SFJPEQI2xww8SF3EOOQMNUn1xFXlrcQOB35s=;
 b=Lotm4Mc1XkIUOkeVUXa5Tm3eCj8ijr6NJn2s7CirY/OHTGHUINgejC4u7Z/5zmw7CT
 iXK0Oeq4yOjHODH2ofBtFRZlq7UoLzKstVFihVsCViujvujwxqw6X7oTCzHhn/h/5OgF
 XI6kmPFgS6tygW0+92DGxXPCrHPRgjPDvUR2BjaAk0Iw0fFpzL3qHh5Y6kDB8NJCJOxS
 4+qZh4ou9Vcc1fimCtc1Qt4Iwfm7G+Hu7WrwoQ/3pePQFJAcEZB7zgRY3iVv0v15eFbK
 J1e6G9L+Oz81HXMa6o+8a32lsen7usELh+Z85BxfIrUdDcUG8LgyG+hLW6t7Dt2yr9bs
 eG+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoFCymiSgztixk2eFtSfMYNSVdn/SXaEbezaJrTRpWu9IfGlNjWbxAqj/VpXOt7G/Y4RNQ7WD4Wzzx@nongnu.org
X-Gm-Message-State: AOJu0YyRtFlEhueuOzdt9/mN+p5nEWsQ5Y9CLrPPGSK8hBJ5y9bgxhvj
 mx8rK00abdAhIeyThZvHv2PURbaQIkwagdQD/Xyi1YrZ9kc/B6QJdXn3/eP3Wz4=
X-Google-Smtp-Source: AGHT+IFhDg2GCGsrlsJJzROwLn9tCna1WLX2GYVOlwQAII8vTqeFhTc17Uqqn/x1EC7HvEOlYL1T7g==
X-Received: by 2002:a5d:68c9:0:b0:367:96d2:5756 with SMTP id
 ffacd0b85a97d-372fd82b8f5mr1799134f8f.62.1724253100235; 
 Wed, 21 Aug 2024 08:11:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abee8bce1sm28931755e9.16.2024.08.21.08.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 08:11:38 -0700 (PDT)
Message-ID: <3e530db3-99e2-4878-a927-e6eebc0f92fe@linaro.org>
Date: Wed, 21 Aug 2024 17:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Move LinuxTest related code into a
 separate file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org
References: <20240719095031.32814-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240719095031.32814-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 19/7/24 11:50, Thomas Huth wrote:
> Only some few tests are using the LinuxTest class. Move the related
> code into a separate file so that this does not pollute the main
> namespace.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/avocado_qemu/__init__.py  | 239 +---------------------
>   tests/avocado/avocado_qemu/linuxtest.py | 253 ++++++++++++++++++++++++
>   tests/avocado/boot_linux.py             |   3 +-
>   tests/avocado/hotplug_blk.py            |   2 +-
>   tests/avocado/hotplug_cpu.py            |   2 +-
>   tests/avocado/intel_iommu.py            |   2 +-
>   tests/avocado/replay_linux.py           |   2 +-
>   tests/avocado/smmu.py                   |   3 +-
>   8 files changed, 262 insertions(+), 244 deletions(-)
>   create mode 100644 tests/avocado/avocado_qemu/linuxtest.py
> 
> diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
> index 304c428168..a3da2a96bb 100644
> --- a/tests/avocado/avocado_qemu/__init__.py
> +++ b/tests/avocado/avocado_qemu/__init__.py
> @@ -10,7 +10,6 @@
>   
>   import logging
>   import os
> -import shutil
>   import subprocess
>   import sys
>   import tempfile
> @@ -18,7 +17,7 @@
>   import uuid
>   
>   import avocado
> -from avocado.utils import cloudinit, datadrainer, process, ssh, vmimage
> +from avocado.utils import ssh

Unfortunately we don't run the user mode tests on CI and missed
'process' is used by the QemuUserTest class.

