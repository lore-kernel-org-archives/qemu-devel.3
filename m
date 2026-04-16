Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B3CF8E489
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVPB-00020b-BC; Thu, 16 Apr 2026 18:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.ferst@gmail.com>)
 id 1wDVP9-00020O-MS
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:41:47 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matheus.ferst@gmail.com>)
 id 1wDVP7-0003aA-KT
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:41:47 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35e576110adso62017a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 15:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776379304; cv=none;
 d=google.com; s=arc-20240605;
 b=ShJ4WqcyAYb0JWmAPn2ZXRbax/UTP0hOJfHmkFKXuPJOSdUGFko1SNnTnc6dz7tHTF
 bcvr0+gynjaQcPE3FqY0PCPWKO+4cpmf8jqsL1ZDzNhVwBxyWcI3xuPQJeWWpE0aGXaC
 TFW/ZyfirvsBkAxxX7HG9Kw4b5BfjaTN3GGysms5WFxGwg6FjFtO4HBDVONG3HJiPn5B
 mFNR6CK5Y6c0yR4/d1zne+O9Pn1+SqN2bJkfed2YPHdnp3ctrTQ7CP/dxs/JJJSob5PQ
 BaSui2S3Ym/sb6SxqFG821jzUIqlkSpy7szThqCJHaI+0CVatBcICUuquFVHJB2NcvVq
 kVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OImrMwYKrZ1adQfrvSiEl3H5ZwG6DfAw5hK2SeDcILs=;
 fh=lSaylozGwWQvC9mpdwVhjl6H30Ek99ulxf5iATbC+ds=;
 b=krL+TA4Ik5UxJuM4m7Osy80K9L4Cb3d6D45VMn+ivsHcHFfOxv41GYsPH7oD8MTJwg
 cuscVRbkiMBbUmvwr+ttOhVnZJucgpvBVXCQMsoAp2jb1hfd/cUJFm31amR5URA+BihO
 1wLMFciT4Q7KFTrPWa0TVJkvZv7BwelebPuVg/wrJl3nqh1AKtYKDfLbOXgVZc5gIupp
 dPYxo2iyoJSS0EHvb6p1kGUxjjrgEZefxtoGEaZ8V7fQV7U9UEXGZ0eG3jT2uNwI74L0
 5YX0Nby8zbuxlLol9hxd0l5PNDaecT/pTZdnCSK0GVa832cGljW0mGm+gVQGPHfwaiun
 YPZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776379304; x=1776984104; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OImrMwYKrZ1adQfrvSiEl3H5ZwG6DfAw5hK2SeDcILs=;
 b=A/1cJolCsaBRWsAhPBJQYQQko66Zt5ftoIrCs1MyJ1oYHg+SpW3Ecvt/8g5rknn2e4
 OFFm6biPXUp2Ybix5qHOiNV+OYafV2w79lcoLwwIg5JnzrktsADKKcTPC362+0+/HRl+
 NDydUFrtRQKMk3XQLM16EQnuATLR95GRpbffC8eFdwtalgPNmgptCvJNlO8GYbOqp6Ih
 ZUi8vHMXAB3GJYf381qJ08A/lKJQTZZgaT+pvPsGksLzcFrSYw0ArDqABCqDdZCYGshr
 hHZbnumj9Ss6op8Q2vq2ZEY9706k18Hd22O0LKlG7bFqJmsySvaFeSTrlSXFLoGHBFfX
 qv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776379304; x=1776984104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OImrMwYKrZ1adQfrvSiEl3H5ZwG6DfAw5hK2SeDcILs=;
 b=IPCg2c55qKFV204OyVVyOK2UFBlzak5HQXSgU2OccfXe5NT8QGATZNsgkaMplcDGej
 BSYMq2chEZ+nSj7IUI06FP+Pd0OmIjspCr+ZHfRpo36+dBTyqS5rSNh7c1ysIAE6PtoQ
 6z3eZhAVt3EgpiPihWW+5hMxVrApfKSuMi9XMOosb8nh7TGAHXRRNXF55R6mH7VsmAWr
 hZ9NDMGxPwTjT9FtbC3C3qQ9CbRabfU9r8WdfbIEy3C4woMVqzZ/VxiGxK0y9g3w2Qgi
 +H4KJaWyfVTNwFDUg+V9NPRdiJtgfStvKpKJLxNf2cJrGmBLSerJzn5DY9eYScmx7Zo5
 Bhtg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MrsAs6h+5oz8ulz/BlEL7gBuiB8SPKzTPufnoO5FdjclhkK0NZ0T9tvGtTA9T8CykJ1aHZ667RQwZ@nongnu.org
X-Gm-Message-State: AOJu0YyYLVdCgFkX+PcEA0i5Gzo0j7QvfMla5qd/mCOCfTZo4nExVRbk
 beByaDQKdbh0gbi7qEsTVfv4Wzrq2scCfGNZ5WOruNS4d5afDtSRyvn3kzCO4+2CLU57V6RcLjC
 X6kkVHevtcaa4p/fT1Lc/ssEA9E9Xh65spg==
