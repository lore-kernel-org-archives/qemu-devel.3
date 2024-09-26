Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772D4CCFA07
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 07:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stiUj-00006W-9Q; Thu, 26 Sep 2024 03:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1stiUP-0008WV-1J
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:00:37 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1stiUM-0000rb-7Y
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:00:35 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d3cde1103so85331966b.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727334031; x=1727938831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+xeIXtEc6kRNFTUYzQAyKLlvH2lNiGwM74kIZ7VoZY=;
 b=kOyqPNQtI1kWsJTYrnONoLR5aankdcgafUPN9BC2LBcxoagbaU1BkTmZ+PmDv1WnhS
 F/ok3eKGqN/w9za1LmnS9/vgECcjScosYcosoUatD7VnoxcbyevwS02Aq97fHaNzpkhO
 I9oDE/dP3fhODBU4f0dFVZhcyHmOCS5F/Qle/iYJgQSC6p41px1jSvxErMlS7iFcAv1/
 lZ5w4HAmj3XKUaYqD6Ac9JUald8iVHTRkawsHrH1NSF3ur5h9+Hkq0zd4/yk2DBAgISo
 3/4cdr0/iSO1OUNUsLThE5QVYNLYMbANepy5bLqtminFOlkODCAgklIga++iyGL6hIn0
 rn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727334031; x=1727938831;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+xeIXtEc6kRNFTUYzQAyKLlvH2lNiGwM74kIZ7VoZY=;
 b=k7OJ698/QWz3MXCI4PWUTnC0IQW6PDhejHwNOKTNPeRdDcByrvrctzZaA1dq5EIrpU
 Us7B8vzr1T0fZJZv92xDtWplfEh0UVfksDAGlCtpYak5jI4Slyx+F3/3rXEzE6cRsXXW
 0LG5GllF/bAfDvLMjuSURFKTiDibXgLdY9shGPRmOHPc+uqc/xZ3Y20UWCvyJIX88jlZ
 WSJRhe6P5CtyzCXPMCU+GF+R2koxEpaIFNQ6+n2w3Dd5MrclRxeQCceeEy8xQyQfU8Ck
 LLlNxDTgJQH7VWxGJ75XH+ROSFc9JCtAkvptmyuy0ySsW7TMHn3xN8/hUM0G/E+LD2jx
 ueHA==
X-Gm-Message-State: AOJu0YywHfITTODxgdSuWyzvuTW2KHyVgqagz0LQsx0t9I1r0pWSDreQ
 eGZwUjNcYJHNRkEvgDWy1/x5J9Bne5L9qr3d3lWBX2Rn9OdPRyNLkY/V2Q==
X-Google-Smtp-Source: AGHT+IGv1LSKo9RRkdIRTryR4MJltN9pQJQRMTvvB75NTvoXKuvjYadmXLUPeSt8buyrLjR0Vqi0Mg==
X-Received: by 2002:a17:907:1c22:b0:a80:7193:bd93 with SMTP id
 a640c23a62f3a-a93a037eb2bmr602026866b.25.1727334029879; 
 Thu, 26 Sep 2024 00:00:29 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-054-081-221.78.54.pool.telefonica.de.
 [78.54.81.221]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f598asm314163266b.154.2024.09.26.00.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 00:00:29 -0700 (PDT)
Date: Thu, 26 Sep 2024 07:00:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, dave@treblig.org, pbonzini@redhat.com
CC: "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2] qemu-timer: Remove unused timer functions
In-Reply-To: <20240919144124.309646-1-dave@treblig.org>
References: <20240919144124.309646-1-dave@treblig.org>
Message-ID: <51F83A2C-583D-4272-A462-C82518EB7C54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 19=2E September 2024 14:41:24 UTC schrieb dave@treblig=2Eorg:
>From: "Dr=2E David Alan Gilbert" <dave@treblig=2Eorg>
>
>qemu_clock_get_main_loop_timerlist and timerlist_get_clock have been
>unused since they were originally added in
>  ff83c66ecc ("aio / timers: Split QEMUClock into QEMUClock and QEMUTimer=
List")
>
>Remove them=2E
>
>Signed-off-by: Dr=2E David Alan Gilbert <dave@treblig=2Eorg>

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> include/qemu/timer=2Eh | 21 ---------------------
> util/qemu-timer=2Ec    | 10 ----------
> 2 files changed, 31 deletions(-)
>
>diff --git a/include/qemu/timer=2Eh b/include/qemu/timer=2Eh
>index fa56ec9481=2E=2Ecc167bd825 100644
>--- a/include/qemu/timer=2Eh
>+++ b/include/qemu/timer=2Eh
>@@ -190,16 +190,6 @@ bool qemu_clock_use_for_deadline(QEMUClockType type)=
;
>  */
> int64_t qemu_clock_deadline_ns_all(QEMUClockType type, int attr_mask);
>=20
>-/**
>- * qemu_clock_get_main_loop_timerlist:
>- * @type: the clock type
>- *
>- * Return the default timer list associated with a clock=2E
>- *
>- * Returns: the default timer list
>- */
>-QEMUTimerList *qemu_clock_get_main_loop_timerlist(QEMUClockType type);
>-
> /**
>  * qemu_clock_nofify:
>  * @type: the clock type
>@@ -326,17 +316,6 @@ bool timerlist_expired(QEMUTimerList *timer_list);
>  */
> int64_t timerlist_deadline_ns(QEMUTimerList *timer_list);
>=20
>-/**
>- * timerlist_get_clock:
>- * @timer_list: the timer list to operate on
>- *
>- * Determine the clock type associated with a timer list=2E
>- *
>- * Returns: the clock type associated with the
>- * timer list=2E
>- */
>-QEMUClockType timerlist_get_clock(QEMUTimerList *timer_list);
>-
> /**
>  * timerlist_run_timers:
>  * @timer_list: the timer list to use
>diff --git a/util/qemu-timer=2Ec b/util/qemu-timer=2Ec
>index 213114be68=2E=2Edf9327657a 100644
>--- a/util/qemu-timer=2Ec
>+++ b/util/qemu-timer=2Ec
>@@ -286,16 +286,6 @@ int64_t qemu_clock_deadline_ns_all(QEMUClockType typ=
e, int attr_mask)
>     return deadline;
> }
>=20
>-QEMUClockType timerlist_get_clock(QEMUTimerList *timer_list)
>-{
>-    return timer_list->clock->type;
>-}
>-
>-QEMUTimerList *qemu_clock_get_main_loop_timerlist(QEMUClockType type)
>-{
>-    return main_loop_tlg=2Etl[type];
>-}
>-
> void timerlist_notify(QEMUTimerList *timer_list)
> {
>     if (timer_list->notify_cb) {

