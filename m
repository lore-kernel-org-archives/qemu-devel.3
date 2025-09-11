Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DABCAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjhj-00009Z-0G; Thu, 11 Sep 2025 11:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwjhf-00008z-FC
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwjhd-0005AQ-Li
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757606355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5Gl87lWcfunzoYrVE0pRSftB8AHiSUHljE7szKd1ws=;
 b=SOF8lDfVrWfTTzp53yPRKXlLjiRp2VBx6MftptPIP10BBq+fVnLRnwBOJccXerkkAzcDVS
 xjiMafgQH8qrN8B2Juno38aUtIA+WksjXklsdEsqqxo+vjXm+ZTP4/2f17DBHlJDsvyQYl
 ltpoadxoOgaIXrLUQB4EfYgL6jk3F4U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-Kqgor0ZJPMasBYGAa3FS9A-1; Thu, 11 Sep 2025 11:59:13 -0400
X-MC-Unique: Kqgor0ZJPMasBYGAa3FS9A-1
X-Mimecast-MFC-AGG-ID: Kqgor0ZJPMasBYGAa3FS9A_1757606353
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e40057d90aso362960f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 08:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757606353; x=1758211153;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m5Gl87lWcfunzoYrVE0pRSftB8AHiSUHljE7szKd1ws=;
 b=xKH1b2xAQLScFvj4tCuqXefY3VOshsCvHk2A7eg6i6kXIruybBSzUzJmfT+pO0ndMi
 1Hw9ldNolNNKauJkG2bcsbNhlQDSSEYiDvnlJqvwy9iAAmp+uPgzSoW5v3EIyfpm3pg3
 GMPi8N86OHJ866epROWKVbpP8UtfrvVK+OMXI7Vy2VmhCGKH3/WnRKxvbb6ZgEPYImDu
 aCNv19wMdTtLy4+enN675dx3zLA/A3Kd+2Q+raMVAIAhnbrdd0qfxmZWJXUl7n777jM0
 eVchYSOTlqR5AEaaKMAvsk7qVSy5AHnkY6dbayZn+78DwlyogxXmWV8b1uPhUq5LLQD3
 w/vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm6Zg95i2TNpXmPybTwMiyOLjc5WsxLwxpYRDZNjdE+5NpiT9F7u4xmigY3LVAuWhWLPqz1iuEfRKH@nongnu.org
X-Gm-Message-State: AOJu0Yxn5vT9XIziL9FtLTgzs+Flu+vaMXSAsk0SGp48artmCxAc+nGW
 TSOAV2wgYfiA9nXzIMtNCktqZf8C583kDZsbRbCGUyWdDNWPsD2WsuSJ2yODtZiY1qiHvKx/k3Y
 UtgkBflUrmYECpcPxbZ38Gn3EWTAnfUmmZWYvEPynRNblyOyDaILcCgi9
X-Gm-Gg: ASbGncu0XhnZfsz8RFAeukN31Degw+R6DuhLpAJ02Doa37KGsiZmX+r0RGt6FKpOVAJ
 HcmTY/9Lbm6g9nzOh+2C2gtAC8yRdP0QsY+F7VLDJCDCaixr3BFcPP39A8XmdAiqVfj1dldDK0T
 oAKqViwmuddmYQ0353FZy12RE9NIvSdxCAzikMUXEC6+2FHmk7Le6ikqLxHXa2Cjp+b4dw/pSq+
 J2feGnA2GXBSXw64+tAuuisYqZJk6u/Te5AaE4kNdBH5/ZtkrIqSqZ7pucrvv0pyasiBC8Tzn1u
 hW1hbHfFr36DjSIAqYBEjIijYwu573fRNxSFb0YrCUZX76WAepQqiI3aIOfBKCOYkX5bh/02YGq
 30tYMI9C8C2rpQQ==
X-Received: by 2002:a05:6000:2c0c:b0:3e7:468e:9327 with SMTP id
 ffacd0b85a97d-3e7468e96a8mr14020611f8f.2.1757606352719; 
 Thu, 11 Sep 2025 08:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSrB5/to6QW2nPvAuUd/WlR4t/Ppb/lRN0E5cuL+7TESs6xG+MxArSdkCRJmxRGYUa2+tbqA==
X-Received: by 2002:a05:6000:2c0c:b0:3e7:468e:9327 with SMTP id
 ffacd0b85a97d-3e7468e96a8mr14020593f8f.2.1757606352333; 
 Thu, 11 Sep 2025 08:59:12 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e01865ff7sm16651975e9.2.2025.09.11.08.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 08:59:11 -0700 (PDT)
Date: Thu, 11 Sep 2025 17:59:10 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 0/2] arm: add kvm-psci-version vcpu property
In-Reply-To: <CAFEAcA8EDJT1+ayyWNsfdOvNoGzczzWV-JSyiP1c1jbxmcBshQ@mail.gmail.com>
Message-ID: <8bca09f1-48fe-0868-f82f-cdb0362699e1@redhat.com>
References: <20250911144923.24259-1-sebott@redhat.com>
 <CAFEAcA8EDJT1+ayyWNsfdOvNoGzczzWV-JSyiP1c1jbxmcBshQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 11 Sep 2025, Peter Maydell wrote:
> On Thu, 11 Sept 2025 at 15:49, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> This series adds a vcpu knob to request a specific PSCI version
>> from KVM via the KVM_REG_ARM_PSCI_VERSION FW register.
>>
>> Note: in order to support PSCI v0.1 we need to drop vcpu
>> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>> Alternatively we could limit support to versions >=0.2 .
>>
>> Sebastian Ott (2):
>>   target/arm/kvm: add constants for new PSCI versions
>>   target/arm/kvm: add kvm-psci-version vcpu property
>
> Could we have some rationale, please? What's the use case
> where you might need to specify a particular PSCI version?

The use case is migrating between different host kernel versions.
Per default the kernel reports the latest PSCI version in the
KVM_REG_ARM_PSCI_VERSION register (for KVM_CAP_ARM_PSCI_0_2) -
when that differs between source and target a migration will fail.

This property allows to request a PSCI version that is supported by
both sides. Specifically I want to support migration between host
kernels with and without the following Linux commit:
 	8be82d536a9f KVM: arm64: Add support for PSCI v1.2 and v1.3

Regards,
Sebastian


