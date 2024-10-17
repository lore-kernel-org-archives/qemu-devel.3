Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73E9D21274
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 10:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1NkY-0004lr-9L; Thu, 17 Oct 2024 06:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1NkW-0004kx-Ac
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t1NkU-0005Lg-Fv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729160933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eZPT49uwzro4d7hZVMTy2uAd9TlkB0WrEjAdjNCx7Oc=;
 b=J4vMK1Uy8CN5VY7LpdSmTBXqOMt52osQlfcbEQehzajFXjUB+zG1y/YEfevybz3kdXGJYi
 0nlAUwGTV5S6ZNRqQizNBf/1H3FV2bxY4iXt80aHCKvMG+S3cEk6vvLirBB6ZOyZxjmVF+
 039d4WWKEozXUfcxqsi9CM2HIALTXI8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-OIgZOvWmPQCYXpYpWZ0nig-1; Thu, 17 Oct 2024 06:28:51 -0400
X-MC-Unique: OIgZOvWmPQCYXpYpWZ0nig-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43154a0886bso4959445e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 03:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729160930; x=1729765730;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eZPT49uwzro4d7hZVMTy2uAd9TlkB0WrEjAdjNCx7Oc=;
 b=sBUtgzIPMCrX1F6nkTMh0FZC+TcVoYx13BbgHFQLtfLEcynB6jOZhkqNbjHwHsL3mh
 E/p7Rfy7UJidy6CJv7ITJnleYMAvtwgcYCbjX8EJQsx3Rzb55cQBMBZojN0wiFwrESyC
 DbJoom4ZuIzCOSFv4ixGO7H44J54TbKS36+OezJCTq86N+w0gcbhu4eRA7+C5yZ2PBwy
 +FA2gCL0zQ/nVj9m1Gdss65x38Vq6cF8aJ+w343bQvSI3WY3E11GseHFUoT0qwcySk8A
 +3idXn8vcjj90pvsA8sJN3NjrGQn9HXuow6duc+oFd9VGWru0+sUVHCur5eDVHqBti2l
 F9HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfN+vXJVNtIpNCsBRhwuhzJpLubP0lQwtqUtbwwt24rihZB/9TEX6FVFNPrEvnoaKwvScPUukW83ID@nongnu.org
X-Gm-Message-State: AOJu0YwnkVEFUNfYr6bkms8SglAW0RyOtTZf/7/aB2YfmZY/PHunImOG
 /uSV+WUEmq4JYlxL+O3t02JPqs3aCUWIFduqfXmR83f57Mm3Dx0Ar23PI9Ddpnvd+kFOgVpmSbk
 K/W3VROXlQfTMS1wLfKkdm0tz4v9Y11RzEgZvthezFFRs8gmnlQV3
X-Received: by 2002:a05:600c:5492:b0:431:52a3:d9d9 with SMTP id
 5b1f17b1804b1-43152a3dbdamr38085315e9.0.1729160930580; 
 Thu, 17 Oct 2024 03:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC/D/5JnrQJu3ZnNnv+mnW3/gVtWcjW6Ub5OFQkdahljKFe/jKWA3K3KOXBEONJz6fyoqMhQ==
X-Received: by 2002:a05:600c:5492:b0:431:52a3:d9d9 with SMTP id
 5b1f17b1804b1-43152a3dbdamr38085135e9.0.1729160930022; 
 Thu, 17 Oct 2024 03:28:50 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c358c2sm21961455e9.6.2024.10.17.03.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 03:28:49 -0700 (PDT)
Message-ID: <d00d9e29-75a9-4355-98e0-b7c65e184691@redhat.com>
Date: Thu, 17 Oct 2024 12:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/19] pc-bios/s390-ccw: Remove panics from SCSI IPL
 path
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241017014748.829029-1-jrossi@linux.ibm.com>
 <20241017014748.829029-10-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241017014748.829029-10-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
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

