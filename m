Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14DCC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj1B6-0006r8-T2; Mon, 04 Aug 2025 15:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1AF-0005Po-0P
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:48:07 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj1AD-0008H2-7t
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 15:48:06 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76bd041c431so3913915b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754336883; x=1754941683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AGIUz6Tii6hnJeIHzpD2Q3N4Unalnab5R3xHGIIwKkk=;
 b=tSk+u7att7F+NSPjxxNsq2R4UP6CwR1epzgYH4JQkt7o249VZ1gkl/KBejz6PgDM27
 yEk3SaG9lGfssuFB6EiZqoQpzwWgdfL2LuaTvTZNWfaSkwM/Zkh2Ax73ZaPAPrrc2FQ7
 ADECquhgEw4u41ipruJdAcOVFfSr0rYy+D7A3I0HUUNVHWOFmxQN0p+XH6HIExU5sC/H
 7PMX8fCwiK3JxkfKQspweXaZuVGx25gvIkSR8Si41H1Rm5VSvF+9kQDHXgb8JqK4TXCq
 fKhk/JcQcFgK/cGNEwLvXvLAlO7r5flFaZs6LuBsg6fb7eW5qZCePoenekCFe+r1ujel
 ciuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754336883; x=1754941683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGIUz6Tii6hnJeIHzpD2Q3N4Unalnab5R3xHGIIwKkk=;
 b=FQtH6j1N/fhFYnxD5E8hScufABoIi5R6RPeaXnDFxiU+kF44m6b3F7Nytuav9O6gOH
 N/ODnKCBI048ahXS+YT2up9V86LDDQ3ZvV6vwRIP50nBRAwOl9eIhxuKNQeKcbsJLkqy
 H8OMCgJEPm74G+EHCY8jahMOwukIyIe+VUZUgsIbfGDBgDWIyWwFTKpcFbZAw4Y9HFfn
 ++jDprfil1kJpm+CPxAS6oAhgc/WXIo84EoVOkl1Pub4CppJclk3lUiOC5QXmVZLR/s7
 q28cW51QS9l5/Nx7Yd88rem48jD3FYlRZSdp6uZu/0+nUrvdcPMi41IJAh40j9Lljzza
 cb7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYJnhp8e9Vd/nTmu4tR/grRl9t3Ilro3e0KghlX4VxD/ddz56ZPgncozOAWoJKsCZdxbEazOKMiGfL@nongnu.org
X-Gm-Message-State: AOJu0YzAFWgeDB5KjP6A+/Hi4xz3FT+r8w/XkAbgcQhzlJbs2GSJfiGw
 V1LyDbR/SzJh/mZkTVFUUK3Tt+ztsucNFlzSXVfwfOcAh9o4/aYfip+tu84aCGc5t0w=
X-Gm-Gg: ASbGncu3Iu4xFQBxs+8pRcxAjpMAV5IGdZbPcKQ3l9q0oFk5nJ7vSe0Xzmdp5/S/Pk1
 vqZ5EaNN188fK+1y9B+ITpdzsP+7o9GvYtnWCy8QCWFLH4MSiDFkADwiXcDaanMURwhwSks+bed
 fJu9lMqVKn0I7f1QTf6/Qnhlt9xDHxlDLaXdPSwaa+2IYuqX599+Ktv0o9kjpMH6A9SQ6k+YfA/
 nRnLxdEAOtr78VkQVM80/Kt5tEektKpI1iCiEHCmepAXt7JrlfbzPZ6tp3vamv2Ub41RPRkF5Zi
 VD8PAwvKgIi3A8ZWm2Hu6k07jYRwhn60yhLfyqT+NSEqt8nhyYVM/wP0dxQ41hA1e49Nc7poFK6
 cqHqpMhE87R8GcUO8btt6cx80VjA4A1R4gWJgrdN+Z3iLsQ==
X-Google-Smtp-Source: AGHT+IFyuUa1LmariXnn8L0egHLM02/sN1daOvKOjJCkId8o4El17GqyPitTZypUWqaSRS+b7r2lBQ==
X-Received: by 2002:a05:6a20:6a14:b0:233:d85e:a698 with SMTP id
 adf61e73a8af0-23df90fabe0mr15725788637.32.1754336883617; 
 Mon, 04 Aug 2025 12:48:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bfaf78c94sm4566355b3a.19.2025.08.04.12.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 12:48:03 -0700 (PDT)
Message-ID: <bf0b1b6b-99c7-4072-a7e0-023fca2c87b2@linaro.org>
Date: Mon, 4 Aug 2025 12:48:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/17] hw, target, accel: whpx: change apic_in_platform
 to kernel_irqchip
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-8-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-8-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> Change terminology to match the KVM one, as APIC is x86-specific.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/whpx/whpx-accel-ops.c    |  2 +-
>   accel/whpx/whpx-common.c       |  4 ++--
>   hw/i386/x86-cpu.c              |  4 ++--
>   include/system/whpx-internal.h |  2 +-
>   include/system/whpx.h          |  4 ++--
>   target/i386/cpu-apic.c         |  2 +-
>   target/i386/whpx/whpx-all.c    | 14 +++++++-------
>   7 files changed, 16 insertions(+), 16 deletions(-)

Looks good to unify terminologies.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


