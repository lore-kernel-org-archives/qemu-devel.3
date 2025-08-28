Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB10CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgG9-0003dm-Fm; Thu, 28 Aug 2025 13:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureB9-0003F6-Ob
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:04:43 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureB7-00049u-TJ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:04:43 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-72019872530so8670287b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756393480; x=1756998280; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NIM20JULGnUqG4/Jb7Bof8QPTqrfP/KEKGJYBU9kd38=;
 b=Ne/klZOnlX4DqtephNhGwghyj2tRLNSSVg7PRcG0ZQOUPpYlY/fwvUVGAg8NI1SxcJ
 C0IeGDA5+pzzXbyCDCpgFKDbuVN9q/nPlcRhWJG/Xqo80uz5cp/l3vubfqIr5hUAYj+V
 2q58tWPidg3ksFegP9q90l9a+toXe/nqgY9jX6AzkojnVPJP2lzHCwgP+cjewR2M/oCP
 PDYwbaOESEeGTd+R6f1uBnlXpXMDNRvrKqtf/PiBbIwGDnJdezAsNtq+ef1uHuqHWDc1
 ahWI9eukikwJ3aU6z8Kig54h8DgPkoMiK7JX19l0aitulrGLqQwScw469qsLnFI5vIXi
 9kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393480; x=1756998280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NIM20JULGnUqG4/Jb7Bof8QPTqrfP/KEKGJYBU9kd38=;
 b=DiOsQpar5GLaeYGShwXE++ZCPp/CDSAAEaC/9lqkdkJ8nv7qEZ9LmSodlUayhqqi/A
 QvTzHr8lf65Oxcqzlh3Zl2Q8jTHsoSojyutJgvv3wGypw3ncS8Ygk9FU1RDd/nH8dgO6
 QBH16LC5YLJs5+NC6wmmJQryO0wr49SAAUHU22QUsK0aiUrq6+yTGgtFr2e72+QOZMP/
 VQy7FOGjGVjxHNBTILJRdh4PG7j82+Ac2fEOAA3FEX4NC3jDLuLcDqhgeWLzQkQMDTL4
 XdGmGyGT4+dFNw+0woTJ4KCYsYmsdhEzWXwTLCRpiBalZcc29a+ouGRC4LEFCrDgR+Va
 pZMg==
X-Gm-Message-State: AOJu0YxLiVDaSt2dTJ0l/EhPZ0ugM3vGBgDqgIAk6jhhiohypotFxe6Y
 Q5z6V3w5RmfAJCtll/qkJ3YUIqC/PM0l93tW9J9xr9WkKRwD0NjLXI/TkvDAjGmTIk6v3unDQtV
 qH71nqVH18Vps1JBujqzHex8oAg+B+R092wuScPzyBw==
X-Gm-Gg: ASbGncsfj9EY//4Kn6g2bfcDcTFt4dulGDGBmRowlgxonNcRLOKLRc43CauwvvlamlV
 9C1JYFja/qImpYVSshxZGryFj3UtLpq3Y+RNEIKux/JTj3fXwM4QAb+u9vPpBEL58aBknzYH3sk
 OF9jl+pgdXuMWIINQTezqjm1mTVvUgV3JTjTQEF9aGRJBlpUNBFyWYW61KpxvqQ1je1lEgMWCJO
 1yW2aHr+oLZtMGGRKI=
X-Google-Smtp-Source: AGHT+IHHgcFJILq8B/7aiQcmc72R/9qjRCtgVjjfJ1uWVRv+XyZOqLHFPhnmQ9dCs7kt3jmU2hFoX9hhqjRgTMVUNYU=
X-Received: by 2002:a05:690c:892:b0:71c:149b:86b7 with SMTP id
 00721157ae682-71fdc30ad9bmr300196717b3.20.1756393479522; Thu, 28 Aug 2025
 08:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-48-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-48-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:04:26 +0100
X-Gm-Features: Ac12FXwgedTSUv8PTx0R11r_XL4NZwJU5Com4N3USh6HQEQSC0YbSdpgkt4IYK4
Message-ID: <CAFEAcA8GodVdKJayYbDjOaomojLAHbYa5U=AYRHK3=G=yKz3-g@mail.gmail.com>
Subject: Re: [PATCH v3 47/87] linux-user/openrisc: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the target_pt_regs structure from target_syscall.h and
> rename to target_user_regs_struct, obviating the comment.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

