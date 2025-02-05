Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27BDC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 07:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfZSy-0002TW-37; Wed, 05 Feb 2025 02:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfZSw-0002S6-7u
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 02:04:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfZSt-00057p-UW
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 02:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738739091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6bxMKlhHffjQTz89EOv0EvsYh8Ft91YDlOBEi51wUEk=;
 b=DfzdParSWZjm0mrFOQBvc4cRPvZ26c0jXr4oms83d2uMhViBvzPVJeB3BZXb15Vq2d/J2t
 HcgfOwgJsLnZKxgDfZGU/YP1Pi174XqP8Vw38Tyv6UWITwiuh/A0xyWjjQY9tyUQt9b7Qo
 S33mefYHXsVqTrU2SAk+yHg4SYKbyQs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-RJwMIxF6N_iNEtpuhNPgVA-1; Wed, 05 Feb 2025 02:04:49 -0500
X-MC-Unique: RJwMIxF6N_iNEtpuhNPgVA-1
X-Mimecast-MFC-AGG-ID: RJwMIxF6N_iNEtpuhNPgVA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa68fd5393cso56715366b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 23:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738739088; x=1739343888;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bxMKlhHffjQTz89EOv0EvsYh8Ft91YDlOBEi51wUEk=;
 b=coJJPF362T51YVfO6dfDKWAAPyby9t14VmMmlMBz4Dn9AKgKCV//DZ0ncs4E/B1K9s
 7MIVne6dWrSi+erdHzs14oN9adl6M8lw7u4xGPVyMBPfGS4UUsHwSO+jGgheWRb9tJ4Y
 Mj/Wz9fNu/6jdvyxXYr6/0tL4jWC3y4R+dPlmUTP9F8/QmrUiicDiOTDTXX3Hu4EGkWR
 DK8p+ItRn/8F8IUYxlpXPQ/u3yow5cGUx/Pys6uRyBOUbSHBvVbN3RcxdpazRluREieH
 ceD4nCwqksW2lUYe94XZ3AHhA8+Y2HSzsLp/NCkp/DSzUfT/OgiofiA9sC7zRLHqf4o6
 fV0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcYBKf1aJM8G50oOhpx4CKIZiUasvK4MKYXr4nvUMUsoEwOavBX95MlZniCW/iJ1L1E0zCMbF0kilj@nongnu.org
X-Gm-Message-State: AOJu0Yzb5XwtiWMS6QX0n66SgsQVAMCYYrtwhThbiECbLBEt/abmanx8
 lw7leJ00k20GtPcH9DWop4cS91gKxUKD2+csxHMo4a7JkaVA2QvVMFl6Hzih8E1sVUTqJgTB33q
 GFselazV/Oy9LpZX3zNDdzyNluqmoOswpD+lK9yGK5js+VeJta5NV
X-Gm-Gg: ASbGncviHHDK7Z4ZnHKt2pm7siprX4dQluXcuiAwuxF+d5GdotAu2iCCMkpTMNbEqRL
 Jbi5aUzmGF57BkxqwIQ9uSbx0LjQxTpoNAjBwlEPW80lRn++9O4m+tH07yETGKQEFboy7puoSlB
 88ZLVNvTPftrKfRacGgfCeldE6X8WBHrguL9w2CzFhC1SCy0BbpO+1lfU/kZ2xvS8PNCSLgkFXc
 cJH0QA896v0Nwei+t2Bnmsjz8ic2wB0p+Ml2gtYy3lUxci/upEuyrxycbZUQ/7IFyDwwyAQN6Ui
 pnU7pqThuCOzrNgzpG6eQe1PHSl+9egaVvVx
X-Received: by 2002:a17:906:c14c:b0:ab6:f59c:661d with SMTP id
 a640c23a62f3a-ab75d2a8beamr156192466b.17.1738739088158; 
 Tue, 04 Feb 2025 23:04:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3GEnO8DzvexngW8Q3uAyrAv6dVmutfzZP860x1jBokQtqO4JT5CmhJywht//yq9R7c/3XWA==
X-Received: by 2002:a17:906:c14c:b0:ab6:f59c:661d with SMTP id
 a640c23a62f3a-ab75d2a8beamr156190466b.17.1738739087776; 
 Tue, 04 Feb 2025 23:04:47 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a7e7asm1053735466b.18.2025.02.04.23.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 23:04:47 -0800 (PST)
Message-ID: <c3fe91f8-4a4f-41cc-aacc-d76ea33ade52@redhat.com>
Date: Wed, 5 Feb 2025 08:04:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] hw/boards: Rename no_sdcard -> auto_create_sdcard
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250204200934.65279-1-philmd@linaro.org>
 <20250204200934.65279-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250204200934.65279-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/02/2025 21.09, Philippe Mathieu-Daudé wrote:
> Invert the 'no_sdcard' logic, renaming it as the more explicit
> "auto_create_sdcard". Machines are supposed to create a SD Card
> drive when this flag is set. In many cases it doesn't make much
> sense (as boards don't expose SD Card host controller), but this
> is patch only aims to expose that nonsense; so no logical change
> intended (mechanical patch using gsed).
> 
> Most of the changes are:
> 
>    -    mc->no_sdcard = ON_OFF_AUTO_OFF;
>    +    mc->auto_create_sdcard = true;
> 
> Except in
>   . hw/core/null-machine.c
>   . hw/arm/xilinx_zynq.c
>   . hw/s390x/s390-virtio-ccw.c
> where the disabled option is manually removed (since default):
> 
>    -    mc->no_sdcard = ON_OFF_AUTO_ON;
>    +    mc->auto_create_sdcard = false;

You might want to remove that "+" line now, since you remove the setting now 
instead of setting it to "false"

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


