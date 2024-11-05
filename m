Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AD3D2C115
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KkS-00030T-Dr; Tue, 05 Nov 2024 09:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8KkR-0002zy-2C
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:41:35 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8KkP-0007D5-FS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:41:34 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539e59dadebso6837369e87.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730817691; x=1731422491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qi0zRjNY65VjFcqxfQxEh4pqL00MyEwpfvs76EiAyOs=;
 b=lXqOQav4j83Q90LdZYsOdUHNl96zT+9zeoWJV8r3MYOX78cYYRk3vcn9DSlu7ErEeP
 mRPZQElmQBrzH5ioQy6YaasPTlaQWD5F3obPY4zgrDNyj4+aMXO/N3yQjizMx6CLplsS
 2d2Ohrz4BX9lpASj8RVXkgzKVP3h4nv1TIOkUym7UZnppeduSCTud5lhPsEkNErLR6qu
 wpeOIB4czI4eGMPtlbqo7u69Y6y0m3/f/H8KK8aiqYhN1anoTY/LvlV98+RAgoXUJlg6
 /Ao/27wo1wMixDXqcvqT68R0OYwEeKUr3YqaNwfx2DsNHC3Vde4Cfo0PbcG/KpgfGdmJ
 NVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730817691; x=1731422491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qi0zRjNY65VjFcqxfQxEh4pqL00MyEwpfvs76EiAyOs=;
 b=gEzBcR9aFkPqDGIuuT/YKhBL67mKbxpsMvr6eDSohSjPB/TndVZnq7TfdHrjZInaEW
 5crGk4NP9X1gsWbwFFCn5DLYiwsyGfCdqS6bn0i7y0J0Jbkjlw3rfq9Cyhs5jh86CYd1
 6rW/emw0penuqTeGOBeXL3t6DXdYHbKuyKx5DU4oKk7/AH2hLp33cieDA2DhFKv9a5P2
 E1OP43ZSbRsH+YQ2lG3X+nV9DjCZ4Egyz6bhGU2zo/5AMWVn4GSrqzwO+1qYmH8e8pCl
 W6mP9V0osVP2ZnQEvIfBJ8c+Vq27VHrreRG7H/qtnJuVXWTb9X+AsaVdyhljb/7lYGFl
 H3pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUopZKdbTvgnKkAJ83sc3Nhqr1RlGYeLcUoOweg9Zv6OUE3TyhFKjSS8diy3cepaF8Ln5zarDvPOzhZ@nongnu.org
X-Gm-Message-State: AOJu0Yx7gXdcrGyUKpYFS6XEcuypf3+2FM39zT+ueSvQb0K5xbF8BtRn
 Lekn/JxEDm4/N+hK/FulWUEvNCvBT6cUv0AU8XA4i1hhND9pjJhgMw1WbgnKHGA=
X-Google-Smtp-Source: AGHT+IHg09U8PWC3f5HRNRFVQWATqRqSFyLKBCgv2TctUswBbVP/U/W+VjNkYUk2lnzPtO2ZduatqQ==
X-Received: by 2002:a05:6512:3d05:b0:539:df2f:e115 with SMTP id
 2adb3069b0e04-53b34909ffamr18939703e87.23.1730817691495; 
 Tue, 05 Nov 2024 06:41:31 -0800 (PST)
Received: from [192.168.21.227] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e565csm16356048f8f.48.2024.11.05.06.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 06:41:31 -0800 (PST)
Message-ID: <b8080e98-c292-4760-abd8-822a1aafc932@linaro.org>
Date: Tue, 5 Nov 2024 14:41:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] gdbstub: Allow the %d placeholder in the socket path
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241024200031.80327-1-iii@linux.ibm.com>
 <20241024200031.80327-2-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241024200031.80327-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
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

On 10/24/24 20:59, Ilya Leoshkevich wrote:
> Just like for QEMU_LOG_FILENAME, replace %d with PID in the GDB socket
> path. This allows running multi-process applications with, e.g.,
> export QEMU_GDB=/tmp/qemu-%d.sock. Currently this is not possible,
> since the first process will cause the subsequent ones to fail due to
> not being able to bind() the GDB socket.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   gdbstub/user.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 0b4bfa9c488..cdf5affae15 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -316,9 +316,19 @@ static bool gdb_accept_socket(int gdb_fd)
>   
>   static int gdbserver_open_socket(const char *path)
>   {
> +    g_autoptr(GString) buf = g_string_new("");
>       struct sockaddr_un sockaddr = {};
> +    char *pid_placeholder;
>       int fd, ret;
>   
> +    pid_placeholder = strstr(path, "%d");
> +    if (pid_placeholder != NULL) {
> +        g_string_append_len(buf, path, pid_placeholder - path);
> +        g_string_append_printf(buf, "%d", getpid());

qemu_get_thread_id().

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

