Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BBFCD3429
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 17:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJEXt-00062l-IA; Wed, 12 Nov 2025 12:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vJEWe-0005Ij-NS
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:21:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vJEWc-0007N9-1m
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 12:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762968051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMxVuvAqoApe1n3kwx4U0GfXYBdIm/dWnshoZeslIHg=;
 b=R5b6uVFWQYeR+nk0uOXuWZ1rlIXyAwvAt/L8Ygp6M1wdBQ2bkHugCqmuH+xT14iDghKNt/
 pcYGjxgXQpzu0YM1LlYTtsC7lAKuV2KXJO4/gXgM94wq8F5093g5lORaw3BV7p/kK+J3uW
 BxV8BxQbDCaFiHr/rtLFp8mOfWo4ZvM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Ljrxpz77Nme4d8N9rbo4DA-1; Wed, 12 Nov 2025 12:20:50 -0500
X-MC-Unique: Ljrxpz77Nme4d8N9rbo4DA-1
X-Mimecast-MFC-AGG-ID: Ljrxpz77Nme4d8N9rbo4DA_1762968049
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475c422fd70so7841395e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 09:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762968049; x=1763572849; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yMxVuvAqoApe1n3kwx4U0GfXYBdIm/dWnshoZeslIHg=;
 b=pc6zMCSjtDkkmMnTSAwwemTnTzgiJK57lmE3r4XI68ObP0mx2/OhOL9zBkJwrN746Z
 pIORG/Wi1Xv+ZV8vFgq/VsviFgdKMWSd3mxAJqDw3RSzcqfPmPlRabJhNuUG1YFSRMUx
 1D3nlwcu2ymzV+eYa+dsOuYNbVOMK0FGKCyvD0Qsnc9NcgUnIV/JsX+NPnfD8yEp8PxP
 wBjkDDILbdfjqf91e9N3pYcaDBx1rUujYvHBSJ1IP2LPPn40SDj1bHz5b6XfdMIW6kcd
 oir6e+g9MGe6BaDRrGUi5hdv+GzaxPJDlRAvVZGxSKz6fSYyTpGI/yw/NNKubTNeUkrD
 K9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762968049; x=1763572849;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yMxVuvAqoApe1n3kwx4U0GfXYBdIm/dWnshoZeslIHg=;
 b=vmWIJ9YPJHzFxqxMU7Xj8XqECYFuhkIzxAvSkyuVDcuGn3K8hdNvTK5rVr9OGF0Zlv
 rGemvb7TyhpLSxS5bzj8c8e9sSFUn49GplYAEfkAsi8ipom8eZD0+ufBvwvNQ2g0KhKD
 +EdbgC0rO9VB7fSVz8pLcw12G8/L3rPZyOF3wRkVszgxQcc/+k9gDCTdpOG6iI0fnT38
 HXPtTWBIX+pt2tFtVWO9RNoGfEY0TQ5M9kiSmZlm7+gy0VAHX6d4uQFcDrZVFY+B7mXu
 Qrj5B2QKZCzqcNKEeU1NBiIafr5/PWVuFlYMLFcALl3g7LNvCWM4S8GaOmcWuJv3GhtE
 EJKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJRttPJ56GAWEfin4gBN/2xZQqtULsXKW+9A0tFPIcRK95P1IYwWNjSkvSNAtq853AxHy+/opHi02x@nongnu.org
X-Gm-Message-State: AOJu0Ywk33+HhrWPvuUGr30cktaKs1tX1vGai9u9v3IjDTH8SE8fN4Af
 hxll4qPm0gadV8FmsIaatLv7+o4Nt3orTZLgNNjtxITkm3tylTLB0FIxMe85tYuiLPT9Mk3Ya+M
 K/8Mmn2FW/l3KSS0rcSPlpqgTDSa82cfu4Rg93T3hNM6/K4jMTTdotKSd
X-Gm-Gg: ASbGncueUXeTYmrrrwSmEe8fKKToB00qQKIf6WUb9K05ZZC+1wfn1mt+cecepz1UBEz
 kAxmWp0yFRXJ8VI/HiTPAyHxa9yuXKYAMdGQjfrxIFSdHn8zbYrGssz2qlWuYrhxbtBbTkHwUUo
 vaqQ54O4nAZD5vnJfmt759LjSWTBOlp/PCw0O5BIsEfC10VLz/O8boIbr1OmDlTYTda6F7KLXMe
 GWrp9wfQtpPispNGjoiiHQAc4o5ctI7AzAxLjrhDCPMbQQ/vV9AO/BN9KAdL7yN7zJgpvaJWrC0
 D42dtttUwoQonJzjsYuzAXPTSEgSkEnWMF7inNwZ0SQH/ycNA/AJO5JQyrMNjlJIk2XVtolUR1q
 IgEVy5kdq7HfxZqrUxuhScIx6wGNyY2xEkH7t+e7YNOioyocc
X-Received: by 2002:a05:600c:6305:b0:477:7a95:b971 with SMTP id
 5b1f17b1804b1-477870a99d9mr38482865e9.31.1762968049292; 
 Wed, 12 Nov 2025 09:20:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEegzjrPUmLH9up7bKJ2Gnf4SouhSesuQw86AewfqbDWeqLNOhar2BDeK/AVLyrimDmRdJciA==
X-Received: by 2002:a05:600c:6305:b0:477:7a95:b971 with SMTP id
 5b1f17b1804b1-477870a99d9mr38482625e9.31.1762968048885; 
 Wed, 12 Nov 2025 09:20:48 -0800 (PST)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e3a656sm46533675e9.2.2025.11.12.09.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 09:20:48 -0800 (PST)
Date: Wed, 12 Nov 2025 18:20:47 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] target/arm/kvm: add kvm-psci-version vcpu property
In-Reply-To: <0795ff4a-50d1-4b2d-84bf-e1bc9da11ba6@redhat.com>
Message-ID: <cff8ff25-f4a6-6b90-8b90-10b8da7972ac@redhat.com>
References: <20251030165905.73295-1-sebott@redhat.com>
 <20251030165905.73295-3-sebott@redhat.com>
 <0795ff4a-50d1-4b2d-84bf-e1bc9da11ba6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 11 Nov 2025, Eric Auger wrote:
> On 10/30/25 5:59 PM, Sebastian Ott wrote:
>> Provide a kvm specific vcpu property to override the default
>> (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
>> by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> ---
[...]
>> +static char *kvm_get_psci_version(Object *obj, Error **errp)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +    const struct psci_version *ver;
>> +
>> +    for (ver = psci_versions; ver->number != -1; ver++) {
>> +        if (ver->number == cpu->prop_psci_version)
> I still have the same question/comment as on v1. In case the end user
> does not override the psci version I think you want to return the
> default value, retrieved from KVM through KVM_REG_ARM_PSCI_VERSION and
> which populates cpu->psci_version. So to me you should use
> cpu->psci_version instead

Sry, I didn't get your question the first time and double checked that the
VM uses the default/most recent version when the property is not set.

I just found out how to actually call this function (via qom-get) and
you're right: the VM uses the correct version but we report something
different here - and in this version even trigger the assertion. Ouch.

[...]
>> @@ -1959,7 +2008,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>      if (cs->start_powered_off) {
>>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
>>      }
>> -    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
>> +    if (cpu->prop_psci_version != QEMU_PSCI_VERSION_0_1 &&
> I don't understand what this change stands for. Please document it
> through both a comment and a commit msg explanation

The explanation is in the cover letter - I'll move it to this patch.

Thanks,
Sebastian


