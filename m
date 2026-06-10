Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0985CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 00:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXSyB-0005RU-7i; Wed, 10 Jun 2026 20:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupidazul@gmail.com>)
 id 1wXS9T-0005RS-2k
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 19:16:03 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupidazul@gmail.com>)
 id 1wXS9R-00032J-IT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 19:16:02 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-9640111c168so2519701241.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 16:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781133357; cv=none;
 d=google.com; s=arc-20240605;
 b=EN3pxHNX5FCNTSoKnKpYqqd2aoBAWiysLzLtysw4Ez7gAty3oS/JJ2risBfOy9tkaV
 ovzn7d2pje2QqMkXx2EwgunWuJaaqPA1WBlb3CsrdY9xVBii9ec4krRYFqSHss6YX5+g
 69Uo19iLx5TZrrYi/77nQcQQlp2pyRnkq/IqVlshRu5kxvn461DWo0FITrIV3KSrF1Mq
 DsRl9cGHuW5C689HEpdq6Yx/daudf56YFgqmA/uuWVJrqA2ltjMLQlGb0g8BxPy7AsI6
 ND0UJPbfUfhnv7iK+MLclBRPnk4EumUQo4O3T4MRH372xWw5YwhJQlg7qV8s73/P7sqB
 5hFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=d94HJddahxxFvyKpbs9he4TMhK9zwAeO1hC7BvIt+AY=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=cHxD3xOGEsi8O4h09rmsDhxeUgptpxhlmTyqDw+FrbMuMa/erc5gZ2M6k6Koyt+nEs
 aZ9x0qeZ5Dv72KKfl6+ecBMDlk+GyVwd7h4S4M7QL3Zx77rAg2thgjxNjAcydhI8AZPd
 3q6wS9gE+MpYJ+tYbs/mfU4SkF4mQu0rUMODtNciQot2yNTt0jZ2TfRU2ZrtiORB76rg
 WsdiItDQLpvjBoyhpkCK9nHQT1Z3CSwSG2VeEfxvzLZnxIIXyep7XeX1nVzIckBSFsI/
 /RuxbpBE9HLEvOenbSLcpMLgMbksuJW8Q3AEk4aOz0u+gh5HxB3ebPzhH0iAULgA97Tz
 1KiQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781133357; x=1781738157; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=d94HJddahxxFvyKpbs9he4TMhK9zwAeO1hC7BvIt+AY=;
 b=NdtCRH9U5uBfmZu+QE3ldwNmiy88nlyMYp4XboV9y3hhVFiUq8HlwB/ht3ySNRqAPC
 0Mq+ih1vvb/HmL3uCInKpUC+/+zQ6uua2Uw1+9oOohubPkfY6cW/nmdLQhtaJnnsJg7W
 63KUM+AN0GmXYhSq+FVLZx9EFZu1WjCkTeClyB/cAR8bEIL9yOiUEb4wC5WazKWP46hI
 nN5laqHP6VEs5H7cXVxn8oBLmxaf3KROFBcuT5fF8w8M2YX9HE6PdBPtSqGkuTGU7oi1
 34XpSmvqRIv03aQ6t1eVt2GUAqz7AK/0TtUUV/iq+8AV6nOS8PwnaGifD8m6d2+puKHw
 igKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781133357; x=1781738157;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d94HJddahxxFvyKpbs9he4TMhK9zwAeO1hC7BvIt+AY=;
 b=oIsOhvUWsGiye368xxUO/4Xu4vNETImNPPbl6dYsGczRbOnaWZQR7Hf+bpcaaePntD
 qMU/HB8Y8I/0zd0bzsAY6WJ5N/F5dA11WYigm4hMWq5INs7peJPgPvx9I1cmJD6TCz7X
 8HOgyw/jRRBQaPyU9jBqiNwSIX4Wjpw2Jkvdbjl5Ii+2qpsYsaGBpYBCk5fZ//cc1gw3
 mvrqn3P0KxL6qaMCJHukCHKrYtl44IvnzZZIReEflMSpHmVQrFzjITaCh5H/6Yu/c4U/
 6jfrmNVvnU3rD7XO43o937PjnKmEmgHGlwldc11XbvFnzroC6yfCzqCHkBbmxePvvNTK
 RSZg==
X-Gm-Message-State: AOJu0YwHVkuCJV+PsPf/1MM8NP/afqAwRscs05FuoEX8sxrG7PhMaAKL
 f+OJh9Nagx8U/sNcon5x336b12ZjmAUP6dn2kPiQnXVznShN9VFDkPqUN5rFO8Jzzz3HvGDJHjQ
 7hkO5RKGfCXFYbICRmgAPqy8dlexLVFplLw==
X-Gm-Gg: Acq92OFGQMxUmZ10tUPQuxdABm79dima/e/y02wHdYdoN6RotzJ/qLEn3kzNn8hZ+a8
 Af/Be4Lm6Br5Wx105Ulwfut4Mjlp0R/hHFPjOQVucnnRo/86yCrZkEMJzzEd5VQMHyDdc6LoBZc
 qJ2ApsrUlVkg21+SbKrwubLMGSGqxNXK9QCjfJ2l74FOYUjhrNfMKEy/JvyV+QtnyyI/C7cNllK
 ukEN1E88gk8E8wYl9Z+jPSsrg23UDDErniHjqD5ZNQrXfevVgERXjge0Rp6VdT78EyjwVFTIc6h
 LWTsOEG/Cpt+Mesffqs=
X-Received: by 2002:a05:6122:3293:b0:575:fea0:559 with SMTP id
 71dfb90a1353d-5b634d49010mr6038705e0c.4.1781133357045; Wed, 10 Jun 2026
 16:15:57 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Ant=C3=B3nio_Pedro_Santos?= <cupidazul@gmail.com>
Date: Thu, 11 Jun 2026 00:15:43 +0100
X-Gm-Features: AVVi8CfP-6-8hMIszEMRWXCkVkpr1nSVo_-0B5Wkyhf7275OpYmsX7NW4yK4CsI
Message-ID: <CABS7-FOxBfVg5Y2CERMFRVdH8D-1Y99u_JHVFA+FGixqR2zurQ@mail.gmail.com>
Subject: Qube1.0
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000b5cf80653ee6dc7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=cupidazul@gmail.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 10 Jun 2026 20:08:23 -0400
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

--0000000000000b5cf80653ee6dc7
Content-Type: text/plain; charset="UTF-8"

Hi team.

I've developed a cli for qemu:
https://github.com/MagicWond/qube

Let me know what you think.
Pedro

--0000000000000b5cf80653ee6dc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi team.<div dir=3D"auto"><br></div><div dir=3D"auto">I&#=
39;ve developed a cli for qemu:</div><div dir=3D"auto"><a href=3D"https://g=
ithub.com/MagicWond/qube">https://github.com/MagicWond/qube</a></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Let me know what you think.</div><d=
iv dir=3D"auto">Pedro</div></div>

--0000000000000b5cf80653ee6dc7--

