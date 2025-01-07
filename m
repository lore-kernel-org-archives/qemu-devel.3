Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB16E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCkf-0002Yp-9M; Tue, 07 Jan 2025 11:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tVCkd-0002Yg-SC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:48:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tVCka-0005KQ-93
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 11:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736268494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtRxmN7slhsaaVCvD6TS34S4xY07o8L0m11lcSrw90U=;
 b=dAKn9p/YhYn8Ka0FVxIZMI4F5nMkWcHQR0WmZ+leRs9tCMedGiyxAL6NSTVQqpG+bOEHpf
 G5ieUyJeDc0r/xNAWdkMGZ2Wc8rRH1k7qiprfk1yjDa3IvV2iT12FhkTufME7iL4rdbIta
 nsgXDB6VoYTzwWshS68ow2yFeK1oa/w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-H3MSGmIvNLiMQHX-1OFq6g-1; Tue, 07 Jan 2025 11:48:12 -0500
X-MC-Unique: H3MSGmIvNLiMQHX-1OFq6g-1
X-Mimecast-MFC-AGG-ID: H3MSGmIvNLiMQHX-1OFq6g
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6dadae92652so370376476d6.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 08:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736268492; x=1736873292;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtRxmN7slhsaaVCvD6TS34S4xY07o8L0m11lcSrw90U=;
 b=DGKpKGH+vTtRJp9c+Dj5PjPauaH/PzzbdjN3tTWkUySaMzo5LktwA9XC/KKjPdr/9i
 KgtNbVZXk0hfZvkyDRn7OWP1UxtrSuIRCdpTQu5AVjssTCdWkTBhSlO3YtvuPwrclweE
 t/rmE3RXJC0VwuGOKem4lvUqoSuIuqr4c0icfva2LHKTMvsnigQjRHRmWizI/uaZF8Jw
 4NLB8Di9yxCzVfrDD97z94YBcJBQTL3h/+hgPyvxtnePtJ/A4QM42/WaUVuGQKs0AjA3
 efdLISTYJeiGPSDfP2t9FiUnRodwY6wb0zIYItpevN123Y3rj0bk0Lxu1MzmZyG6xVH/
 AsFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW10ZClFHZiHMAy68Oa4ad8K5Ak8e73Lxy1a90niXU0Jnks8eDrTODB3E/S/3YefsPmBvX2dd3o5nIM@nongnu.org
X-Gm-Message-State: AOJu0YzCIURxa4Il4/IC3cBdPC/Rea1J86O7UNaRin5QQcDi4gRds38m
 tc5aYMbg4hMK3cuK4OsrKTGLht3gZPp/KQ55nskahdRRUHB7xYnoG3nxN2G1+Z1Yxjygl4Cn64E
 olN+xnvppuPBClYEtmIdYtZZ76nP6C69cilGVCboJE9NVRg38Fc5g
X-Gm-Gg: ASbGncvCtJxCL9MIyCbHxctzXjRQW54iLRVped3+8bsXcCmKMW8NXWO7RpH2w4nOFCE
 QWY1efVSARFKCW1k6N5N3fWT/iYIdy1YYTuXuZNR3UYzQUnpzRKDiPaDDlFhs0eFJKr2Cb3oKRp
 1z39Elt26TdBwFGieG9j6ns6mdttSUatCRtrj7Z9asVXqJPkcxwExmdwBghlQBBu2w2niCMF0Mc
 KnBwzTo/Xfgjz/G3o7rXoTVFxjG2x0+V17hAqforusnnA0ZMrNemiK/KNUyp++id2DAL0UpoTuF
 MfqXW4dX9Zqg/QADs3Oebqhfq/HIEw==
X-Received: by 2002:a05:6214:21a2:b0:6d8:b3a7:75ba with SMTP id
 6a1803df08f44-6dd233aa643mr1101525786d6.45.1736268492315; 
 Tue, 07 Jan 2025 08:48:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4tUPADatzo59E++Jk515OERt2ZSq2DodcKFLFUOPx2YwXG1VrRawcNwb08o6pXAZLZYvWbw==
X-Received: by 2002:a05:6214:21a2:b0:6d8:b3a7:75ba with SMTP id
 6a1803df08f44-6dd233aa643mr1101525366d6.45.1736268491902; 
 Tue, 07 Jan 2025 08:48:11 -0800 (PST)
Received: from rh (p200300f6af039c0027df13c9c906520b.dip0.t-ipconnect.de.
 [2003:f6:af03:9c00:27df:13c9:c906:520b])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d5308sm182552636d6.111.2025.01.07.08.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:48:11 -0800 (PST)
Date: Tue, 7 Jan 2025 17:48:06 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, 
 Zhenyu Zhang <zhenyzha@redhat.com>
Subject: Re: [PATCH v2] pci: ensure valid link status bits for downstream ports
In-Reply-To: <20241203072809.3431fe80.alex.williamson@redhat.com>
Message-ID: <025f615d-4860-4bf5-6bd9-0901681ffafc@redhat.com>
References: <20241203121928.14861-1-sebott@redhat.com>
 <20241203072809.3431fe80.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hello Michael, Marcel,

On Tue, 3 Dec 2024, Alex Williamson wrote:

> On Tue,  3 Dec 2024 13:19:28 +0100
> Sebastian Ott <sebott@redhat.com> wrote:
>
>> PCI hotplug for downstream endpoints on arm fails because Linux'
>> PCIe hotplug driver doesn't like the QEMU provided LNKSTA:
>>
>>   pcieport 0000:08:01.0: pciehp: Slot(2): Card present
>>   pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
>>   pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000
>>
>> There's 2 cases where LNKSTA isn't setup properly:
>> * the downstream device has no express capability
>> * max link width of the bridge is 0
>>
>> Move the sanity checks added via 88c869198aa63
>> ("pci: Sanity test minimum downstream LNKSTA") outside of the
>> branch to make sure downstream ports always have a valid LNKSTA.
>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
>> ---
>>  hw/pci/pcie.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

Can you pick this up for the next qemu release, please? It fixes PCI
hotplug for downstream endpoints on arm.

Thanks,
Sebastian


