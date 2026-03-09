Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D57EFCD77
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXJX-0006VU-FR; Mon, 09 Mar 2026 05:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzXJU-0006Uu-B3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:54:12 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzXJS-0000jn-Tr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:54:12 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so10264855d50.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 02:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773050050; cv=none;
 d=google.com; s=arc-20240605;
 b=cdD1/AfSERUjLTiO7/9hoBd8K78zaqSjbCxstbz2nxubW+mw7FORLgqQrptj97rAoW
 v9YiNsqfBQTNtOrwgcBuuA1Pi1NoDYHT0C8CKsMEdIoOrTQGV/Pdlm3KcafmEUuFaIzc
 nmcBZdPTFLVjtv/nQiT/hQX0O0YIT13cLDnEzo/Jl82/B0A42QQnTj5OEV8Hjy6MlzBB
 vvoWCe4O2zurqsaXzG2EcSL1wFSTIZzqEbvJaAyn1MLsV4t6MjVsUyk1CpFWiBKGRClP
 3/TQsevN5a5y+qw/uSqm6SgOKaxASBgIEg8jCnlqQDvxq52FWMAqikt2DNIQ56OVm1RN
 ZY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vwIgMZhJnMLU4cIy4f1IdPBcCSE/mnaqk0JMqj5HB98=;
 fh=Kj7pLBmD2+LTJQGMhgccveyKolL/sw8nKAB6x9QMUt4=;
 b=cVMcM2A3QqtbY5O7sCCguw/wCBy9Uf8Vu7E/fhCCIQh2dNwhtvU2E42ClcN704Ea7J
 0dRjehT//yCRvVD5RLzjvUmiJ2a6ylZOlXSDmQu2w7EceMZzTmLfkhJYsy9O3EaoLSwh
 c/IpyJxpE1FZRh7XV7z8fm/9Iy5f+5Q6RiugjXG3g5gXQ1Th7yafa9WHxAFyUwD/ANGK
 3vysXg7TdoQsyRShAd4qrjI9IMx7QU/c7USlfNROhZsr8uLnwcHWJzT+FkvVB+4JYrFP
 lmRPNqTDLpeI62zojgoB9+l+oFbtEroEg0BKtp7nAzEZ8J7zqMe+8CbAU/GNMVXyChPJ
 1Lsw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773050050; x=1773654850; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vwIgMZhJnMLU4cIy4f1IdPBcCSE/mnaqk0JMqj5HB98=;
 b=lERlDHPSJ1mlnNkDu44akodL4IdTApEPPWJr9n1zw4m+TsHaT6VFkeBoywG5ddbHpz
 hTmbFu+oYwm3AsWtBFDpcn7pESOJwnAI/fI19dFY7TL2waqD/eqZ5Y6SxiUOxrbOCf8/
 mmy6Coy7Ct/bgQVs4OHrcC/Jk1SqMTDJeK9xU//z0rKJYCgEI28V6jAPLwdKHFE1EK5P
 4pVdZD6Uk6XDsLkFwm9wfZ/d89hPknwMqUjl/zTx/Wxf2RAOB382GgnrYU8ULkxBsjfb
 /q6cH3JGjbim/+vtCQ6F1qI/U0ZaUp8Qw1wxGivCc7Hr7ZpoV8OnmDs5vKcupUerLG6y
 uUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773050050; x=1773654850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwIgMZhJnMLU4cIy4f1IdPBcCSE/mnaqk0JMqj5HB98=;
 b=OnEPO4ivYCaYeQ4fgo43GSlxtUXWq010mPh47/7wo/2IJVpsbyIWQXhlD49TiRJQ96
 iqpg3aRYI2H64KOxaCtCdivAazvHgm7lAxNX2eSS5j4Xy2e5FuyeTUF7SwbDjRNoBvzW
 DMce/0VpPKhB8rCk2JhL3In1TztAJh6T294JYf9KIQlqBBtSqoFAFmFmze9vDIKkINm3
 N/btd0k+zn2ZTwlKRXduoBKY89+E3ohLABJxIgcgIHh61ZOMKwJxWUaCTvLxgNBk+CHT
 Qr0y5RjINNnjGYUGM6uuRblDi9W8HFZD1na2hpIuJj429BgaVi3sqVJ4sdGo3XQcU1i5
 rrQg==
X-Gm-Message-State: AOJu0YwYRuLQtHm9bIds00bMdsdpuZj8ygfyiDXiQqoteJPf5/s4LRE5
 WIikKqGS5gXKXwY250GI6imxqYOCDUhjO72JoFhHIc2csdNjcrL+RZNb1rQleeplB4Ul9zXA/NJ
 Xr/qX439Xsa0gKWx+6XKFzlJxkfELiYaQtYIjwRLFPZRloF/axccK
X-Gm-Gg: ATEYQzyd6A6Q5/8WlsfU0TZoJ9K6+b5J4w7bXsjO+rGGTHePu+U2pPv8V74mvWk8ONf
 F/EKC+2uvbb+H9ImD/hBSYWtitcSstID5OP5kq/t1zVTELpQpJm5otpmUBSH9dFbxL05sT9BUUh
 PDqA7iq3kNm/Sxk1ZZQh27ZKoB7Z4bzSPoeHn4W0G5thyH5o8ZnZJD3u6VcygiPqjuUHZHae6Db
 NSlmIF6m43kHBfIrepEIUhV9NyyoHB1oFPEjaOKT1/NFG4UGcLXzJaySEXtyaIpy46I66eUGlXR
 UcbmIoprs9alAhhyWF+9Nf1PJY/4qWHQJBS0Y53STQfBOHOyFkSTEzQR4drxxqmTlO0=
X-Received: by 2002:a05:690e:b8c:b0:644:444f:3bc2 with SMTP id
 956f58d0204a3-64d14112917mr10124425d50.22.1773050049748; Mon, 09 Mar 2026
 02:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260309095328.1406779-1-peter.maydell@linaro.org>
In-Reply-To: <20260309095328.1406779-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 09:53:57 +0000
X-Gm-Features: AaiRm514kUp2kFWLY70QCpkxPJg-2l8RihysD35jbb1MUqPDfNC5UMiryr0bNHY
Message-ID: <CAFEAcA8x70ruJzSXhSo5OentZnTgsh4xnZmqL3h9+1EcFY=z5A@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/riscv_cpc: Free CPU array in instance_finalize
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 9 Mar 2026 at 09:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The TYPE_RISCV_CPC device allocates an array in its instance_init,
> but does not free this, leading to leaks like this from QOM/QMP
> introspection:
>
> Direct leak of 512 byte in 1 object allocated from:
>     #0  in calloc
>     #1  in g_malloc0
>     #2  in riscv_cpc_init /home/pm215/qemu/build/san/../../hw/misc/riscv_cpc.c:175:15
>     #3  in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>     #4  in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
>     #5  in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
>     #6  in qdev_device_help /home/pm215/qemu/build/san/../../system/qdev-monitor.c:313:17
>     #7  in hmp_device_add /home/pm215/qemu/build/san/../../system/qdev-monitor.c:1005:9
>
> Free the array in instance_finalize.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/riscv_cpc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

PS: this file isn't listed in any MAINTAINERS section -- which
section should it be under ?

-- PMM

