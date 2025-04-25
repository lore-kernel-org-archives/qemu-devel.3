Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED894C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FGz-0001rK-21; Fri, 25 Apr 2025 05:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8FGw-0001qK-20
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8FGo-0007Kt-Ap
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745572964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DsRuvTUVTwnEUInjB2BrfHHnctFdRsvMZG3mqrQa8oM=;
 b=avGzhQPafzFc1+m34qQHq0cYIG/SwwgGNdyPlKk0hLr3BtYkx3CosTbS5WTgIzNtDlI5UT
 7kvZYa48e4f6DLxNwQizwI+btiKrR1JpUcCAVACGtzd0KVQ51wpU3NRXxED5+H/yP+o42G
 +1k1E4fzSj4dqPE2/gFU15IjWUGrm9g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-JzDBygBaOjW0C4A_GLH3Tw-1; Fri, 25 Apr 2025 05:22:41 -0400
X-MC-Unique: JzDBygBaOjW0C4A_GLH3Tw-1
X-Mimecast-MFC-AGG-ID: JzDBygBaOjW0C4A_GLH3Tw_1745572960
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so9528655e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745572960; x=1746177760;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DsRuvTUVTwnEUInjB2BrfHHnctFdRsvMZG3mqrQa8oM=;
 b=NnSHzLdjEo0PjfHIc+QCBtw5yx6cF00Uol+nnJNABvIz/oQMJTTsy8EKF9RJhEEhC5
 tzav65NwNYLvNIoV3oR1Mf5V3vJeWUX4ww3zZ/FBSIeQzAduU2F4jxqAM/wjL7ZjS3XD
 B0G6CJfe8iDqDzOfVdux/cnC4rOac5wwKy6U4s44Fq8pHejTtL5ocztl6fveF0yFbCVe
 rsl9P+TBSwaMFZdckZScJrguGKcyZPQwfVLqUUQ5hMyYJR0PKdUekHhn5ON4PAeHIfSN
 BW7e1PL7eM+dihp9I8hW8KA1ST2BUwhQ0ux2NhGhShCEfbCW9Sefv5HZTWs8XIcX9WM7
 aMrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdz+EI50Ldi+FTGuNWv378o4MV+Mwl/1ULDKXn5rTzCaLOhyo9FTQ3QynXV9MK498tmVer4SYmLMJ7@nongnu.org
X-Gm-Message-State: AOJu0YyE/izAhYZ/u4kZiXLik82qlm4jTsOge6hZdgaC4KyFulQdPK4/
 PPEhQFGpsanS7cihwa5XDtrz5JbWizxFhwPZ2vW+aatRimf6YEUiK1WsXPvcNX5wp68/5IGR0Zo
 VcbQsGHLh0zd0PR0rOCtxX9IMdfBJm8BYVm6ak3fuSt6G2vOBRreW
X-Gm-Gg: ASbGnct6oNTKkoTTA1AmaNXqA1MRU/AisnBTTkeZBpmnsyp/26tl//5hUgGCMgEh2VV
 88k5ddCci3VKfcSuN2IE58XqodgT2iNhwOE9qp/j4S/CmelC+EBwh7Og2fBBww3IWgvdMTcuflU
 mfj3OLrW+Ury+EhQKCZpU0S9dFO6m0PfoPzrep4QH2jcvfV8tI8MHnb/9DCZSDzYTW7P5t7xbu7
 VKQvNOvTO6ejspIi0K6SHQ2SJPE0XNWNHGoR4gYRvxgritWLp3HjeBmvLku2mtKAn0ejgTtpZCk
 yd1A3srdidLXXWo0jz4LJCMnj4XpHTD1Cd07Hdg9aFGasg==
X-Received: by 2002:a05:600c:3b92:b0:43b:cb12:ba6d with SMTP id
 5b1f17b1804b1-440a65ba1fdmr13920245e9.3.1745572960405; 
 Fri, 25 Apr 2025 02:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo65dsMFdWl2eqbGPkeP+bbTAWUliwkncWYoCy4ebK0jyBo/FsdgOyu+zfyGwRnJ2PKU+g5A==
X-Received: by 2002:a05:600c:3b92:b0:43b:cb12:ba6d with SMTP id
 5b1f17b1804b1-440a65ba1fdmr13920045e9.3.1745572960061; 
 Fri, 25 Apr 2025 02:22:40 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbedb9sm1764327f8f.44.2025.04.25.02.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 02:22:39 -0700 (PDT)
Message-ID: <a80e2c09-41c1-4c1b-9524-60ad5d2d038d@redhat.com>
Date: Fri, 25 Apr 2025 11:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] block/nvme: Use host PCI MMIO API
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <20250417173801.827-4-alifm@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250417173801.827-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On 17/04/2025 19.38, Farhan Ali wrote:
> Use the host PCI MMIO functions to read/write
> to NVMe registers, rather than directly accessing
> them.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   block/nvme.c | 41 +++++++++++++++++++++++------------------
>   1 file changed, 23 insertions(+), 18 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


