Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFC4CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 04:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smnIp-0004Ry-U0; Sat, 07 Sep 2024 00:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnIn-0004Qw-S5
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:44:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smnIm-0004PC-E8
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 00:44:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374ba74e9b6so1927809f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 21:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725684238; x=1726289038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y2hiM8GracFUilXI+Yij0hwHyNHNLCbALyTvEyY0qhY=;
 b=joOxecJSoYi9LDHgkQZJrepKesvruYByGhCOF0Qj9tsyeB/Z/NShhkQytRljI9yCc3
 6lp1zQ48U1Oa5S9Cqgbn5hFjEagdrIR02aFpEJqWN64dGi3DNyvnokWWb8KueEL12hiW
 dDL56vNxfRXkdOphVgsrBGFx84YJ9qNTztp6XcDqYI941mokQH3r5qnmXhjqoRkGeFco
 J4TrynT+kXATO+8uzgfqmLHkpVg6hPwdZnEoAsygbqZnx/TTZCndxyQWZcu5JR9LPDiE
 avBdCgZF6rYqU/IgIPIdKCgy27MiI71FWqVtmBENTSVS8z2ee5Fj5aFIvm9zOnNS4cT4
 6p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725684238; x=1726289038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y2hiM8GracFUilXI+Yij0hwHyNHNLCbALyTvEyY0qhY=;
 b=kub9ueORbrlR7iWYLyKehfSiUQlRilR1jfhO68pbTOBqNpfGKLat7kum8iPDX9zqVt
 NBf4Y0aoSusbtxxrpVrD46mVpj+auxMl9OHpdfroJv34JnGc/BYU1hnC6PDqSIECcmpM
 bMfvdJXTil5dZtFP8EbnGriL+ab2HNdzBmXYScfURSBV8QmK/OvU/DVRbtjtbOY0GzwA
 FedKVad2eweuHTp1115ZkUUWymfEFOF8q6Iw9+45Llzq40hK7r9PWCnddbqs6bex5oep
 gNOQCoft7VYfefKAVgbDLA5Hu4ZJ72W145KGbjHJ5QXlRtYvkOp5d9g09KPH++4kBeqZ
 p8Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDQh+CbqZYd857Be3MZtDbkRAq/aLLQnUwutZSna88C/YHX9Mx4lNGLhkyh+6dIEmdqrKLkKMe/069@nongnu.org
X-Gm-Message-State: AOJu0YwDribFuxsCB0ZqqeIFrlbUUmhIuZ4VZKtelB7yIgfhyfpjfhz+
 q/PzjZYC06QZdWNwOzjij/k0zsz8TfNVQhlJCNpNDL1XBR72AlYvOfqip8oFjnk=
X-Google-Smtp-Source: AGHT+IFSJbcOKcFNy8hQSpMxbVDr3ZDjiLpyvVINd33Ay5I4tmHynaiB8L+suvPDaGrWeQaDzS9uFA==
X-Received: by 2002:adf:fa0e:0:b0:374:c1c5:43ca with SMTP id
 ffacd0b85a97d-378922b76a7mr783163f8f.32.1725684238305; 
 Fri, 06 Sep 2024 21:43:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cefa24sm26478466b.178.2024.09.06.21.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 21:43:57 -0700 (PDT)
Message-ID: <4af7d311-923a-40ed-b179-105cfd850ac7@linaro.org>
Date: Sat, 7 Sep 2024 06:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] tests/functional: Add the LinuxKernelTest for
 testing the Linux boot process
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20240906180549.792832-1-thuth@redhat.com>
 <20240906180549.792832-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906180549.792832-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/9/24 20:05, Thomas Huth wrote:
> Copy the LinuxKernelTest from tests/acceptance/boot_linux_console.py
> to be able to convert the related tests to the functional test framework
> in the following patches.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py    |  1 +
>   tests/functional/qemu_test/linuxkernel.py | 41 +++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
>   create mode 100644 tests/functional/qemu_test/linuxkernel.py


> +++ b/tests/functional/qemu_test/linuxkernel.py
> @@ -0,0 +1,41 @@
> +# Test class for testing the boot process of a Linux kernel

> +class LinuxKernelTest(QemuSystemTest):

> +    def extract_from_deb(self, deb_path, path):
> +        """
> +        Extracts a file from a deb package into the test workdir
> +
> +        :param deb_path: path to the deb archive
> +        :param path: path within the deb archive of the file to be extracted
> +        :returns: path of the extracted file
> +        """

I originally put this one in qemu_test.utils thinking we could have
a non-Linux test using Debian artifacts. Probably over-engineering,
besides we can move that later, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



