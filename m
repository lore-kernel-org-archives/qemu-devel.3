Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE1AF357D9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 07:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv98O-00075B-08; Wed, 25 Feb 2026 02:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vv98H-000731-1T
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vv98F-0001tW-3s
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772003785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qL6dea3nPOVHlv2oBcUsVZrWZwNNBBgQt3IQvJSqORw=;
 b=DIAwKFh2+TwSIivX3cBrzUH3P3GaAXUsktB3uQYdkyDO9jam8nAPHtYJL+Z6LsS8r+GJEV
 yVYgXrtE2AjEqEt1BMXVJNXHELqzdjzb6CU32xCskiIUsDho9mqQilR4WanIjQFJBeYKAZ
 Teaq1GeRcyvNpPgydMxBWUOVgVafE3k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-JiuYDrITM0SMaf5y11b_rg-1; Wed, 25 Feb 2026 02:16:22 -0500
X-MC-Unique: JiuYDrITM0SMaf5y11b_rg-1
X-Mimecast-MFC-AGG-ID: JiuYDrITM0SMaf5y11b_rg_1772003782
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4398f665747so376108f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 23:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772003781; x=1772608581; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qL6dea3nPOVHlv2oBcUsVZrWZwNNBBgQt3IQvJSqORw=;
 b=IHT5DH9TP+bAh3tzDUm8busKPRpYWQ+Jd9oOM1GJGSsZbP23tx0vUkPhGgOKWgKcam
 URn21VvrGyQdZVSPkvPio5iI3ZGobR/xa1DaGtsKneBevAnDzGTN7TGyiSGV9EJwNgZs
 UZssQ1SrGbsC6OZyKVefLqtCI01i5WVk/ifSJ+JiWhk3sPnZM4C532gqHjSEdtb0L+S5
 vMPYG+5i7OblmgXHcOfJptxZfRIBLzpJxfGkfWYMkbiHP81j/LUF5x3uFo7rKy7TyVtz
 MtMjTfUw4BOIpYkGnfTrFxfO8pkI0bm7soJROcI+Fhcu4ZCnFHzLonoPgKeYoIwxF8Ev
 cc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772003781; x=1772608581;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qL6dea3nPOVHlv2oBcUsVZrWZwNNBBgQt3IQvJSqORw=;
 b=dVjR3+4jR1vt89m909plAKUsf/heusCyXvSZmr6V0vYBjexamMm5IqhbS+PmKBfA66
 aTvuKdR9TFBW04zpK8nzVlqOoo9VWo6qvXyNAwWpBp28B89DiK06+24flDpo84+UuTPa
 2Qmvs3ZFNMV1LPWkC7M22s+2TZ8lpu2UfOXqbTH6/WUfpSBSYFjsNZso5juHiDnvTVcg
 L4eoLhTqzlSgLHju2U2KfJR/z+sBn/GhRjJxl2ZeqNl3qbSFe+u4G/g3fvfCtUZNKwXF
 yeYGPbfdVNyiZYK51z3jd217ynjpcffFiAdSwMRcRaMsxj2c6VzAM/qltlh/HlhVdtIq
 JYKw==
X-Gm-Message-State: AOJu0YwWHiDc/kTiAvHxM0SbO/FQ/ObFrLbPXyPgI1bP8iMzmPcGAQWC
 BdFAFJI4uLZPq6NpEVbJCiZj5cVsRwj7mfTkOVkY4w8geR5w2K4RQhnEx6N/HyLKnteY+82WfKa
 jC2C48ZA6f9gJTY2QsbXhJLDzpMk/nZah7Al5TXkyMK2JNaTad8UaU+MY
X-Gm-Gg: ATEYQzwwRe0YmxTLEDVsz4SvucA3s0lROA2KEz/ject7GxWgKHefZs/e7Y3U9DlDvWI
 SVn5+03te/Ca0E7308EqnTRZCxN5ctH1xCgnLb5/BDKV2dBBkSCL4meEBs6yaCJ6NveBNDCOBYF
 kQ//cNU/h1SwbdIz+inze0dp8nymU+HPYfFNsdYUgT/LW+FD1PG326DqVzPSafuzPWWotg6CE6L
 RCQr9lFRtks5x4XR4Ky1i98mD6BKfATJNaYo7IIEx7m9gSIg8P25FvlRh3H72eL6uJxnBpWfn/l
 vkYnME94SusJipoVmH4BFJLU1Dl3zc/4FaiO7YtKGrQI6UMthRPas5G/nGlWD4Hg0st5JIDrgVQ
 lC6xYVLTz6ytvMso0cQzckUsRL7S2egtdXiSMitKWHk5msKoI+09K33Zj6BThEUi05bqYok8=
