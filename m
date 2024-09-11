Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4450EE4983
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJqf-0000ZM-FV; Wed, 11 Sep 2024 05:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1soJqa-0000AG-6Y
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:41:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1soJqX-0006OG-6z
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:41:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2055a3f80a4so47159205ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726047667; x=1726652467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZH76peFaXLdICfPd8UUu5baYGOKW8r9xCr4PXI8Nk/M=;
 b=WuXgMtn5k9vLplz+hUYb7H6ksR9E0jKkDCbBW5LOGbhDo6tLFQ+E3anxg0+2c2GJ1M
 XNc3N0Cq/q2ElLHYHaMzXpCVl1/ZBtH3kpi9OjF7vyvjwCAk2nWza77OKMiVP+q/qlLm
 yAl1xBHAXNVZfvCovHVD4oqWbRChPf5yivz3GezKKk55iXh7NfApFlKqIr+S7CJctS8g
 I98WzLsSYdJ+l4ETudElgx77+gwfGP68/lEN36RJhCYZBubbxMgdRLen7/r63OXtpgbb
 FoZNn3zHhPtstM3KKpkj0oPce1sJRMggTpMoP3TEOHD75cFTjtipginLYCcqH/BEyxUM
 DtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726047667; x=1726652467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZH76peFaXLdICfPd8UUu5baYGOKW8r9xCr4PXI8Nk/M=;
 b=tmc6zA5wu72qk4UR8t1wvePV7SxBI9bR4GwDnUVPHs695EYhoYKFk2NeMnydaaOyRA
 k1jRLnCR2qy/de8v/HAJFoXuWfS6uf2hFvWnZSn0liwm1N6QfSTNn9YW5Bj+0Jv0lWq5
 u1F4ldaDr6gUc/7qoPcnYXqBLba6YbA90UbWbSUIfTaUuidU9Q/VQAB8OLIZ3lZGPCt1
 ukdet6Kw8l+8C2h9d9Da9Oykz1uZRJ+74zqP9+J9rxwX+JAR60hdLTfCGN91/2Lc24Bj
 nNNqKzeUj55jMzBYvmNnul5TM6eAkHmU9AQkhnnp5V+fGocVggJEMMJDWGHtEnPNM0pV
 5uoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3manvyeBPir8tiFvwtRJryTrMhocD2lBOB0ILmClxl/+01euxiXpRV5DEoSm2VE9d4fLhVxsvJt0B@nongnu.org
X-Gm-Message-State: AOJu0YwKaqsjUW8D52Qdm9C4PvM6DUqYpjY15sRaOSqtz2bxNp6ur0nl
 L9s/b/p5YujNaCL+NZ+K8q+XsA36TjuVpnnLuueVKOg575Brk6WvX5Wlts3ffCY=
X-Google-Smtp-Source: AGHT+IEhfhfwdLuRZa1ZT7Igq8vngKhwD8/HCRKJeSNTq/lbR3wSLZkiib03oBLW6DRrs0H9qvc3sA==
X-Received: by 2002:a17:902:db01:b0:206:88fa:54a6 with SMTP id
 d9443c01a7336-2074c5e5c4emr43558915ad.21.1726047667021; 
 Wed, 11 Sep 2024 02:41:07 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-198.dsl.telesp.net.br.
 [201.68.240.198]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710eef1e7sm59845355ad.120.2024.09.11.02.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 02:41:06 -0700 (PDT)
Message-ID: <b0b9f930-ac79-4710-ac43-6a26bb9dd0df@ventanamicro.com>
Date: Wed, 11 Sep 2024 06:40:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/39] target/ppc: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-12-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240910221606.1817478-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/10/24 7:15 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/ppc/dfp_helper.c | 8 ++++----
>   target/ppc/mmu_helper.c | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
> index 5967ea07a92..6ef31a480b7 100644
> --- a/target/ppc/dfp_helper.c
> +++ b/target/ppc/dfp_helper.c
> @@ -249,7 +249,7 @@ static void dfp_set_FPRF_from_FRT_with_context(struct PPC_DFP *dfp,
>           fprf = 0x05;
>           break;
>       default:
> -        assert(0); /* should never get here */
> +        g_assert_not_reached(); /* should never get here */
>       }
>       dfp->env->fpscr &= ~FP_FPRF;
>       dfp->env->fpscr |= (fprf << FPSCR_FPRF);
> @@ -1243,7 +1243,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
>           } else if (decNumberIsQNaN(&dfp.b)) {                  \
>               vt.VsrD(1) = -2;                                   \
>           } else {                                               \
> -            assert(0);                                         \
> +            g_assert_not_reached();                                         \

Need to realign the '\'. Same thing with the other 2 instances below.

>           }                                                      \
>           set_dfp64(t, &vt);                                     \
>       } else {                                                   \
> @@ -1252,7 +1252,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
>           } else if ((size) == 128) {                            \
>               vt.VsrD(1) = dfp.b.exponent + 6176;                \
>           } else {                                               \
> -            assert(0);                                         \
> +            g_assert_not_reached();                                         \
>           }                                                      \
>           set_dfp64(t, &vt);                                     \
>       }                                                          \
> @@ -1300,7 +1300,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,          \
>           raw_inf = 0x1e000;                                                \
>           bias = 6176;                                                      \
>       } else {                                                              \
> -        assert(0);                                                        \
> +        g_assert_not_reached();                                                        \
>       }                                                                     \
>                                                                             \
>       if (unlikely((exp < 0) || (exp > max_exp))) {                         \

Otherwise,

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index b0a0676beba..b167b37e0ab 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -316,7 +316,7 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, target_ulong addr)
>           break;
>       default:
>           /* Should never reach here with other MMU models */
> -        assert(0);
> +        g_assert_not_reached();
>       }
>   #else
>       ppc_tlb_invalidate_all(env);

