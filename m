Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBB1C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 10:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIPIB-0000FY-5d; Fri, 23 May 2025 06:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIPI7-0000FA-GJ
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIPI5-0000zc-7X
 for qemu-devel@nongnu.org; Fri, 23 May 2025 06:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747994771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gvrn/WfqSUq9q/wStByaE/DOGUqowxi85O1gYtPFyBM=;
 b=Yb8pddNQBGwCS9NepdlyG7FYD7WyemXB4ftGlwquP/v/87Isq2NYqwTaTR3A3/M06Neqcu
 dO+RCv7OurLIvjgZB78t8GyGlB3372f2QdHW4KghtaYVpdsfHiJ7rAnIOIo2RHFTVoix5Q
 r7JxIyILtf+FEi2bqKkWasuglBeTL1s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-ttZUWR82Nt6Swcj-XzXxYQ-1; Fri, 23 May 2025 06:06:10 -0400
X-MC-Unique: ttZUWR82Nt6Swcj-XzXxYQ-1
X-Mimecast-MFC-AGG-ID: ttZUWR82Nt6Swcj-XzXxYQ_1747994769
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a3561206b3so3369343f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 03:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747994769; x=1748599569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gvrn/WfqSUq9q/wStByaE/DOGUqowxi85O1gYtPFyBM=;
 b=Sfe03LgOkzYgs4RZtZqsozd/yNEg/fZDkVn6pLCKX7iHVJj3H2tx+QcCulPHQh0FUZ
 03uq6XlnKP1uSyGv2pMUrlAjRkRhQv1w/KZ48IFEejQQ2c9zoB3WMmLMC+zaQZMKxqjt
 1HBBt5kl9++/SLODcUnIKuDHapRa2Zz0DhWUMIfC1aUpBoTJl1EoTarBZODzASWu9nii
 rcyzyuYlG4aFFb7ymUfJMEaB9qHlGceKAbAt2pUAuXZHi1FvV+j8owPpPjVy17VXCBJ+
 0Q/qB79Q1refxVgwRIm0JeTz3WGcal5wOqfH1yeFpuLQ4K/TTgzNDbYPD+O7hHmHUNWP
 voWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuk8gBs+JL+HdB+YvtujcKeOaF9V1HbtEB7b94E69VDKTIaRsa7eMgtDTuCTPJr0M9hkpSbwXGkhJw@nongnu.org
X-Gm-Message-State: AOJu0Yw550bOMrojgazQ8Nd46HjQYH+dvZE2k6ecsVuw6JgZzKWUf8Gp
 K6SETL8/76Qj7yG+zHmoc0wFxje8GTlivwtfjJedXpOmpvWUyIgxXquIOQzr6mc+XOvf751NSTd
 0H3eRWxXyWa+Zc/z8DIUq+7Z0kWIQvKZ/v+I0SxcZGPrgFm6tdCKrFDna
X-Gm-Gg: ASbGncsZaNTuYSb89xZsUqsAIgQVISC9z4yl/12miAV+/Zrgrn7eaWbr74S3SH5xDbF
 HHuYycxPfrjLsWLgLNLaUg3RT5zIgRUB+s+XWFx2rzJdOUTI+oBGXivfg4vVU04GGouwvmBatvV
 iZmS4QbI6rIAmSiJDa+dIsOeQw5SXxfSUcHa+TC2rKIMRFsjroj522vZZ1rhSHK65Nt+VXybufF
 gHcpL/V7WbvjwR5rnLs8YFFkRjzuQgMdJ0HdXwYj4wAdtU6GwlRVHXpF49QuTJFCWe+xUdZFQie
 x+CvMDh31vMBU5ZcoiM=
X-Received: by 2002:a5d:4884:0:b0:3a4:c535:47c7 with SMTP id
 ffacd0b85a97d-3a4c535490emr894307f8f.28.1747994768827; 
 Fri, 23 May 2025 03:06:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMD5/JaBEhwglp1JCfiQGzFKZ4Z4NlWaEkO6nPASxunZVHwabj0Yr8aLMM5itgmpvbOR0CaA==
X-Received: by 2002:a5d:4884:0:b0:3a4:c535:47c7 with SMTP id
 ffacd0b85a97d-3a4c535490emr894272f8f.28.1747994768466; 
 Fri, 23 May 2025 03:06:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d105sm26467619f8f.11.2025.05.23.03.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 03:06:08 -0700 (PDT)
Message-ID: <3f38ce6d-6bbd-4737-8c21-ce74cd1ed891@redhat.com>
Date: Fri, 23 May 2025 12:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/16] linux-headers: Update to Linux v6.15-rc net-next
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <84aabcb1d09fdfb24470b018d3f00d7e692008a5.1747825544.git.pabeni@redhat.com>
 <d764213d-7fa8-4b37-8eea-93b77ef989a5@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d764213d-7fa8-4b37-8eea-93b77ef989a5@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/23/25 11:50 AM, Akihiko Odaki wrote:
> On 2025/05/21 20:33, Paolo Abeni wrote:
>> @@ -235,4 +235,12 @@
>>    */
>>   #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
>>   					      struct vhost_vring_state)
>> +
>> +/* Extended features manipulation
>> + */
>> +#ifdef __SIZEOF_INT128__
>> +#define VHOST_GET_FEATURES_EX  _IOR(VHOST_VIRTIO, 0x83, __u128)
>> +#define VHOST_SET_FEATURES_EX  _IOW(VHOST_VIRTIO, 0x83, __u128)
> 
> Suffixing names with _EX is a culture of Windows, and it becomes mess 
> when extending multiple times (e.g., VHOST_GET_FEATURES_EX_EX).
> 
> I sugguest naming them as VHOST_GET_FEATURES2 and VHOST_SET_FEATURES2 or 
> VHOST_GET_FEATURES128 and VHOST_SET_FEATURES128 for clarity.
> 
> include/uapi/asm-generic/ioctl.h says:
>   * Encoding the size of the parameter structure in the ioctl request
>   * is useful for catching programs compiled with old versions
>   * and to avoid overwriting user space outside the user buffer area.
> 
> So perhaps the intended encoding for an extended ioctl is to keep the 
> first and second argument and change only the third parameter. For example:
> 
> #define VHOST_GET_FEATURES128 _IOR(VHOST_VIRTIO, 0x00, __u128)
> #define VHOST_SET_FEATURES128 _IOW(VHOST_VIRTIO, 0x00, __u128)

Thanks, I like that the latter form. I'll do in the next revision.

BTW, the reference to that legacy OS really hurts here :-P

/P


