Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC48C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJ6L-0002zM-Fv; Tue, 06 May 2025 10:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCJ6J-0002zB-QT
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCJ6I-0006N6-3O
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746541008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AXkBzRUG1bhS6zBupdi8Toq+/mppEF77TJXVCdGi1RE=;
 b=Jw1+dNGZVEm9s3e3E+91t0ygx7pFU3HFORYSWkeZFOexzR/EAPMrku1btupS7Gm/iWTVwE
 mpYNmRRpLZTYMqAospL+CM1p1dCvLHWzXYnZBetnFGqIOKlVsB3T0sUI1BxuUwsHIaBvbF
 aDyuvjHsvE9QYYnTnx+VlZG6sGxM/1M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-AZ4BjjBzOLiFRCFO54kOcw-1; Tue, 06 May 2025 10:16:45 -0400
X-MC-Unique: AZ4BjjBzOLiFRCFO54kOcw-1
X-Mimecast-MFC-AGG-ID: AZ4BjjBzOLiFRCFO54kOcw_1746541004
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so17302465e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746541003; x=1747145803;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AXkBzRUG1bhS6zBupdi8Toq+/mppEF77TJXVCdGi1RE=;
 b=SAUEHUBJ2fdrzPy/FsJndUIYWuPLtOj65lVIoMrsbkktc4PMiWBBJmOU9AP+6LBtau
 g8KLRC4zteHg1ySJPXwxdwTcOcjJHuc/R1LrWSOjK5ThW+FssBOSdjWzimGibZZZ27IW
 MpIpM6Oenv6gSoPpMaQrj5ZvFDWLDfBTGOHFd/+XOsD/GYJW5O2G4L75/j/XabogSlvY
 y2nk5hlYZ7E6AjfGHL+TttE0m0gwWWaIdb6kHnB5Q0NjyjaKDYTj5w6x1B2R2JwKeDmm
 cs5Haop4x1JhiTE7SvJOKN30uGrneXPRi+WJqVwYEfj2mnKbDGYIzU5FG3+h1rmW0lRy
 dTUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK+XllKKVAK2z9V8tEEIxDs1pxYODbt3r/AJob8g9igPyxA2AVW6YJgSUFspDr86o3DSLd73Xxzzva@nongnu.org
X-Gm-Message-State: AOJu0YxlSpFzcUzp++zGFygRVbrl7fQcesP0uTYj2/PWsDRCBlmuX14h
 bc6up2opt4n/lkPyW26H3sLyxS2VZD/3y76p4ORW44NJ7lwupyAZq3oQTij0baSOLrVCvcG4gQg
 MBy+Khkeza1Y2rD6nxPCRKQMl+eAqMxXiYO+RfjKjyNEMLWx6IVmv
X-Gm-Gg: ASbGncu/iX3ULmJbVyaG8M3TGOvzhSmaqdj2QBgZhabr+Dgq1K7Xjr93nQ3QwQviZN2
 75XXCsUpA7VmBXrCQxvF8XMWnc/MMjQS6AGX6XjFtjtQ7LWwNhMgDxa8I9bPXyuCK7mxk98B1BD
 ZMqGmr4atzkpni67nIKYVXO0S1WaSdIWOpJDZ09tZ80xKh9NscNjFLVRh9xzXlKfa1+nbk0oFMY
 mgA/V7INzAzpyrK3KYQMtCPUP6ThUQqRgv8cjaT1Qp2qjlJd7H8Om4HrHC5HXptfZJZ1YgESwXY
 v7cFF2EBqW76nQHssJeASfUmhk9by/GaSUWi0/bN68AL9EjekrN4
X-Received: by 2002:a05:600c:1e1c:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-441d050a63emr33462395e9.2.1746541003635; 
 Tue, 06 May 2025 07:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMBl4TQoTImcbtrC3a79htexdiTyFAzYFLx0aKcCc/9HBpJG1E8JmvrXB/OMyZLHFNHqeCmg==
X-Received: by 2002:a05:600c:1e1c:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-441d050a63emr33461885e9.2.1746541003309; 
 Tue, 06 May 2025 07:16:43 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441bc264e2dsm150450775e9.12.2025.05.06.07.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:16:42 -0700 (PDT)
Message-ID: <67ceeed9-75e1-489d-a750-dcf1beac703f@redhat.com>
Date: Tue, 6 May 2025 16:16:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drop support for Python 3.8
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20250425120710.879518-1-thuth@redhat.com>
 <57f21448-79c1-4d46-9a8e-f9109eb67dcd@linaro.org>
 <87jz78b7fh.fsf@pond.sub.org>
 <5d0e0b69-cbbc-4fa4-a847-fdc8603a8122@redhat.com>
 <875ximdj2i.fsf@pond.sub.org>
 <CAFn=p-ZZgRg_A=nXOLGd=S8b2g9K3FNm-hqG1Rv1F=uy4PLqEQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-ZZgRg_A=nXOLGd=S8b2g9K3FNm-hqG1Rv1F=uy4PLqEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 06/05/2025 00.49, John Snow wrote:
...
> If there are no objections to moving to 3.9 as the minimum, I certainly 
> don't mind. Go right ahead and I'll clean up afterwards as part of my 
> "delint qapi" series in which I'd like to fix quite a few other things that 
> are currently wonky. In fact, moving to 3.9 as a minimum might make all of 
> that much easier for me and allow deeper cleanings.

  Hi John!

It has just been merged:

https://gitlab.com/qemu-project/qemu/-/commit/d64db833d6e3cbe9ea5f36342480f9

Do you want me to provide a patch for python-qemu-qmp, too, or will you 
handle it?

  Thomas


