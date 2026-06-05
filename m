Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCA9CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 19:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVa6D-0004Ss-9y; Fri, 05 Jun 2026 15:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wVa6A-0004Rv-Uq; Fri, 05 Jun 2026 15:20:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wVa67-0007ly-Gz; Fri, 05 Jun 2026 15:20:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655FwZWr2915050; Fri, 5 Jun 2026 19:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FsbkZC
 9+gLijiEMFuc7G6UWtpKFveGqe38M1sVzTwgE=; b=Pnt/752HvrEXpCYcZBLovq
 og6IwJl8gQiIII7cCi8wLevCS8QWchdT/icBXQtoSvFPYYBZ/Np7ZX7RylUP2MDU
 uYFTkkrbC5sU9o6vn0MiSuZCFISylReqbm27bj4fOvg2U6UTT27WTzKeUi/2jd0r
 OwdI2cR/+TwTkWC8wjmTN2WDZSYSe6658nagMhna6LMtspqrVQFw4WxdRxJo+BA/
 /AnVQvlrd/AvZyd/8JIjtiK74e2KADIPZw/s6ZrCOVNV44cmVFvPInrWK7PVIKi2
 v+R1XlRfuIHx3rGN2XAQuPr6zOTH+lfQ/Cz3WNDpxDCV3L3v3jh5bN6kcajbeRBg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4p2km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 19:20:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655Is9I6025570;
 Fri, 5 Jun 2026 19:20:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhu2ju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 19:20:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 655JKgbT12124784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 19:20:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2321E5805D;
 Fri,  5 Jun 2026 19:20:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4E0958052;
 Fri,  5 Jun 2026 19:20:40 +0000 (GMT)
Received: from [9.61.146.40] (unknown [9.61.146.40])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 19:20:40 +0000 (GMT)
Message-ID: <f5998015-159a-4d67-b006-092d20d91c2c@linux.ibm.com>
Date: Fri, 5 Jun 2026 15:20:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/32] s390x/diag: Implement DIAG 320 subcode 2
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-10-zycai@linux.ibm.com>
 <ce623f2a-9247-4a67-98a0-7a180fdb88ca@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <ce623f2a-9247-4a67-98a0-7a180fdb88ca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE4OCBTYWx0ZWRfXx0c55zVSvxKd
 6eoUsfkUaRF6EGKUogZqSAdyLxufzpJIufRB7epCxfs7G1/fepsKcGM2/NvAUXKevW00/bWt2Et
 XiurPVpqB2PGPKoH6niwFNQEJ+d4sTLsRSoZGeNQAZ420d5C8i7C1eI2OLUneRw0HArQl1tA8Zz
 +xOPBXZrfjlf8pckh2whNWoJYHnuuGczqhxoFBU5a6F3vdLBUC7o6DlDqcMu/Gg598mO+1AfIyi
 Ke9JDj1P4eaXpaepk+RwzI/3v7NnBIe5WTCsm+MyLTX4Gn9Dg7LnL+3r1MBRoqXcW1ImTqRCgZF
 S8sGHdDyk1ItUjlZzOsjriqQrFMYTOKPtLHU7AnGblU7wqoiMvTjDarrlAfY1ZE2FN+aR9Mh1Ka
 je7kUpeT6z0dI+i0WEEf5/TVdjf6/h/1B+I6kPVE+IsPbgCiGevSrY4AZuTut7+YlUQiL9NlDq+
 SojLdv7LPtogIdSHmKA==
X-Proofpoint-GUID: vfwxgUP6S4U_iHOxjQFFK2D_1F-293Ik
X-Proofpoint-ORIG-GUID: vfwxgUP6S4U_iHOxjQFFK2D_1F-293Ik
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a23218c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=2Cpl7EdXMx0bKFj33R0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks for the feedback!

On 5/24/26 6:32 PM, Jared Rossi wrote:
> 
> 
> On 5/5/26 4:18 PM, Zhuoying Cai wrote:
>> [...]
>> +
>> +    rc = handle_hash(vce, cert, keyid_field_len);
>> +    if (rc) {
>> +        return -1;
>> +    }
>> +    hash_field_len = ROUND_UP(be16_to_cpu(vce->vce_hdr.hash_len), 4);
>> +
>> +    rc = handle_cert(vce, cert, hash_field_len);
>> +    if (rc || !is_cert_valid(cert)) {
>> +        return -1;
>> +    }
>> +    cert_field_len = ROUND_UP(be32_to_cpu(vce->vce_hdr.cert_len), 4);
>> +
>> +    vce_len = sizeof(VCEntryHeader) + keyid_field_len + hash_field_len + cert_field_len;
>> +    if (vce_len > be32_to_cpu(vce->vce_hdr.len)) {
>> +        return -1;
>> +    }
> We already used the maximum size when we allocated space for the VCE, so 
> this
> check is redundant I think?
> 

