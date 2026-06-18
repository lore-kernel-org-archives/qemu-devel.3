Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EF4CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCzL-0007Vi-Sa; Thu, 18 Jun 2026 09:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waCzK-0007VZ-Uf
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:40:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waCzJ-0003mb-Aj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:40:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b7866869so8808185e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781790055; x=1782394855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2P7I/KHZ2El0syfxddTkt4UuIeIj0oln0oK36zXBuI4=;
 b=RUfg3O3AogfIhXm6KvrqTnZV9a9amNvaZUIXuDNIhUfH+BKCqh7TFV9zGDGZD9CSB/
 ehXW2Ex79wVJ2eIf6PC/eGhrDLpKwxaOiO3KIseaf1Qr//VcT9LUsLa3S7YzKOHqvjH0
 CUPUnuTeRgrqnhOcuWxW0z+Z3aCcthnWiW25g1J7dgWqyAr5HkmjLrnHM60jIufEfSjm
 DHrOGhdVG3bM6o0a8od4vEHVKxWDdSFP9w33Y1hrL5DoVfOfW/aLd4OMrwGhjreSo53e
 wZZelx/LVs1EOJ2+WsD5mrNNe7l40c9mygWWQwKenpP04rFe7zGRbrQWYksfmpp/+iLo
 5Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781790055; x=1782394855;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2P7I/KHZ2El0syfxddTkt4UuIeIj0oln0oK36zXBuI4=;
 b=OzkoZ/LP4ePQ0+N9jpzoT0FZOP7FMJf22I5wKRp9j+2vp+r+cij2jDG6JG+1KFjh1X
 ObuNdwIJ/Hr9/SLlzn4GNmKO03mzryuknorgOPfeEDfs0RxjsLBHxJpk+Y69IB8VRVvp
 HW9V1uzTdDQAl18VWY8XIkZ+YrJFbN6/LTOQWc2tpHlBSJWEJnYSkgdmiTdP4CyFkF8a
 w5LA5ezEj+V4mubs6SQTZBuJ5a2xCNGeH9y2RQShafKroT+3o7exK+9aseAdUy2aMpHY
 of+7tlM5wSFeCjX4j2nmWM1oG1EYmQSq/+bu/2wK8Onnvs9HRb6Yw3LdmK/IiVl3lkij
 fWDA==
X-Gm-Message-State: AOJu0YyznrqPBFgSmpAiUoo6DwhG6ppr+U1ZrwZkMZ2kf8APEzWeBYHs
 gXUumoev4Xeo40/W6x/CuwjV+o0BXqEopXKgTXAYFOgEZjbjeo+lbDGQu04LooX/ObQ=
X-Gm-Gg: AfdE7cn5IRQwacvZIzhklqguEWPT5XEm9eQoH9ZzAoK7I9sZcHKwycRrkeWAIndMZ7R
 YjvtXs9i9qN62kxkXc/0I9XM1Ow7+FZpiZaZLHGfJHqWw/OGn71BiCm8GXEJ3hNQAILm94ieGmM
 j67U3UwRvwTme7/G+ABJ1JtTMBoLxGH4N1RdHBnkA0cYm9/ijhGlz8JxbUhf8gsqYXaZ4vt5o1R
 7sDAhrWEouBL33SMfXbtLhsKDJ9b/Qb326Vqfuup6KDQLdPPTF+ux8Tw2vAUMNLJA3iF2sX/6bV
 BqBB/ZsJYm4xDDxZ9kn8tqITY+1KIKYCiGGH2I9wh81AG9lxVQHsV7ws1x6QrI9w4Girj17W9UW
 uNbict+Mxw5fnJDzOGdzGOVPPxJwiiOvxX56xESyEZ0CqJwezbgpKRvvtMYZLByL7CrBzdI1aGC
 WQuwM5pfxXHLTl
X-Received: by 2002:a05:600c:4755:b0:490:9588:bdb6 with SMTP id
 5b1f17b1804b1-4923413c296mr122111775e9.33.1781790054999; 
 Thu, 18 Jun 2026 06:40:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97a07sm419218425e9.14.2026.06.18.06.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 06:40:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 633AE5F905;
 Thu, 18 Jun 2026 14:40:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Thomas Huth
 <thuth@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Mauro Matteo
 Cascella <mcascell@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [qemu-web PATCH v2 1/3] contribute: reformat/restructure bug
 report guidance
In-Reply-To: <20260618132058.1044341-2-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 18 Jun 2026 14:20:56
 +0100")
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-2-berrange@redhat.com>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Thu, 18 Jun 2026 14:40:53 +0100
Message-ID: <8733ykge56.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The current bug report bullet points are duplicating an
> arbitrary subset of what is already requested in the gitlab
> issue template. Rewrite the guidance such that it refers to
> the issue template fields being required, where applicable.
> Restructure the text in general so that it is all a bullet
> point list rather than a strange mix of list items and
> separate paragraphs.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