On 17/10/2024 03.47, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Remove panic-on-error from virtio-scsi IPL specific functions so that error
> recovery may be possible in the future.
> 
> Functions that would previously panic now provide a return code.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/iplb.h          |   2 +
>   pc-bios/s390-ccw/bootmap.c       |  88 +++++++++++++-----
>   pc-bios/s390-ccw/jump2ipl.c      |   1 +
>   pc-bios/s390-ccw/main.c          |   2 +-
>   pc-bios/s390-ccw/virtio-blkdev.c |   4 +-
>   pc-bios/s390-ccw/virtio-scsi.c   | 147 +++++++++++++++++++++----------
>   6 files changed, 172 insertions(+), 72 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index 3758698468..639fa34919 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -94,6 +94,8 @@ struct QemuIplParameters {
>   typedef struct QemuIplParameters QemuIplParameters;
>   
>   extern QemuIplParameters qipl;
> +extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> +extern bool have_iplb;

Why do you move these to the header file now here? You don't seem to be 
using these in this patch? Should it be done in a later patch?

Also the "extern IplParameterBlock iplb" is already available in this header 
file, no need to add it again.

...
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
> index 6b4a1caf8a..32fa81a247 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -26,7 +26,7 @@ static uint8_t scsi_inquiry_std_response[256];
>   static ScsiInquiryEvpdPages scsi_inquiry_evpd_pages_response;
>   static ScsiInquiryEvpdBl scsi_inquiry_evpd_bl_response;
>   
> -static inline void vs_assert(bool term, const char **msgs)
> +static inline bool vs_assert(bool term, const char **msgs)
>   {
>       if (!term) {
>           int i = 0;
> @@ -35,11 +35,13 @@ static inline void vs_assert(bool term, const char **msgs)
>           while (msgs[i]) {
>               printf("%s", msgs[i++]);
>           }
> -        panic(" !\n");
> +        puts(" !");
>       }
> +
> +    return term;
>   }
>   
> -static void virtio_scsi_verify_response(VirtioScsiCmdResp *resp,
> +static bool virtio_scsi_verify_response(VirtioScsiCmdResp *resp,
>                                           const char *title)
>   {
>       const char *mr[] = {
> @@ -56,8 +58,12 @@ static void virtio_scsi_verify_response(VirtioScsiCmdResp *resp,
>           0
>       };
>   
> -    vs_assert(resp->response == VIRTIO_SCSI_S_OK, mr);
> -    vs_assert(resp->status == CDB_STATUS_GOOD, ms);
> +    if (!vs_assert(resp->response == VIRTIO_SCSI_S_OK, mr) ||
> +                !vs_assert(resp->status == CDB_STATUS_GOOD, ms)) {
> +        return false;
> +    }
> +
> +    return true;

Could be simplified to:

     return vs_assert(resp->response == VIRTIO_SCSI_S_OK, mr) &&
            vs_assert(resp->status == CDB_STATUS_GOOD, ms);

>   }
>   
...
> @@ -110,12 +123,13 @@ static bool scsi_inquiry(VDev *vdev, uint8_t evpd, uint8_t page,
>           { data, data_size, VRING_DESC_F_WRITE },
>       };
>   
> -    vs_run("inquiry", inquiry, vdev, &cdb, sizeof(cdb), data, data_size);
> +    int ret = vs_run("inquiry", inquiry,
> +            vdev, &cdb, sizeof(cdb), data, data_size);

Please indent the second line with the "(" in the previous line.

> -    return virtio_scsi_response_ok(&resp);
> +    return ret ? ret : virtio_scsi_response_ok(&resp);
>   }
...
>           if (r->lun_list_len == 0) {
>               printf("no LUNs for target 0x%X\n", target);
>               continue;
> @@ -283,7 +306,9 @@ int virtio_scsi_read_many(VDev *vdev,
>           data_size = sector_count * virtio_get_block_size() * f;
>           if (!scsi_read_10(vdev, sector * f, sector_count * f, load_addr,
>                             data_size)) {
> -            virtio_scsi_verify_response(&resp, "virtio-scsi:read_many");
> +            if (!virtio_scsi_verify_response(&resp, "virtio-scsi:read_many")) {
> +                return 1;
> +            }
>           }
>           load_addr += data_size;
>           sector += sector_count;
> @@ -352,11 +377,16 @@ static int virtio_scsi_setup(VDev *vdev)
>               uint8_t code = resp.sense[0] & SCSI_SENSE_CODE_MASK;
>               uint8_t sense_key = resp.sense[2] & SCSI_SENSE_KEY_MASK;
>   
> -            IPL_assert(resp.sense_len != 0, "virtio-scsi:setup: no SENSE data");
> +            if (resp.sense_len == 0) {
> +                puts("virtio-scsi: setup: no SENSE data");
> +                return -EINVAL;
> +            }
>   
> -            IPL_assert(retry_test_unit_ready && code == 0x70 &&
> -                       sense_key == SCSI_SENSE_KEY_UNIT_ATTENTION,
> -                       "virtio-scsi:setup: cannot retry");
> +            if (!retry_test_unit_ready || code != 0x70 ||
> +                       sense_key != SCSI_SENSE_KEY_UNIT_ATTENTION) {
> +                puts("virtio-scsi:setup: cannot retry");
> +                return -EIO;
> +            }
>   
>               /* retry on CHECK_CONDITION/UNIT_ATTENTION as it
>                * may not designate a real error, but it may be
> @@ -367,16 +397,22 @@ static int virtio_scsi_setup(VDev *vdev)
>               continue;
>           }
>   
> -        virtio_scsi_verify_response(&resp, "virtio-scsi:setup");
> +        if (!virtio_scsi_verify_response(&resp, "virtio-scsi:setup")) {
> +            return 1;

Phew, there a bunch of places now that return "1" for e.g. response OK, but 
this one here is now using "1" for error? ... that's quite confusing. Could 
we maybe standardize on using negative values for error codes? (and 1/0 or 
true/false only for functions that return OK/not OK ?), i.e. use a negative 
error code here (returning -1 is also fine for me)?

> +        }
>       }
>   
>       /* read and cache SCSI INQUIRY response */
> -    if (!scsi_inquiry(vdev,
> +    ret = scsi_inquiry(vdev,
>                         SCSI_INQUIRY_STANDARD,
>                         SCSI_INQUIRY_STANDARD_NONE,
>                         scsi_inquiry_std_response,
> -                      sizeof(scsi_inquiry_std_response))) {
> -        virtio_scsi_verify_response(&resp, "virtio-scsi:setup:inquiry");
> +                      sizeof(scsi_inquiry_std_response));
> +    if (ret < 1) {
> +        if (ret != 0 || !virtio_scsi_verify_response(&resp,
> +                "virtio-scsi:setup:inquiry")) {
> +            return 1;

dito, use a negative error code here?

> +        }
>       }
>   
>       if (virtio_scsi_inquiry_response_is_cdrom(scsi_inquiry_std_response)) {
> @@ -385,12 +421,16 @@ static int virtio_scsi_setup(VDev *vdev)
>           vdev->scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
>       }
>   
> -    if (!scsi_inquiry(vdev,
> +    ret = scsi_inquiry(vdev,
>                         SCSI_INQUIRY_EVPD,
>                         SCSI_INQUIRY_EVPD_SUPPORTED_PAGES,
>                         evpd,
> -                      sizeof(*evpd))) {
> -        virtio_scsi_verify_response(&resp, "virtio-scsi:setup:supported_pages");
> +                      sizeof(*evpd));
> +    if (ret < 1) {
> +        if (ret != 0 || !virtio_scsi_verify_response(&resp,
> +                "virtio-scsi:setup:supported_pages")) {
> +            return 1;

dito

> +        }
>       }
>   
>       debug_print_int("EVPD length", evpd->page_length);
> @@ -402,12 +442,16 @@ static int virtio_scsi_setup(VDev *vdev)
>               continue;
>           }
>   
> -        if (!scsi_inquiry(vdev,
> +        ret = scsi_inquiry(vdev,
>                             SCSI_INQUIRY_EVPD,
>                             SCSI_INQUIRY_EVPD_BLOCK_LIMITS,
>                             evpd_bl,
> -                          sizeof(*evpd_bl))) {
> -            virtio_scsi_verify_response(&resp, "virtio-scsi:setup:blocklimits");
> +                          sizeof(*evpd_bl));
> +        if (ret < 1) {
> +            if (ret != 0 || !virtio_scsi_verify_response(&resp,
> +                    "virtio-scsi:setup:blocklimits")) {
> +                return 1;

dito

> +            }
>           }
>   
>           debug_print_int("max transfer", evpd_bl->max_transfer);
> @@ -423,8 +467,12 @@ static int virtio_scsi_setup(VDev *vdev)
>       vdev->max_transfer = MIN_NON_ZERO(VIRTIO_SCSI_MAX_SECTORS,
>                                         vdev->max_transfer);
>   
> -    if (!scsi_read_capacity(vdev, data, data_size)) {
> -        virtio_scsi_verify_response(&resp, "virtio-scsi:setup:read_capacity");
> +    ret = scsi_read_capacity(vdev, data, data_size);
> +    if (ret < 1) {
> +        if (ret != 0 || !virtio_scsi_verify_response(&resp,
> +                "virtio-scsi:setup:read_capacity")) {
> +            return 1;

dito

> +        }
>       }
>       scsi_parse_capacity_report(data, &vdev->scsi_last_block,
>                                  (uint32_t *) &vdev->scsi_block_size);
> @@ -439,10 +487,15 @@ int virtio_scsi_setup_device(SubChannelId schid)
>       vdev->schid = schid;
>       virtio_setup_ccw(vdev);
>   
> -    IPL_assert(vdev->config.scsi.sense_size == VIRTIO_SCSI_SENSE_SIZE,
> -               "Config: sense size mismatch");
> -    IPL_assert(vdev->config.scsi.cdb_size == VIRTIO_SCSI_CDB_SIZE,
> -               "Config: CDB size mismatch");
> +    if (vdev->config.scsi.sense_size != VIRTIO_SCSI_SENSE_SIZE) {
> +        puts("Config: sense size mismatch");
> +        return -EINVAL;
> +    }
> +
> +    if (vdev->config.scsi.cdb_size != VIRTIO_SCSI_CDB_SIZE) {
> +        puts("Config: CDB size mismatch");
> +        return -EINVAL;
> +    }
>   
>       puts("Using virtio-scsi.");
>   

  Thomas


