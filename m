Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5B1CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0cl-0003bP-6O; Mon, 18 May 2026 12:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1wP0cj-0003b8-5K; Mon, 18 May 2026 12:15:21 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1wP0cg-0003v4-VJ; Mon, 18 May 2026 12:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1779120915; x=1779725715; i=laurent@vivier.eu;
 bh=t3fgSIO9txo34LAvZIv7waanuHz4MnewTHnkHHxZq9o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=d7uYlw4IwXRquwXvrGuc47JdvtIEFgAzBHOjkAW8o3AUVMKPH3iBcGpO9zGZMgzS
 ziM5+Vz/zTzgvdTYmVyFjpUhkATjfdY0OCkX7UTcC7TDVSt7j3ws7CPtdjFEuYJ+H
 GfHi4RvsM7pddUxqD6qMD7AY7n8Ii67lkfEbhBuwug8dEa/slq6Wgm9c7Ob6foOpB
 jbd7gwScRH1829cnU/NHnoyqgJ29x3AwkaOJooOJHBvcEbYg3Kjyc2gyVip5GZjBQ
 QpfBhCoOhzFim7SHO/q73/QJdgjSsEugViHNxGMUGkBLu6ptLgNwepCYd9cAdkY1D
 J6W0rRCYu3Y2XwBFdw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1MelWf-1wzAmt3oSD-00boKE; Mon, 18
 May 2026 18:15:15 +0200
Message-ID: <e427ed38-83e8-4937-b0ef-c5c8398ba7c3@vivier.eu>
Date: Mon, 18 May 2026 18:15:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/rtc: Fix a possible year-2038 integer overflow
 problem
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260518160255.1844308-1-thuth@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260518160255.1844308-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MDSTTKlvDLCds9BPNUML27cRS8KabrN3yauaH1o7L4kyX7sDygJ
 x1Em1UnxSRgumwbnic0iO/M74lGXShVeum+QgUs1qykhj6oZdreiNKlBaXC+IPQTx32GITM
 i/kR18so1gEefDOZT0lJRgin1LTlCaxY++8Xk4QV/wFwx+CY2Uki8aw/yPm5VGFDVymvR+q
 7WqI+mUuZpX6CD9Tf2oyQ==
UI-OutboundReport: notjunk:1;M01:P0:ewoKGv43RDQ=;Mmcr0HbErDnVaM+WFrRPIHl3nih
 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
Received-SPF: pass client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Le 18/05/2026 =C3=A0 18:02, Thomas Huth a =C3=A9crit=C2=A0:
> From: Thomas Huth <thuth@redhat.com>
>=20
> rtc_realtime_clock_offset is initialized with:
>=20
>    rtc_realtime_clock_offset =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) =
/ 1000;
>=20
> And QEMU_CLOCK_REALTIME might be based on gettimeofday() in certain
> cases (see get_clock_realtime() in include/qemu/timer.h). So this
> counter will exceed 32 bits in the year 2038, thus we should not
> store this value in a normal integer variable. Change it to an int64_t
> to fix the problem.
> And while we're at it, also adjust the nearby rtc_host_datetime_offset
> variable to be on the safe side in the related code.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   system/rtc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/system/rtc.c b/system/rtc.c
> index f13dd392a76..83b28088054 100644
> --- a/system/rtc.c
> +++ b/system/rtc.c
> @@ -41,8 +41,8 @@ static enum {
>       RTC_BASE_DATETIME,
>   } rtc_base_type =3D RTC_BASE_UTC;
>   static time_t rtc_ref_start_datetime;
> -static int rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REAL=
TIME */
> -static int rtc_host_datetime_offset =3D -1; /* valid & used only with
> +static int64_t rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_=
REALTIME */
> +static int64_t rtc_host_datetime_offset =3D -1; /* valid & used only wi=
th
>                                                RTC_BASE_DATETIME */
>   QEMUClockType rtc_clock;
>   /***********************************************************/

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


