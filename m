Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4000FD2D84
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxBY-0003Fq-EB; Tue, 10 Mar 2026 09:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzxBW-0003Fe-Cf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:31:42 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzxBU-00081n-F7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:31:41 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79902e1fb71so21731977b3.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 06:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773149499; cv=none;
 d=google.com; s=arc-20240605;
 b=KpBf5hlvtwPeD1k+U0jUjWQzL4aULSALvXSscdLODLHjXZBW3QVSKgBu6JnCHW32mx
 K6WLM5lsqDaSo/Ray2lW+FuqSpWJ5f1+HV6zwa7vG/qXwgmTyMmzzztCtzXSKLJhyaX5
 WuEZ9UXw2fZVJ4f2Y5KYvkfe2wa2n0/FtSeOVY6Ddc1TJlI3kRTQLIvLAzE/4dSBNzWJ
 q0ngteK0wM4/eR8phloeDRAgPrnJVs3ugiICTNDDIIe1cFn5s5W0hlgrRqQiVl/yWTI/
 e7OFbIT0V6zduPBw6iI0qnCCizYN0n4q/lB6K9rwsAtdINuzcUwWnvNxwlJyqVQygrl+
 42OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QmsG94IcMQ+kDso+MGBEBxU9skIvCShz3G8NDv+jl4U=;
 fh=gffcMCOUXtBOrrjZQMiDLavK++hmBvO7zO0yh09tQqI=;
 b=cBEE39/nPallrhRSdHPk3Z35Tn2SmMPySc7VQF/+dbAnsIu6cRKpH/Ptf5bJRfFeO+
 UVIGuKWQNB3f/CM6sVePHzpgaBfg4wc2mSRoGKwOouO+kUunIlK9c4Rr+CyaCfw197WW
 7W6EKhw6A1u7Bn2WtLKoCLhCVMdtchPLSjQfQDGNqvPx7vYxSIelKGUpf6FyEa6cHvKq
 hZF/r8Ra3mMfkCUqgOCygg2tc9wlCLmJGM4lWDz/LZ38t6jCxATsoxV1gF2EZ5nPpDPI
 fXthoA91EGwBD6gkcrAPaZBKrALqFyL/eaMuSx0ikACukEGmgC38Aidz1DS0MVZfpVRo
 wD7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773149499; x=1773754299; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QmsG94IcMQ+kDso+MGBEBxU9skIvCShz3G8NDv+jl4U=;
 b=lKYTbfdytMcGNlr6qNAEKw0a1AuKKyiBE5KAkpoZfN6/zvypaw8itw3WjPTy74q10B
 nJXp5kLYBF1DZS+WSYnlCMTi/xmhdG/Sp09x1zg0k4bE88vb3rKpTPZx9g51prpraYlk
 uPHSANHh2KWmnFtQUfpgZ89nanGinvsC99d7beozdEWWUj3eW+wePzQhIjwXKyT5ZK5b
 a33/3+/SVBdkDbecMbCyeFTwGwGNUUdufuOkFW9kHx8eSWiNmLhKflxSgdPldAvL4YI5
 GFFrjYIjElLqm5gdXcVBxt811WrdAoGmSnE8cZI0fEy/7S6wnnl2rh0oo6YYvC0jgeG/
 cm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773149499; x=1773754299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmsG94IcMQ+kDso+MGBEBxU9skIvCShz3G8NDv+jl4U=;
 b=Rma2D1WgX7IyPQzC5ORFY8HRu9EQvcNtzA/Ez7p2Gkj+1rfXC7JbqFciIV8g4/r98a
 f44Oki1Ce+VvFG1vysXfyYh3zcIbM1o1Y5LYYcOjcXac+UnUDTHPGBpjfWOZrET7qhlj
 sfKcWgD1Q7p4tDptnJ0lg7x07FPjXijMkUHmRtKEOSiStXkK1CrdOEvvFiI8ja8RuXdP
 U/G5DnpcqiZMjdAKbMoQEnY6n12cgDQKSTdOicK8uzML+k1lAtmalRVa1BHUos/ruo/E
 +p0VtlJxv9wPwcX0xl/zot2mNaE2tckGhsLRo/rdPRB3wr4Fcc8Yql/ZPrrCuabcPKIY
 VJpQ==
X-Gm-Message-State: AOJu0YwRdcqzdsPWGPLPmjAlTvmvveI1Q2EVlKLMWo1zwmQHKDUCuqka
 pYfUHOE6atITxIdAHUj2iS/D8ytMvFI/+NZukUWYoK3h7/D8XXRHYzDv83LrJXqPEQi5sTupDCb
 rvK2XzSeRgwOgGsPORviTsUuNUXnUWKlsl+m0QeqtaTbfMk1/pE2R
X-Gm-Gg: ATEYQzwC7UZyY+nd2ZsSEBo3tKRN66nk+xmEdV7iT4qa35bQ9DVa63CCB7uKOsJzReN
 sspmeKv4nM8lt516BWHJINsqfh9LpDPJSn0QfiLArr3pO+N3l4436x0Szr4N1o48b06Dg4Q8RPs
 c4vbCd2+4M7xKvDiZ12E27PI8/TjZv1LVoPIKNVQojOvQpNY+0tyoJ0IcollJ3Lj/Z4a6yEglji
 JQpxgUlr8pfME8ww9VckyvmmDZZ25+nk3R8B7nDerv44MdoDsPVe+Cda/NNd1LzBUEuXfbdRfZn
 qHB+Hi6GUqNlTxKd75LLwhV5LyH3/mwDJ/8MQ4DTtFsub3f7JgGZobDpLpTm5JzkLyI=
X-Received: by 2002:a05:690e:6cc:b0:64c:c616:c349 with SMTP id
 956f58d0204a3-64d1418b37cmr10736342d50.31.1773149494614; Tue, 10 Mar 2026
 06:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260310055530.8893-1-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 13:31:22 +0000
X-Gm-Features: AaiRm50R8F58zQ6X9Xo9h4s4C8v3KqF1a9aDfMwj8zJmebC7deXi4DLoGvv7phc
Message-ID: <CAFEAcA-t7r5pQrZ5jY5CJ8j+TVFhgEAW0EhQqkH_WDU18sT3VA@mail.gmail.com>
Subject: Re: [PULL 00/25] s390x & functional tests pull request for the
 softfreeze
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Tue, 10 Mar 2026 at 05:55, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit de61484ec39f418e5c0d4603017695f9ffb8fe24:
>
>   Merge tag 'linux-user-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-09 14:53:42 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-10
>
> for you to fetch changes up to f2bd9693f22b105182b0bacdba390a0e41b2cf82:
>
>   pc-bios/s390-ccw.img: Update the s390 bios blog with the latest changes (2026-03-10 06:46:45 +0100)
>
> ----------------------------------------------------------------
> - Improve the s390-ccw bios to be able to boot from virtio-blk-pci devices
> - Rework migration functional test to avoid a problem in the ppc64 test
> - Disable functional memlock test for asan builds
> - Some other minor tests improvements



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

