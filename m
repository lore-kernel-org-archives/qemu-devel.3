Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4FCEA3C4E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAoBh-0001C9-Vp; Thu, 09 Apr 2026 08:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wAoBf-0001BK-G6
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:08:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wAoBd-0000em-W8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:08:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-488971db0fdso8193745e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775736520; x=1776341320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Gsy7IZRqA2y9U6KfXMKtj/5gwSn0ocPx9d530a3ePc=;
 b=SMGUUnopd/AQ3x4tU9+/cgd/n5DmoJ4qkx6Hz1ab7+BM7MiZ8OzYG3CKQnOKc50FXF
 rIjXNoxfegfRmYIQvFvRy0ktoFNZOKWGqA6oqEY+hm17qHjMoR52mczS94yFS0Owri6N
 c/YUGRLMKq91/KFfuhhr1obTFFy2JaYr2eiXY69jxXLMDl6hUTKlm9VRLQlis8u9uTJp
 qy4T4pttfUgbvduK4apyvL1KM0ZIiRiJt1OJ87ws4ooA3PhaBrhV5Q5gvD/yv2YSUXSD
 2el4+UYHgbpW+LWnUI9yPJZAPGXYFEnKm4/kvkBZhXfT1Dc/XTvinhTatekDYrFJg3E0
 qOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775736520; x=1776341320;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Gsy7IZRqA2y9U6KfXMKtj/5gwSn0ocPx9d530a3ePc=;
 b=UyFC3lRRBnpTw8rYOocckkKNXRSoYrtfB+djpuGPKLelmrBwHAo9tlVAAUnfF53hlt
 YT2gqPxii1LaR+l6fXpWlIC6diYgvbnhWP2jEC+YOHqS6nEkHn1XlrGRFio9ODS7NbEX
 erAQ0YKHBLncpoEMkE1Bdi6WzIA8ea1KoRaUtSOiAjRGegbFqxeLaNBp1egZnebsgDUb
 NczQAwVIiZn50Q9wEj5f6uAGUe2BcfZtj882DTmE0HZV/RxCAjXIvEwcC92Lt1JYHsjm
 WTJI2WkUWqUwa7t5nq8MKSYxBYrI3+al9OQX2cdRFwoGaCWIZV72ZjMFvTK24Zg/WUvg
 jB2g==
X-Gm-Message-State: AOJu0YwxCJPn5NVJXQXStMPm/Le/N5M5RJ6lBd2jTSSUIHyxHZAD9FdN
 lutSwxNFyO3ZAebiku/a218AMf3k2CY7yunmtEUZ06zcW27l/VV7PEQLHUuVPt2tuB4=
X-Gm-Gg: AeBDiev38mgl64gyqzvR7aVMnq7d1ehytWH8jsrxzEEC1EQabnkYOh0/GfTJvnEaNFK
 qRtSUYO9UGWOKa6qciqCgT9knKGgVopIRoLdxD6GrVxazSCIDjOsVo69nJdfKrbIJOs7n2On2LP
 uvBZBpicmiYFBgdWaA02N82Rj2dhJmmOFDdn4gtw09MJwUbkpfRpd+zQGh8hxgxSPsgJP3f323r
 usbuGoh2PQ6hgmuvc+qm0PCEpOEXb2EwbP39VZMrWN10SKXiD++r7x8SrLb3tHIEHsZU12P5YUS
 PpMsYaO7llPn0aLGNt7W32eawwdgu8W3AwKADpaQcOS2Hg9p3d5JvgTZK+W3DQgTwaUYwPvVqGD
 M/AiDhhTffHH6YEelXjSJVApFQD3t2UsDxatqN5tcQQLmj/cFypLnnikBmuXEd5wB2ObMR8PFUa
 ZxxOaiKECYujkZ4FrnvDWhK8M=
X-Received: by 2002:a05:6000:2dc1:b0:43d:2be:e4e with SMTP id
 ffacd0b85a97d-43d5a18ef12mr4668326f8f.46.1775736519654; 
 Thu, 09 Apr 2026 05:08:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d29bbsm68908966f8f.21.2026.04.09.05.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 05:08:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DFA65FA6F;
 Thu, 09 Apr 2026 13:08:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Anthony Roberts <anthony.roberts@linaro.org>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ui/sdl2: Fix assumption of EGL presence at runtime
In-Reply-To: <20260409110256.684-1-anthony.roberts@linaro.org> (Anthony
 Roberts's message of "Thu, 9 Apr 2026 12:02:55 +0100")
References: <20260409110256.684-1-anthony.roberts@linaro.org>
User-Agent: mu4e 1.14.1-pre1; emacs 30.1
Date: Thu, 09 Apr 2026 13:08:37 +0100
Message-ID: <87qzoo9vzu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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

Anthony Roberts <anthony.roberts@linaro.org> writes:

> The original commit had a section of code which worked on the assumption
> that if OpenGL was enabled at build, it was present on the end user machi=
ne,
> and calls could be made to it. This is not always the case (such as Windo=
ws
> on Arm devices).
>
> This line should have also included a runtime check.
>
> This commit moves the relevant line to inside a runtime check for OpenGL.
>
> Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3347
> Signed-off-by: Anthony Roberts <anthony.roberts@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

