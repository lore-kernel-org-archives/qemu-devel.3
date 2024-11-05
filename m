Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61090D1268D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Hsr-0000BJ-Ig; Tue, 05 Nov 2024 06:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Hsp-0000B4-Gv
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:38:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Hsn-0000es-IB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:38:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso42164905e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730806678; x=1731411478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZIrpEp7lbrsPu6jUWphu9qix+JffP6XhCldRgQExn+M=;
 b=ozV/yboRIecIyq0IW5IlRze+yvlnwKHqQv89uoIEPf5W7Ale01mKgML15GYFCjN/+Q
 ZHq0EVfk4qzd/8v6gC9lNATWx4LhnuU5lPPZSVyYYA7Mfgbtk74dCoEXIJxj8zocUEtO
 UWIRKTU8re7qK8E5Dec6P2wwJKFbjVziEggx1406Bn6K1Nx03dF5OlZv4q2STSKaGgSp
 RvYDQ3ZxmehurYUgSFkonCORjbWjZq3P2WcBlZMzmJciX4PKc162ZIU+q+d5FOhH00v7
 Ost4sVJg7u2y4UYeNpHCNS7Z5hNvSBD6ufZzevXs3DUJJT2R857HPHWmucPBmIcIjost
 jeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730806678; x=1731411478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIrpEp7lbrsPu6jUWphu9qix+JffP6XhCldRgQExn+M=;
 b=KRQLv9yQgjafMDqInNY07hk9Gckvf9ZuoncfE7YWYt+KJh63V3QJwyO0RO2P1uFknx
 KK2zWcJKRascPPnh+IQEwOEp1MtSxTtId2XlI9vM5oOhShJBMmaLUg8YPzZk1yzjvdcL
 rSQ683P4rxKb3A3/CJXaPqbftIZqKQ2JbYDcibZmQ8mv58J87U2GzvVVuXhfkQLW6rhj
 LpZcec9YXYYLzkn6jjskAYJVdrDY0FsyuEmREDPNBIdhhCmJCPG5zBl/sXN0htgon4q2
 K40G9AK5CV0pUJlpsCUDvfjwDOhDVw2jJRjoSa44B3eT1LPN59jkIbfLhYfhWHTbLyoJ
 96qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcgSFLoq6iIAFQCKj6GtqULpwBy2FxoYX3Nd8io1kci5zAekbwqy+gBxhcFfgovMbBrxwWwpnl4X51@nongnu.org
X-Gm-Message-State: AOJu0YzTUDIQVgGD7kWVQm0xZn1OF6k8d04IiaLTexlDvQrplYVsxqVx
 k2HRIUmJuQ1wUChOUX8OOXTG1FRuJMVp6rrdxxT4wswnji/JABfJHWFZ4Lm+/WxXeviXPiw6yUJ
 doZA=
X-Google-Smtp-Source: AGHT+IE3Cm80smxT21vu/1KVnFUMCskgFl3bxH3Xzajpd/R00UacTBR5gB+OoWBdR1xaJtiuOfqJWw==
X-Received: by 2002:a05:600c:46d4:b0:427:ff3b:7a20 with SMTP id
 5b1f17b1804b1-4319ad049a8mr293026685e9.27.1730806678146; 
 Tue, 05 Nov 2024 03:37:58 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6848b5sm184186365e9.32.2024.11.05.03.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 03:37:57 -0800 (PST)
Message-ID: <000c9ef8-c610-4f2a-b191-04b84455d89c@linaro.org>
Date: Tue, 5 Nov 2024 11:37:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user: Add option to run `execve`d programs through QEMU
To: Noah Goldstein <goldstein.w.n@gmail.com>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, laurent@vivier.eu
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <20241030141037.375897-1-goldstein.w.n@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241030141037.375897-1-goldstein.w.n@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

On 10/30/24 14:10, Noah Goldstein wrote:
> The new option '-qemu-children' makes it so that on `execve` the child
> process will be launch by the same `qemu` executable that is currently
> running along with its current commandline arguments.
> 
> The motivation for the change is to make it so that plugins running
> through `qemu` can continue to run on children.  Why not just
> `binfmt`?: Plugins can be desirable regardless of system/architecture
> emulation, and can sometimes be useful for elf files that can run
> natively. Enabling `binfmt` for all natively runnable elf files may
> not be desirable.
> 
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> ---
>   linux-user/main.c                             | 21 ++++++
>   linux-user/syscall.c                          | 21 ++++--
>   linux-user/user-internals.h                   |  4 ++
>   tests/tcg/multiarch/Makefile.target           |  8 +++
>   .../linux/linux-execve-qemu-children.c        | 68 +++++++++++++++++++
>   5 files changed, 117 insertions(+), 5 deletions(-)
>   create mode 100644 tests/tcg/multiarch/linux/linux-execve-qemu-children.c
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8143a0d4b0..5e3d41dc2b 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
>   uintptr_t guest_base;
>   bool have_guest_base;
>   
> +bool qemu_dup_for_children;
> +int qemu_argc;
> +char **qemu_argv;
> +
>   /*
>    * Used to implement backwards-compatibility for the `-strace`, and
>    * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritten by
> @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
>       perf_enable_jitdump();
>   }
>   
> +static void handle_arg_qemu_children(const char *arg)
> +{
> +    qemu_dup_for_children = true;
> +}
> +
>   static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
>   
>   #ifdef CONFIG_PLUGIN
> @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] = {
>        "",           "Generate a /tmp/perf-${pid}.map file for perf"},
>       {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
>        "",           "Generate a jit-${pid}.dump file for perf"},
> +    {"qemu-children",
> +                   "QEMU_CHILDREN",    false, handle_arg_qemu_children,
> +     "",           "Run child processes (created with execve) with qemu "
> +                   "(as instantiated for the parent)"},
>       {NULL, NULL, false, NULL, NULL, NULL}
>   };
>   
> @@ -729,6 +742,14 @@ int main(int argc, char **argv, char **envp)
>   
>       optind = parse_args(argc, argv);
>   
> +    if (qemu_dup_for_children) {
> +        qemu_argc = optind;
> +        qemu_argv = g_new0(char *, qemu_argc);
> +        for (i = 0; i < optind; ++i) {
> +            qemu_argv[i] = strdup(argv[i]);

g_strdup.

> +    bool through_qemu = dirfd == AT_FDCWD && qemu_dup_for_children;

Why is this limited to AT_FDCWD?  Why not for execvat too?

> @@ -8628,9 +8631,16 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
>       }
>   
>       const char *exe = p;
> -    if (is_proc_myself(p, "exe")) {
> +    if (through_qemu) {
> +        int i;
> +        for (i = 0; i < argp_offset; ++i) {
> +            argp[i] = qemu_argv[i];
> +        }
> +        exe = qemu_argv[0];
> +    } else if (is_proc_myself(p, "exe")) {
>           exe = exec_path;
>       }
> +

You still need to handle is_proc_myself, for the guest binary.

I wonder if those two cases are related.  Do we need to also add an argument so that we 
can pass the executable to the next qemu via file descriptor?  I.e. execvat becomes

     f = openat()
     execv(qemu, "-execfd", f)

and is_proc_myself uses execfd, which we already have open.


r~

