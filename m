Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB22C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 23:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts9E4-0008Qu-67; Tue, 11 Mar 2025 19:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts9Dv-0008Q5-Eb
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:41:26 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts9Dp-0008DV-5b
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:41:22 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6e8ffa00555so38339826d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741736473; x=1742341273; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3bNhp+GvS6dVlSNnPa/CjSVNysRqVMdNhOdM5QIIRSs=;
 b=hgFHtNOR6g52hexx0jkLXg0krmpSjtzEe+szoYbtigrEtfrUR491QLz50WOuLgpCx0
 qjJ6XFZVQgPFiZL2iodxxcWOxJCikU0h9Cpaon90AX6Vs6IxigQBzbIsUO5CbY6/3Jd6
 nRCrqgF3QvRiH9nEB2qplRKnyW4pu6KYP7arEcv6FBFt/dCkgkKIJquqjprKyydusjwq
 r8JUZJu1/dnpQNedR1lUojntKNMwFAlhCH2WWl1XwDpQxNo+CcgJEyJJd0SodPZIQ0AJ
 coW8A33dxDGdIYnP/iHb4g7Pr5rSltSl7UBow9W+elUKNleTJpEbxJiBOiLpc94/vCwN
 hB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741736473; x=1742341273;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bNhp+GvS6dVlSNnPa/CjSVNysRqVMdNhOdM5QIIRSs=;
 b=d7uD75YB5pLFwP/CTL1yQ98X/fi4FmkGLFANkYuc8vhlBvZBbUGAEHz37Sni6r7CDz
 ZX72AukK5LwfU0Xvfh+feIfsNrZQ1+EQfZtnozEOSnUuHiyno3wJtCYvp17OTWV0Ng4n
 xRRNWqqkCVCLiUE8htgsZB735Vtq82RnCdq/vNr9cLHm5zcrQEWaD4KzJD4WoL/wGYLX
 P7J7ULKAkH9AsS89Ejjpz672rEWdGd3nL91LQmEosq6HPcoZoB28OpVGqEHV7JhLYQCi
 bKEYwdGP2JPGpMJPZzaZMbWC3TbOpAxs7llqThnFFKSO3QSdvNFX3Tr4uiKg1zAKcwTE
 UldQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6UOEeYmumZiy3xU8MTaIUIYrmkIC7Dg/5LvfoyLdmTdDolC2uX9ypevgvLHKtYTXxr5MTNcb0+7JH@nongnu.org
X-Gm-Message-State: AOJu0YztLPLh2WrgThvAzs6skTp3JCmqgnxY+JO6gkW3Zf+aeWH2cecL
 dcO/9qECaZ7U2HPj8OSzfqigllCpBT+873NmiXhgZ1apS58Fkoze
X-Gm-Gg: ASbGncstQ1j0ovM0JIrADzWc/L0MKiBLXdwbDVVHGihQ8w3oO/UAOtUe4ou6KB6+hAm
 mQcM966c5BnfVMVMDl3pAm5mqsc1eiVLxKjatXUfoxKajWC3STlzwauhWVcIbeibtlIjxJn7zuo
 Ql4pvdPwHEI3h6vBtFbRpNKjpIswTUKxtofRmuvcXthg9JIYuZ43HDoK9pPPeixxjWpw9RqEZoB
 e6JfmxFjo1WgM0RiQmIE4Kc8/8P0YM+eoIb3jy6XKw12yhqBgurd376+TDAT///rEhSQ4dBLgLa
 DXmBo5qBGjysSvtP6NjIrq90Th0D4wSqVzxhI0lFszWXYfR+nSg4NwmuFdsk0N8=
X-Google-Smtp-Source: AGHT+IFk6tr/GrQXOrsrT4hxxIsyTBAT4V+ReK0UVoCe1XxyWCUGz0doELFUJUbI7+j5uKn7Y9M/JQ==
X-Received: by 2002:ad4:5f0b:0:b0:6e6:5e15:d94f with SMTP id
 6a1803df08f44-6e900674e0bmr283903166d6.27.1741736473132; 
 Tue, 11 Mar 2025 16:41:13 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:a832:3b35:d71f:4119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b50asm77740626d6.84.2025.03.11.16.41.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Mar 2025 16:41:12 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-31-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-31-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 30/38] target/hexagon: Add a TLB count property
Date: Tue, 11 Mar 2025 18:41:10 -0500
Message-ID: <00ac01db92df$12a754c0$37f5fe40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgKbEtX7tO4kn5A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250311-4, 3/11/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2c.google.com
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
> Subject: [PATCH 30/38] target/hexagon: Add a TLB count property
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---


> diff --git a/target/hexagon/max.h b/target/hexagon/max.h new file mode
> 100644 index 0000000000..0f595bcb73
> --- /dev/null
> +++ b/target/hexagon/max.h

Name this file hex_max.h or hexagon_max.h to avoid conflict/confusion =
with such a common name.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



