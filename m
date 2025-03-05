Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705FFC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tppq7-00010S-Sp; Wed, 05 Mar 2025 09:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flavra@baylibre.com>)
 id 1tpn8Z-00054v-5r
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:42:07 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flavra@baylibre.com>)
 id 1tpn8X-0000up-3f
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:42:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bcfa6c57fso7648515e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 03:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741174921; x=1741779721;
 darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:organization
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7qoMFHP18t1+aynNKa+ZBE66AWj0AVEE7ajzAxyRuQk=;
 b=bnNV/IK+qnIH6ZItNoz5KCQ7Ge1YvnlHPGhGakKp6PbhGTBqu6+qViW34V835KCcpj
 jmT5xaiB/CgwGjpA2hgsgjU2GUOuBtrQqEISl6bd2isk4Hhdqa3ZLJ8xn3uXGRK0OjTL
 YuVId8lnEZHCB3gIDkFKkbbz+GDql8boJcD8k9j6BlzDlz9UavIEybgQBWyqwHVuCkuh
 ZTp0O50maACkqtl8l2+s669b2kHNmaCoRd9xSu42PO9eHJL4AHsdTm+eFk0j3xCRo2qZ
 Qf9hYRy2DOQxeqsa2/bhnBZgKMPf5+YpWrmmuagK4AYehgQSvXibAPOMRcjafp/k0Oh0
 4Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741174921; x=1741779721;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7qoMFHP18t1+aynNKa+ZBE66AWj0AVEE7ajzAxyRuQk=;
 b=DV4J0r3jr/flpf6OBhJ/5deBW7knbvczidEXDRzQWzmqeIyQouvEWHucoag8wAO4Rn
 KRs2ssAtae4+BYnx3vK6+SWjAJyJAl66QggTBaT+68uu4tGyvycgpl93Ps+aTeabtybn
 h2zz5V1SDmyVFJHD45SYY+LXAJA02lbNxTMR7KI6TYliCLL4S+8ZCT9qhyrmFWBtZ7lE
 T+KPViTU5IjJZZd4GarAQEECZ49Lmyfx21bYsosRsFk3S1XIm50AUP+9kiKNORkeCd0Z
 1RV1GzTR5M9arDADFukNnCvHMkT2rRZAE2f/PFYfjDoAXdNtSjzVw/3Ev2PSIS353ns4
 dtOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEbLFhKzRaqD+MstfhsAPPMVA1QjYYydN+ZbgtRVXUnwJmZ0mQRYqruDO6aX2wkPaaryZ/R3yNAGia@nongnu.org
X-Gm-Message-State: AOJu0YwvV40ACynFvKiQcinkjbSktH8hqsoIuPdheTSB5z99KBO3JoJc
 3hOKcnzA8sGrqHk3UAR1/txVt84tOZIg3K+8xNZvgvFD53glm4x2i1Va+QnzBIU=
X-Gm-Gg: ASbGncutfG3eVN1+LIgFusDxOsHU6Bq0j9qksxlV14Si98iUdQ+4iBjPkvWGjI1s98I
 fW5rzwOlby4YsYteYYGRrjXvqHhRAJgAZ4LQRYZEayMb7vumG9/kSQaYIlDLXKZTNNAJGyW4wGf
 H20At2JFZww8lUvka4qm/Bf2Iq4FdRpWcgwE8oExPE9OTTILgd2DZYmI9siDsUL+dV8jl9kgyXZ
 5hvV7B0wutrOaSo/kyzrZefPO/qlVZ52rBjnADPywHGoSz0FRZozOzfH1+7OYayMFIYFbQiapH/
 eakgdXBG63HVp1DMikLYsEDqGzXKGyeK+EPsABnisT1qVmsdO6qRUj08T99mdolBjSlNZmmgKU+
 6PjxOxtheqZ1ThVU=
X-Google-Smtp-Source: AGHT+IHwLYR3lnUxszBmLur7bdGwk3/lJLpgLsJrp2K853h/x9C1br2a7PT9mDMKqILEqmvul7BYyg==
X-Received: by 2002:a05:600c:4f86:b0:439:96b2:e8f with SMTP id
 5b1f17b1804b1-43bd29d040dmr17232515e9.28.1741174921322; 
 Wed, 05 Mar 2025 03:42:01 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:252a:6e70:c18a:67bc?
 ([2001:b07:5d29:f42d:252a:6e70:c18a:67bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcbcc0c39sm38145415e9.0.2025.03.05.03.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 03:42:01 -0800 (PST)
Message-ID: <7d6f5d9ce0f23a550aa95bba9bb04425a7a5b9ec.camel@baylibre.com>
Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers
 during VM reset
From: Francesco Lavra <flavra@baylibre.com>
To: dongli.zhang@oracle.com
Cc: alexander.ivanov@virtuozzo.com, babu.moger@amd.com, 
 dapeng1.mi@linux.intel.com, davydov-max@yandex-team.ru, den@virtuozzo.com, 
 groug@kaod.org, joe.jin@oracle.com, khorenko@virtuozzo.com,
 kvm@vger.kernel.org,  like.xu.linux@gmail.com, likexu@tencent.com,
 mtosatti@redhat.com,  pbonzini@redhat.com, qemu-devel@nongnu.org,
 sandipan.das@amd.com,  xiaoyao.li@intel.com, zhao1.liu@intel.com,
 zhenyuw@linux.intel.com
Date: Wed, 05 Mar 2025 12:41:59 +0100
In-Reply-To: <20250302220112.17653-9-dongli.zhang@oracle.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=flavra@baylibre.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Mar 2025 09:35:12 -0500
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

On 2025-03-02 at 22:00, Dongli Zhang wrote:
> +static bool is_same_vendor(CPUX86State *env)
> +{
> +    static uint32_t host_cpuid_vendor1;
> +    static uint32_t host_cpuid_vendor2;
> +    static uint32_t host_cpuid_vendor3;

What's the purpose of making these variables static?

> +    host_cpuid(0x0, 0, NULL, &host_cpuid_vendor1,
> &host_cpuid_vendor3,
> +               &host_cpuid_vendor2);
> +
> +    return env->cpuid_vendor1 =3D=3D host_cpuid_vendor1 &&
> +           env->cpuid_vendor2 =3D=3D host_cpuid_vendor2 &&
> +           env->cpuid_vendor3 =3D=3D host_cpuid_vendor3;
> +}
> +
> +static void kvm_init_pmu_info(CPUState *cs)
> +{
> +    X86CPU *cpu =3D X86_CPU(cs);
> +    CPUX86State *env =3D &cpu->env;
> +
> +    /*
> +     * The PMU virtualization is disabled by kvm.enable_pmu=3DN.
> +     */
> +    if (kvm_pmu_disabled) {
> +        return;
> +    }
> +
> +    /*
> +     * It is not supported to virtualize AMD PMU registers on Intel
> +     * processors, nor to virtualize Intel PMU registers on AMD
> processors.
> +     */
> +    if (!is_same_vendor(env)) {
> +        return;
> +    }
> +
> +    /*
> +     * If KVM_CAP_PMU_CAPABILITY is not supported, there is no way
> to
> +     * disable the AMD pmu virtualization.

s/pmu/PMU/

