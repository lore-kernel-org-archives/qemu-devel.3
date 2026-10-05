Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16814CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgFh-0006uj-RT; Mon, 05 Oct 2026 06:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDgFO-0006t5-Qq
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:48:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDgFN-0003vW-5j
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:48:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so16434075e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791197319; x=1791802119; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ubekK0TU+adf9My3n8nfob/aQhN6iLPt+nEG+dgrR64=;
 b=R4bg/W0EhQHLqElULmpnRGatQ1CJBpEJ1ZCiOEA8mpQTCE6gOcJ+dLWXW2QsF8dcRq
 A2JmyxMSEbm0Iq56Of0aWX0EAurgIeHCSAbaH0egJQWWxrQFkR/7/Psyh2kY6B+5a+89
 bYhh0FTzsTmKUZ2s18stgg4z70i8urS2k2IDJq2r0o9+a2t+oydhKqAjNOSeh35J5nCk
 K+fxkmkGzOXwz0Rz1xfjbf/w9F9U+9bWF7cy35GXvmRhjlvAoa330kjJks4W/LsbUYvm
 MsQarodKWzqg+avpZJHhNsHJpXScA0iVSY8wmsxibet+OgrbUPs3+qPobvnTjaKlyALC
 lKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791197319; x=1791802119;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ubekK0TU+adf9My3n8nfob/aQhN6iLPt+nEG+dgrR64=;
 b=HEssFyjlsrFt1k0Xy+yPycMsTfhi3MWdTyh5f6VuJNuHy1cTUihkS5TMzCvuJzToxd
 Bz6lpojKdKEzw8dEGyHMNKJWFD4v6nvbaaPGIUFefF0xT2y3J+HMKN5xXKBaF55jUFgP
 tc1iL/BlXA/BDhMe0TXx9fGTcUQ9SpF24RzHGv/8NGTUbQ+vv3Kh9TXWs9RIAB4hC3/+
 7XSEnBfcwA3faoPZH5zyyeEQ2MHyr4LsKhi4z1obouMmpHn2MpeONh2TJfIjBFAAkjMm
 JcDVgF/1f0wJG5EYoJnDpeP6H9yMMAh888ah4Ds3kfWJniTrUQGxhe18ucvXUnTj81pL
 zgkg==
X-Gm-Message-State: AFuF++nhvClXgYWfNKQIXOlNi1Sda9pbVO1iysbNT0Vi2BE3+whamKv5
 gKSpEJWNSuLCbTq336SLd/QPJj3FEmCZwvTJ6X5EMHOZAoj3TWQiMPAb
X-Gm-Gg: AYBFou1W5kmd/z8ENQpTc0K5VldvddJ8gTrETyyielc/S3zsGV9Jk3MF6aLyymQ6zGf
 1ZaO8GoWgGELTQYBJpq/YlvuaJ+Z62Dwgp6m80MhuDdF4KcjNqbbXuNcjTRMYeDjUdPYr/2MQrB
 wTf6fjNYJwbsxdcRj9/d0dODzztCDOUCKIHn6M3djhQS68PRl0VbZTcXdapkU6KmMJ2sZRgdFVw
 cKDHRTypHb4qoR7ph44/HzIW3lD3gqomPRhgiB6R9Hw8y2X8r59GtuoA9QHyNsk3auNlMXo4YXW
 52pHndcJsMTx0KvDUYzO0XnxzMLlra0OL9hEG5tR0HSVd4kLJH0Q4aJTDUlj/tZVZWT9QKPXTfw
 SAgxBm1sAnbeHsDpOwYP4MhRUBSnikgua2g+UtPzTo9Ighc3PVlTSFohNS/3veIE3vuy8LujYSQ
 zmFTWaKLwdIrzF3U4RDavcslLlMFaS7jcTAduEeMLKJSfqH5LyS1g3jY5v05qqpEkmD9K+Dx3mq
 MlSCn/0JsKp+akv6CW+WoishtboOOYJN+VUY2a/YPooEAHaY+H2XGZrs+YiBDtZfSsXHAPwIHS/
 hS9iVg==
