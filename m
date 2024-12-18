Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0766EE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyFs-00019D-GN; Wed, 18 Dec 2024 12:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNyFq-00018h-FT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:54:38 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNyFn-0000hu-KW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:54:38 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e15717a2dso2864955a34.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734544473; x=1735149273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHe0lPHoTkFzFtNSrm+2meSSy6A7mD+nv7o5HkjCsdY=;
 b=OkZEu6COM2BArN0rLvQgM9CULtCvmqLn5FEYpqTGgLjn2AmbbeFDSlRrCrCf9bA0XS
 UR+R4ZhVMCDAg76fNBr2igFjhJumGsu4Vfup6q9EmXtSGWXYXbyEE94mIukmxS85HoYd
 JWxZ3yuWP9obzaNL0ZSd+Hjq86mQ/LPI6Lip2giKDyb61zZfXztJPNMo8rQIp9qOMUIF
 HzdLKdiMZAwF1UjVONXebjg9ic4p25XqpzA24dEbS89u+uMnMmwSUXJN6YgS6l+M84ct
 mfSz1I2tCuFV0I2HFi4otuOy+YRTrXmZkNeslvmhLDaPYWKaVav0m+LVSTnCqcx22KMe
 kcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734544473; x=1735149273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHe0lPHoTkFzFtNSrm+2meSSy6A7mD+nv7o5HkjCsdY=;
 b=X62yL/c1/TKK3cYQ697Hwen1/9kMTcnFnN6GiJa/bMnRwuVNyjzh4Hu3wDpDGNiKJ3
 t/oDMgQM2eZiD7PKTsU0dV6CrGp/sdZC8O1ztYR3hdgrevMq+/GbDq0Hg621yVUnBLOO
 vkMd6MHBLA8ONwUhZoUxaCEXnVi9IL1rDW8Ih5yk7pFyMf5FsKf3D9OjISdtLsnt5TgC
 2RUo5lYxZ5npSHKz5QQSNG+vBH1cuBemEwBifFO3GkIiHYjNSNxZS6M5JgxtIy07+ifG
 1pfMi+H99Yd7z07psRbu7UYKk1qKbjdmqp2Iy0fdYJVM4cl2XLAS5FxWVRjjXqRLyq8A
 noUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxELM3SP8Ea71CtAxOTbG3r/XkwIsQK1nGGxfSPFM6xEjW35MaL3bwzTKAdPlAYwxbgyy3FYSZ4mON@nongnu.org
X-Gm-Message-State: AOJu0YxENDQwyHvmgNhxWK96kbhlOklVuu2zACoatPdmFKq5TMW6yaRE
 eFV6FaTf0gHSkzElprbI0pYqh28sbb42sWLaKuo/Mpfu2m82DqlDJKItzCLJJBo=
X-Gm-Gg: ASbGncu30PjoZAuYSnccEZFYZtAVLiB0FnPd3JL3fXY8d1UkgFvdO0Y5TDgb9ypcqrg
 9d8nieU7chmRI4T+4N7r3iISBqSw7FO6BKWTu4l3kyOOx9OgdiL1Px1RmB+UP2reXstZCaACYJp
 SEQdj7SAK60BN76rRVXZp12DhpLz4FR1awtIQX86UueKCwilMrsVwz49g93Yyn1HAgIsVhPZDwL
 UZJfbK89xcqZNSFLDRQ4K11xFlqUVjeslbBHBnX8uZvwSr1fBmZLKGJwoPpR7+J0Ski5WAzhg==
X-Google-Smtp-Source: AGHT+IGkwXnZmhS/mYX8BykeuEg6hchaWQXvVPVUocB3QzLmXHPv76aHVpHk9PvWCAQ1F+u8nlGpmQ==
X-Received: by 2002:a05:6830:4988:b0:71d:3e4d:becf with SMTP id
 46e09a7af769-71fb76312c7mr2147819a34.27.1734544473470; 
 Wed, 18 Dec 2024 09:54:33 -0800 (PST)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e484aafc1sm2648930a34.57.2024.12.18.09.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 09:54:33 -0800 (PST)
Message-ID: <87dd586c-039e-48a3-a039-72cd037ddeb9@linaro.org>
Date: Wed, 18 Dec 2024 11:54:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] contrib/plugins/hotblocks: fix 32-bit build
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, philmd@linaro.org, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
 <20241217224306.2900490-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217224306.2900490-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 12/17/24 16:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/hotblocks.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 02bc5078bdd..f12bfb7a267 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -29,7 +29,7 @@ static guint64 limit = 20;
>    *
>    * The internals of the TCG are not exposed to plugins so we can only
>    * get the starting PC for each block. We cheat this slightly by
> - * xor'ing the number of instructions to the hash to help
> + * checking the number of instructions as well to help
>    * differentiate.
>    */
>   typedef struct {
> @@ -50,6 +50,20 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
>       return count_a > count_b ? -1 : 1;
>   }
>   
> +static guint exec_count_hash(gconstpointer v)
> +{
> +    const ExecCount *e = v;
> +    return e->start_addr ^ e->insns;
> +}
> +
> +static gboolean exec_count_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const ExecCount *ea = v1;
> +    const ExecCount *eb = v2;
> +    return (ea->start_addr == eb->start_addr) &&
> +           (ea->insns == eb->insns);
> +}
> +
>   static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
>   {
>       ExecCount *cnt = value;
> @@ -91,7 +105,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>   
>   static void plugin_init(void)
>   {
> -    hotblocks = g_hash_table_new(NULL, g_direct_equal);
> +    hotblocks = g_hash_table_new(exec_count_hash, exec_count_equal);
>   }
>   
>   static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
> @@ -111,10 +125,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>       ExecCount *cnt;
>       uint64_t pc = qemu_plugin_tb_vaddr(tb);
>       size_t insns = qemu_plugin_tb_n_insns(tb);
> -    uint64_t hash = pc ^ insns;
>   
>       g_mutex_lock(&lock);
> -    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
> +    {
> +        ExecCount e;
> +        e.start_addr = pc;
> +        e.insns = insns;
> +        cnt = (ExecCount *) g_hash_table_lookup(hotblocks, &e);
> +    }
> +
>       if (cnt) {
>           cnt->trans_count++;
>       } else {
> @@ -123,7 +142,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>           cnt->trans_count = 1;
>           cnt->insns = insns;
>           cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
> -        g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
> +        g_hash_table_insert(hotblocks, cnt, cnt);
>       }
>   
>       g_mutex_unlock(&lock);


