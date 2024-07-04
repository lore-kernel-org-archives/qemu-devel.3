Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3A2C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 19:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPSY3-0002pA-HR; Thu, 04 Jul 2024 15:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPSY1-0002o5-1u
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:55:17 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPSXz-0006oB-2b
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:55:16 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a732cb4ea31so170156066b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 12:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720122913; x=1720727713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JkTVbHyGeM3SBAtDHPEieTiZwbUjCWrUeYI4o1rC5hU=;
 b=tT/ueTCzgJZVYgZE23bkwrzgg01cKBv3uJ6zTXQN6w0pKZrZEvmexNP5lpI1kOuE6w
 M9+kIsz2g2zBszMZceAq8TbksggGn0oU7BX+N51oVzPLkA6Wc17kBZZq6hJ0IoE2W9vt
 ur0FvuxltCUIjxj9+thbrAlrZvOYUSLmdmwe9ZXVd/ONdTlX7WEr02EsiN8qwRiDHReG
 AQcpTNeY9BAbcujC86pPpy+qooBzxUkted9lyt51z93DBzCq8/RTjarkKxEZYWHQNWjO
 2anCSTdextlA7QMnLoO7RJDPPTUNuM1svi1l6XLH4erg1kYYeLDb+iVzl936sYkzNyOl
 2Emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720122913; x=1720727713;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkTVbHyGeM3SBAtDHPEieTiZwbUjCWrUeYI4o1rC5hU=;
 b=wsO23wHYxsPqM5n908Df4zgnjl2hTSr8EnEjTbZBvLWLOcGT3bVesjlKrkDNOMQOY3
 XkgHDl0pUBXL4XYDYcYyJj3HlNAtJ3xv+eDvlFYLXZGVU2uzXxYXz8wzwFa+B45XtHEh
 ydjCCDXYghNBtegGhO5Fcs1BbJMU/5HDxLBmtPvLSZp8o9QdIM+dDW00knW1xEiNW7FR
 5SET3ElsTHI6MSjp2e+pIz2938nr3cPbQQ+0UI6sBAWerbs18c60JHn7M6BBwWeGvext
 jPgBIpcDh3VoUZzSvVskTl0rcSX4TlyNhIVARhMYN6r9kJIJLEsBIKOKkaRu6Woje3tz
 VR0w==
X-Gm-Message-State: AOJu0Yw05Vw4kYGLrL9C3ozJz6l/VaeT14ghqJIgV/CUX5CEK9GDEB5/
 uDjV6FOVA3P0vRKOg2bKCPIiBnzMvk1bZhqMDSYeTHe+bPgPBTxt+H/TifrgfcI=
X-Google-Smtp-Source: AGHT+IEbwnpHgAFAh/0/EDNpcWpFIZhnYmdcrCV7ahLTdPDjepvOsZ7kixGzEYuy19MbuTTdzmeD0A==
X-Received: by 2002:a17:906:c250:b0:a6f:a2aa:a4c7 with SMTP id
 a640c23a62f3a-a77bd99ecaemr225676266b.3.1720122913051; 
 Thu, 04 Jul 2024 12:55:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c69041f6sm20183566b.103.2024.07.04.12.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 12:55:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8FB315F839;
 Thu,  4 Jul 2024 20:55:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  akihiko.odaki@daynix.com,  qemu-arm@nongnu.org
Subject: Re: [PATCH v4 00/14] test/tcg: Clang build fixes for arm/aarch64
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 30 Jun 2024 12:00:36 -0700")
References: <20240630190050.160642-1-richard.henderson@linaro.org>
Date: Thu, 04 Jul 2024 20:55:11 +0100
Message-ID: <87sewplyow.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Supercedes: 20240629-tcg-v3-0-fa57918bdf09@daynix.com
> ("[PATCH v3 0/7] tests/tcg/aarch64: Fix inline assemblies for clang")
>
> On top of Akihiko's patches for aarch64, additional changes are
> required for arm, both as a host and as a guest.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

