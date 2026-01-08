Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78360D1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 06:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdj6n-0006Hc-Vi; Thu, 08 Jan 2026 01:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdj6m-0006Gs-H0
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:02:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdj6k-0003nU-OJ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767852173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UumluzB9OTvJ8TqvPvDcp4SS+M5rPxnHW6q0l/SWAm4=;
 b=RBnttcn3WAq8x7k9MlxbhKt+l4Dtc6ccNLm38Tqx9qSGKdylyDI2aIP90dO4ivOI0BccXQ
 ylubXV50TKRlgdEVnnRCF+JVPirKHpIiBs6BuuFvxYOgmGiWs5ny+V5O3xY8QcBrXHhQGz
 uJHr3dXs213KYPODzwtwwiqufONnk3U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-7ke0qpE9MIiwlkoo0RcsCA-1; Thu, 08 Jan 2026 01:02:50 -0500
X-MC-Unique: 7ke0qpE9MIiwlkoo0RcsCA-1
X-Mimecast-MFC-AGG-ID: 7ke0qpE9MIiwlkoo0RcsCA_1767852169
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b7cea4b3f15so436286366b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 22:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767852169; x=1768456969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UumluzB9OTvJ8TqvPvDcp4SS+M5rPxnHW6q0l/SWAm4=;
 b=ijjMEmHZjU3Sn004ScGKbwa+8r1RVouaCaPDM5cg+0g5i1v9dBHhn0sn3+UmbTwX3D
 CzRlju0yFO1bu8psyp9KtF29UXsBIScSQT9BKcXbIYJOl++VIp4ZiyHeptxvzWdoxxM/
 EuYC7zfBETlaFYuRnelxEzD8GbFH7q86b6cmTuOEMCQFD2hBpr0hOJ3yd1UGWk6JqdgF
 0yJTNi1tIhkgNgBtQyBkIJvg7XpJ4U6aAnp0n7oBsnPvDg6GtYmUwTpBlU8Uk2fiuX7h
 F6q2h9MjKH2ejuYMklcNPpFbtenvQMm/ujg86B/1Unr7GkGhJyX6tJxgGpz+cQraXcX9
 V3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767852169; x=1768456969;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UumluzB9OTvJ8TqvPvDcp4SS+M5rPxnHW6q0l/SWAm4=;
 b=V5RdOoJvrbfZMOhCuj7TfzxAZQEsJXSY92mpK6QvZSCsK1nr53KrstOfEeUdcc05hh
 Opu1KyUhtfUVOKbWNF80a9M96wNMWuO/WeXDY0VpRMWpLr53URm0lRJNq/8cU1BGYrht
 9ouP/8z+wSJxSutHO4Pm10HCvhKCZuj/nqCSl3d3PmE7ljhwaKPf+1YVdZRPM1jATp+N
 B6/nzb5OTxWdAIc0forrzEuFud3tsCy2UpHWYYGmIl/Rzdvl7n0wGJxZIlYdzVtCrHCh
 VD0SJ7TsUUG3GCsLzMbZ4WkO03qXLc6tBoCUUpGnxf3Dgf+HfSLeC0QT+1uJVNivYvyy
 imrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1DqIZOf1JGzgTia5LZRqkOp4Fv0orKX9CLxKMO9rC7pwnhSZ+zDfvkEvOAio0pYlbSk65V5vSJqZk@nongnu.org
X-Gm-Message-State: AOJu0YxxGu6S6O+aVuO1mGnCoZyg5K7sP1D0v2vr/eG/ZL/qIS83dfgz
 tt2PQm3wEEeUGax9t8ZyA0rHhOWdJUTwyNxxETxesxovaEOTZauM1zmC2y3D8QpNMpe3mVbKkze
 rK0u+oT2iGG5Ikne+au8olAqNComcpV+R+x0Cv1p13Inkkf3jYCyT6RO9
X-Gm-Gg: AY/fxX508dgq2rE4RgD/rDI8fPpFgQPIdKzeXk+YDHOGC2AhAQ6nUJG9l2xWsL8XQkN
 AIhyi0gDFwyzzgJmPC7UsmjYSNEelsGqIyEziqc1L8VrMS94Q3Mv1BS0lerItPZjQ+cup9ucgVs
 AfloAt/XTxjU4AfmfjTXnwQJsiZx0O8DZdC6ErqkepEl0oF14YUtzabvqCCVuVQ5Wm7jr8rNoyo
 yZI6M9zZ8zNDeyjCjSi9VODItODTDjRZT99TlHciAgXi2LM0c87wQiRZnPWIxhoMj47i5mKgVTL
 NdmkDQLpDw+C9YLLIN8D6+SiEnt9McZKjPTDav/R7H50yRmr9Efl2pAhVCwWORDUobf5Igw++1t
 lZx1J0u0=
X-Received: by 2002:a17:906:d54b:b0:b73:5d8c:dd0d with SMTP id
 a640c23a62f3a-b8444fd4a55mr441474866b.52.1767852169404; 
 Wed, 07 Jan 2026 22:02:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzFP2pONUSHkpZqzMUjlUss/ncFRuoMND+5Q1S11r/v83ZJMQp2fSSOV1pYiluwWYLsKELvA==
X-Received: by 2002:a17:906:d54b:b0:b73:5d8c:dd0d with SMTP id
 a640c23a62f3a-b8444fd4a55mr441472166b.52.1767852168890; 
 Wed, 07 Jan 2026 22:02:48 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4d311esm699534066b.38.2026.01.07.22.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 22:02:48 -0800 (PST)
Message-ID: <8d4d72e3-b4f5-40bd-9676-b14150f8daf8@redhat.com>
Date: Thu, 8 Jan 2026 07:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-4-jrossi@linux.ibm.com>
 <1a5926ec-8bf5-49de-9228-595d3910275f@redhat.com>
 <bbb1ec46-3e59-4bfb-b656-7f07570ab981@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bbb1ec46-3e59-4bfb-b656-7f07570ab981@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/01/2026 17.38, Jared Rossi wrote:
> 
> 
> On 1/7/26 4:40 AM, Thomas Huth wrote:
>> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
...
>>> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
>>> index 0f4f201038..0488b3a07e 100644
>>> --- a/pc-bios/s390-ccw/virtio.c
>>> +++ b/pc-bios/s390-ccw/virtio.c
>>> @@ -2,6 +2,7 @@
>>>    * Virtio driver bits
>>>    *
>>>    * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
>>> + * Copyright 2025 IBM Corp. Author(s): Jared Rossi <jrossi@linux.ibm.com>
>>
>> I assume you wanted to put Authors on a separate line?
> 
> I don't quite understand what you are asking about here.  Or maybe I don't 
> understand how to attribute the authors in this case?
> 
> Much of this was just copy/pasted to the new file, so I included the 
> existing byline too.  Should I format things differently?

No, you don't have to change it, I was just surprised to see "Copyright" and 
"Author(s):" in the same line. People normally put it on separate lines, see 
e.g. cio.c, menu.c or virtio-scsi.c in the pc-ios/s390-ccw/ directory.

  Thomas


