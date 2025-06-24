Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCBAC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7Td-0003hi-Me; Tue, 24 Jun 2025 13:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1uU7TT-0003gH-37; Tue, 24 Jun 2025 13:30:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1uU7TP-0008FH-IJ; Tue, 24 Jun 2025 13:30:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O9WDEN025036;
 Tue, 24 Jun 2025 17:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=otPvO1
 XodxdIBZhSJj7wep9HL1Bqw5nVnTA5HyLDMIU=; b=JkUITr5ZmzIg5s8Y+eqbKb
 DGdx8e9ScNhDVmxC8ViDL9ZmYzrXs4Mx+Tpp171nM3ggAK42xrSQzK//mZYDAwbn
 Icm75CSwexIvr0a42UaQJdE0CaN1zucLwdepsP8+93otrO1bSygKfjyr9VVfz5ZS
 OaiUcNPY6EyBk1yNxaWakT1kXGAqMDGdD747h5D0x0K4Vk5wDxokfCYwYKUrUSM5
 EiKKNhTy245/m9LhnOY4wqpTPkgeTGuwfSHsEHwFvGeKZU1/CuVGPA4O4w/MFOoy
 TLYdZiFjsGIvXTxZT7KTdfJbu8565Oq60pUSQZi18xLElaxm8UdsRWgZRm0q+waw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk63t2ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 17:30:13 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55OHPCDL022774;
 Tue, 24 Jun 2025 17:30:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk63t2u6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 17:30:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55ODvWG0031277;
 Tue, 24 Jun 2025 17:30:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eyw8dm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 17:30:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55OHUAsT19530344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 17:30:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCCE758061;
 Tue, 24 Jun 2025 17:30:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EC3F58060;
 Tue, 24 Jun 2025 17:30:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Jun 2025 17:30:08 +0000 (GMT)
Message-ID: <e103dc28-46d9-4a74-9e03-bc16cf9061bb@linux.ibm.com>
Date: Tue, 24 Jun 2025 13:30:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] backends/tpm: Propagate vTPM error on migration
 failure
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
 <20250624-propagate_tpm_error-v1-3-2171487a593d@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250624-propagate_tpm_error-v1-3-2171487a593d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE0MyBTYWx0ZWRfX41rgzL/RBO76
 CRyAE4sI3TJ5jUADPmbvW4CRNMu7PaoLrki6DFMse820xdLQHYzqvQY9lTsbs8O253sD9FvbTgu
 lvq1SpEiNvxGGZEV7rDMaqZ2JMKz20fk1DR/EIgofYdhhNACKjjDTxF4+4mwCcKQYw7m+WaaShi
 okB+RHfpGhqZZzeQMTxu3K4uOWMhpQxdB9LNAlPUtcJ33iYcEpa5bPRlxbSerZU/nFfsQCWUmuj
 /EDFTefjIBQoht/3LVbEzCUFtJ7sWrhRHcHL2Rp/LbePivKTmtZC1gP5qlmFXlBjezjICtNmZNv
 Wh9AzrbEwK97GOi+ggCzIDhaeZxVj23WqtsIdY0nUS5nBKJPxCbTrte9SooWh+oNKKWGT7eTkNT
 AiZfw+OLdS40dFDLyDIX4IKReriQH/eG9p41FiaKbqFnkDXWZ82ftX6D5QciAYYoYe6aPWMz
