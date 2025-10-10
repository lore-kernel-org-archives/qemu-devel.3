Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB6ECCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Bs2-0004Jh-A5; Fri, 10 Oct 2025 08:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v7Brx-0004Ih-LM
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v7Brl-0001TZ-MU
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760097884;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKSizi7tiaCHNDood4BQ6JOusijP44Auo1ckf5Jjulo=;
 b=Yq1Xjovm9gZyYWhZAByRXldDy1OTi5PcLIYvyK5qiwacTeDLcxmG1Mk7S50rg9yF194PgI
 g7YcKt3C6uMlDwBLA/3OZAcupuJb/wCDXQ5epx1nkm2FAm1pa6dhRiglax9qCEiuy12MGC
 KZV9eWazrYIx6kytMdBM2zKhLsB2yhc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-PttJyYlUOj-LePEONKx_OQ-1; Fri, 10 Oct 2025 08:04:43 -0400
X-MC-Unique: PttJyYlUOj-LePEONKx_OQ-1
X-Mimecast-MFC-AGG-ID: PttJyYlUOj-LePEONKx_OQ_1760097882
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e44b9779eso10470295e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 05:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760097882; x=1760702682;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKSizi7tiaCHNDood4BQ6JOusijP44Auo1ckf5Jjulo=;
 b=O38jCwYkMMs2+JMgDhxn+i5IjCxQbydwD4l5eVY6vwqRv2G5OCTsAY90vnJbo+KkyO
 ZG0GFfUZ4UqSZBE5c0RuyjZW60njo5G54ZmYTn0VbkUxn0meukugi8URVODV2hio5u+H
 l8S3S4ByKvVcNrOX4jZi2NOk1QpWx7R9cn6VHakZZfI/WiEwsH8a+rulg3rRlcE3m3Wk
 w1v9gJaCmzhAMFsLB8YVtR6B+YAv4ZNfoVNHQW+sfV2ewAMx7AlMwolg6P1QjlBVtYud
 XGmaBTRbOhLlByFZbZWAytqhcxvauIP48r7RIiMnrBq/jIbG7aIo/25pNh8FmmMWD4wa
 jJEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKJFD+UlMXHlPt+yf316Zf5SAtqWT3jgZ7x0quI5HvIUcAwH5iH8z2N8JtMvixQajlD3gc/pq5kFxw@nongnu.org
X-Gm-Message-State: AOJu0YzG1fmkJ4ZtP7iL2Cm7pmQ2/OP5PUBXOCOONoV9nLva4e4BKsqn
 WRTm1iJ70VL/4biCDmQrwjIVlJ4+vSYsFULYztnVtvCfP4AFrdeqfwznP4UBPMEQtO77JM6vXsj
 IH4eDQPFwklct5I2TKqksdP4RIVxzm6i0MXlxFt4bDNK/gvFDlhcP01gy3RNlkKfn
X-Gm-Gg: ASbGncsN66Fx1K0jEuMyEvJwifjpHKSk4kzUHd3tfo07gtqbzOxEQC65gqoQr/3kyJd
 ol37+IqhoLn86PbNPsf6UbJk+cJFXAmdyUUHgIDBhs8qCDR0fsEKCTzOi3H135jDi0h6MCVqyNR
 t//1mj1MnvnDSEZsdaXeh1ZmhX6XuB5GJ/giW5dFu3vDJwVdOrMQQ85OUYjhe9lC59aGB761NK5
 erP9CR/b1/3iddKXpp85+tK51CN1nnEZOtivXnn1dExAmvajT1YbR+DoWYn/PdG285dCvV5SBOx
 RgDZrOHMU8N1yj75aveKx8hQUlvjfI5UiSrkAAyTiQc06008ge/l/IkEln8UMNrRH7xj85n/jUr
 dl0LmilkMb9s=
X-Received: by 2002:a05:600d:41f2:b0:46e:456e:ada5 with SMTP id
 5b1f17b1804b1-46fa9b01934mr76056195e9.28.1760097881596; 
 Fri, 10 Oct 2025 05:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTQI/jGxU8MChs15Sh7bQPs7KChD7qHUEgJoKVuXP9oL91yT0tNE8qM6VzPKylUlVsz76sbQ==
X-Received: by 2002:a05:600d:41f2:b0:46e:456e:ada5 with SMTP id
 5b1f17b1804b1-46fa9b01934mr76055945e9.28.1760097881169; 
 Fri, 10 Oct 2025 05:04:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489ad27sm44666975e9.15.2025.10.10.05.04.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 05:04:40 -0700 (PDT)
Message-ID: <3400cbc1-320d-4ddc-9172-21c3be89e32b@redhat.com>
Date: Fri, 10 Oct 2025 14:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Did the latest QEMU emulated SMMUv3 not support "smmu sva"
 function ?
Content-Language: en-US
To: tugouxp <13824125580@163.com>, qemu-devel@nongnu.org
References: <202836e9.238.199cb6c9c1f.Coremail.13824125580@163.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <202836e9.238.199cb6c9c1f.Coremail.13824125580@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 10/10/25 2:01 AM, tugouxp wrote:
> Hi folks:
>   i start my aacrh64 qemu platforms with command:
> "qemu-system-aarch64 -m 512M -smp 4 -cpu cortex-a57 -machine
> virt,*iommu=smmuv3* -kernel arch/arm64/boot/Image -append
> "rdinit=/linuxrc nokaslr console=ttyAMA0 loglevel=8" -nographic"
> and found it does not work normally with MULT substream(PASID), after
> review the qemu smmuv3.c i made some discovery,  the smmu IDR1
> register  SSIDSIZE did not initialized for the default value of
> emulated "SSIDSIZE" in SMMU IDR1 is 0, which means only support one
> sub stream(pasid), so that is why does not work.
I confirm PASIDs are not yet supported by the vSMMU.
>
> so here i want to get a information is that, did the latest qemu did
> not support SVA mechanis about IOMMU ? and did all the others platfrom
> like arm on this function?  thanks for your kindly help.
vSVA is not yet supported either. This is under work in [PATCH v4 00/27]
hw/arm/virt: Add support for user-creatable accelerated SMMUv3

Thanks

Eric

>
>  
> BRs
> zlcao


