Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FABEF8FF0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnZU-00011U-Ru; Wed, 04 Mar 2026 09:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxnZR-00010l-2V
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:51:29 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxnZO-0005Lp-RK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:51:28 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c187dfc82so10731366a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772635884; x=1773240684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPYXYvTIGA0fsHs2INz/i9YJKEWs32cUx533EdVlXKs=;
 b=HGoCC5hyPrQfNcqGIE7rz8MZ6ybCPMMo38FJDdTYi9Ey1Zl68CjEq3plw9LiDT9gMU
 /Tmeu6gqZrZN2n4CCOn8ahGL0yPlewG9NZ5yGucVremWvOcpedyV0rzAdP8DwUv18uLN
 w/NhKq7ZHhDEHltq4X60ZLi66AN2GRnjwdpFpu7Ej82yZeZD0kktOZA0NoYTVMSgto8M
 Ak513UQLqQnRgOWOgoTScmNFcAEGPyukpCC0k8zhWwkr+9xTLtnrUBMcsQJCjbioWSTl
 bhCEqN2rZ9jTUpBrlmOX2UhmhKOqEngtQqNPfWv1p4XIUXbm10/LtUX1FTrjuTxepxIC
 z8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772635884; x=1773240684;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPYXYvTIGA0fsHs2INz/i9YJKEWs32cUx533EdVlXKs=;
 b=Y3mFEccSzHEY5u9wh0TniN7Y8l0Xsgqa0eTPnQ4FFF8s8MnfzjOrk1C9pQF+jQ3vrO
 khN4503aw3Hoif8aU40DWZZRUhx2e0xi3CQ9d1aMDutznivhMVUfnjlVxezKTT56luIg
 nW+0XUNYmO5pFi+RBTHc0GFJMn4HAWi6F4E4ZYFic7USEqST4lU2eauofqOvF1yazzaJ
 Vfpi4cLpbffWsAyF1gMfHvBsXdyFdV/8HTVNUc9Zj4rqqG215ahjyUbW26hGLd1IrM66
 wdXfz58gIcxvQbcPjQ1Qw71dUz8Fl9A3SCBWotYRd6JqnpKhjg50LR7JRv9eQv/xuyet
 er0A==
X-Gm-Message-State: AOJu0Yy7QV5lbfuLhSzhr/fsWcMfJXSa9mc00dGDU5DxA3MQq/ENL3/T
 FOR0cLHRxQFaYMa+35t/Vzv8RzxN5/gPotPUD5zOy3Vv+7fVYXCOt+v8+AS3kAyE09U=
X-Gm-Gg: ATEYQzyTAnB4qauZ8yosRzOgENEM2AZW6ahfiCMLR4QuI1u25Q4jlce5jpkXqRL6KZW
 PPo0/7LBhG+lhahY2hshvVEOAcV9f6NxqUnERfkYOLI0Dtk9jFYDFjEhFtLpiSe2lDyNvT7xd41
 cS9aA1nzStBxIXrBpTmd2R2oGzisB5WjsoQhoQ35c6tDXspUsE+1klcBwmGSg0O5PRu7REHSZEh
 mg6OCVWt0ZN+bqtkViA6VgQEye2JES/awwz9cYyyE7R1NozDZufWsAsDrj5E5zgYflg/tNE1e0Q
 nSuEGzm5VGABKTGhdTtjOg4aoSdF8EcxkZyNzLXnTtOhg7EmpOFhu4EmokYaLoKtg81+n9CpjLl
 hZIl9RSOG7GNzPo3ih31cFEtJmLlB2smHvAJkztG9KYrS7y8fedtO63WHyKuTf5u7IG6eFp/nfT
 reg7TuC4DnsyeasjBkUN/DXng=
X-Received: by 2002:a17:907:9607:b0:b90:71a2:3e76 with SMTP id
 a640c23a62f3a-b93f15e1f28mr114520466b.61.1772635884114; 
 Wed, 04 Mar 2026 06:51:24 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935aeaff4csm750667466b.52.2026.03.04.06.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 06:51:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 88B3E5F7F5;
 Wed, 04 Mar 2026 14:51:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com,  marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com,  sid.manning@oss.qualcomm.com,  ale@rev.ng,
 anjo@rev.ng,  berrange@redhat.com,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v3 1/1] tests/docker: Update hexagon cross toolchain to
 22.1.0
In-Reply-To: <20260303210553.2044313-2-brian.cain@oss.qualcomm.com> (Brian
 Cain's message of "Tue, 3 Mar 2026 13:05:53 -0800")
References: <20260303210553.2044313-1-brian.cain@oss.qualcomm.com>
 <20260303210553.2044313-2-brian.cain@oss.qualcomm.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 04 Mar 2026 14:51:22 +0000
Message-ID: <87bjh3ps0l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Brian Cain <brian.cain@oss.qualcomm.com> writes:

> Update the hexagon cross-compiler Docker container to use toolchain
> version 22.1.0, replacing the previous 12.Dec.2023 release.
>
> This requires upgrading the base image from Debian 11 to Debian 13
> because the new toolchain needs glibc >=3D 2.34. Additional changes
> to accommodate the new base image and toolchain:
>
> - Use DEB822 format for enabling deb-src (Debian 13 sources format)
> - Add libc++1, libc++abi1, libunwind-19 runtime deps for the new
>   LLVM-based toolchain
> - Add zstd for the new .tar.zst archive format
> - Replace pip3 install tomli with python3-tomli system package
>   (Debian 13 enforces PEP 668)
> - Update artifact URL domain to artifacts.codelinaro.org
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I assume you will merge with your next hexagon PR?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

