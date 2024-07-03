Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90923C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 10:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxFM-0004c0-On; Wed, 03 Jul 2024 06:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOxFL-0004bU-DQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:29:55 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOxFI-000189-Mr
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:29:55 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7527afa23cso383536666b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 03:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720002591; x=1720607391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S3BaVCbWUQVWg8g6+tIMwrc/4+x9EHM3HGscom/xawg=;
 b=fJ+uCdqHrz7q4L8Hglf+2JCuS9i60E0XYvKdd+Fnvf+qCzml0W6XqwaL/Ez+jkcnvX
 ZXkR5UCdtJ/d1WHm7MuaePA1qAX9/j9GN+TxViW18uHRtHtfAptT2GydXeRJHHtErRbv
 M/1wUgruM+zfqlqeDO64IsSuF1t2ywSnQjw0dY8/WiDCJwu/ozoJzpN8NqVgvHgU5jjv
 IxY6MmzicsQ1lFqpT5D0C/ECj1SUfP2GG2cvsuLW/Xn6aLNffFhgz5joqsYwQG61MrB1
 8pyVdKzeACESP4SmC/RJ11O3c0zxJQ+fcbijJ+dUPcixUZ2lH9+yQsaj5dtuR21wnD5x
 Q5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720002591; x=1720607391;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3BaVCbWUQVWg8g6+tIMwrc/4+x9EHM3HGscom/xawg=;
 b=MnWu+O+meKzu1ZZR2ojWeaRgdzbDPRYHfW+cW3jU/MiLL5eJTAVV7YNX4NufFhg/RF
 ATmRwdT2TmFDHHwnHlPKU9ul9lpfKg4ZXCvn45NwLr0Nd5ZNWrroR0o1sU7z1o3poK7n
 ydHInZBqJAIh0Iu7i5ndnOoyv4iR5kjVWysttOeYFmajgaidAJXoNLVLSIFuo81gMxrq
 zz+xBr8qP8TIcClVrXd4eM2q7dpWXEzmgZTGx/pEZHgpYWaHcC8JXikY7VhR48rgFmKg
 GeC3wBUtdRxlmsXgTEPcyBxqkjHApe+UDbyoiBCIpoV6WToG+vYfMGvTw57i8K9SO/WD
 vQUw==
X-Gm-Message-State: AOJu0YxDs/xWtRKKtmYKG2Nr/WgyjeKkDlEcSA7ZGI8jOuBvmU4yU3/l
 h7U0FwyEuA9s2wmvz5W/z6DQXxv3W+FAZC4D/qzL+LdBP8mTeLMwcXZWhi24O8Y=
X-Google-Smtp-Source: AGHT+IELes4Zit0wv02a/5x2645sgDTvimp2t+4lwlqxqiT6jBSFAtVyu/ik3DarXLIXrH5HRycj5Q==
X-Received: by 2002:a17:906:1350:b0:a6f:dc10:6534 with SMTP id
 a640c23a62f3a-a751449e587mr742362066b.34.1720002590346; 
 Wed, 03 Jul 2024 03:29:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ae84b3d8sm481576266b.121.2024.07.03.03.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 03:29:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 185755F841;
 Wed,  3 Jul 2024 11:29:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Cleber Rosa
 <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 4/4] python: enable testing for 3.13
In-Reply-To: <20240626232230.408004-5-jsnow@redhat.com> (John Snow's message
 of "Wed, 26 Jun 2024 19:22:30 -0400")
References: <20240626232230.408004-1-jsnow@redhat.com>
 <20240626232230.408004-5-jsnow@redhat.com>
Date: Wed, 03 Jul 2024 11:29:49 +0100
Message-ID: <871q4arco2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

John Snow <jsnow@redhat.com> writes:

> Python 3.13 is in beta and Fedora 41 is preparing to make it the default
> system interpreter; enable testing for it.
>
> (In the event problems develop prior to release, it should only impact
> the check-python-tox job, which is not run by default and is allowed to
> fail.)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

