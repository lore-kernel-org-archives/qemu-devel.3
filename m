Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F4E109E557
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5e7V-0002fW-H5; Thu, 26 Mar 2026 02:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5e7T-0002em-U1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:23:03 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5e7S-0000k2-Af
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:23:03 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82c2239140aso240687b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 23:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774506181; x=1775110981; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z8zhMRK1D9tXS3RSuCcHKGiUSHxt9Dbl66Woarml9aY=;
 b=ApJ/qeWTtWKneoAgz5SW0sjED3WyfQf3xc0YkLmOWD9PYoaR+Qnz/Iqn2B1etjaHL+
 qnhlCIPNMm1d7ldx66wkq9WpHrA6XuyGV71DG9kLsdQrtN/WPslxnE6gqGE5GjxEUdWH
 iZNEXfxSbMfEhPkqq5ELX56NZxsPJDdMriZQ7bMUnVh2sqJbvNO77gJk7Vx9dkrQwNQu
 pixCz2WDuR96DnA5Ya8L1JtWo9tRd96Rlc6CozdfzRije+0bCsM6Q1Cu2LqyP0dik/5A
 Yl913uPm/AQOEFSbbtCFPNVrVhiF7joWZRt8CyapMxa3H8IATEhKQa/EM5S+LV9o3aqy
 ZvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774506181; x=1775110981;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8zhMRK1D9tXS3RSuCcHKGiUSHxt9Dbl66Woarml9aY=;
 b=hzRUtmSiazFqkfUQruDTtflK3sOkx6RNCcFDtsfbCIiFagsBkVvXYkgb7zMTiNKY96
 Azro2+cwoDtF58VHsAgkHKEBBJ2P3OSEwcaAue2RfiRCb7RX4e8col9kyZdQKbbWuIwE
 /UfPdaWsdQLXnFbcD8LZ0E+MugCXsdKSYqDe7+eiOW44bcZx0BuWRSvDOHOgKBI/2pRa
 vlZpnuQGaL10/IrrueKM38IGHq1qNr7Mrzu4BjxZLzYQ5Ks29eWcpVWQF+vCLyPmCJW2
 zNWEa8f3HVaRALaCF9eDNdiX2G9OKc18Ozw4H6YHLnnaJxDcPmVknCgy1uho+sMcS7xA
 vRNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3VFAx2zSvs1mpLo02kJz6XU/GyiP03AwKGYNMj6ShnLG7cz4KanAIF28Sr4E1U2Jxkuikrij1yE5c@nongnu.org
X-Gm-Message-State: AOJu0YyrHz9FRLHfNWWMIUmr70dKQioeqC1tD/X8V9eweRhB2uXwAUAo
 nqgFW2ZoIJfC5pYRSSwu2gtwbCrgW8B1ohHOtRhuSuW2F/e3dJ4w/AcP
X-Gm-Gg: ATEYQzyoQtygkjmNSxxxmKMajwqbkjnxNFRu7cX5bM4muJGtqABTmFuuE86gm8Vhii+
 sgNBk6WxpypVuFyHsz8vGWqm/DECyNKMKnmY/IXTlkULcSBEV7W6nqk5Hsl7RUaPj0evd/+/hL1
 eF2wShfm+S2mbnj5aGD+RAHYbF4oWRsTLE80V0SASgwhMXjKMv6Jbi8AEpqDUSnQLPMjhkrsrM8
 FR0CpjcY0lg9yHQom6feygLzd0Q6KpLJhuIONM8S7T9IY+mopXYQvyg37CLxbRMMgi6TiWmKSWa
 muifLwvFVmkg4P12PsTpBEAqsr7SRFU6m/vDsUHCz11Qeil/sH2zSjLEy+JmeEckRAIc6yKI3WR
 C0Ru5JVpw1RHaFgtEoNlrsutjjlwv2oJfGxPW+pKOA8BVfQMmzzBvDXMQy6EzX1XyOGEhTykNYU
 XziEOM597qER9/LMJQUXCLCTq3ghgo5NvjDCEL8BYwSTOdaEGRs1O2wxE1Jy1tyMlF6YpL5fSuv
 bA=
X-Received: by 2002:a05:6a00:3a2a:b0:82c:24a9:d5f1 with SMTP id
 d2e1a72fcca58-82c6dfb50eemr6173269b3a.30.1774506180743; 
 Wed, 25 Mar 2026 23:23:00 -0700 (PDT)
Received: from localhost (103.95.112.190.qld.leaptel.network. [103.95.112.190])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d3f959esm1550263b3a.56.2026.03.25.23.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 23:22:59 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:22:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3 0/5] linux-user/riscv: add vector state to signal
 context
Message-ID: <acTQfgIzWONvJ6c4@lima-default>
References: <20260321141345.599105-1-npiggin@gmail.com>
 <CAKmqyKNmYtA7vnp-VLBWQeRFFi0GW-9eV+Mt3wNAPdEYe+UEzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNmYtA7vnp-VLBWQeRFFi0GW-9eV+Mt3wNAPdEYe+UEzw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 25, 2026 at 02:45:24PM +1000, Alistair Francis wrote:
> On Sun, Mar 22, 2026 at 12:16 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Changes in v3:
> > - Fixed up a bunch of good review comments that Richard made against
> >   the v1 series here https://lore.kernel.org/all/06afcbdc-28e2-4d13-81d4-26fd257ed8a3@linaro.org/#r
> >   in particular:
> >   - Restoring vl/vtype state using CPU accessors rather than stuffing the
> >     values into the registers directly.
> >   - Fix ABI types.
> >   - Fix some confusion with host/guest pointer mapping.
> >   - Fix error handling to SIGSEGV.
> >   - Style fixes.
> > - Fixed build issue without riscv intrinsics header.
> > - Add some more test cases.
> >
> > Changes in v2:
> > - Fix 32-bit compile
> > - Moved sizeof_rt_sigframe change to its correct patch (patch 2 is the
> >   one that extends the size of rt_sigframe, patch 3 is adding new
> >   extended state to the frame which is added dynamically).
> >
> > This series adds vector state to the linux-user signal handler,
> > and adds a basic signal handling test case. As a sanity check, I
> > also verified the signal handling test works in the same way when
> > run under a real Linux kernel.
> >
> > Thanks,
> > Nick
> >
> > Nicholas Piggin (5):
> >   tests/tcg/riscv64: Add a user signal handling test
> >   linux-user/riscv: Allow restore_sigcontext to return error
> >   linux-user/riscv: Add extended state to sigcontext
> >   linux-user/riscv: Add vector state to signal context
> >   tests/tcg/riscv64: Add vector state to signal test
> 
> Can you rebase this on the latest master branch?

Will do. I'll give a few more days then send out updates. Thanks
for the reviews.

Thanks,
Nick

