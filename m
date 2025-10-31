Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7DECCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 17:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEsqD-0007If-3s; Fri, 31 Oct 2025 13:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEsq7-0007Hw-4P
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 13:23:04 -0400
Received: from p-east3-cluster2-host6-snip4-4.eps.apple.com ([57.103.87.185]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEspu-0003kX-HL
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 13:23:02 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-1 (Postfix) with ESMTPS id
 F01F3180026C; Fri, 31 Oct 2025 17:22:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=2zeQjLCx4tfHex0UeNRAfrDHk9b9IXtShtlCGu4Wcc8=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=YiQjATh8vkUip9gT8RVtuCGTqlF6HLh5X2/A1fs8eeNzjmliAZY68wOlKVGSjeiogznCByoYLfjtjWD8tLaTcoQ7FW6D/iYtQmrwkju1R7U+MrJU5avKzsWZO2mwNRlD8tr5v1JoWRBGJioPEDjQP+XRi9MGmy4Hv5vCRAHotIw7Zf2cWYUtwKzQhvdzCwM2KYb9KJz1ho7B6m88Sk+ukT+7xk1DlVKv0+2yQmBYELrq4g+azQ0nU/TWJxVYk2yDFy0LeGA0KIsi7TCXGlKSBF8Bkn1kVPAhy1Beain9OjovnoIc+c4pv5tokE/MLg0Xv+lajyX44kBepCqYhivi1A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-1 (Postfix) with ESMTPSA id
 BBA4A180011F; Fri, 31 Oct 2025 17:21:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Nested virt bug on KVM arm64 when SVE is enabled
Message-Id: <F2620007-8539-4E96-96A0-E18AAFA5D35F@unpredictable.fr>
Date: Fri, 31 Oct 2025 18:21:35 +0100
Cc: qemu-arm@nongnu.org,
 qemu-devel <qemu-devel@nongnu.org>
To: Linux ARM <linux-arm-kernel@lists.infradead.org>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE1NiBTYWx0ZWRfX1Ch0uZYozRLi
 FPzhsOOcsM+Py+XT3tbJsjHRSX1TuwxRoSWoBz9ZwsbMsl9ledYAKFtYS4OATpJeTJEnVjt6CPR
 8sk8FIb1EG72FWy3cB0gzbMAS0Wc5ce0/LyutJUoJJc2qaeSkCl32HG4Yfs9YJebER0FVOZnvil
 Ntnu4nl6sHdI9JJNA8Fk3WbNN2Z/NwKefhYLEnp1g8+9qO4x3VAQLr1BoBE8wsheAktjrHnIvhT
 ZpW/YNqtuV9nMkaY9/cdv+Hsqd+SXuAf1awU9b8genvXuTYZJlxn+a+cBW0etJF8dd0+FkKwU=
X-Proofpoint-GUID: CvDElDBi393IMtjdrWPxEp3BEr-A_Vcy
X-Proofpoint-ORIG-GUID: CvDElDBi393IMtjdrWPxEp3BEr-A_Vcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 mlxlogscore=913 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510310156
X-JNJ: AAAAAAAB0cpLCTzjaQhKwM9FTao6rDkhp+iyLwy0yTacWa4uiyJIkgF9kodpCMCJ75rDeIqm4H6DEgS++qeMKfxz2kBdR0ySsk0rP1379Uan2NNwDzee4Cx7wbKoZl9AHpqATUb/KvcMMoeCMgb+9770knB8Xbt2iBCorO858yaTN305Ov5TGU3zowJjgGoBH+nkHQPwkJSjnv77me+QWCPc3F9FdxZDDuLMMcgdnZtSlsogaytOIU6v3oFWh6f1xcgnMZzTQ/Cwmr0fZgfJVCFVs3cR834VCIbertR+NArqk9FtC6SKXVbDxakVAVV13gYSSIodTDoz/ELgwavTHmneLMlc0Y5UtE6cWXYtVORCvgQLWBZ6iFwyOApy5oyDZhm3UuJOl3PS9+5NqNwqOA3e0K3YXkGmClqG04GXQrBhR0uy7vz5ohkubui+s+Qn+kZxthSAWw0snlP2CzRxTIr7MvTStOh70XMqEWVRGOVsTDNv/7AkhQ1ZunfiQK9qGiZO4hSo+Rr4lruuQPTpUNrv6JOlpSWVGejLJq1QQTylSfoNHFM91gKtoYoAysnKHkraTFOG7mm8ON/UtzqiJBLk4Rls7JewRBKcAVGGsJzm3XQNNTbIUmEu0hxJesnYamf8bKa9nctJMSRK61DzAsntCgdpIpyWzQ==
Received-SPF: pass client-ip=57.103.87.185;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Hello,

This is a bug report of an issue observed on Linux 6.17.3 as the host =
kernel on Neoverse V2 (Graviton4 SoC) when running a nested virt VM. The =
guest kernel is 6.6.49.

When the L1 guest attempts to access to ZCR_EL2, we do see:

[ 4756.369280] ------------[ cut here ]------------
[ 4756.369572] WARNING: CPU: 74 PID: 2705 at =
./arch/arm64/include/asm/kvm_emulate.h:595 perform_access+0x158/0x168
[ 4756.370394] Modules linked in: cfg80211 rfkill vfat fat aes_ce_blk =
aes_ce_cipher polyval_ce ghash_ce gf128mul sm4 sha3_ce arm_cmn =
arm_smmuv3_pmu arm_spe_pmu tun sg loop dm_mod nfnetlink ena ptp pps_core =
ixgbevf virtio_net net_failover failover nvme nvme_core nvme_keyring =
nvme_auth ipmi_poweroff ipmi_devintf ipmi_msghandler
[ 4756.372730] CPU: 74 UID: 1000 PID: 2705 Comm: qemu-system-aar =
Tainted: G        W           6.17.3-arch2-1 #1 PREEMPT(full)  =
ca9b486f90f26691f674c1b85c4d4a845fe363fb
[ 4756.373936] Tainted: [W]=3DWARN
[ 4756.374169] Hardware name: Amazon EC2 r8g.metal-24xl/Not Specified, =
BIOS 1.0 10/16/2017
[ 4756.374821] pstate: 62400009 (nZCv daif +PAN -UAO +TCO -DIT -SSBS =
BTYPE=3D--)
[ 4756.375387] pc : perform_access+0x158/0x168
[ 4756.375729] lr : perform_access+0x48/0x168
[ 4756.376064] sp : ffff80008916b820
[ 4756.376336] x29: ffff80008916b820 x28: ffff00000e0c0000 x27: =
0000000000000000
[ 4756.376911] x26: 0000000000000000 x25: 0000000000000000 x24: =
ffff800082106000
[ 4756.377489] x23: ffff00004aa0b380 x22: 0000000000000018 x21: =
ffff000069c4bba8
[ 4756.378073] x20: ffffa41769e93b58 x19: ffff0000377e1c20 x18: =
ffff5ca53480e000
[ 4756.378656] x17: 0000000000000000 x16: 0000000000000000 x15: =
0000000000000002
[ 4756.379239] x14: 0000000000000000 x13: 0000000000001388 x12: =
00000000000013f0
[ 4756.379813] x11: 0000000000000eb4 x10: 0000000000000044 x9 : =
ffffa41768d01db8
[ 4756.380391] x8 : ffff0003f9dd4ec4 x7 : 0000000000000eb4 x6 : =
00000425d3beaea1
[ 4756.380978] x5 : 0000000000000000 x4 : ffffa41768d05bf4 x3 : =
0000000000000003
[ 4756.381556] x2 : 0000000000000000 x1 : 0000000000000000 x0 : =
0000000000000009
[ 4756.382135] Call trace:
[ 4756.382335]  perform_access+0x158/0x168 (P)
[ 4756.382677]  kvm_handle_sys_reg+0x114/0x1f0
[ 4756.383017]  handle_exit+0x60/0x178
[ 4756.383300]  kvm_arch_vcpu_ioctl_run+0x2e8/0xa08
[ 4756.383674]  kvm_vcpu_ioctl+0x1a4/0xae0
[ 4756.383991]  __arm64_sys_ioctl+0xac/0x108
[ 4756.384314]  invoke_syscall.constprop.0+0x64/0xe8
[ 4756.384696]  el0_svc_common.constprop.0+0xc0/0xe8
[ 4756.385079]  do_el0_svc+0x24/0x38
[ 4756.385344]  el0_svc+0x3c/0x170
[ 4756.385598]  el0t_64_sync_handler+0xa0/0xf0
[ 4756.385939]  el0t_64_sync+0x198/0x1a0
[ 4756.386241] ---[ end trace 0000000000000000 ]=E2=80=94

A KVM trace of the VM says:

> trace-cmd report | grep kvm_sys_access | tail -1
qemu-system-aar-2705 [074] ..... 4756.369276: kvm_sys_access: [FAILED TO =
PARSE] vcpu_pc=3D0x40b6f8b8 is_write=3D1 name=3D0xffffa4176a420760 Op0=3D3=
 Op1=3D4 CRn=3D1 CRm=3D2 Op2=3D0

This is due to guest accesses to ZCR_EL2 not being handled properly. A =
workaround is to run with -cpu host,sve=3Doff (or with disabling VHE via =
the E2H0 cap) - which allows the guest to boot successfully.

Thank you,


