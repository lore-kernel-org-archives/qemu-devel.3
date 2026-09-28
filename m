Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B60ACA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBIOI-00041B-5B; Mon, 28 Sep 2026 16:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xBIOF-00040e-N7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:55:59 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xBIOE-0004W8-13
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:55:59 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912df756so27129055e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790628955; x=1791233755; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LBDIK5RtWl+7QWuO0u/H+GIBlj0qCrCPeguII9D1ils=;
 b=A/0tfMdAQ59pRKZHo1Al2C0r957B1ok/W3GSchl/PQvbABxE6UJjNRwA86wh2r4p6S
 yjh3Qef/WIGYMnottQvGsYJz4gqXuv+K3EOglHahhp1Kk5n11eF9KyQJWS2TrO3re4hn
 dRD36aPIhR7JeWzF7xzbnwBK8zfLh5iWAf3PZJeCQLo7+clul09zHIYs6D97MCa/I+YH
 lsVavdnMsYE5UN/Kdw6AmQkEnf7nPjcUVCvsSpLD6ZSb22o2ts7BoXA9yLfUVwIkN2RY
 j+Iclz2pTz6VAIM0nShxYeBN0IyIvWclqZrb2z0Bq8d7sc0Mk1aBJA9Ub+5mmrakm49e
 lfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790628955; x=1791233755;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LBDIK5RtWl+7QWuO0u/H+GIBlj0qCrCPeguII9D1ils=;
 b=wGnRPhyqpvxyjdUiNSx8UAhGldJxtNfZZF1D4SuVi4vyIIxx5TeDOqOVaBkBEVz2Qz
 FJ0O03fH/PvpE3CZQEyyeyM+7jJ8+1p9kd+r1/kOTqjnamBIWmYs8DpO9UnUFGViW5ZW
 2DLqa7lAJfT+7ZkselEjWwR/8Uo/J2EKVI+I8eStnslE0LKinaeh5OcY49GLpzKquhUn
 H9ZR8Uc0wJ+VlQ2sJEW1PLPdgf9KxluNnQzGKxqU2N6RtNHQUTae10HyrT/sgYLhQkzS
 S15iXCinxUAyzlHZgMLHc/JAWdhwVcUKCaibKGKcA13AxlH5w3ZCqpmrESD60o4DGtdd
 00Iw==
X-Gm-Message-State: AFuF++n3kDnARksg0M6qsQpF8c09n11WwcxTlwKhTR878MtelNZcrPND
 ZE51acTHXblO4EZJzIMAQ8DDCmKMgEflM5usbmHBkJcQVNk2ufufv9AI
X-Gm-Gg: AYBFou1goDeeSAB7wekU1B8+/XtWWwC+Wzod07C7gykoLpUZkP00UrkjcPTII0Bqzjl
 As2ueUTZMDDuNGtzbqrWlV5T14FdcAvUWgeHTHyv7KZ5uOaPfhEdEaY8xL2JxvSXTnes2OkcDUP
 ITb6qYYerCkNj6SBkr3+CXvkpyV5g3WoqYhwlk5bbLQUEtkeKxxXK3KRUjvmVjZDU1fKbU7Jk7b
 xu+UWriTGp1jfGLgtS5lM5dPeqfw0ctfhyT+OzF9yG/Ni+uaVUHSwS49giIkRsBJIA0pq5NK+Ju
 gZDCVkpwCWHyKf3YmGRcqWF1d+X2+LvpkY4zUZqkt66176lmO0z6XhKJzFnjpxivmNQ8g9i1zVH
 wpgVA9oNym8K91SA7/EVVWdvzInH9IgdZVUOaK2Gmk6xTcEVbT2mwkdhNhecxeaDMmHlebrWqgr
 6vICIhFN6VfkSdmGjXaMq8p8WosRnnBDJ2tOZd5HkSuf8UquomxGKq/ijF0ETcQX9/qEXhEwzKw
 ZQFMeF4sOIzWokVLXHoCFg/RSOGzLOtnTUhN0gfi/3f27fgq2ieYvkGOIpAZgmjWFsFQ745xeka
 ulC7CUp1yp+z310AGC4=
