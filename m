Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67A7C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9P6u-0005w1-Vx; Wed, 23 Sep 2026 11:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9P6s-0005vo-KF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:42:14 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9P6q-0008Kb-8C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:42:14 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254fa4c24cso169873066b.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790178129; x=1790782929; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fa6raYUBVSEFVnAsw5R339WmgTTXl3BZylIoJtApnDA=;
 b=egdFN23sHU3Tre8KzkTlMrO/vHXIjzisNS3uzdyvJIZ2LMpfZ6r24qwTcsBmylCKvm
 Rj7N8bmVblqHt9NPKyrsZhnz5RsgdHasRK5kB38akpczWw6gdGHMW/AIHTyZ09D4NSLM
 yOwHJDYXGS0AB1BmA+lgnYrPY2Fggj0RbkGExJTJWwQypsbh8K3c+TNaCvar80k9TN3I
 jY86ss9sj4ce/lugOQR2UsEihOzOgnnhWTsFxo/gp/NjF4CALobSZ4KQt5Cpsxxoergr
 LRc3TWJ5bPYAYXjX5JiPh2kaRpUlUMbDcogzZVflzDHAIX1IRPS+m9RbsXKpoGmwnIO7
 xQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178129; x=1790782929;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fa6raYUBVSEFVnAsw5R339WmgTTXl3BZylIoJtApnDA=;
 b=UF+i+85GDy4aT9S1UDIB1+LUkekTDhVu8raZArz3LBB2JJAM0SLqV6W7t/Bm3AmTZr
 XMAVVZUctL8NsWA8gXh18e+k7VeynKp/0D3hROCwkt8Em7rnRexTC56vNtxjjTTsWBeg
 6PFZXgnZu0nVEFsvn6q6Q+M3pnyvMdrFzWpBEGWy3WkHCM51chFVlb95f41Xu41sHGkO
 Lf+Qowr0gmTGgBF/JHJZGkYlk830Wxvspqpq+OewT2huF9CVz7I5oPLSBbGo2kCzDs33
 q99hlZemz6CrneWOWBZlKrpG+ThPCeMbmsEFQHng/HPWiRD/aw5LrEMWPvqg5XK4VyFO
 VAXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9mOvyRIbhVHr1YelGu6Oed6UP2sOJeL5ImqSajT/pxCeVjs3RjR03d3JCc5YekQfxFSk8JHbrBrRd@nongnu.org
X-Gm-Message-State: AFuF++kaxf8XjcENHL7q+Yzqv1WDOTSerUdJMD9RLC0Ez+uPlG3imexv
 pYAopkEIQO48mLOT0Ukz3xQ0pMQr+miuIcRqg13uXB4RGv7amQyja5g0QtFiKQ2aXOQ=
X-Gm-Gg: AYBFou0ajVxxoEkYdkMKHDkpkUV1yJxkfsZfcLKda5iZez5URrcx+4v6GL7vg0lXTtz
 tRgiZ2dvPhL/uX+SeRd8kMP1d+tUCghx41c0hFhnq48jQ2eWDajJRZ4sozPHnXnX3YpnhFxK9H9
 bG8qEqZz+D73CCArJ3Ju0H9Tm/fQKNmv4eBEHrYaJL8ZA+TfQD/HYxuBrewAxWx9/Hc1i5KL0Lh
 KjzDQy23HGGfKal3OPQu27hRuhQFgy/hBN/Qz7BD79c/7UG8vjUzplgQd8ya6nR/opeJ4Q9/JKF
 qRxYYTmlPzW7kBJ2AM+dqt76I+U6VifccadmTJK1T0RBZW9wBw5jGuj3DnZKkFa58z/cHHb3/Pm
 0qfF62IvA2DUwWjZt7FxdXAsV+nxyCmHifquLWB8i1uqH15cxYP5QKE0q4nA+o3MH0c8RC+fMgt
 v6IxaOIETzYGCohTMauj7JFzFpFBBI6Enor+lOysqsEljtZQajBejeFmCJY4RRptkZK2MPXxE+P
 4q1yM20bpKY1ek95HWMySnKA0II2pCxsG1WB7i8
X-Received: by 2002:a17:907:9405:b0:c29:22cf:b0f5 with SMTP id
 a640c23a62f3a-c2aae0e4639mr236419766b.33.1790178129480; 
 Wed, 23 Sep 2026 08:42:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae63dc17sm143256466b.33.2026.09.23.08.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 08:42:08 -0700 (PDT)
Message-ID: <a78097cd-0a54-468c-b999-4b37d5f92032@linaro.org>
Date: Wed, 23 Sep 2026 08:42:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: buffer_is_zero() constant optimisation not always applied
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: tejus.gk@nutanix.com
References: <06a98356-20c4-479a-a8f7-392ce5b941b5@nutanix.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <06a98356-20c4-479a-a8f7-392ce5b941b5@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej2-x10.google.com
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

On 9/23/26 04:55, Mark Cave-Ayland wrote:
> Hi Richard,
> 
> One of our engineers, Tejus, reported an interesting observation that 
> during multifd migration the zero-page detection logic was falling back 
> to use the out-of-line buffer_is_zero_ool() implementation instead of 
> calling the accelerated implementation directly.
> 
> What we discovered is that the optimisation was not being applied to the 
> buffer_is_zero() call in multifd_send_zero_page_detect(), even though 
> multifd_ram_page_size() is effectively a wrapper around 
> qemu_target_page_size().
> 
> Digging a bit deeper we found that migration/multifd-zero-page.c is not 
> being built with COMPILING_PER_TARGET and so we fall back to the 
> TargetPageBits logic for qemu_target_page_size(). On a local x86 host 
> here the expansion for qemu_target_page_size() becomes:
> 
> static inline size_t qemu_target_page_size(void)
> {
>      return (-(int)((int)target_page.mask));
> }
> 
> which isn't considered to be constant at compile time. Given that we are 
> building a fixed x86 target, is it still possible to get the 
> optimisation applied at least for the migration use-case?
Mm.  And we certainly won't want to build migration/ with 
COMPILING_PER_TARGET anymore either.  We should probably just drop the 
__builtin_constant_p test these days, since it'll basically never be true.

The question is whether buffer_is_zero_ool is good enough or if the 
inline buffer_is_zero_sample3 to (potentially) avoid the function call 
still has value.

Anyone willing to do some microbenchmarking to find out what's best?


r~

