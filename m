Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A7AC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 19:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpuRY-0001CJ-J9; Wed, 05 Mar 2025 14:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpuRW-0001Ba-4q
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:30:10 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpuRR-0006IB-6B
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:30:08 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-47208e35f9cso82832691cf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 11:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741203003; x=1741807803; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zHH2O1TInz9VrI/SztIfijTfhVxlGFaMbW2AqIdIofQ=;
 b=J8LyMl3nkExqarQSzANkd7hPfpxP0I/2FbHwbnUo1K3L1WMHLWFu6eMmu6eqBa0Dcs
 Z5/4K6ZenMhrInH031mj6pz3Ykc1AuLAS+seIYyKbuWXd8bNlaGAir8Mmmpm31Mw+Mzb
 olkkqdzOgvs+9GwX8q1TjEtYVXryRb8IKTFvF6uqZeFik5rCsSj02r+VRGKReBne8N/0
 x5YthYNaSWLcPTWuntlZmqkdpa8E1pccRTGbaKVjb2S8OGeikhBrJA2okSDijQHkszWZ
 5f2xItQYxLyX22puQL+JpuRzdfO0iiTupVDH24/X0jVL6pFnhXASlPTq8mi3Jop+023F
 j7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741203003; x=1741807803;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHH2O1TInz9VrI/SztIfijTfhVxlGFaMbW2AqIdIofQ=;
 b=Ky5cm+3rRQdlcdBfUME2aEy+3pTmUBd1wSK7m7POaxoJnZUB6022hue2O60nqFfqZE
 leTQH1amHpDe1OXAgKCr/4DcVsKRtH4bkl1zVhE8NTVzhHq1fmKE+mQ9PBmTtX4SwUOw
 z1Ufzzn1yR6ejSwsfKsE7TwHFfQCt8liJKL0JB1YIAjb808ILqT2tt304leAH/ddP3Dr
 Sink7hCi+5w8pODOHxGfPkQgJMEvc293vopMzxeYf+DEq3alGfFTsXrCtqwP9RB80dtK
 8eejK1nqfzoX//Xj+s2TjezJQdCeQzL1B3efnwLBSbG8hiT6qkOAyKpfEBf8kB6sRO5D
 hCIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0TTTBF7MB0kGOAcVl6vNenI1cyU/jTNfXP3QG+gBnkDm6L4fWVda8yp64nRJbkU7BkS1ltHff22Mk@nongnu.org
X-Gm-Message-State: AOJu0YyOz7Sq61Bc/wtTdCyynpF0FklBL/XmFSvRHc6lnCk/Tg8gbZEz
 RInK9Co1YzNx+5b4fzFH7Z34T26YxyZcbHF1pRK1jCmx0XmGRNPd
X-Gm-Gg: ASbGnctyJeYh+3ZCkigWU/UFu5UV14PbjR7ydhgSV5ZeUyl0tBzR9iCHHrYpOJ5d8qq
 oZ/uyaOEerO8woMcfmNGhPZRjx9jwvb5ptb2R4mrXbZ2UUw5xYY8JX255flNyyVJOejBiUCFhBV
 VaDtwsRHK9EMJ/qIij8y4hMdgsqGPDldPi46OQqEpFaHunCGyAnpvP29jF+IiUpebEfIREdOCd5
 NUKtEe71qBdSEP/zhdNojXd0MdrneTUXlWZQtY+0RqkckLTlOX7ypbv3yvXLk8SKmq8mCmcTnPJ
 v3OrvORBlV356+bMR89blhkk5Vw/Tfg3notJcoJF1EKnPpgHonykGvomgonY/I6F4FK5sJP4Ad4
 L0aeOUL0=
X-Google-Smtp-Source: AGHT+IGNMmmGtRvvb27aHQZDl5ygdCXtVYq5WMN1t6a/wsTzNddMzJB9QTbLMpT+syF0ZLbcaVLBvg==
X-Received: by 2002:a05:6214:b65:b0:6e8:f1b6:a120 with SMTP id
 6a1803df08f44-6e8f1b6a2a9mr25145606d6.5.1741203003561; 
 Wed, 05 Mar 2025 11:30:03 -0800 (PST)
Received: from DESKTOPUU50BPD (syn-174-097-131-055.res.spectrum.com.
 [174.97.131.55]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976cc74asm82257596d6.76.2025.03.05.11.30.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Mar 2025 11:30:03 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-2-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 01/38] docs: Add hexagon sysemu docs
Date: Wed, 5 Mar 2025 13:29:59 -0600
Message-ID: <01a901db8e04$fde0c0a0$f9a241e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgFSIBaptO634iA=
X-Antivirus: Norton (VPS 250305-8, 3/5/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 01/38] docs: Add hexagon sysemu docs
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                    |   2 +
>  docs/devel/hexagon-sys.rst     | 106
> +++++++++++++++++++++++++++++++++
>  docs/devel/index-internals.rst |   1 +
>  docs/system/hexagon/cdsp.rst   |  10 ++++
>  docs/system/target-hexagon.rst | 100
> +++++++++++++++++++++++++++++++
>  docs/system/targets.rst        |   1 +
>  6 files changed, 220 insertions(+)
>  create mode 100644 docs/devel/hexagon-sys.rst  create mode 100644
> docs/system/hexagon/cdsp.rst  create mode 100644 docs/system/target-
> hexagon.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1911949526..804c07bcd5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -240,6 +240,8 @@ F: disas/hexagon.c
>  F: configs/targets/hexagon-linux-user/default.mak
>  F: docker/dockerfiles/debian-hexagon-cross.docker
>  F: gdb-xml/hexagon*.xml
> +F: docs/system/target-hexagon.rst
> +F: docs/devel/hexagon-sys.rst

Don't forget this file
docs/system/hexagon/cdsp.rst

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



