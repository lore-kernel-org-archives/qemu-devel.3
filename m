Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFE9E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmugA-0004r8-WA; Mon, 02 Feb 2026 09:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmug8-0004im-Nz
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:13:25 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vmug6-000220-Ib
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:13:24 -0500
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-658cc45847cso6845709a12.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 06:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770041601; x=1770646401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8dqGZx/EFAffkySLafgnYrquJYzcYauYRJecbHx5bU=;
 b=tJ2L7Xl9ttArTFKypBg1G4tHw1DnWI2dADMwKxTlZ/6EN1WV4FTw6GOJcZ1rAmVoc1
 ubmMFIX40Hpt+qjc3TF6sbyCQ92Cxbwj/mpHArBWr0dw5aPEek+765AuDxwIcl9B9qTV
 MLCYhBFhTq4QqnHLCY4eF/T+OpTrBPYjuiXLLLyhxjl5klicnRE61XVGQv1ln2flYjfD
 4PuuKXthF5VTSjbVd3uZhwbTMYviI91SdDdw64/IIoR+GFqUtXj7oaTzMI//sY9tevPr
 1t6giYUGiPsIKfaq1KlbnmF995o7/TPihcbWyVBoi6t3U6K4VeCv7sTPfMkfAlJ+Va/w
 RGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770041601; x=1770646401;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t8dqGZx/EFAffkySLafgnYrquJYzcYauYRJecbHx5bU=;
 b=MEIO0BGx8vSC8NNgFajrtydHFsZw8yLnG1SP2qcNAURsYm6yjcIn0FLZOkYYSIguCh
 s9reXOItSe5YG1thF6vUyoCb3onRJoBW36J97rZ4ZCcWpvixJrhMk/5xPGJEHEJhwvXA
 EQEnSQPoQEnwKl81PUNV1s4EdzBXSA+reDHZUZw9raYGaPvcE7qW81sT2svKljiUVqPr
 STTUfHtZrTL7sWvm9fEKTs5RGUbC7thdlUjsBjZt3b3gEtKy0rlvcTjVkKhbQoEYInXb
 2ZGl8IARRrGJQ5+7r4kqsq41Umn0Ijs38+fz0qAwX9AgrBTU2AypEtfG7MjmZm+HNo7i
 TwKQ==
X-Gm-Message-State: AOJu0Yz1sK1nUzw5RPhgUTBShSCn5lqdnv2nTLsPEPx999wnvpICORjU
 JxTQYcQoSURS1cl3Ur4sYGmSNgdrfOQUkH0YoItztqba8tfuviBbOsRvu/ER116tANg=
X-Gm-Gg: AZuq6aIYQjCVOT2GaSVwv356jg2jaWETC3G46zgxwHUGIos2p51SQM0RFqydsQvixMP
 68mQoEYLqeKKLYnrC/uHMl8mWNgHfFwpqrxGIX1g/B+wIpDQSCtl2j3rDU28dTceFG7Z/KF+ksA
 eG7BS5sYhpqO3F4FZ9nj6I4DoE7EWPzBrWHEIktX090lPz+kbrA3p0C5c+hHNxc4fDncxnkjz7i
 nF3PYLw5s4fbV8plma0htwZX75McdX9O+MLNR/7/SCW4uvnGb/LQzZSfllb9ZMFzPoVKB+e2If+
 bdt5CHepV+Kx+3xe1kdYhlBYApyIBbM/St+uRceW70rsIAETbRVW+Vy3QSuuO5yoA0V9RxGdbTD
 Tpn+tQV42ZSZDk/JShzbdiMc5ulr1HTc5UiqSWB7Wb3NdbmmlZdtIkn8HyIYJmIpLg6BQ7BOhpe
 T3Qn5LIuqVlhw=
X-Received: by 2002:a17:907:72c5:b0:b8a:f225:ede8 with SMTP id
 a640c23a62f3a-b8dff68478emr707232666b.41.1770041600706; 
 Mon, 02 Feb 2026 06:13:20 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e0901c150sm557746766b.69.2026.02.02.06.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 06:13:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CF585F7D8;
 Mon, 02 Feb 2026 14:13:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,  qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH 2/2] tests/functional: migrate sbsa_ref test images
In-Reply-To: <7a92bfb8-447b-4c80-a623-3491303b1369@tls.msk.ru> (Michael
 Tokarev's message of "Mon, 2 Feb 2026 16:18:25 +0300")
References: <20260128105839.3487840-1-alex.bennee@linaro.org>
 <20260128105839.3487840-3-alex.bennee@linaro.org>
 <7a92bfb8-447b-4c80-a623-3491303b1369@tls.msk.ru>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 02 Feb 2026 14:13:19 +0000
Message-ID: <87zf5rnshs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x543.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 1/28/26 13:58, Alex Benn=C3=A9e wrote:
>> As the builds in codelinaro.org are going away migrate the binaries to
>> share.linaro.org. As the hotlinks don't encode the filename we need to
>> explicitly tell uncompress how to handle the files.
>
> I'm picking this up for qemu-stable too.
> Please let me know if I shouldn't.

No that is fine, sorry I should have Cc'd stable.

>
> Thanks,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

