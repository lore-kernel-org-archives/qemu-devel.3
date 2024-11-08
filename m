Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE49D5E14D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Lrw-000503-SI; Fri, 08 Nov 2024 05:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1t9Lru-0004zh-Qr
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:05:31 -0500
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1t9Lrr-0001Pd-Jb
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:05:29 -0500
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 6C5F6240027
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2024 11:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1731060315; bh=AuTznBuOuHCLswdhe2i4l4j5yDgTmoMAF062digmYT0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=K5cMREMmMla58lDGydChlVvpVrE+4fe0zHBtIK9QeapdEuxESU2+1yLIdbEHlv47Z
 Wx3c+47vK22Sgkb2fcBtYGZH/biAV7ZlCYKskH3hRgMMrDy9SPZE4A3/hSqC3nlZjs
 8ppAUJkrrmXxSDW+eHNzaZeWbJDnyzvzHJd+XYuO/2jXl+Dg7fnqojzx66/osvYhVj
 eU8PzC7h2Txxa4cNIDix8BGOUp3Ccm9rsf27XIUvirNR11fYLihvk2fGdBhIn3y2rX
 FH8x7P9syM3XsESkdiv1PMCBltKsxJymxmIIRV5m4o7w8NDqAxLEaY6aYCJF/M1jDK
 r14q66zk6Bzig==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4XlF1P5ZPFz9rxB;
 Fri,  8 Nov 2024 11:05:13 +0100 (CET)
Message-ID: <c3b996b4-d128-4830-94d4-5c9448ca003d@posteo.de>
Date: Fri,  8 Nov 2024 10:05:13 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] next-kbd: convert to use
 qemu_input_handler_register()
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 peter.maydell@linaro.org, huth@tuxfamily.org, berrange@redhat.com,
 qemu-devel@nongnu.org
References: <20241106120928.242443-1-mark.cave-ayland@ilande.co.uk>
 <20241106120928.242443-2-mark.cave-ayland@ilande.co.uk>
 <4c127d3c-3610-e6b7-9358-3d88d28477a0@eik.bme.hu>
 <13995544-2d94-4b35-a7c2-f11e0599170f@linaro.org>
 <872fd077-b870-f910-88a5-a045787aa681@eik.bme.hu>
From: Thomas Huth <th.huth@posteo.de>
Content-Language: en-US
In-Reply-To: <872fd077-b870-f910-88a5-a045787aa681@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth@posteo.de;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 06/11/2024 21.32, BALATON Zoltan wrote:
> On Wed, 6 Nov 2024, Philippe Mathieu-Daudé wrote:
>> On 6/11/24 13:00, BALATON Zoltan wrote:
>>> On Wed, 6 Nov 2024, Mark Cave-Ayland wrote:
>>>> Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
>>>> function to use qemu_input_handler_register().
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
>>>> ---
>>>> hw/m68k/next-kbd.c | 163 ++++++++++++++++++++++++++++++---------------
>>>> 1 file changed, 108 insertions(+), 55 deletions(-)
>>
>>
>>>> -static const unsigned char next_keycodes[128] = {
>>>> -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
>>>> -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
>>>> -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
>>>> -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
>>>> -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
>>>> -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
>>>> -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
>>>> -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>>>> +#define NEXTKBD_NO_KEY 0xff
>>>
>>> Now you don't need this 0xff define any more because you can use 0 as no 
>>> key value then the [0 ... Q_KEY_CODE__MAX] init below can also be dropped 
>>> because static variables are 0 init automatically.
>>
>> Whether 0 or 0xff is best for NO_KEY, I don't know.
>> However, definitions are useful when reviewing ...
>>
>>>
>>> Regards,
>>> BALATON Zoltan
>>>
>>>> +static const int qcode_to_nextkbd_keycode[] = {
>>>> +    /* Make sure future additions are automatically set to 
>>>> NEXTKBD_NO_KEY */
>>>> +    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
>>>> +
>>>> +    [Q_KEY_CODE_ESC]           = 0x49,
>>>> +    [Q_KEY_CODE_1]             = 0x4a,
>>>> +    [Q_KEY_CODE_2]             = 0x4b,
>>>> +    [Q_KEY_CODE_3]             = 0x4c,
>>>> +    [Q_KEY_CODE_4]             = 0x4d,
>> [...]
>>
>>>> +static void nextkbd_event(DeviceState *dev, QemuConsole *src, 
>>>> InputEvent *evt)
>>>> +{
>>>> +    NextKBDState *s = NEXTKBD(dev);
>>>> +    int qcode, keycode;
>>>> +    bool key_down = evt->u.key.data->down;
>>>> +
>>>> +    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
>>>> +    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* Shift key currently has no keycode, so handle separately */
>>>> +    if (qcode == Q_KEY_CODE_SHIFT) {
>>>> +        if (key_down) {
>>>> +            s->shift |= KD_LSHIFT;
>>>> +        } else {
>>>> +            s->shift &= ~KD_LSHIFT;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (qcode == Q_KEY_CODE_SHIFT_R) {
>>>> +        if (key_down) {
>>>> +            s->shift |= KD_RSHIFT;
>>>> +        } else {
>>>> +            s->shift &= ~KD_RSHIFT;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    keycode = qcode_to_nextkbd_keycode[qcode];
>>>> +    if (keycode == NEXTKBD_NO_KEY) {
>>
>> ... here ^
> 
> I this case !keycode is pretty self explanatory IMO.

Ok, I'll pick up the patch with this change added on top:

diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -165,12 +165,7 @@ static const MemoryRegionOps kbd_ops = {
      .endianness = DEVICE_NATIVE_ENDIAN,
  };
  
-#define NEXTKBD_NO_KEY 0xff
-
  static const int qcode_to_nextkbd_keycode[] = {
-    /* Make sure future additions are automatically set to NEXTKBD_NO_KEY */
-    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
-
      [Q_KEY_CODE_ESC]           = 0x49,
      [Q_KEY_CODE_1]             = 0x4a,
      [Q_KEY_CODE_2]             = 0x4b,
@@ -276,7 +271,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src, InputEvent *evt)
      }
  
      keycode = qcode_to_nextkbd_keycode[qcode];
-    if (keycode == NEXTKBD_NO_KEY) {
+    if (!keycode) {
          return;
      }
  
  Thomas


