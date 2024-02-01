Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A851C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVYKk-0005m7-DY; Thu, 01 Feb 2024 09:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1rVYKi-0005lt-R2; Thu, 01 Feb 2024 09:46:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1rVYKg-0007EV-OZ; Thu, 01 Feb 2024 09:46:28 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 411E1nbH025309; Thu, 1 Feb 2024 14:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : from : to : cc
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=Bmx1ylp55yzqu7ofM8ntA08kJgrzUuPz8INfGq6Cpu0=;
 b=RReZhhHRUivNOYqIcNtL95qqv5gsm4WoyHNDC1j0mEYG1lK5h7nSCoEE+HxHVINXQH7B
 QgB+VjD9WKplRz71QyhWYfqZ1vWcFq/Jlx0FUaEXD8rLHB5zP6Px4dOdd7yYSmiSoDxL
 xnOzYMzchB7uNOB6DjYvWB1L34DbaD3yekVYPk2ce2AVe5iY7o7jTETIRnzI0jK2Bus3
 7EfKgoOeXlB8PZww0Xbgxjo78qNEI3VjoXIGea9+9yxzQXbowdD0q+xUxNLfdFTTnky2
 eu8DIhqRNY3ErIICXIU4RngHICCwwp8dKcc1JOvJA5NVWI5vn213ZVXFPjqFBAzbes3E 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0bswjwcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Feb 2024 14:46:13 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411EaMMi032725;
 Thu, 1 Feb 2024 14:46:12 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0bswjwcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Feb 2024 14:46:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 411CCrtH002190; Thu, 1 Feb 2024 14:46:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5tn09r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Feb 2024 14:46:11 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 411Ek9sc17826416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Feb 2024 14:46:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E793D2004B;
 Thu,  1 Feb 2024 14:46:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2367720040;
 Thu,  1 Feb 2024 14:46:07 +0000 (GMT)
Received: from ltc-boston1.aus.stglabs.ibm.com (unknown [9.40.193.18])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Feb 2024 14:46:06 +0000 (GMT)
Subject: [PATCH v8 0/2] ppc: Enable 2nd DAWR support on Power10
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: danielhb413@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com, groug@kaod.org
Cc: sbhat@linux.ibm.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Date: Thu, 01 Feb 2024 09:46:06 -0500
Message-ID: <170679876639.188422.11634974895844092362.stgit@ltc-boston1.aus.stglabs.ibm.com>
User-Agent: StGit/1.5
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iRI054W2H_NHq0Hl0P9QCWM9u9mpmzCS
X-Proofpoint-ORIG-GUID: YrLDlRNl6zbr6BK1WmvchqTTuPkN-oJx
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010116
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Extends the existing watchpoint facility from TCG DAWR0 emulation to DAWR1 on
Power10 for powernv in the first patch, and for pseries in the second patch
with both TCG and KVM.

---
Changelog:
v7: https://lore.kernel.org/qemu-devel/170063834599.621665.9541440879278084501.stgit@ltcd48-lp2.aus.stglab.ibm.com/
v7->v8:
  - Fixed the missed out ppc_store_dawr* calls.
  - Removed the macros and split the patch into 2 one just enabling the
    facility for powernv and the next one doing the same for pseries guest.
  - The macro removal barely increased the number of lines by 12 as against
    the previous version.

v6: https://lore.kernel.org/qemu-devel/168871963321.58984.15628382614621248470.stgit@ltcd89-lp2/
v6->v7:
  - Sorry about the delay in sending out this version, I have dropped the
    Reviewed-bys as suggested and converted the patch to RFC back again.
  - Added the TCG support. Basically, converted the existing DAWR0 support
    routines into macros for reuse by the DAWR1. Let me know if the macro
    conversions should be moved to a separate independent patch.
  - As the dawr1 works on TCG, the checks in cap_dawr1_apply() report a warning
    now only for P9 or P9 compat modes for both KVM and TCG use cases.
  - 'make test' passes for caps checks. Also, as suggested by Greg Kurz, the
    'make test' after making the DAWR1 default 'on' and updating defaut cpu
    to Power10, shows no failures.

v5: https://lore.kernel.org/all/20210412114433.129702-1-ravi.bangoria@linux.ibm.com/
v5->v6:
  - The other patches in the original series already merged.
  - Rebased to the top of the tree. So, the gen_spr_book3s_310_dbg() is renamed
    to register_book3s_310_dbg_sprs() and moved to cpu_init.c accordingly.
  - No functional changes.

v4: https://lore.kernel.org/r/20210406053833.282907-1-ravi.bangoria@linux.ibm.com
v3->v4:
  - Make error message more proper.

v3: https://lore.kernel.org/r/20210330095350.36309-1-ravi.bangoria@linux.ibm.com
v3->v4:
  - spapr_dt_pa_features(): POWER10 processor is compatible with 3.0
    (PCR_COMPAT_3_00). No need to ppc_check_compat(3_10) for now as
    ppc_check_compati(3_00) will also be true. ppc_check_compat(3_10)
    can be added while introducing pa_features_310 in future.
  - Use error_append_hint() for hints. Also add ERRP_GUARD().
  - Add kvmppc_set_cap_dawr1() stub function for CONFIG_KVM=n.

v2: https://lore.kernel.org/r/20210329041906.213991-1-ravi.bangoria@linux.ibm.com
v2->v3:
  - Don't introduce pa_features_310[], instead, reuse pa_features_300[]
    for 3.1 guests, as there is no difference between initial values of
    them atm.
  - Call gen_spr_book3s_310_dbg() from init_proc_POWER10() instead of
    init_proc_POWER8(). Also, Don't call gen_spr_book3s_207_dbg() from
    gen_spr_book3s_310_dbg() as init_proc_POWER10() already calls it.

v1: https://lore.kernel.org/r/20200723104220.314671-1-ravi.bangoria@linux.ibm.com
v1->v2:
  - Introduce machine capability cap-dawr1 to enable/disable
    the feature. By default, 2nd DAWR is OFF for guests even
    when host kvm supports it. User has to manually enable it
    with -machine cap-dawr1=on if he wishes to use it.
  - Split the header file changes into separate patch. (Sync
    headers from v5.12-rc3)

Shivaprasad G Bhat (2):
      ppc: Enable 2nd DAWR support on Power10 PowerNV machine
      ppc: spapr: Enable 2nd DAWR on Power10 pSeries machine


 hw/ppc/spapr.c           |  7 ++++-
 hw/ppc/spapr_caps.c      | 36 ++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c     | 25 ++++++++++------
 include/hw/ppc/spapr.h   |  6 +++-
 target/ppc/cpu.c         | 45 ++++++++++++++++++++---------
 target/ppc/cpu.h         |  8 ++++--
 target/ppc/cpu_init.c    | 15 ++++++++++
 target/ppc/excp_helper.c | 61 ++++++++++++++++++++++------------------
 target/ppc/helper.h      |  2 ++
 target/ppc/kvm.c         | 12 ++++++++
 target/ppc/kvm_ppc.h     | 12 ++++++++
 target/ppc/machine.c     |  3 +-
 target/ppc/misc_helper.c | 10 +++++++
 target/ppc/spr_common.h  |  2 ++
 target/ppc/translate.c   | 12 ++++++++
 15 files changed, 202 insertions(+), 54 deletions(-)

--
Signature


