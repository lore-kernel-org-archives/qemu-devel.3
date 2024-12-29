Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF86E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 17:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRwy9-0005Ew-1z; Sun, 29 Dec 2024 12:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRwy6-0005Ef-MK
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 12:20:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRwy4-0006h3-Ph
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 12:20:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436249df846so59149485e9.3
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735492843; x=1736097643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=67IdtOayUiSlRbdKI/T62DCifesDBMlGLh57OPLDpQM=;
 b=CibT9YrPKJjxiAfzNrRKxBWUDa0NWd2Qj9U4NaH7MbWgQzTx9wvHMI1XpnuyTyGruV
 3cfKi7ISoUdBK4HFb8F40YJs2KTuOUiWEh1gkqs0mPe6CPOQz+7eVaoo/qBQS7e+F7mf
 lIpTYaQ/fvcnNY/LBzQpg+8QdxsNUwjJIuCUIkUB5tt1O/TLx+KxEcFlUm3GnoUVH3wE
 pMcFvX+wbgY+hNLTRqI9YGEWpEdzaiXGFdT+C0Bn7iyKtG0AYMXfR5NtxKgr0WpO2S1x
 PjPjJvoH3lx75b3SJ6+FWd1k0eoYYAtA/U2gui+QqKGxRnWIGgQYisXvq3Ay3thOYoU7
 AYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735492843; x=1736097643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=67IdtOayUiSlRbdKI/T62DCifesDBMlGLh57OPLDpQM=;
 b=KmACKBjC3HMEpxD6mvr0qgzUEwwouBHm7nMvO4NsQ76AaqQvQhBChe0jCmjpOtOfRA
 2B9nzNdMtGyDuzq3S+wmUjT/925jko18/rDDhjNkFvb0LMaUzNOc6f3oP4iPo+yewcVJ
 DKWChl4tpE4XAPeC+tHri4kmdwbm7k/YikGen8fM5adWKNz8Eq8o4b7t+BjmLyyl868n
 V6k6kB6bMOtGuk2434njxmeYaRu06L9vbBPkjrTSTB4cyhnMWOJwTPpHVnIkAyOxXXIT
 JjkB5IyRzz5nUmLBTAAfj+tl2xeDhMzwvhd2t+QK5NNeg/tcHBjVJfv2Ji8uqEsQ9Z7T
 6nmw==
X-Gm-Message-State: AOJu0YwSfj3pWEGJXeEo9STaxGEAmsA0u56IP/uGVaWgUgHPBGqFV+8C
 WR3Brgdoqw3VWxS4bMnknECz4IXwitecjaxqgVoe744m9rH7EmRWYTxuw9MDURo=
X-Gm-Gg: ASbGncsPMBICP7FHQdC8GbFG7PKINRJHQNrsm95yNmzuqoYSokSKMT8R5dkVaVjEeO0
 1JbFWeNmlZYUzDufNGJMMigeXpaoUbmgd2rlWwI3lO+KHDnqxsS9mBYKDlkLkyCkkypA/0D9jvT
 q4DwFLsvhCnLvgKCcMSaA4Ixik3uH/kfiNgT4hRfjuqtJ1/grOP3FsX3G549uftvHuZe3LSxBum
 5UBEmsJnwIDdnu+EXZp6qhXFulTrkn95JnpuVihyQwv/8/CfDJ/97SxC+PWt/ptpXOFz4zxXgf4
 Kb6h7JbVi0Xob10HytHrllzB6+UYag==
X-Google-Smtp-Source: AGHT+IHAj1+wvuItYr1lfLDiUZqRcrqUn26lqLQF/JqNkKa7eLkkKE9OW0nmIW8C9IN+N+OJVHVB0Q==
X-Received: by 2002:a05:600c:1c0b:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-43668646750mr293661615e9.18.1735492842694; 
 Sun, 29 Dec 2024 09:20:42 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6cbbsm364545495e9.3.2024.12.29.09.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2024 09:20:41 -0800 (PST)
Message-ID: <08a6f530-7971-40e7-a6c1-31317c17c158@linaro.org>
Date: Sun, 29 Dec 2024 18:20:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_rx_gdbsim: Use stable URL for
 test_linux_sash
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20241229083419.180423-1-huth@tuxfamily.org>
 <87v7v2v4az.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87v7v2v4az.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 29/12/24 17:31, Alex Bennée wrote:
> Thomas Huth <huth@tuxfamily.org> writes:
> 
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Yoshinori said [*] URL references on OSDN were stable, but they
>> appear not to be. Mirror the artifacts on GitHub to avoid failures
>> while testing on CI.
>>
>> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg686487.html
>>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Reported-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Message-ID: <20200630202631.7345-1-f4bug@amsat.org>
>> [huth: Adapt the patch to the new version in the functional framework]
>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> 
> The test works but I'm definitely missing some of the console output
> from the end:

Is it https://gitlab.com/qemu-project/qemu/-/issues/2691
(also https://gitlab.com/qemu-project/qemu/-/issues/507)?

>    ➜  head ./tests/functional/rx/test_rx_gdbsim.RxGdbSimMachine.test_uboot/base.log
>    2024-12-29 16:30:13,829 - DEBUG: Using cached asset /home/alex/.cache/qemu/download/dd7dd4220cccf7aeb32227b26233bf39600db05c3f8e26005bcc2bf6c927207d for https://github.com/philmd/qemu-testing-blob/raw/rx-gdbsim/rx/gdbsim/u-boot.bin
>    2024-12-29 16:30:13,829 - DEBUG: QEMUMachine "default" created
>    2024-12-29 16:30:13,829 - DEBUG: QEMUMachine "default" temp_dir: /home/alex/lsrc/qemu.git/builds/all/tests/functional/rx/test_rx_gdbsim.RxGdbSimMachine.test_uboot/scratch/qemu-machine-pb_7irt4
>    2024-12-29 16:30:13,829 - DEBUG: VM launch command: '/home/alex/lsrc/qemu.git/builds/all/qemu-system-rx -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -machine gdbsim-r5f562n8 -chardev socket,id=console,fd=10 -serial chardev:console -bios /home/alex/.cache/qemu/download/dd7dd4220cccf7aeb32227b26233bf39600db05c3f8e26005bcc2bf6c927207d -no-reboot'
>    2024-12-29 16:30:13,857 - DEBUG: Console interaction: success_msg='U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty' failure_msg='None' send_string='None'
>    2024-12-29 16:30:13,857 - DEBUG: Opening console socket
>    2024-12-29 16:30:13,863 - DEBUG: Shutting down VM appliance; timeout=30
>    2024-12-29 16:30:13,863 - DEBUG: Attempting graceful termination
>    2024-12-29 16:30:13,863 - DEBUG: Closing console socket
>    2024-12-29 16:30:13,863 - DEBUG: Politely asking QEMU to terminate
>    🕙16:31:20 alex@draig:qemu.git/builds/all  on  testing/next [$?]
>    ➜  cat ./tests/functional/rx/test_rx_gdbsim.RxGdbSimMachine.test_uboot/console.log
>    2024-12-29 16:30:13,859:
>    2024-12-29 16:30:13,859:
>    2024-12-29 16:30:13,863: U-Boot 2016.05-rc3-23705-ga1ef3c71cb-dirty
>    🕙16:31:32 alex@draig:qemu.git/builds/all  on  testing/next [$?]
> 
>> ---
>>   tests/functional/test_rx_gdbsim.py | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)


