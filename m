Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C00D148A3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdkal-0004rt-1T; Thu, 08 Jan 2026 02:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkai-0004rG-Hd
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:37:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdkag-0003UR-9X
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767857872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1JjnyJUuQPrBbVHtMi7IR73hwL1c6pzSdtaPxMsyUUA=;
 b=EhNKAziDj7jpIIz9R62GTvyslzSy1JPj44KtuWQD3MRFsK/2Ac3P4UnuHAgyjgvkaMOhzP
 sqaMubCzGllfQjeHr+4Qs7xrgijgBCvFnrGLprYJU7nXiFnLjVna8t4+3hoztMgeGbP1PB
 TNPOgkyDVd9gZ4kv2lkPvZVUN+sxNdc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-YAFRE-dPP0aYvgALWvmlIg-1; Thu, 08 Jan 2026 02:37:50 -0500
X-MC-Unique: YAFRE-dPP0aYvgALWvmlIg-1
X-Mimecast-MFC-AGG-ID: YAFRE-dPP0aYvgALWvmlIg_1767857870
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325b182e3cso1375591f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 23:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767857869; x=1768462669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1JjnyJUuQPrBbVHtMi7IR73hwL1c6pzSdtaPxMsyUUA=;
 b=cAiVTxdwm7U+OAMNjKgb5P0vtC8zQElYsQ+Gj/HtE0jb2ty4j2LXsotoJ7Ii+wPH6A
 GVg8N0FUDubZ01lzQ/aUIzsav5oxtT4WAOxFY70RVx4hqlLF6Pv3grHUe2TACLCrsaSM
 oBhIx+tlLYR5/OL3QEyk/vs2L28g7vvpZ8ZYmCZTPJ2hl/cb8GXqIGoDWjlLYhvD5ido
 j8wor5oPl4WcIPpQQpMFb3HMRhuJ5ZIiAf/PmPS0S2hhCyCx3zfSsLn9jlyz4HosrxUb
 o8WpAQul+eguhwJqOdWKoMAXBpa9GexP7dcPS98qO7TSrg/euzxFRTjsekr7epatTRBl
 0CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767857869; x=1768462669;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JjnyJUuQPrBbVHtMi7IR73hwL1c6pzSdtaPxMsyUUA=;
 b=FEVaqXnPGUlL/jZWx48dBmo1EH168E48GyKo+GGdQne+qZytOC8GVekKilPQ+rrZRd
 NB7hJ/XQcVKYE1OD8Sm5lW/byNJhwgsg+/9mNZiicWApcviQuB5Vc868t9wf3cmNdOOD
 af1mj0ZaMwnweSE0xeBk+Mn13/gWHj/l7w7laZnM/5UkQT3W+lHx3QYsfdi57ZU8bc3e
 fTK6xfI3Y/ppK/1yGRFe8K/gHp4TyN94gV0nNzP/KBZMNU+CUMq3M6eGoZep4s4nRiKj
 U8I8qhs2K8ym6xwnGTRUYY0PJLlxknmMSHLlMs94NLBoGrz0gvvE+9WG9r4BWUz73CO/
 pbfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWItmZQ54XXcq9VKH8DbbBgkpZF3AvJS/oFoafd8Ce2UIZjvt0niyP+jhfery+cD7QLzcXVaeSc6Owd@nongnu.org
X-Gm-Message-State: AOJu0Yzw3wUPYRWNdBu7VVrw7rrKej3C3zjwWi4SUjI3a/TovxPLdxPD
 5MPnS4rsMQ43AuVnpg7/Z4ZLWslr0XqceQ+kGs8k/i7DgZZ8j4Tvf8LjruRaTttkCr5YcP5iw4l
 bg75hg3b1vgi9tJaFy/S+GlFkUD9m5dDkhJbmMDPol7G12nfXdMyIEY09
X-Gm-Gg: AY/fxX7eQOeQHVcpRT/Bu17HUOsSlCj0XUYRbD1F6IS997nHOM82RAcRy+tIn9VPaYQ
 xbmWX1HG8YKn1GyfvF6XQ61XfOgyPbFSXNi3epcfHNxWZSyqcNQCvcQgmNoa1+N0lxvA4oa5FK3
 i+fnEUGdfA/AJ5aAoAZd++WSiWEA2iH3wk4ogFcjsPnu3eCkf8EF52VfQbi6hVGMlqdzSGY+UfM
 gC70/cgKRfQvYgvd3nsasggnaCvjwrn9EC73SMhV35zFhk7LzoZ4TZgLCsc+W8pxdGoEVN6wj+Q
 SD+62CeEO0yZBRHqNLrTvwzB58f1rwcafohZAqLAnOEXCfek2AUIC7Gq8gUWBqgieWfZbcQUrPl
 oJ6FMoNs=
X-Received: by 2002:a05:600c:3110:b0:47d:3ffa:980e with SMTP id
 5b1f17b1804b1-47d84b4101dmr52878645e9.28.1767857869536; 
 Wed, 07 Jan 2026 23:37:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoLSYV7FCUXa15np/P1ZuydXJERldLS3ZLavYgACD0uHsx9FSskXfi/whQP+zQWC2ah2Xmug==
X-Received: by 2002:a05:600c:3110:b0:47d:3ffa:980e with SMTP id
 5b1f17b1804b1-47d84b4101dmr52878475e9.28.1767857869194; 
 Wed, 07 Jan 2026 23:37:49 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f70bc4fsm134081635e9.15.2026.01.07.23.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 23:37:48 -0800 (PST)
Message-ID: <d14892bf-a2f3-40e2-910c-a1898ede74d7@redhat.com>
Date: Thu, 8 Jan 2026 08:37:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] target/s390x: Replace target_ulong -> hwaddr in
 get_phys_page_debug()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-7-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
> mmu_translate() fills a hwaddr type.

Does this depend on another patch series again? Currently mmu_translate is 
still defined like this:

int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, uint64_t *tec)

i.e. the "raddr" parameter is still a target_ulong pointer.

  Thomas


> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index a6c89ed0af3..59e1fd0c4fe 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -43,7 +43,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
>   {
>       S390CPU *cpu = S390_CPU(cs);
>       CPUS390XState *env = &cpu->env;
> -    target_ulong raddr;
> +    hwaddr raddr;
>       int prot;
>       uint64_t asc = env->psw.mask & PSW_MASK_ASC;
>       uint64_t tec;


