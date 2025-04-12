Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E44C369A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 05:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3TUo-0002M6-Sc; Sat, 12 Apr 2025 01:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3TUm-0002JB-Mr
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:33:36 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u3TUk-0003ya-Vr
 for qemu-devel@nongnu.org; Sat, 12 Apr 2025 01:33:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22401f4d35aso31917995ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 22:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744436013; x=1745040813; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+j4F8IDHdMaSGZ3+lVzOTYxn0VceKglRxG6ZXkxCyc=;
 b=WvrEhvXei0EQxOn7Gbxo0xLySJDkb/vHuzFiKit5+6Qv47LhvaEoIoTpoDSSItg4rF
 QaUojhJ1ySJwnvm+pK16IpIOhdKop0vPiEVbiViVpR5pEojPdJNEiP7O1QIZahLUao00
 jOSVTn51XX0CIMLH41TF4IRAicQZP9La5eI8skYwRvs+4ggi+PGGWFa6QjWBkRgKaAwd
 ceBG/Sz1IL8/WSAbVCRQkcur+bpFI3z74+YczkksAMQVDqVDIp6wxqUD44wpbjgQ5e2P
 fZTPFPC8ToqeVAwk5gaiQ9lx0mk6voyhU13xFyPhIl49CkcsgOstTbV7Uwk5sbd21zJf
 yA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744436013; x=1745040813;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R+j4F8IDHdMaSGZ3+lVzOTYxn0VceKglRxG6ZXkxCyc=;
 b=ZzN18RdSItzFO0xXRqPRIv5lEM4S5W5Qpb+7VUFLgz4y5eUETI4oAau6U+r5hzsoqr
 R5jl9BIB9a1eOg2AUNAHkdMuSEaGJF025CJkKpJ/+JHjofqE7//EvwZgC3XtzDPcmpQE
 WN0LGs1nzmSWLePIQORzmh/dOAsVUorLsTbe0Bt+UH50iP7nkkjJmNtir5qRkAZ15loR
 TlsNIcS7H0vT46RA0vG3ujBmkX1mCnnwCxS2Dzq0P7tlCnI3Ym6KI4N2jSVzXjMNeHwM
 GpBhIJsbuj3I1hywsWEHhqFZMPbGg/boqNwMhxDeVq/SqplNObAdceJep/xBpMlm2Qjq
 tOpg==
X-Gm-Message-State: AOJu0YwrciDlJES/T7Ru9oCNprNIZ2LeJYQreEKoQp0AwTQLbAW5Bp0a
 KRi5hiQRlP/xaetAPiCEAPdDHAAFonfT1BqRjmlsc5geZsdPyZNG
X-Gm-Gg: ASbGnct5dstT3cVqAD2Sb3gZvzlBqiS1FDMKoVCCzyxvjk6QNRZb17nySCLhjWxxaD+
 Zwc+c8TqPVDH1CUF/ygfTGRg5J/uqXNvAK4SPevIRtgp6T8Jj1oj7RmvU7pt9Mk4ujrRj26lEeE
 cnRE+RlRHSCp7yljEnYNte+lQ2sAmomnvikyjyNfXnHNJkTNaLaulqzTpIhyA4dcb4Lv1taQSlD
 Nbgcsp9Ju+txxYfcxOffSILcC6ps7PvfzoWS1QDCP4GPFnEPlXK25DmeRg8QbsFF7xwQC4+pFUa
 Mw/4cucrcM3kuh/eNrjlsH8l+EgTQZZh2A==
X-Google-Smtp-Source: AGHT+IG7sfqMghvFyc4o0QJfegIQffBVEk5bo37yt1LRALO0BU6+Pr50Phf8ZkXbVVX1kl/u0Vbq7A==
X-Received: by 2002:a17:902:d4c5:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-22bea4fee9amr73141905ad.44.1744436013347; 
 Fri, 11 Apr 2025 22:33:33 -0700 (PDT)
Received: from localhost ([220.253.99.94]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cdcsm60252935ad.118.2025.04.11.22.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 22:33:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Apr 2025 15:33:28 +1000
Message-Id: <D94EYEYWM728.2K81YKH9JOHYL@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Gerd
 Hoffmann" <kraxel@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Kevin Wolf" <kwolf@redhat.com>
Subject: Re: [PATCH v2 08/10] usb/msd: Rename mode to cbw_state, and tweak
 names
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-9-npiggin@gmail.com>
 <104dc731-10bf-4e79-91fd-7b58e6033bca@linaro.org>
In-Reply-To: <104dc731-10bf-4e79-91fd-7b58e6033bca@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

On Fri Apr 11, 2025 at 8:37 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/4/25 10:04, Nicholas Piggin wrote:
>> This reflects a little better what it does, particularly with a
>> subsequent change to relax the order packets are seen in. This
>> field is not the general state of the MSD state machine, rather
>> it follows packets that are completed as part of a CBW command.
>>=20
>> The difference is a bit subtle, so for a concrete example, the
>> next change will permit the host to send a CSW packet before it
>> sends the associated CBW packet. In that case the CSW packet
>> will be tracked and the MSD state machine will move, but this
>> mode / cbw_state field would remain unchanged (in the "expecting
>> CBW" state), until the CBW packet arrives.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   include/hw/usb/msd.h | 12 +++++------
>>   hw/usb/dev-storage.c | 50 +++++++++++++++++++++++---------------------
>>   2 files changed, 32 insertions(+), 30 deletions(-)
>>=20
>> diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
>> index a40d15f5def..c109544f632 100644
>> --- a/include/hw/usb/msd.h
>> +++ b/include/hw/usb/msd.h
>> @@ -10,11 +10,11 @@
>>   #include "hw/usb.h"
>>   #include "hw/scsi/scsi.h"
>>  =20
>> -enum USBMSDMode {
>> -    USB_MSDM_CBW, /* Command Block.  */
>> -    USB_MSDM_DATAOUT, /* Transfer data to device.  */
>> -    USB_MSDM_DATAIN, /* Transfer data from device.  */
>> -    USB_MSDM_CSW /* Command Status.  */
>
> Since modifying this, please add
>
>    typedef

Done.

Thanks,
Nick

>
>> +enum USBMSDCBWState {
>> +    USB_MSD_CBW_NONE,    /* Ready, waiting for CBW packet. */
>> +    USB_MSD_CBW_DATAOUT, /* Expecting DATA-OUT (to device) packet */
>> +    USB_MSD_CBW_DATAIN,  /* Expecting DATA-IN (from device) packet */
>> +    USB_MSD_CBW_CSW      /* No more data, expecting CSW packet.  */
>>   }
>
>        USBMSDCBWState;
>
>>  =20
>>   struct QEMU_PACKED usb_msd_csw {
>> @@ -26,7 +26,7 @@ struct QEMU_PACKED usb_msd_csw {
>>  =20
>>   struct MSDState {
>>       USBDevice dev;
>> -    enum USBMSDMode mode;
>> +    enum USBMSDCBWState cbw_state;
>
>         USBMSDCBWState cbw_state;
>
>>       uint32_t scsi_off;
>>       uint32_t scsi_len;
>>       uint32_t data_len;


