Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E33E9E31B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCHk-00033U-FV; Wed, 11 Feb 2026 10:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqCHj-00032r-1j
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqCHg-0000Vy-Gb
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770824263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0t2ls4USNVIXwkkL2q2g6u6o8wxKJkSwfzOXqzXvmPo=;
 b=ffGQCWvNQtGKImm9wsfCppiSQC6wT4qrnZsLz4kcFl0P8xogq3auFpLN0Y6j52EdTmLbrU
 Pnm7omW73Y8orORzbHllMia9tz8lWbKRjz4JecCFeXnxUUfdtkEu1RKFIKNZzGLzqdiZHd
 sSJjD2YauiX+J1y2+xQg8hDB0WzvhmQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-ihlhj1-RMF-CQg8TUF0fcQ-1; Wed, 11 Feb 2026 10:37:42 -0500
X-MC-Unique: ihlhj1-RMF-CQg8TUF0fcQ-1
X-Mimecast-MFC-AGG-ID: ihlhj1-RMF-CQg8TUF0fcQ_1770824261
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4803b4e3b9eso50347945e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770824260; x=1771429060; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0t2ls4USNVIXwkkL2q2g6u6o8wxKJkSwfzOXqzXvmPo=;
 b=U+96mb7FD8nni45r+MsKDZdg57fjbNRolPxfU3g8dsXLfEr8AYjCwbF50qySMzu1kA
 OdSr/o7aCU+KRHED5CNRX98gMxnpI+hwDOGmpHabvWWoJbrwctVph4+3BcKWHCh0n/RL
 p9vCQ/EKFsc9AfdPGwacUA0SvU3wHm8JNvnyrYQupISNvfuiBn+DedOfBpgxqKu/1hWW
 as+9w7UvFaplwZ5TfbbqG0WGGVyegY9h6M+XCF9xomSbo5g/sIEEsuOYwLwRDcinYtKJ
 zTrf6e+p148wNTbSHAwOzbuF4w5voirz3PGuJsQw46zFF5E3aPDsrP1vMjnxqKGrdtq7
 93Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770824260; x=1771429060;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0t2ls4USNVIXwkkL2q2g6u6o8wxKJkSwfzOXqzXvmPo=;
 b=DsfgNOeFQAOcxGrfogYTkEMmLHOIJFBF65BKeR7nncfz/bgUKK/EVbfQN5nO5KrTRk
 LizkhW1OTjHOzFukqDah1jZkpv9MarSTKqzZYdblPUtaryuOj6q4l9JZQ8BphPf52AzA
 me7l1sym3zyK60ljp50aeJCxmUdlSER/2MQhBEoPVBAXuD311VcpY/Vfd6iSyQtP0vSJ
 u6ZzP0+H83iHbfnrTRaUr/2FbEPlWXssKIIIHN2mwTz+6bDSQsuM+J4XSvSCYRKBjd9d
 cvtIIwL4bQx0ldxViIRk7Z8pjkVnoImmeiAiTJKV78ZD+sHBcdNO3tBnTB+3JGYYQsYN
 YB8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtOSQA3QrvHYICVWt0VfnvmnRCLYN0EeGDlK24ApBjhAUsT6zuxltQsxc3ufRDPYUirM4NnNYNTulR@nongnu.org
X-Gm-Message-State: AOJu0YzHT+TdSLt82BXREgOH7AsMCbBCy6lA3qVAScGkpFvjJl7xRhzG
 Je+bj8zxLhPylILvICiRgXH+H6lR6j55SJHmN2MnwavSP6zoGYduPwC11jtFDYBn3IPoBYYDkxH
 mRnt6fzxacEHSEnsA8B86KpFNcGUju4D1tOpbZ3rcQPqJu+faKB+6eL5rUwzB/TAg
