Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8708CD3F09D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVHP-0000eB-9H; Thu, 29 Jan 2026 11:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlVHN-0000dC-Ef
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlVHL-0007yH-0d
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769705637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UVWfUPLG4iHfbq14wI3hLHni87VXLqU3kNMP/cEhgfc=;
 b=iLhDJ1h2PRq93R+9tUDafIl7BRIxcMRaw5NBd1mRTzjRXsoBu1uz7OFXJn+PWhTNr/eyBO
 LHzy8hjbKCf24A9azrKRcBN8UonZW6KPDbcsUVTwF+59+2pADtdPSmZhwi941akghbeFwM
 Z15dflEQiqIOsRmWg5oYj1jUJrQA5gw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-MxDVFQAYOUKF3XJ5RMjo_Q-1; Thu, 29 Jan 2026 11:53:55 -0500
X-MC-Unique: MxDVFQAYOUKF3XJ5RMjo_Q-1
X-Mimecast-MFC-AGG-ID: MxDVFQAYOUKF3XJ5RMjo_Q_1769705634
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430f57cd2caso1160949f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769705634; x=1770310434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UVWfUPLG4iHfbq14wI3hLHni87VXLqU3kNMP/cEhgfc=;
 b=rrh//MPq6my1qdjXuLmPtTXT1DUEXGjYSr0scba4i59VCczomVWkZtbWMwKeROnnAq
 jtRHHVrspCNecfdKPPsY0ZTVV4zqHdcK7xEjYxLKRQSspNRKkF1CWMu/E1VwizboEmfJ
 ORUx7pf0Rb2QZlisfFct5/UId3Rd4WjQrB21NDDXw+LaK8n9LG5l5PTi1+AnfxiKj+qp
 VkD4QDUUg7KmyPUBtdnBqnvLx/ljn1MCTJEDj7TsNYYxzW6QNf11pbA+n+vm/afZkQm5
 5pAtdO28tynHdGPzq1OYLaF7TAHEOVBur8fyY765OlF84Y/fMeMPaqeqRDSWfd2flsKw
 Tm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769705634; x=1770310434;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVWfUPLG4iHfbq14wI3hLHni87VXLqU3kNMP/cEhgfc=;
 b=I+vPO5YFeQ4zwhCj7PHO8vY3iTEU5PnE4gNiN8892Dt9Kq2tLB4oHSdigzfyMn8VlL
 kNm/deTxZedSyjKLILqsCccy2pOjxAekvoBeFp6waQDpiThcah5Le6EgEaoTgpu2BilT
 oV7vFw3plVwcAIQOf+x8UV9yDqqfDykJjPuCE6PEEZaJAvIJEAY2oWTNKqfUccibOygm
 NyvPBDwkeGpyt67fzL470o0OA3CHexSY7tsfM4BLn3EEcsTbeRfCusEMIN8J7ZLWDwit
 HmMLV4NEptu4l0fdJBAtGyBxxiA/kf8dfyK7gBQq044Nd5h2tFc2zg4mmQeLyCeDWq4I
 eA2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1mNyPb6UVpoM2fmuV5WnpVqsM4eUyxoZc6QlQKp+GbvpniudsRxs6YC0Lnks55o+WR5h/3TeFrPqm@nongnu.org
X-Gm-Message-State: AOJu0YzqDZruVDwU3gpl4m9qtm1tA3xCzXuIt6ciFzrcgksQBR08Y+iK
 kC00UGmHEFsCHfST9Na0mgP3fXXfoIr90o2e2yR83rs9VtJlqvyxJayJMt1nrGDoBCvfyDUVCsb
 t/fUHVwtYGkGdv0qZMieGj5/zvxiHoB+w5OLPVvP5jtNqDxR4yDGDCqaU
X-Gm-Gg: AZuq6aI67oOhVk7l2XSmquvItIDHVbFZmvgdnVZ0eGj7ZYTnDooOzbh09N53PwtX3G4
 Be2s9Gt7RyH2mnaGNILkHpJ+7yuAya4gYOYeUs15YwQdtaNUbmDcU1ZJPZgSxp18ty8bwITzZu2
 NmaF5LT97Z6UvOIAqmc5jPgkwuf5o5pVARHTCsVAQS2Xo9CXL/OKA6IJpu4XABbxO1dhnXlxChT
 w9kHu4+1KqC58BtMtJveQ5s/uTnxtdMKLbBjAJQEt1jfmNSMH/c2tx1Dc2ineN72uDYxhRRWx1E
 vxFHYzy+ypGNVaeEQUlqKbUOTbC2are2vvcgpvAJunsTiNXCmK7Eqwys9uYO9i1Zi3UadHxPMmx
 TulBhdu8=
X-Received: by 2002:a05:600c:c16b:b0:47d:264e:b35a with SMTP id
 5b1f17b1804b1-48069c1a85bmr107516115e9.13.1769705634296; 
 Thu, 29 Jan 2026 08:53:54 -0800 (PST)
X-Received: by 2002:a05:600c:c16b:b0:47d:264e:b35a with SMTP id
 5b1f17b1804b1-48069c1a85bmr107515875e9.13.1769705633929; 
 Thu, 29 Jan 2026 08:53:53 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfd4sm14985513f8f.25.2026.01.29.08.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 08:53:53 -0800 (PST)
Message-ID: <662393de-bb4f-4b82-b67b-feba94b24ee6@redhat.com>
Date: Thu, 29 Jan 2026 17:53:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] pc-bios/s390-ccw: Introduce virtio-pci functions
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-11-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260127161547.459443-11-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/01/2026 17.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Define common functionality for interacting with virtio-pci devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> +/* virtio spec v1.3 section 4.1.2.1 */
> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
> +{
> +    switch (device_id) {
> +    case 0x1001:

When using modern-only mode for a virtio-block device ("-device 
virtio-blk-pci,disable-legacy=on,..."), the virtio-block device should come 
up with a different device ID, I think it's 0x1042 ... shouldn't this get 
added here, too?

> +/*
> + * Wrappers to byte swap common data sizes then write
> + */
> +int vpci_write_byte(uint64_t offset, uint8_t pcias, uint8_t data)
> +{
> +    return pci_write(virtio_get_device()->pci_fh, offset, pcias, (uint64_t) data, 1);
> +}

I'm a little bit torn ... would it be nicer to have a "VDev *vdev" as a 
parameter for these functions, so we don't have this hidden state via 
virtio_get_device() here? ... OTOH, that makes the calling functions a 
little bit more clunky ... does anybody else got an opinion on this?

  Thomas


