Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E8ECA100C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 00:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utFCt-00055b-91; Mon, 01 Sep 2025 20:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1utCYk-0002Wr-20; Mon, 01 Sep 2025 17:59:30 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1utCYi-0004BA-HB; Mon, 01 Sep 2025 17:59:29 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-afcb732eee6so821584166b.0; 
 Mon, 01 Sep 2025 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756763966; x=1757368766; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/ngE22vPxlMtDkBsAtybowPceCu6XWwfYyIKVIS1CXw=;
 b=QfrOCgNBXJHAqlvXr4REOQLUD3Wht6Z7obgm/BHMxWjHidF2/NpmQcFL+D6YewDJ0N
 qgw9DHrWb75NAQc7h22nqJmo6VAs+t9S1MBaduj7P+6gzqJebnX3FwTLCwH1KSd502Gc
 DINMT1yz2JiCHRsc6UrJo+1fTn2s6jKV1n/BIpg+WF5bOda9mQaZjzU6aob1duVfNogJ
 7gcZDV3B5D+6YzZOlRZOyUhJ1c+eU9oc1LsRyjmNHLmvUS0Leik+Q1C8SQIgsParLxlg
 QsPA4lJWTRZCzMqC69ONCkoY7++6XAl+FLwjMO4Unleek90OahQpraeGdgEcdnwbdyI8
 CFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756763966; x=1757368766;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ngE22vPxlMtDkBsAtybowPceCu6XWwfYyIKVIS1CXw=;
 b=G8e/yMZEPpzFmzKOhUGDoDczF8FMGeHzFy0NrzmI03pA0jsf8JDagiTucxM3bRNkzW
 +xRnRumRstXtQEa2RP7tGJwUrNaHOfndhC2rLfG16gDYejTDPblfJiGa5eAlGvaRPWh9
 JNtaffLdfzm/IumAq1l3Egzf4RzjNibQ8WEME0T1+UFD+17PtNfkEH/hG42at1STICOd
 Wtb1+hz4kYDCRTjadjDLnrLj56zRMkbxgXyUQIHtcFRpIe852DfNkLeIh7uDB1/U1Syn
 TpYwdSi5/dHMxFspDqOX+qrrUzB/WC9KDG352rAJxeNvspxXE4d5AIJZNt80nYiOqxsX
 0D4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHveKY1tlKODsClOVL//6Ys8vG008L9M7YcW2Lgyoiya+XCJwP6k8wbOmkHNF3kP6Uc8pK30unVg==@nongnu.org,
 AJvYcCWY/DiRcPsap6m3ZJqfRGCSLMU8JfT7OhLIFKLM7150NnMbyS6D6lHX/FsdE/s8C3upcrTBSjXmLNTaFA==@nongnu.org
X-Gm-Message-State: AOJu0YyRpDQIIDyNAVLaIUpvxVA59+o/OYFIfFnnzv8cY4pBNSrIUAmh
 jtNaAbw5hx+MMLiL/4FXDlShRnLy6c6HM20piIxUC3KAWN9Abr6+DNzL8DSOu9u8n2U=
X-Gm-Gg: ASbGncvYz8qNKN4dFCJdDPiiI5Lb7/VSmq3/5eiE/JiZOV8Xw0zjw+4AOkZAhG4pRj4
 72I7ChXXLQxz718KedsF2BbIMjy9M6HIvprbcfQXb9DIRATHL5uPpbZGBuXftxc/aXWI+C4FXsx
 OHXXl1jHhTMeNMx9Emi3wyezvQeQyC1TrTyJrt8WRYwf+GnLkBKW04GD6oGMNkoRyC4g/uiy/Zg
 uyk8JOh9sYLozW1Xek0pD6fpgmq2nk8JYET/2IS4lOh2a6hsiSFB2w9Q8J3fIfRf/Wg6qU19dMM
 2moxKqn9cd1DGkYqJFaUC3nxLXMxHqXqukYJmcXsngDiEHqBy8oF4xYNTWI9Ds+dxCSW41BxiJp
 iuky3UTjOAM760P7JH3kNN6yuX/Yk05egdZkB6M9ogzTCycP9ebWQWjh+sLefeSrAPv/Eq/rF33
 CGDYA3ME0zSSpMgDIlysWnfybc+F4cltfMrDK9TVb/siWcIntfhl07vR8Uo+sdd/YXDNG6IrMyV
 Lo=
X-Google-Smtp-Source: AGHT+IExtUNJN9kymg9nxswZJC+AVwJwsVBAGFXZYFOP6qd+sFKzn4QtvuZhTD/9XViU1pAoQMNdxA==
X-Received: by 2002:a17:907:2da3:b0:afe:6648:a250 with SMTP id
 a640c23a62f3a-b01d8a6a71fmr817274166b.17.1756763965963; 
 Mon, 01 Sep 2025 14:59:25 -0700 (PDT)
Received: from osama (ipservice-092-210-202-008.092.210.pools.vodafone-ip.de.
 [92.210.202.8]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b040b1cf3c9sm609597266b.5.2025.09.01.14.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 14:59:25 -0700 (PDT)
Date: Mon, 1 Sep 2025 23:58:53 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/boot: replace fprintf with error_report
Message-ID: <aLYXHdYRlLyjr7Gc@osama>
References: <20250823150321.135527-1-osama.abdelkader@gmail.com>
 <CAFEAcA-GpC3ouaXTQ18VhcY7c-jXK_SF0MLiCMFW471U5Cqr9Q@mail.gmail.com>
 <874itm2joo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874itm2joo.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Sep 2025 20:49:04 -0400
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

On Mon, Sep 01, 2025 at 05:59:03PM +0100, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Sat, 23 Aug 2025 at 16:03, Osama Abdelkader
> > <osama.abdelkader@gmail.com> wrote:
> >>
> >> Replace direct fprintf(stderr, …) with QEMU's error_report() API,
> >> which ensures consistent formatting and integrates with QEMU's
> >> logging infrastructure.
> >>
> >> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> >> ---
> >>  hw/arm/boot.c | 22 +++++++++++-----------
> >>  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> >
> >
> > Applied to target-arm.next, thanks.
> 
> I didn't see this had been posted but I did a more extensive clean-up
> here:
> 
>   Message-ID: <20250901125304.1047624-1-alex.bennee@linaro.org>
>   Date: Mon,  1 Sep 2025 13:53:00 +0100
>   Subject: [PATCH 0/4] arm_load_dtb cleanups
>   From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
> 
> >
> > -- PMM
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro

sorry Alex, I didn't know that your patch set covers that.
I just submitted a simple patch to replace fprintf in raspi4b
Would appreciate your review.

Thank you.

Regards,
Osama