X-Received: by 2002:a05:600c:8708:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-483a963d62amr213324405e9.32.1772003781522; 
 Tue, 24 Feb 2026 23:16:21 -0800 (PST)
X-Received: by 2002:a05:600c:8708:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-483a963d62amr213324075e9.32.1772003781071; 
 Tue, 24 Feb 2026 23:16:21 -0800 (PST)
Received: from rh (p200300f6af25cc00b2a92b19386de96f.dip0.t-ipconnect.de.
 [2003:f6:af25:cc00:b2a9:2b19:386d:e96f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd732eb1sm50579945e9.12.2026.02.24.23.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 23:16:20 -0800 (PST)
Date: Wed, 25 Feb 2026 08:16:19 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, eric.auger@redhat.com, kvm@vger.kernel.org, 
 kvmarm@lists.linux.dev, pbonzini@redhat.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v6 1/1] target/arm/kvm: add kvm-psci-version vcpu property
In-Reply-To: <CAFEAcA8O2UEKToJ+zXA6=vvgkRyPKrPwtfHnti7yyGgCGwoJeA@mail.gmail.com>
Message-ID: <0616fe7f-96b8-251e-dc0f-9e15ec8298ba@redhat.com>
References: <20260220115656.4831-1-sebott@redhat.com>
 <20260220115656.4831-2-sebott@redhat.com>
 <CAFEAcA8O2UEKToJ+zXA6=vvgkRyPKrPwtfHnti7yyGgCGwoJeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On Tue, 24 Feb 2026, Peter Maydell wrote:

> On Fri, 20 Feb 2026 at 11:57, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> Provide a kvm specific vcpu property to override the default
>> (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
>> by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>>
>> Note: in order to support PSCI v0.1 we need to drop vcpu
>> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Tested-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> ---
>>  docs/system/arm/cpu-features.rst | 11 ++++++++
>>  target/arm/cpu.c                 |  8 +++++-
>>  target/arm/kvm.c                 | 48 ++++++++++++++++++++++++++++++--
>>  3 files changed, 64 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
>> index 3db1f19401..ce19ae6a04 100644
>> --- a/docs/system/arm/cpu-features.rst
>> +++ b/docs/system/arm/cpu-features.rst
>> @@ -204,6 +204,17 @@ the list of KVM VCPU features and their descriptions.
>>    the guest scheduler behavior and/or be exposed to the guest
>>    userspace.
>>
>> +``kvm-psci-version``
>> +  Set the Power State Coordination Interface (PSCI) firmware ABI version
>> +  that KVM provides to the guest. By default KVM will use the newest
>> +  version that it knows about (which is PSCI v1.3 in Linux v6.13).
>> +
>> +  You only need to set this if you want to be able to migrate this
>> +  VM to a host machine running an older kernel that does not
>> +  recognize the PSCI version that this host's kernel defaults to.
>> +
>> +  Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3.
>> +
>>  TCG VCPU Features
>>  =================
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 10f8280eef..60f391651d 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1144,7 +1144,13 @@ static void arm_cpu_initfn(Object *obj)
>>       * picky DTB consumer will also provide a helpful error message.
>>       */
>>      cpu->dtb_compatible = "qemu,unknown";
>> -    cpu->psci_version = QEMU_PSCI_VERSION_0_1; /* By default assume PSCI v0.1 */
>> +    if (!kvm_enabled()) {
>> +        /* By default KVM will use the newest PSCI version that it knows about.
>> +         * This can be changed using the kvm-psci-version property.
>> +         * For others assume PSCI v0.1 by default.
>> +         */
>> +        cpu->psci_version = QEMU_PSCI_VERSION_0_1;
>> +    }
>>      cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
>>
>>      if (tcg_enabled() || hvf_enabled()) {
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index ded582e0da..5453460965 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -485,6 +485,28 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>>      ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>>  }
>>
>> +static char *kvm_get_psci_version(Object *obj, Error **errp)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +
>> +    return g_strdup_printf("%d.%d",
>> +                           (int) PSCI_VERSION_MAJOR(cpu->psci_version),
>> +                           (int) PSCI_VERSION_MINOR(cpu->psci_version));
>> +}
>> +
>> +static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +    uint16_t maj, min;
>> +
>> +    if (sscanf(value, "%hd.%hd", &maj, &min) != 2) {
>
> %hd is a signed value, so this will accept "-3.-5" I think ?
> Probably we want %hu.

Ugh, right.

> (If you agree I can just make this fix locally, no need for you to respin.)

That'd be great, Thanks!

Sebastian


