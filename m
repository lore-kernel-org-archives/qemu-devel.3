Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14239D2E014
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 04:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3TL1-0007da-T5; Wed, 23 Oct 2024 00:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3TL0-0007dA-0Z
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 00:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3TKx-0007hi-OW
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 00:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729659070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wlSu+gXnFBgB/3VUmmKejMJ9hX/5UlSIS8fCnb8K/p8=;
 b=JA5+3uX66M5pSLyko12NHwO7xGnNg22A3uKVAydjoTrhsK55XsalV92rJV8/HnQaf3UHHe
 A+0j5Op7vsZx7eGvWSu/ii1Oa9LtbxWBRYa53bl95AxcCba/4kzrqdnCaoeUsaaleLXVxM
 XPoaqsO+vHFTXh+1wF1WmgsNUyXyK7M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-QhjxpAq2OeqU4RGipy50wQ-1; Wed, 23 Oct 2024 00:51:08 -0400
X-MC-Unique: QhjxpAq2OeqU4RGipy50wQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so50302425e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 21:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729659067; x=1730263867;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wlSu+gXnFBgB/3VUmmKejMJ9hX/5UlSIS8fCnb8K/p8=;
 b=nyCbq2DVXo8ncy7Dj8I3PaAzoxUW7kPJmmThZWokbFdflGDAfiYVHPiJmGOxMYPfDD
 1yB3Y6+kKq3YoWGabtKf5IQQE5tiDsUGQqLZYyAS1zTxNxzBXt6LQYMaruR23P3gh1b2
 IyOU87k/x2sQqbYMc4Kkyk4kyLT29mkNgHGVMcZi+II8jOWdo37ZD42SKvvjDfXMGdbs
 VKDo45hixur53rULP0UOPgtVZYpbZ59diGkQLWn6qFDvXAsmSGOvifBVFy11quDoSLBo
 pxMCkY6ghyAVDB2YOSncwLAw/CdKE3xtY2Vuhe3t0+8h1+T91PSt3aSK0OZUjQpbBTEq
 Zf7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIefBWI9bgc25S/wOWrKrL+ocOUDQxpqH1Df/WL2D0emqFP9megzeVeWjSxfeGTnk5RrOcX8VvaJv/@nongnu.org
X-Gm-Message-State: AOJu0YyUXH6fJQwHFpdwn+CMnSyXn8Jkat7N7d4r1bEsNMmyd+0TA6AW
 EcKb5suapapRLFmT3ViMO1Ks0p6xJi6sLvtHq700A09KcJDpVJCPBTaBgjiko6x2nuoJjlV5EYx
 DkxmNhSMMb2PhJK40l2mzmZ6lTBlY+henGe4+OMLJWS6OK6/whQ5D
X-Received: by 2002:a05:600c:45cb:b0:42f:8515:e490 with SMTP id
 5b1f17b1804b1-431841341e2mr10139435e9.5.1729659066975; 
 Tue, 22 Oct 2024 21:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMyKyUCfHJuRJdxA+veSgvBmlA79wTEARoCdTBOUlK9fooBQtnu61Bz/HGFZ7BU4oFB392uA==
X-Received: by 2002:a05:600c:45cb:b0:42f:8515:e490 with SMTP id
 5b1f17b1804b1-431841341e2mr10139255e9.5.1729659066641; 
 Tue, 22 Oct 2024 21:51:06 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-40-241-30.web.vodafone.de.
 [109.40.241.30]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186bd689fsm5239755e9.4.2024.10.22.21.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 21:51:05 -0700 (PDT)
Message-ID: <a189b1fa-4cac-46e5-9253-e2bb2143c3c1@redhat.com>
Date: Wed, 23 Oct 2024 06:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/19] pc-bios/s390-ccw: Use the libc from SLOF and
 remove sclp prints
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <20241020012953.1380075-3-jrossi@linux.ibm.com>
 <7bf513ce-a4e6-47a9-8c56-6cc835cb4d17@redhat.com>
 <39ac6705-8787-4a00-a825-934d4897fdf4@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <39ac6705-8787-4a00-a825-934d4897fdf4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 22/10/2024 22.12, Jared Rossi wrote:
