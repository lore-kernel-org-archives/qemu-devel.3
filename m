Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5EDC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4LD1-0008Tg-BP; Mon, 14 Apr 2025 10:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4LCy-0008TG-Qv
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4LCx-0002zu-FP
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744642485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Vw8oA0wnFzVxD4l8YbG4RGZaY0G2bTHCaN5xjmEjPl4=;
 b=EE0DfqFOW6om3ol2lagtfi8Z7ka4mHzVn/+AarUMtBX2v3z9U/Ucy0yAPTqjvT6rcLCvHU
 Ele/6DCrXXgsl/aGy/qJM6sS7dxgXKA6hXkHumPPZJpQ4HeY2Oe5g3NgWa6qYEfj9cJqeO
 gfT2H766Ef+0eaGI2qwhBCSo1o0nJNU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-NmlkVpPIMOGA3tdCaYO6Dw-1; Mon, 14 Apr 2025 10:54:43 -0400
X-MC-Unique: NmlkVpPIMOGA3tdCaYO6Dw-1
X-Mimecast-MFC-AGG-ID: NmlkVpPIMOGA3tdCaYO6Dw_1744642483
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39135d31ca4so2325914f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 07:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744642482; x=1745247282;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vw8oA0wnFzVxD4l8YbG4RGZaY0G2bTHCaN5xjmEjPl4=;
 b=foOiKcl9xVagk62nZ55N5vhay5twJZfUxgOQqb52mbWLUP+RG5GSS9S1qagZPBEAWV
 Ep/IpS+YGtVqMhsHHEhX9iLftFXM/GprEofq25o0iE7YKfLbyQXKEkGWw7XPKyv4jjxH
 7vOvQdkw4YIJzj5qQSVHH9E9xFaer8DOblQSqTC/aYsbmuSxeZNl6F8JYAvBIG9Bp7mg
 FiIPZdHfVzQgbVSUshGsm1y5Sj0IMREn2+gA96IKtuzJ1wApi4R/oZD7iBPo9BtbFddC
 NAsK4kafk3PeA67+OMNtkMwzOPgv/QzLVcIViUh1YBO+cdK9uSk/CXIxUtGQ65FpnJ/O
 P//Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjRz67VYRpYdB4TnkjFRZN8hSr3bmwKYZpyKl9aM4Zy0m7h0/fsPRM8fvgCrBeD/e9+I5wUsO20VuI@nongnu.org
X-Gm-Message-State: AOJu0YzaEXrC+K6yH4wpDx/8BGMI2LtQSoW13SbH4QUNL3AgtQ5TaJHu
 8h90ek0bNoFTp2Gb0vSc5+Rzu74j8W0LDEfW2hazm6O/AqZC6WnHfHawofga3AbFu5DVnYKx5Dg
 l7d8qUcoopHOMaBB9TYwXLNom5XduAUeS3WS4ecScqH1xxXpc1+Rk
X-Gm-Gg: ASbGncv6pylndDLvUtSqP2a5RjCce2Y3Y41JhLUm6RcmEUyCnrq67hjbjKo99qhRBpH
 7ntFzQeKLhH3qcOGzksKWTF8rPAULp95ZDwCgrBdyIi9dMHm0YZ46sstRH/A/T7kDehCBcRUudC
 Bp4Wm5T6RA5pcYqMpi+wXegBgrkb6lGJCWGazHw1thJzF1luppikFEbdP6RC7zImdFAf0/Yd1WE
 JPGXMIYb6GVeIgiMpVcp8I+jq9dppe2MpyIKZBMXixsBwILhsgNvuNj0PZOGjKllAIVlTmo+9FE
 +yCXD88fe4nl6rW+9ZYRWjdbrck5OnLRjQ8y3lzM+NQ=
X-Received: by 2002:a5d:64c8:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-39e6e48c131mr11366760f8f.8.1744642482567; 
 Mon, 14 Apr 2025 07:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER+bQy3WreoIYMEgYTxSw17BndkCspq8EU4RLESTjd27z7WtybyPJcSjgiz1IGUxtep90ssQ==
X-Received: by 2002:a5d:64c8:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-39e6e48c131mr11366726f8f.8.1744642482136; 
 Mon, 14 Apr 2025 07:54:42 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9807b7sm11315529f8f.60.2025.04.14.07.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 07:54:41 -0700 (PDT)
Message-ID: <9ee2d05c-cb62-4685-88b0-7f2f6ea2a006@redhat.com>
Date: Mon, 14 Apr 2025 16:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/5] s390: implementing CHSC SEI for AP config
 change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, akrowiak@linux.ibm.com
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
 <20250311151616.98244-6-rreyes@linux.ibm.com>
 <f2168937-5252-4e91-80d6-2ad344f443fa@redhat.com>
 <ed45e437-5534-4ace-8a7e-196860b43cde@linux.ibm.com>
 <ce83485a-7575-49df-a3eb-7feac3cfd675@redhat.com>
 <9c837758-c45b-4e08-8cd9-918e25fb1063@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9c837758-c45b-4e08-8cd9-918e25fb1063@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 14/04/2025 16.37, Rorie Reyes wrote:
> On 4/11/25 2:45 AM, Thomas Huth wrote:
> 
>> #include CONFIG_DEVICES
>>
>> at the beginning of the ioinst.c file. Then you should be able to do:
>>
>> #ifdef CONFIG_VFIO_AP
>>     if (s390_has_feat(S390_FEAT_AP)) {
>>        return ap_chsc_sei_nt0_get_event(res);
>>     }
>> #endif
> This worked
>>
>> (or whatever the code should look like).
>>
>> Alternatively, and this might even be the nicer variant, add a file hw/ 
>> vfio/ap-stub.c and include a dummy ap_chsc_sei_nt0_get_event() function 
>> there. Then in hw/vfio/meson.build add this line:
>>
>> vfio_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
> This worked as well. Since you mentioned that this is a nicer variant, I'll 
> go with this change. What do you recommend I do for my patches? Should I do 
> an interactive rebase to add the new file hw/vfio/ap-stub.c and updating hw/ 
> vfio/meson.build? Or should I make two new commits for each file (ap-stub.c 
> and meson.build)

Please do a "git rebase -i ..." to fix up the corresponding patch (that's 
what we're doing in the QEMU development workflow).

  Thanks
   Thomas


