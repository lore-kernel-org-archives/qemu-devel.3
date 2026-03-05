Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1568F3D332
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyC2M-0006Nw-07; Thu, 05 Mar 2026 11:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyC2K-0006Ni-Ic
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:58:56 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyC2F-0003Tb-17
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:58:55 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64aedd812baso7355651d50.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:58:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772729930; cv=none;
 d=google.com; s=arc-20240605;
 b=GMOwpKJcd/hlc/pgMPHHldRx+hv9w57qbuiGobpuMXnDTQfxc/GwzseFqWGJtTIrdO
 VzFsBmDcD05kV/xrTB8neXuf5JHj5Qf8Qd+XVKzaRIUAKLa/JAjRGxliPNgJF0/Q+AYv
 AJSkgksaRU5CDzjjLn1Hk/EzDnZgHmkqQh4l7HpYhkwDO06snYutnCh+We+JZoos/eQq
 BOX1bjdiDEo8D9dbMhnKF7uHdT84hDvsOMKQcE7lw982ZSuIYjVYKPVPj1g1vvw78iNe
 N6359VmNLy+z0kK7BhCdZw7gjoOOuVDHEUf8EYwlUPR7vUNETR9T45ckJoveXlib4E94
 gwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MFmTyxm1/J67fOGNQy86Kslq1dWUNi4PeA3ApEVgYMQ=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=Eq1OTchNZFgqQXaggz4GxBjDXXkXu8lck/WQWvAiP3LVKzYyzYPRmYhP59b3uOmISs
 3kboFqzo2AGH63piA7eRCAmVfc2S+aRtVNdC5yUXgoOxOdISnyJGo8ONZDf0ppQs9m36
 M3ObjeAZgcg83V61cPkwHz4tXX/vRor6BBBTSqlQC4y5mE99vNJlFaHbZMh2SUW3rcJH
 OlYkYdAIQYKuz6r3l4+xpuzmkpAZjbWS4NskM/z4C+x4iimJgX45Zr6f+G0Pug5Xmt6/
 UeA4pO7E52vYO5G2XU/qW9/WcnMoDmFUW4ihrZ4vTuG4R0rWKLwGQ1TxHwbVhaAHEPAl
 6Eew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772729930; x=1773334730; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MFmTyxm1/J67fOGNQy86Kslq1dWUNi4PeA3ApEVgYMQ=;
 b=v1F59KXLc4Bah27pbOFDVGu+UoJkF+osZrS1FjL8Ns3zoDsrL9RwM+NIHgTyGD7LfH
 soX6uHGrZ7/iEXtBgmPDK3Jp3uqXzYRakhI71tbk7sfwUEBwOvwb2cGZkbSRwUu0VetE
 pKgyYIJwzG9ECso/zcFs+d7p5VwS051EPfbSYX2KgXOcwt7H4a20cFTJXPW4qrZqyvtI
 +jq1qyuS2B+wDIVSwdkB6zVZ6dn5q0GZu3MgT6+WLj8o8vOoJ9/m9ejA6TKlZE5TLVIj
 OBped0chzFhq5dhnuxzWLaX2WGFxUZ1LWbjXbwVEtSXK/1NSq5dt66dAUF+rFsSAIkHo
 6Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772729930; x=1773334730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFmTyxm1/J67fOGNQy86Kslq1dWUNi4PeA3ApEVgYMQ=;
 b=c1j70qe/yLeucH6dw4AOmuA8NRsFuuVvd0SRUoeF4qGVsJ0hhttrfnZaiw3F97oeM/
 JB3y9Tg847JJ5crjxMVlaqgIt8LnXzP5j1f3YNezQTS+jYbfv6Evn3MAY5X2xPaz4Vv+
 JbeDIc6EuX69GBQHyEdYkJ6pqg0pq+Us6zsA7388IQMRbZEmHVEZ/ZLoXdqn+gxwBRDG
 z8KsE5aFj79pv4NrhHGk/E1bjM3cIQ1ANcbUf6TgdtOOg/HDHG5JbGkx+kfFJxvr7nAJ
 DSrIDWCq0kZbvNrjx5iTQLIMfh5801bMjYmsZ/1T7LYhRk3k8j1Hn8xTehupQ75HL53Z
 5Xmw==
X-Gm-Message-State: AOJu0Yxf/fVOHRS8LDGsngvtVXnT/pADxdNVRB3m8SyFVV30Yq1XbNJp
 6gQYY3FFrCYSFBaV0jo5W1qzfYVPqXFSfnhj0vbBuT0LlKU515l2w850Znfc6VEdzyUU3IxgXZD
 +92c8nFb5ETTQAMvWa12XQbYA5ai1FBQLu5czEbrGrQ==
X-Gm-Gg: ATEYQzzdUhEs3JdeXiwVz5lNcPenA5gt2GpO7VPrvhpXq63yRMGD16LDCnIXTTOxS6Y
 MQSWa6D+URzsDH5w/X0F/MpRVtYxRp015WxmQDIl+soiWVlxLjtvUIiZ2sexu2eLkBPcNfsuDsV
 y1Fh++Em2rPZeIYE4qUEpybFkX5x7ceAXdZzfRK+BEkk8vsDuFNtAxkja8G0OQbY/SoTMzwry2n
 1vk6ZqVox23iVoD9f19Of8bkCKn+fUFedO9dy3pXW5c+RA4hK3Rii9GG45FtKVKTNt3uSh/9GUe
 bUCTgkwwp9hKCNCMrNFP9dJldHBJxSBgNryzcxhz7z5BHtDrK0/6VlQVdfybXwe0vq8=
X-Received: by 2002:a53:ee5f:0:b0:64a:f69e:bd93 with SMTP id
 956f58d0204a3-64d10bb30b1mr361417d50.18.1772729929736; Thu, 05 Mar 2026
 08:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20260305140508.218316-1-armbru@redhat.com>
In-Reply-To: <20260305140508.218316-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 16:58:37 +0000
X-Gm-Features: AaiRm52gv2hkgpLZpeH1y6FsIPuqSSyA1k0Eu-XGMMRSuJ7hJdCY_WqTKf_MWMk
Message-ID: <CAFEAcA8FLwV14q_nh3L6Cvw58ZnjfBBuG84ANAm5xDd=6zS5GQ@mail.gmail.com>
Subject: Re: [PULL 0/6] Miscellaneous patches for 2026-03-05
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 5 Mar 2026 at 14:05, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9:
>
>   Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu into staging (2026-03-02 14:01:46 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-misc-2026-03-05

fetching from remote https://repo.or.cz/qemu/armbru.git
tags/pull-misc-2026-03-05
fatal: https://repo.or.cz/qemu/armbru.git/info/refs not valid: is this
a git repository?

Looking at it in a web browser:

> The repo.or.cz site is no longer available in the UK.

If you want your pullreqs applied you'll need to find a different
place to host them, I'm afraid.

thanks
-- PMM

