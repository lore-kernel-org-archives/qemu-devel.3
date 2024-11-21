Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DECD78796
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAQa-0002qp-Cw; Thu, 21 Nov 2024 11:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAQX-0002qc-Bv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:53:10 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAQV-0007E7-R6
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:53:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso9810015e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732207985; x=1732812785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipoG+Pm+d9v1XqTHtDZ5F+Rf0K6ZUtMoku6WUrh2VkA=;
 b=xOdVBt6uJR2Anbt6ryvyP5+HHFm+6MAZqGc1QegwCYp3ITTQWUKXcl8rkMSJ9n1BDN
 4Ai/zV942Vw0T97rPcnaKe6gCIZ5nJdWJ6CgZ7FjaVH93xRiqzJh7lMhVGPS5MkUosJO
 qoNPhWMGRZioZ6FnSVlLqsV/ek2h5h+EBscj7Imo0Kjmyllp9UUPsjDUGytEQSCvaeNi
 V726ZYxNoWCq0dxCoV4in9Zz8kN5l/lbPVUWvaduJMdAiLZQFfUA+Omo0bjjQtmA8cZD
 kUFHumTXRVDgCSrqckS4xpQcyv84lBuN54pFP3a4WKhWeSHnCA/Qe7HDsXKH5Qs/B7Wr
 uF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732207985; x=1732812785;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ipoG+Pm+d9v1XqTHtDZ5F+Rf0K6ZUtMoku6WUrh2VkA=;
 b=XKCHoUIWmbUxXCkN+Zkr2jSdvRZlq0b0kujsJRuinwYSfvs1czKuR2DhmackAtdakM
 3aIZUzudzpA1Cy+j9oU2qEfVEXbypU5S/T6ls51UpInF0u3MXdK13xAyPNAPqkoLsl8G
 QyXxUMkaWG5D7opACqGf10x9Xnmau2JVfvt9U2kmcWDSNdeHMFZbGqtMlFKgFDaAdXWi
 0xaGW3BMJEY/DXem8G+ywExIGs/uSM8u7WiQEvlScMPMk5CHJ7ulhqBuqxBJR386QR6w
 TekpckVzmkV+5QWoVKB28TNv0GoV27tM5rLyIyOUt507kGVzTv07O7QnpqQhCzSGDxGV
 2XPw==
X-Gm-Message-State: AOJu0YwjqJhCEQYQdgD+oRy6rjOtN3q06Vjozt+/zdPV99jmvNvsKveZ
 JQc+qZANQotynJaylst+OboTdFuNL9688rsBCWkv2DE/ClvTSg7jtzYnt3SMCG+wU8WJ0TF1UJ3
 L
X-Gm-Gg: ASbGncsGPYo4LSqBKvPf5Vzq6qdV2IjORhdkO6DIIUhbdsObIlPhxp+EJVO01xF252H
 PrOlTnkqUdVqeibQnTA40wvdgw3ZewjaCBYBcBW9zdVfE1gX86eG9ASeagXX7jZEKQnWPE+ttwh
 W6e0/ljqaoJjIbaMB4L+qZsOeDtus2fZeBGM3IXHvrBAe1LrivO9e1kWZsgz8hEQLH93YPWTbo+
 +mzGcA85nu5xw0B9lbeskJwKy2NXp5d8iw4jgh/5TDEAYCa
X-Google-Smtp-Source: AGHT+IEnTEmtLtB3cLdNIKAZro709y+lGUviAMT1bGxVG2GP2d0BCPr/ss2wcESSRuYASp6Xm98g6w==
X-Received: by 2002:a05:600c:1c16:b0:425:80d5:b8b2 with SMTP id
 5b1f17b1804b1-433489ca97fmr71978465e9.16.1732207985310; 
 Thu, 21 Nov 2024 08:53:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b46426d7sm60746225e9.36.2024.11.21.08.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:53:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 107D55F77B;
 Thu, 21 Nov 2024 16:53:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: explicitly permit a "commonly known identity"
 with SoB
In-Reply-To: <20241021190939.1482466-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 21 Oct 2024 20:09:39
 +0100")
References: <20241021190939.1482466-1-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 21 Nov 2024 16:53:04 +0000
Message-ID: <87h680lea7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The docs for submitting a patch describe using your "Real Name" with
> the Signed-off-by line. Although somewhat ambiguous, this has often
> been interpreted to mean someone's legal name.
<snip>

Queued to maintainer/for-9.2-rc2, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

