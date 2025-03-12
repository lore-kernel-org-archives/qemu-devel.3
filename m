Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65562C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsN8h-0007zW-ER; Wed, 12 Mar 2025 10:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsN8e-0007wr-U9
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:32:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsN8c-0003sd-3U
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:32:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2240b4de12bso41555405ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741789968; x=1742394768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j2oQtL52km6dMRq4E/9KIo0vhaHcbPuw6RP0qr/x/nI=;
 b=gkXaFKZFSBF2Knz3IU3yCj8X7nY6Sfdq/H8mL3lUT2qrTDpKPkrlzGnrC5VZepM3Ur
 t4zRamNvo9UgpXYx1vDvx0QS6faCBmGbrGKt5efiprKGGVjKARhZx9RgyKzw6irlgMQU
 AVtPYO2bJ9nnnhDW6Sz7OG/rnNI7kNSWk7zlzhOFKDsgBFmaMYSYcKVEllDyPWTq5teH
 UGUYYYS+cxf2NZnjPMe+TXG+qSsSghQjTlVC+pwIRA8o6Ch4aVvh5x9gjU8fqZjKCafn
 mZf9nlqtc/h4Kky/uonVeyH9DX2kEm1bKeITjgoLA1ER3EcS7hgHCyTF0gvQaPKrqkuS
 /hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741789968; x=1742394768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j2oQtL52km6dMRq4E/9KIo0vhaHcbPuw6RP0qr/x/nI=;
 b=X2+154z8q13T9qNCjDbYm5S25YBjRNsuUCfuSjJW8HqP7O1tIWpm5DWfcXR3SmcYGf
 Da1D+JUreNkBi8fSY3NYLxJ4KhHFZFn8JealGiWajrn2/WL6IXedOyVteESxmWwaJSFS
 vX7NAYPOL9dNyrZQrCOfC8BR+ga5NpJf7W0nCsjQHGcLiwuAlnQs1IajMXmciXnScoUQ
 CfFkS4/XWWf+mavt9oDkVhp3Jf2nWQGDA5FUIWyu9O6Wddj7vIjd3q81ibEPgeiHruiN
 J5ca9WNcwaBnyNOAuSkq0E5dpQMnmNKByvRGAkLd9ZvqvoVJeWemCb2aar939TLJ+aRk
 IllA==
X-Gm-Message-State: AOJu0YyhlANaln4Ho7XU22UB/3sCuXqpA6i9H4Jb66m2iNNUSbx7TPVn
 FmJstfMeew6TZas1QevdHgD3NRQmrTrCI3Q6oQTJiqhIB0kQPmJ43rVFdq8677E=
X-Gm-Gg: ASbGnct4dw1EwSBr4rDlMAcdK8e045w2Pule2AGJIT2eGFsdjdeiqhpF+kMAoIzrpLd
 nTSQE4m8i13SRvGOhPtNEI2J9ni2wRM9E142n2ZkdHMbz5F1Mf+lKsEhydsY3wjt46wE5YYlkWK
 5mgBfrJWww44LerEJUdF2tOA/8DRDisBnrCfF49FlBnrKeF1IbZV0jQ7PVQC98BiOwR8McyuAda
 BPaU2IKuiBQsugq3tRAF5e2lfMStOCikmyGGEgO28k2UslnGIAN94bQ3WK0pXGacGu15a9IuQdp
 EMk2xwgl9jT1/rvmVhhxDTHdrwva3H/x748+wiTfmXRgp/0pBDru+USAhnJTORRqaWrsAgsxJwV
 E8FryzwsR
X-Google-Smtp-Source: AGHT+IHNKmgZQI9Q9XAy44lrtnij/x863QgSlWavnA3uiuM0FxHjkUjcdIfEcsCendqK14eKV+b7fg==
X-Received: by 2002:a05:6a00:b4d:b0:730:8a0a:9f09 with SMTP id
 d2e1a72fcca58-736aaaaca0fmr33143789b3a.18.1741789967816; 
 Wed, 12 Mar 2025 07:32:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736c16c72ddsm8785162b3a.177.2025.03.12.07.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 07:32:47 -0700 (PDT)
Message-ID: <01af330a-d5c0-4d0e-bda2-0a3908dacd6e@linaro.org>
Date: Wed, 12 Mar 2025 07:32:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] util/cacheflush: Make first DSB unconditional on
 aarch64
To: Peter Maydell <peter.maydell@linaro.org>, Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, slongfield@google.com, pbonzini@redhat.com
References: <20250310203622.1827940-1-komlodi@google.com>
 <20250310203622.1827940-2-komlodi@google.com>
 <CAFEAcA8VO4QNU5+9Xk=AiBObXFCRoPF3NUN9m2r1752oi1cShA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8VO4QNU5+9Xk=AiBObXFCRoPF3NUN9m2r1752oi1cShA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/12/25 07:18, Peter Maydell wrote:
> On Mon, 10 Mar 2025 at 20:36, Joe Komlodi <komlodi@google.com> wrote:
>>
>> On ARM hosts with CTR_EL0.DIC and CTR_EL0.IDC set, this would only cause
>> an ISB to be executed during cache maintenance, which could lead to QEMU
>> executing TBs containing garbage instructions.
>>
>> This seems to be because the ISB finishes executing instructions and
>> flushes the pipeline, but the ISB doesn't guarantee that writes from the
>> executed instructions are committed. If a small enough TB is created, it's
>> possible that the writes setting up the TB aren't committed by the time the
>> TB is executed.
> 
> Yes; we need the DSB to ensure that the stores have completed
> and are visible to subsequent icache fills; and then we need
> the ISB to ensure that any instructions that we execute after
> this are done with an instruction fetch that happens after the
> ISB (i.e. the CPU hasn't already speculatively fetched the insn
> before we forced the store to complete).
> 
>> This function is intended to be a port of the gcc implementation
>> (https://github.com/gcc-mirror/gcc/blob/85b46d0795ac76bc192cb8f88b646a647acf98c1/libgcc/config/aarch64/sync-cache.c#L67)
>> which makes the first DSB unconditional, so we can fix the synchronization
>> issue by doing that as well.
>>
>> Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> Richard, are you doing a TCG pullreq for rc0? If not, I can
> put this into target-arm.next.

So far I have nothing queued for tcg.  Please go ahead.


r~

