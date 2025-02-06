Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF71EC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyPU-0005aI-1i; Thu, 06 Feb 2025 04:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfyPR-0005a6-B9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:42:57 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfyPO-00025T-H9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:42:56 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38db3a3cf1cso270026f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738834972; x=1739439772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CCnPKoirm1TSgXa3aRLOwDR65B06aXsySVkxKtLtNgI=;
 b=nZi+nhNnp5Mk7rKeGwiJrQ58Ie645dswa4b838cPt0uDJzDNd9YlAO+fH2EtTCuURd
 YDVZtPYVDceumlkLiy8E856RSgHICQGXbCvE2IH0Aw1IdFxy26XaMUeUOyrKQtyXd03X
 zap4xv3ex5R6OXM86rP/KRVXTvR6nNOrk8sLxNXvcU5jMrQw8G4BO/3+SPAk0K3i39/f
 Yx2nMB0BbF5E/ssXK4R0IFUHjUCx1dwqbSUOHxLetZNj6fQ4fZETjQUt5QjKtwxEN5Fu
 2LlBRVi3jwzTkcUZ1fwKJN2Q9g/Xv6PV7vesIIUpUM4aA81a4LMv7Uflga6wkGJWjiXu
 bqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738834972; x=1739439772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CCnPKoirm1TSgXa3aRLOwDR65B06aXsySVkxKtLtNgI=;
 b=tbkXYq7IrmCmICUR3veqR0ibuEPFHSi3Wp93PyxFmttBWpsMRERU7y2R2TZ5ycRvqt
 3+AJg6PfcMu5FXZ94j5MMi+cGI5RTGAQGo8cvDxbBoUQWtY6zaye0i6ysQhSbbkj2KPO
 T5z1gMIZMNPG8F9XyJvDvlVkjzNpr06h2A4ulAbWtfzL7lyR3mXno8B1G2LTgfy8zUyx
 EwON5kekJDe9Eq6wffdlKyQzZOR8IF+BWSRnl3rJNG8zSf/W7z3gUjZR2LnaoL+DJ2q5
 dPcJoIFA0kTSUc4lY9Fjav/dl9kZsS0RB257tZnY43CgywctrMpDcoKlF8qmcifCOS75
 +TMw==
X-Gm-Message-State: AOJu0YyIqMli/iSx8I+V6KDkYYvkfjZd2mh9kFaAANLFOsuZK624i64A
 abT+QFPWpoc3efwwYOpiAK7Zma/AD4XtwWFg1mz3IzFgz4ZOc1BEMPMZNZBrpSg=
X-Gm-Gg: ASbGncuOYX9VAhOUr02hIWrSbnAuoQs3F55ii3ZXpaqe5u0zkFUE7lDsuKuyAvbQEO0
 SpMsMjy9oG+QR66O6v3/nB3Qcz7MBQu5is+mSgrrs8GDgLIfczToRvvp9WVWjPFOip6oYTBs9Ct
 es42reVg5eVTbPDsrItCDuHmUBztwsUMcjTaF/DrI0ReTy65ygBnjIe49H3De+P95X2EHDaGG+L
 8KRTj2ocNGcTV1PNMSQL3JZH03Tg6AtKIEIi96DdH/wmT9+XU29kn9XCeKTz6ywQv0wEQPC1Aww
 jqyWx4y7uq3+oI9qi6iMfTTbQQD8ZFM0KgbFurHYr2MymPlg0wyO5i5ZLao=
X-Google-Smtp-Source: AGHT+IGtFmjOQMG8Z2at6sipDcZ2CAydar5VWnIhNv1yp3/esDkSfwJNJfkhZjutC0AyHcluoSHTwg==
X-Received: by 2002:a5d:47c1:0:b0:38d:b325:471f with SMTP id
 ffacd0b85a97d-38db48bcaccmr4357212f8f.15.1738834972558; 
 Thu, 06 Feb 2025 01:42:52 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1dc1dsm1220023f8f.87.2025.02.06.01.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:42:52 -0800 (PST)
Message-ID: <adfe1b26-7e5a-4ced-92c4-9d396953f197@linaro.org>
Date: Thu, 6 Feb 2025 10:42:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND 1/5] hw/core/machine: Reject thread level cache
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20250110145115.1574345-1-zhao1.liu@intel.com>
 <20250110145115.1574345-2-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110145115.1574345-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 10/1/25 15:51, Zhao Liu wrote:
> Currently, neither i386 nor ARM have real hardware support for per-
> thread cache, and there is no clear demand for this specific cache
> topology.
> 
> Additionally, since ARM even can't support this special cache topology
> in device tree, it is unnecessary to support it at this moment, even
> though per-thread cache might have potential scheduling benefits for
> VMs without CPU affinity.
> 
> Therefore, disable thread-level cache topology in the general machine
> part. At present, i386 has not enabled SMP cache, so disabling the
> thread parameter does not pose compatibility issues.
> 
> In the future, if there is a clear demand for this feature, the correct
> approach would be to add a new control field in MachineClass.smp_props
> and enable it only for the machines that require it.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since Patch v6:
>   * New commit to reject "thread" parameter when parse smp-cache.
> ---
>   hw/core/machine-smp.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


