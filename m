Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E558E8B397
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 04:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnUcY-0006Yd-IG; Tue, 03 Feb 2026 23:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnUcX-0006YP-T4
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:36:05 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnUcW-0006hI-Ge
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:36:05 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so216383b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 20:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770179762; x=1770784562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=isgzfM3dfOHrDHP535tyrqT4hFMl9xutstTJO7213Ks=;
 b=C8u68SD1+UlCsxvBc2gjKtJ0kAeGxvlZvDSWs3A7//1tU0yG7lqqqJ1JCdz/caxzpF
 e3Q0ATr0g0tG+0whmOcaCqxImZypEKmgwlsgT3+PtM8RFk9vJJdPUjEUtqJnGUPad8Qg
 Eo2ZMx6N37ODXjuoTmjKcolQI2RU9FtqQmjZ2dVQjUU+ugZWAKVJ+LqQ2qFx3RGdbxg+
 7f9mZs3SgPl6JjiFrWM3Cc+SJxprJ5H1Yi1nowa1CHrUFORpn4UzrbJ493xIZCHFlqDa
 jZsIPhx92POfrVKRtpvk7u+GY6wLGzNy8+fR0UvOHaPlp5M9HeEkhCI7WPV2MkoCxqxk
 LUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770179762; x=1770784562;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=isgzfM3dfOHrDHP535tyrqT4hFMl9xutstTJO7213Ks=;
 b=C9SkMDn9P0vryXd4UrzsoJJivhAqZh6kIwyBxelyb5tLE2yCMzLZ10zno324MgZD2m
 ZU51ElsI6wpvNZJKSX3nMWnQsUV8LRXfHVSfcaD7OJ9WxBiWOF7bfk+u8uFZRKAv6yKp
 9nIpbSA/1MhBHe6RWe+6M58wS8bQ7ajfdcM38Ktb2BSmbqtHjZ6rApKrw70HVWzpGo67
 fBhgybvOlU0MHAD6Xyb1HZs8xrQu49+/oDtYXhMr/APYTisog59Jec93/5C6SxKUvBm9
 qFGt/lIAxuKhjK+FnG75f2At1UbNSBCrkU8Q7i4NH3sHjB0jGmYxqCp5+EZjqSl/n5Rz
 ZSew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNtgOdKPudLD+2VGZABW6ViIkG3Z7BFmSzJSNfOt+V0L1Y+SCeb8TSe8UcWSkvkNaiFkNm5/VQWsyN@nongnu.org
X-Gm-Message-State: AOJu0YxKxVoEPpJN7rmKrYGdkxkcyXrwFuxdykTZ/jAqW3o7ih9tpE+W
 FQ87O1k3cNBfPjtbUNDn6a3vyKSN7jKhJFZZk1jECI6/+tbPNyA7RKGvGe75UceVKl5/62jvFXR
 Fvl50G9k=
X-Gm-Gg: AZuq6aKcVzR+cOJXh5kPuK7TLg2h2PIhlZlQEVAhK66YAbpO2JlVVTbcw2haOCPXfSp
 iQ/ENgfiPccw+8plDNl58LBeId/fkYx4dx0kXbgBR5odrpyhbW34OMXnQzGpH3a0eBup6kXlqhc
 wp041K5n4JV8utj0YSndTzZuatj0oy8HA80JvIzmgcztcHuQT7CTDvK+dujIf0b5yhWORqIH5s3
 IsEa9N03p4e4ujP5F70MydPjR6RYsh9f41FX5/U/CDTyIbLOLAbzjEcfaV91b29qJRzfUc61R21
 vP65Z2tJP2oX4Ihlelj5SfXVd1KwoE9CvfBmpQhZyDyr/6Xv9eUMByZ2lLifx0TIrx82lS0ZnPs
 LDpvc9dSbhjnhf4AnvwIIJpBvvxi2gHxaaPItV/puHjs9bjU9DElXV24AUV1nBVMiSTFkSdSDhQ
 jkD5JwmHS8HsnU/ANOkepq9lvrcRuo53CobM7UPm5Bkn9TIyNkgDD+Adleb2SDPFvMKA5jzeTZ9
 1tXwawxhi8xlZ5YjMkpVnr/xT9VoltmQ2hd
X-Received: by 2002:a05:6a00:12d9:b0:81d:e9b1:b6d6 with SMTP id
 d2e1a72fcca58-8241c75f197mr1782079b3a.28.1770179762396; 
 Tue, 03 Feb 2026 20:36:02 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d438897sm869112b3a.37.2026.02.03.20.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 20:36:01 -0800 (PST)
Message-ID: <e0b9ce25-db50-4f72-bfc5-751770c0695e@linaro.org>
Date: Wed, 4 Feb 2026 14:35:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] gdbstub/user: localise variables for reading gdb
 socket
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
 <20260203115201.2387721-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203115201.2387721-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/3/26 21:51, Alex Bennée wrote:
> Keep things tidy by moving the declarations to the block where they
> are used.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/user.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index cc71cda3e33..c7a3ef947ed 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -198,9 +198,6 @@ void gdb_qemu_exit(int code)
>   int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
>                     int siginfo_len)
>   {
> -    char buf[256];
> -    int n;
> -
>       if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
>           return sig;
>       }
> @@ -246,11 +243,10 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
>       gdbserver_state.state = RS_IDLE;
>       gdbserver_user_state.running_state = 0;
>       while (gdbserver_user_state.running_state == 0) {
> -        n = read(gdbserver_user_state.fd, buf, 256);
> +        char buf[256];
> +        int n = read(gdbserver_user_state.fd, buf, 256);
>           if (n > 0) {
> -            int i;
> -
> -            for (i = 0; i < n; i++) {
> +            for (int i = 0; i < n; i++) {
>                   gdb_read_byte(buf[i]);
>               }
>           } else {


