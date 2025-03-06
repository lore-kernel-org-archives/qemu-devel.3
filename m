Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C214FC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 21:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqIvS-0000U6-FE; Thu, 06 Mar 2025 16:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIvN-0000QR-Hs
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:38:39 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIvM-00075s-1p
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:38:37 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c3d3147b81so137340185a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 13:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741297115; x=1741901915; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gLlz8w6pyVr8UYFGeXKy9ZVt3ayZEKpIuJVaDqZ7P0I=;
 b=cZBO2p0ExdUxtOhD7caBAHfowL8KIpTwQfG6oVB6CwodswxR8kkwKdDf0+J8SbV4z3
 hcQvSD3Z4XvZ4nz3Ki0G91FY0NNnUyG2Y9tm83gYB+c268Z5kixY+EZa5DIHmknNphy7
 LRgCYJbrYR8phggXc7AZJU9NVR7FVKz2Fq7LcJOoIpG7lqe3ifbDU1WrDDkj+fYcAJrx
 76tIpfw6Cs49UfUTO/g2wrxCYkB0vQ6c/NIDTq+ap9izw82J6Bp7cYq/zCkEHtWDP4P7
 8uzanF6c9OzB87BX0a7EhGHZPktBEL7jzLNtC9V+4hp8rAWpPLAejS034uSSU0+y4Sew
 Amjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741297115; x=1741901915;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gLlz8w6pyVr8UYFGeXKy9ZVt3ayZEKpIuJVaDqZ7P0I=;
 b=L7wxoZ2fKW5GIGk7Z77UN3lXu1ZroqwuC3S7TGYauknDAB1PZhsESlH3BYSQVCmWDN
 +G0LefOgEegxRbI7+V6v94OO6YnMp47HmxBFNFNqqeldEhofXMxUDljyOddKRj5l1Wpi
 3Xnpcg1AsBDGZKIUXov5Ip5a2XGGc9+5XLZ3JJfu+LJSnUBYOK+52fHEGRnI45GfFwx+
 qMuAMzQ4l1QxJAvdXOZtDyX72g90/HMgUnQ1Lye31O/YAYvKV4GjFIZg/DZsJS2cOp5h
 CKqzukEeFOecAWZAEb0RxeUlka3mgaUytVH1SDWxZkxF4jgu2Xs95GPqT+mLPN+SRYvt
 YYQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVOekaf28LRcyLh1wZk51TYAVXyP4CaejJGrDow/cvBLt/7BXJQP5+2WewQkdtLIphsXETu9IHYaMl@nongnu.org
X-Gm-Message-State: AOJu0YzPi9PHdT0S8sXtfd7RZS5M4IDV3p4AmcKU0iebFlEDlgMApx9A
 vgQXM2EKyP/m6G2S28ezHE0L4u3nHbu9Pz40FaeYzj1fIwRTSAw2
X-Gm-Gg: ASbGnctksBfhQhdTnjxSBiX3CHaJHgy2gpXCibvbDK/7pgCL7ekXA6rR7tY/nJVUQC4
 almUKoqTMFaXszFrwEYVAF2p5OX83TVW//nPs11hiQ/stG4Ej6ufijCJjXPznKo7SqMr7io95Sd
 oEgqfwLOPscNnIFkazDTh7KsdqnIlxc7LOWuqrAwxSQf7qcK1yrhLS+kpUJ5GJnx5AJFOLcJtqJ
 0CaMVut3a4fOwpxoRV+aTV2M0MlOarm+iBNUEIkwbkV1c9afY/m8krF2nqSzJU3cHhSTp6A4Ukc
 W4XsU8WWgHTKVJBfGupgYa/sytlMVsW180j5QugPyQZxBGTKEeGtaEG4JqhMyHk=
X-Google-Smtp-Source: AGHT+IFSvteZUcHf0w2JeTfQQ7cdupB/xFY3KRALTkXDbDv/N8Jo2nDY/mo1Am/jGwgthTnVMZKRCA==
X-Received: by 2002:a05:620a:6181:b0:7c0:c09a:bac0 with SMTP id
 af79cd13be357-7c4e60f0ae0mr103885085a.15.1741297114740; 
 Thu, 06 Mar 2025 13:38:34 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e534bb1esm140830785a.31.2025.03.06.13.38.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Mar 2025 13:38:34 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-11-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-11-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 10/38] target/hexagon: Add TCG values for sreg, greg
Date: Thu, 6 Mar 2025 15:38:33 -0600
Message-ID: <023e01db8ee0$1cdcc310$56964930$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgGxGQ3AtO116OA=
X-Antivirus: Norton (VPS 250306-6, 3/6/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x735.google.com
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
> Subject: [PATCH 10/38] target/hexagon: Add TCG values for sreg, greg
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c =
index
> 2e9a934fc6..71c137be30 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -61,6 +61,13 @@ TCGv hex_vstore_addr[VSTORES_MAX];  TCGv
> hex_vstore_size[VSTORES_MAX];  TCGv
> hex_vstore_pending[VSTORES_MAX];
>=20
> +#ifndef CONFIG_USER_ONLY
> +TCGv hex_greg[NUM_GREGS];
> +TCGv hex_t_sreg[NUM_SREGS];
> +TCGv_ptr hex_g_sreg_ptr;
> +TCGv hex_g_sreg[NUM_SREGS];
> +#endif
> +
>  static const char * const hexagon_prednames[] =3D {
>    "p0", "p1", "p2", "p3"
>  };

Is there code in a later patch to do the tcg_global_mem_new for all of =
these?  Go ahead and combine that patch with this one.


