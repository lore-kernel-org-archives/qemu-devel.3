Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674E0C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGJS-00009J-K5; Mon, 14 Jul 2025 06:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubGHr-0007bQ-J1
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:20:04 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubGHo-0002v9-H4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:19:55 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e8276224c65so3677415276.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752488390; x=1753093190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v9jzWSjLXExFqqVpvpK2AkRoYqLYZiZEgR1f+vTFLuo=;
 b=CN/G77Z8ZTjJmGScrCp8pF/UTsgCeYwyxWNIfQfnTLDqQ3BRkHF3BshIZ7soWueeU6
 Cm1qlXz/z8j/8aK+o5WE9aW1CkKCWvFMxU3Gbtl+AnsRScvgbtoCmziMHx1OfHudDDAy
 7Xb6/JxvEo21qFsKyYpxYR8rqrlLKELe+V2DzMMtcUgB28MOQFm5OExoUC9Pc3Qozhwe
 IDEgXscKByZc7pSqJe9d/EC+ELixJJRIKNT6/6eEUBGZFJM+V0sk58twyNlHX9DztZXs
 XV9NOCTugwmzs9cslYwkyin9Zi8SP7Dlz3taa/GOJMB0oxUaAq1NJrlKWAIMH6UB2sSa
 f5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752488390; x=1753093190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v9jzWSjLXExFqqVpvpK2AkRoYqLYZiZEgR1f+vTFLuo=;
 b=wmrdPZ1KaUEJ9Patc6xwvuLRVYrEZTkMiSCcCOLb9LDL4cuk7ZtCiEpdOksTZDMWEu
 +yJBPs3uMgHwx9xmgJP7RXLbKyDZNN/S/mqxz26RExOr7105+le9iqs5Q3XAVie2sKbs
 LqpTgiGlIgMHMOq23NmJyxcR5xqpf/p4FylnnoNoK0IwNxjxfInC3dS/wJSlPMSw4s60
 ZCI1ZMe55oQmtHmp9opU18qvxmbJZjozwrJr7tq1+Z7oT8RdNZzLuyKLh7ljq4D/O7bF
 10o3bQxD2riJJwQ+6Z6OjfVDu3C0qIly3iFWaoFdO0hJuVaMFpoCYAUl8WdUfokgI86+
 AiTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlcKtj/+kxA+n18/XpbBcgiFbqhFzx4p2UFqcXiunDOchELsVyRpZxkPwJsFqIW1Td2IF4Y5iOpszi@nongnu.org
X-Gm-Message-State: AOJu0YzW4XmTD7XxuAuTa5+yvDmHjWEk9cpKNIXYz3zVV1HBox5H+FG8
 VziYRkhbWVJQuJf3oZFaAw4S5NRcWikO1TnK0gWNPuZtCs8fUcBr8K355ihuVpse5o+YQbgWItD
 oNA796Q8mUez7p4o9oVPt5ucxr5tQOG9VYg/UMPfsUQ==
X-Gm-Gg: ASbGnctVAhnRiOYSbdaOICb9sQOSgFuTEMVmESOhQ9STyDZJq4Oqw06xM9LwVdhrAgD
 S7QNwb8EvL9b4T2qMAx/VNQB1+n2Di6tH1fi0Hrh/EprSHID1c3NA3ENczxdVsn3UZEdsrWFbXP
 K+oV1aaZWcD1F2bx189RaefbACEBbVoXYhqH2Zqk3r/k8MCuc0iXmnfX4DHi0Uj1jjwrNMeFUFv
 fzDcPZVFHrbXObBY3w=
X-Google-Smtp-Source: AGHT+IHoiKpr1AdBA7V0x5qWUApLA4PVNHgItJYrnK1NPBWY66WVkoCK1i9vEkzT396Fmf+gKvYrmrZiLVtdEaoY61U=
X-Received: by 2002:a05:690c:4809:b0:70e:719e:743 with SMTP id
 00721157ae682-717d5e0ea36mr176197587b3.26.1752488390088; Mon, 14 Jul 2025
 03:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250713154719.4248-1-zenghui.yu@linux.dev>
In-Reply-To: <20250713154719.4248-1-zenghui.yu@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jul 2025 11:19:38 +0100
X-Gm-Features: Ac12FXyREpceJQvZUqDKHaRfH2bJqlOUrrnuKpIm5TFeL2LvFUfNGE5_Ptg2Elg
Message-ID: <CAFEAcA8AS=X9QVFOVomFJB=bzsPdxxJS8O9e4rXYXVFb_5hhTw@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: Remove $pc from trace_hvf_data_abort()
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, agraf@csgraf.de, 
 mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 13 Jul 2025 at 16:47, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>
> We don't synchronize vcpu registers from the hardware accelerator (e.g., by
> cpu_synchronize_state()) in the Dabort handler, so env->pc points to the
> instruction which has nothing to do with the Dabort at all.
>
> And it doesn't seem to make much sense to log PC in every Dabort handler,
> let's just remove it from this trace event.



Applied to target-arm.next, thanks.

-- PMM

