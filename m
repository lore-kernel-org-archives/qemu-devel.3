Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7342C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMbN-0001mE-42; Fri, 11 Jul 2025 18:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uaMZq-00086d-05; Fri, 11 Jul 2025 18:50:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uaMZl-000182-Ol; Fri, 11 Jul 2025 18:50:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJ2x60009277;
 Fri, 11 Jul 2025 22:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FMJdgS
 PlGMK8C0bagfojD92cKNewFgelFniLxDCT+Eg=; b=c9raq8NZSvVxGjeeuT5Y5C
 57Cc9FaWmeLnzHqCTCMJTikUmuHm51d0wQ7T0H+j+6ycIULXBc1rJfhO2IGkjhVk
 lobPemraec1CHcyATQstn+tQKpMKGYG7mDjshF0hTvo+wySY9bfIlr8eab9Byp0I
 DgXx4sBm5mTYLmxUEzhy+/0lFaPMhkp2KY/3uldcNlfQmqeyrCk8luDGUsZR9zRw
 veGBzRa2X0MkmFKoQgQhdWvTgqTN09lyHHYxZ8sCm3qXeYamGpeJlzC59Js69lIc
 uzIBoXZERFkM/dA+Um0dpFNFfHZ1P+9wyjJqYepubVi0xPE9hYNRluScWB6w85bQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb2dmnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 22:50:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BIaRQv021581;
 Fri, 11 Jul 2025 22:50:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qecu529q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 22:50:37 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BMoaLh24248860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 22:50:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CF9758056;
 Fri, 11 Jul 2025 22:50:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3043558052;
 Fri, 11 Jul 2025 22:50:35 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Jul 2025 22:50:35 +0000 (GMT)
Message-ID: <eccbac31-7c1d-4b75-a284-a46ad98675db@linux.ibm.com>
Date: Fri, 11 Jul 2025 18:50:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/28] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-21-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250711211105.439554-21-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE2OSBTYWx0ZWRfXzP6/KOnqTUcN
 U5krJV0MsM5C9F+A9kEds2hKqMZd+Xdtc1kPbcCMn4Jp/I+Em+SybhxxnGE3IkKrGCgzcWgRzBI
 A397uFf1GdPChvs0rJ//SnNUJUGoBXnzv6GeFGaOnELcBPckqB8A1KX81k/Z/4gMVNcHmz4I/8J
 juRcSgepfmgzpywg7N8GCsBrDySne3NM/2J+VMUgEQHKfi+w6j9F5ULMMu+y8KasxqLJSMuot8x
 3RGNueEraG+Tf18pkHv8Zc6ePXuZBhGlFPhHBnTc2+GE8Vf4UYyfx8SZR9rria5sDTzTxWVxLId
 jMVheo6z+JZTZI9r5olOYgWio320zLzJYcAibLhbOcPJwQWACqo+6AZaiXWHmOIoV/ijgMcMsMU
 EjG/2UflQxio0vMeNuFRpBtpcf2BoHvR0vYmgfVW+tb7W3KvB4Y1ckr8cKK90MKufyJGmHmG
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=6871953e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=G8nC_XNHhfjc3ldv6R4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ujxeGtuF_xwCjGw8aVWEdE-ojsLvjyR1
X-Proofpoint-GUID: ujxeGtuF_xwCjGw8aVWEdE-ojsLvjyR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110169
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/11/25 5:10 PM, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
> 
> Add a comp_len variable to store the length of a segment in
> zipl_load_segment. comp_len variable is necessary to store the
> calculated segment length and is used during signature verification.
> Return the length on success, or a negative return code on failure.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
> 
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

I would suggest encapsulating all secure-boot related functions into the
new secure-ipl.c|h files to help keep bootmap.c less bloated.  I would
suggest moving the following to the new file:

- zipl_handle_sig_entry
- handle_certificate
- zipl_run_secure (this should probably be the only non-static func,
since it'll be used by bootmap.c, and you'll probably need to mess with
the levels of indirection for the params)

