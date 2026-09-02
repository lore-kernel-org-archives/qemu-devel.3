Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A17C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nIH-0007bv-Cv; Wed, 02 Sep 2026 11:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1nIF-0007YR-El
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:54:31 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1nIC-00071P-JF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:54:31 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so189706966b.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788364466; cv=none;
 d=google.com; s=arc-20260327;
 b=ZpFtsrMhtRW+1L7g6JEmuW8qEIHGJuD6e3wG7MAleBrc5ZMWhTJHsVgCvu/qz8m1aF
 c4qqSY5uru/WOZOwTBLcPPm5nifeD4QcF7mlWe3UuvC9p2UQgBrYGJ5bVfGxwTitisQS
 2z1Pw2eC30+5JO4QVDqIAKqphpo0+eWpaYw09wA5nA+Hlx98E23NvSXrB1whoQHGL2KS
 tAq66zWKkM/wjAowaLGaHxlabj+fSvqYx+Qt5Gf4NwU6/EuuvMjnObmBIxhgrm0W6IG8
 0x/HZ5SRoRh7fSICcCSuTbLMmWFgrfzUH3yMCggyMohLcSX/PyTwoeDE8d+d1swLPg2H
 d2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UjQOC//brlOILp2yoPiknRJJfOVqfX0vXJRvazfKoPg=;
 fh=YUyQhuKKaM8zIiKq6wqIM6WRKP7NtW7B8IhW8S+ydRU=;
 b=dzloGRksRwOPcnpPk7dGTLTD+2tBPf/IV62xwOsmPhf5OkPJo2M23Nrb0gLj+0tab/
 RRvRR5EZI5wr8ojMXWk0FiZaB727i3l9/UleTxFMI1JQ1FMz6fbt/qFAOtDM7bKHAkjw
 h6khGvRnUONtqDpOiNVgs1ckuRxDWYrTWX8pt3mSx0/KHIQ0dDl8oYx4mhi/huykIn1R
 +9LxKHoz8Pah4/3myXcivUXRDaj2Dw7/FE5VPS84tr4F403ZV7pjtPII3uuFuKV4FOux
 M7Emdw8W3gDqyJSJxuD4Y1+kbZM2gYy/MW5Thka2Vx2cNd17+21PM+x5vEqrVNrADGdu
 56+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788364466; x=1788969266; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UjQOC//brlOILp2yoPiknRJJfOVqfX0vXJRvazfKoPg=;
 b=hCZlB1gCW3GGH6uCdgBXEtPY0vo4jONeU5v+wSrjOwXnAYWaPmMJPtzzdCWaGufiSI
 gnSLvjgslPpDDctUxMyLvfnHcu90wA7MIoYbeeRPXQ9cftKoRnJYGXlgb5CcrJKVzILa
 HtJO3UC0M1Yg//3VxUq9AuveLpyJJc1K+zbAEiIa8cgddOJKM9FSBmBaZbcxo7arQWh5
 MJTOQs4WDSHEeYXORSFJ6QerpEO95CNltej2Xr8F5gZxw9s6DzgWLZjzTSR4XSrS/NW5
 s5fiNahR2rULtlAFqWRbe/CzI/J1DgS8zoBHUqpmE95lIuEdJFxdYyDp95aDBp/Ecj+H
 V1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364466; x=1788969266;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UjQOC//brlOILp2yoPiknRJJfOVqfX0vXJRvazfKoPg=;
 b=jEj6Y0HhffpIyMweNjJo8+ZE1im0EUq62pOjrpLrWZ2rCYANc0UFECpGYXdABUlwK8
 8sfEa/DBOKyBJADtEaZkC9hwjrWQj9GclSd1AAdQGZfb1ok/wr7LfPyUwGhOgQyAPpH/
 9qbZezi9gmCrAhbPN6PgodM95sBZBu5bftmLaIhBv2pkUBxrNCQduFrUMYD0UYekdApN
 c6R0UyiMdQ7SOiOYI3rQkIS74PqxL3D8vmLXQsIGKJHOgWdULymyjdMh1OJLOacPTwbx
 GY/EQ3+mp4N7gMCI07q48MLnbLPdbeOJmuvKh/6CgvKwN0AWm0FHiEc43FcxusFrht2D
 rTTQ==
X-Gm-Message-State: AFuF++mk5SbcWBqWxszne0uWmsu7WZnm766FC82gzbAHrZDy7z/f5ziJ
 8zXu13hUFcADgFZvWFDWn8F3GXeioRmcpv1/o0xiwZPS/xUWbnneeTYuuMgHllPw7hyql/hRRE+
 GzwDkaeqpk+3hd9JmwTT7lSd3roVClXUdwNjebwtJTA==
X-Gm-Gg: AYBFou16GDUJT5jvJHE+Fk9jOOUpHBTVbpI3YrfGZA5nGTJnpu4FV/QnVoL+RRD8reM
 eNUysaxGISy01KgkAwk7au0Hb6NSVYb62AH7T59sHsfWVGzbMc7sc2vVIz29rslCeo4bCxIcaMx
 b41WVWs+/OAZYhvoGzdkoXyRUCejbjsm0Yztxo07HNMSg/+662xrlrgZ0i/bUtTr9LNp2gahV90
 q1TBQ0Bgf8J37ykg6ePWTr/sqjDu5y5GkrO5WhptMbThpXJjvcdzDG0A7ZeeNvAtbEOQvDaKX2u
 eH7Loj2c3i0dGHrUMIQop+3sdlV+pHqaHYKQeL0uH4rfasJ8SAEsdCfKzbGv6PHeswona1Gk+Pv
 r5B2NwxdQg8AoX6OqT7s+jpW/hS2m
X-Received: by 2002:a17:907:7250:b0:c1f:c061:569a with SMTP id
 a640c23a62f3a-c25d545303emr420589166b.7.1788364465319; Wed, 02 Sep 2026
 08:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260901161422.314581-1-pbonzini@redhat.com>
In-Reply-To: <20260901161422.314581-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2026 16:54:11 +0100
X-Gm-Features: AcwNN1U_pfPGTg7dLJhqWMmi-eI22_VPc7m6UEjaCX3V3iPgtoIZUEzPhGhprJI
Message-ID: <CAFEAcA8s=P6_SUFss9AikhfpLrFOi8p81idM6YZ=De-Z488RCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] docs/devel, AGENTS.md: a completely new policy
 on AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Tue, 1 Sept 2026 at 17:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> WARNING: this is *intentionally* a full U-turn from the previous policy
> and discussions.  This is not a refusal of the arguments presented in
> those discussions.  It is also a request for comments, and not something
> that is ready to go.


> Paolo Bonzini (4):
>   docs/devel: introduce a new policy on AI-generated contributions
>   AGENTS.md: Let agents know what the participation rules are
>   AGENTS.md: make the human part of the design process
>   agents: add CLAUDE.md and GEMINI.md

Could somebody write a short AGENTS.md which is *just* an
encoding of *current* AI policy, please? I think this is now
the second series that provides an AGENTS.md as part of
doing something more ambitious. But right now we have nothing
at all, which means we have no guard against users who have
missed our AI policy asking an LLM to generate code that they
intend to submit upstream.

thanks
-- PMM