X-Received: by 2002:a05:600c:190a:b0:4a0:a34:6e7d with SMTP id
 5b1f17b1804b1-4a00a346f12mr32001875e9.18.1790628955355; 
 Mon, 28 Sep 2026 13:55:55 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1844-bb00-d99b-d42d-2461-dbe0.310.pool.telefonica.de.
 [2a02:3100:1844:bb00:d99b:d42d:2461:dbe0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af1e2929bsm1041255f8f.14.2026.09.28.13.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 13:55:54 -0700 (PDT)
Date: Mon, 28 Sep 2026 20:55:52 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_01/42=5D_hw/watchdog/wdt=5Fimx?=
 =?US-ASCII?Q?2=3A_Fix_handling_of_write-once_WCR_bits?=
In-Reply-To: <CAFEAcA_xVcfC9UrxM4jjW8HOGoq96iuOABdbVB9Ftfxjq2zMAg@mail.gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-2-shentey@gmail.com>
 <CAFEAcA_xVcfC9UrxM4jjW8HOGoq96iuOABdbVB9Ftfxjq2zMAg@mail.gmail.com>
Message-ID: <5D88A101-D230-4783-9618-B9233257A683@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 28=2E September 2026 18:22:49 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>On Mon, 21 Sept 2026 at 22:47, Bernhard Beschow <shentey@gmail=2Ecom> wro=
te:
>>
>> Guests such as u-boot may experience inadvertant reboots when configuri=
ng
>> the WCR register=2E Apparently there is a typo in the WCR locked bits
>> handling: The locked values for s->wcr must come from itself rather tha=
n
>> from s->wicr=2E While at it remove the redundant locked attributes for =
the
>> bits which stick to one once written with one=2E
>
>"while at it" is one of those phrases that tends to suggest
>this should be more than one commit=2E It's doing a lot more
>than fixing the bug where we use wicr when we should have used wcr=2E

Okay, I'll split the patch: One which fixes the bug by fixing the typo, su=
itable for backporting=2E Then another one resolving the redundant boolean =
attributes which breaks migration=2E

>
>> Note that removing the locked attributes required a migration break=2E =
Defer
>> that to a subsequent patch to help backporting=2E
>>
>> Fixes: daca13d495a1 ("hw/watchdog: Implement full i=2EMX watchdog
>> support")
>> cc: qemu-stable
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  hw/watchdog/wdt_imx2=2Ec | 19 +++----------------
>>  1 file changed, 3 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/watchdog/wdt_imx2=2Ec b/hw/watchdog/wdt_imx2=2Ec
>> index c83d4107c1=2E=2Eaaf4695db2 100644
>> --- a/hw/watchdog/wdt_imx2=2Ec
>> +++ b/hw/watchdog/wdt_imx2=2Ec
>> @@ -59,9 +59,8 @@ static void imx2_wdt_reset(DeviceState *dev)
>>
>>      s->wicr_locked =3D false;
>>      s->wcr_locked =3D false;
>> -    s->wcr_wde_locked =3D false;
>>
>> -    s->wcr =3D IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
>> +    s->wcr =3D IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS | (s->wcr & IMX2_WD=
T_WCR_WDT);
>
>This doesn't look right=2E Reset should be "cold start power on", so
>the reset value of WCR shouldn't depend on what s->wcr happens
>to contain now=2E It's also not mentioned in the commit message=2E

Note that `s->wcr_wdt_locked =3D false;` is missing in the existing code, =
so retaining the IMX2_WDT_WCR_WDT position preserves behavior, hence no men=
tioning in the commit message=2E

WDT is cleared on POR while WDE is cleared on "system reset"=2E So indeed =
WDT needs to be cleared when reset represents "cold start power on"=2E I'll=
 add a (backporteable) patch=2E

>
>>      s->wsr =3D 0;
>>      s->wrsr &=3D ~(IMX2_WDT_WRSR_TOUT | IMX2_WDT_WRSR_SFTW);
>>      s->wicr =3D IMX2_WDT_WICR_WICT_DEF;
>> @@ -156,23 +155,11 @@ static void imx2_wdt_write(void *opaque, hwaddr a=
ddr,
>>      case IMX2_WDT_WCR:
>>          if (s->wcr_locked) {
>>              value &=3D ~IMX2_WDT_WCR_LOCK_MASK;
>> -            value |=3D (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
>> +            value |=3D (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
>>          }
>>          s->wcr_locked =3D true;
>> -        if (s->wcr_wde_locked) {
>> -            value &=3D ~IMX2_WDT_WCR_WDE;
>> -            value |=3D (s->wicr & ~IMX2_WDT_WCR_WDE);
>> -        } else if (value & IMX2_WDT_WCR_WDE) {
>> -            s->wcr_wde_locked =3D true;
>> -        }
>> -        if (s->wcr_wdt_locked) {
>> -            value &=3D ~IMX2_WDT_WCR_WDT;
>> -            value |=3D (s->wicr & ~IMX2_WDT_WCR_WDT);
>> -        } else if (value & IMX2_WDT_WCR_WDT) {
>> -            s->wcr_wdt_locked =3D true;
>> -        }
>>
>> -        s->wcr =3D value;
>> +        s->wcr =3D value | (s->wcr & (IMX2_WDT_WCR_WDT | IMX2_WDT_WCR_=
WDE));
>
>This looks correct, but I think it would be helpful to have a
>comment that notes that WDZST, WDBG and WDW are "write-once only"
>whereas WDT and WDE are "write one once only"=2E The difference is
>a bit subtle otherwise=2E

Okay, I'll add a comment in the patch where the redundant attributes are r=
emoved=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

