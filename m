Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51F5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1HT-0001a0-5s; Mon, 18 May 2026 12:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1wP1HQ-0001ZF-Qr; Mon, 18 May 2026 12:57:24 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1wP1HP-0001ys-1J; Mon, 18 May 2026 12:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1779123440; x=1779728240; i=laurent@vivier.eu;
 bh=1fLb/e1dql1yBEums0vJZcH3Bnjsk/7RXQbqIfPm8NY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ItS0VaMMEY5ubMP/t+l3qj+8DzaRObDVO0lgDUYhdpyEFx0A/y1YDq9cpOb4Srw1
 BqHUiwtYpz7VkCw6QLv31T8eYwVw0Wd/OCzOKuOu5Q52hjRFL3aue9/VObkpVH0gJ
 STrMOpOC43YbEmmcSbdAh9j+yZbhLBkYxaCwpNr1lSz4TFmthJMq28/QxSQRyPg8F
 xudhEWxmANy3iytf/B5ZkRb4BSQ8v0Rdj278riUJ1qYI/+Z1W60JOFESElEAQevd3
 IQtMqVXTI0m4f8thYck9SLtYBYj0xrQxG0Y1HGn+cnpj7tPYsIncgKlL1y2GkjZBd
 K2BnzuwZCcQEOUmj7g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.17.181]) with ESMTPSA (Nemesis) id 1Mc0Er-1wwR9M3kj9-00pYQE; Mon, 18
 May 2026 18:57:19 +0200
Message-ID: <d109c83a-114e-4211-afe9-240b7ee8409b@vivier.eu>
Date: Mon, 18 May 2026 18:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] system/rtc: Fix a possible year-2038 integer overflow
 problem
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260518163408.1865629-1-thuth@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260518163408.1865629-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:64nd3I8BUkH33tp3AbpUJhvf2a4p8RX0apbymix9iaImlnqqnyJ
 1EtZuoi8RSBWpT+6tp1IxSn66n32+fb2/kjZYpn0krb+nrIJYgoBZ+b9qADddHjfDzaQ254
 knEcRGhfIgZ0cNrjFQsn+QT79HYUBGYWOgOnK3oHppqDyAB+v76iBUgaP3USrCN+GsG0rKi
 fgDD81awG08EKRTUR/t3w==
UI-OutboundReport: notjunk:1;M01:P0:UIZsJtjojiE=;kmCLR3+KAJ6OPtwURqjYIA44w30
 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
Received-SPF: pass client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
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

Le 18/05/2026 =C3=A0 18:34, Thomas Huth a =C3=A9crit=C2=A0:
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
> store this value in a normal integer variable. Change it to a time_t
> to fix the problem.
> And while we're at it, also adjust the nearby rtc_host_datetime_offset
> variable to be on the safe side in the related code.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Use time_t instead of int64_t
>=20
>   system/rtc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/system/rtc.c b/system/rtc.c
> index f13dd392a76..018609a4f9a 100644
> --- a/system/rtc.c
> +++ b/system/rtc.c
> @@ -41,8 +41,8 @@ static enum {
>       RTC_BASE_DATETIME,
>   } rtc_base_type =3D RTC_BASE_UTC;
>   static time_t rtc_ref_start_datetime;
> -static int rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REAL=
TIME */
> -static int rtc_host_datetime_offset =3D -1; /* valid & used only with
> +static time_t rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_R=
EALTIME */
> +static time_t rtc_host_datetime_offset =3D -1; /* valid & used only wit=
h
>                                                RTC_BASE_DATETIME */
>   QEMUClockType rtc_clock;
>   /***********************************************************/

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


