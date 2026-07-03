Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A41C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTdS-0007g2-RK; Thu, 02 Jul 2026 22:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfTdQ-0007fG-VU; Thu, 02 Jul 2026 22:28:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfTdO-0002d6-Jg; Thu, 02 Jul 2026 22:28:08 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631IrEE1199273; Fri, 3 Jul 2026 02:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CJypsP
 08zOM5XFhCNYMzeN0vMqrlQ2j5z+LzOZigM3U=; b=n3d8ZI5PO9k5K/WCZqWlvU
 yhb8HULp/AH9FbBKZc6DbkWUnBB1njvSfhSvPFDj0Ym3L3xYgsqhApKTKY31y7zT
 KcOijvyuIIBHWzJcno6W0tQWaenXLCU+33DYoQ13GpnmiwiDQ3F55I9E5z4pfkCP
 BQCjKvRmRLQN2YpYt3HKZnyT/JvfIcU4pdvaPUQnZBboWLBphqBejCOjT7UqvOpR
 hA08p7qsxXW/dczid5tv0GqD4/Q+COKDjAJoVSY8LRjCG6uRsJ4prqac0C+pog32
 xASzjaTlKIkXSIP3nEBLJzBOPi6Wip+76CMoMt3VIZMDJODhHmNXQRQzSGFLkU5Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rfcdp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:28:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632Jfg4021814;
 Fri, 3 Jul 2026 02:28:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukertk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:28:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632RxjS22348406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:27:59 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D74E58058;
 Fri,  3 Jul 2026 02:27:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE5BE58057;
 Fri,  3 Jul 2026 02:27:57 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:27:57 +0000 (GMT)
Message-ID: <68e6ed9dbe0f48274d8cd6b8ef1ec75555f7180a.camel@linux.ibm.com>
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
Date: Thu, 02 Jul 2026 22:27:57 -0400
In-Reply-To: <efefd0a4-e40e-4555-9e1b-5cdd1edb55c5@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-27-zycai@linux.ibm.com>
 <2648e0272c9a8b9d5c5667a85a303f63b54ecb3a.camel@linux.ibm.com>
 <efefd0a4-e40e-4555-9e1b-5cdd1edb55c5@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a471e31 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=cG211jZ1XAp2nIG6UvUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5SEwwIIl_3ACQFbixFnEflTEUAagkMHD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX/4weeurziivq
 r+OoMZvVEsnHCbD38rR/pWPvrhn8Kf3QElucC3BWJTyMiMn+ObM5wvppJEKrRX9vYFK66A2R+M6
 CQbcYmcGvgBkRRuFvllWUafzkYYvRaOhhDdtKcQ7+SVT/tacw/9ugy7iRv/wjSJld5rqEvBeLsb
 hZxvaeX1iAqM2pISADkAZ3o0Vd5qK8My0E1wHJQFI/halV/mV9E6Dghr/cpfUTcvyMedLXFtV6E
 vvIYcdcJBA8xn0DYjBa5vI+f1DEh1sQhcjtg+/Z4uNUXWc0rgutd2Q5a/gXXTkz5fWbQvSxOEEt
 ihuoXdH1yd+oD61ed49XVGGCND+SVlZRR76Q/3D51+8v+z1lvnEnuFqG+CPBAaiddouvP/xq/ZD
 dAzMx+qUwOrElWLP4ZPa9wNiqn6ZoJrzoMSWaa6aOS+aNUg3XvDh2CGgPV9qrNT5b4oMNdY9USS
 flNi0I8yUiOQitpMNbA==
X-Proofpoint-GUID: 5SEwwIIl_3ACQFbixFnEflTEUAagkMHD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX5/Gd1mzVzfK5
 5OTyqH3i6yKDPmfkGycFeUrCxr/2+St6AVrHQxesRACWEFatq0omZgRQoXT37ei5zuCmZgmJ/qB
 4/+0gTTtlTNLQleeTrVWr/XxpsGMTsE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 2026-07-02 at 16:47 -0400, Zhuoying Cai wrote:
> Thanks for the review!
>=20
> On 7/2/26 12:08 PM, Eric Farman wrote:
> > On Wed, 2026-07-01 at 16:49 -0400, Zhuoying Cai wrote:
> > > Add additional checks to ensure that components do not overlap with
> > > signed components when loaded into memory.
> > >=20
> > > Add additional checks to ensure the load addresses of unsigned compon=
ents
> > > are greater than or equal to 0x2000.
> > >=20
> > > When the secure IPL code loading attributes facility (SCLAF) is insta=
lled,
> > > all signed components must contain a secure code loading attributes b=
lock
> > > (SCLAB).
> > >=20
> > > The SCLAB provides further validation of information on where to load=
 the
