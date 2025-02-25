Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F634C021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtPu-00086n-5z; Tue, 25 Feb 2025 06:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmtPp-00086G-VQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:47:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmtPo-0004kN-6m
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:47:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-439ac3216dcso31831555e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740484074; x=1741088874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bjKbzVPk00o7e175/6bojvBROsWTOe6SU6NC3irojo=;
 b=OzTfdTh0fux7H5GQlcQrLXCNk9fMm0YEwUJhCwHUMS6bEhhAdLi4nrAC71l/il8mhQ
 W2Oc9t5Jft1u2g2aWtmpxgIwZZxnNIv28oqyXxuUWnGFvnEs/rnyGYYJflW5kIG913Vq
 ua+FE2stlqr0PqKvqENO8mGt5v2Pff/kTz1TX2Bzb8okY0DCCX37LC4Oai3OrzjxLcfJ
 69MJrfMuq3t7G2GbJ2wQeg2asCLtNTW1lsbEiRznQ92wOIgO3v8aBoYc1YM4UUAJHjaR
 W8FdnwgpfQzSsdycqo0GtVfqvcKaM/mTAMbvTt7kBzO6uCL/BGRzhJofe2GUjxdi3q5A
 MqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740484074; x=1741088874;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1bjKbzVPk00o7e175/6bojvBROsWTOe6SU6NC3irojo=;
 b=IbrK8YzWBuFafBT20sE1tt+zkTkZ40AfT8YCTirQQSTTYsxYYctAFWo2uRDeO2kSHn
 tV0yNQQU3tDoFNZSbVkq/USINRtPugFZqVwVCuNv0x6/84R5SSfzL/6fFHKPn2FrWNlF
 cDZNrDZWaE/M0nYbu0f9lUyzUXh8Nw2vYxO96HmnLjSNfh+vtmbiv4q6JDzNHAvaeDku
 H8iIIi8M32bn8rj50EmK9YfnZgBEePVIVxnk3auWipQKNuKGqGesPdtN+yrdoFS/7i0H
 +v+kMnfo9D/CJhbfaJ8AfKF3dSOU6Ie5Tvc+ckbrlTdw+1GHEFQfT9rOPWlCb9UBf6YW
 +GUw==
X-Gm-Message-State: AOJu0Yy7a64rZmQSkDxt4akdSG+CzUXMDar/Ehj96FzarVbNSohbxFZo
 i9RD8wTQJ6tARfTktUVxHXT0gGQAmg3ktlb9bwAuN9VBXwKINjlUtOUuvEX1G9U=
X-Gm-Gg: ASbGnctOuXimLA6QJe6iKNaFqQh73ZAlYBYTfxVKLKtcs74an3J/D3CGbpNBm1iJ3ll
 kRz1JabGMrSihTjJdmshBZI/gCZnMQj2Z7oEDwa3wR5ODp7E9gESr7LAnGkE1lIOzGcsmsH2kDn
 rW5zMuV6YLoF5Q5SiJRaC5jPZAoLQDFGZDkIW3dEjB/yxgCWaPYwsinQNJXea8sqnXsPZmNOgGI
 Z/LJtSddgZYEtC2cz4y+HAKMnZSr+qwJnZX2+XX4wnBA01nFFHMT6L4j60kRJZON7EGoAiM/A+N
 uN9HaEBYkieFQtpgUHg8NtDPHPVu
X-Google-Smtp-Source: AGHT+IHRyfxC2S9NLq8Uj61308xng36zAPuLlzanZr+TJusnvfhtu0g1lq2W+mhVD0rXAiRUFpsPXg==
X-Received: by 2002:a05:6000:1842:b0:38d:c2d7:b5a1 with SMTP id
 ffacd0b85a97d-38f7078b9f2mr14312015f8f.19.1740484074320; 
 Tue, 25 Feb 2025 03:47:54 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1533104sm23561545e9.5.2025.02.25.03.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:47:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 056625F7DC;
 Tue, 25 Feb 2025 11:47:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 04/10] tcg:tlb: use tcg_debug_assert() in
 assert_cpu_is_self()
In-Reply-To: <20250207162048.1890669-5-imammedo@redhat.com> (Igor Mammedov's
 message of "Fri, 7 Feb 2025 17:20:42 +0100")
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-5-imammedo@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 11:47:52 +0000
Message-ID: <87y0xu5jpz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Igor Mammedov <imammedo@redhat.com> writes:

> that will enable assert_cpu_is_self when QEMU is configured with
>    --enable-debug
> without need for manual patching DEBUG_TLB_GATE define.
>
> Need to manually path DEBUG_TLB_GATE define to enable assert,
> let regression caused by [1] creep in unnoticed.
>
> 1) 30933c4fb4f3d ("tcg/cputlb: remove other-cpu capability from TLB flush=
ing")
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

