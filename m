Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92633C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 21:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqIRu-0007ao-Fn; Thu, 06 Mar 2025 16:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIRp-0007Zk-Ih
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:08:05 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIRm-0001JK-6k
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:08:05 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-47519994f25so14535401cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 13:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741295280; x=1741900080; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=l6BwE9SYAn4qTGitRNfMWTTNEcvnK+veA5QXKvra8fM=;
 b=alt7s8CocCwdEfblzEsj2+gwefOquimD+3dKXUU52M/ffxTVGRU2qEZVfJEvHphzW4
 Wzw4JJCGF6F3fB2HiHcsVrr5M/DbupqHTjqSlmvOzXe2fDQ7QvmNUKoJZ6Yotije0DVX
 q5xOn/298tJglQG2H7Yt4DbB1CqcqkHE7+zns5n5X0dSGytwGAlBJM8x35GZ64MJpgbd
 jHdFdz8FX5/C/4Lim8sODEflqxWXbT3OJ1oQj2FlgMuKoC0Eco3dx42NgWOOy3tgrLya
 bv+l1DQ6/f/CKwkJ4WahBUK0NY24t8PNepkcx88WZrXBxaZGgG+u+4WjTrfoGnduRKPU
 rMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741295280; x=1741900080;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l6BwE9SYAn4qTGitRNfMWTTNEcvnK+veA5QXKvra8fM=;
 b=B2nepiBTZbZSCzkGFJKTAZ2V2MGsZWKKQ4P9Mla+KfJ38djqIrXEXdtxLnWtrpGX6l
 sU//fK/tax0zJlcGc6lMH+0Liz0jnSBcbxvktl13CW4lfKxB04YPZIs1mrP7sPsHTHEQ
 uHs+EuamZQZ8fadMeroQ+EQfihSBnDdsK0AdP+/KzW+vWNCmzFv995C+NkY/A+ZFr8yn
 hOci9nKUkR+B6o3xTsIuus8q2AmH7YJP2huDOFsOj1Zif0N+a00K0+0d5YuePD8FQgTY
 d4k6Q7qjMDxS6dplq2qB+S4jwTfQreAiMdN4FdAyoG+xZ2/rL1uck+iq11AGysLZ/oZ7
 Gzbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0HRiyu2zE9ZaOvnImLloQUhoPaWgccEhRmlm+5zYoeWo3deVrX5Ta4psaj2+D+ItzANJWDkOZcjhM@nongnu.org
X-Gm-Message-State: AOJu0Yzod1i0Gh32PtJuyBu/B8t8/QG2wE+5wZq2amIdMUU/8M3LwGvs
 nJ2lbMmdw3g8BbvJJcRu7npSAl3OuxVw4/z3qC1z8khXZAS0Kq8L
X-Gm-Gg: ASbGncsP/HzyyOeRKeB0W2O0wByugWWKN6mYvfWuRqrjYriEiyVG2mxS/cL/EA5eOCa
 BHE0mpKnOyuBogXOek3MNlX3GXzXiBgE4vYy0AjsV0Kj1HUaFhbHc+AQ4LOhIRLCjgZk+6WMFtz
 vwJnYHLVdgx6+1slxrn/mV1bNA+/gsQNW52qw0vGClijnB2nGgO8ZwLJ46F7IzoeQk1SkiuQUqb
 FOH4LbcDfugYTv/Oz8YIfw7d83odnGUYekSiHV9wFdIdf6eoXcn2U86AOX5dkXFNJAwgwXAnmmK
 4RHD7kGWl5Vugcqj0/n5d8l8GTLYoKUmg3AZzA999yrUVWmlCD21q0WtjN4O/cM=
X-Google-Smtp-Source: AGHT+IHWJlZuEHxxl+aoD5wsO/Ux01zotJT9euVSYGDzksdXEoLnCWqXoZCjEyGB0t/YO88S0tEPkg==
X-Received: by 2002:ac8:57c4:0:b0:472:6e5:d7b6 with SMTP id
 d75a77b69052e-4761095001fmr7640581cf.6.1741295280151; 
 Thu, 06 Mar 2025 13:08:00 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751d96c3b8sm11766171cf.26.2025.03.06.13.07.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Mar 2025 13:07:59 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-6-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 05/38] target/hexagon: Switch to tag_ignore(),
 generate via get_{user, sys}_tags()
Date: Thu, 6 Mar 2025 15:07:58 -0600
Message-ID: <022c01db8edb$d73c5900$85b50b00$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgJ+THThtOcCAFA=
X-Antivirus: Norton (VPS 250306-6, 3/6/2025), Outbound message
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
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 05/38] target/hexagon: Switch to tag_ignore(), generate via
> get_{user,sys}_tags()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