Of course, make all functions used by zipl_run_secure as static since
they'll only be used there.

I'll revist this patch later to verify the SCLP bits and triple-check
the data structure layouts.

More comments below:

> ---
>  pc-bios/s390-ccw/Makefile     |   3 +-
>  pc-bios/s390-ccw/bootmap.c    | 193 +++++++++++++++++++++++++++++++++-
>  pc-bios/s390-ccw/bootmap.h    |   9 ++
>  pc-bios/s390-ccw/main.c       |   9 ++
>  pc-bios/s390-ccw/s390-ccw.h   |  14 +++
>  pc-bios/s390-ccw/sclp.c       |  44 ++++++++
>  pc-bios/s390-ccw/sclp.h       |   6 ++
>  pc-bios/s390-ccw/secure-ipl.c | 190 +++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/secure-ipl.h |  98 +++++++++++++++++
>  9 files changed, 563 insertions(+), 3 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index dc69dd484f..fedb89a387 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -34,7 +34,8 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>  .PHONY : all clean build-all distclean
>  
>  OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
> -	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o
> +	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> +	  secure-ipl.o
>  
>  SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>  
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 2513e6c131..0827459803 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -8,6 +8,7 @@
>   * directory.
>   */
>  
> +#include <stdlib.h>
>  #include <string.h>
>  #include <stdio.h>
>  #include "s390-ccw.h"
> @@ -15,6 +16,7 @@
>  #include "bootmap.h"
>  #include "virtio.h"
>  #include "bswap.h"
> +#include "secure-ipl.h"
>  
>  #ifdef DEBUG
>  /* #define DEBUG_FALLBACK */
> @@ -34,6 +36,9 @@ static uint8_t sec[MAX_SECTOR_SIZE*4] __attribute__((__aligned__(PAGE_SIZE)));
>  const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
>                                    "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
>  
> +/* sector for storing signatures */
> +static uint8_t sig_sec[MAX_SECTOR_SIZE] __attribute__((__aligned__(PAGE_SIZE)));

Since only zipl_secure_run is making use of this scratch space, I'd
suggest declaring some chunk of mem within that function and then
passing it as a parameter to zipl_handle_sig_entry.  It'll also make it
a lot easier to understand what is going on in the
ZIPL_COMP_ENTRY_SIGNATURE case.

> +
>  /*
>   * Match two CCWs located after PSW and eight filler bytes.
>   * From libmagic and arch/s390/kernel/head.S.
> @@ -676,6 +681,159 @@ static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>      return comp_len;
>  }
>  
> +static uint32_t zipl_handle_sig_entry(ComponentEntry *entry)

I think "zipl_load_signature" reads better.

> +{
> +    uint32_t sig_len;
> +
> +    if (zipl_load_segment(entry, (uint64_t)sig_sec) < 0) {
> +        return -1;
> +    }
> +
> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
> +        puts("Signature is not in DER format");
> +        return -1;
> +    }
> +    sig_len = entry->compdat.sig_info.sig_len;
> +
> +    return sig_len;
> +}
> +
> +static int handle_certificate(int *cert_table, uint64_t **cert,
> +                             uint64_t cert_len, uint8_t cert_idx,
> +                             IplSignatureCertificateList *certs, int cert_index)
> +{
> +    bool unused;
> +
> +    unused = cert_table[cert_idx] == -1;
> +    if (unused) {
> +        if (zipl_secure_request_certificate(*cert, cert_idx)) {
> +            zipl_secure_cert_list_add(certs, cert_index, *cert, cert_len);
> +            cert_table[cert_idx] = cert_index;
> +            *cert += cert_len;
> +        } else {
> +            puts("Could not get certificate");
> +            return -1;
> +        }
> +
> +        /* increment cert_index for the next cert entry */
> +        return ++cert_index;
> +    }
> +
> +    return cert_index;
> +}
> +
> +static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
> +{
> +    IplDeviceComponentList comps;
> +    IplSignatureCertificateList certs;
> +    uint64_t *cert = NULL;
> +    int cert_index = 0;
> +    int comp_index = 0;
> +    uint64_t comp_addr;
> +    int comp_len;
> +    bool have_sig;
> +    uint32_t sig_len;
> +    uint64_t cert_len = -1;
> +    uint8_t cert_idx = -1;
> +    bool verified;
> +    uint32_t certs_len;
> +    /*
> +     * Store indices of cert entry that have already used for signature verification
> +     * to prevent allocating the same certificate multiple times.
> +     * cert_table index: index of certificate from qemu cert store used for verification
> +     * cert_table value: index of cert entry in cert list that contains the certificate
> +     */
> +    int cert_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1};
> +    int signed_count = 0;
> +
> +    if (!zipl_secure_ipl_supported()) {
> +        return -1;
> +    }
> +
> +    zipl_secure_init_lists(&comps, &certs);
> +    certs_len = zipl_secure_get_certs_length();
> +    cert = malloc(certs_len);
> +
> +    have_sig = false;

