Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AE0C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPtI-00013B-9x; Tue, 18 Feb 2025 10:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tkPtH-00012z-0V
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:52:07 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tkPtE-0004EO-W0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:52:06 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abb81285d33so557549566b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739893923; x=1740498723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fupdkb6zRhcZ72xBQ0C9EGT92sr/ytJJt+6oaLVGG/g=;
 b=Ac0b3tED2IWGoTcO3uF/PWwPoPb9DDWiCzP7TS5AjmBUXV/Hi6DSU1DvWcRBnc0r8d
 /0qKfAhPTPTuIaZnevzrsEXf9qqH/jkjzoBze0BJ6qazajnvJsaFLVTzL/huWd83vQ7H
 wBfzc5ry1UOmIO14AoEFVfJLO3kNnYJwdpvLNwon69fotso9Z0a+QUFBq5WQi+d+jh+T
 mflWDNRBaDnuKryJnFby5u4M/xKyIG5ya82rntoEAhGOd1FmuKgJNdb92BYuSAiHO1y8
 Io6AtRymQqfo7hkHeLfrn3D1HGn0AC+9hxJkqIsiavRdLprmYZvqmK/TS3XLcPTzXa4G
 Y38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739893923; x=1740498723;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fupdkb6zRhcZ72xBQ0C9EGT92sr/ytJJt+6oaLVGG/g=;
 b=gksRbH4IiD1jMoLTzEu9sO7gk7kJltCMAON2ALTWnsUrAfPMFbNlWN3HkU8MmYKwej
 fz/yIAvL9XiMTy/GGR9dx1qS0RBx8ep1vuZBZ/W1mCVYWB0V2WmDVr5J2rQq7H2idtbA
 NcKrgk7yaS5rh1nkWMaJJfcxPRnh5Re+KnWIUI01mWroQZa6Bbjc4EavNMaOlfNbXKeu
 ZPUO+N2+ngW8/2KeQnZNIQslZUG8JIr80hWKlzw/tFge4dm+Mj5xT+9qmnnlpa+Cxphj
 KO/V9Z/4P8hSFmpwFBaFJr/bdw6cazGTZKjDSCjqoAxkTVFjt2BY5Mc0pwyfsrf6Uvjl
 kWkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSLQscyQcBZQpTO+boWw83nBj8aaoNqiXifiGjIAWfPK+vqEawlT+KoJvL2rwvNrc5y/ho7Qn0zed2@nongnu.org
X-Gm-Message-State: AOJu0Yw+/0mi2vdIRS4ETn7Pb65jDQIkqb6WXDJm0NcQP+KmtlpiZv6N
 CTauk+h6Z/R9f6mRJp6e+7vTFpAKSxsdoNOY3ozjzIf7fMNO30cM+FVbhL0oNt4=
X-Gm-Gg: ASbGncs5HH+0tyeEx2zu38aHROBh7SL0nHORksJcOkOreHHzPsCNyKHcrglLsxfPOMT
 8W14UWVr2VKEhlNxqTp6TAsIHcJldeR+2bQ7V3syTmBfxlaZGPYlYiYP93fWNlBRSHjrFDdsEOx
 ifVVj1iOacTuhaQvqXLT6OS4wKtZFQOulmjWLmm8Xx+Fp3RgjD4fkiQdqFy97gH7+wBeNyFKIDC
 lH2dlPPkHYgHsi5nMv8Y+Dx+5DAd6vq8Z4wZbSjaQkA6lvpmduyDfJpEaOCSpt7V7lgN6wQliVf
 FgNF3ZSbbIdnU8xerQ==
X-Google-Smtp-Source: AGHT+IHAJz04XR0sbdq/j/U2oTv4BdlhciRkyvKnX5opJzwYpeB5lnKXlm69UOnR7oy/O5wg/qTK+w==
X-Received: by 2002:a17:906:318f:b0:ab7:fbb2:b47c with SMTP id
 a640c23a62f3a-abb70de28c9mr1346754766b.35.1739893922807; 
 Tue, 18 Feb 2025 07:52:02 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb7e29be33sm638195766b.94.2025.02.18.07.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 07:52:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5314F5F843;
 Tue, 18 Feb 2025 15:52:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Di Federico <ale@rev.ng>
Cc: Alistair Francis <alistair.francis@wdc.com>,  Anton Johansson
 <anjo@rev.ng>,  Markus Armbruster <armbru@redhat.com>,  Brian Cain
 <bcain@quicinc.com>,  "Daniel P. Berrange" <berrange@redhat.com>,  Chao
 Peng <chao.p.peng@linux.intel.com>,  cjia@nvidia.com,  =?utf-8?Q?C=C3=A9d?=
 =?utf-8?Q?ric?= Le Goater
 <clg@kaod.org>,  cw@f00f.org,  dhedde@kalrayinc.com,  Eric Blake
 <eblake@redhat.com>,  eblot@rivosinc.com,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Eduardo Habkost <eduardo@habkost.net>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Auger Eric
 <eric.auger@redhat.com>,  felipe@nutanix.com,  iggy@theiggy.com,  Warner
 Losh <imp@bsdimp.com>,  Jan Kiszka <jan.kiszka@web.de>,  Jason Gunthorpe
 <jgg@nvidia.com>,  jidong.xiao@gmail.com,  Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,  Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>,  Luc Michel <luc@lmichel.fr>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Max Chou
 <max.chou@sifive.com>,  Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com,  mimu@linux.vnet.ibm.com,  "Ho, Nelson"
 <nelson.ho@windriver.com>,  Paul Walmsley <paul.walmsley@sifive.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  QEMU
 Developers <qemu-devel@nongnu.org>,  Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Shameerali Kolothum
 Thodi <shameerali.kolothum.thodi@huawei.com>,  Bernhard Beschow
 <shentey@gmail.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Thomas Huth
 <thuth@redhat.com>,  Wei Wang <wei.w.wang@intel.com>,  z.huo@139.com,  LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  zwu.kernel@gmail.com
Subject: Re: KVM/QEMU community call agenda items for 18/2/25
In-Reply-To: <87jz9sq23d.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Fri, 14 Feb 2025 09:59:02 +0000")
References: <87jz9sq23d.fsf@draig.linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 18 Feb 2025 15:52:01 +0000
Message-ID: <87o6yzjlni.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> The KVM/QEMU community call is at:
>
> https://meet.jit.si/kvmcallmeeting
> @
> 18/02/2025 14:00 UTC
>
> Paolo is going to give another rust update along with an overview of
> how a rust backend goes together.

You can view/download the video from:
https://fileserver.linaro.org/s/zQzSmd92ecaT5dN

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

