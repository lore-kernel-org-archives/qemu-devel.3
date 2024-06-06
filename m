Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C473FC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9fa-0004DJ-Hh; Thu, 06 Jun 2024 05:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9fZ-0004D7-9I
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:44:29 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9fX-0008Vc-Py
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:44:29 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52b98fb5c32so1164649e87.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717667065; x=1718271865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Lby2FWDCzp1L2DNQo2idrg+Efh+C/3fpMfGpj/ZrzY=;
 b=Jh+H3PuQzP1z0t9LT1+kO5wYjU5CnEOIXnTIxy3qjDu/pmi3dEmE+r1IqfnMgPumwi
 OtgsmnJrTj9D8VS34+LlLHxOA9My3f4rkOHq4v37O/P0cOBNq8i3PdoQSd2Jd6Xwhq+5
 tHEA70+BOHLgkK9XlrJmrQF2WKNZ2Af3WDct4qVfq9t/BpOZba41WHBg9EzEoB2fhQNQ
 PGWJSX2tcEBdQ/8F2j8PBiUO/nXFM++rNgLuTSD7pNfETPukIb8excmJlaR6BjGPUAbm
 7YTljA2iK8s0UsP2Z/qz4RvaeJkb19CFn9Ca7Yq6O7oAXTDrO0u76WY2jfuUJGjC4cii
 Rlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717667065; x=1718271865;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Lby2FWDCzp1L2DNQo2idrg+Efh+C/3fpMfGpj/ZrzY=;
 b=NHy8GL84hFdpKTCSoUgAF1+hgtZp1D4WH56sYnFZYDh/frdW/eAxp4hkPRXijnKFY1
 dXfhWznfDlA//2BtJ+NSDN3QdDKrjcAyh0AG/c8J5WlvNzbXPDWfPR2IwStbkRLk2E78
 5rXogzMKiRmCMZHwfv9aJQKTE9Ii8BLvQIV7cJqoA1i92IyB3/ILKjqQARHTbKLxuW0s
 hSaZ4jSnCjszxE3MrbzPn0hWam9uiceuDhpt1DiMV10SXeJuxuiodBsqKRA5qJsqI50d
 m4PC/Vrk4UUh4ob8TQCv1Tj/YGTY1BygxwCYca4jo7scr2yv51gGscMgR/Vd4AUOBUut
 0/ew==
X-Gm-Message-State: AOJu0Yw9/Zh76VTNh3Ww+UrUhNY9XUefORs7tcK/oSyA1Tc9xy1+/WgM
 ByAgL8ccMGlfkDzS0HhupbuWG7YCyS2pCV0L7AFuFBRmzdrlr50oPagMKSjZ4z4=
X-Google-Smtp-Source: AGHT+IGoq2YbhjhgXYmTIEHu82NxVZtoqZHeLzBH8hh2BGa6fWzQ4ts9kQNhkSUThYuDMN4TXnR4lg==
X-Received: by 2002:ac2:5b89:0:b0:52b:8343:618f with SMTP id
 2adb3069b0e04-52bab4dc99dmr4302251e87.24.1717667065446; 
 Thu, 06 Jun 2024 02:44:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070e839sm72432766b.176.2024.06.06.02.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:44:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A973F5F7AD;
 Thu,  6 Jun 2024 10:44:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 2/9] accel/tcg: Set CPUState.plugin_ra before all
 plugin callbacks
In-Reply-To: <20240606032926.83599-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 5 Jun 2024 20:29:19 -0700")
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-3-richard.henderson@linaro.org>
Date: Thu, 06 Jun 2024 10:44:24 +0100
Message-ID: <877cf2mmmf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Store a host code address to use with the tcg unwinder when called
> from a plugin.  Generate one such store per guest insn that uses
> a plugin callback.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

