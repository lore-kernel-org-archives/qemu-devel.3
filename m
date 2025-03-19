Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7FCC35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tux65-0003cg-3E; Wed, 19 Mar 2025 13:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tux5x-0003bX-I2
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:20:48 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tux5v-0006lM-VF
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:20:45 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4768f90bf36so58814501cf.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742404843; x=1743009643; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/oz4vFkt0vu7R2WLcd9oj5E1DTZW5cYFVorDlubXmp0=;
 b=HI7O8O60wuqEAQpLQMcdVamdhxQYZq06M+XBbc3EZQPq3ql9eWt9tfleH8MMDc6pn+
 DJc8IcSrIzR/AxQsBEXotKtROu9madmvUlcC9QGYKYeCjd3O7vpLD7Rae7Agyk1wazsa
 602DeYttl9iEcyu/fPvPVs+sgm6XjxTi8ulJB3glVQ3hdnSid1X5cCgu3MDRy81nkgDu
 LSKsC/RJbOuMWSpnH+EoecigiXOg1+7wYkQuSH59AH2DDcORBK1lZZjWIW5rnFxIsZFb
 /3Tl+ND961SxQtD40O+9kdepMwuNR564Qjbhi7NDE0cmJu7zMzPPCXhVxLQuy0tQQp6y
 WdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742404843; x=1743009643;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/oz4vFkt0vu7R2WLcd9oj5E1DTZW5cYFVorDlubXmp0=;
 b=j2v+PjY7unhZNrakmpn2VZSPvvhc6YGUi6P/v7XiTQS5btX2QYg4Nj49+xT2dcfsQz
 CCoV5UdvPwqUoVSdnFxI1VlGCThwZ6Tldph6/RkvyyrN/7Dqedl3Akz/fW8MzGrrGGgw
 6moPDonuuzSzt9ZOSG4zWJ1iZa1qN8817DP6KUpeeKpTzE2vzPZ+P2tGX6PJu1aTO555
 YA8yQsLyJ9R1OyahwQurgvp3s4hjUC7edT+pFPoelCxm2hTCFXKnd6OZgGpLQTc52qot
 qNJhhuVkf0WCXFI0tysbNJtDLLX29gp9xaoYcxcZ4Q3DBK4+fgeGH/BCs7nAroXk4pW7
 2dag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDx5fGBzUhdq1t0LuPg4wFJGfM9PBiIzzSDWIDVraNDlpqACVMG0SIMdV7sF9PmQbWGqoo6nmeJGnR@nongnu.org
X-Gm-Message-State: AOJu0YybBfRcjlwlxELVqbDzTqdi6b/A0v05xvwN0nrR38NvucvUYnRW
 aZ3GO2X2qJIylcgXX4DAg9JVr46tH5S/00tzzJCBq5LX4ajoXne5
X-Gm-Gg: ASbGncuJExzhDh3wqGIT+/T3u4U9mQmlDtyBMawKMdrAMYJkoWociFp9zMEjcfs2A6E
 SCRCjzVjXZUFPE+FwViEjb0FQKDnBvN4Yvd/LxumsYx6A4uEmwL+FOkyGx9num96hscRhv1w9eR
 Gl2KXYDPOTA4+YkhgL9Oom1/RizbE+OcBXjZ+zm3sVJ2+FWNo3pkrBydxoyrZSb/MO00qhDdR/8
 xvRuHej4w5EOGfbqa72+7eEWuHfbVxO9HVh1XpEAmXaBK2sN2tKLzy1MSkFlH5c5SUJf6f9uE9N
 3Cd9/8sREipSYDFoArUEh61xQ4gbP1jJdTSgAqaBLJLS/GvglZYi7do4zQgSEQ==
X-Google-Smtp-Source: AGHT+IGHl5aI8axXZcU4DcLZuIbS2TeGHXk6OzrMv3HgkTkvNBKG61G0lF+HI35bB1ZaoJWQcRKg0g==
X-Received: by 2002:a05:622a:588e:b0:476:79d2:af57 with SMTP id
 d75a77b69052e-4770835cfa6mr55271371cf.22.1742404842729; 
 Wed, 19 Mar 2025 10:20:42 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb669f72sm84617731cf.42.2025.03.19.10.20.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:20:42 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-36-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-36-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 35/39] target/hexagon: Define gen_precise_exception()
Date: Wed, 19 Mar 2025 12:20:40 -0500
Message-ID: <02c201db98f3$3dee1690$b9ca43b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQH2/w/lsvWDTLA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x834.google.com
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
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 35/39] target/hexagon: Define gen_precise_exception()

The definition of gen_precise_exception is not in this patch.

There is a use but no definition.

> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Add PC to raise_exception helper
> 
> Replace the fGEN_TCG_J2_trap0 macro override with the fTRAP()-generated
> system helper instead.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>


