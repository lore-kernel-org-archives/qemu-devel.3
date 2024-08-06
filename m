Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B64C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbIxT-0000qZ-Qb; Tue, 06 Aug 2024 08:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbIxQ-0000ob-Jf
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:06:28 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbIxN-0001Cq-J0
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:06:27 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52f01b8738dso718583e87.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722945981; x=1723550781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qnVBfqlkOxhMSKyH+fBWhpF6qHnvq20ApNiTBfcsfRI=;
 b=ZHQZjdhOuONSOpgwL8MilB7tH+tOlEXGCUmNIy5vIFI42ARTzHOjFuh180likSvOHQ
 j9OEOpOkX1Mxbwri6T/109fKhRNDKL8nh1IxPiB3hFVjo8SzunN7d/o6FWmfNBwy8hj8
 fZK1/pqx+D4ywIXqVY8IJAZcESl3cxZmKfLHF/4LMIODywZfsVVmZA8sX0Evd8oMlSfM
 pqxg07+UTkI831Zv6V5gEKKULB3uVXM6mQMnxwtQ3wpbYkfg3+DjkWuSsi/yPQlc3L5e
 CbHOApJBaKxaXXm7QUwVc13Oy82IbQwLrHlYDg/Zhs24tDQGUPMolM/QGMt7gPyd8m21
 plWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722945981; x=1723550781;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qnVBfqlkOxhMSKyH+fBWhpF6qHnvq20ApNiTBfcsfRI=;
 b=YsdqhXkPi5bJP9BczE/jwmnMmXCFYzOry0PU4QNTzqXndibEdRT739aBr++OFXriI3
 dDDkY5vzEf/fKOnfuYxxiWB6wg1NpMWx1U+95QzBXRIZdXe7j1zmAv1+Oj94/xSwV/Y5
 r6Xoib0kvP7g7PrJGgG1ZvQNfBUE8/yAgQc7O0bg+wX67G3W4AeKbann/MG4rXl2SJjv
 Sc85PyKDD8Nn/9NX0KW44oCuPny9XKw7lnz4Ayw8NmzxbQxKwh+NzThSbWKY8xIacHF9
 Pdn+NXMLzmgxRUKF8BzPcIMOMH/lLGAhbCWbHpZsJdBQ1pmdQDQkqM2fHE34ON3cBvyf
 ff+Q==
X-Gm-Message-State: AOJu0Yz920oE9UMJGjC7fl1b26f5KXsRNFei/KzNwoQqdMpedYNW7YAz
 N1mGgMZabClpxEFXncx+kqG/CvjiC/Yjo1J2V2pJOuWiJuRSeGRUYsV8bwiDmlAVxMxrDab+L6/
 I
X-Google-Smtp-Source: AGHT+IEZQSOY21Yo1IO4stUgdUHYBB0HcKxc3a/rSD7YtEwCcdPvTxlAYVsRb0OoEoziP/4NQ1Thpg==
X-Received: by 2002:a05:6512:3baa:b0:52c:dbe7:cfd5 with SMTP id
 2adb3069b0e04-530bb387535mr9570809e87.32.1722945980658; 
 Tue, 06 Aug 2024 05:06:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d89a8esm552168566b.144.2024.08.06.05.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:06:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1432E5F8A1;
 Tue,  6 Aug 2024 13:06:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg McGary <gkm@rivosinc.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] Add plugin bbvgen: basic block icounts for topblocks +
 simpoints
In-Reply-To: <20240805161951.2701529-1-gkm@rivosinc.com> (Greg McGary's
 message of "Mon, 5 Aug 2024 09:19:51 -0700")
References: <20240805161951.2701529-1-gkm@rivosinc.com>
Date: Tue, 06 Aug 2024 13:06:19 +0100
Message-ID: <87a5hpsvno.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
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

Greg McGary <gkm@rivosinc.com> writes:

> Tally icounts for basic blocks. The data is useful for producing
> human-readable topblocks reports, and for creating simpoints to guide
> accurate & efficient machine simulation runs.
>
> QEMU's The Tiny Code Generator creates TCG blocks in a way that is
> expedient for JIT translation but does not conform to the model of CFG
> basic blocks. TCG greedily translates straight-line code until it must
> end the block for one of four reasons: (1) page boundary, or (2)
> maximum TCG block length, or (3) CSR-hacking insn, or (4) jump/branch
> insn. A single TCG block can span multiple CFG blocks when there are
> internal branch targets. Multiple TCG blocks can constitute a single
> CFG block when the component TCG blocks terminate at page boundary,
> max block length, or CSR-hacking insn.
>
> The bbvgen plugin normalizes TCG blocks into CFG blocks.

Are there any tools that consume this data?

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

