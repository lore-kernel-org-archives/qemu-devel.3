Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26616EB2718
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpuq6-0004z2-Mc; Tue, 10 Feb 2026 16:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpuq4-0004yO-KU
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:00:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vpuq3-0008T1-1U
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:00:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso52754415e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 13:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770757201; x=1771362001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2XkULp5U/4XBPo2ij4telgRLGalFcX1JK2UA0zQqWsQ=;
 b=GsJ7IU5B9DCEBHhp/fW3lih6g8t98G2TFkGby5Jj84RKpvSn9fai9Xx1BKPPHvXPd7
 BKbOatmytYZ/Tv4PopEpk2JTOdPaRWSxuhxTJc1aX9HVhX8Lun9OWUdUdnNwChtK+RXz
 nVriBaxU2hqlQPXc/6ZUbjTq7OlyUDN7x3bhffh/zvMsREABfc3sNXHpL4LZiocOakCF
 t8cz3BWZ/u/ETxKKpRJU7tmmZVjbu7Zss2h0+Gsd7qaSOLoqfV1WiYh6NmmCY/wClfMe
 37piDIxysWly3tuN5luFlW+Z4FxVNB3m2/jIDauSjMCk3cV39h78i6ZBd/nWBGOu2D2W
 zMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770757201; x=1771362001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2XkULp5U/4XBPo2ij4telgRLGalFcX1JK2UA0zQqWsQ=;
 b=DaCDC3S0sz+vAcnCak5c4TJ7g9GfTx5ApN4wJze8dIUczXyl6zz5irzm5dT/J4WEGL
 P1nsG07Rht/s1c3IiPbxjh+mDBPcGl8qKB3ElYiVmSmOD8qfrECh+nJUX1v3awR7AKpd
 lTSdKBHbl2svUGoflfWoKoZwqUeLUmEMWcMOlckDGMNcwzyeqhERUGokWnmPtG3MefM4
 b1tMbrPQfgn9JziavdUev+GVgwpS3b0FCnqQ9qKH0C/e2SnZ4ESNo5/qYZn8bYEvlsa1
 ZQO9ElDV9ECcLv+EuZ6Y1OTDd8iMRFONXdL4SxKSajxo1EH2RGVQ1QbIWKDpnr7CA/r6
 pLaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKFlTbs4VlYmf8uCYEO0YlyDhzhuOoktz5AOUt1jMERchx5lxhSxrJ86IUBEFX4znlhd3me4Mn4IF+@nongnu.org
X-Gm-Message-State: AOJu0Yw/qvQmlw91wq83EgwgeqgcTqt8iS7EFwfF+ghW9TDmHQiIiJUR
 KV9bXI3JQ0LM1i4t68XOCqWVBXuBeK62efChYcNH+aJK/gOODWeNC1RxJr4cQaq10K8=
X-Gm-Gg: AZuq6aKzue/iGD6oHmyieUY21E5WExSiY2PPBvOuwZKkSGEeT/nD9wGgzcomZFejPG7
 Ng73r3BUlThvRoHhvMzMokgTBdzYbbaQ4zt7v39zC+qCoj33eAtkIMqtyjdZyTUO2dxJWbhS0KF
 AbqqLfPU6qeAqlLcBgYowy7pXoUdx0sZJRXD3tWR4WaGIPyHXeF8aJMm24MtFNJJlnf/7KjAYDA
 qKbmHxcLYadQNM4hNMY5i73ESYbEEPb3DVkfFA8N4dhSB1Hx+FfnURv76XbNCrV6A7QYpYSavUo
 83JTJCV06V5xEnmWlzynAmy2DeA1FbRk+fGB6Y3o52UTuYq/yrSrEY32nN4z+yLfQyARGJjlQSv
 8McuMKQdVVGTysFfSLwmJL5syEWmFxcld8lr2jztfSRtTpx8Mb4NJXOOY7848P+OEjrcWojx9K2
 gYBSZyVw7YA3Jo5WorqcMXxmQzA3POh4YBFNzN4Pdj8gcIUV04mZdHTO8QdvstQs4=
X-Received: by 2002:a05:6000:238a:b0:435:e440:f518 with SMTP id
 ffacd0b85a97d-43782cb1c0cmr634062f8f.54.1770757201284; 
 Tue, 10 Feb 2026 13:00:01 -0800 (PST)
Received: from [10.123.89.66] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4376d3a32basm20266442f8f.14.2026.02.10.12.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 13:00:00 -0800 (PST)
Message-ID: <28ab896d-bde6-4f2f-94b0-f37fc4d05f0c@linaro.org>
Date: Tue, 10 Feb 2026 21:59:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] docs/about/emulation/uftrace: add info about
 automatic tracing
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 anjo@rev.ng, brian.cain@oss.qualcomm.com
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
 <20260210201344.1403613-4-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260210201344.1403613-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 10/2/26 21:13, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/about/emulation.rst | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

