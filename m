Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB36C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvONn-0001jt-A8; Thu, 20 Mar 2025 18:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tvONh-0001ix-3r
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:28:53 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tvONZ-0005HQ-QI
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:28:51 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6e8fc176825so11044326d6.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742509723; x=1743114523; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DhzRkPRbZ4GduLZwaltWlcCpN6qXMglp47tgAS0H40A=;
 b=HMky79cVdHKTIfWbn75bEkCHkoy5AbTE3oYCNBpP4IJrmc3wCc8XIQhxmYJmGD3SGp
 6ZkD6NlCX9DemEwDI+cA3Rcav4y29hXw8j9ZTrVX7m5fmQ9jNqgeobGNZFdHsJ1H9pRU
 +uRjZR3mnuTp2ImMkMK2y74lXK/NWbk+cEwMVw3eYnrGV0U75NOWKmSZhyuDlrebvT33
 /j0JbKj9smSFmBCjTr/8XHR/1pcIHQGpJfcUeC2Uxsf3XnGrTuqgMMpoc2X0s4b+O0bD
 CX7rlTV5/DA9QqpT46/wkaIc3cvwYmUt5ueVXLpnvUXSGYiR403R7knbhjpxqZGZaSPj
 aG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509723; x=1743114523;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DhzRkPRbZ4GduLZwaltWlcCpN6qXMglp47tgAS0H40A=;
 b=WxUOaTwBxkhZq88bRmA3KjfqZbROPcWFBlgx/B8N5u62xc+cBEitSw6JVh1evoUvIy
 +xeLn5uV25o2HBIhiAu50yxykWIlbjJpPYUEdweilW9/8/IPMKbfAGvFrZp7YsinUBs/
 Hd7wLbsEKdBTtty3LfxXur464jenrjzXu2nyj0dqCMt+H0XpHW3x62EjnmMdOJxVjtxW
 eEvJ8vz18bVp4t7RyyhvKifx5ErOpZ6qZQzeSqjq71QI0uhwd9lDowdYIdc8a+PzQsfG
 QfChcHdjJLOCP2WurJi3we9M8uwy/leL5XpPrmjhenXJ11Iu0u2V2pX5i23LpwfrZYQn
 7GRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHFBi6HSdwjiZmDuQzMjWEJL3u21+xYyR8cD5Q/hF1YHknniHRE52gc5IGofVflmGGN4Hl+XLNa8xC@nongnu.org
X-Gm-Message-State: AOJu0Yy3IPDbXY/Re9FIg2dLRD4HWhVLfmxcZe48IbukvfkBqr9Nl0xN
 sIq2G74LLc4qhMF0ajvAum/eTgOuzjHfyA95bts9++siLNJTHa7m
X-Gm-Gg: ASbGncuuZIhUnB+FipdpLsuT0fAXpclw3dRl/h5ZYBeTnDcQa9qeuJj/XBkX76DviQh
 SnbAyIospZ/W7ma9wjNPCL8WoFm0E3ylAGPN/IfDzlEWfwtx1v4Bg96gp6Y95i68q7oDaLbw/ZG
 hNADY0weY7Iby9WhMd0A5z4pIfFTnFyVy6iE5PPAZIwe1xe22Y/D91bLlmgaejIbtIoXfMfURlg
 lMmc8/h3EyMOj1BIhgJ6deKv/oO9YuYvXusLc2RMgTIBOb6LbvTkJrTVrvC7qbUKm7MHMbckEIF
 R4dqQagNK/cRbOVLgHfKVb9Xb4595Nfsv8f2q9ok/HcXT7X34M9a6d6gyIbWJZk=
X-Google-Smtp-Source: AGHT+IHotKrbWm3mUjIjRmiYgvCWAy0qj9zVKQS4ACZ5sytpPC9mKUhFR9+Ckg+loUTaTH0vVkWDSQ==
X-Received: by 2002:a05:6214:1c0b:b0:6e8:9bcd:bba6 with SMTP id
 6a1803df08f44-6eb3f27f3abmr15460936d6.7.1742509723133; 
 Thu, 20 Mar 2025 15:28:43 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:7462:60e4:5895:7c5f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eb3ef31abasm3258696d6.58.2025.03.20.15.28.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Mar 2025 15:28:42 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Sid Manning'" <sidneym@quicinc.com>,
 "'Brian Cain'" <brian.cain@oss.qualcomm.com>, <qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 "'Matheus Bernardino \(QUIC\)'" <quic_mathbern@quicinc.com>, <ale@rev.ng>,
 <anjo@rev.ng>, "'Marco Liebel \(QUIC\)'" <quic_mliebel@quicinc.com>,
 <alex.bennee@linaro.org>,
 "'Mark Burton \(QUIC\)'" <quic_mburton@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-23-brian.cain@oss.qualcomm.com>
 <03a101db99d0$8c67c5e0$a53751a0$@gmail.com>
 <IA0PR02MB9486BDD73D3CBCD3468C367FBED82@IA0PR02MB9486.namprd02.prod.outlook.com>
In-Reply-To: <IA0PR02MB9486BDD73D3CBCD3468C367FBED82@IA0PR02MB9486.namprd02.prod.outlook.com>
Subject: RE: [PATCH 22/39] target/hexagon: Implement setprio, resched
Date: Thu, 20 Mar 2025 17:28:41 -0500
Message-ID: <03aa01db99e7$6f8a20a0$4e9e61e0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQH8eWrXAinTeNYBj9+NfrLZdzCQ
Content-Language: en-us
X-Antivirus: Norton (VPS 250320-10, 3/20/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf31.google.com
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
> From: Sid Manning <sidneym@quicinc.com>
> Sent: Thursday, March 20, 2025 3:26 PM
> To: ltaylorsimpson@gmail.com; 'Brian Cain'
> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
> Cc: richard.henderson@linaro.org; philmd@linaro.org; Matheus =
Bernardino
> (QUIC) <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; Marco
> Liebel (QUIC) <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; Mark
> Burton (QUIC) <quic_mburton@quicinc.com>; Brian Cain
> <bcain@quicinc.com>
> Subject: RE: [PATCH 22/39] target/hexagon: Implement setprio, resched
> > > +    if (lowest_th_prio > best_prio) {
> > > +        qemu_log_mask(CPU_LOG_INT,
> > > +                "%s: raising resched int %d, cur PC 0x" =
TARGET_FMT_lx "\n",
> > > +                __func__, int_number, arch_get_thread_reg(env,
> > HEX_REG_PC));
> > > +        SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTWAIT_PRIO,
> > > 0x1ff);
> >
> > What is the significance of 0x1ff?  The field is 10 bits, so this
> > isn't setting all the bits.
> > Should this be lowest_th_prio?
> [Sid Manning]
>=20
> Hi Taylor,
>=20
> The value 0x1ff is correct but it does look like BESTWAIT_PRIO is not, =
it should
> be 9 not 10 target/hexagon/reg_fields_def.h.inc
>=20
> It looks like it was added in "PATCH 19/38 target/hexagon: Define =
register
> fields for system regs"
> I will make a fixup to that patch and correct the value.

I see.
If the intent is to set all the bits in the field, then use ~0.

Taylor



