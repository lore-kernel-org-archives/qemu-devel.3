Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060C2D3EE84
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vixjW-0005Wq-Kc; Thu, 22 Jan 2026 11:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vixjU-0005Vb-98
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:40:32 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vixjQ-00044B-33
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:40:30 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so12496735e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 08:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769100026; x=1769704826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuQo2MpZVaFGdVJNbnqOFBzx3kz0oaqU0Fh8o5Y94cM=;
 b=epRtfAWsy5BG+tE9QwNseuOuE5Pau9Guw3Tvt7/vMbvO6ibEkHwEAvwIqhmfwWDiI+
 HmKAxts6pTctpvBMQnq9aEBZ8h/01f0ENi1rg8GpreLL5bjb8IGAR6NCTgmqM6bnJkKc
 FF07yay/FfN6NuQOQI5UO5ZjdKsOSZsHtffdYVlkSnae1L4/1xFs+4eZBu4Vlg3frDJJ
 lup2ulBIB93qyEuUHtjdSUR0Iw7c3wKX14Qx5+v+XIuHu7k7E6EIomK6hjddcYkVxPc2
 GxgKZx/VOZqeKjTRnEcltbYphg644/uHErAPuU0fk89orLS+xsBBVlvXRhLVFuG31qzJ
 aNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769100026; x=1769704826;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BuQo2MpZVaFGdVJNbnqOFBzx3kz0oaqU0Fh8o5Y94cM=;
 b=MmHwGAb6nCoEJ9FTd4LAlQjA6m6gN9yj5kCMC5P1URyv8rtpaohY6KtwnUCTBhvgky
 yazy8w934g3HKorg8r0IykCzclNigL4jR148qpFW7Uwb2/pzXuRspxtZhi+aRZGhC467
 EixNbjqoOX/xr7W9l9ugETquXISXhH+nQgOBV3fAmSwNxC6skd8DtkjaqGGfVpbmkTWd
 SDYgpMS3S0OSUAYZMdyheXYscYIQsWr0/9JDs3jvT+UEBJWhCyucUIVOCQjGpzMPROpa
 lMjFhCjST54eSpTT8X0xHTgu3TpnilJdEFSIIvpRX3Zlufj8DQkkCJ1R2oBh8ySZ0boZ
 N/lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbv5XFbtGLtwJG9XmQiKdphcl2XELgmV3KwHKwygvUTjnxRnQjL57/xMm3ni+TqbvmBzj108LN4X+J@nongnu.org
X-Gm-Message-State: AOJu0YytDTGUBwwk3EtWRsNcnHms0pOK/8v5fKqw0DLAzswWNiJNUuGy
 zvGXFRnOo6fhVXmntx5bFEvDhXC1fma99IdD05/DltVovbKe3r8JplQjOWNn/xMutMU=
X-Gm-Gg: AZuq6aKxnDKSmGK13Z3+5ZQT5owksEY4MBRv21d7NshS80hte1PFFusq0vH3dcil0i9
 CU5yAPbkRm7xiW96IK5uyHGCINXFGmgAY3sp4/fLxqdM1uFICrwaUZ8274C63NY8IvQZ5pGc38Q
 Lr0sGtVPq1XTTMqH5KZY+g8YFqryRo3ZY2y5oIbSS+wSkrQdBqw2itbjdl0tuPG5DR9RJXiCGZJ
 AmlFTnpI8wSOOEw6ezEmDc0g/f5nLsDWXtrB8+tGQul+oiXuKfr/ZtoojmhvImuo9OhgmAknV3V
 tC1V8bpcoALR1GY+0ym4jLf0OmGHnLqYydu4xxXDVsm+lECGk4zTL9OjgOSKITEd90px6C/P6HT
 oEZRprNplj5JtoKDHTVqmGOespiWkFyEvNyktOhJbWA8OGd3tXHqJt571FY32kLEfjO+fsTiM57
 +lHQGyDaeQU081
X-Received: by 2002:a05:600c:1c16:b0:480:1a3a:5ce6 with SMTP id
 5b1f17b1804b1-4804c959d80mr3737215e9.14.1769100026140; 
 Thu, 22 Jan 2026 08:40:26 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d26ab25sm182035e9.3.2026.01.22.08.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 08:40:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A7ACB5F7C3;
 Thu, 22 Jan 2026 16:40:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] target/s390x: Dump Floating-Point-Control Register
In-Reply-To: <20260121222116.713325-2-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Wed, 21 Jan 2026 23:12:31 +0100")
References: <20260121222116.713325-1-iii@linux.ibm.com>
 <20260121222116.713325-2-iii@linux.ibm.com>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Thu, 22 Jan 2026 16:40:24 +0000
Message-ID: <87pl71mwhz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Knowing the value of this register is very useful for debugging
> floating-point code.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

