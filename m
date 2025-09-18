Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDFDCAC5A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 12:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzE8K-00082z-Qt; Thu, 18 Sep 2025 08:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzE8J-000827-7l
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzE8H-0003s5-GI
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758199984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l3YMQ+ChjVTz9YacEjddJ7NmRqHqMWE3sudjbixo8J0=;
 b=MKq01tAWrGE+pWo/Ep/RPIpoWO6GVbdKeIXeFd/wxTTCGByGAoJi1MDCUNe6kK5LybNJRR
 O4kfKLF0chYN0wDrUV/V1Lx46HClkKHDBeBbZrWBm5M9/RvKENF3/r+NleMLMURpO+e32E
 F+NKTAqeYisP43tA0qVDLqNj87Fr0qs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-PYOOsc9aO7mg8cDzZ82iwQ-1; Thu, 18 Sep 2025 08:53:02 -0400
X-MC-Unique: PYOOsc9aO7mg8cDzZ82iwQ-1
X-Mimecast-MFC-AGG-ID: PYOOsc9aO7mg8cDzZ82iwQ_1758199981
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdc9dbc5fso598496f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 05:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758199981; x=1758804781;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3YMQ+ChjVTz9YacEjddJ7NmRqHqMWE3sudjbixo8J0=;
 b=lil28RBLsEy24bUV/Y//Pu3el/A8ATPMXlfG/p64ZqKBPp6Gm8ivdtRFQ388r3pZAl
 0oaMq0q2J2gVha9Ke+PyiJ7SNRGr5FGIME7B+P+PFXhyY56CohjjCsBcjKaZcnuFt8fQ
 DBlVnXtRoSMiQXsi2dQBDQvmYT/qjJHgdw1CKrX7D12LZM/uq+ZhCze2EYFuE9xrVJJt
 5SVAeXeejGlE3bbQt6tIKrMrYerdBG7zoJOx8DdthWUbpeyGme44Op9Yvo4Sexw7FPqq
 KDJs0Dtv1jnY40QJtFB92nw3ojSjSpmrSYDa06Evcb8w/AsqoCkCyUTW16WQk+iTHEQC
 klFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8F33GxHYWjaifagBfE2TV+qrUrX3c4zW4VsFTEXyXEg2ZClzxBEbcLggdc62iRM13Z2M6KL6as5wP@nongnu.org
X-Gm-Message-State: AOJu0YxSZEmB1QffSNlhmBuyMyv2Rnwm4cSCsxIDGJ9H3ogxFzOw81OT
 dF7jNjjy0AM/uPccFaFNLABAMKKIn15LYB515dqYzsJF+lKD37gGacBVfQeVqAtlqaTf316AjD1
 lhekhW/byeq9L2trSoInUs4iJJSmGa+39fBOzQCJXU37zllPingPKvRO/
X-Gm-Gg: ASbGncsacby7e0y2T5WWABIA3I4q8BxMS4kyaCjfTiX0wHIVs37pEWptoigKwTQG7to
 wDJClgklo8rwhqhbKZpG2CuLCus272sfHdlkDTd8J3I2Ai7NrTbVlph41Cb7PDn1ENKr0uJUU+o
 LMB8i8dKV0biWUwMsFXfP5fSWngCi5ztfAPyEVubgDdaSYuvVzIOXSKqljyeoLqdFdvbiIon0dG
 X3Wx4qfSyQCS62/MbRBBDcAaXaL5Tr49B1rBvtAUJ/JXPV1b3X+RM+PhGmZZ/q5m7/lbVtkNt0f
 uKe9ONnI7YyG8cLn5FWjle3q058rgImt5ivSqwrs8z7o/eEL9pkZ3H8Yn6RsOh+R7SZRuMobtBL
 Z+gU87g==
X-Received: by 2002:a5d:5886:0:b0:3e9:d0a5:e436 with SMTP id
 ffacd0b85a97d-3ecdf9c0293mr5482816f8f.23.1758199980770; 
 Thu, 18 Sep 2025 05:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7UPSx/O4y16Ru9EeCUI+rVxNFjHs//q/zPr8KCI8e+Nxk4TsIJlO/5mi51+a9RwD8rWEfOw==
X-Received: by 2002:a5d:5886:0:b0:3e9:d0a5:e436 with SMTP id
 ffacd0b85a97d-3ecdf9c0293mr5482791f8f.23.1758199980336; 
 Thu, 18 Sep 2025 05:53:00 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbd666asm3524508f8f.49.2025.09.18.05.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 05:52:59 -0700 (PDT)
Message-ID: <34517c98-21ea-4fd2-8798-d2c901b3ad0f@redhat.com>
Date: Thu, 18 Sep 2025 14:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: Fix "make check-functional" for targets without
 thorough tests
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20250918114015.83061-1-thuth@redhat.com>
 <CAFEAcA8qwgQoGrU1phd+ozQMtWdo=Jt_XNCtaxPysoqaLxd16w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8qwgQoGrU1phd+ozQMtWdo=Jt_XNCtaxPysoqaLxd16w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 18/09/2025 13.51, Peter Maydell wrote:
> On Thu, 18 Sept 2025 at 12:40, Thomas Huth <thuth@redhat.com> wrote:
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> If QEMU gets configured for a single target that does not have
>> any thorough functional tests, "make check-functional" currently
>> fails with the error message "No rule to make target 'check-func'".
>> This happens because "check-func" only gets defined for thorough
>> tests (quick ones get added to "check-func-quick" instead).
>> Thus let's define a dummy target for this case, that simply
>> depends on the quick tests.
> 
> Tested-by: Peter Maydell <peter.maydell@linaro.org>
> 
> We also have the opposite problem if there are no 'quick'
> tests, which you can see if you try 'check-functional'
> on a build configured with the aarch64-linux-user target only:

Yes, looks like we have to define both targets in Makefile.include, just in 
case of such situations. I just sent a v2 to fix it.

  Thomas


