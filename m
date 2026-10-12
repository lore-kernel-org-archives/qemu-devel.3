Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47531CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGChl-0006td-Pu; Mon, 12 Oct 2026 05:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGChg-0006sw-0P
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:52:21 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGChe-0000GQ-Iy
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:52:19 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ab395abf79so10083167b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791798736; cv=none;
 d=google.com; s=arc-20260327;
 b=EwSEcf5WgiMt02BnpPSk8ElECrxN5Cqg0yP2BrK56vyTslyrUhvr/NMGiY79QQipPW
 NbWIOHXQcrYoFHSJLrvUV3goPNIcmqu3a7ai8s1EB+yS0TLMdL3cpv0/o7pf1xeIXM6A
 fKVz44ohiW0VD15Acu6MR2V1O6/322AE3vcRftzV2YokpSRwB4TC+Qonro9P0/wAtLeU
 9crwrAChEsPrUrAB5HnriBO1D7Y7uBwqxanZj4PG7UzFVIAj6FMtpKxVXCzs8n5akcLW
 FpSL+T6GzzZXwU23OkHhvDpZsJBHtn1GkQqCJhxgS3w6DKa3ajdGmyeq3miWR5SYvA7E
 4vVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+umfz3SlzoeSCqX3h1F92tiHRLs6umtF0IR1GJmbNcg=;
 fh=kFF/XFhhDVgLJL7VfSWMbraE0OC3Zj7WmtDurJ861Mg=;
 b=WuJ0Z+sLvl8boYeqEbNoMCSACkUVBEpe2xdnL/xt5P2zkTC+XeUA9xmzRggcIkCc83
 v64RuWNGf7UC1cmDZjuyvmdsO7OzfXtmB1SS0faB+9NJC10JHkKQ08AYidUGbAj/BboR
 J7ssDxREvnXgd+EEnRNVRQ70tJxYV3yR6BxiciQvu4yrM5iJd363/haVxGFOSKSCgIER
 cHjfdaaD76SIL2JCGxV0ai6VE1e4uj0mdb93Uu0cNxd5BOcbrf2P5KR/152DB+BRyLKV
 2N8tUl50OQZt4Id2JWDoyNHDoVarNvjSYBSmL6uVYX2+unG9bIHD/Vxy3JRcW7PNpT0P
 l5kg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791798736; x=1792403536; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+umfz3SlzoeSCqX3h1F92tiHRLs6umtF0IR1GJmbNcg=;
 b=nlOjGBLh+rH1FFgCV2//dLNmzJyJy7o+SFfyefGZUcd0lft7gtb4BmIa2DTONu5puR
 IloLHMWUV0NmuO6u0V/HeKnzaTTrDjpYXZ3xCE+/Vt+Xdp3qeey9SeN5z17fYmpcwFBN
 TIS0zR0oIBpKTvZUIHBmqlLyKCSh5Y/ojuaOvJCSJ8E6wkRY4jGkNuxAG5zGO0L3SliL
 mQFRiNM6+qiWNfgXe+pXpE+i1xPJnumEBeLNAw963+xrZ/C5+MbCKVG+r17apBxWhfPP
 3eMPD6XSWw3P5fyyh7nK1WfqYGSjthFCT0NHR5QZ9TSxZapuBRudbMkRgRixch857wjb
 WOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791798736; x=1792403536;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+umfz3SlzoeSCqX3h1F92tiHRLs6umtF0IR1GJmbNcg=;
 b=dYBbXXxh5L/Ku/bsI81IA8DuSyNqwvCmgqiEUdj4nFHFkLt76Av+2Nn2PNQgcygMtr
 vRAC6rCQkrYMvsZrSNwuFDitgtAZmYAgLH2wP3v26dlhvbnFOnsvxfr7cue3UjFjDXtY
 5yLrVwYtqezfiHOI0dwoQ+QM6ayreX0oomDObDZAD7zAIeAQg3C4bC0unl2v90uJG8SI
 /5DzfapVXqSiL+/ETtloQ8y/mPBGg06/qGxE3MkJVSfkN0IrxFUiiyA8hxo8pqbfCKdw
 FF4zdWjgshE7x3vvtNw7IJDSAHtUA83xcmwGagR9ylYLw3+S6PE0iIbFDDX45crs+b/U
 DoNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+M0G+d+DqgUM/jp7UQ1WK4pDBBQGb2QhVyVI6mP6DwJuiu+VmXHI4jgfsqqB/7b8uo9oT7oAxbkuU@nongnu.org
X-Gm-Message-State: AFq9FYJDxyifuY3XBk5GS7F2SS2zohCkFLcHfRkcAi4PUgqMFIyoFPdf
 s6dcnaXArPBvIMEpgs95ghd5gLPfQMEo1cYbbvUE9/2eXGuIoNZAq+ywsEnVKkkFttHAlsc6CHf
 DxVdD0AOpGTZCYFsWIgpzvgrFjvoNErZo5DK/NF99tw==
X-Gm-Gg: AYBFou1+Q5QjvkQFN2U2Ezjd+sGmlHo8Gy4YSWn1yrl/PBz+E7Zn7FbfvZQeV5btU57
 3+0B02736+aRmM+TA9kXzhlpsIN0+0TcjVncd3JCcTXtMDndIRFha0d0FiNHXLbwtDlsd4BlqdF
 VONfeyXSE8ivzk5g4WkBifOxpRAmpd2Lnu3Uc435//QItzUWGyV1bfLaolZLDkBH77TCagjX/9D
 Hp2mE/JWecxIoqraDWnRa12kOsrWt9PBhPfAfNlN1QKiyGcX6Z9+E6JODu6PZrrGnY6Bk/3PoB3
 oB+RTfxsb7zE5q/uRw7Ff+q2I8gXQAc3vRWhO/WEdxsbDnf69HVy0lseY+W8BQRLB+JJsL6wgpu
 ll5R/54rUZoGxj/uhz+sX+rqhZ75rYqUHFPmTJnTj
X-Received: by 2002:a05:690e:43c1:b0:674:1f9a:9e88 with SMTP id
 956f58d0204a3-67936acb407mr1939692d50.90.1791798736281; Mon, 12 Oct 2026
 02:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20261009121545.241772-1-gromero@redhat.com>
In-Reply-To: <20261009121545.241772-1-gromero@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2026 10:52:05 +0100
X-Gm-Features: AclHuK9RLXsSqv7VU1vONq2feiFPvBZ-rtgPd-WOxV9mzRxIL9uTZScCcXCFVeo
Message-ID: <CAFEAcA93it=-W+aSf=n=TcaX12DnVbkbjJRbPkiue4oChvAArw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Use TAG_GRANULE when creating tag memory
To: Gustavo Romero <gromero@redhat.com>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 9 Oct 2026 at 13:16, Gustavo Romero <gromero@redhat.com> wrote:
>
> Use TAG_GRANULE definition when creating the memory region where the
> FEAT_MTE tags are stored.
>
> Signed-off-by: Gustavo Romero <gromero@redhat.com>
> ---
>  hw/arm/virt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

