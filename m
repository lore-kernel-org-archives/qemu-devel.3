Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2646EE4982
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJlf-0002LH-FQ; Wed, 11 Sep 2024 05:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1soJlJ-00022N-4L
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:35:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1soJlG-0005kd-Gk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:35:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-201d5af11a4so69525025ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726047340; x=1726652140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1u4hLYLb6JvJyT39AyvjEboo66L18yRm1sqg09O3j9E=;
 b=PiHWs1tyuu0X40gjVWBhgrLzBbp5+qHEIHZa7UOaJ4wHHRPMpMq/VrwNT+09/mSIhS
 obNXV+oEvSp6Y4hGkHelDRZ+RYsoX4L60JgTG4gTs0axza93Deyt59Fds3Kyt2a9e0pd
 TDXJBDnzrpY90BmusI3+1k9aUAq62+7VYdr/mRR5mJpBP7YZwEg430meqHphMXYwM8PH
 kZWzlj24qrsa9XPGcJXDgOuejbzEqGSIaAZd1PuXsepK7LmlMzxmQ7CPyfAHLYhLlmDC
 7OyoPQYWJLeKlZSuPAx7jkZPpTh1v+AiFO7DuYKf00am8vS8iwhqlp69/c46w5YRm/mA
 7CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726047340; x=1726652140;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1u4hLYLb6JvJyT39AyvjEboo66L18yRm1sqg09O3j9E=;
 b=gK/t+8gNq3kfPbATBoydPsQDcfFsIpQs96C9BB9QihSj/wfRoq25K/KCsSaPPwODFl
 e6oRAOdV6Mpcqwt6kTh3H8mfE1RjTg+gAty4/GRRjwy8kEwEXGEl6TrZkAol+QHrwrof
 laESfxM439IDcKpsOd7OvekXd5P0tsEa0EV4v4SGtwXsoCy0vYKJX2CxzIsEoqrJmR7E
 YywlD42Y9S6+sX4CPuFZxzI8ZlwQ4QGoPUDHtZP9QUYXjmews5TPQWCuqaNXCV+zioeR
 TR2E7kQrnXs7rH77nqKre3xTjBgOvnVFl/ha5Z2Wkb9ExbtLyHU6fcAKXgKOBcDMZ1BJ
 VBDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbRuI0e3ZeGSMlwFSSIPuy/m2st7FkfJFez4GtQClxVZtViU2vFi073ub3BRJnuogV22Txs08V/ZQ5@nongnu.org
X-Gm-Message-State: AOJu0Yw2NBJSuUdhhJ0oMyginLf/kyX9hgzmWnYDXGdw5A0Y5VAkX5j9
 bnkSEO06Lq5aweW0aR+ErvW/sxIwjx2XKDR6vxSZwvngwSwxlGnUC3wnZeTnYE4=
X-Google-Smtp-Source: AGHT+IFUx/BwHC24gWqvFB3GjiXa6Pwl4/OE8FDUMSu9YsViqYb7FQaE3SBpFeH2lAaF7lGvC5UgZA==
X-Received: by 2002:a17:903:290:b0:207:3a53:fe67 with SMTP id
 d9443c01a7336-2074c5f7f19mr61649475ad.32.1726047340049; 
 Wed, 11 Sep 2024 02:35:40 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-198.dsl.telesp.net.br.
 [201.68.240.198]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d8255dc0d4sm6861245a12.64.2024.09.11.02.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 02:35:39 -0700 (PDT)
Message-ID: <769135e9-c377-461e-86ed-e4e1de6ff0cc@ventanamicro.com>
Date: Wed, 11 Sep 2024 06:35:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/39] target/riscv: remove break after
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
 <20240910221606.1817478-35-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240910221606.1817478-35-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 9/10/24 7:16 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/monitor.c                  | 1 -
>   target/riscv/insn_trans/trans_rvv.c.inc | 2 --
>   2 files changed, 3 deletions(-)
> 
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index f5b1ffe6c3e..100005ea4e9 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -184,7 +184,6 @@ static void mem_info_svxx(Monitor *mon, CPUArchState *env)
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   
>       /* calculate virtual address bits */
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 3a3896ba06c..f8928c44a8b 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3172,7 +3172,6 @@ static void load_element(TCGv_i64 dest, TCGv_ptr base,
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   }
>   
> @@ -3257,7 +3256,6 @@ static void store_element(TCGv_i64 val, TCGv_ptr base,
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   }
>   

