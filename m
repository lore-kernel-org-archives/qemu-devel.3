Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C309FCD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 06:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLy1h-0008Jd-1L; Sun, 10 May 2026 02:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLy1f-0008J7-Aq; Sun, 10 May 2026 02:52:31 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wLy1c-0007w3-Di; Sun, 10 May 2026 02:52:31 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64A6ptmF001441
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 10 May 2026 15:51:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VOEDL6NXraz7Y1ib3+3zrn2sY/jn8axyzIJKRtM1j/o=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1778395916; v=1;
 b=Atq204n3W30a6caKEE/w7vUE9jY+jYsEhm2FzFelRX/LuWAONLK1HML7zH9TqIlI
 9gcHWAbLxO1ihKxeUYB6PncZDWBtUCXJwZprZRhOO6PZjyfTOL6a5VdwG3psXFMH
 UoLX4b5xPW3zD2aYvV7JLsxRc6LnaXHwDR0X53Bf7sBg4/fjQF3HW9Y1c1ORJP0E
 oYwcYA89gUxutzOso0vKo3BgamUs1YvsRCur+kKZFOS39tIi8wutobYxv000fZPd
 6geeyIC0i0ygUrjdTOEU8N0LLI+o1DVg8EI6siAx1zersTIlJuydvGg8NDdKfjyF
 cEgSh8Ra3qhMVORl9PVsHA==
Message-ID: <28005362-7092-449a-97ef-4360e5a5ee0d@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 10 May 2026 15:51:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/28] ui/input: Remove QAPI wrappers from
 QemuInputEvent
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
 <20260509-input-v1-2-66f18d2edde6@rsg.ci.i.u-tokyo.ac.jp>
 <177839287566.1301060.6783840665482202851.b4-review@b4>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <177839287566.1301060.6783840665482202851.b4-review@b4>
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
> On Sat, 09 May 2026 19:34:14 +0900, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> 
> Hi,
> 
>>
>> diff --git a/ui/input.c b/ui/input.c
>> index 52ab7beb942..a3ced08429e 100644
>> --- a/ui/input.c
>> +++ b/ui/input.c
>> @@ -159,16 +159,55 @@ void qmp_input_send_event(const char *device,
>> [ ... skip 30 lines ... ]
>> +                g_assert_not_reached();
>> +            }
>> +
>> +            evt.key.key.type = KEY_VALUE_KIND_QCODE;
>> +            evt.key.key.u.qcode.data = code;
>> +            evt.key.key = *qapi->u.key.data->key;
> 
> You are overwriting the QCODE/code with this assignment. Swap the lines?
> 

I will remove evt.key.key = *qapi->u.key.data->key. It is likely to be 
an artifact of rebase.

Regards,
Akihiko Odaki

