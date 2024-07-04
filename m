Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08808C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJAQ-0003M5-45; Thu, 04 Jul 2024 05:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJAP-0003Ig-Aj
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:54:17 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJAK-0007IG-3N
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:54:17 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a75131ce948so51596966b.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720086849; x=1720691649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7EqW54N/gD3QtdDyUfKaeFo8kacnhFKJfEsd1V3cH2Y=;
 b=sd3DIsuBIWRAHDEhjN6MxqgFC+ygpjlzyBRW2oXGLjrjEOTT2gx+G0oE5YAPA2Lw2u
 Af6jDyzPd7E3BikhDSg6osLe33kyX+7HFLjm8/7xo+ntVOEOtIkdIKRGfz66/j+FcdDR
 OzzMmffxMQIXARKpESX/+aPqv8yPvQKjAWIAODT8b2jDaHqqVyKKf8kJ78BbtFnbUC4q
 aVzY0TduB9U59aA+AZUJ1CZHmRmfYKvUZtZzbaZeBo8ehOmhKkJYZHLv3o5HFW3Ycs/1
 vngtZDjnaARd0zW22dHyzoCikwybqo7pcNfJLoOIZlOnNvBnH6GyOSKa+cWrrPMVMhBn
 a8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720086849; x=1720691649;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EqW54N/gD3QtdDyUfKaeFo8kacnhFKJfEsd1V3cH2Y=;
 b=WsoZjdfrrkJqYRZtRRzQi44zVGCRF0t9LlKBTbJDyYk6szRkbYl/UOSzs/MCsldF2x
 ETY4/JAOr+F7rqJV6gIoPlC+SC/7aNRDKsOVaGd7pEW3aAZFJs6wlJWiIiDqZUZUZTVL
 y/2dDbSaX6FrCyg2YdfXPJ1blLbimKSU8Ji9cOJU+v9kX09a12TdL8oPJfIwXT3wyzWq
 kVyy42vdvSrkowuwYFsOHPiCriKe9puTBhYb/VRTzrfpZPX5X1OgrU9/2eTslhoPAGOt
 P6Lexee8qyo/D8xxhu2ctjbkG+fiwALMLKk05ygz1Nu2l5JB25YINemyJpGe9GKtw6E5
 arlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6kwqdiLhgtpnvzOCCA2zuOvkO4jpzgd/sENMIaUl30HNtf+bdPnH6JesfCOlfewwVueiRkSd6NIlh5siL/VmQ47lO2QY=
X-Gm-Message-State: AOJu0YztsIOMbYHw4e7evZfeRnQzatIsvBOijAeclPcdS8nUU/eZx8we
 VzKh5rvp8pmq5xCp3BxYHSwK+PlSV5H+1uJhWYGFAnA6M4usY/zaut1dpkOyjVs=
X-Google-Smtp-Source: AGHT+IHhms2ySVos1DQadnupcMl7GBV3e4GVECd6bLUke7XEY70r62UxvB9fXPw+myzqsl0a2ppdyg==
X-Received: by 2002:a17:907:3f8e:b0:a72:6ff6:b932 with SMTP id
 a640c23a62f3a-a77ba711c8emr72156166b.51.1720086849174; 
 Thu, 04 Jul 2024 02:54:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0651easm582648566b.137.2024.07.04.02.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:54:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C362B5F839;
 Thu,  4 Jul 2024 10:54:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,  Peter
 Maydell <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 Paul Durrant <paul@xen.org>,  kvm@vger.kernel.org
Subject: Re: [PULL v3 58/85] hw/i386/fw_cfg: Add etc/e820 to fw_cfg late
In-Reply-To: <6680fde4c583a892cfaf275f19b5369ce3859850.camel@infradead.org>
 (David Woodhouse's message of "Thu, 04 Jul 2024 09:09:16 +0100")
References: <cover.1720046570.git.mst@redhat.com>
 <93c76555d842b5d84b95f66abecb6b19545338d9.1720046570.git.mst@redhat.com>
 <6680fde4c583a892cfaf275f19b5369ce3859850.camel@infradead.org>
Date: Thu, 04 Jul 2024 10:54:07 +0100
Message-ID: <87r0c9o534.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

David Woodhouse <dwmw2@infradead.org> writes:

> On Wed, 2024-07-03 at 18:48 -0400, Michael S. Tsirkin wrote:
>> From: David Woodhouse <dwmw2@infradead.org>
>
> Oops, that was supposed to be
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Not the end of the world if it's too late to change it.

If attribution matters we do have .mailmap and the gitdm metadata for
after the fact fixups.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

