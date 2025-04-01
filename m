Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3286C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 01:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzQYj-0004uT-Ru; Mon, 31 Mar 2025 21:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzQYe-0004tu-IR
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 21:36:52 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzQYb-000050-Is
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 21:36:52 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso3262261fac.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 18:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743471408; x=1744076208;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LFzvRs5BaOFpxRaNXbWGclyni/keKCVevQkKKPUnux0=;
 b=R7fpq8M0yvDHQlvKLMiQsV45W2iBf9PKsLzEVGWNn4RnhIKK84iqs5FGOoNjqojKj0
 uQr/B8Ha1FV9BJWnir1jPV07LGBpBnG8BtEICzIWei5xa6sPdkgsrDxKNQwh6mooLieI
 uBQPqWTmRnn3yAhKjygYNuazqmYvt6wnnVyT46ypUzRyQnBQLBnbaX3n3xWvXrMvqREL
 /9sE+cEEW18Sc4wsOVnXCDRDcnMP+gyL1Qpk0m3SYIqZJ5zJXGE//eyY1qy7XlYZ8lfm
 XyFoNq1uuHOiYBGKciT2hvkAHk8UR2OmFzrO0s02MJoAeOHscKCnGKg2LL/LbmRBpnKW
 oMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743471408; x=1744076208;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LFzvRs5BaOFpxRaNXbWGclyni/keKCVevQkKKPUnux0=;
 b=JlbvA5ztf3BFlpjKZ/hhsqnIcjCyCsxx9z+kV3XDDf6dgoGWU+Atr/3v8vKQ8oib2P
 WvaNozMsAbSsf3n4VmDj2F5b2jiKeEeSLfA8dYzVzaO3jLhlht9CoD8gYvGa5dYmYuUi
 IOycrfURAsiEJZ0pqziUTfw+NIVJU6DdnLXJMKshms0i5sWWuGC4BsE6CS6Uwdo84+/U
 Le1oRxpnEk4JxzsRWs0wyi7chTHzI/qWYiPhL4VbjGNhyigR+079PsE32VU1ebthY4fT
 MsCHsHbw6xv+Gti8S+LNu7BIy6L1CZQZAbW84IMXAgG4+d5LuS/sDbg00cqT+y0BC7Zf
 biNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtFUG9GJXeQuWDSOeZM19KPyw2sQAb5sJv+RxOu4NIGE7+oS9Irgq3aH7E6iMOoR9eqUUA99YBLf2C@nongnu.org
X-Gm-Message-State: AOJu0Yxc3YMcmscMLP5qHClKjjb8aeMk/J8yePNDnWUoD5g6bYviYUxo
 WhDVj9HPmKbMNcMEVh/kVJ+nA1RVkzegyv0euMk4XpG8I36wVbv8lfb0TlVLKRc=
X-Gm-Gg: ASbGnct61VXLaIUplIlWeFoSw2NItB5E9l4StSIRJacII5iFf3ydw+IqIELZw1yzMR9
 eKlkdQrLTlITg3nYOKe4CaPGc8t4sEU/TzmBXu/QOeQvj5YxykrXdyBEsnbd3L/jGdmvGt4REFn
 vZ83Ad/OgMtl9q6tetnRJxA7NeEB30yK8D468cqgPJPctmVEySpVYYk3XbNp/nqQNiYc46mHyzM
 di8428pLtDtowhRky+6C0BTMntRC23N6CGm+shXH6N+VDNKH1FClY2lzabZ2sSQkcwwEAbpuOdk
 UMynVPjIR1zGiPhVGtcWVSK+EX8sfU+vHb+9I0n9N+kCLI79
X-Google-Smtp-Source: AGHT+IFS5d9keiXyxM/YnS9J1outhRYt1P8jYI1DQHRVQXRQRr5qpV+DaVhqQYOLsTXKYS6s/AxoJw==
X-Received: by 2002:a05:6870:d149:b0:2a7:d345:c0bb with SMTP id
 586e51a60fabf-2cbcf73d043mr7139170fac.27.1743471407774; 
 Mon, 31 Mar 2025 18:36:47 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8459:d76b:f4fb:8568])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a91606fsm2090054fac.49.2025.03.31.18.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 18:36:47 -0700 (PDT)
Date: Mon, 31 Mar 2025 20:36:42 -0500
From: Corey Minyard <corey@minyard.net>
To: Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <minyard@acm.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] ipmi/bmc-sim: implement watchdog dont log flag
Message-ID: <Z-tDKkaOgtzv0vXR@mail.minyard.net>
References: <20250331125724.607355-1-npiggin@gmail.com>
 <20250331125724.607355-2-npiggin@gmail.com>
 <Z-qU_5RWxK-qpGTn@mail.minyard.net>
 <D8UT7SKP9L19.126NYIT8BU3AI@gmail.com>
 <Z-sfL6mlGud_N76m@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-sfL6mlGud_N76m@mail.minyard.net>
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=corey@minyard.net; helo=mail-oa1-x2b.google.com
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

On Mon, Mar 31, 2025 at 06:03:11PM -0500, Corey Minyard wrote:
> On Tue, Apr 01, 2025 at 08:37:19AM +1000, Nicholas Piggin wrote:
> > On Mon Mar 31, 2025 at 11:13 PM AEST, Corey Minyard wrote:
> > > On Mon, Mar 31, 2025 at 10:57:22PM +1000, Nicholas Piggin wrote:
> > >> If the dont-log flag is set in the 'timer use' field for the
> > >> 'set watchdog' command, a watchdog timeout will not get logged as
> > >> a timer use expiration.
> > >> 
> > >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > >> ---
> > >>  hw/ipmi/ipmi_bmc_sim.c | 7 ++++++-
> > >>  1 file changed, 6 insertions(+), 1 deletion(-)
> > >> 
> > >> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> > >> index 6157ac71201..32161044c0b 100644
> > >> --- a/hw/ipmi/ipmi_bmc_sim.c
> > >> +++ b/hw/ipmi/ipmi_bmc_sim.c
> > >> @@ -733,7 +733,12 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
> > >>  
> > >>   do_full_expiry:
> > >>      ibs->watchdog_running = 0; /* Stop the watchdog on a timeout */
> > >> -    ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
> > >> +
> > >> +    /* Log the expiry if the don't log bit is clear */
> > >> +    if (!IPMI_BMC_WATCHDOG_GET_DONT_LOG(ibs)) {
> > >> +        ibs->watchdog_expired |= (1 << IPMI_BMC_WATCHDOG_GET_USE(ibs));
> > >> +    }
> > >> +
> > >
> > > Are you sure this is correct?  The spec doesn't say what this means, but
> > > I would assume this means "Don't add a system log" not "Don't set the
> > > expiry happened bit".
> > 
> > From IPMI spec, Set Watchdog Timer command timer use field of byte 1
> > says "timer use (logged on expiration when “don’t log” bit = 0b)".
> > But it also says it should disable the timeout sensor event logging.
> > I missed that part, I will see if I can make that work.
> 
> It doesn't currently add an event to the log, I don't think.  If you
> want to add that, it's fine.

Actually, I'm wrong here.  It does generate an event through the sensor
handling, the sensor_set_discrete_bit() function will cause an event to
be generated.  However, you can't just not call that function, you need
the event set.  I think the best way would be to add a "do_log"
parameter to that function to suppress the log in this case.

-corey

> 
> However, as it is, your change will cause the Get Watchdog Timer command
> to return the wrong value for Timer Use Expiration flags.  It's not what
> you want to do.
> 
> What bug are you trying to solve?
> 
> -corey

