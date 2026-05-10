Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27D2CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 06:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLy6w-0001IK-BM; Sun, 10 May 2026 02:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLy6t-0001HS-CU; Sun, 10 May 2026 02:57:56 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLy6r-000176-9d; Sun, 10 May 2026 02:57:54 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64A6vRJ4003538
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 10 May 2026 15:57:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=kLTm3xpI2Ygui73orK8LXcp9PHIv2jpQkYxS9D9saJU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1778396247; v=1;
 b=OorHRfE+ec5pgfyrzNAze64+t8E+kcK55OjETdQ3Fl/hw2walDh0O31U7mh0xHpr
 sd2V7kGA/ia7ahLNl2hsQGNoK0CdFa0oYRFp+90dptZRi+076EBzTeNyDlXv9xuV
 YdMJ5+ND6R0PRbTx+Odps4j6DqRuwO0mBfjJqfs/eiPYkUU3P9a/DzYqxSxzHoZL
 WFCVUoiOl6wR9ngIgEyRgI6apyhFJQnpvTP3TjWGa8sUbZfC/UJdQtZSEuXBalik
 AnnEvLtmTX98lEElxY8Do51nfjb6A0MxYiEhfxqBsvngEkYHQOcojzYNy/Y+UwlM
 LVQ0zRuZVpstQwNd8Agc3Q==
Message-ID: <fd2a85a8-0e23-4e35-80a8-b4dfe4813e10@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 10 May 2026 15:57:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/28] hw/input/ps2: Use Linux key codes
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260509-input-v1-0-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
 <20260509-input-v1-12-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
 <177839287567.1301060.18218108403655321396.b4-review@b4>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <177839287567.1301060.18218108403655321396.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/05/10 15:01, marcandre.lureau@redhat.com wrote:
> On Sat, 09 May 2026 19:34:24 +0900, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
>> index 93c3c737205..1f266bc6a07 100644
>> --- a/hw/input/ps2.c
>> +++ b/hw/input/ps2.c
>> @@ -126,17 +127,17 @@ static uint8_t translate_table[256] = {
>>   static unsigned int ps2_modifier_bit(QKeyCode key)
> 
> QemuInputKeyEvent.key is unsigned int after patch 4.

I ran a codebase-wide search of QKeyCode but there are clearly 
occurrences I missed (ui/vnc is another case you spotted). I'll 
double-check to ensure there won't be such except the intended cases.

Regards,
Akihiko Odaki

