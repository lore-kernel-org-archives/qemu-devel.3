Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2250C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 23:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzN6D-0004qa-Oa; Wed, 26 Aug 2026 19:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzN6B-0004qC-OU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 19:32:03 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzN69-0000uK-94
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 19:32:03 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1483913a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787787119; x=1788391919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hn+22UZR7MKGGTHWaJBn5Gu4IiPZajSfCXhZ33TCHY8=;
 b=vGxvk0g1cHBMbLXpRjZmxHnpoDhj8nwnEuCS08Oy5n2pQRzcrjr4WuznzDEpemjsOc
 1yCjkbHOfjCOZzE4JU7ubpROmcHyZp/0n2x+lNqcB/b1Guc1z0vOxVuUYZaDDJ7fCSa4
 f23kMFRUe+jofZdQ8xGyOdxrW2ku87v3LjTnjp0/QIb7NZyLnqDbqPcN1egcGJRf1aGl
 eWnIp2xnY80C8S0v9CwZ4UGZuNlMIPmBh3g+4E7iX5LT/Mw/+m0r41D3ujuN0Kmq70jg
 udBS2oOo8iW4Puvrci13WfI+NlBpQA/Txjv9ne5ceLULgz7IvXyMWQXMethOxn4gV60L
 fSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787787119; x=1788391919;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hn+22UZR7MKGGTHWaJBn5Gu4IiPZajSfCXhZ33TCHY8=;
 b=Mjz9oX+plsBEm4LGsJ0vb3oat+pdK9k38kX4ZeLAuST49uTzQKlWCU0j4j73bzjVTr
 1ni2//rsL3XxnpjuQLmSHj5TlgMh3YukHe2m1ANFE4Otk3CYa4fBn/MyNkpaq/S6AJa8
 R/Lwd4rMBNaZ4Vkgl4yzPyJ+Oz+lKQAn8SMVz364LKe72SnZ5ivQjIrvoF3Uo1NF2qTh
 6euMj4ArD7X2uCUbRr4F+Ubn310hbcPUHT7pXfw1YWS7efcQHC09QUm0+afp0Ftk9Dtd
 b5aKd0HGaJva1+T5Zza2GAkIU/HocI/qKOgQpL0ZJ28j49aljQ/DY2Z2mkB+/5hMzDrE
 mJyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpwl7jJnv8JNRZ+lunLRz3LM0Wen4htdC8pzJVhoXuSM18eoLsqi2bAscjePk+P5cTDmVliIORFjXFJ@nongnu.org
X-Gm-Message-State: AFuF++nYzHEhYAkI5kvRJ/6J/IjvD77x48v7FlxNXLQ/s7X6bhAqkPwt
 Xj7s2aA6FD/qieoLie44DxP9Q41NAKqKdR6w61SAubT27lF2WwC/hqzWgPr0tP5vcxI=
X-Gm-Gg: AR+sD13C8l4wx/5h5r6S812efJMt5LRcFiGfo942sXtUKsYJCmrbLMgXysG4Lvu7j2R
 TBLnvVraMVXbLIr3PMGa8Iwu4Vtc4e+tdDEvCAlcZ2tWNBxEUTlYJBpb8OBjAtNwsIMmtbVybeN
 B9BXvVn5ZZQW2Wrj9VlsLJrTZF0o8K0NzAf0DMWlVfxv5DLFW/5FTOKH46LyFdGxEkh1ZrpwRg+
 FbS9ffdEvCpzqdTWHfnbgWL8ZVDG+AylPlhroDCrI89D7z77bqkB35RIPIq1pPki96cSdKYpP+T
 Puut3iQiEFUj9jPwfZELZA1FH0/7WUEz7C3VhSrOAU4y6wwG7GWQMu8R+5HX3XfRQ0GgILMuPpk
 fz7ENaH5e3ARkBME/6LlwXEr1VSFxcJIDcFv3fwd3yo2vPrjZJS+iupSnuULfWj2VT4DMApBzVC
 prOyXODf6D1MNU6683eDqdD1WCYYy55HFA1F6OhMkjreJx/CWxnPI+eay6i7P2AXh03tWeYXRH8
 hjI4Yr6JCJAwQEJL4j4a5IeOxij
X-Received: by 2002:a17:90b:4f49:b0:395:4de9:b30 with SMTP id
 98e67ed59e1d1-3966d1baf30mr19867634a91.5.1787787119285; 
 Wed, 26 Aug 2026 16:31:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d3c9e4sm210578a91.2.2026.08.26.16.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 16:31:58 -0700 (PDT)
Message-ID: <77f29009-66e3-48a1-8663-bc567ff1c1a8@linaro.org>
Date: Wed, 26 Aug 2026 16:31:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
 <anxQdlwxAtqfl-N-@redhat.com>
 <cc88ff07-474f-48d6-a2a4-1a2c3f64f3fd@oss.qualcomm.com>
 <anxvMQpZlBUu5SaB@redhat.com>
 <9db3cc07-61e6-4740-823d-112ec80f216b@oss.qualcomm.com>
 <anyCswBYBZWeMt3I@redhat.com>
 <e40e5a75-cb20-4608-b628-f363068a36ba@oss.qualcomm.com>
 <b0930315-f3b6-4fcd-82ca-11028856c343@oss.qualcomm.com>
 <9292ce2a-6493-41f9-85a0-b6d90f1fdab0@linaro.org>
 <7c0f6c44-6f60-4d3b-8d04-cc3e9aadb5f4@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7c0f6c44-6f60-4d3b-8d04-cc3e9aadb5f4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 8/26/26 16:29, Pierrick Bouvier wrote:
>> Can we please just have a plain callback?
> Something like:
>
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -494,6 +494,7 @@ struct TypeInfo
>       void (*class_init)(ObjectClass *klass, const void *data);
>       void (*class_base_init)(ObjectClass *klass, const void *data);
>       const void *class_data;
> +    bool (*is_available)(void);
>       const InterfaceInfo *interfaces;
>
> And used as:
>
> ...
> is_available = target_aarch64.
> ...
>
> We would keep the exact same set of types registered than today.
>
> Would that work for you Richard?

Yes, please.

r~


