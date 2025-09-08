Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769FCCAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcjb-00055n-VF; Mon, 08 Sep 2025 10:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvcjZ-00054o-Ua
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:20:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvcjQ-00011D-Au
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:20:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso28751345e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757341223; x=1757946023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBQpfK5Ppgu2j7IEVQsruWGnmykbI+PC/kC5pUhut9o=;
 b=Ana+5pFNMPVl3a8Qd+Pz0e2IpklWPnJyuvmVEiWssX+Cjv115IYZgmRb06brTiIRQo
 8a1boDnXhp2W6dXcuyByz7uHzAzfMoJ6X9l0/8+fHSPS8BCo5H39kCYADPCkTfgXnhof
 Xd4CabteDc4wblAbOWdeMPXC4HUULPc7iht/U7U7ML2hoGWF+TY8lZsUyJ2QBDOOhgmS
 cO13eGcbMQCcVGyswP+yGrAo4P4Vp0LcRZItHniqInlrlQKYKsLikPTUXtQMM743d+oE
 slaepxAkq/GghT/CyfDzGIF/kB/NUWxqZkFMcciuIxZiQczQGqJghGHekJHX4l+z0I2S
 0Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757341223; x=1757946023;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fBQpfK5Ppgu2j7IEVQsruWGnmykbI+PC/kC5pUhut9o=;
 b=B+IOZ0AOs5AUMWMFoFeTBw+eL73le+3IFfGjsVVgY1R73qR2+kCLiiSZ79h8aoNRLK
 56P7D3VB1dNIlwq1D4qPZNRr7OtmcxPewK6VibeONbkrls55BbYp23d3jsTglFgu1H+T
 QHHZ3wgxZfs4ozFrWPsSJORfd2rcJuWMa75lzWxhWqH0XaqNsEO+Pcl8ekXdmYyojDHw
 Y5AxwX2887h5AQmkDVSSiDqnjoWk0yqUQG2R3UvzAgjndOAzhyDD2GFAcadsYYN13zjR
 3+cXPSWj59o9nxqaSu2e+xR6X7jBmtNeeyVRl5+Opt6WzkEGQ7d/E4FFeFM8KKG6B3Na
 NaIQ==
X-Gm-Message-State: AOJu0YzbPnj8q1ZskI85I8BoGezseDc/VaENmDn5iuxhASZ704QBhVCz
 kRprLjzGoaO2lT+P/xs7/+2jgRsUga2sJA/KZklmZTbYbNQnJXi3k4s3oLGhL9OPubc=
X-Gm-Gg: ASbGncvKQ7nKDVjGoLCD5u8IHUt2SqjpuAzhzvrcsgH/w673A1A20739q98lFS8g54/
 92QRYOcFBZfdStl+e+QVQa8lbBghakPKW03WlHVMaMeg63Ug/uSHdf32S3/W27Ck2GLP53L2OHr
 f5Tb7oUb7ObPeKfG0JKGNKKpRXk5gJpxDcgkZaLp6TG4hv/0G+ONLql3dfvvS6N1y46YM44k2WX
 z7Yifd7QxX+D69B6xM2OGtfsM8v7PoPXywJtvR6FEJqaB5m0dFHvLOr7gqzVsiU6/lnhfuYrhRM
 jaeSy1TgVICMlX4RFOrjkm9NIgAIV5OZp/r69+FYLOSusVzMXRGw6pd1QPS+ZEfYKmJdS2LK1dx
 wH7aFVylH4Ot6FuUG6BX0/jU=
X-Google-Smtp-Source: AGHT+IHXR+przUAV1rfcg5Ues+qwWIfSpt1lTSVOnVXJFOJDo2N3K0i2M5MR/K0tbhxKT+jI0qFlGQ==
X-Received: by 2002:a05:600c:1c15:b0:45b:9c93:d22b with SMTP id
 5b1f17b1804b1-45ddde864b4mr61120565e9.2.1757341223493; 
 Mon, 08 Sep 2025 07:20:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de16b8b58sm92719155e9.4.2025.09.08.07.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 07:20:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0853B5F7FA;
 Mon, 08 Sep 2025 15:20:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/4] tests/functional: purge scratch dir on test startup
In-Reply-To: <20250908135722.3375580-5-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 8 Sep 2025 14:57:22 +0100")
References: <20250908135722.3375580-1-berrange@redhat.com>
 <20250908135722.3375580-5-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 08 Sep 2025 15:20:22 +0100
Message-ID: <87wm69do0p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> The test suite purges the scratch dir in the tearDown method, but
> if python crashes (or is non-gracefully killed) this won't get run.
> Also the user can set QEMU_TEST_KEEP_SCRATCH to disable cleanup.
>
> Purging the scratch dir on startup ensures that tests always run
> from a clean state.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