X-Gm-Gg: AZuq6aLBu7ez7zNMrGeaQj2NY2iZiIyskNy2MR1y8decLyJ6omiDvluG4Seznqrx3mB
 OWZ4cxx8X63X7EnQkXQlQqwCdjS8s4xWAJPYj5LgOw2COlRbCiV1D/f4CkPpUcNY5rU57yUwQhK
 SyTjZ5TJPUlniPzHL4zqmdaJFneQxLOF/zpmBDZxJtrUpPsoZ93ojo6kwznd3IauVH30f1goHBH
 qrPAsfhYO5fvS44WljZ5Q8MTe+cn1g0KSff/7sIi/4wqWEZX2wkp3gbfDiPsIVN3CdWKnH6/pSk
 fUBkhlQURcDUyDnYD1Y90jIbg/jf0DpTKS3EK3HXptxYuIbjpF4r9Zo/swwUtxKY/LSJz1pZR6C
 lqH65bdqvz+kYzpmShgjaApTXD9AmeAjJ/RX2n2IVze4HZJTSmpfugHHuCusdlAw2Ny0D2SQ=
X-Received: by 2002:a05:600c:638f:b0:47f:1a8d:4f30 with SMTP id
 5b1f17b1804b1-4835b936b47mr41117105e9.26.1770824260589; 
 Wed, 11 Feb 2026 07:37:40 -0800 (PST)
X-Received: by 2002:a05:600c:638f:b0:47f:1a8d:4f30 with SMTP id
 5b1f17b1804b1-4835b936b47mr41116775e9.26.1770824260146; 
 Wed, 11 Feb 2026 07:37:40 -0800 (PST)
Received: from rh (p200300f6af2d8700b4c2d356c3fafe63.dip0.t-ipconnect.de.
 [2003:f6:af2d:8700:b4c2:d356:c3fa:fe63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4c4sm245868605e9.10.2026.02.11.07.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 07:37:39 -0800 (PST)
Date: Wed, 11 Feb 2026 16:37:38 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 2/2] target/arm/kvm: add kvm-psci-version vcpu property
In-Reply-To: <CAFEAcA8oi1Xs2kv66dFV9NZore+Q2vHUsgMikveVdN1c+3SBJQ@mail.gmail.com>
Message-ID: <9b04a20f-b708-208d-1e4e-466ec30b7bb9@redhat.com>
References: <20251202160853.22560-1-sebott@redhat.com>
 <20251202160853.22560-3-sebott@redhat.com>
 <CAFEAcA8oi1Xs2kv66dFV9NZore+Q2vHUsgMikveVdN1c+3SBJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Peter,

On Fri, 6 Feb 2026, Peter Maydell wrote:
> On Tue, 2 Dec 2025 at 16:09, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> Provide a kvm specific vcpu property to override the default
>> (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
>> by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>>
>> Note: in order to support PSCI v0.1 we need to drop vcpu
>> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  docs/system/arm/cpu-features.rst |  5 +++
>>  target/arm/cpu.h                 |  6 +++
>>  target/arm/kvm.c                 | 64 +++++++++++++++++++++++++++++++-
>>  3 files changed, 74 insertions(+), 1 deletion(-)
>
> Hi; this patch seems generally reasonable to me as a way to handle
> this kind of "control" register; for more discussion I wrote a
> longer email in reply to Eric's series handling other kinds of
> migration failure:
> https://lore.kernel.org/qemu-devel/CAFEAcA-gi42JObOjLuPudABX8WRdWf5SzSbkzU-bd06ecF1Vog@mail.gmail.com/T/#me03ebff8dbd8f58189cd98c3a21812781693277e
>
> Unless discussion in that thread reveals that we have so many of
> this kind of "control" knob that we would prefer a generic
> solution rather than per-knob user-friendly names and values,
> I'm OK with taking this patch without completely resolving the
> design discussion on that other series first.
>
> My review comments below are fairly minor, and patch 1 of
> this series has already been applied upstream now.

Thanks for your comments! I've addressed them all and sent out V5.


>> +static char *kvm_get_psci_version(Object *obj, Error **errp)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +    const struct psci_version *ver;
>> +
>> +    for (ver = psci_versions; ver->number != -1; ver++) {
[...]
>> +        if (ver->number == cpu->psci_version)
>> +            return g_strdup(ver->str);
>> +    }
>> +
>> +    return g_strdup_printf("Unknown PSCI-version: %x", cpu->psci_version);
>
> Is this ever possible?

Hm, not sure actually - what if there's a new kernel/qemu implementing
psci version 1.4 and then you migrate to a qemu that doesn't know about
1.4?

Thanks,
Sebastian


