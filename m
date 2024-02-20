Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC0AC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUS8-0001pd-Ja; Tue, 20 Feb 2024 13:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcUS1-0001oH-2x
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:02:42 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcURz-0000Ja-IF
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:02:40 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4126d65ace3so8684025e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 10:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708452157; x=1709056957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgVjlUJ23f7cpGu4Ux4UGTB32erhFEdDPaw6i/5FGkQ=;
 b=muAVOZN3w8PfuE6iJwupqrAz3d7wWAVagv7Y7CAjykJQ1hY+F+KMLhCVd1c/RbzjIH
 9DIIqAblmXyXoxpFt6hN1dhc3nl8CU0tOl0LphUtXslauHl4FGhhiv/C7A3ecNC6PMbf
 igyBnzFqT9+k33QNvgOGyZiUbLBbkf/8ekCOXnBMvZfQq1GrfG0woho4B/UKnSHgVF7G
 s1Z1xVf2gdkFQiIQOIEAY7/Kit8gYkI9GgutFwPOkrJlWpufzuBLL3YjaPHwkEknOHL7
 PQN6zCR7YiaHXMq+YvW9j7iTtnmPPFj7zGoE5qUoNuj91rp8CBxNasBTnZ8TfoACOLDs
 L7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708452157; x=1709056957;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SgVjlUJ23f7cpGu4Ux4UGTB32erhFEdDPaw6i/5FGkQ=;
 b=mNKhLo46zxg+1EA0NYXuezBMpalcyoKd41QY/w/BYeroXdAFhhen1Hn4y89r9a1xrP
 lhQ7or2IR9VkymYPpYuTRyXZeAqUGe57S/wK1IaMtlTu+mJmsFrWQn299whVrOMLckDW
 CECBXEMr3rRSYFwSi9MXpciSqCyf/LPOJtcfVaJGPcWMZixshiySQtXx912T7b4k+K89
 NeNWwDsFMMQIUNxkJrhdJ0t6oYtBtQbD1NvUYmRenGCf0GPQFDvGfFoJIgo/5oRFVgU4
 T0G5mbk1qJOluxN9JVa7WimrykyY+8ItmBrfhwAhP9MiUL4UxaBKoUNU/UtxU3eD3WC0
 q/Pg==
X-Gm-Message-State: AOJu0YzvwtpxaYB6oeLAkD9wJXhJ+8MbDMnV+cP+abVaJodNT8VA68BB
 klDmI+pSpnEgxN2A7wMD+eAZ00gBtJ+o1MPvii9kc7hXlPQWJd83M/8UC0kZKs4=
X-Google-Smtp-Source: AGHT+IGgJC/PYtMg3Sy/8fa38dIsQ1agr/p2tlXaWRmytqMGXwF0vw8ZzfHB/6pHzD6VOO6qrr3lcw==
X-Received: by 2002:a05:600c:68d0:b0:411:3673:1c6d with SMTP id
 jd16-20020a05600c68d000b0041136731c6dmr13450691wmb.37.1708452157185; 
 Tue, 20 Feb 2024 10:02:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b1-20020a05600c11c100b00410cc2f5550sm15012037wmi.19.2024.02.20.10.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 10:02:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 848575F85F;
 Tue, 20 Feb 2024 18:02:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 2/3] .gitlab-ci.d: Drop cross-win32-system job
In-Reply-To: <20240220174412.155885-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 20 Feb 2024 17:44:11 +0000")
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-3-peter.maydell@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 18:02:36 +0000
Message-ID: <87h6i3au9v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> We don't support 32-bit Windows any more, so we don't need to defend it
> with this CI job.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

