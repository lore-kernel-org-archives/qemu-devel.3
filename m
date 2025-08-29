Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F75CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9O-0003nh-Al; Sat, 30 Aug 2025 11:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uruB3-0003bB-H4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:09:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uruB1-0001zt-Ev
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:09:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b82a21eeeso589315e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756454976; x=1757059776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYEqRHgbV4dj/zidZbTo09wctcjJATrJIMMftyItbto=;
 b=SyaQmP0ve9WxSUuhkLG70fPWNo9iIgNYQGW0Zopgjl3pAK1efj+CQPmuvsxXCmzIvb
 7ECOI/3yUoKjTTszQXtg9sQQww9noGYWBpmTxP/2hjMp61OSjE8gZymvDdMMWDLuy2kZ
 yU+r++ndvCYxGirMAbi1ZPAnWXi2aJ1eeadN6Yc+2TTL2N9d+saJ7V9uYknXNXwdRL3w
 7vCUoC1iiPVZRU9Za1+V5ksaUNY7Gx1I1PERU/0tj2ik8f5SqSFkbzIeQ5hUsz+pATRn
 EUqemrpO3HYJD4r085LasZQs7Dlao2rMn631WWfzf53mxchxK8qtC6YwqpQFQ+ifxxnE
 bH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756454976; x=1757059776;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uYEqRHgbV4dj/zidZbTo09wctcjJATrJIMMftyItbto=;
 b=M2UsUegFd/b/cMmv37FIPY92NyeUm1DWl1lAh+z4zX8jpxOdS2y8XEeLvJGkq7d/G+
 XvADcAi9vBSIC1mzrZm2+kmUxh1xhbv0AGFKf+yjOGSGrBXoEw0KSEC14ybDi3BbHTWw
 kktFElyOpeI6yc4kGwxalisMGPBB2s7JNh+fn4rG1UCBHhAPgr0Q2p+yEYvxpeEUtznr
 MdMvw4IR/Z2sp/V85/eMHaM7lXMTa0D1/3JQa2t3isxMO7JAStbUTGWDIMcXDxyOblaE
 hb0jlozba+QhjC77wOf5H76NlGUfDEx2VvRLjKH0+smlZNusAqJM3dbHCkfyNvpPZHEX
 qC2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrpqXOwblEHQWwO9mnCvyS2pH2HL3X+HFyh8rlIwqiueAVSqK8SAFRzbEOnSjHP9a0DPMOmIQYs5qG@nongnu.org
X-Gm-Message-State: AOJu0YzZt6kLUlUF/VueqnNtU/wcJR4zX50by6CFukB2/XU8DX3OWT0Y
 gLlbWR/fDj9SzRJOwzZT5vcC4rlgcy/BAH7ZcBv8DxwNHbaQzNyIHuApmNzjtp8s7QE=
X-Gm-Gg: ASbGncuAoi7mIZNSBFQ9uTKgB5nk8xxfjtHKdV22QrRpK4tEvSdKypY7KUL5a0zy/C5
 jW7bwwuGu4uzd8ph/up+NLkKQbpcWs5sYlHnvmUUTeREMqDWyfa/jUBH/1P22IoYpOKGEy8lOKq
 1l9ciBxrVXnBzYuWUNSdn2TUqdnD9uHzCHva2Ll73+VBFWsln7/S8Bms8Mo/AUmHG6ruVEdBf5k
 hsVFs11+CKCyNYp1GSh419ixJd2+smIzSOuZwVBLXrzZh9vycNE0ot67eVzDbwc6l75sqNtqv3e
 x1FtLmlrfhhRlL+j3bb/4EkV25rtg/FnvfdEFaSES+TbrYGrT2IJTRuo88a0dIt8spW05tAXUFg
 TmE+oEQ+BcP5gktTxKzCt1wM=
X-Google-Smtp-Source: AGHT+IHWSncY8t16Gat2oF1IXj0YlNyyddkee5hGNfgNIv6CUTjZIlCqXsjtUmztQd8y/JQTBGuFKA==
X-Received: by 2002:a05:600c:4705:b0:458:bf0a:6061 with SMTP id
 5b1f17b1804b1-45b517d49d4mr253939295e9.24.1756454975590; 
 Fri, 29 Aug 2025 01:09:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e89920dsm29880545e9.16.2025.08.29.01.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:09:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4A305F80C;
 Fri, 29 Aug 2025 09:09:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] system: drop the -old-param option
In-Reply-To: <20250828162700.3308812-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 28 Aug 2025 17:27:00 +0100")
References: <20250828162700.3308812-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 29 Aug 2025 09:09:33 +0100
Message-ID: <87wm6my2f6.fsf@draig.linaro.org>
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

> We deprecated the command line option -old-param for the 10.0
> release, which allows us to drop it in 10.2.  This option was used to
> boot Arm targets with a very old boot protocol using the
> 'param_struct' ABI.  We only ever needed this on a handful of board
> types which have all now been removed from QEMU.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

