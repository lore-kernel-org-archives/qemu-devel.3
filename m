Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AF3C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 19:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP65f-0001hk-72; Wed, 03 Jul 2024 15:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sP65P-0001P8-CG; Wed, 03 Jul 2024 15:56:17 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sP65L-0001rA-3O; Wed, 03 Jul 2024 15:56:15 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52e9a550e9fso866175e87.0; 
 Wed, 03 Jul 2024 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720036566; x=1720641366; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nABnWO2jH0MDHBwOkZK1RtSwctfW2WVcS4fNfMuQy74=;
 b=g4zIEM39DCGUP5rAmt4uYPzhwGj5MEm+SncTiuyth3I42phAxNzRHMIhHqCHJu+84a
 980uH1hD/PpJt7nbnsbUsD4nIWTK8PfwN77LxcvfbTtAvczx7nWM9lzPUanOZJRnUlm1
 kfdWpMnDT4+DjFl94vVWtHh1GU3g+ja2D80RwwNP2dqa+hh6jU317DZxuaPB7FslZ2ZS
 uhtjf1nrqGmyiPqMUmRyEZtR/c00l4XZnSDgNmav0HjtaCShl3HQVaBBMExRUa4CmoUR
 u6RUtpCKYaa0qgDK1ZIdFU1bv213HNA5imYEFpzjvmqkllI/2OtHLls2KlGqhkHbvFt/
 XzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720036566; x=1720641366;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nABnWO2jH0MDHBwOkZK1RtSwctfW2WVcS4fNfMuQy74=;
 b=X5Uux/Ef/esut8pshLGq2/Hwf5Fa4E1VKHcbvFWXXJweXqugMFmdoIBBCpewRdyY/d
 0YXFMiJygLq3O4AkrLpBy4VVzJQB7jiAru9XtTP8/AKQDNehnFhPujBek1D7jCf/OdIM
 HVqpmEE+/0yM24hadHPW2Z8JYmXnfm08BnSloHjIVPmJL65FpgMd13+pg9FgR6bx6rSW
 bXMyc8KiI9Fi6b19xJovLsL/Y/zPhzQujePyQSuswOS+KJp4woauWFm6RxMckNplCXcj
 WoC2Ce1EX0WuNrNeSG5fGEASB34d2fp1uzi9SQJzTJJImkfHrdFgjIPumT2e9cc7MvhZ
 gSTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjViFjM6jCRdhJhchWow5462pZFvTxx1P4gaAheNrs5bTz+Ka+4RsN4/2QTOZwwQ/o7VrC/eGhiSS8cew8YtxFLzY4LgIShIM9RkSCybRxaTfIorGlXWcm7I8qbQ==
X-Gm-Message-State: AOJu0Yw1YV9FchphR1WkcF/6uzVcL6NorX62vjQVP89rBGcqaIFtrcjB
 7DJq4br4RVuL+BI1ycCT6w38+mOvafC54/pFg0vOg8spJ2I1rDiM
X-Google-Smtp-Source: AGHT+IEjOxlPAcurfPVGHqdWiKhzCXD7Q+47TQtH+EaxRckU/LdGLuiCcrt2Kqf2mKa+pCLHYJ4w6w==
X-Received: by 2002:a05:6512:453:b0:52c:ebf6:9a7f with SMTP id
 2adb3069b0e04-52e98057697mr768508e87.11.1720036564598; 
 Wed, 03 Jul 2024 12:56:04 -0700 (PDT)
Received: from [192.168.1.3] ([176.194.243.4])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52e7ab27af9sm2241184e87.152.2024.07.03.12.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 12:56:04 -0700 (PDT)
From: Mikhail Krasheninnikov <krashmisha@gmail.com>
X-Google-Original-From: Mikhail Krasheninnikov <mi@gmail.com>
Date: Wed, 3 Jul 2024 22:55:17 +0300 (MSK)
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: Mikhail Krasheninnikov <krashmisha@gmail.com>, qemu-devel@nongnu.org, 
 Matwey Kornilov <matwey.kornilov@gmail.com>, qemu-block@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio: Implement Virtio Backend for SD/MMC in QEMU
In-Reply-To: <87le2ipigb.fsf@draig.linaro.org>
Message-ID: <7c281582-e5a3-265b-f6fc-80f7a1f01078@gmail.com>
References: <20240703145956.16193-1-krashmisha@gmail.com>
 <87le2ipigb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=krashmisha@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MALFORMED_FREEMAIL=2.967, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Hello, Alex!

No, there's no patch to the VirtIO specification yet. This is 
proof-of-concept solution since I'm not sure that I did everything 
correct with the design (and as folks' reviews show, for a good reason). 
As soon as most obvious issues would be out of the way, I think I'll 
submit a patch.


