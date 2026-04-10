Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4A4E99057
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB7Wr-0002nF-5t; Fri, 10 Apr 2026 04:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wB7Wp-0002mt-Dp
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:47:51 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wB7Wn-0000nd-T1
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:47:51 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79d991c7b6aso17942767b3.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 01:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775810868; cv=none;
 d=google.com; s=arc-20240605;
 b=IQ/DloAKvaxnLMLoRmxatn1w6WnCJqHNXR3y61RNjrHfRsns3gX7btDlRAxNMU1zcV
 U0lOeBnvXmXe+ymahkxkXzhCwWX6gMIMOQWQHy2CGcHG1h8VFsprxJjoxA6AaionRmt7
 namuOHcHwFaMUSN05UTjyIUMmTrW6kaOW55JECEmUJiOE3nTo4v++v+3Gj7HrIVT5eXg
 YEErs2j97Ru8tT1E/DDCKmUeAGnUfJZCBZ3Lnv7gO/Bp4ThmI9ppaZHSlMeE6zSfweTB
 SiyiCqVMHtPY+Z4vQDdzqZdJmBeWgkwfz6V47b2hfPocfArAolUSiFPyaJBc1gWnr89K
 qbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BhjrxvBGZe8DQIDMBzkcOYYo4DWG36jOiMgcpKt8AK8=;
 fh=LlJHh1fTyVMrUeRXfxxHN6hBLR5uzJfRrrZ9y/XMyWY=;
 b=Db8FKNouyvLv6NJ3RwNdOfzKjngeMQET3V8Z5TP9HGw41L4YTtt9d8KVp/vzNd5wo8
 TI66h7G7cXD5+gXSJc0Jc5l0jjprcD89v60HjzhrBJPQOKRm2IZ53HW1oCf4lCq2R4G2
 7R886EOqnUnrbZ6pUO9yrO/gXPf/CR5/rFbl0rccl/yAF2twY49FriYJlsnwdMluqDVj
 j+H5eCIpbsPtmHb4D8eJWZsRNyjOsF+2q29eFTqtwJg6375EzRjW64MvJoLSjRbtUgbD
 55rJXZewJhRy5ehl+IbRKGbmpjad32Dvo8uZzbyFLn7/EJHnjRlVuXh3IQBzQU3d5LEN
 PJTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775810868; x=1776415668; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhjrxvBGZe8DQIDMBzkcOYYo4DWG36jOiMgcpKt8AK8=;
 b=MpsBVFcWYzSgJiyLnJW5MC+d27QnB2KahdvW9l6K73+ajZAXyzdyoOiJgWjV5IaQIq
 dx02GhoYqOhfZqRZbyk1HXKxM9bmttzRRoQFxv16CTvlhw52JJZPpMlhROsYNWczuLRw
 JnhVL+LCiz6txV5jf9H/7YqueoWlhL8XNZqluTPiR0jXgKj02kJ+gPWEOeVd5gqp+CuH
 NR3I5bo8hIJ6G4nIqzZlkJqILFFCLDG4jv8/BKWwJZ2wxz04WNGaVIh1NkZhG4ORixqZ
 GFWU8oaK24Ix6h4rd007V9yPYx4OrhrGh77gHn3a53PgXDJS+RpU2o7vP7Gyrm+qLpUh
 /ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775810868; x=1776415668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BhjrxvBGZe8DQIDMBzkcOYYo4DWG36jOiMgcpKt8AK8=;
 b=SOxB3Vg71qe4PmwNZIyc2925lE2HYVGsZLEfWsViUQUXaz1RfMRwo+lKV5tL2c7W5u
 +b5iuc/sd2vabCe0Oj319x7ji5nskFMMBoCf3j/Ar+T6PFxB4SsCe8rPf1RZqoE9JDs6
 8LFkclVXbwtOfM2XkT1ppePmMsjYU1iSJSinZFXsySgT4Mf8+NEF/i1gTSxChf8GBB4h
 +vQY43FMSq+fi9JeeXFvX/H7ITHbhJezX+T1cQt0/Pf77V8KcoIgiQOCq+BH8OqJij+4
 yF5VHDG1B87EspBejo3dxo2HzsOltFcAsvZ13XNCcpw+2cxICSGKHmDDkUP09UnVcinp
 ILMg==
X-Gm-Message-State: AOJu0Yygd7EuoXUqAUsU734QnJ00WvuUAmS73ZuSn38VUZfxgTx6jgi1
 vvLa7nUau9zQ96fFE6JWYJ8kzhMtAINbbkM4oPqC0Q/yCpp3zAq7ds0RS3f7R8tOmbnWsSHDOLR
 wjA4XcMVlgkXBl6jCFQ+LFOX9jkjNn7R3ndxgwmcXxQ==
X-Gm-Gg: AeBDiev/Y0PiGK+s4QDIXBhABBngBVX/YJ2Ozzi0oVdeK4RnXM+ug4u6wgTdBnrkBR7
 rN/teFGnKN4xGbqNu6BPM17umjPq6T5illCXkcNZAz4VDa3MTZVZsk5k/+5wiQ6jLkhrWLB3lEV
 KYWkLvVtEKUcIMXBfeX/rwtdIk0MvH7BqjvGnbEke/c9yHr96pTxm5Nxiz4oHW3gvtgvDWZrBB5
 VjNIqb3eRmY8WUugxWqX7n/DBp/NCrnVmTKphHlxnW/4rtCCfX6ndZjFEQjwRxnIuo7XkOGQVQq
 hKIkaSApltqKu9Lg1KRlHnHMpKsN+lV7cP1HpS27pXdwGtwbaez7mo2Dg5WCIgFJoEQ=
X-Received: by 2002:a05:690c:6710:b0:798:78fd:fed8 with SMTP id
 00721157ae682-7af71087669mr24478797b3.33.1775810867695; Fri, 10 Apr 2026
 01:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-25-alex.bennee@linaro.org>
In-Reply-To: <20260320130607.2071996-25-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 09:47:36 +0100
X-Gm-Features: AQROBzDCzp5PsRFPUykgKuJP4fPvHYOFIzKsMC0Zt7Ar8jPmCyFNwNgMSLFk2V4
Message-ID: <CAFEAcA83X2v6iTQO-r-xp-sRku+KNQb56QhLtvgiCMpOxqFCyw@mail.gmail.com>
Subject: Re: [RFC PATCH 24/35] target/arm: remove event_register check from
 arm_cpu_has_work
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 20 Mar 2026 at 13:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The generation of events are not indications of work to be done and
> importantly for the case of WFI instructions not a reason to wake up.
> Remove the check.

But an event *is* a reason for WFE to wake up, which is why this
check is here. In particular, the thing that tells accel/tcg
that the CPU should come out of halt (via cpu_handle_halt())
is whether cpu_exec_halt / cpu_has_work returns true. If we
don't check the event register here then another CPU setting
the event register won't cause this one to come out of WFE.

If we want to have WFE and WFI wakeup events to be separated
such that only WFE wakeup events resume a WFE and only
WFI wakeup events resume a WFI then we need to do something
more clever here, so that we track whether we're halted for
WFI, WFE, PSCI-power-off or whatever and our has_work function
can check the right condition. (Side question: are the only
cases where our arm CPUs halt WFE, WFI, power-off, or are
there any others I forgot about?)

Incidentally, looking at the code above it will need fixing
for A-profile anyway, because a CPU in PSCI-power-off should
not be woken up by a WFE event. We get away with doing the
WFE event register check first because M-profile doesn't use
the PSCI powerdown stuff.

thanks
-- PMM

