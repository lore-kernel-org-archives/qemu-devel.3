Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753EFCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMwZ-0002jO-45; Thu, 30 Apr 2026 04:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIMwM-0002hh-33
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:40:14 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIMwK-0004nD-IS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:40:09 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-651b4d09141so977554d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 01:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777538406; cv=none;
 d=google.com; s=arc-20240605;
 b=XcXuhMzfPwWC6sFPcKIXw0fRJz0Jq/qgffjlVOYrYmd6QGN2pJZllregLXtQVuAPYZ
 MnU2B0U0klzi3MJnIVZ7h9hrYKt+Xp6VDgxQvx6QGBgNJqW4IPl/+GVT/sw3ax0RhwuF
 xcPVCYYWD1278Kv5awh6D+5q1J48+X9Y3JZtZFZ/mwtMTseafcUqm2VC+DpMc/3I9ncs
 Xi1W1fPzWE9MJNrD7ctB7YaS1Z6FTk8+aJsa0vJ5IDcptYkUwJc73BDvrT3nljuwe3/1
 Va4KrIp/yjDpELXSbQ/sMqRRpOHWFS9/eFB2Y/evEtQkZy3EZyocfnoDCajBaeijCuxh
 z2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HPWFPkMaTPBBRwZ5s2tdvNEyjmeAjvkQjBAZyQS1X6c=;
 fh=ih0IwRyM8grDHegggVioxmU5VbmmsD9RF4sNtWxqAb0=;
 b=dXin2jQN8XokUiSNEl9uvYXx58QFzV1YjpDhzRINBXPt6BTvUXIsp/voPKtAJpIHLB
 nofWe2Ho79s6/eVDXOynW4Vj++pnl2tqQC6LYY8zahcTpQ0SNA5xwHt2byLsJClgI65Y
 xmmeX+88qOs+0NNYvARujFGYPaz4Ecc9y3yTAiWNvyQNlzTXdSuGxJecYWUV2LzjuLkK
 jgRxhVyKtZFuFX0DonfmF0AiNeP+F4cri1w0eHaSqVTbvRAUVJCQhbXgZSDzvw1EbI3g
 A+39DjlWO4HPr5udMh0ZpY0Mt3zGNzcp3PFIStZQDLJD5+4VDEVO586WjPGO9UviLVxb
 uzzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777538406; x=1778143206; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HPWFPkMaTPBBRwZ5s2tdvNEyjmeAjvkQjBAZyQS1X6c=;
 b=FFAGHWIH/XRru8NV1xGuRs9yOVcWIH39dk88yH4xmXEtWUm4FF6pFQC2QGeCEABEIZ
 trV32nAl2S7MmqlR/mj9si0NZQ58UGd2+MTO2uXxLjvR5HuRwxHVXv/68z/eLXg0hxDi
 un/zFrG5axqXweko5F1rUwGudopq/vXY8PlZR5+L5KuB7NFvcpkPyzHa/ofpHiZ+0gNR
 e9fSMf1BMCyNdukRfGFgpykOo/qXhqWaK+ippXOXlSODxNX00o7NXqa9fZZPh6sFuI71
 9ZzXxLcYwa8A+9//L2kQfyPI56OeAifvKVr/3wMp2WJBhM11s5dIO3DUrZQrP+m2AAUs
 X18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777538406; x=1778143206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPWFPkMaTPBBRwZ5s2tdvNEyjmeAjvkQjBAZyQS1X6c=;
 b=YAxEhECRDuWqnrab7r8R0SAm7xqtb0iP63ZWgrXPZEoTvzHz08c5ZT1ibgK1ThlXFw
 aHbMQ7Ln9uPNuvdeiaNEtvBzqq0MNbSnIrrwNL92w6yyHdgHaxcKTTLJqxkVlcZbqjt5
 jcaPgkj5jkH0XBqC4j+V3a3PafmzTYkv0wW5TAnvaTNTceyScwzdkaYxJeYOAoX4GObR
 RnnXlHBUciZaaiR7SzkAGs+aExnEiFLymc5XrTEcAjB+kstaUZ4U32Y8REcXYCZZ3WNM
 H0wXhVnAHAzCGUV5mE3qdDc+bCs4v7HFxXc0vmuI5dR0bspqz5ubft+eBzMiI8EYXv5M
 nfZQ==
X-Gm-Message-State: AOJu0Yxv7Z4D6XgtcGxy70G1zDX8lpgyMA/2OKaY9IO5sXGDVOL409z4
 7/m6lsS0Xp91gMJhbZV33dhjVRo+pAua0gV98NTMWDh0Mwz6uandsOXn7gjv9VWgT1EbOJ6uy4b
 jJe3XPZnk7VmU5BsSsNSjjSNdUOAaJLDyGilxysDUNw==
X-Gm-Gg: AeBDiett30EoPkBEzZdTXacRJWf/YgwAOFnZ509BRF9Wv7tf4pqQD5sncYR2dZn2Tmh
 gB6jRlb28iLdevYceCByki6D+hOERGUR8Yhb8z0bcc4/ZfJ4/Pxs8fzUUGodrA9FzBPgjYCTRJR
 8gDcqJ564WqrPB6obNaoTOa6IgKhAxbJ/rjLrGzGw8yqsB+sw2B5n04Lv8hsMU/2RsE+sjRrSAn
 /Zr7cJLT2dcUGvRgPiyKtkgWC6PKoQUBXtHRve6IPhYxeNgDjFECMeChXlZ0TcufnlRfrDIn6Yz
 n7bYil64JR4xNKqj/+LwWcUmXJ9sj+OPCcGvwK4GN+voD6w6SJ80AlwcY+iX/0uXnlfP7AbgAAm
 PTw==
X-Received: by 2002:a05:690e:4187:b0:651:db4c:808f with SMTP id
 956f58d0204a3-65c1b135d89mr701321d50.45.1777538406493; Thu, 30 Apr 2026
 01:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
In-Reply-To: <20260429170519.2137725-1-joel@airwebreathe.org.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 09:39:55 +0100
X-Gm-Features: AVHnY4JO7trkTrdcaSs3SUlqr078MQCUDz0wf1dqzDH1pCJaBpJssAYZcOVO7uI
Message-ID: <CAFEAcA_a7nOqqu7pU5fvcM-7j=FT-ZANyW=+4iAh5Hw5LKAmSA@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/or1k: fix arithmetic edge cases
To: joel@airwebreathe.org.uk
Cc: qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Joel Holdsworth <jholdsworth@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 29 Apr 2026 at 21:06, joel--- via qemu development
<qemu-devel@nongnu.org> wrote:
>
> From: Joel Holdsworth <jholdsworth@nvidia.com>
>
> This series fixes two bugs in the OpenRISC TCG translation:
>
>  1. gen_div: INT_MIN / -1 causes undefined behavior (hardware exception
>     on x86/ARM hosts)
>  2. gen_mulu: uses signed multiply instead of unsigned, producing
>     incorrect carry flags
>
> Note: these patches are AI-generated submissions.

Please read our policy on AI submissions:
https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-content

thanks
-- PMM

