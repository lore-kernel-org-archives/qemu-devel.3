Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE16C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 10:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjG97-0003c7-P1; Wed, 28 Aug 2024 06:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjG95-0003au-PU
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 06:43:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjG94-0006zq-4k
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 06:43:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-371941bbfb0so3813551f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724841800; x=1725446600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5wRC4cfjfI3/PRMPjKYHL0utoj3RZBCE+nzkXvW6vzo=;
 b=pO9rS2HCydpKMiNx3Jr7ZlrLEI7njTa6omVsw83d1fy5lhz8oE1wIX2GtkOd8ZIjZH
 kJ/Q0ylt+iwDjzDOf0/UmT38XwxzcnDtCwPItSYoqY9QP8xPbomDuci0GIRAoc4OKRm+
 wwpMYPONE5u+pGHduHqJHifklaESffbVOlxjYyNMCJ4gTG4+QonQsYmF/bcqK2pILk+Z
 5iNwJp4sRcaSQeK4a4iIU94YgX8o3Uyy+akGIgmkEHcbhOZj8UT1smAzpi1Bu38NNN3Q
 qx5C7YQkkzvppd06nCys0ADV/rsFxWS2idOruBsIUFB6pmaHvtzy8UzxKvXhrHJ1l3En
 m+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724841800; x=1725446600;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5wRC4cfjfI3/PRMPjKYHL0utoj3RZBCE+nzkXvW6vzo=;
 b=Ak+TFda1k/cd4eQV0c+EuilG2lCI6GlW4b7y6BDvY+FyGoCdwEBsI+e9Lfd/U+389/
 ysDI64zTGNAj+WPBrB/F41f40lXrdPJJMFA54CUPRjID1GKMZDsW2SQ6ta7nhBfd4Rfp
 llhE1aWC+HdguNU2HxTKkgxnj1KnI869my9atoKZQOyHulkiihM4+refLTC5B+Ica68U
 8LngJvMZH8CoNmXZ2ovEB7QzAxAWdkiS2ky+7TsgJC+hbmLdGYOC2LKNBJ8ZLscQ1X9A
 UXHpMSBt6eFQ7u32pKgh5COaz9cIk+NYSALhSN4lgOSLPEKc9xgamfI4gqFOpuGfitrL
 mgPg==
X-Gm-Message-State: AOJu0Yw1g3xX83KR5puWf6IApdAVqPJqOVbobk2fimqq5sEyWzWjsEPP
 YuCBbDUpfcW/vwfgYqNOK/HHWn7IopGHPcKhDf8+SkNUmpnlXE6tTd0ke9ao8fk=
X-Google-Smtp-Source: AGHT+IFjFSF8nr0/Ai/8WsplHRldPs95mj73AGMEx/epOM46Wj9Qp6hSV42E3ZrFGLKnHengqKkf1g==
X-Received: by 2002:a5d:4682:0:b0:371:93a1:9d3 with SMTP id
 ffacd0b85a97d-3749680dd9bmr1170918f8f.13.1724841799186; 
 Wed, 28 Aug 2024 03:43:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba63ad364sm17288425e9.28.2024.08.28.03.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 03:43:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA2405F796;
 Wed, 28 Aug 2024 11:43:17 +0100 (BST)
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
Subject: Re: [PATCH RESEND v9 1/9] Require meson version 1.5.0
In-Reply-To: <20240828-rust-pl011-v9-1-35579191f17c@linaro.org> (Manos
 Pitsidianakis's message of "Wed, 28 Aug 2024 07:11:42 +0300")
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-1-35579191f17c@linaro.org>
Date: Wed, 28 Aug 2024 11:43:17 +0100
Message-ID: <87le0h3p2y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> This is needed for Rust support.

Just a note that b4 will fail to apply this as lore hasn't archived the
binary patch. However it applies fine manually.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

