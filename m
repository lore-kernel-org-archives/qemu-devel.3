Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC96C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 07:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPcO5-0003sw-6C; Thu, 12 Jun 2025 03:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPcO0-0003r7-54; Thu, 12 Jun 2025 03:30:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPcNx-000505-W9; Thu, 12 Jun 2025 03:30:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d54214adso4589325e9.3; 
 Thu, 12 Jun 2025 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749713402; x=1750318202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZ6sPcipkdgCHZUrlXXsBzdJ/gVBOKP0mf97qysVYPc=;
 b=FYpff/5ckEgccfCzTMtJp6gcoOKbrq8GFhaTixHqpDKzzGd2GVDY9hLLj2PjHpsHfO
 pNjFBiPYJCbm/c7M7sE1FEwAD4pnSXKPcM0swyvloyOSl9BaoNDmO2zoNhwOZ2JClvyZ
 SdUmoD6ZrAWokAjRnTwjNulqDljWPGG/L9LkyYtHaUQa14Q1DxH6V3K7qQRLKLIVaqmG
 agpyG2m0/ewUAzaSsGVEbxhD7UwgD/rlfiGabbhmWpvloO91FrYy6qfGr2slo4Vlh2Pv
 bwsT7NIjQaUo6cc8YAKHXhnSOQRnH6JADA0OCmIr/mzX1MCk2UB3diI2BXg/0sYtAuvw
 0NKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749713402; x=1750318202;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZ6sPcipkdgCHZUrlXXsBzdJ/gVBOKP0mf97qysVYPc=;
 b=TEjT8vTWy6/krPgIrQyEtVKH4Hy5r4dBjq5qISkgP+Gls3+T7tqFG4/pqcsPr7Y6o2
 Z3oHUn39iSwfm0dtQ+x4WdBI1KaCDEsSIBr1MLhI0gCbjP6grkYu526t+GNiHi46qO/N
 +gp+fNJ6L89YNFBNkzrVZPM33kplOw6S3RYbyF9duWYRaDfOuGUE9MWEVPN80A9OeItE
 M81IGCA/Pj5R2FX18jOirtNKfrX8jr25pa4Ba/BWKvarpmopKQDX+XhYfQbgnZMGaCNH
 Gn1EZ5p4PoiyPMnR0oYX+W5ekvNg2OSoiGGf5RgyJKCfWGv5MdWxeS22fuyoRUcBOUPZ
 +PJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4hd8OGbOlQmOBc/gT3Wgnxnzv7bEi+9Yr9CJaYttL5yLW/qr+lVFKPS7KbeLkN06qapGq/7LMgUY=@nongnu.org
X-Gm-Message-State: AOJu0YxvfD92e3RdWggPUUS1Hmzw+4wBfIs56Vzv5NlSmiVj4Zn31We8
 r+U+tpMoa0JtNAQX7rmDkNRKbDPnMTkI8Zi/7wzGJuoAVpHPi8vVZXDA
X-Gm-Gg: ASbGncvzA6JyTZabMjbA4+lCjI2ox4GHrLr+oj/p8HjXQO6ZMoFLCOIwmeShIlwDOoO
 Qte42o4mOCi63pY6c+VLeBAAV0WZqHULz0QrM0siZq2cr+GDDCsneHdz6H5Q84P1aLLBZ8IxsWu
 4hSdXu5AoHQCLwToXJDGolvr60RnhQoly1gTFyi5c0cd59wzE134sQdasiOxOxw2YJ9UqlmwjVf
 2eN0wNZdh8fwCJKbxzMqVCHs4+vQ3Y1faISUp+BY3mdFQM488jbW2PiHr6Hbjh3T4vOGcY1jVql
 C3H9VW0R/bux6n3wXdRD4m21CUWf55yPgIKj7t+rRWi5X0DqshWA1KylYfvYTzvHi6k=
X-Google-Smtp-Source: AGHT+IH7Y0ttH5M3AHT2bU36eXJweMGldXIecU3i/W05D7llHYNUWysbP2+tFItsc0H+TNU/xW/67Q==
X-Received: by 2002:a5d:64e6:0:b0:3a4:fc52:f5d4 with SMTP id
 ffacd0b85a97d-3a5586e983bmr4896646f8f.47.1749713401877; 
 Thu, 12 Jun 2025 00:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e151c3csm11760555e9.30.2025.06.12.00.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 00:30:01 -0700 (PDT)
Date: Thu, 12 Jun 2025 07:29:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_rust/qemu-api=3A_Add_?=
 =?US-ASCII?Q?initial_logging_support_based_on_C_API?=
In-Reply-To: <CAAjaMXZ5S7GUPmhwxsyuVmF4tvUh3vgjnK8OLKv-A+h7JCPqBA@mail.gmail.com>
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-2-shentey@gmail.com>
 <CAAjaMXbtcyB3J3AvGh8ZW3MSi41uMaE+TkZwipCs5pg6wvYJ=w@mail.gmail.com>
 <CABgObfYgoYBJmZjin_Wj8JeEviFMM+vFa_QX_8Np+1n9apq4kw@mail.gmail.com>
 <CAAjaMXZ5S7GUPmhwxsyuVmF4tvUh3vgjnK8OLKv-A+h7JCPqBA@mail.gmail.com>
Message-ID: <07B116B0-6D08-446A-9BD1-C8020D8EE86F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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



Am 11=2E Juni 2025 12:17:57 UTC schrieb Manos Pitsidianakis <manos=2Epitsi=
dianakis@linaro=2Eorg>:
>On Wed, Jun 11, 2025 at 2:05=E2=80=AFPM Paolo Bonzini <pbonzini@redhat=2E=
com> wrote:
>>
>> On Wed, Jun 11, 2025 at 12:57=E2=80=AFPM Manos Pitsidianakis
>> <manos=2Epitsidianakis@linaro=2Eorg> wrote:
>>
>> > Maybe we could take this chance to remove the requirement for trailin=
g
>> > newline? Not urgent, and also something we could change afterwards
>> > anyway=2E We could also introduce log_mask_ln! macro but now I'm just
>> > bikeshedding=2E
>>
>> Good idea; there is no "formatln!" but I think you could use concat ins=
tead=2E
>
>I think `let formatted_string =3D format!("{}\n", format_args!($fmt
>$($args)*));` might be sufficient, but I haven't checked it myself
>

So the idea is to have a log_mask_ln! macro instead, since there isn't rea=
lly a point for a macro that doesn't add `\n` at the end=2E Correct?

