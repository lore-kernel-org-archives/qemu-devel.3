Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC96BC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQ1E-0002a3-1J; Wed, 26 Mar 2025 08:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txQ19-0002X0-0N
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:37:59 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txQ16-0008Bu-VG
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:37:58 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e5b56fc863so10081498a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742992675; x=1743597475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSh/YK+sRnu723a7KDPxkVNE36njQX4SU4OluJcMA7Y=;
 b=CZI3cxpgNgXn/Jk1xJ9obIYOmcW+3sUM92O6j6A0WnVmnZe6tavgg2s2oXIwAe/3fu
 GqtkSEBmI6Hf1fnT3UEzfzMyf03kJpjylRQGSKGU2fhtG+r0nh3H0qHpyOMsB6xXBZ5m
 ZNxwmBId4DlQ/XHa84MuVQUrz6XKHexMJf7wdDg0d8F6+MHZ+OTaYy/2Er15ouYILAeG
 v9d6innBUkSL9eCunmd1JjPaZScR56u86WEl2ORYMrvHEVKSJtXC3ZpLsF49YSslm/ji
 59VLmUwGfJLS42w551AxBRHPGdzPqJfpS8skdMwcQUSb4tdq92fU3FBQH+LRojtPpIz/
 pHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742992675; x=1743597475;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oSh/YK+sRnu723a7KDPxkVNE36njQX4SU4OluJcMA7Y=;
 b=IHzE3n9zpaOWuVAStgrj9N/csmwbpiykHhqBgtQPrROQ9b1BJWpL3aFAEHQHULzDOj
 xVZ3tLxa7PvLD5niJJJcFdB+rVdF9SwNl8JVV9V7KxLTu15zTJVY2ZTrIz2HaBX+hxHF
 zDx61m2k2g+3lXZKQ7U9D5QLOeXCp8dMu7l2Xu1cckZmdHeuLNrp+3AqIHi6/Wvmfomr
 cFdNT3gTvNID27jDuEUhiPFpn+NUAwAmhiU7Q1s3gDTMzFnatT96gwX+1etvxuhUYRmf
 sI+oYyLEqyFzjXfS1qqh6NPY9uu0fY+NvL2LA+gVDflGToiei4upVSnkrhRmK8vLrcEF
 k1uQ==
X-Gm-Message-State: AOJu0Yw8KLgSDGah1d0mtJZOSBcVsgMuCghl6CdpkeKFjeqF+U0iz1v1
 veEhly1qWturotz11xwZYLoeLbwHwAxliSZsy7Wv0DY08AGZ4b+ggKZL76xZCe8fZo9BZFT5Jlp
 X
X-Gm-Gg: ASbGnctZ5IzkYQ9UOUk3dxOHXWBI9RDDC5aohhXA49lXzQjQ6CNvbXIY4Tk1l3Svd+m
 dBr3KNe4dCDZHiZxYOzj7XdQVfL+J5xSN8YL2u9pkCpU4cS1Qh4OG3lltvWHZi2rIrjre9DNesy
 jMsJL9wRtgISokKbphEij1/Jxr6JwXZ16TMORBQLP08BjMxQtbE/g+Y/i8zHzqJQpyy6lw5VJ2e
 ts1xMRB0wYiN0NI8jtZ+1gLfdiUHVZ9zAxrFOuHpL4f0bA22MQu59T9V9JWLbST2H6F3nYW/uor
 H2umOXWzS3ZrnxprVPBSaU6HpTqyMnop4wx118wJUnxTA1I=
X-Google-Smtp-Source: AGHT+IHvRJAMGNX9QCqIxNOdhs+3QTKqfB71HpW0GK3VHBX+6W/6patj/rfR9aIuNHv2d+JMCkd1pQ==
X-Received: by 2002:a17:906:6a0d:b0:abf:6f87:c732 with SMTP id
 a640c23a62f3a-ac3f2238aaamr2029360266b.20.1742992674547; 
 Wed, 26 Mar 2025 05:37:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efbe8ea3sm1027939366b.147.2025.03.26.05.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 05:37:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 480875F90B;
 Wed, 26 Mar 2025 12:37:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Louis-Vincent DERIAN <louis-vincent.derian@st.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Vincent BEUNARDEAU
 <vincent.beunardeau@st.com>,  Nelson Petit TAMBA
 <nelsonpetit.tamba@st.com>,  Francois PENALOSA <francois.penalosa@st.com>
Subject: Re: Inquiry About ISO 26262 Certification for QEMU Software
In-Reply-To: <VI1PR10MB367772124137F1672AA1F58DA5A62@VI1PR10MB3677.EURPRD10.PROD.OUTLOOK.COM>
 (Louis-Vincent DERIAN's message of "Wed, 26 Mar 2025 09:22:30 +0000")
References: <VI1PR10MB367772124137F1672AA1F58DA5A62@VI1PR10MB3677.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 26 Mar 2025 12:37:53 +0000
Message-ID: <87iknw0xy6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Louis-Vincent DERIAN <louis-vincent.derian@st.com> writes:

> Hello,
>
>=20=20
>
> My name is Louis-Vincent DERIAN, and I work for STMicroelectronics. We ar=
e interested in using your software to facilitate
> our development and testing processes. However, we need to know if
> QEMU has ISO 26262 certification.

The QEMU project doesn't have any certifications, as an open source
project it is provided as is. There may be 3rd parties interested in
certifying a particular version of QEMU but I suspect it would involve a
lot of effort to audit the code base.

> Could you please provide us with information about the ISO 26262 certific=
ation of your software? If it is not certified, could
> you explain the reason? Is it because certification is not required
> for this type of tool?

Because no one has done the work or is willing to pay for it.

QEMU is a very large project and supports a wide range of devices with
different levels of quality in the implementation. The project does make
some statements around principles for secure use of QEMU:

  https://qemu.readthedocs.io/en/master/system/security.html

In short we treat bugs in virtualisation use cases as potential security
bugs but the emulation use case shouldn't be relied upon for guest
isolation or security guarantees.

>
>=20=20
>
> Thank you for your assistance. We look forward to your response.
>
>=20=20
>
> Best regards,
>
>=20=20
>
> Louis-Vincent DERIAN
>
>=20=20
>
> ST Restricted

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

