Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD668C54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIZ7-0000FN-Nz; Wed, 28 Aug 2024 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjIZ6-0000Ay-Lr
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:18:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjIZ4-000861-O1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:18:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-428243f928fso74341515e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724851101; x=1725455901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2yzVg4LuTlmOC/ofKU8UclzdWHSed5bQs8AP4DiJuKE=;
 b=WeWZlLzaaFLehfsP318PV0mCmoXxOoUynRF93dSB4qeFn1g2o2gSrrDw8uaA7vScnD
 IHZStTd+/qDMKapKGgsBYdhlWlqkeoxkgAm8Q4GlFqhsMEnvxT/x+U0Z4nFEz8Clwanq
 OruP1Nm7h91bzx1Pq5b9KR5pQZOncu0fzlMhVkSF+vCUZ1HIHxs+UJKxyTsGG2VruNke
 v14I0koLUrtI91/pDMQ1Z2j+P6Q5ohH+xzjuYcmkzsxEtfLPPRw4JkEDfSYc3gOQS1aF
 DaljCYdpBA/V9WPH50Ul5uLY7pq8znn80pT6iltoOCSVXhc4Sf+h+VY35XniR2D/CSDz
 BLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724851101; x=1725455901;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2yzVg4LuTlmOC/ofKU8UclzdWHSed5bQs8AP4DiJuKE=;
 b=UTQqcdTSKtuUgORBd13Emq4OTJmzmCsXGFyJ+D3OqXKG1AbwRbfpBZgMmkd1DG66XP
 A59mV5YBgEc0ydw6a7qlHznHgMztWmI/kDtpz11K7lFYu02ckNd7zDCL5T1NFA6HtCNm
 pSA4RMGmFee39l1iaPnzot6JVqMYp40H0qPwsoPHfEky9nuY7088MDOEPHOUxKcptES7
 A4+SXZX1Gro3dB9FrNukDbjeGnpjs6MtUMWaxJCPBvPc63rDsRNxAl45T3yZfmqvumCI
 llu/Gabj68thc3Y6tqubZLhfLo6Y0r6BmiCkQvZ5Xj2sYH3acPijMQnUuhkqk9RYtHCW
 8Rwg==
X-Gm-Message-State: AOJu0Yw8cahrcvr+NjsEu85G770rPX4UfuUOIbAZBIJgmvEk2UXPjaar
 Tk6z5DtOEwJ91irLVp5kC2XFbs5fPEVMDWtdWF3qk5Ra3xSiBArsv/dqDWociXA=
X-Google-Smtp-Source: AGHT+IHNY4KpZRVnZqeIwgzKGH7qE38QhXjsHpX6Ak1/V1gOOcx66rBddmyCf2F3aDxvwwCGzk9K8Q==
X-Received: by 2002:a05:600c:354a:b0:429:d43e:dbc3 with SMTP id
 5b1f17b1804b1-42acd5e7513mr143248625e9.34.1724851100332; 
 Wed, 28 Aug 2024 06:18:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42b9d9561b1sm40755485e9.0.2024.08.28.06.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:18:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE8245F796;
 Wed, 28 Aug 2024 14:18:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 Junjie Mao <junjie.mao@intel.com>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH RESEND v9 0/9] Add Rust build support, ARM PL011 device
 impl
In-Reply-To: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org> (Manos
 Pitsidianakis's message of "Wed, 28 Aug 2024 07:11:41 +0300")
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
Date: Wed, 28 Aug 2024 14:18:17 +0100
Message-ID: <87seuo3hwm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Hello everyone,
>
> This series adds:
>
> - build system support for the Rust compiler
> - a small Rust library, qemu-api, which includes bindings to QEMU's C
>   interface generated with bindgen, and qemu-api-macros, a procedural
>   macro library.
> - a proof of concept ARM PL011 device implementation in Rust, chosen for
>   its low complexity. The device is used in the arm virt machine if qemu
>   is compiled with rust enabled (./configure --enable-rust [...])

OK I've finished my pass through after running aground with the bindgen
problem. I shall have another go on a Trixie machine once
I've caught up with my other reviews.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

