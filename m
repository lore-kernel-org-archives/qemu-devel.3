Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2816BC021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDLV-0005oz-IJ; Wed, 26 Feb 2025 04:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnDLT-0005oa-KP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:04:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnDLR-0000JI-2T
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:04:47 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so43301655e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 01:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740560683; x=1741165483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzomA0cGg9RpgS9QyWeUwhgCmm58A51R7Y1ZW0F7GAk=;
 b=xHu5/3wtajTh41k71KwZsBar6rYfz70YLyXZ9XsNOuqs4jHkvFF9nEkK5HVfYn15Ri
 OzGl11ePL91sFNp3emk93ARi6ILC8A7VG6I0yRR8BOy9HFE/XUSt1REHbjOcU4A41kG6
 bUC7VyIVDZ+CvtabfzzZP2kQm51DD6P4kGV9RUz36XmJnJWJpLZhJQ6i5DtZHf6ZGBRX
 UVyjagg2j2xfN/WMRgAFhGehq1f2AHaiHHGPMqvIP6uA9EwbdczAwSAZx5gir2aB5neZ
 fM3B7n7Tw9uqwCQ5+nxpoPxj++Dc+GqZ8P9Rt/MkNGmzLQ4v84jtM5n2jZEwHmPeoEoP
 19qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740560683; x=1741165483;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mzomA0cGg9RpgS9QyWeUwhgCmm58A51R7Y1ZW0F7GAk=;
 b=wWNSWu8jJ3PfiAatVfCTAqhG+EIUXcVfFs2HUbiXniuYxEgF0oD2D0VCl4FHrIDCaY
 XPJg1nfU5GiriqWqr/Kq89kRdnQJqGfyLOGVX+jHuGhcM+GXyprQuWAXZAO44E5Q5fS1
 1YG/Ox+McOEs8Bi/w1z2IoXlncvqTtc/ccQOTmO4gOK7aUD4nUglBZQnxBajKV3KtAEV
 qLixVdJOshRZXJRdDP8X0fpdOfDyk/gfW9FzwJeG+K2xccXJ8GXKnQHA/f+hrRel8jzl
 cisN2/dEGjmoSVvi4irkFSVc5lvwcxCxccdxaCkZ0DXQsoKmG2oBnKOxT3XKcXwlGlrp
 hqHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeCW0HPaV0hlviTFtgKjVFTNtIpAOkWKXrPbw+GUEmP3CpYL+4kgVLN9pqdrgzrVxCN3h+Haa8akWB@nongnu.org
X-Gm-Message-State: AOJu0YwqnW+hDqBakBttB4tCyKE4m0jPCCeC02nMIDUavaeEScIYjrNy
 aPXS65+YwO+hI7qQV2DvwU8fPGz9EGx6pxnsSQbLkYUmo/LXzHT1gm1c4Mq4g0A=
X-Gm-Gg: ASbGncuYcZmGcvoRPlNpIOamHQbmzfbLDlDxH3g0tIXv3VIfjOSKf6ee8il3mCZHpLK
 1RtmJJ/Sx3CaLaYsqOKQ4qwaed/EcSsFYz7k6BYxEFYWMl4Ax8kn4WhDhqS6IMGG2J0gCASeuO3
 pFJE6AnteUmLER6BDFcqS7jGml0Mm15D/kTQCREBxJQNP4AGtPA2SzhPe0MgagQzie3ciSS3gEN
 kZeMYQZ2mohS1F1I5wio7JNHqKhh4gCqzhGgRCjWvGeLlMGUERtS5AiTT4oSX2ajxlmJ4m5uZ0O
 QUdsBxpdlYUS3ghtecXrfm/f4DiS
X-Google-Smtp-Source: AGHT+IGSv29icUpxAAd1Pp0jndvZHl8O3xlSmCb7nMg307KVV1V+WoC77QiZ521UqrC4xcFQuI9dtA==
X-Received: by 2002:a05:600c:1547:b0:439:884c:96ae with SMTP id
 5b1f17b1804b1-439aebda78fmr156062315e9.27.1740560683209; 
 Wed, 26 Feb 2025 01:04:43 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba543ebfsm13825485e9.25.2025.02.26.01.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 01:04:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A24225F87C;
 Wed, 26 Feb 2025 09:04:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH v3 1/9] target/arm: Apply correct timer offset when
 calculating deadlines
In-Reply-To: <20250204125009.2281315-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 4 Feb 2025 12:50:01 +0000")
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
 <20250204125009.2281315-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 26 Feb 2025 09:04:41 +0000
Message-ID: <87tt8h3wly.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> When we are calculating timer deadlines, the correct definition of
> whether or not to apply an offset to the physical count is described
> in the Arm ARM DDI4087 rev L.a section D12.2.4.1.  This is different
> from when the offset should be applied for a direct read of the
> counter sysreg.
>
> We got this right for the EL1 physical timer and for the EL1 virtual
> timer, but got all the rest wrong: they should be using a zero offset
> always.
>
> Factor the offset calculation out into a function that has a comment
> documenting exactly which offset it is calculating and which gets the
> HYP, SEC, and HYPVIRT cases right.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

