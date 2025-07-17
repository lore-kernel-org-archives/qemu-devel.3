Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFCCC83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLM4-0003oM-0i; Thu, 17 Jul 2025 05:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucLCJ-0004Rj-EL
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:46:41 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucLCH-0003MN-Jd
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:46:39 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e8d70c65ad5so229399276.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752745596; x=1753350396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8CioygTmfycSr8QAYzyE0OTziroi6lit3MpcoLG0JVQ=;
 b=WMHPnWJF5ECR+4xNz4GPRAWhCHt1knE540humzK6yhNFZg0veUwZs10oQcCoQGrpb7
 jh/C2MFehVJNkfd1DPBeCJzfpojpKceW1H89f3tMQG8czoHWu8QxOo/JiNTaB+KRkd7N
 qvd+Vx4825JxdRHJEunurNHs2+tDdgfS8StUuVsc6QJIbrbcg4PehqfHTUqerpSfWZO/
 EbMQVHFllBf5YG2SZ08+E0QW4WL78U0u+ODPd8H4Vklp4q2seszHOVN5uMXRKcaWda4D
 8P1NloZUkUWX4BhbbxJ9tBg84gQwjmRG/gtjFLgqoPVvwPpaEnU4F1tSjBjCMcSmUHnp
 Dxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752745596; x=1753350396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8CioygTmfycSr8QAYzyE0OTziroi6lit3MpcoLG0JVQ=;
 b=VrDhcNmFVeBup1GWT+1wjx74VNNhlVHGhvL1XE9jHgU4Cs7nbVUgefxwyWSJDo1vDu
 Ih1/yzr5dCLlPk+OBX4fen/v8gMdwyJYXxpFi9L9cVTdR7ZaKuhrXGQD0YllVUewMnRa
 uqHxRfJbWc7EgHHZX+gHXWBbkNNFcvIr6MShrgdcnhPl3qusZdESOxu1z/gh3myXiXL5
 Q604X/18H6/hD8k++rOg6tXDeCPumZQbuVD1Uu8tqT8KgvS9E+MOrGib/uW7JMOYJkNE
 XIvDxiS0UrgBi5tLGK0x2m5GxG17O88BtP0YZAUbgOcqdyWlsJgJpVJ3RZE9CqJqljUb
 SIIw==
X-Gm-Message-State: AOJu0YwH442TxdmAuI3dHmYtYyZE3y+5TYjUkD25jBI16b3n52h1BZDR
 ZqJWNPGXu2ufECkb0PUZjogra/VKVylyIQCByJY8/QFjaFgplDF2cbZ1K3xyCM/feQhYQCesjTD
 F0KkMCmLXMe/zHhxYtmJ8amkNgx/cDwS/lHea4hU+dQ==
X-Gm-Gg: ASbGncu0sh2qnRlEvMJL980o5vrvej17nvxGlihMiza9TJUDYfSimj4GhlVKJTZOANC
 UFGeJEkdF7mvLOXlb/c3+tfIy9NdmpHkdkcU7kDaJXCFD9TdieIQ3/O3yUwDYGtaGXcfIcMSr05
 TcG3XT8FSM64Frh9IOrxaqI9he+qxrLJy5emeoI0to/aRPnx+j32GuH7dG+TibJmwNdYn6K9tm3
 2/f9UvzutcVsxxXXyg=
X-Google-Smtp-Source: AGHT+IHhAlDDKzb5xF+qmj2ly+uE3KXFY5gguo1/WQPn9uCzn3MUs9pzxD5Zq/Xwr7GEXab2U79HIVQdPSY5BuNf7E0=
X-Received: by 2002:a05:690c:6082:b0:6fb:1e5a:fcdd with SMTP id
 00721157ae682-71837109292mr80646997b3.17.1752745595969; Thu, 17 Jul 2025
 02:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250714110406.117772-1-pbonzini@redhat.com>
 <20250714110406.117772-16-pbonzini@redhat.com>
In-Reply-To: <20250714110406.117772-16-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jul 2025 10:46:23 +0100
X-Gm-Features: Ac12FXy8-gBLS_ae3mCElDrpJ2AcoQkry5b26YxJUKHiKow1fx1K5pl_AVW-jlI
Message-ID: <CAFEAcA9Hz0K9Z27mVs2fYcXpa-1p=kJvtgWEVjGTg-C+-egnVg@mail.gmail.com>
Subject: Re: [PULL 15/77] i386/tdx: handle
 TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Mon, 14 Jul 2025 at 12:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Xiaoyao Li <xiaoyao.li@intel.com>
>
> Record the interrupt vector and the apic id of the vcpu that calls
> TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT.
>
> Inject the interrupt to TD guest to notify the completion of <GetQuote>
> when notify interrupt vector is valid.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://lore.kernel.org/r/20250703024021.3559286-5-xiaoyao.li@intel.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; Coverity (CID 1612364) thinks the locking might not
be right in this code change (though it has a fairly
simple heuristic so it may be wrong):


> @@ -1154,6 +1179,9 @@ static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
>          error_report("TDX: get-quote: failed to update GetQuote header.");
>      }
>
> +    tdx_inject_interrupt(tdx_guest->event_notify_apicid,
> +                         tdx_guest->event_notify_vector);

In this function we access tdx_guest->event_notify_apicid
and event_notify_vector without taking any lock...

> +
>      g_free(task->send_data);
>      g_free(task->receive_buf);
>      g_free(task);

> +void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run)
> +{
> +    uint64_t vector = run->tdx.setup_event_notify.vector;
> +
> +    if (vector >= 32 && vector < 256) {
> +        qemu_mutex_lock(&tdx_guest->lock);
> +        tdx_guest->event_notify_vector = vector;
> +        tdx_guest->event_notify_apicid = cpu->apic_id;
> +        qemu_mutex_unlock(&tdx_guest->lock);

...but here when we are setting those fields we take the
tdx_guest->lock.

Should we hold the tdx_guest->lock also when we read the
fields in tdx_get_quote_completion() ?

thanks
-- PMM

