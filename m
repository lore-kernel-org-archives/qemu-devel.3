Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32019EE021A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 08:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soItQ-0005GO-HW; Wed, 11 Sep 2024 04:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soItP-0005FF-Gk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 04:40:03 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soItN-0000KB-Il
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 04:40:03 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so5896061a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726044000; x=1726648800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JyV9LJm2Vf4wGO7Hd4ArlaMIqvRcHyLUasi+8n7+pY=;
 b=mSTH4EcqqL9CEdHbn1hx+IY7dMd07p6SQ67XzkuRTb3wOEIOU7/DYtGFA1hd/NnvTl
 V24LUH400XtCu5qlONQyrgZgEDI0uB+LftmxjZTOSFewzMRt7UbJUhEARB3jK0+Hlup2
 zVwwet5JtaXHdrHpIIuVnGaCul92+2Y8uM7yNwB3I52HmvX1ec5FIh8l77hdAkVhaSL4
 cQLsKf49LLotEwUHtcT6tJ6xFAof+9iL5n939G8EjGWaFqAzMWWBzmYBPs2r6+L7qrYb
 RIGQTIsxB79VWw7DyjckZauinSAhSCrrhGjIUUrSwdVYXSCLLZTR5RvcPQpgWgAvxWMa
 Lx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726044000; x=1726648800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JyV9LJm2Vf4wGO7Hd4ArlaMIqvRcHyLUasi+8n7+pY=;
 b=wvUZYyVViiAHM4bYWElubGl6tbWsLy6OrieNkgKiz4RbaaEmoifR/XW9zHhfJLfwj3
 rs3O5vpI9Kob1D15ZyZqUT0TqlGbSfxeOfj2u4DBcHgIJiIO9BeC4idY0EQ0WwX+flDe
 jpTtyJ6BNUFlyWBGBtzPoD5/9c/P2qD+Rqk+tUsHshdMQkjq0Z6kG5JlMRyWYXM9RieN
 jrd4+ShM6BrMcevZGKZ47wLj3uDZL4fcQ3ezxbmLrNr8uOmtDO9NeTp9RqyYtGNhktr7
 h9AcYDhzCoqsW4cpLWSEmswCrQxGdGBQXPEseYR81x4GBTkZOseGCz47gBDrxONPPhXI
 80DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0y7pdgG8Z51nFK2GGhHOoEDGE4CugT1FTMi4or9n9sPaxCP34jCmTpI7Uw4mW8wpx8KCk0F/VqmOq@nongnu.org
X-Gm-Message-State: AOJu0Yz3a2e+O68/2BTojafC6S8+0QKNc1m8HUjm0AoyBDef/W1mkEF7
 2omtdCK6lQCIYQPqHv+9OY7iF0ndkHFB0sub96ZRc77Rn8e5tDJb/ov3NemT1/E=
X-Google-Smtp-Source: AGHT+IEuEoUthM2OYCPbsPo/4/wEMjrSZwhG3gfLOvWlGcTJuhGUXemtOiCS/nVKmGgtKqBxFEkheQ==
X-Received: by 2002:a05:6402:26c9:b0:5c2:439d:2042 with SMTP id
 4fb4d7f45d1cf-5c3dc78034amr12338656a12.5.1726043999447; 
 Wed, 11 Sep 2024 01:39:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd52099sm5139643a12.48.2024.09.11.01.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 01:39:58 -0700 (PDT)
Message-ID: <cd6c5970-9a1c-4d58-b8af-483909c3c0ca@linaro.org>
Date: Wed, 11 Sep 2024 10:39:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/39] Use g_assert_not_reached instead of
 (g_)assert(0,false)
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
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 11/9/24 00:15, Pierrick Bouvier wrote:

> Pierrick Bouvier (39):
>    docs/spin: replace assert(0) with g_assert_not_reached()
>    hw/acpi: replace assert(0) with g_assert_not_reached()
>    hw/arm: replace assert(0) with g_assert_not_reached()
>    hw/char: replace assert(0) with g_assert_not_reached()
>    hw/core: replace assert(0) with g_assert_not_reached()
>    hw/net: replace assert(0) with g_assert_not_reached()
>    hw/watchdog: replace assert(0) with g_assert_not_reached()
>    migration: replace assert(0) with g_assert_not_reached()
>    qobject: replace assert(0) with g_assert_not_reached()
>    system: replace assert(0) with g_assert_not_reached()
>    target/ppc: replace assert(0) with g_assert_not_reached()
>    tests/qtest: replace assert(0) with g_assert_not_reached()
>    tests/unit: replace assert(0) with g_assert_not_reached()
>    include/hw/s390x: replace assert(false) with g_assert_not_reached()
>    block: replace assert(false) with g_assert_not_reached()
>    hw/hyperv: replace assert(false) with g_assert_not_reached()
>    hw/net: replace assert(false) with g_assert_not_reached()
>    hw/nvme: replace assert(false) with g_assert_not_reached()
>    hw/pci: replace assert(false) with g_assert_not_reached()
>    hw/ppc: replace assert(false) with g_assert_not_reached()
>    migration: replace assert(false) with g_assert_not_reached()
>    target/i386/kvm: replace assert(false) with g_assert_not_reached()
>    tests/qtest: replace assert(false) with g_assert_not_reached()
>    accel/tcg: remove break after g_assert_not_reached()
>    block: remove break after g_assert_not_reached()
>    hw/acpi: remove break after g_assert_not_reached()
>    hw/gpio: remove break after g_assert_not_reached()
>    hw/misc: remove break after g_assert_not_reached()
>    hw/net: remove break after g_assert_not_reached()
>    hw/pci-host: remove break after g_assert_not_reached()
>    hw/scsi: remove break after g_assert_not_reached()
>    hw/tpm: remove break after g_assert_not_reached()
>    target/arm: remove break after g_assert_not_reached()
>    target/riscv: remove break after g_assert_not_reached()
>    tests/qtest: remove break after g_assert_not_reached()
>    ui: remove break after g_assert_not_reached()
>    fpu: remove break after g_assert_not_reached()
>    tcg/loongarch64: remove break after g_assert_not_reached()
>    scripts/checkpatch.pl: emit error when using assert(false)

I'm queuing reviewed patches 4,5,7,10,27,28,30,36 so you don't
have to carry them in v2.

Regards,

Phil.

