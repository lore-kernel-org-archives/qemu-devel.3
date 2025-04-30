Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20083C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA4lj-0003gp-2S; Wed, 30 Apr 2025 06:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA4le-0003g5-7Y
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA4lb-0003Lq-7P
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746009254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wzQqzAPm/ZK3fZ9jfW+FDF2eyY6/t84RIqaPtgALW/k=;
 b=b28TgC5SbOPhH+Ey4hxkUXZebNxa/UsbmeS+01QKqLHbxyLkbEATM7QYXhmS2q7tHPC0Cd
 FuDc0zdxPo4VSTOnUn6KjPmwo/2LMce4bwaR7iu7bztbNkmWsoaoURTA3foL+R9Qwlf7cB
 YB54oU6OnqAZrPBgoewi0JNt5JCb/Go=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-eE7bcSEjP_ezG1Jijgeikw-1; Wed, 30 Apr 2025 06:34:12 -0400
X-MC-Unique: eE7bcSEjP_ezG1Jijgeikw-1
X-Mimecast-MFC-AGG-ID: eE7bcSEjP_ezG1Jijgeikw_1746009251
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39ee57e254aso3396880f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 03:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746009251; x=1746614051;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wzQqzAPm/ZK3fZ9jfW+FDF2eyY6/t84RIqaPtgALW/k=;
 b=EFKyOhHtKFUfelebX/LRJp2d4pNn5kKv6ajti+o0TuMe3w2OrEyf3Q9RBZGkgeMgew
 U3ttix5meHGVwp+WdcWowOnLezoRtUNbZI9WfcSMQtOEA8aWpetEMG3lzHMCmHoDr5QF
 j6mrS/j42/cDrfQj6BGUntDgEHVXfRGaWqBBDMezoQrgbQBoY+AauAhmOq5XE4rCwSgp
 Z5hIC2qiANZ6o1083Ma3Pt8tgWfCkiXBON76Gb/UZi1Yscdw8puo6oYlJhasVzvTkViQ
 stMW8JZmJ0/JLC0eF2G/iA9rP8iIuqSfr6nUxKE13eDlhsWUjH32bGCNxrLz18CB60Rv
 /ZVA==
X-Gm-Message-State: AOJu0Yy21BNmjjIVrNAnt9jdtBFsFcvVuV+2gKfr3+AkYU0ypbZDCpxe
 oqgNmjKqh81+tA7jD2K7N99oijcJKjEz+lFhK2QybixmoG0I95poeO3fjgx2jvpyOimOel2nxOr
 crt7g3EWb7W7yze2Ft5oWGh1YN1sKBTOgibY4B6C2g8oRUUsHTcDGVSdPrg9T
X-Gm-Gg: ASbGncvgHINwQ8VfZrJev6EABXjiRXGQTGKUY/7+NUHZ7RUgAaZSl01O2pFyct3Qhva
 NyffVmwLMTBQINULqusWzCubBfHgoRNpKKaqorm4vNxddrEFBFeH2xS7Ic/H66SJDPErBvRATQB
 Yr8KNFu/kGn/gcECCQIlAhroRvmFsEsoJuLv8soGI4WViMZBPDHH7xmoKIPbwETj3wcUzexj45c
 rg8rzONaBdnreAVouH4ngbFIEHS9lYTkwOh7dS3QmqGJllAb+sUWU8V8cFmrOrbgIaGUh9bahFp
 YvzF4JNoJ0Y+eQsuqI6oSIcm8/H+BHs3K+ill/52
X-Received: by 2002:a05:6000:4310:b0:3a0:7aa3:cc74 with SMTP id
 ffacd0b85a97d-3a08f75250dmr2343751f8f.6.1746009251217; 
 Wed, 30 Apr 2025 03:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLWctRPHkoDOdbdwYs57wYjYZCGlqnE/Qy9pGNeNzE7CSDHp3eLqOMlKKGodoGCu+QvDDSjg==
X-Received: by 2002:a05:6000:4310:b0:3a0:7aa3:cc74 with SMTP id
 ffacd0b85a97d-3a08f75250dmr2343723f8f.6.1746009250908; 
 Wed, 30 Apr 2025 03:34:10 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e4641csm16462598f8f.80.2025.04.30.03.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 03:34:10 -0700 (PDT)
Message-ID: <17ad2f31-dadb-4b36-b663-7736ac6c1cfe@redhat.com>
Date: Wed, 30 Apr 2025 12:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] hw/s390x: add Control-Program Identification to QOM
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-3-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250410150934.1331433-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/04/2025 17.09, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification data to the QEMU Object
> Model (QOM), along with the timestamp in which the data was received.
...
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index 13589459b1..dcc8bd3245 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -18,7 +18,10 @@
>     */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/timer.h"
>   #include "hw/s390x/event-facility.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "qapi/qapi-visit-machine.h"
>   
>   typedef struct Data {
>       uint8_t id_format;
> @@ -58,11 +61,39 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
>   {
>       ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, ControlProgramIdMsg,
>                                                ebh);
> +    SCLPEventCPI *e = SCLP_EVENT_CPI(event);
> +
> +    ascii_put(e->cpi.system_type, (char *)cpim->data.system_type, 8);
> +    ascii_put(e->cpi.system_name, (char *)cpim->data.system_name, 8);
> +    ascii_put(e->cpi.sysplex_name, (char *)cpim->data.sysplex_name, 8);

Would it be possible to use sizeof() instead of hard-coding "8" here?

  Thanks,
   Thomas



