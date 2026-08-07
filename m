Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9A9C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsNBv-000545-6l; Fri, 07 Aug 2026 12:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsNBq-00053N-FD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:12:58 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wsNBm-0006SX-Oy
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 12:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1786119171; x=1786723971; i=deller@gmx.de;
 bh=7ZyKrK7/AdIVzL6tYFv22qrRBIySWi3rtkLq3KWIE/I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=U/nJl/4YBpZsr70mtjHj6NyMzFPy2YtLa+5Q6qTrZsYwdfIPEvp9xRbb+g4Kj75l
 R9FmYZHjwMYkRgvuM66pyk0RHnOGI9TUT4cxJARcxq9sMkoENXvXVXbm++S2aZoLM
 PosyPSogbohNzleaRC1uvHo08zwiOLN30ac5ubNpSEw8Y6kFcDGZ+kh+MOcYq9tOG
 yNVEDSPsCMGZJZPS0++0vuI7/BHCOtxNjx1F0xzOQo0AM7KQAfPTmYs4nnkNjZHWV
 8C94UTfKnS4qBzHhbOVuR4kVROJRHbqR/ZyEEOJPQPRRETdJ5YOXR+a1oVYxWgtu+
 UYx6ZCCaecMsKdDwiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1whxKv1vgU-00GnLv; Fri, 07
 Aug 2026 18:12:51 +0200
Message-ID: <14232d35-cafd-4d24-9607-0f390c9626c4@gmx.de>
Date: Fri, 7 Aug 2026 18:12:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] linux-user/alpha: write the floating-point registers
 to a core dump
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260805171507.3119442-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260805171507.3119442-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gd4jcAyAIN998BRpcY7DxgbQvBuHWKVnRwkxEr0YLDhvoNHKUW4
 vTRj12RxQyLY/5PdXOkuNbSKtJWnFW0ZVp0VbmdLqH6B1uI0fUUxCniZ8saz9bVtkswHPcV
 PuU5P6UIF2NsG/lf9bseqPK6QiRRXHPTnT9Pt075fzkDem818rUrvRRp9KQX5cq5rTycBen
 sgV1YPaO8Uu7VJgwsEVWQ==
UI-OutboundReport: notjunk:1;M01:P0:D45apsknuac=;uezXELXzCwyd1UmAqTOlUnk8z7k
 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
 LQmCvF4QSUHzQXi5Ooc=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/26 19:15, Matt Turner wrote:
> A guest core carried only the general-purpose registers, so a debugger
> opening one reported every floating-point register as unavailable --
> including the arguments of the function that crashed.
>=20
> Implement HAVE_ELF_CORE_FPREGS for Alpha: define target_elf_fpregset_t
> to match the kernel's layout ($f0-$f30 plus the control register in the
> slot $f31 would occupy) and fill it from elf_core_copy_fpregs().
>=20
> Checked with lldb on a core from a program that faults with live values
> in $f16 and $f17: both read back correctly, as does the control register=
.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/alpha/elfload.c    | 10 ++++++++++
>   linux-user/alpha/target_elf.h | 11 +++++++++++
>   2 files changed, 21 insertions(+)
For the whole series:
Reviewed-by: Helge Deller <deller@gmx.de>

series queued up for past qemu-v11.1

Thanks!
Helge

