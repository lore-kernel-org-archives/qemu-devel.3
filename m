Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF01CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6JG-00042i-OA; Mon, 15 Sep 2025 06:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6JA-0003x6-JS
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:19:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6Iz-0007kR-VL
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:19:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45f2acb5f42so7922505e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757931562; x=1758536362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uy0HCfE3DMpSzqeuh6VRDtUO9lvr0BfKdeK87q9qIms=;
 b=JJfSRsCkV0ZQ37I/BHEcQwo5C2OHuNQygJkPk1ftizOD+hxHC3k96bz5OLuKTlGvSD
 NPv41tnlqd6URX+rKucK8RJGo957bZf2FAhoTmekUgW/+m4a7tFRh9qDRBBE2YHxiDSS
 PFvaN6SB1qeKX2UClFIigwPoQ+F/jIX337LmAklN9OkJmQLaQfD/J9b33VS4FqHNizDM
 SFHESDG7ZMiajBoIT2NpmgeNTiAWtNUdd7ABvms+i2qIdeLg24s7+g/J0eLgqek1dCyY
 LUc8oSKnMQzjFoAwF7exaDCK6zs9ueu7xDZCMDA0Ju96C/ozA+HAV7YtDDGzAxaJu/lg
 1lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757931562; x=1758536362;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uy0HCfE3DMpSzqeuh6VRDtUO9lvr0BfKdeK87q9qIms=;
 b=EXQWtM0ig8x8k60Mj1FjgnIjKuVIBDaZNdKQlvtu5Ep0oo1kVsD9zezS6TA/BS/f/e
 HtywUHibN1s+WqMa2AnXAKz5v8cVufoI9U2+Yjl0+fK3hJZGYUTsNDNg8ORv+/igBmiN
 +pHNtUd7Z7Lug7YZIk7calo8Nvv2E948lquGlLPq8prTP/6BerecFwFcrfBuPFx1ZokV
 YGURYlW76IzTrWFs0PCH855x4Zwdedm2t9Un2fqupRtmvXMVD9vjvtElMvV1ng/MZvRN
 UvAFz233wEqCg6L+F7NDQkE+96YDaTzwTOPrxWwU/zk9tGOnDetS62kAAy9Od/33i5EV
 LXHw==
X-Gm-Message-State: AOJu0Yxql3na2Kk6RRSOeZK1N8QZe030xzLiUZTT+fxmYm1Uztyndonw
 +ISdAZXuVj93Vu8zuFO8iYa6CaXSQxiV5PWTOv6Uj5MtNCbIvO3XC2PClo4nTg7hEAdJbnWG4mh
 qVYRTIso=
X-Gm-Gg: ASbGncv9D7NNcToO50A32ZGoFqncPEM7uhiq12UYb1+igXaH+K7GsdkKPiXrCxmFFw3
 9qqNZbPUlV4WclB2Ny6RyhpOSq0Nh3ANuy/n4qraKbXQbF96NiKOAfvaeUEUvdsGozpl+NCvte7
 mmaKtVfxCXGc+xfSPPQfcnmBkEbVvgD0IxfgMcdn0M57soUCSK4D03P4iMig4g1JMSllTtT6lyN
 ijXrcYtafNYzkFQ6ENgDlwC+GWT+yy/p7ecb9SE1JEfjgTc02H+L2gxpdPy4EflJoM9UUrEylZq
 KjGcfM4HbxbcfBf4kBdpSNSaLxVZ0dtUo15RWWee36FZkpH4QZjv/X3Iqv6Wic6SHzFAsxWYa+t
 UqgSNAUREbQXEFPAhqqvVYJw=
X-Google-Smtp-Source: AGHT+IEtDCfXPHLFMgJ9ukZS/1W2Ue1oFQ/DhePDg9KsJAQeE68l/7x4JUKXY7ysIoJXWovNcpU55A==
X-Received: by 2002:a05:600c:8010:b0:45f:2a9f:79da with SMTP id
 5b1f17b1804b1-45f2a9f7d5fmr41272735e9.18.1757931562363; 
 Mon, 15 Sep 2025 03:19:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e015784c3sm182003365e9.10.2025.09.15.03.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:19:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1BC705F867;
 Mon, 15 Sep 2025 11:19:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 6/6] tests/functional: use self.log for all logging
In-Reply-To: <20250912182200.643909-7-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 12 Sep 2025 19:22:00
 +0100")
References: <20250912182200.643909-1-berrange@redhat.com>
 <20250912182200.643909-7-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 11:19:21 +0100
Message-ID: <87wm60qaqe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Some tests are creating their on logger category which means any
> output they log is not captured in base.log.

This seems unrelated to reverse debugging and perhaps should be split to
each test. But otherwise LGTM:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

