Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0E3FC6181
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spDE9-0003WO-8e; Fri, 13 Sep 2024 16:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1spDE6-0003Ui-KS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:49:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1spDE4-00037t-Tq
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:49:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-206e614953aso28292015ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726260547; x=1726865347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:to:content-language
 :references:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VxUorh4NWhWnBfjL6qaCnmHLNtkmrkYrwGKKgjqTXHM=;
 b=sRxJUOBxk70HGuaoNUc7tNt27XeuhL31NA6baIYwoOJeWEgjeRqKeCf7elcjuG2UTX
 2WivlRFtNfGAzYJbCxTu3izyzOUyILUl02+8iBqTjgdQr4koXwMzFGPBwEAQS1i/Bt78
 Q3P0EIWUsVOQXBhhf+V0nWAceliSraKnbAC8/6U51aINioY8nZHxV60vKUh/fiwgAOvu
 pjpp8dFsdXcYwNdYIKUMY76My6n1lisDNtJlCE50f9XIAi0ttCG9SgXBY4I08rgZRHl0
 UGuBKczYNCcjE7IpPc1DBTdt++GcD+KX+lI6a3/RCxktexkAHXCnKjNhoTkaz1k1q+FH
 g/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726260547; x=1726865347;
 h=content-transfer-encoding:in-reply-to:to:content-language
 :references:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VxUorh4NWhWnBfjL6qaCnmHLNtkmrkYrwGKKgjqTXHM=;
 b=V7YL7bKocAt9Ml0oux+f9Pp9UvyAJBQNTe/G/Zk6ss0P42DXa+7OwIYZdfr/EpMSd4
 l0IyGXho2ecvkwLISoJDMO9v0avHiyXB/kNGQk6jRtITZy2d8cwb/pUxMJcSBoR16D3H
 wDEO1RHTX3ASZuDLDkhynYtiZ1BdgipsWzBMzYPeoCrB9cUeDWbzXrF90ocvN7iRXFcU
 dFBcSzTMYI7ei5Fo5qKEGYU/m7KgA5v8x3kSCHNvelh78h2hpUjrbhH/+cTgUxxOZsL0
 qUiYgcnjRajhR7tew0dC8eqAZFSKnQiFow36nqnFpIXEppEl3rUdkE1IgsubBJTP+NCp
 usvQ==
X-Gm-Message-State: AOJu0Yxk8qR5QC66dewE+hOdidSE/ZmHLHNlyRo3N+02ARZu264VZdkR
 woUY607C995PbmPCyQ2zeT0djHY2OFVvU9sNk4Sku5pZEiSxs4+/F8Fsb9YyC2O3kDbN32Ba4Oq
 a
X-Google-Smtp-Source: AGHT+IGvvFRjjs9R+sd6DHdRCCnvplsKr8FObTsdNZTs36vVuxHpeVlm71zw6mWQSpKvLFkMzoRDCg==
X-Received: by 2002:a17:902:d50e:b0:207:ded:9cbd with SMTP id
 d9443c01a7336-2076e370cadmr103928285ad.24.1726260546684; 
 Fri, 13 Sep 2024 13:49:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dbb9c3f29asm2276823a91.1.2024.09.13.13.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 13:49:06 -0700 (PDT)
Message-ID: <a554dc1c-7c6b-412f-915c-2f3ce3a11cc2@linaro.org>
Date: Fri, 13 Sep 2024 13:47:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Subject: target/loongarch: Support QMP dump-guest-memory
References: <a6e35fdd-d8fb-4368-918f-e5f9cdb90105@twiddle.net>
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>, Bibo Mao <maobibo@loongson.cn>
In-Reply-To: <a6e35fdd-d8fb-4368-918f-e5f9cdb90105@twiddle.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


On 9/13/24 11:44, scan-admin@coverity.com wrote:
> ** CID 1561133:  Integer handling issues  (BAD_SHIFT)
> /builds/qemu-project/qemu/target/loongarch/arch_dump.c: 102 in loongarch_write_elf64_fprpreg()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 1561133:  Integer handling issues  (BAD_SHIFT)
> /builds/qemu-project/qemu/target/loongarch/arch_dump.c: 102 in loongarch_write_elf64_fprpreg()
> 96         int ret, i;
> 97
> 98         loongarch_note_init(&note, s, "CORE", 5, NT_PRFPREG, sizeof(note.fpu));
> 99         note.fpu.fcsr = cpu_to_dump64(s, env->fcsr0);
> 100
> 101         for (i = 0; i < 8; i++) {

>>>>      CID 1561133:  Integer handling issues  (BAD_SHIFT)
>>>>      In expression "env->cf[i] << 8 * i", left shifting by more than 31 bits has undefined behavior.  The shift amount, "8 * i", is as much as 56.

> 102             note.fpu.fcc |= env->cf[i] << (8 * i);

Coverity is correct that 'bool' can't be shifted by 56.
However there's an existing read_fcc() that gets this correct.


r~

