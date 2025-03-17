Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D371C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 10:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu7uh-0003ps-P3; Mon, 17 Mar 2025 06:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu7ua-0003pY-8C
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 06:41:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu7uX-0006k1-1c
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 06:41:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2240b4de12bso29203425ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742208091; x=1742812891; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wHymbGZD4WoSW8wUdBrV2zxjPDwL1khzCbVKjkhNAo=;
 b=HjQirAa3u0EhmGwjuDb7nWe9yQIFSxdD83mxqCAIWI4W4H7xD9V+G1MAiuklAeUCF2
 dTobzkYYXkIzMCLZ4St/qlFWtcQ4gT6w1boLnSkiSNlqy3AZSChjU3O5O0KbLRSf2KyA
 t9Ez4d9F2m3MuojNelHJx4G/9UDEUZRAy8ZGjOQbNNuIrn+qc9XQhd9cJvfIKpScc1TP
 +/zYEMC9ZPszLI2LohdfCBu/OD+gd02Ts5LcbkR+7+pzGqmUHTTU6aIq5vj/QbPlO+qF
 VYcTgyv2s8Vs52325kfi105fQjXG0q5BCjxdv9RW9MKAtQUGDtqI/pFX0ldpGQrVBYsM
 O82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742208091; x=1742812891;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4wHymbGZD4WoSW8wUdBrV2zxjPDwL1khzCbVKjkhNAo=;
 b=f2ueqc2l3mZoZ9b+9CFa0knxxqxgsX2wtqcrEkULVpsN9rZqB7L0L5MU2dFI0gZQa9
 S9aJ5k278Rg2KBamiyJ7YVpI8HZtTN/zhxNG/IMddFBv85ZojkbV45/oSjxryujmfUH9
 Y5o/EZRuoGbPiXgXnuqpikz9cPoSnvr0UdSwx7yuqKXxTJyuZRr55LvOQUK9fHt+Uxm5
 DUXkZ49HbGR9YU5bSTAQ0JhFJWWk7uAWLQtRjDovQZkxBnv4nB9Do1sR3qBWhUhln74a
 1hNk/nMQBXGCnkHbMuJZjn6cLgc22+nxvENumH6ZBeafMf6Bkq8fMw1BaeIeE9cumqVe
 zfVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGGscMYjZtokn2DOlWjCPHxMf1uBm4KNPZZRH53Lm3PtB92JIaMzHczKq0+77Z2GJ7Ps0JEzth9STq@nongnu.org
X-Gm-Message-State: AOJu0YyYn107ExaAGI8zqvaD9ZG6MVpaIfRzGD0a4srUVRbfH9FEqtrS
 b6HBgAq1cGt/B15kQRkRFQuuRWCd0/gP3DxkMo5C5u7EXWw9Fwop
X-Gm-Gg: ASbGnctv7DlLWeDEz5mTzrBLl1YvEvupuvvcN91yZq9VSlAZ8Rlkzpr8VHIKqO773R8
 334CmTFKxC2qTpWAxd8LPV4fQY6gXDJbuoeUMTksmUQwbouVLDJDaJbgFTOWpS76RyEMCE5UnK7
 8h+p0w+sfCklkpkkaxrRjxC0WexVoTE2DUlfxjtlXnGeoOOMytym6CIM+VXl5pRTHbK1cEy4uSW
 /ic7mrrt06cS80sLdtXiULLX73ygjJ3eWdEGRNakAsn5SjRHVSGlbd1QSdBUIOJnEmBV3Y3ykq9
 9j6JAGbSMtT2IkbGcZxMsYAquTMabsrlX3y9t9c=
X-Google-Smtp-Source: AGHT+IGogHy/alE51CPX8nBzdAqroOiUcI5GXA9EfMLne4r1CwzLTV2kcK7K5FmT/enAuhtJClJ+Hw==
X-Received: by 2002:a05:6a00:2343:b0:730:9752:d02a with SMTP id
 d2e1a72fcca58-7372236c6a7mr14959591b3a.4.1742208091440; 
 Mon, 17 Mar 2025 03:41:31 -0700 (PDT)
Received: from localhost ([118.208.135.36]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b10e1sm7209191b3a.165.2025.03.17.03.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 03:41:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 20:41:25 +1000
Message-Id: <D8IH81HZG5OJ.Y5UEA1WLU4DL@gmail.com>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Peter Xu" <peterx@redhat.com>, "David Hildenbrand"
 <david@redhat.com>
Subject: Re: [PATCH 2/2] memory: suppress INVALID_MEM logs caused by debug
 access
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250314074107.992163-1-npiggin@gmail.com>
 <20250314074107.992163-3-npiggin@gmail.com>
 <4be1fdc1-3c50-4e20-aaf5-f6831a944246@linaro.org>
In-Reply-To: <4be1fdc1-3c50-4e20-aaf5-f6831a944246@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Mon Mar 17, 2025 at 7:03 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> On 14/3/25 08:41, Nicholas Piggin wrote:
>> Debugger-driven invalid memory accesses are not guest errors, so should
>> not cause these error logs.
>>=20
>> Debuggers can access memory wildly, including access to addresses not
>> specified by the user (e.g., gdb it might try to walk the stack or load
>> target addresses to display disassembly). Failure is reported
>> synchronously by the GDB protcol so the user can be notified via the
>> debugger client.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   system/memory.c | 37 ++++++++++++++++++++++---------------
>>   1 file changed, 22 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/system/memory.c b/system/memory.c
>> index 4c829793a0a..960f66e8d7e 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -1412,18 +1412,23 @@ bool memory_region_access_valid(MemoryRegion *mr=
,
>>   {
>
> Alternatively:
>
>          int invalid_mem_mask =3D attrs.debug ? LOG_INVALID_MEM : 0;

Oh that's a thing? Would save a level of indent and might look
nicer. (I guess you have x : y expressions reversed)

Thanks,
Nick

>
>>       if (mr->ops->valid.accepts
>>           && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, a=
ttrs)) {
>> -        qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWADDR_=
PRIX
>> -                      ", size %u, region '%s', reason: rejected\n",
>> -                      is_write ? "write" : "read",
>> -                      addr, size, memory_region_name(mr));
>> +        if (attrs.debug) {
>> +            /* Don't log memory errors due to debugger accesses */
>> +            qemu_log_mask(LOG_INVALID_MEM, "Invalid %s at addr 0x%" HWA=
DDR_PRIX
>> +                          ", size %u, region '%s', reason: rejected\n",
>> +                          is_write ? "write" : "read",
>> +                          addr, size, memory_region_name(mr));
>> +        }
>>           return false;
>>       }