You can get rid of this boolean and simply use sig_len as the indicator
that there were nonzero bytes read when a signature entry was detected
in the previous loop.  Where you set have_sig to false below, you can
set sig_len to 0 to reset it.

> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +

I'll be honest, I'm not a big fan of neither the design of this while
loop nor the one in zipl_run_normal.  I'd prefer something like:

while (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {

    // sanity checking

    switch (entry->component_type) {
    case ZIPL_COMP_ENTRY_SIGNATURE:
        ...
        break;
    case ZIPL_COMP_ENTRY_LOAD:
        ...
        break;
    default:
        // Unrecognized entry type, return error
    }

    entry++;
}

The above makes it clear that we're loading in segments until the exec
entry is found, and the handling for each recognized component type is
clearly labeled and organized.

I won't speak for making this change to the zipl_run_normal function
yet, as it may introduce too many changes in this patch series.

> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +            /* There should never be two signatures in a row */
> +            if (have_sig) {
> +                return -1;
> +            }
> +
> +            sig_len = zipl_handle_sig_entry(entry);
> +            if (sig_len < 0) {
> +                return -1;
> +            }
> +
> +            have_sig = true;
> +        } else {
> +            comp_addr = entry->compdat.load_addr;
> +            comp_len = zipl_load_segment(entry, comp_addr);
> +            if (comp_len < 0) {
> +                return -1;
> +            }
> +
> +            if (have_sig) {

If you use my idea to re-write this loop, you'll be able to reduce one
level of indentation of the code that follows by checking the inverse
condition:

if (!have_sig) { // or if (!sig_len)
    break;

> +                verified = verify_signature(comp_len, comp_addr,
> +                                            sig_len, (uint64_t)sig_sec,
> +                                            &cert_len, &cert_idx);
> +
> +                if (verified) {
> +                    cert_index = handle_certificate(cert_table, &cert,
> +                                                    cert_len, cert_idx,
> +                                                    &certs, cert_index);
> +                    if (cert_index == -1) {
> +                        return -1;
> +                    }
> +
> +                    puts("Verified component");
> +                    zipl_secure_comp_list_add(&comps, comp_index, cert_table[cert_idx],
> +                                              comp_addr, comp_len,
> +                                              S390_IPL_COMPONENT_FLAG_SC |
> +                                              S390_IPL_COMPONENT_FLAG_CSV);
> +                } else {
> +                    zipl_secure_comp_list_add(&comps, comp_index, -1,
> +                                              comp_addr, comp_len,
> +                                              S390_IPL_COMPONENT_FLAG_SC);
> +                    zipl_secure_print("Could not verify component");
> +                }
> +
> +                comp_index++;
> +                signed_count += 1;
> +                /* After a signature is used another new one can be accepted */
> +                have_sig = false;
> +            }
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
> +            puts("Wrong entry value");
> +            return -EINVAL;
> +        }

Can someone who is more informed than I am of the IPL process please
explain to me what is the purpose of the above check?  Why does it check
if the next entry, the one which isn't going to be inspected/loaded, is
within the bounds of tmp_sec?  This has been here since this file's
inception and I can't find any documentation or mention that supports it.

This code precludes any of the secure IPL changes.

Was this actually meant to be entry[0] to ensure the actual entry we
want to work on is not outside the bounds of tmp_sec?  Or perhaps it was
meant to be done before the increment to entry?

> +    }
> +
> +    if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
> +        puts("No EXEC entry");
> +        return -EINVAL;
> +    }
> +
> +    if (signed_count == 0) {
> +        zipl_secure_print("Secure boot is on, but components are not signed");
> +    }