Although exceeding the maximum size is unlikely, I think it’s good
practice to keep this check, along with those in the handle_* functions.
These checks help ensure that the actual lengths of the certificate
metadata retrieved from the qcrypto functions remain within the defined
limits.

Please let me know what you think.

>> +
>> +    vce->vce_hdr.flags |= DIAG_320_VCE_FLAGS_VALID;
>> +
>> +    /* Update vce length to reflect the actual size used by vce */
>> +    vce->vce_hdr.len = cpu_to_be32(vce_len);
>> +
>> +    return 0;
>> +}
>> +
>> +static VCEntry *diag_320_build_vce(const S390IPLCertificate *cert, int idx)
>> +{
>> +    g_autofree VCEntry *vce = NULL;
>> +    uint32_t vce_max_size;
>> +    int rc;
>> +
>> +    /*
>> +     * Each field of the VCE is word-aligned.
>> +     * Allocate enough space for the largest possible size for this VCE.
>> +     * As the certificate fields (key-id, hash, data) are parsed, the
>> +     * VCE's length field will be updated accordingly.
>> +     */
>> +    vce_max_size = sizeof(VCEntryHeader) +
>> +                   ROUND_UP(CERT_KEY_ID_LEN, 4) +
>> +                   ROUND_UP(CERT_HASH_LEN, 4) +
>> +                   ROUND_UP(cert->der_size, 4);
> In Patch 10, we define MAX_ENTRY_SIZE.  Is that something different than 
> this?
> Let's use the constant here unless there is a specific reason not to.
> 
>> +
>> +    vce = g_malloc0(vce_max_size);
>> +    rc = build_vce_header(vce, cert, idx);
>> +    if (rc) {
>> +        /*
>> +         * Error occurs - VCE does not contain a valid certificate.
>> +         * Bit 0 of the VCE flags is 0 and the VCE length is set.
>> +         */
>> +        vce->vce_hdr.len = cpu_to_be32(VCE_INVALID_LEN);
>> +        goto out;
>> +    }
>> +
>> +    vce->vce_hdr.len = cpu_to_be32(vce_max_size);
> It is not obvious later in the code if the VCE length is a true value or a
> place holder for the max size, so MAX_ENTRY_SIZE would help clarify also.
> 
>> +    rc = build_vce_data(vce, cert);
>> +    if (rc) {
>> +        vce->vce_hdr.len = cpu_to_be32(VCE_INVALID_LEN);
>> +    }
>> +
>> +out:
>> +    return g_steal_pointer(&vce);
>> +}
> Actually, I wonder if we might be able to remove the diag_320_build_vce()
> function since it is basically just a wrapper for building the header 
> and data.
> 
> If we introduce the MAX_ENTRY_SIZE constant and allocate memory before 
> calling
> the build functions, I think we can simplify the whole thing.
> 
> See notes below in the loop to build VCEs...
> 
>> +
>> +static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
>> +                                   S390IPLCertificateStore *cs)
>> +{
>> +    g_autofree VCBlock *vcb = NULL;
>> +    size_t remaining_space;
>> +    uint16_t first_vc_index;
>> +    uint16_t last_vc_index;
>> +    int cs_start_index;
>> +    int cs_end_index;
>> +    uint32_t in_len;
>> +
>> +    vcb = g_new0(VCBlock, 1);
>> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb, sizeof(*vcb))) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        return -1;
>> +    }
> This is only the VCB header, right?  That's all the space is allocated for
> anyway.  I find it confusing, here is my understanding, please correct 
> if wrong:
> 
> We are allocating a VCB and updating the header values, but we never 
> populate
> the VCB's buffer area because each VCE being built has it's own malloc call?
> 
> Meaning when we read/write the VCB it is actually just the header, and 
> the VCEs
> are written independently?
> 
> If that is correct, then we never really build a full VCB right? Could 
> we just
> use the VCBHeader struct here instead to make that clear?
> 

Yes, you're correct. We only build the VCB header here, and each VCE is
allocated separately and appended after the header one by one.

I’ll update it to use the VCBHeader struct here to make that clearer.

