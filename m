Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F5DEDF166
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqtuA-0007fU-JB; Fri, 13 Feb 2026 09:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqtu8-0007fD-HQ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:12:20 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqtu6-0000V5-QT
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:12:20 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ad2a2851cso937445d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 06:12:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770991938; cv=none;
 d=google.com; s=arc-20240605;
 b=Xy5izbI7gMkv5LT8RVbDU/hJ9E1z+dK61taT0wZobdVtae6aC/dkQEtfpZFTaR7R94
 tmo+CyV0vhXaESzgb69dDMMqKHhr3DQlEaeNp3YBzBOwd4AaPUGgDA9FY7kptRcEbdEF
 aWg0zYZaquyGxLPlFzCs31DG03qyFAolx4VQokkxSi53fvcroEjk6sz4X1oMBUjm3yFL
 U2rVKJ7dLvP+cAhKtrZoDAuv5y8+X9bisacg+ncadmtd3QVCFLc3PTasxS+HM76N6UdB
 RXNUpCngrn9xoUzHcwdWFmRkdLPCetk05gHoR2x3eFKjpmEy4aQb3ZjobkTQpCevaI5O
 vFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tN6l6ZQWQtVw0hQEpupmq8IjNwbvdkX1tM3G6GOWYQ0=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=c6l7IgoB8yjBIlr2HALLn11qsEbOwya9Zv0jJFaVQuwgGNLkLM1qb9B37zHQ3/Ubsw
 4T40/RD/MGJ8pc2hGt5v0dl2ery7WKXGA07WefIaHiC94DjlgAsZ+5DXT65RgnpErZ5b
 kIW3Yl0/2fRrcri2/SV5FSaX9oFf7fk4cWM4n57gAIEHNpA8BI0QnajEri/atZr92O8/
 teKLh98J31PlLHuhnIjLvxqbhqx7M2dRuBasVMBVACdvmN4qIGfMX9OHNZpjaRmr2W9G
 oyywutzvAH/ul6Z8xkh/jJNIkxue/mo3fftwJCIlREske2BBlJ0N8PyyncpjzNa4QqE3
 C/4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770991938; x=1771596738; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tN6l6ZQWQtVw0hQEpupmq8IjNwbvdkX1tM3G6GOWYQ0=;
 b=JH92BbMoMoS43UPX2kB0G9j34CqhzfP7Spt+lQJlFv5PWUZooXkmumWFRYfVjDgxuM
 RIj5l/TxKUlPK1QB1fUGQvtCzxBP+PWwjJol43fmavKFvZ7FSGDenur/v5t1K8DqjsCE
 QhD23c3BrkVTBIRS5RsZ7vap2X5MHCnQZdRGvpUptwRFRlWMub/lMfUjos5aCpAiVwDH
 7YEpML6pG0R0Z51Vj32gC5l0lC90kajFmbh823JEFo988QIptD+yF0zsKKEhuhsinS9C
 0A2apg7HfwjHw9bK9OxDXCBDt/ODqSo/WsVWHHRPioGMVnTAsjqT6ve0jUq1TuzfzN1n
 6D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770991938; x=1771596738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tN6l6ZQWQtVw0hQEpupmq8IjNwbvdkX1tM3G6GOWYQ0=;
 b=GHfG387GkY9RIoMdMPBbVpZ16bRWyOKTnUXRHwf3jL2UAG6ixu2uaUFmjNrPPB7IqD
 8Y+PAkm7uI9r72+OkBokwajp2bcjOYBfz9dl1se/AV3EZP1bHlgPa8pq0H8tiI032tFN
 IrNX8uq3uf9s+2BA4glUHBCWWdnVv19ycX9afhGRpnKFtpmZhCSye6GdPW0lZ0D/FyK+
 CYc+ZBJjhEYy6/NG5kAdmgzr9/qsjHpxqyOC9Y5HXAx1otLlbRQLk18vLCP8Fj7rb8o9
 yxeigRZqlBk5Q/MeDTWXHIBwS/jnDoRi7z1CjMn0Wp1uAxssivbaFPceSHQwVPTr/Inl
 uqeg==
X-Gm-Message-State: AOJu0YywGGt1zo6rzbTeI241GX5gzCToUvFiLzN22NoQnTwSZH65xTE4
 gehAV3akLumOZiXuhLaY4qkc4tSf1iUb171h/FvRyVhUVOASzIAl2UjXWYxnXuWP9itR+lfPs9C
 BBN0sVsda2h13AiOEB23P2Q4qWWIKH55e05vRnt7tlNA4FNi/R6Wu
X-Gm-Gg: AZuq6aINL4q1VqZcp3qyF9Z59uxmi/wfp193rTlti+tt48u6TpO5ZE0rFuWUVO/3p7D
 st42WfkZdFSdwuEgCsbPvX2ldIK68ZB4jCMI6ZwkcFGkli3eSduXpOMDGvXOpXia8BsNdsROETS
 BeY5rnejXmyIB8TITnTO43XkB6bZM55A2s7MftbKrwqPwBAL2fX56frYTurA4J5SFtrwzlQ1JEz
 B3oF2LuianwJRFKYD4nfjYT4WAfmY6eO9BdAXgEcU7pxowXGcwyVOY+33JJ7G55OF0tXxVN36V3
 Hq88hcM57ox0lekrDBX8YY3VhobhMMmTwGbwC2XlJEH8NlBjWuppSP8BYxtmiyuiYpM=
X-Received: by 2002:a05:690e:1341:b0:649:be95:aada with SMTP id
 956f58d0204a3-64c19b3a476mr1191396d50.69.1770991937718; Fri, 13 Feb 2026
 06:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20260213102109.107491-1-pbonzini@redhat.com>
In-Reply-To: <20260213102109.107491-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Feb 2026 14:12:06 +0000
X-Gm-Features: AZwV_QgaKBzO7Gtsul2yDGh90Lko_egcZbg81TLdwC71_YvdYWuBnBixJPa4gB4
Message-ID: <CAFEAcA8wC1-3QJNNvUkO_Qc+oyAoWpHjOEKa-PTMSbe=as+scQ@mail.gmail.com>
Subject: Re: [PULL v2 00/41] QOM, target/i386 patches for 2026-02-12
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 13 Feb 2026 at 10:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit cd5a79dc98e3087e7658e643bdbbb0baec77ac8a:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-02-05 13:54:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7db36b822316a830ae803e903a12e920e3273b85:
>
>   target/i386/mshv: remove unused optimization of gva=>gpa translation (2026-02-13 11:16:52 +0100)
>
> ----------------------------------------------------------------
> * hw/i386: Remove deprecated PC 2.6 and 2.7 machines
> * i386/cpu: Fix incorrect initializer in Diamond Rapids definition
> * qom: Clean up property release
> * target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu" is configured
> * target/i386/kvm: reset AMD and perfmon-v2 PMU registers during VM reset
> * mshv: Cleanup
> * target/i386: convert SEV-ES termination requests to guest panic events
>
> ----------------------------------------------------------------


Applied, thanks (I decided one missing s-o-b wasn't worth respinning).

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

