Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE92C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzh31-0006kY-TP; Thu, 27 Aug 2026 16:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzh2y-0006iJ-8v
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzh2v-0004vd-VR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 16:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787863799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vNzcQEWh32RxvwBhFRjP8/ie5i2fd4amhNQFR5Z6IN0=;
 b=BBdsq7LRtJpFWMoMGldhNHy4xim3eO6KS88wTwTOhoZwYtgdoXLC0YrPHEUcDB9v5EGQ6Y
 8lAy4ZnUb/KAhRzewUXAOKwzZzNLqRk/xHC5Iu1q1CfpvKXUAIxhbxof4WxX2I02jrybeR
 sHkSxxYgODTOUQsrN6jAUtI3IzvY0S4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-_mxlGGCqMHal5Ge_LzUl4Q-1; Thu, 27 Aug 2026 16:49:58 -0400
X-MC-Unique: _mxlGGCqMHal5Ge_LzUl4Q-1
X-Mimecast-MFC-AGG-ID: _mxlGGCqMHal5Ge_LzUl4Q_1787863797
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4997b060af8so747605e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787863797; x=1788468597; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vNzcQEWh32RxvwBhFRjP8/ie5i2fd4amhNQFR5Z6IN0=;
 b=kJK45SKI3ExQ21etttfHx1hZxjgM7BRLgqBJ8ioeK7XRx4lh7GwF8zNyte3eMN/hJq
 bCcXXbEBtx2/DDg/TNhhlWOIgB2vxxnLJnftl45+vv/bIJ06BoNlQ4ePEagPumJGW/HZ
 jQU+vrfRBE0Meom+qKz54pjjSShJVAsvLC1txiDTpcf/uBue4z9hzFheArTlHl/qwZ1u
 lWoswvc1rJT7oU9T6Wmeu2FoiYGWc+zYQSAurZ3cv2KL36z18aJVDw3bV6GZ6+uok/+f
 JEfinhxRFhWYerI9RzTK7Zg+9lxsRqgkZOmrptae0ZvsaaNLdyuvNzna6ONAmvStepVW
 ohSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787863797; x=1788468597;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vNzcQEWh32RxvwBhFRjP8/ie5i2fd4amhNQFR5Z6IN0=;
 b=lBZ3HQsggpm+z4WIgK4oSNEJ6j0zmomoRIFYx8eCsQgnf5J3DkF8BLd8xYTAYBL3aX
 B40nZUm/7w6OSo6anPW5iUTHDZ2lRT3jbDMavQEmxlbGoPAtC6gsmWgwjpQSzCR1tyoy
 m5TosBxov3KXyp5MQwpuT+yBRZSNfyyY7GZ7JOtFp/vlmJNxDPjiUXIzbRqyjktb6+lo
 KqxaxM1yfs31uOt2yAwdiO4TQtajEtLM4VA2gHjFKxsR5EoldZt1QZt/MqbPChmu3BrC
 UioXe12BWJe5NSqjSj/IlpXcVPSfIXOFhoU2C4sqF7KeJgjJqaqML0GAJ9NXb01qrrrZ
 Z1Og==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBK+jX8OEzCLV1HB/WQXYksHP3X5E9fyHeTQKbPd2qTloFn5Chl2dCagYWIcDxPLttabyDmkg+PSge@nongnu.org
X-Gm-Message-State: AFuF++k5Hg0WVKEcgPIFZ1g4TWULed7iUYS18DcCBrOqQ0HaMV3LNURR
 513XhnbsxqHxPNy+8B9H8F5AWGlkypWuO8IuagWTeFufLbZATljrK4HLWCM+SssF+PgGIM5eH/v
 XQKvBgnUjDnrLb/2beTLHC/i854EFNE7OzoQ569bUpw7x/cA3pk1NfFvY
X-Gm-Gg: AR+sD12YQ5Ygtnt6wqb5uKsbkEZMMe7DX6zSuTLz304wBbGRFaH06SPhIAhpl577fcY
 6JQIE7+PWohnGsqr1ODqzYd8968cv1pG92fGWB/+j9dDnu11RJfbHZ2mV38+syUz31zAok9jJPq
 AWGLutI0iOehqnfv7L3fGYuRG5mialcRc8tt2+5btubsDTrZ1+b1UlJIjQLasLU/2QN1FXDu61J
 pPp3DJconZ+miimEBxiH8CmvxU/y5dIL2X5KlWR7oYFRPWdY9oYwQex7tblodt4mEwbW7ZlXao+
 HAydpCgtXmulYRmWIzt6vg4bRuyB5XmcXo3xzeO3erkW8w1AoXyAZiDHmu/56Ks/tbLI2Baa+Q=
 =
