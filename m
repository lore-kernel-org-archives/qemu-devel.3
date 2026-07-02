Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A40C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJxz-0000IR-IJ; Thu, 02 Jul 2026 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfJxj-0008Uq-LC; Thu, 02 Jul 2026 12:08:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfJxh-0007pR-1L; Thu, 02 Jul 2026 12:08:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662EIUoF4135107; Thu, 2 Jul 2026 16:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Zk1eTU
 QacHXqMZY3qSZQzytRyfsygGFKe+5tTairZ+c=; b=QuuY/tjFYZJ+7p7AFOxLRL
 p/yvyGi6H9Wuxxr0SPjTMzYg7fYTZ4hgjAO5JjwBHfTdKQnjqTkP4w9uW4dsckXv
 jYpyw3ZVBzaeLAMF4lenmnvJTarCPvjzsBX/Hka6RFQyi8/Nk0E4CxrrMOEvBz8z
 s7UyBpHf1mbkyK29D4fVIPLc+tWUcJFGn0jhJdN/ZXiVeP9TyqdEZAH2N74fTDY+
 izXJoiRp4yLS+RYtTmPirNECkeyvlao5hJM0y5uXGvXJfjI80kduDTMj0V3ee2HT
 tvr/DZn/L1pUMEZ26L7eC/yxxtZkJho9nhGKMHioKkYH0r4aiyOnTGNWio8XkN3Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26peaxfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 16:08:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662G4cBE026668;
 Thu, 2 Jul 2026 16:08:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhymg6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 16:08:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662G8IXV16646858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 16:08:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18A8558050;
 Thu,  2 Jul 2026 16:08:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FF3158045;
 Thu,  2 Jul 2026 16:08:15 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 16:08:15 +0000 (GMT)
Message-ID: <2648e0272c9a8b9d5c5667a85a303f63b54ecb3a.camel@linux.ibm.com>
Subject: Re: [PATCH v12 26/35] pc-bios/s390-ccw: Add additional security
 checks for secure boot
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Thu, 02 Jul 2026 12:08:15 -0400
In-Reply-To: <20260701204922.1320349-27-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-27-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lGllGirWodt25edM1WY_nlEO6rPgU5RM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2NiBTYWx0ZWRfXzQ8iY7uIRPYj
 +pQWkefuzXqynhybDMntUFmrK9Cg5bNzaxYyR+osx5AMHvbSIxjk/n4asKzRwieEgvXORnApTq5
 MvzdjAMTR6mcgh1yS23Hpqhncp85ObQ=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a468cf4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=PfiXzCDCU1Cr7uTv4yoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2NiBTYWx0ZWRfX7cZ8/dpqnIig
 yqrHDnwcDkEX5nuKW5jDvgR1mDi0CZaqsTG1zM+TTJ81EfOL/gIL3dF6UqJxD8nglXwKGudyHfm
 SP2QO2Or9pW+dqa4CJwFYrTWac+xYKZp/kb5c9RMjrTYIPuY/8EADvp4ng+8JSIfRj4LVGeCMHy
 uVeHTBJxNqjj/wO2EwKgTIs1AngQGXtBoQbR1Du7Z06bad5Y14u/w6+hhNjysN97pElpL9qMLEU
 +e5jRR58VPQaXf/dxEzThLMqLUrMuluMJPEo+trfEPnVPD2PTW8jJO0f4kwOZJ5llwvv7ZXLpZo
 VUZBi5sAgQAsn8D9Rp8uFyUZ4zQFGMAVIq9mN81G60Lanvk1xxj1OWa0/2dOxd8xiHyxL1KEV7/
 GMCqPNC/3FEX7U49SkOV6eenxcJZE0cLMnTGRgfJwVEE9pwC9aZeR1qyUfLduTEPRa9D4kCm3GS
 3w1JKuaim5uQ7DM0rlg==
X-Proofpoint-ORIG-GUID: lGllGirWodt25edM1WY_nlEO6rPgU5RM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