>> +
>> +    in_len = be32_to_cpu(vcb->vcb_hdr.in_len);
>> +    first_vc_index = be16_to_cpu(vcb->vcb_hdr.first_vc_index);
>> +    last_vc_index = be16_to_cpu(vcb->vcb_hdr.last_vc_index);
>> +
>> +    if (in_len % TARGET_PAGE_SIZE != 0) {
>> +        return DIAG_320_RC_INVAL_VCB_LEN;
>> +    }
>> +
>> +    if (first_vc_index > last_vc_index) {
>> +        return DIAG_320_RC_BAD_RANGE;
>> +    }
>> +
>> +    vcb->vcb_hdr.out_len = sizeof(VCBlockHeader);
>> +
>> +    /*
>> +     * DIAG 320 subcode 2 expects to query a certificate store that
>> +     * maintains an index origin of 1. However, the S390IPLCertificateStore
>> +     * maintains an index origin of 0. Thus, the indices must be adjusted
>> +     * for correct access into the cert store. A couple of special cases
>> +     * must also be accounted for.
>> +     */
>> +
>> +    /* Both indices are 0; return header with no certs */
>> +    if (first_vc_index == 0 && last_vc_index == 0) {
>> +        goto out;
>> +    }
>> +
>> +    /* Normalize indices */
>> +    cs_start_index = (first_vc_index == 0) ? 0 : first_vc_index - 1;
>> +    cs_end_index = last_vc_index - 1;
>> +
>> +    /* Requested range is outside the cert store; return header with no certs */
>> +    if (cs_start_index >= cs->count || cs_end_index >= cs->count) {
>> +        goto out;
>> +    }
>> +
>> +    remaining_space = in_len - sizeof(VCBlockHeader);
>> +
>> +    for (int i = cs_start_index; i <= cs_end_index; i++) {
>> +        VCEntry *vce;
> What about g_autofree VCEntry *vce = g_malloc0(MAX_ENTRY_SIZE);
> 
> Collin already mentioned using g_autofree, but in addition to that if we can
> allocate the memory up front that would allow us to call the build
> functions directly from here e.g. (untested)
> 
>      if (build_vce_header(vce, cert, i) || build_vce_data(vce, cert) {
>          vce->vce_hdr.len = cpu_to_be32(VCE_INVALID_LEN);
>      }
> 
> That would avoid the frees and steal pointer too.
> 
>> +        const S390IPLCertificate *cert = &cs->certs[i];
>> +
>> +        /*
>> +         * Bit 0 of the VCE flags indicates whether the certificate is valid.
>> +         * The caller of DIAG320 subcode 2 is responsible for verifying that
>> +         * the VCE contains a valid certificate.
>> +         */
>> +        vce = diag_320_build_vce(cert, i);
>> +
>> +        /*
>> +         * If there is no more space to store the cert,
>> +         * set the remaining verification cert count and
>> +         * break early.
>> +         */
>> +        if (remaining_space < vce->vce_hdr.len) {
>> +            vcb->vcb_hdr.remain_ct = cpu_to_be16(last_vc_index - i);
>> +            g_free(vce);
>> +            break;
>> +        }
>> +
>> +        /* Write VCE */
>> +        if (s390_cpu_virt_mem_write(cpu, addr + vcb->vcb_hdr.out_len, r1,
>> +                                    vce, vce->vce_hdr.len)) {
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +            g_free(vce);
>> +            return -1;
>> +        }
>> +
>> +        vcb->vcb_hdr.out_len += vce->vce_hdr.len;
>> +        remaining_space -= vce->vce_hdr.len;
>> +        vcb->vcb_hdr.stored_ct++;
>> +
>> +        g_free(vce);
>> +    }
>> +    vcb->vcb_hdr.stored_ct = cpu_to_be16(vcb->vcb_hdr.stored_ct);
>> +
>> +out:
>> +    vcb->vcb_hdr.out_len = cpu_to_be32(vcb->vcb_hdr.out_len);
>> +
>> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, sizeof(VCBlockHeader))) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        return -1;
>> +    }
>> +
>> +    return DIAG_320_RC_OK;
>> +}
>> +
>>   QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != VCSSB_MIN_LEN,
>>                      "size of VCStorageSizeBlock is wrong");
>> +QEMU_BUILD_BUG_MSG(sizeof(VCBlock) != 64, "size of VCBlock is wrong");
>> +QEMU_BUILD_BUG_MSG(sizeof(VCEntry) != 128, "size of VCEntry is wrong");
>>   
>>   void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>   {
>> @@ -270,7 +594,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>            * for now.
>>            */
>>           uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
>> -                                         DIAG_320_ISM_QUERY_VCSI);
>> +                                         DIAG_320_ISM_QUERY_VCSI |
>> +                                         DIAG_320_ISM_STORE_VC);
>>   
>>           if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
>>               s390_cpu_virt_mem_handle_exc(cpu, ra);
>> @@ -296,6 +621,18 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>           }
>>           env->regs[r1 + 1] = rc;
>>           break;
>> +    case DIAG_320_SUBC_STORE_VC:
>> +        if (addr & ~TARGET_PAGE_MASK) {
>> +            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +            return;
>> +        }
>> +
>> +        rc = handle_diag320_store_vc(cpu, addr, r1, ra, cs);
>> +        if (rc == -1) {
>> +            return;
>> +        }
>> +        env->regs[r1 + 1] = rc;
>> +        break;
>>       default:
>>           env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
>>           break;
> Regards,
> Jared Rossi


