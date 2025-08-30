Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE2FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 22:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usTiF-0005t5-PM; Sat, 30 Aug 2025 18:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTiD-0005NA-I0
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 18:06:17 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTiA-0000N4-0e
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 18:06:16 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-323266d6f57so3513160a91.0
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756591571; x=1757196371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AoMm8zyxIjPljehp07rdJd/o7PlK1uGZtC8DWy6n09w=;
 b=WTXINSDOX9790TdPlVRg9LNmr8dDLsXp/fKMrXeWJ1NqioO4T1VHwCGq2OcCrbk58L
 LsGLG1izsKUJIUZ2gXls5fdbWU5wV9cuffFkjVjpxd+zYa6qk/a4Bw/4LlOZbraRsJo0
 BtBbqc5TB1YRwDTiBnDvIK7XP/12ASVBKaLbgeAQaH3RrxzcLRJiXQHEqsQ+micgue8+
 k34/yvXsUJxCKuKkg/ylXWro1ACQhLNfK1IjQgjthGfAfcRLSRQQzmD1Na8Mp/KhVixl
 SlWmcWe7neWSG7Ok8w2G1bTAv40A05tzWgxME+zQyzIVDnxe9eRpOxnnEwHmc8FBCLCj
 5KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756591571; x=1757196371;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AoMm8zyxIjPljehp07rdJd/o7PlK1uGZtC8DWy6n09w=;
 b=bLNeI7KoT3FG52g5UrPwtQwzEBPBi4BdIyXSd5FZ5H+QfQFjGb3i1enDYPFdql85Hc
 Dth91Ku5WHafxngF2J8DJsSTJ0ll0h9QSGCGr34ejG+G26q1NIUmoCGPBX8jBDCXl2ze
 0OZ7jK/+o3/aZJbGf796NGEHJ8NmnumrnGzquGMLrULuiSfq0Np2P7JygQFGjlR+++bl
 sJNvV1tb/6gHtrQyLeiBa+/VfKu+8sH/jGmAwuP59agw02YNo6lxXrO/rBYBBcCFuwTy
 0lzARN0BM/fVutNNQ5W6RGf5VTGGZF+7AE4XhuiUgQveGTNoSsLOTXIrU56XnsVspgz5
 UYZA==
X-Gm-Message-State: AOJu0YxMlYFqRcmKFMS2I/hASPVkV0bm5e0aXi2V6+uk0ipB2ifpXBy1
 x6bmpVVJTDvKWw2Nmf7WY2+C0AW0SHfa2XahkF78nn90ypf5X/Ig7LLt1BDsgsEa+bf8GspJT4J
 pcB8Ut4c=
X-Gm-Gg: ASbGncsPpemCs9bGn2X2HNFGYg+Gwl+COkgvMsfBZf9msg4yEK9jQQWnj3gO2uqwdDp
 6cX7K8DqXBJB5NP/rIhXBYbg6KP5ZUDrPyzAEKv6ZxkSOAQOxCKEazvFsaYv0jo7OHtXTL4r4cc
 ckVz/nTYlKeHD0xLLcYocTrDYJ4xyaJwI90RzCoL2m3jcOpSHtvSrCP+aOCdy5ZtBSB75M+qVne
 tzbRuZo3+jvEmqWQJ0qcmxQM47P3GVIKq/fB3PwyuTUtOxWU7HOOlnHkZ5DQe1jqwGsVrg9Z3kH
 Q/R2SMv9H/c7IQbPH2IfPwgY5ELbj3F6ad/Wxt6la40eAzMQ1DWlIcOrXM3c02z84V+D+zfNwF2
 JFegg09H2nqRMdjPRLFDGLBsJNMbiMX+L5oROUvrOA/V3yxADssGYsnjJrH6dYBGJFrprrMFfCF
 9zxCQ+bMY=
X-Google-Smtp-Source: AGHT+IFjbzG/mR/axcNpCDD6hfO4CXj/cHNlX+FC5a6U0hT4qIPpxpAyz9bGfdzDvgk6J/Lu7Bemcg==
X-Received: by 2002:a17:90b:4a92:b0:327:d8fb:f2a3 with SMTP id
 98e67ed59e1d1-328156dfa5emr4190973a91.29.1756591571444; 
 Sat, 30 Aug 2025 15:06:11 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4e5684da06sm2465181a12.17.2025.08.30.15.06.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 15:06:11 -0700 (PDT)
Message-ID: <497b3e2f-8c60-4fd1-a58e-1b311d0870f2@linaro.org>
Date: Sun, 31 Aug 2025 08:06:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] util: set the name for the 'main' thread
To: qemu-devel@nongnu.org
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-7-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829180354.2922145-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 8/30/25 04:03, Daniel P. Berrangé wrote:
> The default main thread name is undefined, so use a constructor to
> explicitly set it to 'main'. This constructor is marked to run early
> as the thread name is intended to be used in error reporting / logs
> which may be triggered very early in QEMU execution.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   util/qemu-thread-posix.c | 6 ++++++
>   util/qemu-thread-win32.c | 6 ++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index ddaa1de4dd..275445ed94 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -22,6 +22,12 @@
>   #include <pthread_np.h>
>   #endif
>   
> +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> +qemu_thread_init(void)
> +{
> +    qemu_thread_set_name("main");
> +}
> +
>   static void error_exit(int err, const char *msg)
>   {
>       fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 62eaa11026..7a734a7a09 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -22,6 +22,12 @@ typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
>   static pSetThreadDescription SetThreadDescriptionFunc;
>   static HMODULE kernel32_module;
>   
> +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> +qemu_thread_init(void)
> +{
> +    qemu_thread_set_name("main");
> +}
> +
>   static bool load_set_thread_description(void)
>   {
>       static gsize _init_once = 0;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

