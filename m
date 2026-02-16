Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E89E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruO3-0000Gu-7U; Mon, 16 Feb 2026 03:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vruO1-0000GR-KO
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:55:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vruNz-0003Ki-Jn
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771232117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yVKbvfM+4ZsReQVaNkJX+B9dSjM+u4MtrC1hl7hWcq4=;
 b=gR7rDetIYZz4r64oAPu+D2cHHQO50mBgmVV/jFU7XLb8bs7KIBouDkH7nB64xRgmNx+Kzv
 xKIN2bjmoE5okknZzXcrS1thheBVvwNIhx48KErl+jjKzVtqdPENrnzcCk3rT+zJPqK+6/
 MvtAuuRSkuz+qoWWCMLEUuU2UG0qXUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-TUeWIsl1OPWud60I5iTi3w-1; Mon, 16 Feb 2026 03:55:15 -0500
X-MC-Unique: TUeWIsl1OPWud60I5iTi3w-1
X-Mimecast-MFC-AGG-ID: TUeWIsl1OPWud60I5iTi3w_1771232114
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4368060a5e5so3365197f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 00:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771232114; x=1771836914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yVKbvfM+4ZsReQVaNkJX+B9dSjM+u4MtrC1hl7hWcq4=;
 b=PvJts93cv33fVxRp1xaqao0cSJTut0fPgDWslorUhPZcX2vHPQjVsTdKo3JjM7tl79
 w1mR7uEyvf5EJCMa0LrCaaqO68bodOiVLZoVggFEElDMcWmOlGCAl4S/Cvad+VN84poE
 bPD5MOgUbDZbZCsv3ABe6ZjlfNK1QpQmg2YpKqsG82ui4ErNwaLqOu2etpa28znBlDyB
 QifGptok5sQSDWvKAm7c5A9cHYwFSl8DY8pzSZicZyu7bbD1rA7KMd/ZTatcRGg3grFV
 AxcCVsrqFUwys6rlAwZj6WaQvg41Ekw5t5elxeycLPyeH37bx5V+atz1/2tmUL7LtHWs
 yYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771232114; x=1771836914;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVKbvfM+4ZsReQVaNkJX+B9dSjM+u4MtrC1hl7hWcq4=;
 b=tBjlSImgjgzaMYIqjcCntRCAS2VR8ig0u43+9zRuo80BAONnyEYsPQXOqEPIK5JoZG
 6fapVBoG8qSqWSXdlUaFhYMlXpf5+68d2S0AyyVfsYx8zdtqfpzAPRJn4tEUUnR4DVlt
 LP6iqzU3REamTo2n1ppPqHEyimm0voCOpd0nGuIBzIoAZNXpeki49Y6cRN5VUDbW/9ZJ
 3YObHbEDMMTpeZ6Cyndi9+Appn++azyZCWmLLflGDPqr+cI3j8iIzBJC8vwv1crBsVhK
 OFz2wpTk5clHjiYaMIShmTCREO9CXxpPfrdyLz3pnpRKv+e8XSUB/FKvKZR91c3rr5F8
 KEuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgpLfTwYt29kD5DbwzjUJAR1ihqL7ED9GC+xhOZgyBlUeEI4hD/uVD0aoGccaf9H41N9i5DoW3PGCL@nongnu.org
X-Gm-Message-State: AOJu0YwfvroXz77bduv9xfcM8gk07rQPZhZyJRXfowoowTyCRROuqyQ9
 pDS0s/8VAruJi+INKaDGi6NThtVVRi8icgfdiEUDDiBgXWA0jztyc9EGOaSYW2zsUDwAe4qTamJ
 r7paARIwEUiiCxa7hchJ1e+P20sn/PxRg7c2xTdDtv+YUo1MHHspCB3mi
X-Gm-Gg: AZuq6aK3okafBAD0u/rCnOBHOmF2SJ235UlEvBbse3mCz49prkvnVOOykf4qfI6naoa
 uHIjH7FJFLe1hImbbe38Ur9cLnCR9BbcV7o0UBvkyyvYUJiIDBF3tuK4BmaBcW8yoixaq3tP+vc
 MUcQ0OHEgwwMLCXTe5+5hY5tAJaeiNXrguQyRdi96jyAHDXLbl/g7D+pOtuBSZ86+PqHnj26XvB
 FKGlz+SQD07VfsCEqILCY6BEG/79XfI3bGzuDaiPar5jrVFszq3aoZ1Si6JzUQ/5fjTdpWNAvn+
 jxypT0e2OtG1a99cE+kB364NNqMEIFniFjSRgdBW+sSZTcAJ+7SxwuVG0ERhvx9xUeiUfpXmVnf
 Fl6CIZa93162KmI/YU8Lm89RfUuQMtk/vYUKlAkFoREyIRbIqS1pg0R/kj8aq
X-Received: by 2002:a05:600c:698c:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-48379b932b7mr131966185e9.3.1771232114040; 
 Mon, 16 Feb 2026 00:55:14 -0800 (PST)
X-Received: by 2002:a05:600c:698c:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-48379b932b7mr131965935e9.3.1771232113602; 
 Mon, 16 Feb 2026 00:55:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a41be2sm132434835e9.1.2026.02.16.00.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 00:55:13 -0800 (PST)
Message-ID: <dc42083f-e236-48cf-a3d1-69775031e629@redhat.com>
Date: Mon, 16 Feb 2026 09:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/vfio: sort and validate sparse mmap regions by
 offset
To: Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "alex@shazbot.org" <alex@shazbot.org>
Cc: Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20260211030615.3202-1-ankita@nvidia.com>
 <20260211030615.3202-2-ankita@nvidia.com>
 <98b36726-71d1-4129-99cf-b16bea1575f1@redhat.com>
 <SA1PR12MB71994FF05BA4E852DF0CA080B06CA@SA1PR12MB7199.namprd12.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SA1PR12MB71994FF05BA4E852DF0CA080B06CA@SA1PR12MB7199.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hello Ankit,

On 2/16/26 08:17, Ankit Agrawal wrote:
> 
>> +         */
>> +        for (i = 1; i < region->nr_mmaps; i++) {
>> +            off_t prev_end = region->mmaps[i - 1].offset +
>> +                             region->mmaps[i - 1].size;
>> +            if (prev_end > region->mmaps[i].offset) {
>> +                error_report("%s: overlapping sparse mmap regions detected "
>> +                             "in region %d: [0x%lx-0x%lx] overlaps with [0x%lx-0x%lx]",
>>
>> please use PRIx64
>>
>>
>> An extra 'Error **' parameter to vfio_region_setup() could also be
>> considered to propagate the error to vfio_pci_realize(). It shouldn't
>> be too complex to add.
> 
> Thanks Cedric for the comment, I've posted v3 addressing the additional
> Error ** param. Please take a look.
> https://lore.kernel.org/all/20260215084950.4657-1-ankita@nvidia.com/

vfio_setup_region_sparse_mmaps() can take 'Error ** errp' parameter
too.
  
> I missed to address to use the PRIx64 in error_report. I'll consolidate that
> with any additional comments that I get in that version.

A v4 is required indeed bc of PRIx64. I will take a look.

Thanks,

C.


  


