Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117A8EC142F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNZe-0000cf-Vg; Tue, 03 Mar 2026 06:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxNZZ-0000cF-46
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:05:53 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxNZX-0001S2-2S
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:05:52 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65f767a8d62so9541675a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772535949; x=1773140749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RU1+WTMSLZ20bjetOwc83pUIUY2a9W5pJZNrzBCVrMI=;
 b=JbT+QTsMDY1l5G7vPfWIf+tCID9LigwtecGibJMN7plY4rDib0OIikS/8Av7kleQqj
 GMXVAo+IpL8DKDqvON9wJe/rTu2j5XhyXc1dPHpw5dmEkr7uxZgfAYAanmptz49ph5eN
 Y2yiN08CO5OJRU1Z8ZgwMri2c22URTJH8mltjKOcpv3O83K/j3jyHvIHFUdinRpj+cac
 EzWDauCLxLo/qKpjSl+iD9xGRoKVe0snfyxCoIllBlcexdebswRyX86LcBBnv3Zi5boq
 pV93oG5VjJYU+0LB4+uqwjmUxBCNSo9eQqt2sxviFbWdVUCMT4NXz61tIFkcwcG6+2mz
 aLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772535949; x=1773140749;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RU1+WTMSLZ20bjetOwc83pUIUY2a9W5pJZNrzBCVrMI=;
 b=ghgJtg8k7tRYeV+9ZlWPyMEfJoMP+DBYTDqTUy6utJjvRlf5Q1AJRBx3Te4vPUHZbk
 GZ+KaEWeQFKEC7hHTI7+IhM3y9W9LHA4JqDE43ozG69g+NZAYpjufPyJCtCuJ+MYdhs9
 /3ANFjZ2ch7v3SRCuYQQlKtpe5trFNciqizQZYLU0qpsy902HBScXwH5njs3pOW5eiFG
 7Z0L5WSUgI2syhpzZDRKZ0tf+UUR9Xm0tX1pYqpVxV4s4PeM5CkF4nD1wyW/9lXd6yEy
 UcOTJyPYY54r+SnXGuyj7K1pmRF3J9Ysy855jEc+e1o1+ut6g3cPs25+uPoi59q7fTQ9
 wEbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgdzSGoU1A3nrRziu/QNMwxXxMK97t+qaK8FXXjjWTvgMJgJXJ2hVHmIy3vxPAw6lxcAEpu+0dPqRY@nongnu.org
X-Gm-Message-State: AOJu0YzjJZEvXQ153ltrgQ9zbKG/pf/w3ZLFH4Qrp4aJ+EYWPEweQrPh
 ZSTUmWDTGUmySwoZWzyhdwmFfkblMiEhL11M/fqBL0XD7vNA4Ss5J6JUFW0u4twH6/I=
X-Gm-Gg: ATEYQzxxh3Jhm1+TGIYsZfAh1zHnz6TiIsyX/PCEGIKan6U+aMewpJK77cCVzFwhjN2
 sVfnk6e/E4S7lPuKrbYQtuOfmbTtUxUKqWjtG5B9pSyTndrMplx3wGebcUAREAOK2RNgNJhJyiO
 aRqz6nKostsUpxr5xIQSGxEPzcft2rkyXtiB1PSQpls2ywDYMJzlzYW0QNk7DVaGgGp4fX6OYEv
 s2dkhUaht/E3ga6ZM5BCK7tCaNTs9sKOrtdAiDf1/ES+MSH1VxX9YTVfqSQiLbbtSl/wTjKi6UG
 IucxR7AID3afMyQBC2ab13oiyZO7txs8rsgvuoJK5FCO4eEWS/e2vMgSS800UY3yqhseiZSi5dN
 ufZ1nviIr8cl0MY2bZJ+B9LbmWc/5/KIzONq0yyoqlQegwQycLcYjkwYakKQuCO4AfitDbviaxF
 nsRi02KlzHU5nRN+c6bqFcF6A=
X-Received: by 2002:a05:6402:26d1:b0:64d:3b22:a5c2 with SMTP id
 4fb4d7f45d1cf-65fddcf0fe3mr8296116a12.25.1772535948809; 
 Tue, 03 Mar 2026 03:05:48 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabf6d113sm4015716a12.19.2026.03.03.03.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 03:05:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F11F15F7C1;
 Tue, 03 Mar 2026 11:05:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Honglei Huang <honghuan@amd.com>
Cc: <dmitry.osipenko@collabora.com>,  <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 <armbru@redhat.com>,  <mst@redhat.com>,  <cohuck@redhat.com>,
 <pbonzini@redhat.com>,  <qemu-devel@nongnu.org>,  <Ray.Huang@amd.com>
Subject: Re: [v6 0/2] virtio-gpu: fix error handling and improve consistency
In-Reply-To: <20260113015203.3643608-1-honghuan@amd.com> (Honglei Huang's
 message of "Tue, 13 Jan 2026 09:52:01 +0800")
References: <20260113015203.3643608-1-honghuan@amd.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 03 Mar 2026 11:05:46 +0000
Message-ID: <874imxcgvp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Honglei Huang <honghuan@amd.com> writes:

> This series addresses error handling issues in virtio-gpu and improves
> code consistency across the virtio-gpu subsystem.

Looks like these patches where already pulled via another tree.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

