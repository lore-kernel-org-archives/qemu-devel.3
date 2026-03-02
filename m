Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C314EE9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1OP-0007uY-AP; Mon, 02 Mar 2026 06:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx1OB-0007p9-8K
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:24:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx1O8-000249-UB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772450664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3Pqfhr38D8UyT4WSQtDGaML66dxVeZ2mv+4ore6Y8w0=;
 b=WvzvGL4hful8MN9KmYuEkvKmyPXLUnsRvXNJvg7LM/MSIqfcQcc58YYKGXVUs/PmXhnyvj
 DlGVTSkx5Lqvy8Y12joef+bohE3Fhg/Yv0xjrPyb+dTNWKpFKUxGUG/GM9te6jHTRVZ6Ot
 MQwRoHkYRDUEHgPtCSFlmOEdgQ+iuQA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-P-jR1zBNPHeHj2ZFX26lkg-1; Mon,
 02 Mar 2026 06:24:20 -0500
X-MC-Unique: P-jR1zBNPHeHj2ZFX26lkg-1
X-Mimecast-MFC-AGG-ID: P-jR1zBNPHeHj2ZFX26lkg_1772450658
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1704B195609F; Mon,  2 Mar 2026 11:24:18 +0000 (UTC)
Received: from [10.45.224.162] (unknown [10.45.224.162])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEE151800351; Mon,  2 Mar 2026 11:24:10 +0000 (UTC)
Message-ID: <ba373cdc-bfb4-46b0-9a74-bfe7e74bdbca@redhat.com>
Date: Mon, 2 Mar 2026 12:24:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 22/30] pc-bios/s390-ccw: Add additional security checks
 for secure boot
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-23-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260212204352.1044699-23-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/02/2026 21.43, Zhuoying Cai wrote:
> Add additional checks to ensure that components do not overlap with
> signed components when loaded into memory.
> 
> Add additional checks to ensure the load addresses of unsigned components
> are greater than or equal to 0x2000.
> 
> When the secure IPL code loading attributes facility (SCLAF) is installed,
> all signed components must contain a secure code loading attributes block
> (SCLAB).
> 
> The SCLAB provides further validation of information on where to load the
> signed binary code from the load device, and where to start the execution
> of the loaded OS code.
> 
> When SCLAF is installed, its content must be evaluated during secure IPL.
> However, a missing SCLAB will not be reported in audit mode. The SCALB
> checking will be skipped in this case.
> 
> Add IPL Information Error Indicators (IIEI) and Component Error
> Indicators (CEI) for IPL Information Report Block (IIRB).
> 
> When SCLAF is installed, additional secure boot checks are performed
> during zipl and store results of verification into IIRB.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   include/hw/s390x/ipl/qipl.h   |  29 +++-
>   pc-bios/s390-ccw/s390-ccw.h   |   1 +
>   pc-bios/s390-ccw/sclp.c       |   8 +
>   pc-bios/s390-ccw/sclp.h       |   1 +
>   pc-bios/s390-ccw/secure-ipl.c | 318 +++++++++++++++++++++++++++++++++-
>   pc-bios/s390-ccw/secure-ipl.h |  42 +++++
>   6 files changed, 395 insertions(+), 4 deletions(-)
...
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index cf147f4634..3441020d6b 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -52,6 +52,7 @@ typedef struct SCCBHeader {
>   #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
>   #define SCCB_FAC134_DIAG320_BIT 0x4
>   #define SCCB_FAC_IPL_SIPL_BIT 0x4000
> +#define SCCB_FAC_IPL_SCLAF_BIT 0x1000
>   
>   typedef struct ReadInfo {
>       SCCBHeader h;
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index 27d2833642..54e41ec11c 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -197,6 +197,12 @@ static bool secure_ipl_supported(void)
>           return false;
>       }
>   
> +    if (!sclp_is_sclaf_on()) {
> +        puts("Secure IPL Code Loading Attributes Facility is not supported by"
> +             " the hypervisor!");
> +        return false;
> +    }

Let me double-check: This emits a warning and then the bios might continue 
with the boot process with another device? (zipl_load() prints another 
warning and returns without panic'ing when ipl_scsi() failed)

... is this what we want? Or should the boot process be stopped in case 
we're running in (non-audit) secure mode?

>       return true;
>   }
>   
> @@ -259,6 +265,290 @@ static void addr_overlap_check(SecureIplCompAddrRange *comp_addr_range,
>       *addr_range_index += 1;
>   }
>   
> +static void check_unsigned_addr(uint64_t load_addr, IplDeviceComponentEntry *comp_entry)
> +{
> +    /* unsigned load address must be greater than or equal to 0x2000 */
> +    if (load_addr >= 0x2000) {
> +        return;
> +    }
> +
> +    set_comp_cei_with_log(comp_entry, S390_CEI_INVALID_UNSIGNED_ADDR,
> +                          "Load address is less than 0x2000");
> +}
> +
> +static bool check_sclab_presence(uint8_t *sclab_magic,
> +                                 IplDeviceComponentEntry *comp_entry)
> +{
> +    /* identifies the presence of SCLAB */
> +    if (magic_match(sclab_magic, ZIPL_MAGIC)) {
> +        return true;
> +    }
> +
> +    if (comp_entry) {
> +        comp_entry->cei |= S390_CEI_INVALID_SCLAB;
> +    }
> +
> +    /* a missing SCLAB will not be reported in audit mode */
> +    return false;
> +}
> +
> +static void check_sclab_length(uint16_t sclab_len, IplDeviceComponentEntry *comp_entry)
> +{
> +    if (sclab_len >= S390_SECURE_IPL_SCLAB_MIN_LEN) {
> +        return;
> +    }
> +
> +    set_comp_cei_with_log(comp_entry,
> +                          S390_CEI_INVALID_SCLAB_LEN | S390_CEI_INVALID_SCLAB,
> +                          "Invalid SCLAB length");
> +}
> +
> +static void check_sclab_format(uint8_t sclab_format, IplDeviceComponentEntry *comp_entry)
> +{
> +    /* SCLAB format must set to zero, indicating a format-0 SCLAB being used */
> +    if (sclab_format == 0) {
> +        return;
> +    }
> +
> +    set_comp_cei_with_log(comp_entry, S390_CEI_INVALID_SCLAB_FORMAT,
> +                          "Format-0 SCLAB is not being used");
> +}
> +
> +static void check_sclab_opsw(SecureCodeLoadingAttributesBlock *sclab,
> +                             SecureIplSclabInfo *sclab_info,
> +                             IplDeviceComponentEntry *comp_entry)
> +{
> +    const char *msg;
> +    uint32_t cei_flag = 0;
> +
> +    if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OPSW)) {
> +        /* OPSW = 0 - Load PSW field in SCLAB must contain zeros */
> +        if (sclab->load_psw != 0) {
> +            cei_flag |= S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO;
> +            msg = "Load PSW is not zero when Override PSW bit is zero";
> +        }
> +    } else {
> +        /* OPSW = 1 indicating global SCLAB */
> +        sclab_info->global_count += 1;
> +        if (sclab_info->global_count == 1) {
> +            sclab_info->load_psw = sclab->load_psw;
> +            sclab_info->flags = sclab->flags;
> +        }
> +
> +        /* OLA must set to one */
> +        if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OLA)) {
> +            cei_flag |= S390_CEI_SCLAB_OLA_NOT_ONE;
> +            msg = "Override Load Address bit is not set to one in the global SCLAB";
> +        }
> +    }
> +
> +    if (!cei_flag) {
> +        return;
> +    }
> +
> +    set_comp_cei_with_log(comp_entry, cei_flag, msg);

Code gets slightly shorter if you inverse the logic here:

     if (cei_flag) {
         set_comp_cei_with_log(comp_entry, cei_flag, msg);
     }

> +}
> +
> +static void check_sclab_ola(SecureCodeLoadingAttributesBlock *sclab, uint64_t load_addr,
> +                            IplDeviceComponentEntry *comp_entry)
> +{
> +    const char *msg;
> +    uint32_t cei_flag = 0;
> +
> +    if (!(sclab->flags & S390_SECURE_IPL_SCLAB_FLAG_OLA)) {
> +        /* OLA = 0 - Load address field in SCLAB must contain zeros */
> +        if (sclab->load_addr != 0) {
> +            cei_flag |= S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO;
> +            msg = "Load Address is not zero when Override Load Address bit is zero";
> +        }
> +    } else {
> +        /* OLA = 1 - Load address field must match storage address of the component */
> +        if (sclab->load_addr != load_addr) {
> +            cei_flag |= S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR;
> +            msg = "Load Address does not match with component load address";
> +        }
> +    }
> +
> +    if (!cei_flag) {
> +        return;
> +    }
> +
> +    set_comp_cei_with_log(comp_entry, cei_flag, msg);

dito

  Thomas


