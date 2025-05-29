Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78760C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiLn-0005Es-AH; Thu, 29 May 2025 14:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiLl-0005Ef-A1
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:51:33 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiLj-00051Y-KG
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:51:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22e033a3a07so17991645ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748544689; x=1749149489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wPR3PfdkQNmcceVUz9Q/xfdEqBAisag/mQQPvyurlEg=;
 b=gYs8cpEo1eubym/PA4s2VydZqvHDnDk19841GUoMXaRtPulqzQe4hj97gTijrVXohT
 0qHUxDoGHrpUhpDNL4jGr/tnHEQ3S5NoRjsXWwnsji478E3DzTSG1HAVw9BdSZHa0Np8
 SpI5fvZ4E22nAB85ppSV1NXGCr6RzN8A7QtN8IDMoZ/OBGyka8WyLkCRNrrUTjA7Q+JK
 2Se+5pEzbuRq+etLiwb7vmNr+P2+3YX9H0UEAk+ikpYJ1DXVH4X1/ZgMoyXTmomaPe4o
 UImljK3iJePq6pVt3x81X9sMFUc/ox2vH6rCsY0q3Nr+Jk67odlHEc9HXKxrFGOI+qq8
 vtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748544689; x=1749149489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPR3PfdkQNmcceVUz9Q/xfdEqBAisag/mQQPvyurlEg=;
 b=Qye+U5l143dlt1vx3gTOEcjwQOPsccO35PghwfNH508zcPcoQbpDuTW6dx7zCHeuYe
 xuy+ooy9CVUsKdM1ExdPFGEHaVpmX09+SZ4isHRLoexsgXzPwCyzIhxtCqW//NSiI6aH
 os0g7oomtDAG09GtvD9QhA/TMbTrB6sfpnr76N8jBLVyhYjM/X6ZAzpzVg+Z3Prcehdk
 zPUEN14OltSDjaC7oK0lnW1ifxxeSrLZhV2I3wdvX5TC7souUGxqtWfTqRPCvYLwqCqg
 MQ1mxUEKW2xSGMA8fdyJEzVJEgKJN+iM7B524nVg4zc4lOgevk075BLPASJU7zm12hR3
 Gn0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuq5GmUXbzzZv0unW1LSAaMQdIdqlMC1LWqSg20JNCh5ZLHZ2xPGpL0uKgA7S7nj1jmVo9YLtHHhQa@nongnu.org
X-Gm-Message-State: AOJu0Yz5q2oU5wwWRYE/3WOW31KncxLM0mhdXLGEh6fD/btTK3ax9ejN
 F+Mtlh/H+6Ktj2f5NpoID9YiPKhX//Xb8VnRaWA5fLAzTSjNG2Aa8Hy3hZYOf+cOZdI=
X-Gm-Gg: ASbGncuyKWqakvuAwzaYSBD2iquxGWavnJP5BNrJ54w6SNDHPZeHMpa8FsrZu3otvnQ
 IYhnE2hiFqXwLAXNHT+GNukWqlYXxFPuWfMWaoxA7c0fnx4kGGWj8kkrQi4AE5ON1gP3Md88kIy
 v3/tN5jPzwDLp5zi4zS0HSY0DXFz8fSHhlZl3CC9134oUCQ2DNsm83M1NcKfNM8y8O8OZla5z0K
 6UVkDMrAqAmunM8gds8t/5H0wIuq/+/TWo+Ca7nWv+i43rKKPL1VxxZ5Nk3hUk7jUia6bZhA5YQ
 9ajqjHqy7e4QYJMhfvvgm8S/96IAwo21waHe6y/lKFF8hblI+/LS5sgv+C50jQCJ
X-Google-Smtp-Source: AGHT+IEyUI9NhobOQNxsUUskKSnMgbznkJMgGMRS8NICSwtWslTnu50nCDX3ICGWR/JVYaiYrsjZVQ==
X-Received: by 2002:a17:90b:2882:b0:311:c1ec:7cfc with SMTP id
 98e67ed59e1d1-3124187cc1dmr912278a91.27.1748544689544; 
 Thu, 29 May 2025 11:51:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3123b29f89esm352304a91.10.2025.05.29.11.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 11:51:29 -0700 (PDT)
Message-ID: <29bb01c9-8f30-4d67-a968-426225bc701a@linaro.org>
Date: Thu, 29 May 2025 11:51:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] plugins: Remove use of qemu_plugin_read_register
 where it is not permitted
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
 <20250523020344.1341179-9-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250523020344.1341179-9-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/22/25 7:03 PM, Rowan Hart wrote:
> This patch is required to make the insn plugin work after adding
> enforcement of QEMU_PLUGIN_CB_ flags in calls to read or write
> registers. Previously, these flags were not enforced and the API could
> be called from anywhere, but this was not intended as described by the
> documentation. Now, the flags are enforced and qemu_plugin_read_register
> can no longer be called from a vcpu_init callback because it does not
> request the QEMU_PLUGIN_CB_ flag (nor does it have a mechanism to do
> so).
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   tests/tcg/plugins/insn.c | 22 +---------------------
>   1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
> index 0c723cb9ed..265d3ebe9e 100644
> --- a/tests/tcg/plugins/insn.c
> +++ b/tests/tcg/plugins/insn.c
> @@ -81,25 +81,6 @@ static Instruction * get_insn_record(const char *disas, uint64_t vaddr, Match *m
>       return record;
>   }
>   
> -/*
> - * Initialise a new vcpu with reading the register list
> - */
> -static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> -{
> -    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
> -    g_autoptr(GByteArray) reg_value = g_byte_array_new();
> -
> -    if (reg_list) {
> -        for (int i = 0; i < reg_list->len; i++) {
> -            qemu_plugin_reg_descriptor *rd = &g_array_index(
> -                reg_list, qemu_plugin_reg_descriptor, i);
> -            int count = qemu_plugin_read_register(rd->handle, reg_value);
> -            g_assert(count > 0);
> -        }
> -    }
> -}
> -
> -
>   static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
>   {
>       qemu_plugin_u64_add(insn_count, cpu_index, 1);
> @@ -295,8 +276,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>       insn_count = qemu_plugin_scoreboard_u64(
>           qemu_plugin_scoreboard_new(sizeof(uint64_t)));
>   
> -    /* Register init, translation block and exit callbacks */
> -    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    /* Register translation block and exit callbacks */
>       qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>       return 0;

Let's see what Alex thinks about this, as he asked to enforce those 
flags, and may have an idea about how to deal with this.