On Wed, 2026-07-01 at 16:49 -0400, Zhuoying Cai wrote:
> Add additional checks to ensure that components do not overlap with
> signed components when loaded into memory.
>=20
> Add additional checks to ensure the load addresses of unsigned components
> are greater than or equal to 0x2000.
>=20
> When the secure IPL code loading attributes facility (SCLAF) is installed=
,
> all signed components must contain a secure code loading attributes block
> (SCLAB).
>=20
> The SCLAB provides further validation of information on where to load the
> signed binary code from the load device, and where to start the execution
> of the loaded OS code.
>=20
> When SCLAF is installed, its content must be evaluated during secure IPL.
>=20
> Add IPL Information Error Indicators (IIEI) and Component Error
> Indicators (CEI) for IPL Information Report Block (IIRB).
>=20
> When SCLAF is installed, additional secure boot checks are performed
> during zipl and store results of verification into IIRB.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/qipl.h   |  29 +++++-
>  pc-bios/s390-ccw/sclp.h       |   1 +
>  pc-bios/s390-ccw/secure-ipl.c | 170 +++++++++++++++++++++++++++++++++-
>  pc-bios/s390-ccw/secure-ipl.h |  51 ++++++++++
>  4 files changed, 246 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 2b29dfa8c5..f05c4a7206 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -167,10 +167,20 @@ struct IplInfoReportBlockHeader {
>  };
>  typedef struct IplInfoReportBlockHeader IplInfoReportBlockHeader;
> =20
> +/* IPL Info Error Indicators */
> +#define S390_IIEI_NO_SIGNED_COMP      0x8000 /* bit 0 */
> +#define S390_IIEI_NO_SCLAB            0x4000 /* bit 1 */
> +#define S390_IIEI_NO_GLOBAL_SCLAB     0x2000 /* bit 2 */
> +#define S390_IIEI_MORE_GLOBAL_SCLAB   0x1000 /* bit 3 */
> +#define S390_IIEI_FOUND_UNSIGNED_COMP 0x800 /* bit 4 */
> +#define S390_IIEI_MORE_SIGNED_COMP    0x400 /* bit 5 */
> +
>  struct IplInfoBlockHeader {
>      uint32_t len;
>      uint8_t  type;
> -    uint8_t  reserved1[11];
> +    uint8_t  reserved1[3];
> +    uint16_t iiei;
> +    uint8_t  reserved2[6];
>  };
>  typedef struct IplInfoBlockHeader IplInfoBlockHeader;
> =20
> @@ -194,13 +204,28 @@ typedef struct IplSignatureCertificateList IplSigna=
tureCertificateList;
>  #define S390_IPL_DEV_COMP_FLAG_SC  0x80
>  #define S390_IPL_DEV_COMP_FLAG_CSV 0x40
> =20
> +/* IPL Device Component Error Indicators */
> +#define S390_CEI_INVALID_SCLAB             0x80000000 /* bit 0 */
> +#define S390_CEI_INVALID_SCLAB_LEN         0x40000000 /* bit 1 */
> +#define S390_CEI_INVALID_SCLAB_FORMAT      0x20000000 /* bit 2 */
> +#define S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR 0x10000000 /* bit 3 */
> +#define S390_CEI_UNMATCHED_SCLAB_LOAD_PSW  0x8000000  /* bit 4 */
> +#define S390_CEI_INVALID_LOAD_PSW          0x4000000  /* bit 5 */
> +#define S390_CEI_NUC_NOT_IN_GLOBAL_SCLAB   0x2000000  /* bit 6 */
> +#define S390_CEI_SCLAB_OLA_NOT_ONE         0x1000000  /* bit 7 */
> +#define S390_CEI_SC_NOT_IN_GLOBAL_SCLAB    0x800000   /* bit 8 */
> +#define S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO  0x400000   /* bit 9 */
> +#define S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO   0x200000   /* bit 10 */
> +#define S390_CEI_INVALID_UNSIGNED_ADDR     0x100000   /* bit 11 */
> +
>  struct IplDeviceComponentEntry {
>      uint64_t addr;
>      uint64_t len;
>      uint8_t  flags;
>      uint8_t  reserved1[5];
>      uint16_t cert_index;
> -    uint8_t  reserved2[8];
> +    uint32_t cei;
> +    uint8_t  reserved2[4];
>  };
>  typedef struct IplDeviceComponentEntry IplDeviceComponentEntry;
> =20
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index a8a41cd004..cae65b29b5 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -52,6 +52,7 @@ typedef struct SCCBHeader {
>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
>  #define SCCB_FAC134_DIAG320_BIT 0x4
>  #define SCCB_FAC_IPL_SIPL_BIT   0x4000
> +#define SCCB_FAC_IPL_SCLAF_BIT  0x1000
> =20
>  typedef struct ReadInfo {
>      SCCBHeader h;
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.=
c
> index af98881aa5..c92d8e2aff 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -180,6 +180,12 @@ bool secure_ipl_supported(void)
>          return false;
>      }
> =20
> +    if (!sclp_is_fac_ipl_flag_on(SCCB_FAC_IPL_SCLAF_BIT)) {
> +        puts("Secure IPL Code Loading Attributes Facility is not support=
ed by"
> +             " the hypervisor!");
> +        return false;
> +    }
> +
>      return true;
>  }
> =20
> @@ -210,6 +216,147 @@ static void check_comp_overlap(IplDeviceComponentLi=
st *comp_list,
>      }
>  }
> =20
> +static bool is_psw_valid(uint64_t psw, IplDeviceComponentEntry *comp)
> +{
> +    uint32_t addr =3D psw & 0x7fffffff;
> +
> +    /*
> +     * PSW points within a signed binary code component
> +     *
> +     * Check addr falls within [comp->addr, comp->addr + comp->len - 2],
> +     * ensuring at least 2 bytes (minimum instruction length) remain.
> +     */
> +    return intersects(addr, 1, comp->addr, comp->len - 1);
> +}
> +
> +void check_global_sclab(const SclaBlock *global_sclab,
> +                        IplDeviceComponentEntry *comp_entry,
> +                        IplDeviceComponentList *comp_list)
> +{
> +    bool psw_valid =3D false;
> +    bool global_psw_valid =3D false;
> +    int signed_count =3D 0;
> +    int unsigned_count =3D 0;
> +    IplDeviceComponentEntry *comp;
> +
> +    if (!global_sclab) {
> +        comp_list->ipl_info_header.iiei |=3D S390_IIEI_NO_GLOBAL_SCLAB;
> +        zipl_secure_error("Global SCLAB does not exist");
> +        return;
> +    }
> +
> +    for_each_rb_entry(comp, comp_list) {
> +        if (comp->flags & S390_IPL_DEV_COMP_FLAG_SC) {
> +            psw_valid |=3D is_psw_valid(comp_entry->addr, comp);
> +            global_psw_valid |=3D is_psw_valid(global_sclab->load_psw, c=
omp);
> +            signed_count +=3D 1;
> +        } else {
> +            unsigned_count +=3D 1;
> +        }
> +    }
> +
> +    /* validate load PSW with PSW specified in the final entry */
> +    zipl_secure_validate(psw_valid && global_psw_valid, &comp_entry->cei=
,
> +                         S390_CEI_INVALID_LOAD_PSW, "Invalid PSW");
> +
> +    /* compare load PSW with the PSW specified in component */
> +    zipl_secure_validate(global_sclab->load_psw =3D=3D comp_entry->addr,
> +                         &comp_entry->cei, S390_CEI_UNMATCHED_SCLAB_LOAD=
_PSW,
> +                         "Load PSW does not match with PSW in component"=
);
> +
> +    /* Unsigned components are not allowed if NUC flag is set in the glo=
bal SCLAB */
> +    if ((global_sclab->flags & S390_SCLAB_NUC) && unsigned_count > 0) {
> +        comp_list->ipl_info_header.iiei |=3D S390_IIEI_FOUND_UNSIGNED_CO=
MP;
> +        zipl_secure_error("Unsigned components are not allowed");
> +    }
> +
> +    /*
> +     * Only one signed component is allowed if SC flag is set in the glo=
bal SCLAB
> +     * More than one component in the component table is not allowed
> +     */
> +    if ((global_sclab->flags & S390_SCLAB_SC) &&
> +        (signed_count !=3D 1 || unsigned_count !=3D 0)) {
> +        comp_list->ipl_info_header.iiei |=3D S390_IIEI_MORE_SIGNED_COMP;
> +        zipl_secure_error("Only one signed component is allowed");
> +    }
> +}
> +
> +static void check_sclab(SclaBlock **global_sclab,
> +                        IplDeviceComponentEntry *comp_entry,
> +                        IplInfoBlockHeader *comp_list_hdr)
> +{
> +    SclabOriginLocator *sclab_locator;
> +    SclaBlock *sclab;
> +
> +    /* sclab locator is located at the last 8 bytes of the signed comp *=
/
> +    sclab_locator =3D (SclabOriginLocator *)(comp_entry->addr +
> +                                           comp_entry->len - 8);

Need to verify that len >=3D8, otherwise who knows what gets read.

> +
> +    /* return early if sclab does not exist */
> +    zipl_secure_validate(magic_match(sclab_locator->magic, ZIPL_MAGIC),
> +                         &comp_entry->cei, S390_CEI_INVALID_SCLAB,
> +                         "Magic does not match. SCLAB does not exist");
> +
> +    if (comp_entry->cei & S390_CEI_INVALID_SCLAB) {
> +        return;
> +    }
> +
> +    zipl_secure_validate(sclab_locator->len >=3D S390_SCLAB_MIN_LEN, &co=
mp_entry->cei,
> +                         S390_CEI_INVALID_SCLAB_LEN | S390_CEI_INVALID_S=
CLAB,
> +                         "Invalid SCLAB length");
> +
> +    /* return early if sclab is invalid */
> +    if (comp_entry->cei & S390_CEI_INVALID_SCLAB) {
> +        return;
> +    }

I get why these two conditions (missing/invalid SCLAB) cause us to stop pro=
cessing when in audit
mode...

> +
> +    sclab =3D (SclaBlock *)(comp_entry->addr + comp_entry->len -
> +                          sclab_locator->len);
> +
> +    zipl_secure_validate(sclab->format =3D=3D 0, &comp_entry->cei,
> +                         S390_CEI_INVALID_SCLAB_FORMAT,
> +                         "Format-0 SCLAB is not being used");

...but why doesn't this one (SCLAB format)? Do the subsequent flags checks =
all apply regardless of
format?

> +
> +    if (!(sclab->flags & S390_SCLAB_OPSW)) {
> +        /* OPSW =3D 0 - Load PSW field in SCLAB must contain zeros */
> +        zipl_secure_validate(sclab->load_psw =3D=3D 0, &comp_entry->cei,
> +                             S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO,
> +                             "Load PSW is not zero when Override PSW bit=
 is zero");
> +    } else {
> +        /* OPSW =3D 1 indicating global SCLAB */
> +        if (*global_sclab) {
> +            comp_list_hdr->iiei |=3D S390_IIEI_MORE_GLOBAL_SCLAB;
> +            zipl_secure_error("More than one global SCLAB");
> +        }
> +        *global_sclab =3D sclab;
> +
> +        /* override load address flag must set to one */
> +        zipl_secure_validate(sclab->flags & S390_SCLAB_OLA, &comp_entry-=
>cei,
> +                             S390_CEI_SCLAB_OLA_NOT_ONE,
> +                             "OLA flag is not set to one in the global S=
CLAB");
> +    }
> +
> +    if (!(sclab->flags & S390_SCLAB_OLA)) {
> +        /* OLA =3D 0 - Load address field in SCLAB must contain zeros */
> +        zipl_secure_validate(sclab->load_addr =3D=3D 0, &comp_entry->cei=
,
> +                             S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO,
> +                             "Load Address is not zero when OLA flag is =
zero");
> +    } else {
> +        /* OLA =3D 1 - Load address field must match storage address of =
the component */
> +        zipl_secure_validate(sclab->load_addr =3D=3D comp_entry->addr, &=
comp_entry->cei,
> +                             S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR,
> +                             "Load Address does not match with component=
 load address");
> +    }
> +
> +    zipl_secure_validate(~sclab->flags & S390_SCLAB_NUC || sclab->flags =
& S390_SCLAB_OPSW,
> +                         &comp_entry->cei, S390_CEI_NUC_NOT_IN_GLOBAL_SC=
LAB,
> +                         "NUC bit is set, but not in the global SCLAB");
> +
> +    zipl_secure_validate(~sclab->flags & S390_SCLAB_SC || sclab->flags &=
 S390_SCLAB_OPSW,
> +                         &comp_entry->cei, S390_CEI_SC_NOT_IN_GLOBAL_SCL=
AB,
> +                         "SC bit is set, but not in the global SCLAB");
> +}
> +
>  static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
>  {
>      if (entry->compdat.sig_info.format !=3D DER_SIGNATURE_FORMAT) {
> @@ -268,6 +415,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8=
_t *tmp_sec,
>      uint8_t *tmp_buf;
>      bool verified;
>      bool signed_found =3D false;
> +    bool sclab_found =3D false;
> +    SclaBlock *global_sclab =3D NULL;
> =20
>      if ((MAX_SIGNED_COMP * CERT_BUF_MAX_LEN) > (CERT_BUF_SIZE)) {
>          panic("Not enough memory to store certificates");
> @@ -308,6 +457,10 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint=
8_t *tmp_sec,
> =20
>              /* no signature present (unsigned component) */
>              if (!sig_entry.len) {
> +                zipl_secure_validate(comp_entry.addr >=3D S390_UNSIGNED_=
MIN_ADDR,
> +                            &comp_entry.cei, S390_CEI_INVALID_UNSIGNED_A=
DDR,
> +                            "Load address for unsigned component is less=
 than 0x2000");
> +
>                  comp_list_add(comp_list, comp_entry);
>                  break;
>              }
> @@ -319,6 +472,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8=
_t *tmp_sec,
>              comp_entry.flags =3D S390_IPL_DEV_COMP_FLAG_SC;
>              signed_found =3D true;
> =20
> +            check_sclab(&global_sclab, &comp_entry, &comp_list->ipl_info=
_header);
> +            sclab_found |=3D !(comp_entry.cei & S390_CEI_INVALID_SCLAB);
> +
>              cert_entry =3D (IplSignatureCertificateEntry) { 0 };
>              verified =3D verify_signature(comp_entry, sig_entry,
>                                          &cert_entry.len, &cert_table_idx=
);
> @@ -364,9 +520,17 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint=
8_t *tmp_sec,
>          }
>      }
> =20
> -    if (!signed_found) {
> -        zipl_secure_error("Secure boot is on, but components are not sig=
ned");
> -    }
> +    zipl_secure_validate(signed_found, &comp_list->ipl_info_header.iiei,
> +                         S390_IIEI_NO_SIGNED_COMP,
> +                         "Secure boot is on, but components are not sign=
ed");
> +
> +    zipl_secure_validate(sclab_found, &comp_list->ipl_info_header.iiei,
> +                         S390_IIEI_NO_SCLAB, "No recognizable SCLAB");
> +
> +    comp_entry =3D (IplDeviceComponentEntry){ 0 };
> +    comp_entry.addr =3D entry->compdat.load_psw;
> +    check_global_sclab(global_sclab, &comp_entry, comp_list);
> +    comp_list_add(comp_list, comp_entry);

Do we actually need to add an (empty) entry when global_sclab wasn't found?

> =20
>      *entry_ptr =3D entry;
>      free((void *)sig_entry.addr);
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.=
h
> index 1b1287858b..1bacb4987a 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -27,6 +27,33 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_=
t *tmp_sec,
>                      IplSignatureCertificateList *cert_list,
>                      uint8_t **tmp_cert_buf);
> =20
> +#define S390_SCLAB_OPSW    0x8000   /* override PSW flag */
> +#define S390_SCLAB_OLA     0x4000   /* override load address flag */
> +#define S390_SCLAB_NUC     0x2000   /* no unsigned components flag */
> +#define S390_SCLAB_SC      0x1000   /* single component flag */
> +
> +#define S390_SCLAB_MIN_LEN      32
> +#define S390_UNSIGNED_MIN_ADDR  0x2000
> +
> +/* Secure Code Loading Attributes Block */
> +struct SclaBlock {
> +    uint8_t  format;
> +    uint8_t  reserved1;
> +    uint16_t flags;
> +    uint8_t  reserved2[4];
> +    uint64_t load_psw;
> +    uint64_t load_addr;
> +    uint64_t reserved3[];
> +} __attribute__ ((packed));
> +typedef struct SclaBlock SclaBlock;
> +
> +struct SclabOriginLocator {
> +    uint8_t reserved[2];
> +    uint16_t len;
> +    uint8_t magic[4];
> +} __attribute__ ((packed));
> +typedef struct SclabOriginLocator SclabOriginLocator;
> +
>  static inline void zipl_secure_error(const char *message)
>  {
>      switch (boot_mode) {
> @@ -38,6 +65,30 @@ static inline void zipl_secure_error(const char *messa=
ge)
>      }
>  }
> =20
> +static inline void zipl_secure_validate_u16(bool condition, uint16_t *fl=
ags,
> +                                            uint16_t flag, const char *m=
essage)
> +{
> +    if (!condition) {
> +        *flags |=3D flag;
> +        zipl_secure_error(message);
> +    }
> +}
> +
> +static inline void zipl_secure_validate_u32(bool condition, uint32_t *fl=
ags,
> +                                            uint32_t flag, const char *m=
essage)
> +{
> +    if (!condition) {
> +        *flags |=3D flag;
> +        zipl_secure_error(message);
> +    }
> +}
> +
> +#define zipl_secure_validate(condition, flags, flag, message)   \
> +    _Generic((flags),                                           \
> +        uint16_t * : zipl_secure_validate_u16,                  \
> +        uint32_t * : zipl_secure_validate_u32                   \
> +    )(condition, flags, flag, message)
> +
>  static inline uint64_t _diag320(void *data, unsigned long subcode)
>  {
>      register unsigned long addr asm("0") =3D (unsigned long)data;

