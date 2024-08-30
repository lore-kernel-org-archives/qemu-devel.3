Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ED5CA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 12:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk0dO-0006ac-Tn; Fri, 30 Aug 2024 08:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk0dL-0006XF-MF
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 08:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk0dJ-0005b2-Iu
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 08:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725020499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T4iGmPLMcniqrCTysq3cqm7gdc9OVgJZIOJyj5Fker8=;
 b=O/ddgSL1a93a0UGixSTM0t7FAnWbI2mF8XNK8cGwIPJcu5R4UhOIOIaOvOKS8fSEZyGkNN
 PuSCxZqxhHKVv7wr5/fJmbw3Sbt+94Gcpq7jd7MrmdN7NtrFrUx/Ay1EdSUTUWvuWIiJxK
 qIPQhWaUEBG7tQpEEZDqNO5XhKZJofU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-vNH8V1RIO9qBzEBhZiGysA-1; Fri, 30 Aug 2024 08:21:38 -0400
X-MC-Unique: vNH8V1RIO9qBzEBhZiGysA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3730b54347cso1204204f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 05:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725020497; x=1725625297;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T4iGmPLMcniqrCTysq3cqm7gdc9OVgJZIOJyj5Fker8=;
 b=lcEDXaKPM00xrHGLgPzd3rAViAGHJNWTNxlE5UAFMOHAwVv8N7ul/7UGYClS/T20tR
 9Qp9BZNLgBaq7gy1yEGf5QUmB6yF/o4h4Tf9lR4OfMRH4YHDiCu4j3TLLbZbY2Mbabbd
 d7bBLTCNInDP7Mq7YBBzFYqpXZ9ZxBftz9Z9jLynalcGmIGPIWdqi2E5VQgbGmcy2dMB
 A+g8L7BLSDyrh0IAU0fExlPLK5K1eMnLxYRyb6wXWKeGo83Ck/RTttHr3P7UFp9J0dec
 iL6c2AkJ0U38kDeMB/KLpwn0a0PwwKYCFrnKUkddFad0AtfqJmjetZtNC+YaSNWu8MKc
 pUAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCA44PChMNx0o8uTHO4dngHWoVRscR4ggskPIZrZEo0tcX5DMunz38K5UYWGoLd96ut1DcVMg6P9rT@nongnu.org
X-Gm-Message-State: AOJu0YyyomakL3aLzwXcdMimZk0gRA8csA8wZAXvenMDsJOZDpFC0EfO
 rFRZu5S2Hf9L5MsX8qCkPDJIpKj2n4KWJ6iuiC+7SXRk7sxfvu7jbBJT4aJlgWxFkpkg2GsgOmw
 Os9O7NBVKSCqp5XwmjvGrWP9Vnn8CHjapyV5DXsYNFnNnZ3nmmIxw
X-Received: by 2002:a05:6000:1010:b0:371:8d47:c17b with SMTP id
 ffacd0b85a97d-3749b54ce30mr4385012f8f.30.1725020496935; 
 Fri, 30 Aug 2024 05:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiWcp9Ff9eR8wgtXID/l9JQodCuter+Bo5Vqd3FeU1ECiKUA/GoRtAF2EskAL6ADP1k227Wg==
X-Received: by 2002:a05:6000:1010:b0:371:8d47:c17b with SMTP id
 ffacd0b85a97d-3749b54ce30mr4384994f8f.30.1725020496351; 
 Fri, 30 Aug 2024 05:21:36 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-179-35.web.vodafone.de.
 [109.43.179.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ef812cbsm3877255f8f.83.2024.08.30.05.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 05:21:35 -0700 (PDT)
Message-ID: <08271c0a-d28d-4fb2-95c0-35cfc7a19a42@redhat.com>
Date: Fri, 30 Aug 2024 14:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Peter Maydell <peter.maydell@linaro.org>, Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
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
 <CAFEAcA-FG0V0=MNf6sszGW-_Z8PdNv5DWZbLyiF3CCyTt8NUxQ@mail.gmail.com>
 <CAFEAcA8WC7K_r2rOwPm=5HtYs99OTprkCZah_-g8PTEX8e10cQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8WC7K_r2rOwPm=5HtYs99OTprkCZah_-g8PTEX8e10cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/08/2024 14.17, Peter Maydell wrote:
> On Fri, 30 Aug 2024 at 13:04, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Fri, 30 Aug 2024 at 12:56, Nico Boehr <nrb@linux.ibm.com> wrote:
>>>
>>> Quoting Peter Maydell (2024-08-30 12:01:47)
>>>> I ran overnight with none of the patchset applied, and it never
>>>> failed (as expected). Running with just the first virtio-ccw
>>>> patch does fall over fairly quickly. So something's up with
>>>> that patch, which is curious because that's the one I thought
>>>> was a straightforward conversion without any complications :-)
>>>>
>>>> I'll investigate further today, I have the beginnings of a
>>>> theory about what might be happening...
>>>
>>> Thanks for taking the time, Peter! Let me know when you have insights.
>>
>> I think I've found the problem, I'm just testing it to see if it
>> does properly fix the intermittent.
> 
>> The fix is to add an extra patch at the start of the
>> series. Once I've tested this I'll send out a v2 of the series,
>> maybe also adding the cleanup RTH suggested in one of the later
>> patches.
> 
> By the way, how would you like this series to go upstream?
> I can think of three options:
>   * you take the whole thing through the s390 tree
>   * I take the whole thing through my tree
>   * you take the s390 specific patches, and I take the
>     remaining reset-cleanup patches once those have landed
> 
> Any preference?

I'm fine if you take the patches through your tree along with the other 
reset-related patches.

  Thomas



