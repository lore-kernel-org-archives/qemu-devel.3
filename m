Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD00C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 23:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzOA8-00062X-Ld; Mon, 31 Mar 2025 19:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzOA6-00061i-IW
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:03:22 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzOA4-0005ZX-FB
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:03:22 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2a01bcd0143so5425867fac.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743462198; x=1744066998;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0b/HREWlSts9X6mo5RQnPiJulzCTMn4twu4d9WJao30=;
 b=GrWDDSYldbjdWvIsSSpaygkh2DoKeSyJV0eVtqfc3Jm5bVYm0Kkvs1SOTskR5vdKvV
 K9qJvarAp18+1+AChfOuoaOiKaICrSAnSDVxAuAvR5Ykn/Yev4PzUkGS0qi2Xsv1D6Bi
 qDVnv1b4IZlv1CNI0KTkZklpJmZD8MwCQVvn5oi2E2YSdqAcExd67N6wkWicB4wgFCpg
 ZCzpc44VV5a4jbNUIvw+WqyTAhk0uwAyOscuhrwdRC8Z4zxHSDuye5tEaSWyMJoHMrrK
 JpLCtEDN6LXvTt4vzFQVSPQ3aCHCqY22iKLxS5tSfgaS3mvECytyIv3omsIbtimb4RRS
 k2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743462198; x=1744066998;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0b/HREWlSts9X6mo5RQnPiJulzCTMn4twu4d9WJao30=;
 b=ERxXuDU32iSMhOQgO/Dwz301EIG+bGmagW2MnJa9ffktSOIXSXFw3Jfq0CV4dr0oim
 5CyCqLeOzsHq7IEFD5iNh/+kj3Z7ty7Xyx1CINX1m6aZIMtGWsYRm9Ympq67nthqf0oQ
 cAsigAtGM2AQOKFAQbwOBEObSJoruA43r273JGExj83v9mq/dJwl2L9nmA/2mV0c6mGq
 B01WrHz6Ior6AwiZvpmhWCYAAOxFN9AEhzGXalj6AYzvt2odzPfRLZDrcxw+TJkUg9jV
 A7NshdJf4eJLP+43n/Za/Bem4+4vn7ldLJJtbW6pX7DIkFBId7YOtZeMg1qQ/LnaGFfY
 CG1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlslFy/EwJIepXwZXhkP5J/RT+XWbk9C7QFSN/uQ24dPf2w4rMSxkaF0hzYQIOG8/kkrV6mDvCobGa@nongnu.org
X-Gm-Message-State: AOJu0YxObkmvVAMmckjQ5K86RbNLVSCObnMX6EqMIVy0bjaNN1Asyunh
 zTrqgxMnfp3Ms6j3Sly9+8mb9jIUtp7Xku4834nN0+aK4U8e8vtObZ7cUBry2sQ=
X-Gm-Gg: ASbGncubX1tUKqXWJjXKkchSNZ5jmadCpkbP3CuAnPFORb4scMs3iwzH5xCTrG40t8x
 +Z4GmCndNZNCratCH7vkMfwzH/OOkd0rextson6t1ZHQ3DeUgfXWQcCH1oI/Z+KDqzb+D8YyBxb
 pPLE3T5Hy3SA8tGkW4XhVv5OwVpCouJbMuF7MowMVNtiSgqMB3pvTDunYcoM0Q8kqQkOGK2H7q6
 +cCm/U5R05XV+6VJedOMKw5jX+qVEbFG/8isEPbniEcOzhvPzUdC/xc7y8Cg0eLrLEraY0LC9aK
 hsdNePzzD+ck/yCOPtHWWFMkVA/SE0vKWfycThgSQ0MS2dsa
X-Google-Smtp-Source: AGHT+IHS3C/1z1AASrJ+n37ajLlILqGsoopGzGnCy9lE7adF1fk6EuWY2pXJa6fcTT2SPfkl0n2R2g==
X-Received: by 2002:a05:6871:554:b0:29e:32e7:5f17 with SMTP id
 586e51a60fabf-2cbcf6c7ff8mr6179022fac.28.1743462198592; 
 Mon, 31 Mar 2025 16:03:18 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8459:d76b:f4fb:8568])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580927f4sm1656119a34.3.2025.03.31.16.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 16:03:17 -0700 (PDT)
Date: Mon, 31 Mar 2025 18:03:11 -0500
From: Corey Minyard <corey@minyard.net>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] ipmi/bmc-sim: implement watchdog dont log flag
Message-ID: <Z-sfL6mlGud_N76m@mail.minyard.net>
References: <20250331125724.607355-1-npiggin@gmail.com>
 <20250331125724.607355-2-npiggin@gmail.com>
 <Z-qU_5RWxK-qpGTn@mail.minyard.net>
 <D8UT7SKP9L19.126NYIT8BU3AI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8UT7SKP9L19.126NYIT8BU3AI@gmail.com>
Received-SPF: none client-ip=2001:4860:4864:20::2c;
 envelope-from=corey@minyard.net; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 01, 2025 at 08:37:19AM +1000, Nicholas Piggin wrote:
> On Mon Mar 31, 2025 at 11:13 PM AEST, Corey Minyard wrote:
> > On Mon, Mar 31, 2025 at 10:57:22PM +1000, Nicholas Piggin wrote:
> >> If the dont-log flag is set in the 'timer use' field for the
> >> 'set watchdog' command, a watchdog timeout will not get logged as
> >> a timer use expiration.
> >> 
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>  hw/ipmi/ipmi_bmc_sim.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> >> index 6157ac71201..32161044c0b 100644
> >> --- a/hw/ipmi/ipmi_bmc_sim.c
> >> +++ b/hw/ipmi/ipmi_bmc_sim.c
> >> @@ -733,7 +733,12 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
> >>  
> >>   do_full_expiry:
> >>      ibs->watchdog_running = 0; /* Stop the watchdog on a timeout */
> >> -    ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
> >> +
> >> +    /* Log the expiry if the don't log bit is clear */
> >> +    if (!IPMI_BMC_WATCHDOG_GET_DONT_LOG(ibs)) {
> >> +        ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
> >> +    }
> >> +
> >
> > Are you sure this is correct?  The spec doesn't say what this means, but
> > I would assume this means "Don't add a system log" not "Don't set the
> > expiry happened bit".
> 
> From IPMI spec, Set Watchdog Timer command timer use field of byte 1
> says "timer use (logged on expiration when “don’t log” bit = 0b)".
> But it also says it should disable the timeout sensor event logging.
> I missed that part, I will see if I can make that work.

It doesn't currently add an event to the log, I don't think.  If you
want to add that, it's fine.

However, as it is, your change will cause the Get Watchdog Timer command
to return the wrong value for Timer Use Expiration flags.  It's not what
you want to do.

What bug are you trying to solve?

-corey