X-Gm-Gg: AeBDiet+gvEsELaWKW8eSAKs2b5EUbtwkRaZnA1q5CAY5V1W7WM79Dow9qhuGfWy1q3
 bGt0K42zVokOp6xMfZlM5ZB5eoNDkQHX6sDOpqx5Pn6DZsBXtVtU4fq/2y6PCMbPI8bwIZsRqnl
 kzoOKKrQSRLWKeoiZLzU6D8NGq+siJDI/Mo7zjuxeada2cbEr81CTiRcrpdHNLfqX1RoDYqWBtk
 E/xXgTsDbNcr3JZcFcWLmRpaDoTdHLpyqN4lQxZuXHDRlYUaabzvkNhHiUYW/+RFriBQjmj1zEa
 WyPW9OSUAtw3jBrkq8nLnaQ9A+Nv7uA/Qaat0vcmzeuAoGEJbQ==
X-Received: by 2002:a17:90a:d604:b0:35b:952c:43ab with SMTP id
 98e67ed59e1d1-361401eb6e8mr204375a91.4.1776379303574; Thu, 16 Apr 2026
 15:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260313194849.859579-1-matheus.ferst@eldorado.org.br>
 <CAOrDodHP9wmqk9ZG48vDfGW_e2WqYWbBQRFL+cEzLP4cJ82MVw@mail.gmail.com>
In-Reply-To: <CAOrDodHP9wmqk9ZG48vDfGW_e2WqYWbBQRFL+cEzLP4cJ82MVw@mail.gmail.com>
From: "Matheus K. Ferst" <matheus.ferst@gmail.com>
Date: Thu, 16 Apr 2026 19:41:32 -0300
X-Gm-Features: AQROBzBXFvK1VInHY1BND9KoZso7WynT2c9koUIU5vbqetGk6r0u3FHDXWoWFFk
Message-ID: <CAOrDodFB=0z+ZEhERnwoa7ZEzLjVtVHuC-znOfoSQC5W1CYXsw@mail.gmail.com>
Subject: Re: [RFC PATCH] net/tap-win32.c: fix segmentation faults when
 multiple -netdev tap are used
To: Matheus Ferst <matheus.ferst@eldorado.org.br>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, sw@weilnetz.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=matheus.ferst@gmail.com; helo=mail-pj1-x1035.google.com
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

ping