X-Proofpoint-ORIG-GUID: _3Qoc0mt85zGpr4644TH6KoAOi3ScIAv
X-Proofpoint-GUID: GAWub4EsHlZ13ZnScBKd_XQpzoEfJWDP
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685ae0a5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=q8dJGX2VtPoojEl89u8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240143
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 6/24/25 8:23 AM, Arun Menon wrote:
> - Introduce a new post_load_with_error() hook that will
>    take in the Error object as a parameter.
> - This error object is set if the loading of state fails.
> - The error can then be retrieved using QMP command
>    {"execute" : "query-migrate"}
> 
> Buglink: https://issues.redhat.com/browse/RHEL-82826
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   backends/tpm/tpm_emulator.c | 39 ++++++++++++++++++++-------------------
>   include/migration/vmstate.h |  1 +
>   migration/vmstate.c         |  4 +++-
>   3 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 4a234ab2c0b19b2604bf0dd8cb5f4540c72a9438..816134d7b4de00a75a3d0b928d160595b17be810 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -819,7 +819,8 @@ static int tpm_emulator_get_state_blobs(TPMEmulator *tpm_emu)
>   static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>                                          uint32_t type,
>                                          TPMSizedBuffer *tsb,
> -                                       uint32_t flags)
> +                                       uint32_t flags,
> +                                       Error **errp)
>   {
>       ssize_t n;
>       ptm_setstate pss;
> @@ -838,17 +839,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>       /* write the header only */
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
>                                offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
> -        error_report("tpm-emulator: could not set state blob type %d : %s",
> -                     type, strerror(errno));
> +        error_setg(errp, "tpm-emulator: could not set state blob type %d : %s",
> +                   type, strerror(errno));
>           return -1;
>       }
> 
>       /* now the body */
>       n = qemu_chr_fe_write_all(&tpm_emu->ctrl_chr, tsb->buffer, tsb->size);
>       if (n != tsb->size) {
> -        error_report("tpm-emulator: Writing the stateblob (type %d) "
> -                     "failed; could not write %u bytes, but only %zd",
> -                     type, tsb->size, n);
> +        error_setg(errp, "tpm-emulator: Writing the stateblob (type %d) "
> +                   "failed; could not write %u bytes, but only %zd",
> +                   type, tsb->size, n);
>           return -1;
>       }
> 
> @@ -856,17 +857,17 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>       n = qemu_chr_fe_read_all(&tpm_emu->ctrl_chr,
>                                (uint8_t *)&pss, sizeof(pss.u.resp));
>       if (n != sizeof(pss.u.resp)) {
> -        error_report("tpm-emulator: Reading response from writing stateblob "
> -                     "(type %d) failed; expected %zu bytes, got %zd", type,
> -                     sizeof(pss.u.resp), n);
> +        error_setg(errp, "tpm-emulator: Reading response from writing "
> +                   "stateblob (type %d) failed; expected %zu bytes, "
> +                   "got %zd", type, sizeof(pss.u.resp), n);
>           return -1;
>       }
> 
>       tpm_result = be32_to_cpu(pss.u.resp.tpm_result);
>       if (tpm_result != 0) {
> -        error_report("tpm-emulator: Setting the stateblob (type %d) failed "
> -                     "with a TPM error 0x%x %s", type, tpm_result,
> -                     tpm_emulator_strerror(tpm_result));
> +        error_setg(errp, "tpm-emulator: Setting the stateblob (type %d) "
> +                   "failed with a TPM error 0x%x %s", type, tpm_result,
> +                   tpm_emulator_strerror(tpm_result));
>           return -1;
>       }
> 
> @@ -880,7 +881,7 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>    *
>    * Returns a negative errno code in case of error.
>    */
> -static int tpm_emulator_set_state_blobs(TPMBackend *tb)
> +static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
>   {
>       TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>       TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
> @@ -894,13 +895,13 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb)
> 
>       if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
>                                       &state_blobs->permanent,
> -                                    state_blobs->permanent_flags) < 0 ||
> +                                    state_blobs->permanent_flags, errp) < 0 ||
>           tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_VOLATILE,
>                                       &state_blobs->volatil,
> -                                    state_blobs->volatil_flags) < 0 ||
> +                                    state_blobs->volatil_flags, errp) < 0 ||
>           tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
>                                       &state_blobs->savestate,
> -                                    state_blobs->savestate_flags) < 0) {
> +                                    state_blobs->savestate_flags, errp) < 0) {
>           return -EIO;
>       }
> 
> @@ -948,12 +949,12 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
>    *
>    * Returns negative errno codes in case of error.
>    */
> -static int tpm_emulator_post_load(void *opaque, int version_id)
> +static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>   {
>       TPMBackend *tb = opaque;
>       int ret;
> 
> -    ret = tpm_emulator_set_state_blobs(tb);
> +    ret = tpm_emulator_set_state_blobs(tb, errp);
>       if (ret < 0) {
>           return ret;
>       }
> @@ -969,7 +970,7 @@ static const VMStateDescription vmstate_tpm_emulator = {
>       .name = "tpm-emulator",
>       .version_id = 0,
>       .pre_save = tpm_emulator_pre_save,
> -    .post_load = tpm_emulator_post_load,
> +    .post_load_with_error = tpm_emulator_post_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
>           VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 056781b1c21e737583f081594d9f88b32adfd674..1c6e89c3b08a3914cde6dce3be5955978b6b7d0b 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -207,6 +207,7 @@ struct VMStateDescription {
>       MigrationPriority priority;
>       int (*pre_load)(void *opaque);
>       int (*post_load)(void *opaque, int version_id);
> +    int (*post_load_with_error)(void *opaque, int version_id, Error **errp);
>       int (*pre_save)(void *opaque);
>       int (*post_save)(void *opaque);
>       bool (*needed)(void *opaque);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 3f8c3d3c1dcfe14d70bab1f43b827244eb4bb385..c5dfffd9bad7285e819d4769e055d47157caab34 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -232,7 +232,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           qemu_file_set_error(f, ret);
>           return ret;
>       }
> -    if (vmsd->post_load) {
> +    if (vmsd->post_load_with_error) {
> +        ret = vmsd->post_load_with_error(opaque, version_id, errp);
> +    } else if (vmsd->post_load) {
>           ret = vmsd->post_load(opaque, version_id);
>       }
>       trace_vmstate_load_state_end(vmsd->name, "end", ret);
> 


