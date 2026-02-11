Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D134ECD6E0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 19:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqGCn-0007Gt-2u; Wed, 11 Feb 2026 14:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqGCl-0007Gk-NE
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:48:55 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqGCj-0001Le-FW
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:48:55 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7947cf097c1so55437427b3.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 11:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770839332; cv=none;
 d=google.com; s=arc-20240605;
 b=WzqTMSs87t0F+OzXqg6sJm/yp4f3ebbkJAXUiT209kMQ1q1hmL6rDKA2Cb7gNUwjC/
 CErYiTalEvSoPKpOyOkrMWwDiPVShaGOiSI89G0RNOcaJ53GkaFx9JQ+CSGSROnC2Uro
 Val3oeRvQ+jSf59h5QuYGzRiUwnCpWmFDgbFogzkdwO1+pstACpoiSRznruDt4EM4ZPv
 mDHkJ00V+fEHahWNw9uyTqfVdBxHyanVlSl4Eq7WrKF7t50IKXCDyqAYu84a6nabY0vy
 FKQbAB7Rij8bF1aThjI+MCJtv5dmZ8ZmlfbO4teOHygSmdWWry5x34HV4wuzvRaZOrTf
 T1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5d1mo/wmrZUCSU4AWBTn9DArqFqnLNSoSXd0rH38Fuo=;
 fh=2oELGECO+avhv5ZhKT1HV5UhzwhHELFfZHQ6O1Qe/u8=;
 b=Aw6pf8z1wN0eZ/aQSNM+/XeSPCMW5U4s5dXNQLlwuFRIz5DTlREkdDv54KvfKflbOx
 iwcS96t6GjU8XW94TvLprI8DxI2z1TdPUtGjzxyVM3jDeBSB/wGQV5Y33CareSIb5o7z
 sAqkyCarFRliaKm46SMgr+fs7nD7WYupUZrYY52d/v9y50aZPqGjqtbwql7JzAormSu+
 5mpRWKtX26AOaLyoONpiQzfTFyjQ/b0AfmxqNLDp8mkO1nD1Pcxw1EzrX3ekPMlfDaqi
 MzSYOjZ22txZ567u95OgPgpElcN3asV3Nm1EmhKS4Giz9c/X7k3Pz3s8vNV2dOYfOObU
 IKUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770839332; x=1771444132; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5d1mo/wmrZUCSU4AWBTn9DArqFqnLNSoSXd0rH38Fuo=;
 b=p3WqcnqmlgNjhbnykqASe58PL+TZc0UzoOu7FGPeWNG2QgCzeKZ2yP6bghRqcZdxvF
 WwVm6Bk0JM20ho+1QUsdvD9THok/wUgoJJyWl4VLjtb6KeotVLZFnxxdx/7Qn4jzkdTe
 48Bjto35HlWTi2LW+zKtHyWJcbKC61dWSTUkBQ/iZ/+GajZDMuXyhTAvE+UJKUJQygUm
 OdQaDxyRU+rX7TeQ2DUOjKQRWrWE6dD1y+Ii/ez9KoIMKlJw+9vnPUlijfaB9IJUgELA
 NIEEZcG2zN7UxS7zMXxR2Lr8wFb2thY2GhFed4Q9XxzJHjVqlrZpK9ykmrPFCde1Qj1l
 5AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770839332; x=1771444132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5d1mo/wmrZUCSU4AWBTn9DArqFqnLNSoSXd0rH38Fuo=;
 b=cgiGQQiB/ieyTn1g0gA0NAcpANGkWvD7F05cys3heJtEX63jz+uNID/Vb1hiBYBqsk
 DafZZ+q6AlWxNwiWQfU7tSZ1JSxuah1SV/RBqt8BoCpSEo6NbJSQlGlHtSPKw9yugnks
 ymUXORZfQRMZF8DS4suSu7VbWSKomkZbZE/xhhvqKZtP51CXGXhC1kN+tiZkiYWNtcG0
 8q9QWxIhpFYh1Vg1izOL2SmeMVUt7HuFjpfe2BV8JqNAwjg80fe7LA/GjIjTIP02RWNa
 z3RwHt44axD1erBC+40E6Ua9yMjgiz6H3PNGF+q2cBZr8EYWll9PC8jVj9RS9yFp2LTo
 DL7w==
X-Gm-Message-State: AOJu0Yzu8fDMymgcXubGTfR4pWn8RmWUOXt84VFBUwjHTmFibNOL1Zm1
 fQKttpcBvVWBBTka1gEqp9+hOuB+ZQJxhSjPT7jk20P0hTp+9TphsBDz16veX4QVP1Elh3eqv+K
 G/Tx681OiK1vau7KIunx6Wd85N4Cm8l2zhLhaSP+QBA==
X-Gm-Gg: AZuq6aKo7eTAzvKaCSvssLw5m9TWyRdZD4nMM7bgpilzvjOdI1WEfML+uAN4z5cSBlo
 KVxoFgw4khyu4cfvgMhGBAdRpHXIhZuIY7f4N9Vz1fcWAgzZdsioYlifCPR6GSteMzQdC0kvk9p
 aYG2VtOLOYwR+0xghq3TRKnaTw6cy/7o7b2AGqPt82MLSAO1pHaC81f3KX+yrwzwvD9fa1dTIWt
 TPc5mZM7CDaO98p9Ejz4elIUBNTYYqIytYUez0zY4AUbk/Yu0jzPwJmOMLfezWvZmxyjrLDpGPL
 6komv3z9FPEaRRAFENawTWa5OyeyDdQHxDOr00xFyuJ7g7hS2k6oKVVT6J+w9eurzsI=
X-Received: by 2002:a05:690c:e3c8:b0:795:254a:b3ee with SMTP id
 00721157ae682-7972f9c9607mr6817747b3.28.1770839332303; Wed, 11 Feb 2026
 11:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20260210154801.1662032-1-stefanb@linux.ibm.com>
In-Reply-To: <20260210154801.1662032-1-stefanb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Feb 2026 19:48:39 +0000
X-Gm-Features: AZwV_QhojKo0oX_OSBES2Fs-qjBdIlQYFJ-9ev3vx5KRvCajV2lzXa5lVvGYtAA
Message-ID: <CAFEAcA_1+xc_DvvEWgx2HsAQw-BsoD2RQrbU68XFzLKZFF1-aQ@mail.gmail.com>
Subject: Re: [PULL v1 0/3] Merge tpm 2026/02/10 v1
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 10 Feb 2026 at 15:48, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> Hello!
>
> This PR fixes a few issues with error reporting in the TPM code.
>
> Regards,
>     Stefan
>
> The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:
>
>   Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2026-02-10-1
>
> for you to fetch changes up to 46565a8db1fd1e41485341fcf51527047551f6a8:
>
>   tpm_emulator: tpm_emulator_set_state_blobs(): move to boolean return (2026-02-10 10:35:55 -0500)
>
> Vladimir Sementsov-Ogievskiy (3):
>   tpm_emulator: print error on error-ignore path
>   tpm_emulator: drop direct use of errno variable
>   tpm_emulator: tpm_emulator_set_state_blobs(): move to boolean return
>
>  backends/tpm/tpm_emulator.c | 59 +++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 35 deletions(-)
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

