Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F2DCF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 10:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svDPZ-0007Sa-Pn; Mon, 30 Sep 2024 06:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svDPS-00074c-Na
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svDPR-0003Vp-BD
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 06:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727691220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1iX1T/ydGnsYoCCF4+XNIlRa0Q6zUBWhTbMYe7r3Gd8=;
 b=JKzpLCxDZCs1yxabi7GMMy+Eq+UGjNm9nao3C1+wVU5x9iSw8DboKztCQlfG2iFqdmejsJ
 oCmiODh1eavmv2944GyV8jTHaAwodfw5CxY08R/jrbuoBcQ+gOzqBUdrOH0FZ9HvMkIXYm
 8d1IuXltulZ5JAdmoi4voCI4CTxfgC0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-UDENrCcBOmqLHb0Q9A987g-1; Mon, 30 Sep 2024 06:13:38 -0400
X-MC-Unique: UDENrCcBOmqLHb0Q9A987g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cb27fb4c98so54612836d6.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 03:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727691218; x=1728296018;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1iX1T/ydGnsYoCCF4+XNIlRa0Q6zUBWhTbMYe7r3Gd8=;
 b=HtNaTPXjfNsAM8fGDNq/bTMUutVSZcEEaS7fwmeFkoXUg+AFgAfwjtZMc8XslpMGLx
 YFOFb2D8+g1QvCmAi//AB0w/B3Ixdf75i6eBjIUgOhso+NfSSMOuvht/0/cSDVhfVAKT
 /RyiC3YJyJaHRKh5kAqf6bI8M4KLBi+Xgb3CjPKMcKcxtG3FG4gFzHMs/L1c6Ln9CgJi
 3Rhw7hiCd6/D8KNVpSb9X/NsMHF7+beBEpm7GqBlxXHGLGT+ZI3oDcfsB54gjP9qlg5k
 0q7DumuEFYKZbL9sAYuH3sERqeCY7TZNr/MYin5drTTZ9Olh7PbqMMpZ2orPfoDqMto2
 2fUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJIcwuasddbYHQSD1TkMN4Sa1oBUFRE3UMVhfxDUMF6D5bx0V7bm6/v9J083UUtRK03AwtLzKDQyhW@nongnu.org
X-Gm-Message-State: AOJu0YwRtGVqhLcxei6nCptNS+CkfPGT/w6PiutrSfiDAji1noYhn2a1
 +UTPRCird4xA1g/rQ/m+p2xH9br7haYv8xmD9UH3+TOoO9hpk1r65Z2d7WD7RiJBOZ+obuqTPX1
 DW7dXPyptSWtUEVYCANolLs7vdnk19qfI66X9HEgPGl5ph76AqliK
X-Received: by 2002:a05:6214:5bca:b0:6cb:579b:b4ce with SMTP id
 6a1803df08f44-6cb579bb6e9mr90502956d6.38.1727691218395; 
 Mon, 30 Sep 2024 03:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwxPGlFZ2Lid3w3kUMZOcmSjNBXqb42zq3rUF1R9KCVJNrB7afpJ1R3dTbofOG6i/YayvZvQ==
X-Received: by 2002:a05:6214:5bca:b0:6cb:579b:b4ce with SMTP id
 6a1803df08f44-6cb579bb6e9mr90502736d6.38.1727691218024; 
 Mon, 30 Sep 2024 03:13:38 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b6106c1sm38791576d6.44.2024.09.30.03.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 03:13:37 -0700 (PDT)
Message-ID: <441fa08e-dae5-40d8-abd1-fbcdda7ed635@redhat.com>
Date: Mon, 30 Sep 2024 12:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] pc-bios/s390-ccw: Remove panics from SCSI IPL path
From: Thomas Huth <thuth@redhat.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-10-jrossi@linux.ibm.com>
 <f0d95299-48ca-4c23-bf68-dda8e499ad7f@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <f0d95299-48ca-4c23-bf68-dda8e499ad7f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30/09/2024 09.48, Thomas Huth wrote:
> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Remove panic-on-error from virtio-scsi IPL specific functions so that error
>> recovery may be possible in the future.
>>
>> Functions that would previously panic now provide a return code.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>
>> ---
> ...
>> @@ -572,23 +575,37 @@ static void zipl_load_segment(ComponentEntry *entry)
>>               }
>>               address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
>>                                            (void *)address);
>> -            IPL_assert(address != -1, "zIPL load segment failed");
>> +            if (!address) {
> 
> Shouldn't that be "if (address == -1)" or "if (address < 0)" instead?
> 
> Hmm, virtio_load_direct() seems to return an "unsigned long", so maybe that 
> one rather needs to be fixed, too?

(see my comments on patch 12)

>> +                puts("zIPL load segment failed");
>> +                return -EIO;
>> +            }
>>           }
>>       } while (blockno);
>> +
>> +    return 0;
>>   }
> ...
>> @@ -78,24 +84,30 @@ static void prepare_request(VDev *vdev, const void 
>> *cdb, int cdb_size,
>>       }
>>   }
>> -static inline void vs_io_assert(bool term, const char *msg)
>> +static inline bool vs_io_assert(bool term, const char *msg)
>>   {
>> -    if (!term) {
>> -        virtio_scsi_verify_response(&resp, msg);
>> +    if (!term && !virtio_scsi_verify_response(&resp, msg)) {
> 
> Should that be "||" instead of "&&" ?

Ah, never mind, I got it wrong, the "&&" should be fine here.

  Thomas


