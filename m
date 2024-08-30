Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB1DCA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 12:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk0NW-0008L1-R7; Fri, 30 Aug 2024 08:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk0NM-0007xF-Nq
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 08:05:13 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk0NI-0003y6-M8
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 08:05:10 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a86b64ebd8aso114268566b.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725019506; x=1725624306; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hWrw0WtSK0LqUAaW2KMHtN9a27jg18BOzC3xlbw8kpU=;
 b=DqUFilk1N9XQDfLkAjG9iiEZ9wT+cvMAFVik9clU6hSTyHci6HOUPp+60l+QV7XWB3
 MQ/ABr6B+riaMjnmKVVK7UCysaqG+c7oG617XjaWbwMG1x4ApyBF6KcvMKqL/8o3rJ6c
 1u34tdKYhppwBip+O1aZOQq/k9t5kVet4/9F11K7r+YgpJv5GEQhIZMSi2m9ySlvkB3+
 WihJwKR66tqQkIs1KguFs8SK+/etzvk9T/bPFccBsuZRJ1WGVo/2MI3CasZgETC7yDIs
 tbxhk2KWF57LAaeltnkUwuLJEyy0R1+EE7JCfndC7W/Nh2znjqsASp9yF9usrtnA+lP0
 7K7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725019506; x=1725624306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hWrw0WtSK0LqUAaW2KMHtN9a27jg18BOzC3xlbw8kpU=;
 b=bANDBbzTEoXEK+oRCT/4GYUFCVZLBi51qDqwNo0zPPfFvyjKtET7TLPam1lr9b8p2g
 iAwKrQ6eeAYOCMnvMdDl0i/55UiJVXBhlrKYFa/q355UDJ83cgEhtN/yiXtAZFVYs3bn
 cFdz70MwNZkWjLwvRh7eFL1GfQ0nxGbZeisqABXPzkKtVu3GJBlM06VcFWUr2LxQu5gH
 yKaO8Dfhy0Cn/3hsw1U7/67+3U0i3+iqD5EAve5nWYFEj6+ak/eafA9ATKBfSFonudlA
 ZLPUxvWV0DSKBbtb7vuLf86sV9To4u7awdJnRCg0dS0dfrtNHQ3OKbOBaOft6ooAVstZ
 7vuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxjSbLOgmfa6lgG41gsI9sTvKkzr7OrlP/WCUgNTaoa60BawbSVoKX91WVLefHn5qb6z0AqC4hsUPy@nongnu.org
X-Gm-Message-State: AOJu0YxiY4gegC1VmgA3vT12E5JZuoqGWmEoG0TArqvZu2JSzVmq/bmm
 p5HDuoVE06VG2IlPHi4r/9fvlGyq9vssS4iUW9GlOrjxL0QyXT7kpf0IlU2hDVqyW44cO1BSpkS
 wi8nKlIe/GnVvYdu6WQ9w/xitL9zyVtNZKcgNcw==
X-Google-Smtp-Source: AGHT+IGNjvO1gj3B3rnHkOMh359AExJDxtwRdvcHDollwqp0rzMdabjbHt6W1hqdqogWtqo5RyGUVmCaujxD1GEhXPU=
X-Received: by 2002:a05:6402:358a:b0:5be:d704:e730 with SMTP id
 4fb4d7f45d1cf-5c21ed315dfmr5304426a12.7.1725019505844; Fri, 30 Aug 2024
 05:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA9c1pAE7gttju5ib470ZhEMjd1=UMjLuhS+gXohnLs=Xw@mail.gmail.com>
 <172499689329.6066.495009881329074086@t14-nrb.local>
 <CAFEAcA8nTAPi9wr5h_V_GZkVV9f-YDV19mi9yybry0wxMyh6Eg@mail.gmail.com>
 <172501900133.6066.3071687086903215470@t14-nrb.local>
In-Reply-To: <172501900133.6066.3071687086903215470@t14-nrb.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Aug 2024 13:04:54 +0100
Message-ID: <CAFEAcA-FG0V0=MNf6sszGW-_Z8PdNv5DWZbLyiF3CCyTt8NUxQ@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Michael Mueller <mimu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 30 Aug 2024 at 12:56, Nico Boehr <nrb@linux.ibm.com> wrote:
>
> Quoting Peter Maydell (2024-08-30 12:01:47)
> > I ran overnight with none of the patchset applied, and it never
> > failed (as expected). Running with just the first virtio-ccw
> > patch does fall over fairly quickly. So something's up with
> > that patch, which is curious because that's the one I thought
> > was a straightforward conversion without any complications :-)
> >
> > I'll investigate further today, I have the beginnings of a
> > theory about what might be happening...
>
> Thanks for taking the time, Peter! Let me know when you have insights.

I think I've found the problem, I'm just testing it to see if it
does properly fix the intermittent. The issue is that before we
can convert a class to three-phase reset we need to have
already converted all its parent classes. TYPE_VIRTIO_CCW_DEVICE
is a subclass of TYPE_CCW_DEVICE, but I forgot to convert
TYPE_CCW_DEVICE to three-phase reset. The result is that the
reset in the parent class was not happening at all (presumably
leaving the TYPE_CCW_DEVICE in an invalid/unexpected state on
reboot). The fix is to add an extra patch at the start of the
series. Once I've tested this I'll send out a v2 of the series,
maybe also adding the cleanup RTH suggested in one of the later
patches. (Ironically, if we do that cleanup then the bug would
also go away, because old-style DeviceClass:reset methods will
get called in exactly the same way as if they were registered
as phases.hold methods, rather than being specially handled...)


commit ff9bc4c8910f636f20e9b6e91d63dd003408ce10
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri Aug 30 12:50:03 2024 +0100

    hw/s390/ccw-device: Convert to three-phase reset

    Convert the TYPE_CCW_DEVICE to three-phase reset. This is a
    device class which is subclassed, so it needs to be three-phase
    before we can convert the subclass.

    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index a7d682e5af9..14c24e38904 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -44,9 +44,9 @@ static Property ccw_device_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };

-static void ccw_device_reset(DeviceState *d)
+static void ccw_device_reset_hold(Object *obj, ResetType type)
 {
-    CcwDevice *ccw_dev = CCW_DEVICE(d);
+    CcwDevice *ccw_dev = CCW_DEVICE(obj);

     css_reset_sch(ccw_dev->sch);
 }
@@ -55,11 +55,12 @@ static void ccw_device_class_init(ObjectClass
*klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCWDeviceClass *k = CCW_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);

     k->realize = ccw_device_realize;
     k->refill_ids = ccw_device_refill_ids;
     device_class_set_props(dc, ccw_device_properties);
-    dc->reset = ccw_device_reset;
+    rc->phases.hold = ccw_device_reset_hold;
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
 }

-- PMM

