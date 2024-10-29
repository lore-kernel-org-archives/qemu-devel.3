Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36462D3A675
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 17:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5pfK-0001s4-MP; Tue, 29 Oct 2024 13:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5pfH-0001rk-SG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:05:55 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5pfG-0004li-9d
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 13:05:55 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso6944104a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730221552; x=1730826352; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VsKA5yUCykpyGe2Gag/8i+s+VfUkkJK/EU1jMr3m3b0=;
 b=GJQQEgHNiw0NC75GZMzIF1CHkeNP400X1XwPBTUeuUyqpqKOkQ2PEPPpnW/wDVNDLZ
 zc1qVV346qFGWSqHaTnYJyw0Ij3Ww8EZApOYg8gcsni+MmikYe8b9VoTgyB4u89Ii2pB
 aC/El5lFSHBh+LhR429MHJSb/s2EdrRAvjoDoUhtCGa6vpxrMEOS9+c+ufCyQT0bFUkk
 jYoxqaafAL2qahO5ZLSneEzonjo171AuZ1aP+yUpiciCDCmBxjwKUhVGO+RGNQS3oD1Q
 hUxTqrVNZ5/Pn33DNebT80wz7OSHPkpCZCTKFcoh4FSXMtKE2m1YXxjFk3dXOTGJ5X0K
 VBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730221552; x=1730826352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VsKA5yUCykpyGe2Gag/8i+s+VfUkkJK/EU1jMr3m3b0=;
 b=aYQTdMB3ig4S7pgjc3jywLwhInk0B0h9Tqg6RQISV8KOrcMqFGOrazLhVuAMzvCvVa
 S558IKz+Av1kLupumrSDEeLP9EujO40zsPlgu3ec5LmO4S02WFQxH/7EQG/dXEbp8fo/
 CXL38wOQmrDbgvZ/CNV8v+hbfNzlGVjUArH0R0cvaD0R9AdGYnymnUdBulfLoKJjwcoV
 Q7vCgYu0jvkWSCciy1PQZUIiuk31Yi9CCRcKePgkLIyqUOTUqdRdfdmjoWyllyiTojzb
 f50ZRU8hGjFTJTIo7RWzBb8NigmfZMwengebHWKz4h4YcS1sWEGDjnRUrT2DoRAl4Uq7
 3ctA==
X-Gm-Message-State: AOJu0YxjUXnHOxiGbCtLq/fYIPq5lSHw5I4LnjcYIJd2smlTD76KsOKP
 DkeI8WVa8XQXMia2Chmplo/wQrv5oc2sP5l0DqWGyl3GwCPvd9w4zNw7N2St5teHLJQ2LY76TN4
 JUyIKpOProvz/FGr5ChY6NCQhwwk6u6yazCq3AA==
X-Google-Smtp-Source: AGHT+IGpCZE9US7F6LoXBpVvuV8ltsKENyjlPdpm9PTiLhhiJ+da3LWkIZXeciiQK0XjwuDE9SvbD7+zhPNu1gVIrbs=
X-Received: by 2002:a05:6402:5107:b0:5c9:8ab0:296a with SMTP id
 4fb4d7f45d1cf-5cbbfa62b4fmr9838385a12.25.1730221552268; Tue, 29 Oct 2024
 10:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241029080705.3238-1-jasowang@redhat.com>
In-Reply-To: <20241029080705.3238-1-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2024 17:05:39 +0000
Message-ID: <CAFEAcA8OOQ2_GHJwnpZV-nfQ8hpamq5T-sBAiMvAYkk8seeLhg@mail.gmail.com>
Subject: Re: [PULL 00/14] Net patches
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 29 Oct 2024 at 08:09, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2:
>
>   Merge tag 'pull-aspeed-20241024' of https://github.com/legoater/qemu into staging (2024-10-25 13:35:22 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to cd76e8fcbe1a340776ae61b4e182be3a45b26219:
>
>   virtio-net: Avoid indirection_table_mask overflow (2024-10-29 15:53:29 +0800)
>
> ----------------------------------------------------------------
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmcglKYACgkQ7wSWWzmN
> YhEm/wf/cYA7i3asKMUoYqlff5mBiY3aFCWzTR5qHLBcWfnB33f9FYpAW6RgDwMa
> 3aFAJm1VZAynmUWgz+f537+e+7900M+P54zbD7kHCthAy7l/E7t9SkKNpe6jZHEA
> P4hB09CSKm/TY1XtsFMvO5tkF9IgY51VEO+mZJesO1H2X2+3ulJYusx9fh/P6yST
> bG8sbXr55v23R3z4UOovqfkuskPETwRh3qoiOLPPBy8CWkBVze8J+siC7HC+eFIo
> KrQ+jhUYpIK8CAgHV09ZnlurLo6UZ0+vlo9IcJN+GQp/gsmg8OErjvzPdKKbynC/
> 1zjvkgyW27aHsei+baTMXGCE0P8dIw==
> =6+yo
> -----END PGP SIGNATURE-----
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

