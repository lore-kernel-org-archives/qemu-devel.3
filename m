Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA6C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tf6-0001si-PP; Tue, 08 Sep 2026 07:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tf3-0001rQ-CG
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:06:46 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tf0-0002O7-Og
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:06:44 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8630c1503f2so34507607b3.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788865600; cv=none;
 d=google.com; s=arc-20260327;
 b=XudQONsu7Pt1gMEnpCYFDlfJ40xhlJMnRl6qX4plmfqfM9cmCbamrw+mmKx5uoqNOy
 ByfoiXPxrff4bw2pL8OGPilHQnLBmKdaivIy2IR5l7iV1isBXmVDWTWGrufo/npTwjWH
 SJGVW8m5a1hrKHs8hPkmcwRIhHEvp7XVOG8+suO5MVZgcHEIHsNaXBTT9du5y+0QGgIf
 6T3p4s+ANYNxEoIzM/1jBLEWmfJNiLe+atV6+EzE4W1ReIb5bPCwiuiA/MZNOHGwF19Y
 nx87t/feRJDGoZKB8WuH/Dppc06YXLaoQrPB5mQX+WDP/TyN/qpLbOW7XT/xOwqHvHPO
 /h8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oglPP+j03+Qqw7bAG7SNFcjv48UgS4g5SlwNI/8S2oo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Hu3jdUOxLvHeqZ++XdpLnthmjmcxWQQH8nK0tzDeJX1y5qlrSlkAsHbgBt2YR1kRBl
 dDaBdaj3/YeZGfCv+070I82zvKw6T8LMtFoPhpHUEYpYRA9B6J3T44r9kiBu13nfrhGm
 KB6Fut+EAAkJXKtcg0igxwJLSLTRcnAS06IJVnt30V2S4MVeH43gF25ZmOCjA3zxSClM
 iAcNe7MtwOIUbMQW8YnSSjRsEha9hY7hLZcPI0LyOnlVsHHqEpjrb2TDliwDpFxN1gvv
 CAi8NoaGl9WLmbW6rPGhOeURsLYDqJkLvy5PHAukScrlsa9LSpTEcQt8IaVjnTPew7px
 EMqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788865600; x=1789470400; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oglPP+j03+Qqw7bAG7SNFcjv48UgS4g5SlwNI/8S2oo=;
 b=De+LzHn7Q5BiEc+VeRSwmhPzQLJMHvnj/wjbzGmmF2RdnomYsRDGvne/2y0crqm7sR
 wjvSJZp6LGRDa9tiQ6Yqt8pVQlbicQIU6pAnK6IG21//qHzbXSwKAHMLEjoeEFpcJ0db
 9dG3YxHiRfFpFKA+Wf9UOcSfW5+0jM+lJPXhQHZwdGe8FNx2bQrDmilcftjZOx1CtKgC
 YYEseqqaM60KAOg+9jQ9sZ0Gt6tig48eMbavZXS60TYl3Xq/VohZNjUeSWDZYxDHvSK7
 U9XvnRT/Wwq+Ec7d1mFifw80IXJ3ylBJhay6x1mqKlCC0jZr2zNyUptGPonZQmU6zRtU
 zZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788865600; x=1789470400;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oglPP+j03+Qqw7bAG7SNFcjv48UgS4g5SlwNI/8S2oo=;
 b=pAL4K+Sz9mPnrV1ql89I47xNIJrYTg9DHBFS/RAwVRSZ7uE55VNd92uWs5/JNhS1zg
 Jz9NNcMMjpUaIZdVJcOlc0pimWk+csso6oNhjqyiVocTuCYgr8nZaXrpZpQ7Bqsl+CPP
 0HtzRspN2Ty4MrPJb0m40TE4k/lKaEWnoX0GUtQC5duy1h4aDGlsLxGp4sOgAFp+SRN6
 TvVOt3bS58RReSYKnSPgCpN0/ZQ6dQ9VUKPoYeT1f6LgrZIgTHGbx+vbP6n97uGMzA5T
 HQ3trmI3xyn8VIZ0aIdvdO9l6wjbyGr2JJrXWG5xU6eXY/VhNlDidlsl+sq722ESxV98
 Vl1w==
X-Gm-Message-State: AFuF++mHW34V1okYoWw856mrb/9mliDX5eMYoOEZ8bn/LJUDOTlOqhBp
 gjrHdk6JZfbeAwvpBIXMkzf4tKHl+5SoYiKbllhM3Eg6UwKgozmGdBAzSm/k2AzXOlQzn/v9+0p
 8YHyL6iJ0pRm8rxxvO7Oa3/0v4mL56UYjpmOG3YV1wSkMdhT8E9lkFxc=
X-Gm-Gg: AYBFou2tsxe3o4xBHZ3avQW7o/2IzX7f2UZigo/7ecvkolhkhFcFtVVGCOo3v+aBw4c
 WL2bcrl2p2tAVhY03FPXC8l0+Mr01sQz1AJZaYznBfI1UdzZTOnoHW/NSRHnLB03gXEwAVR78s/
 wR7kH3SGFQ7pbIcSJbEDouSxXXUw9RBgsxA6e0IaPD+iSi9XAoTXS0FrJTrDs8XsWE8dCFeW/+a
 uQ4TQe+towbxtDBuaFkz0fJaUVQLdc4Vco7EZnvS9+7ENZ5mYW0mr1sdvw7ppLyeVqxtdLCcGcA
 FZdlngFa7W2TL34p6BHhbDy7Pyugjs64yPvFj9R4NYjJiVv1gWoZ30A5jfRQ+9c9loNlBI3S90r
 7ZA/tAzLWoR/FarST9AcadERiq9Us
X-Received: by 2002:a05:690c:dc7:b0:841:e9e4:8ab9 with SMTP id
 00721157ae682-8712a709f48mr117102247b3.25.1788865600031; Tue, 08 Sep 2026
 04:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-11-richard.henderson@linaro.org>
In-Reply-To: <20260828222639.1432046-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 12:06:28 +0100
X-Gm-Features: AcwNN1WQ_vBUzqsALzlCACrEV-a9WTwIwqZNRJpdlJ5oUpBDxEtdiRLIE4dhiyo
Message-ID: <CAFEAcA_J_y8ccp_BAtkb0n7z1wdRHqa88wgL_jAyaRmN-_sbKQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] target/arm: Read and write PSTATE.UINJ
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Fri, 28 Aug 2026 at 23:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With FEAT_UINJ, allow PSTATE.UINJ to be set from aa64 and aa32 modes.
> Read the value back for SPSR_ELx from aa32 mode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

