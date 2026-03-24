Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225CCFEC0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56bZ-0007GD-CK; Tue, 24 Mar 2026 14:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w56bF-0007Eb-Gf
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:35:38 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w56b9-000311-Lk
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:35:32 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64aedd812baso1696441d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 11:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774377326; cv=none;
 d=google.com; s=arc-20240605;
 b=MsMHCWJqHrDw/xITAFcUGA/wufAwszzvJK8PvhU78XQiZwqK/QCNnk8mi+UEwivitD
 zIGc5E2d/QXgLBaKb7RfnyKq7gN2IOjMyk+20fdH2+7CeEU+VVT3WiIuAJ9XZ/en4q22
 SgKIK7hfGRzE5/+MCLnFAyeuibIoQNlIZoMOHSdclHPWesG7LUubvDumn5tSTW7w3Qes
 on4q8gadbP0VLMqCTf3CHBWeBFiN4koea48VikxI8m4JcdxPp2VJbnUPKpuFwxriHPXn
 0c9/fjrUcqll+GrpK8cqX8As7AMtyhBIpDQPfFrZ86FHuh1boGuze6fIzXMKw1aoC9f1
 5Dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2l5BIxEWC/cDCvQbuxmSCsYfbdqGZdohBU17UTLkiFM=;
 fh=0gw5nfXnh7VFeoy1bdl11avC11t0a9fpFz5v6uZHFHI=;
 b=jxHSUm7GBP428mpCtLBGXqQYWOw/5bAgJwCcnS1LxpUvtko5iPjScSy1k7YbE1ulGy
 gjMJYZia2gKTEzHvC5RMfG1CSozEhBI258jvr6UMsSd1uIu5zOvnncwXpbYHyVTQJgTD
 OFB/042Z5XnjHpysMN5X+aGTlGXq3j3QoaJiBHEXen+1bLZAAhU6dMAi28eOqjUetqt9
 6ipjRT2OuwwWo6zsruPSW521ku2t/TOBw4cx54h1co/tJyWSJM1KCmlP7XQyy0u7rvnf
 ZWekyyGAUFh2DTXgemUpbvqivlGYTmMg4i/7kQ0yBsGu+fEAO93v0GU2FfShLfnavpcx
 seWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774377326; x=1774982126; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2l5BIxEWC/cDCvQbuxmSCsYfbdqGZdohBU17UTLkiFM=;
 b=Y47EEeqxkZkYaR/RZe655FU3rCq/gF0ijlAzklM48yxkohfsKpnxb+tjM5UmmsfZcl
 OORpeJsFfVoxbGhgAvDZ3Mu5qLNHD8nqxrksDlsgsY4Bu3x+WpJtEmnu4e8p8lr3ROKP
 zJ1vTIs/hNLIiDsaL3dulMrRt8b1SV+NPy4ep+niG1VH9YOTcORTRt5FuQjKQYX6EN6W
 mrnY3Opr4RPj7tUWf09yfaOC7CDLNb3LJ76IentszfwV0WpOaWCTAiCg0uj3G9uMsSog
 /hRb+pFBZpsdWgdVNNXYVvWnKN3GEpoQNt+bYmWj50/uWR9jVZrlsefp1kq2mvKXx2Ob
 kOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774377326; x=1774982126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2l5BIxEWC/cDCvQbuxmSCsYfbdqGZdohBU17UTLkiFM=;
 b=bpQChz1TfzpXBLzbbg+71TftyCTpqtdubMwUVsxafO+34q6xr0StgA5NWUt2VKvYqZ
 qADEIdqwwsrC4BC9XHa7ZHb3vbCLdmdGrdZQZ4ixy3Nx4/KM1FJG+mPUPIaOkX60m4Yf
 ABamXjxZBdr3AO9PeCm5IXgaEEHiMC73kY8SxdQ1to2VTz+8pRjsKuW4PZA9bWCsmvU5
 1MyWYc1XdZhZ3RjWBs+NIF8b0hOMBF1wk9FEOO0sJeE6pMM1dIjZ73R4k2KWpSj38T1A
 +nJcfz+Jx78MAUMh6srY2NGjhBgXkiowTbWnYQJKu4RJpVmbEowmL2oz3Ask6s11bfIO
 28qA==
X-Gm-Message-State: AOJu0YwKtb2ceTVIFR1ZFtScopn0NJEApqDTBeIQLh16zTc0gIfieZLC
 uo6T6o/Ro4BPuH1Oar/4ezVKpgtKBkwphiXSfD3aOBCYY5OFqCsvMORsNxONFlroOe6DKtmHXDB
 aD0n86MNAZqlPXAmi7zLD4YpkqeflwlJ+yrRjrOkguA==
X-Gm-Gg: ATEYQzzLF0H8sYBZj6MwCeXAjdn0/Gk6AK7WKYmYt1QehmSI8kPwZolWctVvkDkNHRw
 qZ/w+FNZVbfqoMGyQw4zSXtLQNFE8npIWMCzJLiDdO2fZ/TXNqHj8/Y3JDdfz6SPg6Wjl8B0B38
 9Uhvyaa9VxW8xlBGIo3Ir+BLNog/Iu07i2WGbeE72bim58hgRHVrOfnhxQ3/Wc7gcMuShHsHI9y
 EQQg/Aoe+jXHTBCShObAXfJGPeexyeJfsUjCVOi+CAs/F95Jw8dlikaVfKGnSkMrGDx4BKPRaTn
 tYBJilSrB7dloaensf1ZRXVkGuTOZI6IhPvyk5ByD8Ceiqqn2hNxfmJ3tfqoE6/p0xo=
X-Received: by 2002:a05:690c:e3eb:b0:79a:467a:3c57 with SMTP id
 00721157ae682-79acf73293dmr8482657b3.54.1774377326179; Tue, 24 Mar 2026
 11:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260324123444.131118-1-cohuck@redhat.com>
In-Reply-To: <20260324123444.131118-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 18:35:14 +0000
X-Gm-Features: AaiRm53Kzr7o1-AltAnJUP7ZRX8k0fMKNlDA3jSph9qY-AmnMSBpkU0dTiOVCaA
Message-ID: <CAFEAcA9jLcvvUW6duXdghBtyRHTWqJ4r8YfapSe=LSrXw-GVuQ@mail.gmail.com>
Subject: Re: [PULL for-11.0 0/2] s390x maintainer updates
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 24 Mar 2026 at 12:35, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 750ed363ebfb108082b40bc532b20564bf00f913:
>
>   Merge tag 'hw-misc-20260323' of https://github.com/philmd/qemu into staging (2026-03-23 16:58:15 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/cohuck/qemu tags/s390x-20260324
>
> for you to fetch changes up to 8a749493544e027a43a14a6eba23feb7e9e5c370:
>
>   mailmap: Update email for Nina Schoetterl-Glausch (2026-03-24 11:52:11 +0100)
>
> ----------------------------------------------------------------
> s390x maintainer and mailmap updates
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

