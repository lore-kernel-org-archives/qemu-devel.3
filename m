Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55742C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 21:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqIna-00067D-FU; Thu, 06 Mar 2025 16:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqInV-00066o-Gk
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:30:31 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqInT-0005Ez-7G
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:30:29 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6e8f6970326so8882796d6.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 13:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741296625; x=1741901425; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AGzkS5wg1/S/9xzfyHiqaEFz06BNTV3JMYR7LPia0pA=;
 b=lHcOAgOnDbNFkvP9z7BLDS+hQd9RyVdamW8ry7fkrOwWgIm5rbm6rIPagQEHWdmUoy
 jjSYneVjQg74tFzloUsJjIgDOaXf0GLb9JrNX0XRcHzvJwAHWjnrUfNhEvYqlXgkJ9ma
 44uwGv/4aZXycuwpiQI49GtOPapWDdGKTUFKsudMn4ahJF4GQz+TPrLsj/94ySIZmlK8
 SPp7AxiEcwhto1VVfPyw1mlFCly2t/9EpGnwCVmYfGyQr6kdbdKDnkAWaMaa0XUIsZJU
 YCAundtXFweLY+WadSqGUswQ2Kq4vy5B72wxGrAa7DJ8LN7dTdMt0310kAz+47XJxKOO
 XyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741296625; x=1741901425;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGzkS5wg1/S/9xzfyHiqaEFz06BNTV3JMYR7LPia0pA=;
 b=TRYjHXe7fKNkHjIXTNf5Li163nnZLe8Ro7DxkSJyuTy82ywdUY5d4lPCYI/xhakmh1
 c8i0la9B1dYUcxDwXfvO5WJgOd2RSiGK+Znv1MKKA/v+fIPKqzTu+iEPfpwLOV/gy5Hv
 xBlHg0j+X9UsT2lXuOs5oEdsKrLfw31mTlI81tsKeKOfdRaOQ6UZCxnjSPXrvriVHcD/
 h7SHPZT0ngMqY+nyv5MTTeshuGWk57bdK/3jfxjJnmihXXg7BubeYJR8shsUt7gJUcYs
 4eQQYe353qiB4Sj+IcLRRSX0ELb3/lQ1N7OrOmmmQgMuTlVP5hYGedRrtHpXvF6ulrmf
 Yo+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe7Lq1s+NV5RCH7fc9XrCe16ffebnA9fc84Mqm1ZhCnluM2gn99T5plQW2uO2BDB+Gdmi3EZGEIaif@nongnu.org
X-Gm-Message-State: AOJu0Yz2SIBSb8u8wGiskIp39faStwaj/svnoZyfjwuoXnXq390iq7Cg
 F1wSkLkZdraMUs4hqLoA9u4v5ufXMLDXVRo0/m4KO/0Htr8iI5YVhPXj8jVo
X-Gm-Gg: ASbGncs+wzRISHyRCyEoaXNXmA179Bwa0uipkz6yeH1e2Nei+0P8WdLGOV/OVJG5U7y
 Fr7GuRmaagu1mcZVEZlKHnrC15vtMMFMAF7WT1fIg2GUVFUxbPkYfOB3/oEkdKiTPaBUbb6Fqqj
 YaQph58noOhKrUeea8uTKjbH3jwWyxbcBuyrW6SvzCJtl8rF0Io5Jhiqrzg/bEfOTIjalXnWoZn
 JcJhmFwG4jb1tnqdiU0WuC4YVOSntHO8BtoAKNWyhNi/6KUProjGmlhRiliPYHX9MB5OKdvAokr
 S6jJ8N0uWFj2UqSLOr23yphj3yKrknyR4g/tXf5ZYI1t/TXOq8OQ1Mt7V8JOR0g=
X-Google-Smtp-Source: AGHT+IHcpWb+RlOb3znBoqi5Uim8idfMhCzdeOKzzTlBssTUTIm7Pib2p8n5doS883jjMNtwA0ZyPg==
X-Received: by 2002:a05:6214:258f:b0:6e8:fb44:5be2 with SMTP id
 6a1803df08f44-6e90063d670mr8334116d6.23.1741296624913; 
 Thu, 06 Mar 2025 13:30:24 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f707c3acsm11390596d6.12.2025.03.06.13.30.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Mar 2025 13:30:24 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-9-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 08/38] target/hexagon: Add guest, system reg number defs
Date: Thu, 6 Mar 2025 15:30:23 -0600
Message-ID: <023901db8ede$f8dc6980$ea953c80$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgJEfDXJtOjX9bA=
X-Antivirus: Norton (VPS 250306-6, 3/6/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf34.google.com
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
> Subject: [PATCH 08/38] target/hexagon: Add guest, system reg number =
defs
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> These registers are defined in the Qualcomm Hexagon V71 Programmer's
> Reference Manual - https://docs.qualcomm.com/bundle/publicresource/80-
> N2040-51_REV_AB_Hexagon_V71_ProgrammerS_Reference_Manual.pdf
> Refer to =C2=A711.9.1 SYSTEM GUEST, =C2=A711.9.2 SYSTEM MONITOR.

Strange to put this in the checkin description.  See prior conversation =
about doc references.

>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h      |   5 ++
>  target/hexagon/hex_regs.h | 115
> ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
>=20
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
> 79e60d4bfa..20ea0adcca 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -20,6 +20,11 @@
>=20
>  #include "fpu/softfloat-types.h"
>=20
> +#define NUM_GREGS 32
> +#define GREG_WRITES_MAX 32

Can you actually write 32 G registers in a single packet?

> +#define NUM_SREGS 64
> +#define SREG_WRITES_MAX 64

Ditto

> +
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
>  #include "hex_regs.h"



