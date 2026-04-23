Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F27FDEE51
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG2AM-0002pH-Is; Thu, 23 Apr 2026 18:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wG2AF-0002om-Ol
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:04:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wG2AE-0007OP-CG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:04:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so73204635e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776981888; x=1777586688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5zW5k+LKyZVt8QQbuUCh6+n8BCos+yrt2FVNstn7Js=;
 b=IC7bVRXGJv3tw1XNdwoFSpageo3WYwO0LCvtovZC3KEpUxzNZ13y4YENbkyHtkZv9b
 PF7IZsrZvjLbmzR+rrqFoXn9h7RuPjKaQ11lC0NXaLtp6pGmJqp3kxIZJURpZmZnDpPI
 mcoL6R+xvYgi30yPhDrYaw8oncNifA/wTt+fpTOmRh9MiAnV69uDdsB4MT6Mq+lNyYxY
 qbHI5gkrvzfq0M6PZXVYqjtP+WKYR0N7/lVzAVHHeF5aCUKPrQJ1bvJQj2HKxw2w6wT/
 hKkgtesuC4X02tgu2FyTJLJSk3Dfy3Tl6y4xErNhLE0FMDFuzs3HLwR00ZDprL4GNGiX
 +X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776981888; x=1777586688;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5zW5k+LKyZVt8QQbuUCh6+n8BCos+yrt2FVNstn7Js=;
 b=cGHlihgYJM1CL5G+I67zhdY0FwwpTgbg1PZv9FPiznWrmkrRChzpRGdKx+Rja/dSa9
 8WTWiDO/ng0K3e610bnZXXYgqDxCYvaZ+CrGNzGDZy186jKN/GHyAIQHPqZD4WNKAbw6
 o+V7iXRdRQoBUlLJDumrV1u/ElsgrWvm+FJdTeNCNWWaXwldY7lc3bKYl4tjuCxWi6hX
 jxrSqLnxvvRB3Y5/NbjCyEe8cvgnxnhEt24mdLd6NLuqMbXdJK4yxEL7JxVhFh0loksI
 Jn5jcYK4v4dK3CQp63fhPTj5i6Pykl3yeMGDL5H88o44TAQWR/h8rxTbxmlwANz02dPA
 CjgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+M+9pvLxPdfqVWl9JXu+672BxFpsuvkqS+EDAnuTkIc8WV6Bz/MSRF8UtGBAEkY5UIRuG8cALIC3gf@nongnu.org
X-Gm-Message-State: AOJu0YzTaVa+QdG3pgJqrX2jkzlwrnkz0a126NOCnvMRcAqgYLMFXzae
 JCs9jO5mpHZkXANn+uo7eLQ1SJJZcfsGeLTnCuA6pL4xu6uArDYxokop7VpG85ky3ps=
X-Gm-Gg: AeBDieudOJL0HTGfLaNrF8sDwiyD1FISjp4b9PKhzG16TOTW2+7M7p61Qqy4cs8JuNe
 nB+mYjWdnF27JatMI30VQAgasi2dXkCclqEBZeTD1V72vWJOf1k4FcWiyOz7r6qCXHspEekc0+9
 kVzyOBBSGTQvcgL++fQ4mZVw1oQVLIleROVlMpxf4X/V3IvoXgSBSycOJBu1hepJspjO3SDe3tD
 jj0kGazaulUsxW2XK+ClW/fvnAhL5OeOPnssis0otjtWXfZIB66tL+W1p/JMySIal5u+/vecY1O
 BebOLK2B6IvOMgOqS4jhYW/MJLvbZK/MJovvUOzvFCNNA6DI61erryHUR0lNd20gsYRPjNx+fzV
 bU6YL2AxWkBc0sSBJTD+wcbcffyoQLrSefXOGazLrl+2srb/ohNN9wdKX4EN117/jOloRa83GKu
 D6zxkxrIGE0XdGfQW8b/mVp7/k0bm3nlISYMY2+uaoiCLo
X-Received: by 2002:a05:600c:1554:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-488fb77810bmr425165605e9.14.1776981888062; 
 Thu, 23 Apr 2026 15:04:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm620236695e9.8.2026.04.23.15.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 15:04:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6ADE05F941;
 Thu, 23 Apr 2026 23:04:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Helge Deller <deller@kernel.org>
Cc: laurent@vivier.eu,  qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer for linux-user
In-Reply-To: <20260423151521.3969-1-deller@kernel.org> (Helge Deller's message
 of "Thu, 23 Apr 2026 17:15:21 +0200")
References: <20260423151521.3969-1-deller@kernel.org>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Thu, 23 Apr 2026 23:04:46 +0100
Message-ID: <87bjf9wcxt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Helge Deller <deller@kernel.org> writes:

> From: Helge Deller <deller@gmx.de>
>
> I'd like to step up as maintainer for linux-user. I'm actively using
> linux-user to emulate a HP-PARISC (hppa) linux environment on my debian
> buildd servers, so I'm very much interested that linux-user is running
> good and stable.

Thanks for stepping up.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

