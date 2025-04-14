Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093C2C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4NEl-0006Uj-PD; Mon, 14 Apr 2025 13:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4NEX-0006MK-EM
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:04:36 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4NEU-0002HY-Rc
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:04:32 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85dac9729c3so355774139f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744650267; x=1745255067; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=l2TEbLAtlL1JbwCci1ecI1N/NDp0qEv95NpQvUg9hI8=;
 b=XB62vqWwmgdLVcs3PitF56ObmaQ6FMepfzqJ/MHOiUpQPRtdL59bwxx4MvN5RQNGSB
 kq8au5qOHl8VNApJwNawDaCOK9oovg7QWtuGjSlnkTm1HkKBpXyMWFfUIsAwdTfhK1wI
 6Gh+z0FKJBglrcXLgT9G4ArsF/LAeJ/NtfTHorBmqRQd7f1TDKjHNckzrMRVTaaEQiWe
 bdq4c1+sltoNE10/6GiRtQ1OnmugdBZTFHiWclBnEGNY5eVGprYd5miKCVUiQltA76+P
 iLI56Vgd2TL3HdvdXIqOX+QM3ViAAujPRGDAN0kbRP2bOpG8XJtl4F9ha7GLesKRV/xs
 mQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744650267; x=1745255067;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l2TEbLAtlL1JbwCci1ecI1N/NDp0qEv95NpQvUg9hI8=;
 b=sUMkhFeRv9odAHWs95D/poAWifBdkaKQThC86g6P8Id/N43jALMXu9AfzD9iXQtrd3
 xiJHMxHpSADOQl5lWANgexcdTbCBd8wQo9O8d+i6TO4fy/rHkd/ykeKm6iTP75pW/rjX
 G47KOzeMbKuJhzxUAWj/ARIjLcfsqrPkxE2OR5f43xkm6S9+v/+azkXhaCXntIwThcyN
 VR2wUYeZzKGPbB36hCGqxmJ3dkQjoWsgr5dHBf8QRsbVb5dRhC6eMvCcrwnVtjw40dSP
 iz85mWOsC3iPko3x5BYBsbQrbO+dgG1OPfc2ltzBUWcwnKXO3ApIABF4eUjGbn7j3FuN
 NqUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhuZ/LacfaFQiJLM6XtQgozd7fD/Ydm3Kir69IlGIoVCsdmBm7lH1LA0cFfcyI7Mcjvv0IpARi7m0d@nongnu.org
X-Gm-Message-State: AOJu0Yz2LbO8H0W2vWd++SWzbkeCcruqPw28yRvq8FeB+vdWE+QfF2B+
 GY0X5jaSzoz4wfaNA9DPFowgwQTTI28mgcMpjJy59pTanP0aZ0+f
X-Gm-Gg: ASbGnctPTWNr4cyme3txxWiCNtIzy6eFHjAXPN6z+UbnC4btjfxn5us5wmG8zGAXd6z
 BppfPU0cPEGtEw1GIXUR0QZBz9oALYwGT1AxdUz+brOu6wde+hpi2LlCx6WpOF3HaSwcgLvt5gz
 zArSd0mD7iwivvPNbb7V0wEM3W5L31rCLfGLOMWTgqCPLE++Po8HgIfodYFjxd+4l9kewJ/H1HG
 vTp2XEzMBTV4f8ikXxsSOIhEgQuHpmzSyx6qgg1OMhx4ypFmBwCokRkreGgtGE2mQx1iG823Jex
 7VIbyKChclG1upG+qQTxyI0B7258nl9fffVQ+WF+5794J9F067HWODW0boX3E4kP8T5rt9W1FZI
 =
X-Google-Smtp-Source: AGHT+IGCwpx7BD8STLuK0zw76hj9FOj4m15HwYGhpagno8JjuINQZ5p0kQvrk8jx59oOa4hesV05mw==
X-Received: by 2002:a05:6602:379a:b0:85b:3449:faa2 with SMTP id
 ca18e2360f4ac-8617cc09e8emr1329862539f.9.1744650266803; 
 Mon, 14 Apr 2025 10:04:26 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-861656e18b2sm220949839f.45.2025.04.14.10.04.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Apr 2025 10:04:25 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <matheus.bernardino@oss.qualcomm.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
 <20250407192705.2605614-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250407192705.2605614-4-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH v3 3/5] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Mon, 14 Apr 2025 11:04:22 -0600
Message-ID: <058301dbad5f$467a2530$d36e6f90$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFxbseScfkce8xHjxBW05Q6egvQNQHWEv9stGktYCA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250414-0, 4/13/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd36.google.com
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
> Sent: Monday, April 7, 2025 1:27 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
> anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com
> Subject: [PATCH v3 3/5] target/hexagon: Add missing A_CALL attr, =
hintjumpr
> to multi_cof
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_common.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/hexagon/hex_common.py
> b/target/hexagon/hex_common.py index 6803908718..a2dcb0aa2e 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -247,8 +247,11 @@ def need_next_PC(tag):
>=20
>=20
>  def need_pkt_has_multi_cof(tag):
> -    return "A_COF" in attribdict[tag]
> -
> +    return (
> +        "A_JUMP" in attribdict[tag]
> +        or "A_CALL" in attribdict[tag]
> +        or "J2_rte" =3D=3D tag
> +    ) and tag !=3D "J2_hintjumpr"

It would be better to make this decision with instruction attributes =
only rather than a mix of attributes and specific tags.  If needed, add =
another add_qemu_macro_attrib call to hex_common.calculate_attribs.

Having said that, the correct tag for hintjumpr is J*4*_hintjumpr.

Taylor



