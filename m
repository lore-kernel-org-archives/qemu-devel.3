Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9F6CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXUs-0007Qd-GA; Fri, 19 Sep 2025 05:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzXUh-0007HF-Ue
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:33:35 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzXUW-0001ew-HK
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:33:29 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-ea669836e8dso882415276.3
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758274394; x=1758879194; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YlM8knXhiI/w7jplN+fwhCTHl+p/fpTGiqFnGVOApYE=;
 b=Zyi2wMPfdzptAA+BZ4ZHbMBdxdnsUcE+ICv3/kwWp6DZn+umeonzUONwCy6G4cFwj5
 LCpeaAKOG7wcL9x34Q7IYFEgltSAgshs5s03bRMUYK0dXJzqhaO/8V24FYzR9VgEwhw+
 NYuL09YtHgb+F9m3q+wjpQpalctu5lg+w4zyJjLhsp0vV1PVVoncW0szIQGL6N7dC5cu
 AeU8yfRsXrVCP78Ek2LCEtJQzPH/3U/zp1Bo5R48ZhGfz07PE0iiXeDYsy6djSvP+F/Q
 7HrjPL0w8Ljw0887+dj7pJ/RJN7i67Y4bp6uht7zCxHjX4TQMzqPgEipsJGWCrzs17UY
 9lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758274394; x=1758879194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YlM8knXhiI/w7jplN+fwhCTHl+p/fpTGiqFnGVOApYE=;
 b=sG3J8qkcOdukAnn+koWzzVvllObAHo5KCgOu0N95lhZjh1t2BDfy22y22mx0ob9Igr
 xaow/FryvFyGbcE0LISbZdeLfpJjkxkhGX25igGlS64FC+oejIcYUYiu6YUGjP5PMOho
 Uuc7A1jH31jyqO6i4rvth93MESm0OipnxgQtuPYkP4CTbiS9Wd681wDOGWmdpGMnFveD
 6h32njgcyRofsynrLIr+Yrh4EMRKieaHsyP5bJAyOuqVRiCUaQBZbwRufAFSYcCsITGV
 gMtPUYAeCkd5sLVDB4pzs1ux5EMDmI7VgWmKRzHB8NNJXgLaNsBZg17GRzXHNQ3Y8bt+
 qmCg==
X-Gm-Message-State: AOJu0YzpjOvX3kwBy5dkaNT1zU4kiL57xH/vozGMR+1Adgn0u4zRqLQd
 2cTBDEgosKq2CeSagMPzx124zRyPyFuUH/DBfBOt+PDtqbsdiMwXlYSHF6m7cgGgVdAeCyYTNZN
 DO/JHbsRFY0ZznyHpl98d+oATnhEmcccJdz6T/f3X8A==
X-Gm-Gg: ASbGncu+DyC3QgDJLXsj4qQ/Hq+0+ICCSbS0NvvQwRXdtvJ4N031d+u7fWV3T794vaE
 MKBXV6VYWFyHdb0h+I9taeOsiGqaotT1ZjTIL7SaTsrgENGRTUEbUziTdfWbygzYtThZPeT28/I
 vWi4dAkN4Deb/bLGpQWzIn5jSGH/t3WNQ6vN+YCi2VE2scQ4iai4G0GFZqjtF5T49/EAu8UDzI5
 yco+i+E
X-Google-Smtp-Source: AGHT+IHlz0SjeRzDlvHdD4/IJU1n8v3r8+RaWykJcFf4S9oq3GFfZ2VHvhJMyE1x2n5EFOGCyYOdk0B7B19TFUQM1wA=
X-Received: by 2002:a05:690c:7089:b0:734:4161:aa55 with SMTP id
 00721157ae682-73d3b0b753fmr22190297b3.25.1758274394228; Fri, 19 Sep 2025
 02:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250919083612.86546-1-pbonzini@redhat.com>
In-Reply-To: <20250919083612.86546-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Sep 2025 10:33:02 +0100
X-Gm-Features: AS18NWCOXaAkCVZfeaWQEySbRO1vi0QioHDJ3TTD7GNBpWx8836wTrr4gl0oiPE
Message-ID: <CAFEAcA8BBisMO3VJF=bb0a7oQCK16P4NhtTxcWRNRg0yMTWtwg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: avoid -Werror=int-in-bool-context
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 19 Sept 2025 at 09:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> linux-user is failing to compile on Fedora 43:
>
> ../linux-user/strace.c:57:66: error: enum constant in boolean context [-Werror=int-in-bool-context]
>    57 | #define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO(!(M)), N }
>
> The warning does not seem to useful and we could even disable it, but
> the workaround is simple in this case.

I'm surprised this is the only place in the codebase
where we treat an int as a bool...

-- PMM

