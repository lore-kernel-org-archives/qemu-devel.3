Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD83DCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDi35-0008TM-QQ; Tue, 28 Oct 2025 07:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDi2v-0008LY-TB
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:39:26 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDi2n-0004za-HH
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:39:23 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-784826b775aso66668847b3.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761651548; x=1762256348; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vWz1wjAUcUO8dzSnLsMAab5s/DVpHJWu2/n8Ei85kFk=;
 b=zXad2gRUYnypGQk+tXyY3LC7rr9wkb0SQB1ywqi04Rk0H0NUFRE4LRsa1ig2nBobz9
 UgS3c77QmtrUhTlib+dxphUoWXmLPvzSO/T4VVaNusemAr9dSw2YrpIYbCQXBdUr5TNA
 gIl570ECJR274a0a0Vlc4DVJhm6dpOsKq1IhNwrpnJWruZt3+30yPC8JdiqCzVPKShpV
 lnzUkNHaT+iwlGjBQ7a4r8ehnhqXWJNsw0pqRvjuPs6jAFJBqLsHEvjtKEBbyluIEPHj
 21sizbsOrtz2gSMQHjMMICVuQWUtP/mGdxJWqbOyxA2VxwrjKvWbPo7sUTx/graSjUS2
 JRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761651548; x=1762256348;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWz1wjAUcUO8dzSnLsMAab5s/DVpHJWu2/n8Ei85kFk=;
 b=EFsQ0kDwLY7ajkDWRta6Fbox4NxJgcGZf+vbYS7D7hQrmhLvycqCEOTcJAbgCpH1H2
 Tyddh4ZIubv229gXfAXYJmof6Gm58cfFulNFa9NNbxgOIMdrNtF7oAm0Tc7D24R0xrn8
 BB7IzQq1zZQtn0lgWUSgR8UlIkX/MQcQlAchlxJ8WLsZle8F7umJT1gUyPa7mqVhd9jb
 nnPpr5dfxJy3wJcChNxJW7M/zX+IAXd6jit/08UVVfwjOgZGg3AfF8plg8/O4goenKGO
 vZkqKasBEgPGtxXYMs6fgf30TXJdOlGoBQujwLe/7b4j6pIgDlhQqalS4hJyN5YQc82f
 p7uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPUge6S2YLu4OYAjR7JQXtKcDjsol1+7d41vFJCA+osKVFlnWOT+kWXK1Tuqhkd783j47S93QRjCaF@nongnu.org
X-Gm-Message-State: AOJu0YxDYI1dbMCB+LSIqqXpG/Ymg5QFDdgnVHb+Brjmru7MrXA3aF/Q
 CkylJyQYZk83y9/pXXPgrDtr3pZZvRe5DjD9cNOfhGGpLy8f4VgHtHRvnLEd+4Jb19bPNHTDOQx
 JmYNote46UCuvaL2AR6MjEVpxyOSs7ZS9uU25BxR0bA==
X-Gm-Gg: ASbGncuyDnG+oDmGduEr3pY9Nf19aGYgn99T1iwunqq40OqHVgcHPt+H1dBMtnd+E0y
 816bJF+6GlHDKZbkOGbPvYEY54oxiLuIMgkK5h6EhgLplEi1FzPQKmw4L9rlb1VVjWVl70pBorG
 GIQgS74lPu6oHIITENlU10NXWuazF9J63noMaBdeETx7ELZV9ToMH0quDkMPN2fjygQbRsjTefQ
 84IzeHd2u1RDdrQEfGYq5K4aeRDJvT5IWYbMcimuzYyhxoPak5U+rL4o9x67g==
X-Google-Smtp-Source: AGHT+IErFuQxfHGymiVpLnG1uZQC8DTMR/QZ5aqz3Bwrw3I6ssyq1RiDmHEPLGeo060AzzHIM8ZtLZqZCGoe87ISkeA=
X-Received: by 2002:a05:690c:2c8d:b0:785:cc3e:13e0 with SMTP id
 00721157ae682-786183862a3mr34145877b3.49.1761651548177; Tue, 28 Oct 2025
 04:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <s7ingr72rgtvch2poxlwyc25lkxp7hh5c273ubvmz4tdskjttz@7dzfvylkgwsh>
In-Reply-To: <s7ingr72rgtvch2poxlwyc25lkxp7hh5c273ubvmz4tdskjttz@7dzfvylkgwsh>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 11:38:56 +0000
X-Gm-Features: AWmQ_bk7D_dREHEf4B7QMAU1dpcW-TBbaZBJZyM1GjtFfymKXCRm0Y_T9G3Cv_E
Message-ID: <CAFEAcA-gmKkfysSThFDFzCUU0dYjh10qDA4zM8E0y2qcipzNXg@mail.gmail.com>
Subject: Re: [PATCH] Use correct type for ioctl(FIGETBSZ) emulation
To: Bastian Blank <waldi@debian.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 28 Oct 2025 at 11:29, Bastian Blank <waldi@debian.org> wrote:
>
> The FIGETBSZ ioctl get's "int *" (pointer to 32bit integer) as argument,
> not "long *" as specified in qemu.  Using the correct type makes the
> emulation work.

We could also note:

This ioctl does not seem to be documented. However the kernel
implementation has always used "int *".

thanks
-- PMM