Em sex., 27 de mar. de 2026 =C3=A0s 09:22, Matheus K. Ferst
<matheus.ferst@gmail.com> escreveu:
>
> ping
>
> Em sex., 13 de mar. de 2026 =C3=A0s 17:19, Matheus Ferst via qemu develop=
ment <qemu-devel@nongnu.org> escreveu:
>>
>> The static declaration of tap_overlapped does not work when multiple
>> "-netdev tap" are used, tap_win32_overlapped_init will be called with
>> the same struct but a different handler, and the already running thread
>> with tap_win32_thread_entry will have the semaphores and free lists
>> changed under its feet.
>>
>> Make tap_win32_overlapped_t a member of TAPState to be allocated with
>> qemu_new_net_client, and move out the tap_win32_overlapped_init and
>> CreateThread calls from tap_win32_open to tap_win32_init.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3314
>> Signed-off-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
>> ---
>> I'm no longer seeing the segfaults with this patch, but I only have
>> connectivity when using the e1000 or virtio-net-pci devices. With
>> virtio-net-device (as shown in the issue with aarch64) I cannot ping
>> anything when two interfaces are used. I'm not sure if it's a problem
>> with this patch or a different problem, since it works with the other
>> devices.
>> ---
>>  net/tap-win32.c | 47 +++++++++++++++++++++--------------------------
>>  1 file changed, 21 insertions(+), 26 deletions(-)
>>
>> diff --git a/net/tap-win32.c b/net/tap-win32.c
>> index 38baf90e0b..af20c62868 100644
>> --- a/net/tap-win32.c
>> +++ b/net/tap-win32.c
>> @@ -114,8 +114,6 @@ typedef struct tap_win32_overlapped {
>>      tun_buffer_t* output_queue_back;
>>  } tap_win32_overlapped_t;
>>
>> -static tap_win32_overlapped_t tap_overlapped;
>> -
>>  static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t* =
const overlapped)
>>  {
>>      tun_buffer_t* buffer =3D NULL;
>> @@ -589,8 +587,7 @@ static void tap_win32_free_buffer(tap_win32_overlapp=
ed_t *overlapped,
>>      put_buffer_on_free_list(overlapped, buffer);
>>  }
>>
>> -static int tap_win32_open(tap_win32_overlapped_t **phandle,
>> -                          const char *preferred_name)
>> +static HANDLE tap_win32_open(const char *preferred_name)
>>  {
>>      g_autofree char *device_path =3D NULL;
>>      char device_guid[0x100];
>> @@ -604,7 +601,6 @@ static int tap_win32_open(tap_win32_overlapped_t **p=
handle,
>>          unsigned long debug;
>>      } version;
>>      DWORD version_len;
>> -    DWORD idThread;
>>
>>      if (preferred_name !=3D NULL) {
>>          snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name=
);
>> @@ -612,7 +608,7 @@ static int tap_win32_open(tap_win32_overlapped_t **p=
handle,
>>
>>      rc =3D get_device_guid(device_guid, sizeof(device_guid), name_buffe=
r, sizeof(name_buffer));
>>      if (rc)
>> -        return -1;
>> +        return INVALID_HANDLE_VALUE;
>>
>>      device_path =3D g_strdup_printf("%s%s%s",
>>                USERMODEDEVICEDIR,
>> @@ -629,7 +625,7 @@ static int tap_win32_open(tap_win32_overlapped_t **p=
handle,
>>          0 );
>>
>>      if (handle =3D=3D INVALID_HANDLE_VALUE) {
>> -        return -1;
>> +        return INVALID_HANDLE_VALUE;
>>      }
>>
>>      bret =3D DeviceIoControl(handle, TAP_IOCTL_GET_VERSION,
>> @@ -638,34 +634,28 @@ static int tap_win32_open(tap_win32_overlapped_t *=
*phandle,
>>
>>      if (bret =3D=3D FALSE) {
>>          CloseHandle(handle);
>> -        return -1;
>> +        return INVALID_HANDLE_VALUE;
>>      }
>>
>>      if (!tap_win32_set_status(handle, TRUE)) {
>> -        return -1;
>> +        return INVALID_HANDLE_VALUE;
>>      }
>>
>> -    tap_win32_overlapped_init(&tap_overlapped, handle);
>> -
>> -    *phandle =3D &tap_overlapped;
>> -
>> -    CreateThread(NULL, 0, tap_win32_thread_entry,
>> -                 (LPVOID)&tap_overlapped, 0, &idThread);
>> -    return 0;
>> +    return handle;
>>  }
>>
>>  /********************************************/
>>
>>   typedef struct TAPState {
>>       NetClientState nc;
>> -     tap_win32_overlapped_t *handle;
>> +     tap_win32_overlapped_t tap_overlapped;
>>   } TAPState;
>>
>>  static void tap_cleanup(NetClientState *nc)
>>  {
>>      TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
>>
>> -    qemu_del_wait_object(s->handle->tap_semaphore, NULL, NULL);
>> +    qemu_del_wait_object(s->tap_overlapped.tap_semaphore, NULL, NULL);
>>
>>      /* FIXME: need to kill thread and close file handle:
>>         tap_win32_close(s);
>> @@ -676,7 +666,7 @@ static ssize_t tap_receive(NetClientState *nc, const=
 uint8_t *buf, size_t size)
>>  {
>>      TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
>>
>> -    return tap_win32_write(s->handle, buf, size);
>> +    return tap_win32_write(&s->tap_overlapped, buf, size);
>>  }
>>
>>  static void tap_win32_send(void *opaque)
>> @@ -688,7 +678,7 @@ static void tap_win32_send(void *opaque)
>>      uint8_t min_pkt[ETH_ZLEN];
>>      size_t min_pktsz =3D sizeof(min_pkt);
>>
>> -    size =3D tap_win32_read(s->handle, &buf, max_size);
>> +    size =3D tap_win32_read(&s->tap_overlapped, &buf, max_size);
>>      if (size > 0) {
>>          orig_buf =3D buf;
>>
>> @@ -700,7 +690,7 @@ static void tap_win32_send(void *opaque)
>>          }
>>
>>          qemu_send_packet(&s->nc, buf, size);
>> -        tap_win32_free_buffer(s->handle, orig_buf);
>> +        tap_win32_free_buffer(&s->tap_overlapped, orig_buf);
>>      }
>>  }
>>
>> @@ -716,9 +706,11 @@ static int tap_win32_init(NetClientState *peer, con=
st char *model,
>>  {
>>      NetClientState *nc;
>>      TAPState *s;
>> -    tap_win32_overlapped_t *handle;
>> +    HANDLE handle;
>> +    DWORD idThread;
>>
>> -    if (tap_win32_open(&handle, ifname) < 0) {
>> +    handle =3D tap_win32_open(ifname);
>> +    if (handle =3D=3D INVALID_HANDLE_VALUE) {
>>          printf("tap: Could not open '%s'\n", ifname);
>>          return -1;
>>      }
>> @@ -727,11 +719,14 @@ static int tap_win32_init(NetClientState *peer, co=
nst char *model,
>>
>>      s =3D DO_UPCAST(TAPState, nc, nc);
>>
>> +    tap_win32_overlapped_init(&s->tap_overlapped, handle);
>> +
>> +    CreateThread(NULL, 0, tap_win32_thread_entry,
>> +                 (LPVOID)&s->tap_overlapped, 0, &idThread);
>> +
>>      qemu_set_info_str(&s->nc, "tap: ifname=3D%s", ifname);
>>
>> -    s->handle =3D handle;
>> -
>> -    qemu_add_wait_object(s->handle->tap_semaphore, tap_win32_send, s);
>> +    qemu_add_wait_object(s->tap_overlapped.tap_semaphore, tap_win32_sen=
d, s);
>>
>>      return 0;
>>  }
>> --
>> 2.43.0
>>
>>

