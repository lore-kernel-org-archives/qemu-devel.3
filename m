Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBC9C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqNr-0005xf-7A; Tue, 28 Jan 2025 13:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tcqNg-0005wr-N2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:32:14 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tcqNf-0005aq-4W
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:32:12 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so144236575ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738089128; x=1738693928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZMiW42i/FOJkEcdj1yuSIik5IMzJMuSgQyY9MOKepo=;
 b=DByslOd35wpFgT+LCsmQiRuBZW+4i9rbMv/eVB6yXbT3Kuarfd8IeQvV26bLw8W3X+
 cFfY5QiyDTRvfeZDcr9fF0DgYt8G9ZTADhFKVWJhXbOR0GA1f/730kalRf9NX5njmsEk
 dZYwq32TUpIJuycfFV6yhUKlxIc1J5GkmnpN5dJD4m+gTrnGEqX1RBQ7cASS2jpOd++n
 TQKVrft4jkFVy1iPc8RxJ7X/zyszxSHJq/x83UwVxyt2kRQhEWFCDTTnxekwDBECodz2
 U0Oxm68e21jUJJMdNRyJ38b2MQSfOuJTC0SnJDNQ5MHNApUiNGPbzOhAYlkKHnXX3JP/
 rQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738089128; x=1738693928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZMiW42i/FOJkEcdj1yuSIik5IMzJMuSgQyY9MOKepo=;
 b=tTcdeAhE1XetSceOY90JQQIvxME1rXLIYF+xD6eoge1OXyNiELB8p3C2YUdHz2HO79
 PfsSddQWXtvSnjm/1G14UQsdGbQ+13edesnbxHT4MUGHy7p2XMp8qct//iLbc8+mxOyE
 rgKHqsTKVJ1mJbQsuRyp+aO3fwt7xvgFAln0biW7onu85u5FGMLP62eZXX6atHKIryNQ
 q9EJi0fn22Oec15/ZE9rxnmV3G8CSQg6u/BhhRQ5uDFPTIvXVqpANjoGtomK6OFd5M1d
 gTEnvYDzo2nTJoQUxcgMbAJI0keKkTEv2AuFN+qLyBTNFBr4xOD5gzVCIjM17FeyTEhi
 aW+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0I9pFX/ZwlX4sPA/HviKRTkC3SN40aO/GR0uVaX0vjTTFPkjBEDyrnaP5hgNrrkVQewguJekQ86zD@nongnu.org
X-Gm-Message-State: AOJu0Yz3q39nWVOH2SGjaLCboAsqqMCuZ4PVxJCGY91oJ6Uz9mWoowtb
 RuIjDaA2dQqxrjd8iYWurXhwsrg+rkTGSQ5dph9rTaQbnDksuZjJve5m2XhFQzg=
X-Gm-Gg: ASbGnctYyp0Saeqd6apG+fv3qanyxXzARrWstRyMy7ZXxgEIOgAc6b+PbWGALVz5ryQ
 NS0qwoC+4t7v1d3VqJiq8vmEGWNpQ+v8NMt2Tg2FA74Q06G5nIg86N5/AJzUt3MwOUZr6BSYys2
 KO0J8lzfwSHKFmcCiRQvBdRQyoDRoZO61DqC6K7Rs2yTgRPkJOP5iPe8sNYYNivpps1ZkQ8H70D
 4YEi8xpNKz/cW/8hivNVAaDYhhU8BU31oXmGmLJx4kVz/PvRnBdO6948IniZ3RTQzWO0XB0gpID
 8KDJxLokzZvQBelCwYJKNM8kfFM4
X-Google-Smtp-Source: AGHT+IETyQBoCDKrKvvnx1vaxIC+YbbWz7lZRHxPdvDhPTnWige4e9MBqjVTWDvJP3ZBUduZD6cxjg==
X-Received: by 2002:a05:6a00:130c:b0:728:e1e3:3d88 with SMTP id
 d2e1a72fcca58-72fd0be17f5mr251260b3a.7.1738089128592; 
 Tue, 28 Jan 2025 10:32:08 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c779sm9832172b3a.145.2025.01.28.10.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:32:08 -0800 (PST)
Message-ID: <2858941f-c745-41d6-8b52-cfa7f4648574@linaro.org>
Date: Tue, 28 Jan 2025 10:32:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] plugin: extend API with qemu_plugin_tb_size
To: Luke Craig <lacraig3@gmail.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250127201734.1769540-1-lacraig3@gmail.com>
 <20250127201734.1769540-3-lacraig3@gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250127201734.1769540-3-lacraig3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Hi Luke,

On 1/27/25 12:17, Luke Craig wrote:
> ---
>   include/qemu/qemu-plugin.h | 10 ++++++++++
>   plugins/api.c              |  5 +++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index a1c478c54f..1fa656da82 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -476,6 +476,16 @@ void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>   QEMU_PLUGIN_API
>   size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
>   
> +/**
> + * qemu_plugin_tb_size() - query helper for size of TB
> + * @tb: opaque handle to TB passed to callback
> + *
> + * Returns: size of block in bytes
> + */
> +
> +QEMU_PLUGIN_API
> +size_t qemu_plugin_tb_size(const struct qemu_plugin_tb *tb);
> +
>   /**
>    * qemu_plugin_tb_vaddr() - query helper for vaddr of TB start
>    * @tb: opaque handle to TB passed to callback
> diff --git a/plugins/api.c b/plugins/api.c
> index 7ff5e1c1bd..177f0ac9b6 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -241,6 +241,11 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
>       return tb->n;
>   }
>   
> +size_t qemu_plugin_tb_size(const struct qemu_plugin_tb *tb){
> +    const DisasContextBase *db = tcg_ctx->plugin_db;
> +    return db->size;
> +}
> +
>   uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
>   {
>       const DisasContextBase *db = tcg_ctx->plugin_db;

by tb size, do you mean the size, in bytes, of all (original) 
instructions of the tb?

If yes, you can get it by fetching first and last instruction, and 
compute the difference between last->vaddr + last->len -  first->vaddr.

Regards,
Pierrick