> 
> 
> On 10/22/24 1:36 PM, Thomas Huth wrote:
>> On 20/10/2024 03.29, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> We are already using the libc from SLOF for the s390-netboot.img, and
>>> this libc implementation is way more complete and accurate than the
>>> simple implementation that we currently use for the s390-ccw.img binary.
>>> Since we are now always assuming that the SLOF submodule is available
>>> when building the s390-ccw bios (see commit bf6903f6944f), we can drop
>>> the simple implementation and use the SLOF libc for the s390-ccw.img
>>> binary, too.
>>>
>>> Additionally replace sclp_print calls with puts/printf now that it is 
>>> avaliable.
>>>
>>> Co-authored by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>> ---
>>>   pc-bios/s390-ccw/netboot.mak     |  3 --
>>>   pc-bios/s390-ccw/bootmap.h       |  4 +-
>>>   pc-bios/s390-ccw/libc.h          | 89 --------------------------------
>>
>> I just had to discover that the removal of the old libc breaks "make 
>> check-tcg" since it uses the sclp.c from the firmware for printing.
>>
>> I'll squash this patch to fix it:
>>
>> diff --git a/tests/tcg/s390x/console.c b/tests/tcg/s390x/console.c
>> --- a/tests/tcg/s390x/console.c
>> +++ b/tests/tcg/s390x/console.c
>> @@ -4,7 +4,10 @@
>>   *
>>   * SPDX-License-Identifier: GPL-2.0-or-later
>>   */
>> +
>>  #include "../../../pc-bios/s390-ccw/sclp.c"
>> +#include "../../../roms/SLOF/lib/libc/string/memset.c"
>> +#include "../../../roms/SLOF/lib/libc/string/memcpy.c"
>>
>>  void __sys_outc(char c)
>>  {
>> diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/ 
>> Makefile.softmmu-target
>> --- a/tests/tcg/s390x/Makefile.softmmu-target
>> +++ b/tests/tcg/s390x/Makefile.softmmu-target
>> @@ -3,7 +3,9 @@ VPATH+=$(S390X_SRC)
>>  # EXTFLAGS can be passed by the user, e.g. to override the --accel
>>  QEMU_OPTS+=-action panic=exit-failure -nographic -serial chardev:output 
>> $(EXTFLAGS) -kernel
>>  LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
>> -CFLAGS+=-ggdb -O0
>> +CFLAGS+=-ggdb -O0 \
>> +    -I$(SRC_PATH)/roms/SLOF/lib/libc/include/ \
> 
> I'm not sure if it is just a problem with my setup, but with this patch 
> applied I hit an error when running "make check-tcg --always-make"
> 
>          In file included from /root/staging/qemu/tests/tcg/multiarch/ 
> system/memory.c:17:
>          /usr/include/inttypes.h:351:8: error: unknown type name ‘intmax_t’
>            351 | extern intmax_t imaxabs (intmax_t __n) __THROW 
> __attribute__ ((__const__));
> 
> It seems to be cause by including the SLOF libc, because it works for me 
> without that.
> 
> For what it's worth, it worked until used I "--always-make", so if you 
> aren't building all targets some change might not be picked up here.

I don't see it locally, but I've hit the same problem in the CI:

  https://gitlab.com/thuth/qemu/-/jobs/8156508094#L6090

It seems to work for me, if I simply drop that 
"-I$(SRC_PATH)/roms/SLOF/lib/libc/include/" line again and only use the 
other -I line. I initially struggled a little bit with my cross-compiler 
setup, that's why I thought I'd need the line, but I think it is not 
required with a proper setup.
Could you please check whether it works for you if you remove that line?

  Thanks,
    Thomas


