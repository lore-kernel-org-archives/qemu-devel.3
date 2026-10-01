Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0ACCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGjq-0005jq-O1; Thu, 01 Oct 2026 09:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xCGjm-0005dv-H8
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:22:15 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xCGjl-0004lD-1D
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:22:14 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b01d89b23so1069803f8f.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790860931; x=1791465731; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4XDMxZzI9Z2DNC7Zo1uh1LFAps4K+DQfPRUPu2kObW4=;
 b=DT6HuTtUkIUAotMA2+jGgdrIc8BRSnmTYuet7Ar9B6VVCVvdTxKIujIZFgmeIQFwIT
 7qYloWAAJfXEuH8XYZ9x1wl520GqNl7GIB8ozmTxB6ct7+BvJBiT7BXCVQsdRfGc6EUy
 4hIeNqvGYliTtotYWIKg7Kobz7lePyAT+KNX3AtoPmobZOtjYizPDYL5MmX0tkjTBy63
 77NqwxfA+3PC2dpyfUQIHOP0zvf/SZQEpT5Byri1Hyg//OnyhbUMykTRqQGvd0WxN8su
 bTfjXwncx748Tg2vxLDJMCQso7AL0jEW0R4RZjZRIyWU8mHL43Yx2XcIXOnwUg8qib5x
 3Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790860931; x=1791465731;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4XDMxZzI9Z2DNC7Zo1uh1LFAps4K+DQfPRUPu2kObW4=;
 b=OcYHyDjZ3rbv+acR+3LKuiFyhAis2yUCzy8+jxFPyuabKSbQe1S2Gv0/QBjc9p+63i
 L+2ZXSCE0PubRwNbcG+buZFw+FG+Q/sW4fw5k9Frh9gEQfq2nChMWDJK8wLIAdoQEiL1
 MIkplzh1e3iLyLEZEY0+uXprtlOYkkolOgSnCPMQFfC2JB4Abu/oNtBOPjlAh5qHViL7
 gzowpw0C/K0yya7rmyzhkMtOfOX8MGubj9x2rVNiuhaSLZ7/h1SSsL6Pwqs6+RFOU4Pb
 rwBX6FjBtETIl7UGVjOqu1M/+LXG6VyqYd4xpIQkoXpJ/VMpw1WJT3ogt65zjy6ROJa4
 jCRQ==
X-Gm-Message-State: AFq9FYJndPY9Fm/ohI3240qf6ESHmwLmGs2F1vj+ekm4PG64f7OoM/+a
 hwgNWAQfGfNczaPSlZlPTHc1+ZDGWLSQy9ZzD+ykqVFu6chVqN2yEvdqqMuL2+PyYZw=
X-Gm-Gg: AYBFou2zUzequiqlUzJ1L7O4NKZ08jdfo/YOFHAiSD6tte2CeaXp/0mR91LpPWMuVHR
 3mFLVMypzLLBABaRdPhE8/fWD4KoP1IUTsK7nPqCD4JuvNI/JV9C+o/k8TNszcFmLLSBWNuXgGF
 Kf7RkQS0nPJU2HBC294JbjtoBZ5Tg/d1Rw6yXV8F4po66i74hmdULXyCTnVG3Cb7K2Nzr9Kuld8
 /nyR54g8oidAK/iD7FrF9l1IjfRMdJwbHlHq6pI+pkW1YvLLRcN1Emx7zQzauXd0JdpGVDVldYN
 M6dg+cF51i4KcggSOEMW4z1YPA2tbjyk9Cfa6pakuXyoku/p/e5Y2NCLfWZ4quBke6pRp0zldr6
 GX0UGaG+qOGR1m/qKRHtdAXMDScmAQTs/XpqDH/Wj9fMCh1/miEX7veCYKwZi2989BieDsykpqO
 5cnIwE/Ta63sC0W+ndPhsmkVW0VQ/bHIQ/tSaj/E3Tk4Xgy//DLXubOU/Z6W/usefgGqp2sQ==
X-Received: by 2002:a05:6000:24c9:b0:48b:f08:8162 with SMTP id
 ffacd0b85a97d-48b0f088446mr3004921f8f.39.1790860931325; 
 Thu, 01 Oct 2026 06:22:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0db63f0esm3144007f8f.40.2026.10.01.06.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 06:22:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9183C5F826;
 Thu, 01 Oct 2026 14:22:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Matheus Tavares Bernardino
 <matheus.bernardino@oss.qualcomm.com>
Subject: Re: [PATCH] contrib/plugins/uftrace: add support for Hexagon
In-Reply-To: <20260930175519.3601312-1-brian.cain@oss.qualcomm.com> (Brian
 Cain's message of "Wed, 30 Sep 2026 10:55:19 -0700")
References: <20260930175519.3601312-1-brian.cain@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Thu, 01 Oct 2026 14:22:08 +0100
Message-ID: <871pa9lfnj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x0e.google.com
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

Brian Cain <brian.cain@oss.qualcomm.com> writes:

> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcom=
m.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

