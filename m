Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F6CC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfYXf-0007cI-5l; Fri, 03 Jul 2026 03:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfYXb-0007bK-6c
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 03:42:27 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfYXZ-00046q-89
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 03:42:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493b7612475so1982765e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783064543; x=1783669343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLJ7EoZLL/OcQDmkFHu9BXV1+Itp/8XIkRtF5+1+4pI=;
 b=oHkT3P6upws1O5JWVWXz8MRGTOQwn6ZbRXZTD3bUom2tIQv/dH2aFPrYtgxAkMardi
 gLWPSVXlnz0W+LAOjMshgqF/KWbch/ZgYHfeXHS2WxNmneOzy18w4wCbfjuymLAeq6tK
 bpI7Vz/2fPrkitqvAXFVlb3Fd+fph2C8LEPK9+MhERSVBNm8wtE/oePau86d/ibbq7bn
 YOcERo4WJHU802tyyaTpKZrAF/bJ3sqnthLFEerZGxpecbRN09mO3iFq3AYxmtHzvkn8
 1PG+j4r2AzJ+otyGSOYs4K0MIuA8KGRGKPdGy7gIJfqT52eSoomrW9Gy7DygYgjLoU+V
 dm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783064543; x=1783669343;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QLJ7EoZLL/OcQDmkFHu9BXV1+Itp/8XIkRtF5+1+4pI=;
 b=nVNOcrRb2Ojo5qVe896Sjc8Bv4kqybdMYjRalwchgWRbuhrTF3ogESv5kI1m/7Ye3P
 C/RNTssOlyHSOGtpameYCgiu0y8/gYHwybcb7oUGoW7LYo0LzDmO5wcYAFbrzcPjVp/Z
 YSzhmpUqoV32EIdPZstY4mRbt+ETNuHGIhPntsHLH3PXUghaTCOvmeSbEV91Jxnp0mct
 JlE5aSedA/cDg0w3qltm6x5y0zQ3JFY8HcG4pQTmNm+EiYODORnz+oMVnsxqXEf0+bCc
 9tO0q+vwl+FwVZdKn6bIoeQBAC0x2p3a1t3C+9pS6umjI6NpvSwnmJJhd43CMLd5sbbd
 PWog==
X-Gm-Message-State: AOJu0Yzs8btx5nU4SxEvMfPV1Gsb/MgpN3DuXX1PazqWN+nHI9Fk6DQ2
 EY7MgoWdVp0hOjVfmWNSFoZTqqL6wYrws9F53v7UQyvZH7CmkAup+AbHrgiPH3BX8VwB3MoIAmp
 c7RARbl4=
X-Gm-Gg: AfdE7cm0gZvNIw+HN5z3nIQiftJoe2ZYvFn2M4L8jy6mQ5Ns5vcqfkGiXnlU3iozn+5
 /BDDZ9co6LwOpIlxVQDGKjFbexVmtftwFFnE/QSL0BSzrVvsdpc/A/7YKA02nBXzKXnAV3KAVvt
 805mzoLsAkuwhVc/FMq/QZp8VhInZmAd1mmIonKAoPkt6TWQNGBvNfvwqOMix05yMReH79aJP4O
 I0iK8I0sf8t0lW2qNN2j+XTY4yGoejyWos+csxdDRtVSgLsatoEtk52TPONA0O7YfWEAzO6bJpG
 srusdscWaqJ2lvTNSyAykCqIaMYHBNw3+yNQUgde2QkvkMRgDo3IpMJK/ujTcKY2/WCrHJe7tU5
 XdRYGJIH8mYucwKU8lQnLPwdWWf5rtEZflICk43lh7JSw4VcRVYB9E3SY60LBANL3fjYXinsK+R
 nMlfXUCCOvLP1FeoQZQptqYZw=
X-Received: by 2002:a05:600c:64c7:b0:493:cb68:9552 with SMTP id
 5b1f17b1804b1-493ce4b66d7mr7284705e9.8.1783064543177; 
 Fri, 03 Jul 2026 00:42:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bf7efsm112394725e9.14.2026.07.03.00.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 00:42:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A8225F7F7;
 Fri, 03 Jul 2026 08:42:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@oss.qualcomm.com,  qemu-stable@nongnu.org
Subject: Re: [PATCH] accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for
 user-only plugins
In-Reply-To: <20260702171057.47998-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Thu, 2 Jul 2026 10:10:56 -0700")
References: <20260702171057.47998-1-richard.henderson@linaro.org>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Fri, 03 Jul 2026 08:42:20 +0100
Message-ID: <87echksen7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> In 6d03226b422 we set TLB_MMIO to a non-zero value for user-only
> so that we could return a non-zero value from probe_* functions
> so that we could force callers like Arm SVE vector moves to use
> the slow path rather than direct access.  All for the sake of
> exposing these accesses to plugins.
>
> Back then, TLB_FORCE_SLOW did not exist, so TLB_MMIO seemed like
> a reasonable solution.  However, user-only doesn't really have
> MMIO and this has knock-on effects, like forcing Arm SVE first-fault
> vector loads to stop.  Better to use TLB_FORCE_SLOW as a more exact
> exact trigger for plugins.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument mem=
ory ops")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

