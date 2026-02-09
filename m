Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346EAE94602
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 20:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpXoT-0002tD-BP; Mon, 09 Feb 2026 15:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vpXoN-0002rh-Hu
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 15:24:47 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1vpXoL-000107-Gn
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 15:24:47 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6729292dcd7so79899eaf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 12:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770668683; cv=none;
 d=google.com; s=arc-20240605;
 b=eutCrvKjKYmd3BFOyvhZmF9FL762vvgFM6jXTTP2VJS4XI0bMD/VTmCLfUbZOW0T6O
 Ps/2sDCtk00yqlIaicqq3YqtJNcc8RNJhJt21/Q33P3xAk2eZw73qaqXeUk84gqu49YF
 AgFBEE7q9KDgDSR7kDtk9yZ5VrAD0vSnd/hu2GBH0kQU/KiTsK90+0J3H6MKC/urPh2I
 4AQX/5Ij0F/lxjicy7E9CSx3U0qQKATOUeILbK5j2uiBbtUAJ5iZOZwqcL3+GzWETnk/
 BMoZbuWid0kmKVJKoCWDlIi7pzK+O3Sg9NtuJhB9Tv9oPfplo8rAU0dBQO4qfSyen4y5
 7Yjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kB7A/TdsnTPwUeT7NthK2hjc2c0lU8AiZqCUPGyMazI=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=Jqe1mKBDtnMomPe+SXc4KxT4dEkUoiIam/eK6XlmyAc3zAcea9IA9P4+9wcvOBD1/D
 jFAZSn9XOaUwarGV1tQY3D8zKolhaFMjT2EtvJ0xedEbdBkw+cA+qPa/EdlmVikDWVKW
 OSka9O4X0QiDeE17RkMeh6tyC6QoLoQFL4BV7GGTH5GXU42YMQtgH7gElOqXEZdsxUpu
 uHWaUXi4IgO8fQhtnVUFeVPsyuXJGSNPMo1Mr3efUP98526Qu/anXsnKR26XOLCT0bkZ
 AmIpVoN2mhcFx5LOsyaQPF0EojthtEkhoFPs7CE5AtwFpmHeKur8K1R1gQHh8b++b2cJ
 iHHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770668683; x=1771273483; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kB7A/TdsnTPwUeT7NthK2hjc2c0lU8AiZqCUPGyMazI=;
 b=zQkEJr70nJ8v6FDKEuMmok0LvtumI2pR8yN481b3LZxbl+1GaA9mO/N3wZBMzpua52
 yT2NCTJYGIoyRrI6eOyzO9b46bxGjCiUKaF6Gz6fJ4VtnvPxR9Su8TJ8FUs0YSih9bGf
 yh39799QidTNnKVNc1bwB1WHyk/mZJ4NrSC955yNTYOqn6TkboMOrEca9IjXsHDNpSFW
 hk8rWo7K8SMKFBH9UADmgU0dd8XTgcRZ4/7cukgo9I6wiYIkt17CJbn1NwxMnDF6uRjX
 pnA5PSXd17ve4z59aL9CURD4gdSfH4zeMpUgBANi4/PFuPILni7197Wwh0RMKSF/eGAe
 XyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770668683; x=1771273483;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kB7A/TdsnTPwUeT7NthK2hjc2c0lU8AiZqCUPGyMazI=;
 b=Nc/MSrA4r8TKCJ8SKj/DcaCgVgsmL9uqRFWiSmYQ9cAMwS8NXjqQmKO1YaRkypwvFu
 nFyoawoDPj+HL6XqmT2BA4TSqyax1uuyJ8gU2WNMjFLeYS1zAUh8tIW9St7/dxTRYzm1
 r1ColdNJBtSQYCQSCVdF5UHVhDWyRiUXjanWMMJF4Z8iX8wgKhyWtpHWELXdNLhGJjdn
 v4jK1+gMBlJh8ewSoebVIsPXfg1M2otEM+CqbVm1ZN1wi9+MybnHxvKN2DBQem5O8Dzm
 WuQauojbbLd4mhYGd974MlbeV44WQReOwa9rY9akJJhJimWI2OaKB3U0+6nsiUDGiS3B
 MgDA==
X-Gm-Message-State: AOJu0Yzl97oTyLj5UAZd8HojX/px0g00TZCrcg8NnzrTev2W3wocSguX
 tCEzusK8ElZA6oFC+202h8WBNqcVGP++E7vcQXkVbltS3eXKFJSnj2ZdRMusmK88WixgCqd4INi
 Z3fhrrPo1sFf0h/b0LZ9y+RJRNs7RaE9Txs2p51Rwaq7+jrPGCQvq29xQlQ==
X-Gm-Gg: AZuq6aINrsbB46oJ7nPKEbZBDEl04KcwCt7RI1LfkhKbPtVnAKrgnEnuVwTRE9ANDtm
 MnLmL9rVzSCGd2w6gdqq8t2Fsbs6Fs1NOMmdCGqQjwojFzXQhoSj/Zt8r7tQxaSsn7PrWeLgZfZ
 8zM7fkmPoeKjc/Trs6vW8f23LN/bpx6CYamn07yON6FwaWFLMinVTldjcKXucfBozNrl/DjQaOs
 a1hq2k5LFUciMamDw6aMAqWs84f4OwNoe9ARMD65sxCJxFYealKGP34739PcU0sJ56eHjA=
X-Received: by 2002:a05:6820:210e:b0:664:8baa:fcb2 with SMTP id
 006d021491bc7-66d0d6dd177mr6014930eaf.80.1770668682712; Mon, 09 Feb 2026
 12:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20260206214448.22008-1-philmd@linaro.org>
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Mon, 9 Feb 2026 21:24:31 +0100
X-Gm-Features: AZwV_QiIoLOm5I-CXJR_vpCOlbpFAoBoJRzIvqAyiL_QhKJHSNOfG56lzIZtnEQ
Message-ID: <CAPMQPELL23vMPEsehDk7FFWrxNfSjwbHs=yVu4a2Oikp7vTmNQ@mail.gmail.com>
Subject: Re: [PULL 00/30] Single binary patches for 2026-02-06
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-oo1-xc35.google.com
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

On Fri, 6 Feb 2026 at 22:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac=
8a:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst=
/qemu into staging (2026-02-05 13:54:50 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/single-binary-20260206
>
> for you to fetch changes up to 5cab4bafbb8c635c7db6ae1cff8660f83b547c02:

Tag updated as commit e934c624f32f6f44f427d73a2e6a67e983a02ae6
to fix a typo in commit subject reported by thuth.

>
>   target-info: Statically initialize target_arch (2026-02-06 22:37:54 +01=
00)
>
> ----------------------------------------------------------------
> Various patches related to single binary effort:
>
> - Reduce RISC-V Boston tests
> - Prohibit target_ulong / TARGET_PAGE_SIZE uses on s390x target
> - Build target/arm/arm-qmp-cmds once
> - Forbid legacy native endianness & ld/st_phys APIs on SPARC targets
> - Forbid legacy ld/st_phys APIs on x86 targets
> - Rename OpenRISC -> or1k
> - Avoid QAPI parsing in target_arch()
> ----------------------------------------------------------------

