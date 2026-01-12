Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644D2C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJBT-00016x-S5; Mon, 12 Jan 2026 09:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfJAj-0000tN-Iv
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfJAh-0008P5-35
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768229129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pBMfyCaVBGxKeL1jNQCVtSpveh/biXj+sq4KQ9Z42vI=;
 b=Z3fTWHAyidcvcBesfzzSV/zCJ7QyB9xlb8GCZ3zz0hC3cBjSwL5VOAnTI3HVCH8CWSgl38
 tl9PykUBRXg+0f27sXy0j0wITYsVeQFI/UzV1gQaE4diEcS9l+6pHcpX6kTCid1o9rNtqD
 RXJlEKkDkp3asoFVEENpsgTsaQ1VOaM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-MztleB3tOyeYGKbFeE4MnA-1; Mon, 12 Jan 2026 09:45:27 -0500
X-MC-Unique: MztleB3tOyeYGKbFeE4MnA-1
X-Mimecast-MFC-AGG-ID: MztleB3tOyeYGKbFeE4MnA_1768229126
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d3c4468d8so41864835e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768229126; x=1768833926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pBMfyCaVBGxKeL1jNQCVtSpveh/biXj+sq4KQ9Z42vI=;
 b=VGcEVDWNy/xy/Q8ctZ+sa5EoG6JirinqvK3dYxfeACTKB8Ogf0lriGNkK0ZS6xvopy
 A/DvHvI2D79DwPa6gCtofMPAhkhpKqriEB8VwVmuC0x32Qc+W4tnVNFwpvKMDsaXSx0T
 Y79x+Opn5amSbcrDuIrYu5+hh8R9BQmSY51xOZAndeQxheoCyW2xll2kX5J1O5qFwFXM
 7NQTlp/GwqAVUWIyecHgiadVBxPV0jSWmRw9I2vpk2dFObEM8AHQNpeB9cDdCxF+BuYk
 TLL5hum27Uo7WIoSuf++ZIXk1aBTA+Wc7WqCZzsGD1jPziT4wMT6KfL3H1b2UEgxoqOQ
 OTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229126; x=1768833926;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBMfyCaVBGxKeL1jNQCVtSpveh/biXj+sq4KQ9Z42vI=;
 b=jDhRyou/JB3nwo4ClkuD53BhDB4CrKjFLsoXJjKIhVC+QcaWE4UGghljT0WLexa8JV
 TSBYCkESNSJIgtXWD8Ga5a698Su+f4NkPjSvzp8xNzJ42fWb5ly31lySO8/hPyHCK7J+
 VIDKpKn9Y5YMhMvWLhO6gElAAPagge7nKc6JBJDxgKLDajKIVFtA/SFG1Pq3oPRZKkmz
 90Y/KrUtBh5hAd7h8vhDkaGHaE4b7ccdr6xdyLU7XFchVV2dmF/iMRClDCDxxCqJD2+s
 QHpWdUd2snRP3WvGMK8NitEEi0tLPXwIj5GMJNA5Oh3BtQzjhcioEVXuLKCti9A3iFPv
 jq/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjK/zguTlwyli1tlsve2xlyJVVf1irRgu9JO6XqLqjI913XNFFUDw+0hRT5wyBB+YLQ8BQTyCMAiFo@nongnu.org
X-Gm-Message-State: AOJu0YyoE+SO+WLLa8gMWTWTuf6KUSimwKU9ROgu6/W/p73/LjBmgEjR
 1lI5/qkAt31jOB3rSa14zU3TQUJ8G3YT8huQNMI41qKzgKVbfsmSM41UWbLHvm27QrV43i5h8hi
 mvUoS5qKGTWqmDWNF9v+htN19/NGEsuip2afbCXrG+HCg7PR1LJsyLjF5
X-Gm-Gg: AY/fxX7HyjUU6FE7W63BKdUSCBfzFz6TkSDNMjNqFwbcvkZ5+OAYkRRjoeHgGGyx5kY
 YarIzmK7uEg/tSeBDJEdA65JcvrnioHRHo1ZjMR74gQWqdBC5cE8fbZRMrDoFBuUb6u9AMYkupB
 2nmxoTxi443c31nUrShykqHcTA1BH5uMv/uGrXW0GGRM1g75mZqEl6gIo0cbJB3C+3D7lbBYxoJ
 S5KpMuYhkmsLRrD75TXeaFR5/GuLwWS4JTdKOvOvdkF/BIh2eoZMJGs9fDm4ibzxuoKRx5Z/Qn7
 AP515ESYy7jw6Ao16IxoXAWuick/ZI5kal4QmGljQjAL9eZhUmOMRWx5Eer4kHN+JvvTf4+Yl2s
 ksU0HlI0=
X-Received: by 2002:a05:600c:3483:b0:47d:6c69:bf28 with SMTP id
 5b1f17b1804b1-47d84b3476fmr209698845e9.24.1768229126068; 
 Mon, 12 Jan 2026 06:45:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdn45Eh3EcZrm7BMWQS8pPBDqgto7NuhvXo15FQ9/BbSXipFv6xFtvbz62fw1UOpGhcd5vQQ==
X-Received: by 2002:a05:600c:3483:b0:47d:6c69:bf28 with SMTP id
 5b1f17b1804b1-47d84b3476fmr209698465e9.24.1768229125656; 
 Mon, 12 Jan 2026 06:45:25 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f703a8csm353787575e9.13.2026.01.12.06.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 06:45:25 -0800 (PST)
Message-ID: <88bc91d3-2c57-4cd0-9dfb-6a994ebd9b46@redhat.com>
Date: Mon, 12 Jan 2026 15:45:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/29] Add secure-boot to s390-ccw-virtio machine type
 option
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-23-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-23-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Add secure-boot as a parameter of s390-ccw-virtio machine type option.
> 
> The `secure-boot=on|off` parameter is implemented to enable secure IPL.
> 
> By default, secure-boot is set to false if not specified in
> the command line.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/system/s390x/secure-ipl.rst   | 22 +++++++++++++++++-----
>   hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++++++
>   include/hw/s390x/s390-virtio-ccw.h |  1 +
>   qemu-options.hx                    |  6 +++++-
>   4 files changed, 45 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


