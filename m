Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095A3C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzX5h-0004dh-BX; Tue, 01 Apr 2025 04:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzX5G-0004bD-7O; Tue, 01 Apr 2025 04:34:58 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzX5E-0001Bq-Le; Tue, 01 Apr 2025 04:34:57 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2243803b776so29115355ad.0; 
 Tue, 01 Apr 2025 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743496495; x=1744101295; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KjoTC0DBrzX6Zpx4diqskJW96XJ1RiID2DuCpOlPHnc=;
 b=PnS7BmZQG35McJPI++zzN43ksoTxo5YFZ+cE4sCEPNGIuDc2hjg6V/Vkkrdf1i3FUb
 dMtqj5T8N+FwEIYuBve+cweRMGUpx3C5L+oYnCT+vu9XxnteROPG6Aq5/Lf7uC7SlLBe
 qJW9hDOazg6Xfwe2nM+Fg900FOaCjpBpSuVfIQ6V7nO8bX/9ciDRmNf2ZYVddAfPeTPA
 EEJN4EntK68FxhAjRv2xZPzAT3dDGDmkZN0KnyXSVdPYC7kpS99GRMgep44LmoPSX/zT
 ISfKd+zkHbDfhyaGJrKvkIDSllUVOUugJ6EhnxRuXvRyQLUQMGvIB+Eqb3VCfgfLgb3l
 pLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496495; x=1744101295;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KjoTC0DBrzX6Zpx4diqskJW96XJ1RiID2DuCpOlPHnc=;
 b=N+mHnskeJgz8WIUKTSJKGdqSEq88SCufaUU8MTFof//57K29Vs1IcVZvxtyAiEI553
 ySWelTOGLOKauxABuzH9z+sgAFJFdVpa2n3pxSPhqizFNEvuCdJ6cGenHrjNGuWoijvS
 DlARUVeSJEzZu4Bq4YEMbZv8EcOkG3MwRIttYyLG2bnXDfUcx9c2DysBmCCyhqJekPzU
 RNJ+RoFrZAAqXMyfjmx3jJF8aTjiUzve9WMgY6pS+kTRH1me6sV7oNSvSBxkJ/gJ/nDz
 V8mppBsbnetdbAVckbEoK8LsCU4oSqwrhkgtFB1/EQz5cbD5DY9xuDpTrx6QuoYRXZky
 xOnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWTKHjwmjZ+OYff63sPr0yKdVJNEqD1zD+TsCIMILljO/eUfYPa92dYwlqkiwGLHEhUYj5yYeAYQ==@nongnu.org
X-Gm-Message-State: AOJu0Yxf4HaqEI0iTVJEHY4IGTXvO5rSwcYxcbT1Zg6DW7/BbmxuEsLj
 kBaLADfy6/x3hgMgSGGRUgl/8/UNIax5q9G3+SOAXc+IGog+bNKAYkQo1A==
X-Gm-Gg: ASbGncuH9bVkWPr8VbhBptlY23eWqLIsYxIQY1zP/cCvvhGPbGEU9mSpO8ln54KxWC2
 Z9ryb7bUnS7tXrkrCWsaO/VuL6zEaGC4lZQ9dXPvJoDNKrau9E12ssVw6owEqwnS/9jwjyazr/Q
 Q53T0CV1Qg66nVkAIkNVjJ9HM8IgwMj8evyS3EuAC3lZBpWxcdt/IN0drQsdzcsE+uKc9rM9ATD
 d1ZnwU1eYKK83fFDuDlUkAt5/SR1tgC3ls7XmZCUf6w9iJ+e/dePxGFNr2b7LJ1VtLJsTLKGPvV
 J9mDOlNkai0b7EpF+1WZCHQWJk0JFxmsyTRoSyk=
X-Google-Smtp-Source: AGHT+IFa/n5nE6vf5dsxq7msqn5LEEwT4q8lldIBZ7mHXMJhf97okmrryk8DS/ro2id4bQ32DDa9Tw==
X-Received: by 2002:a05:6a00:4b05:b0:736:4830:68a6 with SMTP id
 d2e1a72fcca58-739803359e7mr20250988b3a.4.1743496494600; 
 Tue, 01 Apr 2025 01:34:54 -0700 (PDT)
Received: from localhost ([203.185.207.94]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73971091cadsm8321826b3a.126.2025.04.01.01.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:34:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 18:34:50 +1000
Message-Id: <D8V5XAKJ9ZYN.12HHKNW227769@gmail.com>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 1/3] accel/tcg: Option to permit incoherent
 translation block cache vs stores
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250331155423.619451-1-npiggin@gmail.com>
 <20250331155423.619451-2-npiggin@gmail.com>
 <baa70d58-d599-4b81-9333-7982b82f1167@linaro.org>
In-Reply-To: <baa70d58-d599-4b81-9333-7982b82f1167@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Apr 1, 2025 at 5:51 AM AEST, Richard Henderson wrote:
> On 3/31/25 10:54, Nicholas Piggin wrote:
>> Add an option TARGET_HAS_LAZY_ICACHE that does not invalidate TBs upon
>> store, but instead tracks that the icache has become incoherent, and
>> provides a tb_flush_incoherent() function that the target may call to
>> bring the TB back to coherency.
>
> We're not going to add another target specific ifdef, as we're working on=
 removing all of=20
> them.  If we were to add a feature like this, it would need to be done an=
other way --=20
> probably via TCGCPUOps.

Sure.

> How much benefit did you measure for ppc for this?

It's noticable, I'll get some numbers.=20

>> XXX: docs/devel/tcg.rst says that this is not permitted because TB must
>> be coherent with memory to handle exceptions correctly... I'm not sure
>> where this is, maybe it can be worked around and is not a showstopper?
>
> I presume that note was for x86.

It is actually for RISC it says. But it is very old so may not apply
any more.

Thanks,
Nick

