Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C90C369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 05:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3TUd-0002HH-RT; Sat, 12 Apr 2025 01:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3TUc-0002H1-PP
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:33:26 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3TUb-0003xy-6b
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:33:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223fd89d036so35097255ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 22:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744436004; x=1745040804; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jh0BaaB4xw1ocHehmXIvuBEOnl8pZo2NZTop052dpF0=;
 b=BcahYOj14XDH9xupxSDB1Xsg49dlPG/2R3YojbgHrAF1GFibyR+74V6ntz9mhwLbUu
 C82Eh2qwm/CYqzepmF5lEujGQTP6Pv8XVLkUWRkZbDVSLY8sWGMmgYz/Ovx/1arNZeAJ
 JEsBQujBq5P8/WuzcCUlCcRz7YwK+wVKNpUHkw7AddN4BBuS0rMFvsjRsGw/6poRTeyl
 gnbd4qXQN7PhA7pxlI6peQ8LGED9Kp+mjHdtjDmRaIO4NFnf3URZGdN1ZRxlQTaZX+xC
 KqM9+vfbsP/57XHF5ObY7Ka7kO1yxL9YQOr7CJGwB/86mBvJvpqOf82CD5FSsuqJ6HrN
 9AZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744436004; x=1745040804;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jh0BaaB4xw1ocHehmXIvuBEOnl8pZo2NZTop052dpF0=;
 b=UUdfItwCSOQRrcPzO0dkRfdOv0HefwYFp8D5E3S0yo+N260Nlv3AoA48A+Kq2rJutP
 mKGX+jJif27Eqggtxi4fNmvesAb59pVgk5XzWz11bO7sbT0kkkPVmZQdcPHnNHlIIs9E
 +LKJi8wDXKbwpelfmFCA7d5Di5kQYs3OXlwaaW9EMhVKnHkT1rxPmd7mDKnkmv4Ag3Ey
 nzTujq8x/QR2yNI1nR6pLWIG6lsolKecUWTgBLD8vC0g7ofU6RD0HNXydb4Si/dOgbCr
 s9eARPKdwMWfMoKstqPQuz+iJAoZMSkTDBDuNtYDNhWfuatLP5MDYuOoQGHC+dhMTVM1
 kTBA==
X-Gm-Message-State: AOJu0YxqacB6R4Bv9MNNolDYbH/8w5wytNSmIisYYkXUunCwXgBVT1La
 ATMhU2RX76jpCgLQaw9uZQspAMSEE0NyDBIEatPsQZFmZr+yenl4on8D7Q==
X-Gm-Gg: ASbGnctS6OcZ66zUDwASvdlP4QaKrcfvFOOasqViJX6mUPLt9o5s8+HsUchcoZeVuLP
 olLU1U7qd8fTImr2i3pkNYD93Gc+Pczq2FHEDkcUZ+sFa3lLA7Ftf1YEjPE3ylIQL2a6aXJpDrO
 1xe2bhr/JQhvSUTGGoEDFYHX1YbkPHfkk5WmsihXrmOzzCCGYA7+agSn8grp7Ae/ghSa9+Fun6P
 qYg/wQUiVDoeOUWbqYbNqMN9NuTf7mT7sytzxHDYkK/BTKEe1uDwnL6XguYyWG/ycacSoIrVq8n
 jRc2z7kT6oR7vWDckgFfbvgWXEKc4SLvFw==
X-Google-Smtp-Source: AGHT+IEtdrGGokvoxogFRkF4S9YDPFao3JT9iFAVtusMPy/VSpUt/C2yajpbIS7oU7gOmGrpiTnsFg==
X-Received: by 2002:a17:903:2f8e:b0:224:160d:3f5b with SMTP id
 d9443c01a7336-22bea502b47mr66083335ad.49.1744435994938; 
 Fri, 11 Apr 2025 22:33:14 -0700 (PDT)
Received: from localhost ([220.253.99.94]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b62859sm60087805ad.40.2025.04.11.22.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 22:33:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Apr 2025 15:33:09 +1000
Message-Id: <D94EY6H32JFV.MEHMRMWGT8Z6@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Kevin Wolf" <kwolf@redhat.com>
Subject: Re: [PATCH v2 10/10] usb/msd: Add more tracing
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Gerd
 Hoffmann" <kraxel@redhat.com>
X-Mailer: aerc 0.19.0
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-11-npiggin@gmail.com>
 <5aba881b-a1bb-40fc-b707-2fd0d4b1a1d2@linaro.org>
In-Reply-To: <5aba881b-a1bb-40fc-b707-2fd0d4b1a1d2@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Fri Apr 11, 2025 at 8:36 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/4/25 10:04, Nicholas Piggin wrote:
>> Add tracing for more received packet types, cbw_state changes, and
>> some more SCSI callbacks. These were useful in debugging relaxed
>> packet ordering support.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/usb/dev-storage.c | 23 +++++++++++++++++++++--
>>   hw/usb/trace-events  |  9 ++++++++-
>>   2 files changed, 29 insertions(+), 3 deletions(-)
>
>
>>   static void usb_msd_copy_data(MSDState *s, USBPacket *p)
>>   {
>>       uint32_t len;
>> +
>>       len =3D p->iov.size - p->actual_length;
>> +
>> +    trace_usb_msd_copy_data(s->req->tag, len);
>> +
>>       if (len > s->scsi_len)
>>           len =3D s->scsi_len;
>>       usb_packet_copy(p, scsi_req_get_buf(s->req) + s->scsi_off, len);
>> @@ -264,6 +268,8 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_=
t len)
>>       MSDState *s =3D DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.paren=
t);
>>       USBPacket *p =3D s->data_packet;
>>  =20
>> +    trace_usb_msd_transfer_data(req->tag, len);
>> +
>>       if (s->cbw_state =3D=3D USB_MSD_CBW_DATAIN) {
>>           if (req->cmd.mode =3D=3D SCSI_XFER_TO_DEV) {
>>               usb_msd_fatal_error(s);
>> @@ -324,11 +330,13 @@ void usb_msd_command_complete(SCSIRequest *req, si=
ze_t resid)
>>           }
>>           if (s->data_len =3D=3D 0) {
>>               s->cbw_state =3D USB_MSD_CBW_CSW;
>> +            trace_usb_msd_cbw_state(s->cbw_state);
>>           }
>>           /* USB_RET_SUCCESS status clears previous ASYNC status */
>>           usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
>>       } else if (s->data_len =3D=3D 0) {
>>           s->cbw_state =3D USB_MSD_CBW_CSW;
>> +        trace_usb_msd_cbw_state(s->cbw_state);
>>       }
>
> Maybe helpful to log state transition?
>
>    void usb_msd_cbw_change_state(MSDState *s,
>                                  enum USBMSDCBWState cbw_state)
>    {
>        if (s->cbw_state !=3D cbw_state) {
>            trace_usb_msd_cbw_state(s->cbw_state, cbw_state);
>            s->cbw_state =3D cbw_state;
>        }
>    }

Yeah that's not a bad idea. I added that. I made a few more tweaks
and added some more trace points too, but nothing major.

>
> Otherwise,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>


