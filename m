Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D5ACCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 05:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4rX-0003uU-Gk; Tue, 21 Oct 2025 01:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vB4rV-0003uL-TP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vB4rU-0006nF-6l
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761024281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kz6m0AVmw/Ag61Qq1S4zYvhIx5QVZ02v9f8ESiqk9T4=;
 b=cl+wOSkj0H7y+M50KbhL2/JXP/p1XkguSOy47XY42fvqtwWTXKYjh6Cl3URQmp6nHP3SSY
 ebhwVTLRyaV2wtquvCq8R2m4Tkhdts7rpad2EJoKmfg54+M1iZLDeadxrpOhpFMr8PuMaM
 bsS/hYMb5sVBEHvCFe4GxJ/xUEQ2JIk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-uHbJWAr9NzakXKbmrCHY5A-1; Tue, 21 Oct 2025 01:24:39 -0400
X-MC-Unique: uHbJWAr9NzakXKbmrCHY5A-1
X-Mimecast-MFC-AGG-ID: uHbJWAr9NzakXKbmrCHY5A_1761024278
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46eee58d405so25810505e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 22:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761024278; x=1761629078;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kz6m0AVmw/Ag61Qq1S4zYvhIx5QVZ02v9f8ESiqk9T4=;
 b=iKGXAbtMndXaZO8Nw0NCGzRg+lLuT5fQbH7O4LYNklM/v6Bc/s6MVVPf0EUnY4AKz6
 ZqC8nP84RDzaXwomM8s3qRmy5hOvp/dzmy2jCM4QPboofFjEMlV7lKxkTlxRx2zQB0sL
 tJE4i3+IVsuakGaw9IAsYWAs2D2kTvwqSvtZGXB4/RIkQerFIRwG4HO3qdZQUUOXiox/
 hpYVMVOiSbVAiPoSSigif+zTjZuyVOOeMP+ovfR5M4iYwtgz195nYGDuPqU+vS2NcwSw
 TAiwvFJOR70DOo0MdguVB7IqNzODdpXhrDsgjZQAwOSs39dF/seKV23r0gwccccmArMt
 09zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUruC05JO+xEhiTElgkl7vDNlhYHwk5zsJhQMqfUIHIp9nbyMfQ1g4dbcehr0MUClbtmTpmBpCfhoE6@nongnu.org
X-Gm-Message-State: AOJu0YybPr4YetszOgwVXFsZEOlVpwvx5jXGMRzOFyGRn4maotlbgNtP
 by22xQDn6H5lz0re2G4BUMVeDO1oX+jJfP62CLv/fssbLN4Nn523TmdnhWGyoLoz8cWFz3GXlYb
 I9OpNgxVLtxQyOWFRmiANv6jmksFKCreq/Jg9mBi6/K/PhC9lkk2uFtMU
X-Gm-Gg: ASbGncujAu82ljfqJ9lien1GkhedN9Cp4l+jnGkxrFhmrVn6ptGGmNyejsz0oqJ6IOO
 CqEnlSChmPnC2wy657GtrrhEr06eZ4S8hDqbnCo24xE8RWQk0hN3a2eiMcN8okIjZJZK6Fh1JUa
 nwXLYr81zGnrOlIbt2Pec1rRnqXR8HBg3bUlSHalNF0cvhZIM6v36q1sMfxzEm7qT6r8sN3RasS
 bbrE1BXduZDHqkNBsYeLNUJOAv3KV5NBD7eXj4Fh3ZWpz80oAT8ciw6VoxB7r5tc3SirMjUHK2h
 vrtwqBWKQ9WZmcytiD/XbBYfVpDWr4CWa6amz+Cdmg8JWr9xVz4MTCQZE/3jeklDXdp/V1FenBN
 wt8gIYKmX1ss75n8QsqDmq8AoQIj9icGtNrtv4Vk=
X-Received: by 2002:a05:600c:3b03:b0:471:6f4:602a with SMTP id
 5b1f17b1804b1-471179068f6mr108892115e9.23.1761024278487; 
 Mon, 20 Oct 2025 22:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA2s1nyuReeT/w2o4rXP69ituqnQ6yQ/SS/vk9FmdcWbYCMQxpNlTa5j7gQVbHlkDA90ISzg==
X-Received: by 2002:a05:600c:3b03:b0:471:6f4:602a with SMTP id
 5b1f17b1804b1-471179068f6mr108891935e9.23.1761024278130; 
 Mon, 20 Oct 2025 22:24:38 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-081.pools.arcor-ip.net.
 [47.64.113.81]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-474975af467sm16437135e9.10.2025.10.20.22.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 22:24:37 -0700 (PDT)
Message-ID: <2e2edaf1-cbba-41cf-9121-10629ecabd64@redhat.com>
Date: Tue, 21 Oct 2025 07:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] pc-bios/s390-ccw: Introduce CLP Architecture
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-4-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251020162023.3649165-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Call Logical Processor (CLP) Architecture is used for managing PCI functions on
> s390x. Define and include the structures and routines needed to interact with
> PCI devices during IPL.
> 
> Headers in ~/qemu/include/hw are not normally visible and must be included
> using a relative path.

That's kind of ugly. Could we move the header (or at least the structs that 
you need) into include/hw/s390x/ipl/ instead? IMHO it should be ok to 
include "include/hw/s390x/ipl/s390-pci-bus.h" from hw/s390x/s390-pci-vfio.c, 
but if you mind the "ipl" here, we could also keep a stub header in 
include/hw/s390x/s390-pci-bus.h that itself simply includes 
"ipl/s390-pci-bus.h" ? Or something similar?

  Thomas