> > > signed binary code from the load device, and where to start the execu=
tion
> > > of the loaded OS code.
> > >=20
> > > When SCLAF is installed, its content must be evaluated during secure =
IPL.
> > >=20
> > > Add IPL Information Error Indicators (IIEI) and Component Error
> > > Indicators (CEI) for IPL Information Report Block (IIRB).
> > >=20
> > > When SCLAF is installed, additional secure boot checks are performed
> > > during zipl and store results of verification into IIRB.
> > >=20
> > > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > > ---
> > >  include/hw/s390x/ipl/qipl.h   |  29 +++++-
> > >  pc-bios/s390-ccw/sclp.h       |   1 +
> > >  pc-bios/s390-ccw/secure-ipl.c | 170 ++++++++++++++++++++++++++++++++=
+-
> > >  pc-bios/s390-ccw/secure-ipl.h |  51 ++++++++++
> > >  4 files changed, 246 insertions(+), 5 deletions(-)
> > >=20
>=20
> [...]
>=20
> > > +static void check_sclab(SclaBlock **global_sclab,
> > > +                        IplDeviceComponentEntry *comp_entry,
> > > +                        IplInfoBlockHeader *comp_list_hdr)
> > > +{
> > > +    SclabOriginLocator *sclab_locator;
> > > +    SclaBlock *sclab;
> > > +
> > > +    /* sclab locator is located at the last 8 bytes of the signed co=
mp */
> > > +    sclab_locator =3D (SclabOriginLocator *)(comp_entry->addr +
> > > +                                           comp_entry->len - 8);
> >=20
> > Need to verify that len >=3D8, otherwise who knows what gets read.
> >=20
> > > +
> > > +    /* return early if sclab does not exist */
> > > +    zipl_secure_validate(magic_match(sclab_locator->magic, ZIPL_MAGI=
C),
> > > +                         &comp_entry->cei, S390_CEI_INVALID_SCLAB,
> > > +                         "Magic does not match. SCLAB does not exist=
");
> > > +
> > > +    if (comp_entry->cei & S390_CEI_INVALID_SCLAB) {
> > > +        return;
> > > +    }
> > > +
> > > +    zipl_secure_validate(sclab_locator->len >=3D S390_SCLAB_MIN_LEN,=
 &comp_entry->cei,
> > > +                         S390_CEI_INVALID_SCLAB_LEN | S390_CEI_INVAL=
ID_SCLAB,
> > > +                         "Invalid SCLAB length");
> > > +
> > > +    /* return early if sclab is invalid */
> > > +    if (comp_entry->cei & S390_CEI_INVALID_SCLAB) {
> > > +        return;
> > > +    }
> >=20
> > I get why these two conditions (missing/invalid SCLAB) cause us to stop=
 processing when in audit
> > mode...
> >=20
> > > +
> > > +    sclab =3D (SclaBlock *)(comp_entry->addr + comp_entry->len -
> > > +                          sclab_locator->len);
> > > +
> > > +    zipl_secure_validate(sclab->format =3D=3D 0, &comp_entry->cei,
> > > +                         S390_CEI_INVALID_SCLAB_FORMAT,
> > > +                         "Format-0 SCLAB is not being used");
> >=20
> > ...but why doesn't this one (SCLAB format)? Do the subsequent flags che=
cks all apply regardless of
> > format?
> >=20
>=20
> Continuing with the flag checks seems reasonable to me, since we're
> still dealing with some form of valid SCLAB. Please let me know your
> thoughts. Thanks!

Agreed. The flag checks apply regardless of format, which I overlooked prev=
iously.

>=20
> > > +
> > > +    if (!(sclab->flags & S390_SCLAB_OPSW)) {
> > > +        /* OPSW =3D 0 - Load PSW field in SCLAB must contain zeros *=
/
> > > +        zipl_secure_validate(sclab->load_psw =3D=3D 0, &comp_entry->=
cei,
> > > +                             S390_CEI_SCLAB_LOAD_PSW_NOT_ZERO,
> > > +                             "Load PSW is not zero when Override PSW=
 bit is zero");
> > > +    } else {
> > > +        /* OPSW =3D 1 indicating global SCLAB */
> > > +        if (*global_sclab) {
> > > +            comp_list_hdr->iiei |=3D S390_IIEI_MORE_GLOBAL_SCLAB;
> > > +            zipl_secure_error("More than one global SCLAB");
> > > +        }
> > > +        *global_sclab =3D sclab;
> > > +
> > > +        /* override load address flag must set to one */
> > > +        zipl_secure_validate(sclab->flags & S390_SCLAB_OLA, &comp_en=
try->cei,
> > > +                             S390_CEI_SCLAB_OLA_NOT_ONE,
> > > +                             "OLA flag is not set to one in the glob=
al SCLAB");
> > > +    }
> > > +
> > > +    if (!(sclab->flags & S390_SCLAB_OLA)) {
> > > +        /* OLA =3D 0 - Load address field in SCLAB must contain zero=
s */
> > > +        zipl_secure_validate(sclab->load_addr =3D=3D 0, &comp_entry-=
>cei,
> > > +                             S390_CEI_SCLAB_LOAD_ADDR_NOT_ZERO,
> > > +                             "Load Address is not zero when OLA flag=
 is zero");
> > > +    } else {
> > > +        /* OLA =3D 1 - Load address field must match storage address=
 of the component */
> > > +        zipl_secure_validate(sclab->load_addr =3D=3D comp_entry->add=
r, &comp_entry->cei,
> > > +                             S390_CEI_UNMATCHED_SCLAB_LOAD_ADDR,
> > > +                             "Load Address does not match with compo=
nent load address");
> > > +    }
> > > +
> > > +    zipl_secure_validate(~sclab->flags & S390_SCLAB_NUC || sclab->fl=
ags & S390_SCLAB_OPSW,
> > > +                         &comp_entry->cei, S390_CEI_NUC_NOT_IN_GLOBA=
L_SCLAB,
> > > +                         "NUC bit is set, but not in the global SCLA=
B");
> > > +
> > > +    zipl_secure_validate(~sclab->flags & S390_SCLAB_SC || sclab->fla=
gs & S390_SCLAB_OPSW,
> > > +                         &comp_entry->cei, S390_CEI_SC_NOT_IN_GLOBAL=
_SCLAB,
> > > +                         "SC bit is set, but not in the global SCLAB=
");
> > > +}
> > > +
> > >  static int zipl_load_signature(ComponentEntry *entry, uint64_t sig)
> > >  {
> > >      if (entry->compdat.sig_info.format !=3D DER_SIGNATURE_FORMAT) {
> > > @@ -268,6 +415,8 @@ int zipl_run_secure(ComponentEntry **entry_ptr, u=
int8_t *tmp_sec,
> > >      uint8_t *tmp_buf;
> > >      bool verified;
> > >      bool signed_found =3D false;
> > > +    bool sclab_found =3D false;
> > > +    SclaBlock *global_sclab =3D NULL;
> > > =20
> > >      if ((MAX_SIGNED_COMP * CERT_BUF_MAX_LEN) > (CERT_BUF_SIZE)) {
> > >          panic("Not enough memory to store certificates");
> > > @@ -308,6 +457,10 @@ int zipl_run_secure(ComponentEntry **entry_ptr, =
uint8_t *tmp_sec,
> > > =20
> > >              /* no signature present (unsigned component) */
> > >              if (!sig_entry.len) {
> > > +                zipl_secure_validate(comp_entry.addr >=3D S390_UNSIG=
NED_MIN_ADDR,
> > > +                            &comp_entry.cei, S390_CEI_INVALID_UNSIGN=
ED_ADDR,
> > > +                            "Load address for unsigned component is =
less than 0x2000");
> > > +
> > >                  comp_list_add(comp_list, comp_entry);
> > >                  break;
> > >              }
> > > @@ -319,6 +472,9 @@ int zipl_run_secure(ComponentEntry **entry_ptr, u=
int8_t *tmp_sec,
> > >              comp_entry.flags =3D S390_IPL_DEV_COMP_FLAG_SC;
> > >              signed_found =3D true;
> > > =20
> > > +            check_sclab(&global_sclab, &comp_entry, &comp_list->ipl_=
info_header);
> > > +            sclab_found |=3D !(comp_entry.cei & S390_CEI_INVALID_SCL=
AB);
> > > +
> > >              cert_entry =3D (IplSignatureCertificateEntry) { 0 };
> > >              verified =3D verify_signature(comp_entry, sig_entry,
> > >                                          &cert_entry.len, &cert_table=
_idx);
> > > @@ -364,9 +520,17 @@ int zipl_run_secure(ComponentEntry **entry_ptr, =
uint8_t *tmp_sec,
> > >          }
> > >      }
> > > =20
> > > -    if (!signed_found) {
> > > -        zipl_secure_error("Secure boot is on, but components are not=
 signed");
> > > -    }
> > > +    zipl_secure_validate(signed_found, &comp_list->ipl_info_header.i=
iei,
> > > +                         S390_IIEI_NO_SIGNED_COMP,
> > > +                         "Secure boot is on, but components are not =
signed");
> > > +
> > > +    zipl_secure_validate(sclab_found, &comp_list->ipl_info_header.ii=
ei,
> > > +                         S390_IIEI_NO_SCLAB, "No recognizable SCLAB"=
);
> > > +
> > > +    comp_entry =3D (IplDeviceComponentEntry){ 0 };
> > > +    comp_entry.addr =3D entry->compdat.load_psw;
> > > +    check_global_sclab(global_sclab, &comp_entry, comp_list);
> > > +    comp_list_add(comp_list, comp_entry);
> >=20
> > Do we actually need to add an (empty) entry when global_sclab wasn't fo=
und?
> >=20
>=20
> I think we should still add this entry even when global_sclab is not
> found, since the comp_entry would still contain the PSW value from the
> EXEC entry.

Works for me. Thanks!

>=20
> > > =20
> > >      *entry_ptr =3D entry;
> > >      free((void *)sig_entry.addr);
> > > diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-=
ipl.h
> > > index 1b1287858b..1bacb4987a 100644
> > > --- a/pc-bios/s390-ccw/secure-ipl.h
> > > +++ b/pc-bios/s390-ccw/secure-ipl.h
> > > @@ -27,6 +27,33 @@ int zipl_run_secure(ComponentEntry **entry_ptr, ui=
nt8_t *tmp_sec,
> > >                      IplSignatureCertificateList *cert_list,
> > >                      uint8_t **tmp_cert_buf);
> > > =20
> > > +#define S390_SCLAB_OPSW    0x8000   /* override PSW flag */
> > > +#define S390_SCLAB_OLA     0x4000   /* override load address flag */
> > > +#define S390_SCLAB_NUC     0x2000   /* no unsigned components flag *=
/
> > > +#define S390_SCLAB_SC      0x1000   /* single component flag */
> > > +
> > > +#define S390_SCLAB_MIN_LEN      32
> > > +#define S390_UNSIGNED_MIN_ADDR  0x2000
> > > +
> > > +/* Secure Code Loading Attributes Block */
> > > +struct SclaBlock {
> > > +    uint8_t  format;
> > > +    uint8_t  reserved1;
> > > +    uint16_t flags;
> > > +    uint8_t  reserved2[4];
> > > +    uint64_t load_psw;
> > > +    uint64_t load_addr;
> > > +    uint64_t reserved3[];
> > > +} __attribute__ ((packed));
> > > +typedef struct SclaBlock SclaBlock;
> > > +
> > > +struct SclabOriginLocator {
> > > +    uint8_t reserved[2];
> > > +    uint16_t len;
> > > +    uint8_t magic[4];
> > > +} __attribute__ ((packed));
> > > +typedef struct SclabOriginLocator SclabOriginLocator;
> > > +
> > >  static inline void zipl_secure_error(const char *message)
> > >  {
> > >      switch (boot_mode) {
> > > @@ -38,6 +65,30 @@ static inline void zipl_secure_error(const char *m=
essage)
> > >      }
> > >  }
> > > =20
> > > +static inline void zipl_secure_validate_u16(bool condition, uint16_t=
 *flags,
> > > +                                            uint16_t flag, const cha=
r *message)
> > > +{
> > > +    if (!condition) {
> > > +        *flags |=3D flag;
> > > +        zipl_secure_error(message);
> > > +    }
> > > +}
> > > +
> > > +static inline void zipl_secure_validate_u32(bool condition, uint32_t=
 *flags,
> > > +                                            uint32_t flag, const cha=
r *message)
> > > +{
> > > +    if (!condition) {
> > > +        *flags |=3D flag;
> > > +        zipl_secure_error(message);
> > > +    }
> > > +}
> > > +
> > > +#define zipl_secure_validate(condition, flags, flag, message)   \
> > > +    _Generic((flags),                                           \
> > > +        uint16_t * : zipl_secure_validate_u16,                  \
> > > +        uint32_t * : zipl_secure_validate_u32                   \
> > > +    )(condition, flags, flag, message)
> > > +
> > >  static inline uint64_t _diag320(void *data, unsigned long subcode)
> > >  {
> > >      register unsigned long addr asm("0") =3D (unsigned long)data;