X-Received: by 2002:a05:600c:154b:b0:4a1:7108:c2b6 with SMTP id
 5b1f17b1804b1-4a17108c4camr53874655e9.31.1791197319229; 
 Mon, 05 Oct 2026 03:48:39 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf09ae005c0c4b1d534a3dac.dip0.t-ipconnect.de.
 [2003:fa:af09:ae00:5c0c:4b1d:534a:3dac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6229e025sm2683422f8f.31.2026.10.05.03.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 03:48:38 -0700 (PDT)
Date: Mon, 05 Oct 2026 10:48:34 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_01/30=5D_hw/watchdog/wdt=5Fim?=
 =?US-ASCII?Q?x2=3A_Fix_handling_of_write-once_WCR_bits?=
In-Reply-To: <CAEUhbmW58ikRLMr0+O2hpmTvnUko7+vWF6CuJBMejXFX3gFBsQ@mail.gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-2-shentey@gmail.com>
 <CAEUhbmW58ikRLMr0+O2hpmTvnUko7+vWF6CuJBMejXFX3gFBsQ@mail.gmail.com>
Message-ID: <9F300FF3-860C-4B96-AE15-7A2739E6F5AE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 4=2E Oktober 2026 15:05:57 UTC schrieb Bin Meng <bmeng=2Ecn@gmail=2Ecom=
>:
>Hi Bernhard,
>
>On Sun, Oct 4, 2026 at 8:29=E2=80=AFPM Bernhard Beschow <shentey@gmail=2E=
com> wrote:
>>
>> Guests such as u-boot may experience inadvertant reboots when configuri=
ng
>> the WCR register=2E Apparently there is a typo in the WCR locked bits
>> handling: The locked values for s->wcr must come from itself rather tha=
n
>> from s->wicr, so fix that=2E
>>
>> Fixes: daca13d495a1 ("hw/watchdog: Implement full i=2EMX watchdog suppo=
rt")
>> cc: qemu-stable
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  hw/watchdog/wdt_imx2=2Ec | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/watchdog/wdt_imx2=2Ec b/hw/watchdog/wdt_imx2=2Ec
>> index c83d4107c1=2E=2E3283990bbf 100644
>> --- a/hw/watchdog/wdt_imx2=2Ec
>> +++ b/hw/watchdog/wdt_imx2=2Ec
>> @@ -156,18 +156,18 @@ static void imx2_wdt_write(void *opaque, hwaddr a=
ddr,
>>      case IMX2_WDT_WCR:
>>          if (s->wcr_locked) {
>>              value &=3D ~IMX2_WDT_WCR_LOCK_MASK;
>> -            value |=3D (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
>> +            value |=3D (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
>
>I see this patch has qemu-stable cc'ed, so it shall be a complete fix
>instead of a partial one that relies one another patch (in this case,
>patch 03 in this series)=2E
>
>So patch 1 corrects the source register from s->wicr to s->wcr, but
>the WDE and WDT branches still use inverted masks:
>
>>    s->wcr & ~IMX2_WDT_WCR_WDE
>>    s->wcr & ~IMX2_WDT_WCR_WDT
>
>These preserve all the other bits rather than the locked bit, which is
>apparently wrong=2E
>
>Patch 3 fixes this as part of removing the redundant lock flags, but
>not marked as qemu-stable intentionally=2E When applying patch 1 & 3
>together on QEMU master, this issue is fixed correctly, but not for
>stable=2E
>
>Could you fix the WDE/WDT masks in patch 1, leaving patch 3 to remove
>the redundant flags and migration fields? That would make the stable
>fixes work correctly without depending on patch 3=2E

Hi Bin,

Thanks for spotting this! Dedicated patch added to v3 series=2E

And thanks for the other comments and reviews! Everything should be incorp=
orated in v3=2E

Best regards,
Bernhard

>
>>          }
>>          s->wcr_locked =3D true;
>>          if (s->wcr_wde_locked) {
>>              value &=3D ~IMX2_WDT_WCR_WDE;
>> -            value |=3D (s->wicr & ~IMX2_WDT_WCR_WDE);
>> +            value |=3D (s->wcr & ~IMX2_WDT_WCR_WDE);
>>          } else if (value & IMX2_WDT_WCR_WDE) {
>>              s->wcr_wde_locked =3D true;
>>          }
>>          if (s->wcr_wdt_locked) {
>>              value &=3D ~IMX2_WDT_WCR_WDT;
>> -            value |=3D (s->wicr & ~IMX2_WDT_WCR_WDT);
>> +            value |=3D (s->wcr & ~IMX2_WDT_WCR_WDT);
>>          } else if (value & IMX2_WDT_WCR_WDT) {
>>              s->wcr_wdt_locked =3D true;
>>          }
>> --
>
>Regards,
>Bin

