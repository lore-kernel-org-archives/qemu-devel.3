Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C59C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZmF-0004gf-8v; Fri, 06 Jun 2025 12:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNZmB-0004gA-Cu
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:18:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNZm9-0007pF-RA
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:18:39 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so2045938b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749226716; x=1749831516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7b7GfhmSNpYAm204tVlseTvlPS7fdpMp975RzEXDCtM=;
 b=PfUr/w/DZ5E0+buWLiTog0Wc4us8s5U9k/LgnBlE4g14JBPAr+RQA2uvLwI/Ho0TiJ
 Iu8tsUOKx0TMf4Fb3LK71nkIpnsNcBiRzvSVtBskI5zdIj6R5sAd5OnklXqxxs5PSy5y
 2fveqqE/60swOxZ4sle4R7yrVgPuH9RGKec5neIL0AH0dflltJobgU1PoOTyHa+iAhw9
 9Lthh2iNOIdYVGo1PbfzSiiyiA1k77ikl8t+oYlG9tLD7+iCRJVG0Q7C9JBbBjs7hX7y
 PGVyeAM/ZnYQpeyGaCkzweghOnxMOac1JtWLzPtVw55oga491XEfU+WWUchjfqwxBUdt
 YzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749226716; x=1749831516;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7b7GfhmSNpYAm204tVlseTvlPS7fdpMp975RzEXDCtM=;
 b=DxSFJp2rrwuGis9r4Xc9oUsl2orYDzd3aFxGC7jMetkNadXKn1WJgNb3KnbtNPxsbh
 3Hrcl1lyPqNvwywZVogsSJ65jJHtGrs+Atk5+DWAOUpc5rh++FsPFkARe/O1JUqTne7s
 kZelBdvcT2tvxJBoZRRLUNfFRCpE6DeAfdErMVRv3Z55pKjYjtF8DUsmHbolJFtoWhdz
 rbXX6fBi7cvLQA2iF64pdJuJQmLUd6SBwr4II+uHdU7tMNEM7cnLkSrj8sfurLxT4GQO
 UKW8aFl+BJ/fwNGpBb0GRT//t9oNYfhLnX37sGyOf93O0TAik32u87oHSfyPaSoJ6H1u
 a3oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlvry/19Ze6wFMUXYsdBN3o/85OooeJMpnvgSokLNeY6ms512bRXBvo1Kmd0paJ4Trn/5fN5lTdCc0@nongnu.org
X-Gm-Message-State: AOJu0Yy5oi08CAMFwwU9jLaXlSucE4ziqXq7mZ1oKNm1spCxKJlmf2Wi
 5/F3yqCm/GTtDdV2Gh8tYCgdWw7UgmI6T4u0W7BxC6WYVl8gtpEZelpqbHmt413Ucxk=
X-Gm-Gg: ASbGncuC+3iyDQFKdt/BL3cBlZSp2p9zvKncoKriYZF1BrcWumoYjK9esiQAYR/Cldm
 P3xskO1Ps5znN66zU2ABBnLMcP2a2yk/xNT/vKiI3oO0hzhCe5OKncU/y01p6YLHWCTXxW33Q+a
 b1Iz8AAkaDDfKEh2As/NiyVhqUdmVZ19qtU1dN8mbLyapjwiRrSt6F2RFVs65eqxMuYeOD+u8jT
 pfuAZyWA8LNc16RjQZiZG0oAKEfJCfk/2UqjKTxZjR31IH1SPfeBUZlzMCzpCVN02rO1YEvMTjY
 YniTDIUh1XBzxS0Gdy22HLexyzr1gNNphjM6tFGIJe7104jDvALIGVYlNpN1nInb
X-Google-Smtp-Source: AGHT+IGVZ3EE9U2MIt6QYR1bhaMHVedZ8Xts2vPxfZJ+LUWdkXxdBmLYaBMNL9liu1gCHCN3PDJ1kg==
X-Received: by 2002:a05:6a00:244f:b0:740:596e:1489 with SMTP id
 d2e1a72fcca58-74827f3d35emr5636940b3a.23.1749226715869; 
 Fri, 06 Jun 2025 09:18:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0e9c3csm1447469b3a.153.2025.06.06.09.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 09:18:35 -0700 (PDT)
Message-ID: <811aa1ec-352d-40cb-a42b-2bca5dcf64cd@linaro.org>
Date: Fri, 6 Jun 2025 09:18:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/unit/test-char: Avoid using g_alloca()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250605193540.59874-1-philmd@linaro.org>
 <20250605193540.59874-4-philmd@linaro.org>
 <7832d31a-2707-4cc4-9838-f2ea4b6b2cea@linaro.org>
 <0f7673d9-31f4-495b-a118-f53ed6c6fc37@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0f7673d9-31f4-495b-a118-f53ed6c6fc37@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/5/25 11:09 PM, Philippe Mathieu-Daudé wrote:
> On 5/6/25 22:53, Pierrick Bouvier wrote:
>> On 6/5/25 12:35 PM, Philippe Mathieu-Daudé wrote:
>>> Do not use g_alloca(), simply allocate the CharBackend
>>> structure on the stack.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    tests/unit/test-char.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
>>> index 60a843b79d9..f30a39f61ff 100644
>>> --- a/tests/unit/test-char.c
>>> +++ b/tests/unit/test-char.c
>>> @@ -993,7 +993,7 @@ static void char_udp_test_internal(Chardev
>>> *reuse_chr, int sock)
>>>        struct sockaddr_in other;
>>>        SocketIdleData d = { 0, };
>>>        Chardev *chr;
>>> -    CharBackend *be;
>>> +    CharBackend stack_be, *be = &stack_be;
>>>        socklen_t alen = sizeof(other);
>>>        int ret;
>>>        char buf[10];
>>> @@ -1009,7 +1009,6 @@ static void char_udp_test_internal(Chardev
>>> *reuse_chr, int sock)
>>>            chr = qemu_chr_new("client", tmp, NULL);
>>>            g_assert_nonnull(chr);
>>> -        be = g_alloca(sizeof(CharBackend));
>>>            qemu_chr_fe_init(be, chr, &error_abort);
>>>        }
>>
>> Would that be more simple to declare the variable, and use &be in the
>> function code?
> 
> More context (see reuse_chr ladder):
> 
> -- >8 --
> @@ -991,45 +991,44 @@ static int make_udp_socket(int *port)
>    static void char_udp_test_internal(Chardev *reuse_chr, int sock)
>    {
>        struct sockaddr_in other;
>        SocketIdleData d = { 0, };
>        Chardev *chr;
> -    CharBackend *be;
> +    CharBackend stack_be, *be = &stack_be;
>        socklen_t alen = sizeof(other);
>        int ret;
>        char buf[10];
>        char *tmp = NULL;
> 
>        if (reuse_chr) {
>            chr = reuse_chr;
>            be = chr->be;
>        } else {
>            int port;
>            sock = make_udp_socket(&port);
>            tmp = g_strdup_printf("udp:127.0.0.1:%d", port);
>            chr = qemu_chr_new("client", tmp, NULL);
>            g_assert_nonnull(chr);
> 
> -        be = g_alloca(sizeof(CharBackend));
>            qemu_chr_fe_init(be, chr, &error_abort);
>        }
> ---

Ok!

