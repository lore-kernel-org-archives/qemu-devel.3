Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA620CF0454
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 11:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syUi8-0000Uw-AA; Wed, 09 Oct 2024 07:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1syUi6-0000Ub-QH
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 07:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1syUi3-00033L-8I
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 07:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728472705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JB8THYf1tlY9wjb3bOBVwz4hCFhDk6fK4oosycaFrV4=;
 b=E1OIkW41PWruDTY/vJnhl7k5M89TtwdtvE4cvMGh9MU+deFHE53S7FzgaTZL94ka1Oy7LY
 fckFQ0ZdUndrXgw/kcTRUKKJyI1uRRD35fWZiimFgizm3DlDlHgR+Vlu8BFmZqrdQazTAZ
 /A5zZCuNdXpnacN3CrcNLjTot0h4Iuw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-A4ROrBs-MVieRZrNegX_hg-1; Wed, 09 Oct 2024 07:18:24 -0400
X-MC-Unique: A4ROrBs-MVieRZrNegX_hg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2fad296738fso47217571fa.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 04:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728472703; x=1729077503;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JB8THYf1tlY9wjb3bOBVwz4hCFhDk6fK4oosycaFrV4=;
 b=NmlTIHmpaTEscu9fGj9fm97JfSJ4qDIouAgorxtiJ6wI4hvwPowli/3AoQXZuGfdu+
 sOjQLQhXw+dfKWy2Xr/I8vULKcM/AGjK2KC9Gc8CxY7rz1/XPWAg+Q9t22feK1rGZ5rz
 Jlt35kOSh9LGgNRwdMExudK1Xw2cMg89Co/FX4HqaU71dViHPhLKDJExEuE8vbtDvYlE
 /edycmbteDhdPEDcEXA7aNDVNbox2wlmHaXk3uB5bDMPLT94SympExahBCBQcWFNaIeG
 cMZKA8XdNAGO5ga0nT1qkXZbZSzHdNMZQ9/WNxb1GeRni49zZ0DuAVWrI6FxIPXk06rK
 cA6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC2/UqEINtxHrLzuwiWFNRnA+UNKn9O5U5kbibDNrmd4MpJSEUyEtleUuhKYAyvR2QCNTwG+o3cc/Y@nongnu.org
X-Gm-Message-State: AOJu0YwtTTji73Xu+JbYHNd/TGjnbrqcqjyLd66RxCNUKTpRc85Elh4i
 F3CoHlYP432gVvelwOLq5wXpCxHyEYElKMAsEcoSlsmkv1IkLPPiUdT654MfJvrk9oUuw2kzLDu
 RPO9+SOFgpSFT7axrIev0ZLIjd3J//1CsPSvFTWmwXXGR9rGrNk69
X-Received: by 2002:a05:6512:68e:b0:539:88ae:ded6 with SMTP id
 2adb3069b0e04-539c48e1f94mr1260022e87.35.1728472702538; 
 Wed, 09 Oct 2024 04:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWIQjEv2wkIRZxGBLP/2sgxOTCPSksLRCfeOxroQZ2vhYJJsWO6wz3bhgd/2sxuSdalUiEDA==
X-Received: by 2002:a05:6512:68e:b0:539:88ae:ded6 with SMTP id
 2adb3069b0e04-539c48e1f94mr1259991e87.35.1728472702021; 
 Wed, 09 Oct 2024 04:18:22 -0700 (PDT)
Received: from [10.33.192.239] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4304efc1cd3sm26845485e9.1.2024.10.09.04.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 04:18:21 -0700 (PDT)
Message-ID: <911b4020-c60e-4a74-a61d-3ce370a3a878@redhat.com>
Date: Wed, 9 Oct 2024 13:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/19] pc-bios/s390-ccw: Remove panics from SCSI IPL
 path
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-10-jrossi@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241008011552.2645520-10-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/10/2024 03.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Remove panic-on-error from virtio-scsi IPL specific functions so that error
> recovery may be possible in the future.
> 
> Functions that would previously panic now provide a return code.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> @@ -78,24 +84,30 @@ static void prepare_request(VDev *vdev, const void *cdb, int cdb_size,
>       }
>   }
>   
> -static inline void vs_io_assert(bool term, const char *msg)
> +static inline bool vs_io_assert(bool term, const char *msg)
>   {
> -    if (!term) {
> -        virtio_scsi_verify_response(&resp, msg);
> +    if (!term && !virtio_scsi_verify_response(&resp, msg)) {
> +        return false;
>       }
> +
> +    return true;
>   }
>   
> -static void vs_run(const char *title, VirtioCmd *cmd, VDev *vdev,
> +static int vs_run(const char *title, VirtioCmd *cmd, VDev *vdev,
>                      const void *cdb, int cdb_size,
>                      void *data, uint32_t data_size)
>   {
>       prepare_request(vdev, cdb, cdb_size, data, data_size);
> -    vs_io_assert(virtio_run(vdev, VR_REQUEST, cmd) == 0, title);
> +    if (!vs_io_assert(virtio_run(vdev, VR_REQUEST, cmd) == 0, title)) {
> +        puts(title);

Should there be a "return" with a non-0 value here? ...

> +    }
> +
> +    return 0;
>   }
>   
>   /* SCSI protocol implementation routines */
>   
> -static bool scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
> +static int scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
>                            void *data, uint32_t data_size)
>   {
>       ScsiCdbInquiry cdb = {
> @@ -110,12 +122,13 @@ static bool scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
>           { data, data_size, VRING_DESC_F_WRITE },
>       };
>   
> -    vs_run("inquiry", inquiry, vdev, &cdb, sizeof(cdb), data, data_size);
> +    int cc = vs_run("inquiry", inquiry,
> +            vdev, &cdb, sizeof(cdb), data, data_size);

... since the caller site now obviously checks for a non-zero value!

> -    return virtio_scsi_response_ok(&resp);
> +    return cc ? cc : virtio_scsi_response_ok(&resp);
>   }
...
> @@ -207,7 +221,7 @@ static int virtio_scsi_locate_device(VDev *vdev)
>       static uint8_t data[16 + 8 * 63];
>       ScsiLunReport *r = (void *) data;
>       ScsiDevice *sdev = vdev->scsi_device;
> -    int i, luns;
> +    int i, cc, luns;
>   
>       /* QEMU has hardcoded channel #0 in many places.
>        * If this hardcoded value is ever changed, we'll need to add code for
> @@ -233,13 +247,21 @@ static int virtio_scsi_locate_device(VDev *vdev)
>           sdev->channel = channel;
>           sdev->target = target;
>           sdev->lun = 0;          /* LUN has to be 0 for REPORT LUNS */
> -        if (!scsi_report_luns(vdev, data, sizeof(data))) {
> +        cc = scsi_report_luns(vdev, data, sizeof(data));
> +        if (cc < 0) {
> +            return cc;
> +        }

By the way, calling a variable "cc" reminds me of the CC of the PSW, so I'd 
expect values from 0 to 3 for this variable. Obviously this was meant to 
convey negative error codes instead, so I'd like to suggest to rename that 
variable to "ret" or something similar instead.

> +        else if (cc == 0) {
>               if (resp.response == VIRTIO_SCSI_S_BAD_TARGET) {
>                   continue;
>               }
>               printf("target 0x%X", target);
> -            virtio_scsi_verify_response(&resp, "SCSI cannot report LUNs");
> +            if (!virtio_scsi_verify_response(&resp, "SCSI cannot report LUNs")) {
> +                return -EIO;
> +            }
>           }

  Thomas


