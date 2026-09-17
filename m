Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0C3C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x75xv-0000UP-5B; Thu, 17 Sep 2026 02:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x75xt-0000Tw-C3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x75xc-0006Hz-0m
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 02:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789627865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YL1B0K200a/buzG1mdYI9y/Vymrf5bQwt9Wkw9WL3Vc=;
 b=OJgMPOWLKg5JySQIRO6W6VCJorKJ4r5eqJCVxVQyUbQs0EG1ERhQNSQoy6jcF8H3CXRZW5
 THB21svtJ5W/t42Mks3UXcRS4atVXupbnkYMA1II0iI0i4FD/RVoeU0qkJz1gUnyS4blXP
 p4GTQgc1oghownTjklgotkDXsGlmYgw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-MKV_cEAvOCy--WjbRb0-DQ-1; Thu, 17 Sep 2026 02:51:03 -0400
X-MC-Unique: MKV_cEAvOCy--WjbRb0-DQ-1
X-Mimecast-MFC-AGG-ID: MKV_cEAvOCy--WjbRb0-DQ_1789627862
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so3258355e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789627862; x=1790232662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YL1B0K200a/buzG1mdYI9y/Vymrf5bQwt9Wkw9WL3Vc=;
 b=PKEJBPCrQebM+HoVgPiTRZ1rkxheJSQeN3bW3EBM5trT5yvEDCY3WIqmLlnTUG9b1z
 RurDzzw+1xtGIJKNOLRTG+jjn+4/05XzTNUwf0suQ1lWpfrPG1KS1rn+DYZ4ZIo5b7j6
 cnPaI2t8FUBx94+ZrSuPTcH87rMOEP0+zOqoztA5vLBMWJalMgECTU31v4fS7eNPh+pc
 9XX2ZdYRtP4Svln60yEwp1XmfnBiiCxY+PXeho7/jej5ewjZgl7QouvEoBNzUUJL+VZp
 lPsJ9xd03XMuO3UEaD7xeRk6cSgsMK0aUK6DGnzo07hsmJznZLFeW+suH4+U9tpB55+O
 ndog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789627862; x=1790232662;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YL1B0K200a/buzG1mdYI9y/Vymrf5bQwt9Wkw9WL3Vc=;
 b=uMCuYiqU77Qyf9JbtD5nwsyy24jDa2fsfMdKv18RFJ4zLx1QVJimqYVIBePSRv1Rq5
 6XmqJQ8EHetNDk93rQupZgNF5MTcjothKX6vcuCv3fwVDnGfgqylzekQb1sL5BP+9FxV
 FzvJ7FeE1lW5sjfciMcC6Jwm/bD+WUR3l/1myqfZHlc9Wru56tX9I4oRSseOVMF1JLmL
 RyfSSGgb+6A7t0AwAIyoSNzZJrgxVTpZCwVZiFaDSleyOBV/1ARktTq9xOLvzGLCOUlh
 BEMDD34AkTUw9nluWEhDNmynHtI5+HCNxjjuNU2h9KdJ5weIIGqMu3KzR0/yjgVCGEvu
 zQZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF/MBRsQojQp9li7DLpeEr6MzRsv6wD0tmaYbpZoAbE4JYGtiPOjB5RYIely2OsMXk7Rt/WIj9vQKJ@nongnu.org
X-Gm-Message-State: AFuF++kX+v6uPhUf6obzbxSOvIZ+2SnMvwhUN4hEcsFnql/n+/gYGDhA
 dm4KMUqLWdQRrUDQmgy87qRcFVAA9WuR9TXm4y9bEAorWdbE7HTFrBq9C7fa7RdBfU7DvnfF7P+
 1/amT25pe1X5PmCnS0THni4n0b4WqmyMBBvUhtyKAFlUI6l/M+9R+QV3D
X-Gm-Gg: AYBFou0AgXdKs4ZlkM8S69DBrN5c+LsOt3OvU62Ll55A/PYqd8UzG8/rPvfSeRq7oRG
 STzhpWCkueciBry5H/D1EWuswC1xuPPnIsJ6jYIssTAxkcf99KumVFrgtwJ+3XF0oKaOE3RC5wj
 2w/9C1pioQureiML8cIbOccyzp1+5x8XkhfLNsjtNXSnmQfQsxiHdDfWY7nnh8gYMJVbHhqZVzP
 HQV8kTMU8VMQ/sXvcR7J9F1shFkDgu0C3gCeFAvkZw9bsIIA9KyK6iDEVRDDVMdOiVNI7hoVMH6
 Oti2ZZmW3MGcsCf3tozSumniZd16H1dRZ1+PJbkcfuO7hewg32Wo+vXLexSIkWcU/Lm95LrfoNj
 eAFR3dAERk/gQ7TpByCK+9CExhdayiXwdtgENn7jorg==
X-Received: by 2002:a05:600c:1f96:b0:49d:243a:e4f9 with SMTP id
 5b1f17b1804b1-49eb6e2c8e4mr60096905e9.10.1789627862118; 
 Wed, 16 Sep 2026 23:51:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1f96:b0:49d:243a:e4f9 with SMTP id
 5b1f17b1804b1-49eb6e2c8e4mr60096755e9.10.1789627861785; 
 Wed, 16 Sep 2026 23:51:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1d0978sm49957205e9.2.2026.09.16.23.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 23:51:01 -0700 (PDT)
Message-ID: <0a85a818-7a1a-44d2-b502-21dfba688e08@redhat.com>
Date: Thu, 17 Sep 2026 08:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 farman@linux.ibm.com
Cc: cohuck@redhat.com, alex@shazbot.org, armbru@redhat.com
References: <20260914174420.12309-1-alifm@linux.ibm.com>
 <20260914174420.12309-3-alifm@linux.ibm.com>
 <b71cc588-f0f9-4c1e-9207-5ddd103a002e@redhat.com>
 <2ff23698-675f-4e4f-9257-51a31445ef30@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <2ff23698-675f-4e4f-9257-51a31445ef30@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 9/17/26 03:21, Matthew Rosato wrote:
> 
>>> +    }
>>> +
>>> +    fd = event_notifier_get_fd(&vfio_pci->err_notifier);
>>> +    qemu_set_fd_handler(fd, s390_pci_err_handler, NULL, vfio_pci);
> 
> @Eric - Since this version of the series is now all living in s390x
> code, I expect it will eventually go via an s390x PR -- but I'd like to
> make sure we at minimum get an ACK from Alex and/or Cédric for this
> patch due to the change above.
> 
> I already see Cédric giving review comments (thank you!) but wanted to
> make the requirement explicit.

Sure.

Nothing major on my side. The 'pci_aer=true' is implicit and the Error
handling a bit weird.

Thanks,

C.