X-Received: by 2002:a05:600c:6088:b0:49b:2796:be30 with SMTP id
 5b1f17b1804b1-49b91c433a4mr24292815e9.11.1787863796994; 
 Thu, 27 Aug 2026 13:49:56 -0700 (PDT)
X-Received: by 2002:a05:600c:6088:b0:49b:2796:be30 with SMTP id
 5b1f17b1804b1-49b91c433a4mr24292445e9.11.1787863796606; 
 Thu, 27 Aug 2026 13:49:56 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c52fdbsm10465225e9.0.2026.08.27.13.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 13:49:55 -0700 (PDT)
Message-ID: <b526ba23-6e7d-44ce-a740-b553f66adbb2@redhat.com>
Date: Thu, 27 Aug 2026 22:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Natalia Portillo <claunia@claunia.com>
References: <20231007072313.22108-1-huth@tuxfamily.org>
 <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
 <bf3036ba-0259-4757-a249-68e2a15af1ea@redhat.com>
 <74883723-8f58-404c-9bab-ddb9a4aef4a8@oss.qualcomm.com>
 <CAFEAcA_ALPTQLQwA_XzqOr=Zuc4_K9=LPNXN9jN_i0fyouqwxQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_ALPTQLQwA_XzqOr=Zuc4_K9=LPNXN9jN_i0fyouqwxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 27/08/2026 19.32, Peter Maydell wrote:
> On Thu, 27 Aug 2026 at 17:09, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Hi Thomas,
>>
>> On 27/8/26 14:54, Thomas Huth wrote:
>>> On 09/10/2023 21.39, Mark Cave-Ayland wrote:
>>>> On 07/10/2023 08:23, Thomas Huth wrote:
>>>>
>>>> (added Natalia who was the GSoC mentor for the NeXT cube work)
>>>>
>>>>> The machine is incomplete, and unfortunately the hoped-for improvements
>>>>> never happened. So it's maybe best if we mark this machine as deprecated
>>>>> and finally remove it again in case it gets into the way of a code
>>>>> refactoring or other reasons.
> 
>>>> I'm torn a bit by this one - on the one hand the NeXT code could do
>>>> with some love, but then given that the code already uses qdev/QOM
>>>> then there isn't really much in the way of maintenance burden. The
>>>> main concern for me at the moment is the use of the old-style memory
>>>> accessors that pre-date the memory API.
>>>>
>>>> With my latest ESP patches I think it shouldn't be too hard to update
>>>> the NeXT DMA controller to get SCSI working, so perhaps we can leave
>>>> it for now if it doesn't cause too many problems?
> 
>>> Almost three years later, the world changed quite a bit. We're getting
>>> flooded with AI-generated bug reports now, and of course people are
>>> discovering problems in this old and neglected code, e.g.:
>>>
>>>    https://gitlab.com/qemu-project/qemu/-/work_items/4303
>>>    https://gitlab.com/qemu-project/qemu/-/work_items/4304
>>>    https://gitlab.com/qemu-project/qemu/-/work_items/4305
>>
>> Hobbyist motivated machine emulations never committed to be
>> secure. While I appreciate these bug reports for the overall
>> quality of the project, I'm taking these one as lowest priority.
>> I wouldn't even mind of closing them as WONTFIX "Thanks ...".

The problem is that closing such tickets likely won't prevent other 
LLM-based "security researchers" to open another ticket for the same problem 
again in the future. So as long as we have such spots in the code, we'll get 
spammed with such AI-based tickets (IIRC some of the past AI tickets already 
had 4 or 5 dups from different people). And every time you have to triage 
the ticket, decide whether it's a real issue or not ... it's just very time 
intensive.

> I agree, but also they can prompt us to look and say "actually
> this machine is no longer used / never got sufficiently
> implemented to be useful / has no maintainer" (cf musicpal).
> So the questions here are:
>   * is the machine's functionality better than it was in 2023:
>     can we boot something beyond just the firmware now?

Mark did some work on the SCSI controller, but I think it's still missing 
some proper interrupt or DMA handling somewhere, so the kernel still does 
not boot properly yet.

>   * is anybody planning to actively work on it?

I was originally hoping that the original author would chime in again once 
the basics had been merged, but unfortunately that never happened.

>   * is anybody using it?
Certainly not. Unless that person enjoys looking at the firmware prompt ;-)

  Thomas