Shouldn't this be handled within the loop?  If it gets to a LOAD type
without a signature, audit mode should report and move on.  Secure mode
should report and abort on the spot.  Then you can get rid of signed_count.

I'll get back to reviewing patch 22 wrt to this variable's usage later on...

> +
> +    if (zipl_secure_update_iirb(&comps, &certs)) {
> +        zipl_secure_print("Failed to write IPL Information Report Block");
> +    }
> +    write_reset_psw(entry->compdat.load_psw);
> +
> +    return 0;
> +}
> +
>  static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
>  {
>      while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> @@ -735,8 +893,17 @@ static int zipl_run(ScsiBlockPtr *pte)
>      /* Load image(s) into RAM */
>      entry = (ComponentEntry *)(&header[1]);
>  
> -    if (zipl_run_normal(entry, tmp_sec)) {
> -        return -1;
> +    switch (boot_mode) {
> +    case ZIPL_SECURE_AUDIT_MODE:
> +        if (zipl_run_secure(entry, tmp_sec)) {
> +            return -1;
> +        }
> +        break;
> +    case ZIPL_NORMAL_MODE:
> +        if (zipl_run_normal(entry, tmp_sec)) {
> +            return -1;
> +        }
> +        break;
>      }
>  
>      /* should not return */
> @@ -1095,17 +1262,35 @@ static int zipl_load_vscsi(void)
>   * IPL starts here
>   */
>  
> +ZiplBootMode zipl_mode(uint8_t hdr_flags)
> +{
> +    bool sipl_set = hdr_flags & DIAG308_IPIB_FLAGS_SIPL;
> +    bool iplir_set = hdr_flags & DIAG308_IPIB_FLAGS_IPLIR;
> +
> +    if (!sipl_set && iplir_set) {
> +        return ZIPL_SECURE_AUDIT_MODE;
> +    }
> +
> +    return ZIPL_NORMAL_MODE;
> +}
> +
>  void zipl_load(void)
>  {
>      VDev *vdev = virtio_get_device();
>  
>      if (vdev->is_cdrom) {
> +        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
> +            panic("Secure boot from ISO image is not supported!");
> +        }
>          ipl_iso_el_torito();
>          puts("Failed to IPL this ISO image!");
>          return;
>      }
>  
>      if (virtio_get_device_type() == VIRTIO_ID_NET) {
> +        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
> +            panic("Virtio net boot device does not support secure boot!");
> +        }
>          netmain();
>          puts("Failed to IPL from this network!");
>          return;
> @@ -1116,6 +1301,10 @@ void zipl_load(void)
>          return;
>      }
>  
> +    if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
> +        panic("ECKD boot device does not support secure boot!");
> +    }
> +
>      switch (virtio_get_device_type()) {
>      case VIRTIO_ID_BLOCK:
>          zipl_load_vblk();
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 95943441d3..e48823a835 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -88,9 +88,18 @@ typedef struct BootMapTable {
>      BootMapPointer entry[];
>  } __attribute__ ((packed)) BootMapTable;
>  
> +#define DER_SIGNATURE_FORMAT 1
> +
> +typedef struct SignatureInformation {
> +    uint8_t format;
> +    uint8_t reserved[3];
> +    uint32_t sig_len;
> +} __attribute__((packed)) SignatureInformation;
> +
>  typedef union ComponentEntryData {
>      uint64_t load_psw;
>      uint64_t load_addr;
> +    SignatureInformation sig_info;
>  } ComponentEntryData;
>  
>  typedef struct ComponentEntry {
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index c9328f1c51..38962da1dd 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -28,6 +28,7 @@ IplParameterBlock *iplb;
>  bool have_iplb;
>  static uint16_t cutype;
>  LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
> +ZiplBootMode boot_mode;
>  
>  #define LOADPARM_PROMPT "PROMPT  "
>  #define LOADPARM_EMPTY  "        "
> @@ -272,9 +273,17 @@ static int virtio_setup(void)
>  
>  static void ipl_boot_device(void)
>  {
> +    if (boot_mode == 0) {
> +        boot_mode = zipl_mode(iplb->hdr_flags);
> +    }
> +
>      switch (cutype) {
>      case CU_TYPE_DASD_3990:
>      case CU_TYPE_DASD_2107:
> +        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
> +            panic("Passthrough (vfio) device does not support secure boot!");
> +        }
> +
>          dasd_ipl(blk_schid, cutype);
>          break;
>      case CU_TYPE_VIRTIO:
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 6cdce3e5e5..648f407dc5 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -39,6 +39,9 @@ typedef unsigned long long u64;
>  #define MIN_NON_ZERO(a, b) ((a) == 0 ? (b) : \
>                              ((b) == 0 ? (a) : (MIN(a, b))))
>  #endif
> +#ifndef ROUND_UP
> +#define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))
> +#endif
>  
>  #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
>  
> @@ -64,6 +67,8 @@ void sclp_print(const char *string);
>  void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
>  void sclp_setup(void);
>  void sclp_get_loadparm_ascii(char *loadparm);
> +bool sclp_is_diag320_on(void);
> +bool sclp_is_sipl_on(void);
>  int sclp_read(char *str, size_t count);
>  
>  /* virtio.c */
> @@ -76,6 +81,15 @@ int virtio_read(unsigned long sector, void *load_addr);
>  /* bootmap.c */
>  void zipl_load(void);
>  
> +typedef enum ZiplBootMode {
> +    ZIPL_NORMAL_MODE = 1,
> +    ZIPL_SECURE_AUDIT_MODE = 2,
> +} ZiplBootMode;

These should be ZIPL_BOOT_MODE_*

Also, is there a reason why the list starts at 1 and not defaulting to
the implicit 0?

> +
> +extern ZiplBootMode boot_mode;
> +
> +ZiplBootMode zipl_mode(uint8_t hdr_flags);
> +
>  /* jump2ipl.c */
>  void write_reset_psw(uint64_t psw);
>  int jump_to_IPL_code(uint64_t address);
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 4a07de018d..0b03c3164f 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -113,6 +113,50 @@ void sclp_get_loadparm_ascii(char *loadparm)
>      }
>  }
>  
> +static void sclp_get_fac134(uint8_t *fac134)
> +{
> +
> +    ReadInfo *sccb = (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        *fac134 = sccb->fac134;
> +    }
> +}
> +
> +bool sclp_is_diag320_on(void)
> +{
> +    uint8_t fac134 = 0;
> +
> +    sclp_get_fac134(&fac134);
> +    return fac134 & SCCB_FAC134_DIAG320_BIT;
> +}
> +
> +/*
> + * Get fac_ipl (byte 136 and byte 137 of the SCLP Read Info block)
> + * for IPL device facilities.
> + */
> +static void sclp_get_fac_ipl(uint16_t *fac_ipl)
> +{
> +
> +    ReadInfo *sccb = (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        *fac_ipl = sccb->fac_ipl;
> +    }
> +}
> +
> +bool sclp_is_sipl_on(void)
> +{
> +    uint16_t fac_ipl = 0;
> +
> +    sclp_get_fac_ipl(&fac_ipl);
> +    return fac_ipl & SCCB_FAC_IPL_SIPL_BIT;
> +}
> +
>  int sclp_read(char *str, size_t count)
>  {
>      ReadEventData *sccb = (void *)_sccb;
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index 64b53cad29..cf147f4634 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -50,6 +50,8 @@ typedef struct SCCBHeader {
>  } __attribute__((packed)) SCCBHeader;
>  
>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
> +#define SCCB_FAC134_DIAG320_BIT 0x4
> +#define SCCB_FAC_IPL_SIPL_BIT 0x4000
>  
>  typedef struct ReadInfo {
>      SCCBHeader h;
> @@ -57,6 +59,10 @@ typedef struct ReadInfo {
>      uint8_t rnsize;
>      uint8_t reserved[13];
>      uint8_t loadparm[LOADPARM_LEN];
> +    uint8_t reserved1[102];
> +    uint8_t fac134;
> +    uint8_t reserved2;
> +    uint16_t fac_ipl;
>  } __attribute__((packed)) ReadInfo;
>  
>  typedef struct SCCB {
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> new file mode 100644
> index 0000000000..4b8321e401
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -0,0 +1,190 @@
> +/*
> + * S/390 Secure IPL
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

Let's take the opportunity to add some meaningful content to the file
header.  Something like:

/*
 * S/390 Secure IPL
 *
 * Functions to support IPL in secure boot mode (DIAG 320, DIAG 508,
 * signature verification, and certificate handling).
 *
 * For secure IPL overview: docs/system/s390x/secure-ipl.rst
 * For secure IPL technical: docs/specs/s390x-secure-ipl.rst
 *
 * Copyright 2025 IBM Corp.
 * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

No need to put in the .h

> +
> +#include <string.h>
> +#include <stdio.h>
> +#include "s390-ccw.h"
> +#include "secure-ipl.h"
> +
> +uint8_t vcb_data[MAX_SECTOR_SIZE * 4] __attribute__((__aligned__(PAGE_SIZE)));
> +uint8_t vcssb_data[VCSSB_MAX_LEN] __attribute__((__aligned__(PAGE_SIZE)));
> +
> +VCStorageSizeBlock *zipl_secure_get_vcssb(void)
> +{
> +    VCStorageSizeBlock *vcssb;
> +    int rc;
> +
> +    vcssb = (VCStorageSizeBlock *)vcssb_data;
> +    /* avoid retrieving vcssb multiple times */
> +    if (vcssb->length == VCSSB_MAX_LEN) {
> +        return vcssb;
> +    }
> +
> +    rc = diag320(vcssb, DIAG_320_SUBC_QUERY_VCSI);
> +    if (rc != DIAG_320_RC_OK) {
> +        return NULL;
> +    }
> +
> +    return vcssb;
> +}
> +
> +uint32_t zipl_secure_get_certs_length(void)
> +{
> +    VCStorageSizeBlock *vcssb;
> +    uint32_t len;
> +
> +    vcssb = zipl_secure_get_vcssb();
> +    if (vcssb == NULL) {
> +        return 0;
> +    }
> +
> +    len = vcssb->total_vcb_len - VCB_HEADER_LEN - vcssb->total_vc_ct * VCE_HEADER_LEN;
> +
> +    return len;
> +}
> +
> +uint32_t zipl_secure_request_certificate(uint64_t *cert, uint8_t index)
> +{
> +    VCStorageSizeBlock *vcssb;
> +    VCBlock *vcb;
> +    VCEntry *vce;
> +    uint64_t rc = 0;
> +    uint32_t cert_len = 0;
> +
> +    /* Get Verification Certificate Storage Size block with DIAG320 subcode 1 */
> +    vcssb = zipl_secure_get_vcssb();
> +    if (vcssb == NULL) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Request single entry
> +     * Fill input fields of single-entry VCB
> +     */
> +    vcb = (VCBlock *)vcb_data;
> +    vcb->in_len = ROUND_UP(vcssb->max_single_vcb_len, PAGE_SIZE);
> +    vcb->first_vc_index = index + 1;
> +    vcb->last_vc_index = index + 1;
> +
> +    rc = diag320(vcb, DIAG_320_SUBC_STORE_VC);
> +    if (rc == DIAG_320_RC_OK) {
> +        vce = (VCEntry *)vcb->vce_buf;
> +        cert_len = vce->cert_len;
> +        memcpy(cert, (uint8_t *)vce + vce->cert_offset, vce->cert_len);
> +        /* clear out region for next cert(s) */
> +        memcpy(vcb_data, 0, sizeof(vcb_data));
> +    }
> +
> +    return cert_len;
> +}
> +
> +void zipl_secure_cert_list_add(IplSignatureCertificateList *certs, int cert_index,
> +                               uint64_t *cert, uint64_t cert_len)
> +{
> +    if (cert_index > MAX_CERTIFICATES - 1) {
> +        printf("Warning: Ignoring cert entry [%d] because it's over %d entires\n",
> +                cert_index + 1, MAX_CERTIFICATES);
> +        return;
> +    }
> +
> +    certs->cert_entries[cert_index].addr = (uint64_t)cert;
> +    certs->cert_entries[cert_index].len = cert_len;
> +    certs->ipl_info_header.len += sizeof(certs->cert_entries[cert_index]);
> +}
> +
> +void zipl_secure_comp_list_add(IplDeviceComponentList *comps, int comp_index,
> +                               int cert_index, uint64_t comp_addr,
> +                               uint64_t comp_len, uint8_t flags)
> +{
> +    if (comp_index > MAX_CERTIFICATES - 1) {
> +        printf("Warning: Ignoring comp entry [%d] because it's over %d entires\n",
> +                comp_index + 1, MAX_CERTIFICATES);
> +        return;
> +    }
> +
> +    comps->device_entries[comp_index].addr = comp_addr;
> +    comps->device_entries[comp_index].len = comp_len;
> +    comps->device_entries[comp_index].flags = flags;
> +    comps->device_entries[comp_index].cert_index = cert_index;
> +    comps->ipl_info_header.len += sizeof(comps->device_entries[comp_index]);
> +}
> +
> +int zipl_secure_update_iirb(IplDeviceComponentList *comps,
> +                            IplSignatureCertificateList *certs)
> +{
> +    IplInfoReportBlock *iirb;
> +    IplDeviceComponentList *iirb_comps;
> +    IplSignatureCertificateList *iirb_certs;
> +    uint32_t iirb_hdr_len;
> +    uint32_t comps_len;
> +    uint32_t certs_len;
> +
> +    if (iplb->len % 8 != 0) {
> +        panic("IPL parameter block length field value is not multiple of 8 bytes");
> +    }
> +
> +    iirb_hdr_len = sizeof(IplInfoReportBlockHeader);
> +    comps_len = comps->ipl_info_header.len;
> +    certs_len = certs->ipl_info_header.len;
> +    if ((comps_len + certs_len + iirb_hdr_len) > sizeof(IplInfoReportBlock)) {
> +        puts("Not enough space to hold all components and certificates in IIRB");
> +        return -1;
> +    }
> +
> +    /* IIRB immediately follows IPLB */
> +    iirb = &ipl_data.iirb;
> +    iirb->hdr.len = iirb_hdr_len;
> +
> +    /* Copy IPL device component list after IIRB Header */
> +    iirb_comps = (IplDeviceComponentList *) iirb->info_blks;
> +    memcpy(iirb_comps, comps, comps_len);
> +
> +    /* Update IIRB length */
> +    iirb->hdr.len += comps_len;
> +
> +    /* Copy IPL sig cert list after IPL device component list */
> +    iirb_certs = (IplSignatureCertificateList *) (iirb->info_blks +
> +                                                  iirb_comps->ipl_info_header.len);
> +    memcpy(iirb_certs, certs, certs_len);
> +
> +    /* Update IIRB length */
> +    iirb->hdr.len += certs_len;
> +
> +    return 0;
> +}
> +
> +bool zipl_secure_ipl_supported(void)
> +{
> +    if (!sclp_is_sipl_on()) {
> +        puts("Secure IPL Facility is not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    if (!is_secure_ipl_extension_supported()) {
> +        puts("Secure IPL extensions are not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    if (!(sclp_is_diag320_on() && is_cert_store_facility_supported())) {
> +        puts("Certificate Store Facility is not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +void zipl_secure_init_lists(IplDeviceComponentList *comps,
> +                            IplSignatureCertificateList *certs)
> +{
> +    comps->ipl_info_header.ibt = IPL_IBT_COMPONENTS;
> +    comps->ipl_info_header.len = sizeof(comps->ipl_info_header);
> +
> +    certs->ipl_info_header.ibt = IPL_IBT_CERTIFICATES;
> +    certs->ipl_info_header.len = sizeof(certs->ipl_info_header);
> +}
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> new file mode 100644
> index 0000000000..b9052e8c78
> --- /dev/null
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -0,0 +1,98 @@
> +/*
> + * S/390 Secure IPL
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +> +#ifndef _PC_BIOS_S390_CCW_SECURE_IPL_H
> +#define _PC_BIOS_S390_CCW_SECURE_IPL_H
> +
> +#include <diag320.h>
> +#include <diag508.h>
> +
> +VCStorageSizeBlock *zipl_secure_get_vcssb(void);
> +uint32_t zipl_secure_get_certs_length(void);
> +uint32_t zipl_secure_request_certificate(uint64_t *cert, uint8_t index);
> +void zipl_secure_cert_list_add(IplSignatureCertificateList *certs, int cert_index,
> +                               uint64_t *cert, uint64_t cert_len);
> +void zipl_secure_comp_list_add(IplDeviceComponentList *comps, int comp_index,
> +                               int cert_index, uint64_t comp_addr,
> +                               uint64_t comp_len, uint8_t flags);
> +int zipl_secure_update_iirb(IplDeviceComponentList *comps,
> +                            IplSignatureCertificateList *certs);
> +bool zipl_secure_ipl_supported(void);
> +void zipl_secure_init_lists(IplDeviceComponentList *comps,
> +                            IplSignatureCertificateList *certs);
> +
> +static inline void zipl_secure_print(const char *message)

This name is a bit misleading, since it will do something more sinister
in a later patch when secure mode is introduced: it will assert and
abort IPL... not something I'd expect a "print" function to do ;)

Perhaps something like zipl_secure_check... or something better... I
just don't think "print" makes sense.

> +{
> +    switch (boot_mode) {
> +    case ZIPL_SECURE_AUDIT_MODE:
> +        IPL_check(false, message);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static inline uint64_t diag320(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x320\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline bool is_cert_store_facility_supported(void)
> +{
> +    uint64_t d320_ism;
> +
> +    diag320(&d320_ism, DIAG_320_SUBC_QUERY_ISM);
> +    return (d320_ism & DIAG_320_ISM_QUERY_VCSI) &&
> +           (d320_ism & DIAG_320_ISM_STORE_VC);
> +}
> +
> +static inline uint64_t _diag508(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x508\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline bool is_secure_ipl_extension_supported(void)
> +{
> +    uint64_t d508_subcodes;
> +
> +    d508_subcodes = _diag508(NULL, DIAG_508_SUBC_QUERY_SUBC);
> +    return d508_subcodes & DIAG_508_SUBC_SIG_VERIF;
> +}
> +
> +static inline bool verify_signature(uint64_t comp_len, uint64_t comp_addr,
> +                                    uint64_t sig_len, uint64_t sig_addr,
> +                                    uint64_t *cert_len, uint8_t *cert_idx)
> +{
> +    Diag508SignatureVerificationBlock svb = {{}, comp_len, comp_addr,
> +                                             sig_len, sig_addr };
> +
> +    if (_diag508(&svb, DIAG_508_SUBC_SIG_VERIF) == DIAG_508_RC_OK) {
> +        *cert_len = svb.csi.len;
> +        *cert_idx = svb.csi.idx;
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +#endif /* _PC_BIOS_S390_CCW_SECURE_IPL_H */


-- 
Regards,
  Collin

