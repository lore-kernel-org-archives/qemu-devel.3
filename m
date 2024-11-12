Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEE6D42B82
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 13:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArPd-0005Qy-W8; Tue, 12 Nov 2024 08:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tArPb-0005OZ-HV
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tArPZ-0003wb-RG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731419909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hdXVUlqVfoMx7VfsEYkygPSm+aQDbnjz4m29Ey7ggq4=;
 b=EB6KxgSIm9r06r/PXtQUPnorfr0MoLAOJfNkx7E9PGxr/j/94Al/jdz5nVSobUYeb2DJ80
 tSo3UFHnog4DTZTHRXZt8Y9114FFsQqw6Jl94LULzJ6v2ttdXkrLpdaUjrxP5Jb+JKd9OF
 vfx/MNuaZlzmXAU7iEZgvGFQkoLbg3Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-fTgsEd0XPx2j_88VzH7GlA-1; Tue, 12 Nov 2024 08:58:27 -0500
X-MC-Unique: fTgsEd0XPx2j_88VzH7GlA-1
X-Mimecast-MFC-AGG-ID: fTgsEd0XPx2j_88VzH7GlA
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-460b35f820fso83071331cf.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 05:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419907; x=1732024707;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdXVUlqVfoMx7VfsEYkygPSm+aQDbnjz4m29Ey7ggq4=;
 b=fYc8dZAOJ+DBBO44qUCzkt36QUEKVHoa6mQwRwCiRkzFaL/cqZ4D5kgaLfWcyklWRB
 ePq056I6P+ZERElFrqrKp3Z2D7EoNTtxm5IjOnoRmRRZLWM7DTmrBvZkQVt2sBKzmb7V
 lp6lRlCn2lP5FpJFpfLpfGn2+Z15jsOHSIwJN2xTxkrWZcboZJOlAJtwvJEzRiZ0hkJL
 XfhsebSB9CpRMQtRMsH8T69qLBuPrtVLLaIKBzTPCjdMuXgurXPnni+zv4oiuxx9RLb7
 ltm2dQOCQiS1ZfJjmMP/QU6SA8rAxhAjKXO77riwf1dKKe5HZi8+LcjJoFb+Zeqi2y1z
 HzjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxp5tBGW2gtIrv8na+1wM/DkYpBRDmEOf26RXOHCBFGbZC4pxprYjJqr/HuK1ia0It3TvjKTwATZ9Z@nongnu.org
X-Gm-Message-State: AOJu0Yx9PNJCCLoVmOHPsfcgxQ78UwS6WkLxQQkX/mpeT1HfJdpUqFw4
 lUNcqaxXtDi+bEdMrot9e7daGJKBEa7s6wx2ZttjT28hgJr1JsokSLz7EFQOv/nWzmYHWzVvdT+
 ZebRXPHkAIeizhqDtrn+sE6rnTiHs5FikC3caJNJpAxGFY93jY/gC
X-Received: by 2002:a05:622a:207:b0:458:34fb:5d59 with SMTP id
 d75a77b69052e-4630938ab07mr211818301cf.29.1731419907159; 
 Tue, 12 Nov 2024 05:58:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkuova7N2/OvH53fyIfLQXqbP3q9ErwtvLCZlsN2NVvnG/kbVrRnrFnT1qg0sGl1vPpWscew==
X-Received: by 2002:a05:622a:207:b0:458:34fb:5d59 with SMTP id
 d75a77b69052e-4630938ab07mr211818151cf.29.1731419906904; 
 Tue, 12 Nov 2024 05:58:26 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff5c8eb1sm75096471cf.77.2024.11.12.05.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:58:26 -0800 (PST)
Message-ID: <2fce3b45-d234-4fa8-93fa-2fa312203ef1@redhat.com>
Date: Tue, 12 Nov 2024 14:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tests/functional: Convert Aspeed arm SDK tests
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241112130246.970281-1-clg@redhat.com>
 <20241112130246.970281-4-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241112130246.970281-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/11/2024 14.02, Cédric Le Goater wrote:
> Drop the SSH connection which was introduced in the avocado tests to
> workaround read issues when interacting with console.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/avocado/machine_aspeed.py     | 124 ----------------------------
>   tests/functional/test_arm_aspeed.py |  67 +++++++++++++++
>   2 files changed, 67 insertions(+), 124 deletions(-)
>   delete mode 100644 tests/avocado/machine_aspeed.py
> 
> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
> deleted file mode 100644
> index 2240c82abff9..000000000000
> --- a/tests/avocado/machine_aspeed.py
> +++ /dev/null
> @@ -1,124 +0,0 @@
> -# Functional test that boots the ASPEED SoCs with firmware
> -#
> -# Copyright (C) 2022 ASPEED Technology Inc
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2 or
> -# later.  See the COPYING file in the top-level directory.
> -
> -import time
> -import os
> -import tempfile
> -import subprocess
> -
> -from avocado_qemu import LinuxSSHMixIn
> -from avocado_qemu import QemuSystemTest
> -from avocado_qemu import wait_for_console_pattern
> -from avocado_qemu import exec_command
> -from avocado_qemu import exec_command_and_wait_for_pattern
> -from avocado_qemu import interrupt_interactive_console_until_pattern
> -from avocado_qemu import has_cmd
> -from avocado.utils import archive
> -from avocado import skipUnless
> -
> -class AST2x00MachineSDK(QemuSystemTest, LinuxSSHMixIn):
> -
> -    EXTRA_BOOTARGS = (
> -        'quiet '
> -        'systemd.mask=org.openbmc.HostIpmi.service '
> -        'systemd.mask=xyz.openbmc_project.Chassis.Control.Power@0.service '
> -        'systemd.mask=modprobe@fuse.service '
> -        'systemd.mask=rngd.service '
> -        'systemd.mask=obmc-console@ttyS2.service '
> -    )

What about that EXTRA_BOOTARGS stuff? Is it not required/wanted in the new 
file anymore? ... maybe mention it at least in the commit description?

  Thomas


