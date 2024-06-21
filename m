Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C12AC2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiJ8-0006K9-R1; Fri, 21 Jun 2024 13:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKiJ4-0006JD-NY
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:44:18 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKiJ1-0001Tq-Gj
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:44:13 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52cc14815c3so2414028e87.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718991849; x=1719596649; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7M2XzSuVbhnGyP9wJclPlAA+jB/cVXBrm6QIWFe7Mto=;
 b=tCgPcdrf3KIJC5+CD9eoatC8Zf7aDJMb4ANdE6KJ8YD/Qqi5FZ6W82HMcwvNlNTIvI
 Sg5ySyvfXV9Ibhs85Uj5Q/AnAiSrfQh9GO8fA4M16cxtfh34b8hjeXNQ50xMQWiJ/iuj
 EaKdMb1V3sruzLRKPCRFLqgeT9R0GnBUfBYbyODK8Xa6S9rjrYZfwpyn5olarONkXH/z
 1dxhInDOzwXyuOvy24rMwWhfRfnzmSXdHxUvhm2xFLuNX85HrruEnrmIrwJF645CaWiI
 6AY1WN4Xcy56hKXvzZw+7ia9KrfLe7ptGvhxw3nXwrQCnNU/zSd2mGXycMCXPydsUf+7
 adgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718991849; x=1719596649;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7M2XzSuVbhnGyP9wJclPlAA+jB/cVXBrm6QIWFe7Mto=;
 b=ci+gFxyXrkOzGQflO1r6wC6LHFjajrar5sVBz60vYNHCi9pkBvPny3Xf9vQTdCHgoF
 s3PlDlj8tt50cyvypABxC4/7+rsGbGnrUfgXud3ThwhyiQrr9BDFjzMd9+fAnmpN0zOm
 c/bC/9GkgbFAEQWngneMEGSF8NVshR+6oRyusGF74YYvtM1GwcK0QgVrTBU2XnMQeZtt
 nKPTZuxVHSg5xnCfqai+5Tam/bCQj0FGpz8LwDmePNBWclo5Vqd7/vO9PLp3zMd0qGC7
 9T68kAMMd8q5yUiPn4R3ihFpjf1go8J6hwzT3fWrhA2oE4Ujarkv6aiVk/qw/+4Aj1Xd
 tYow==
X-Gm-Message-State: AOJu0YzOvrkE4lKmT0hBjVYxjWz8vOVsLSZZ4RiqbeQVjhWQeT0PgR3a
 WVZ3axMS9U0OgReIZTFtpXnAQvCkANWup0sNDjOvxIrFgu5Rfsn1EK/v8GAUx/0C/dC54Rr5Tt3
 DcjyQCLaqID5g8jHvJHeFjLFWxuOdpRhjzDWEAQQ+fxsvk6mDLR0=
X-Google-Smtp-Source: AGHT+IHM8tTD0cBfsy1j133uAGWjJVRLqyA3RDMlRdF+cKAhtf3mkgZ47pEaJViV2/l9Xib5355Rvbbjnx0STdMYC0c=
X-Received: by 2002:a19:2d0a:0:b0:52c:a8a1:69e5 with SMTP id
 2adb3069b0e04-52ccaa32a2amr4839291e87.20.1718991848358; Fri, 21 Jun 2024
 10:44:08 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 18:43:57 +0100
Message-ID: <CAFEAcA94twaBSx--NVXQcRBQ7v9TuK9iTq9kTWP4FYpRzgPbBA@mail.gmail.com>
Subject: command line syntax for connecting a chardev to a CPU
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

Arm CPUs have a "debug communications channel" which on real hardware
is basically a way to talk to the debugger on the other end of a JTAG
connection; Linux supports using this as a console. This patchseries:
 https://patchew.org/QEMU/20240614093026.328271-1-sai.pavan.boddu@amd.com/
proposes implementing this in QEMU by wiring it up to a QEMU chardev.

I think this is useful (among other things, it lets the user sidestep
the "where is my UART?" question). But I'm not sure what the right way
to let the user enable it and pick the chardev on the command line is.
Do we have any relevant existing precedent?

The patchseries has the CPU look for a chardev by ID, so if the user
creates a chardev with id=dcc0 the first CPU will use that, if there's
a chardev with id=dcc1 the second CPU will use that, and so on. I
don't think we really want to make some ID string values be magic,
but maybe we do that already somewhere, and so it's OK to do here?

I thought also of having the CPU take a chardev property, but then the
question is how to specify that on the command line. AFAICT the -cpu
option (a) requires a CPU type first, which is a pain for cases where
otherwise the user has no need to care about the exact type of CPU
because the machine model creates the right one for them, and (b) for
the key=value properties in a -cpu option string it will set the same
property value for every CPU in the system (which obviously isn't what
we want for this chardev).

We could make it a machine property (so you would say eg
 -M xlnx-zcu102,dcc0=mychardev -chardev stdio,id=mychardev)
but then that would require plumbing code in every machine model to
create the property and set the value on the right CPU.

Do we have a neat way to specify per-cpu CPU properties that I'm missing?

thanks
-- PMM

