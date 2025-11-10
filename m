Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9A1CD13D2
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 08:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIMt6-0006kH-GN; Mon, 10 Nov 2025 03:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vIMt4-0006jE-Gf
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 03:04:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vIMt2-00062k-6M
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 03:04:30 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9NiRow004045;
 Mon, 10 Nov 2025 08:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uPuA216IkfFj5vXmm
 h8nE+ldZYGKOHA9fyvJh1hjkt8=; b=JghjjNw/UCXpD1s8TAFpE/gUn4vLRhzr7
 88cR0XMU0YCUV8ppbaGdxV3kz9QhhxRbMOv7Aw3s5KefKb5tHSkv+Yw3bX9pNE2s
 9vPLHgHhBVKu3RdwlI4/RkRgWGqwYaIhwyvCpNea7PEJ86q1QolJXLUYB0d1W9fM
 SigH3NiCuk1MeP89l29JAMVCjwPnO5EObo8UxqaQ1gTZCOYP17is6GRKL5OIQLQ6
 m50KGWLy0iAa1Pb2J/V9DyiQNYWQgByVNm2DXBldMjmqV4vYWGhCeL3ce9uU6p1H
 W2N4ltU0BGvwF7jvl9l1Ez2Iyp9xm/5kzDcBIfV5no4hawK3e9ADw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5chwwak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Nov 2025 08:04:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AA7skBV026966;
 Mon, 10 Nov 2025 08:04:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5chwwad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Nov 2025 08:04:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4oVge008197;
 Mon, 10 Nov 2025 08:04:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6mmj63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Nov 2025 08:04:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AA84LqN51118512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Nov 2025 08:04:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5589820043;
 Mon, 10 Nov 2025 08:04:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44AE020040;
 Mon, 10 Nov 2025 08:04:20 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.217.7]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Nov 2025 08:04:20 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Yogesh Vyas <yvyas1991@gmail.com>
Subject: [PULL 2/2] pc-bios/dtb/pegasos*.dtb: Fix compiled dtb blobs
Date: Mon, 10 Nov 2025 13:34:01 +0530
Message-ID: <20251110080401.3652497-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251110080401.3652497-1-harshpb@linux.ibm.com>
References: <20251110080401.3652497-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=69119c89 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=V2izKdb8aK_A4sH-rhUA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX8f0ZlfavC7ZT
 NfihYsSzjaR2OZt6LgQZsUKAAJAEJ8XduW4PPqj2FoTH+XA4pnKWvMLk5ez5whdga2ngy1Xc5r1
 D6rN+kzxMdnvailx3GtHZrbVDCPYns5L1KxUypQAYzubMQEWtlm3PS5IAkGMOpYOMA4IkSel5pI
 WYugFRE0KJqhp5/g2uFMSQrn7oqa0w1Xh8+Eeh79yfy4scFislazOiQ3MCgrH/kuO0P6N9ksGKm
 cGU9xZFx+nN0sFWpg1xPbgVUnTQa9uiroAHD0EKceI4B4ny77f7QW0EsMafApGHtUsbIbUY9LOE
 sbrkCJgagAsG3zCQ9wkPDZ8LfKDBkuFjNl6tEViC/PoH0oz/lT47vwSAaxK6IEFGK1zsdFEv1Fh
 /qCKiUHIm5hj4goMW2Q/HQAjORzepQ==
X-Proofpoint-GUID: ZmwhfpToJ6IglqU4G1IDH4ckBLaLsYRv
X-Proofpoint-ORIG-GUID: 5H9AZ1gmFRNBeA2e0pNJuWrQASw2dNV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

When adding these files somehow an incomplete version was committed.
Regenerate and update these dtb files to match the dts which fixes
problems caused by missing nodes in the dtb.

Fixes: 9099b430a4 (hw/ppc/pegasos2: Change device tree generation)
Fixes: 3c21f9dfcf (hw/ppc/pegasos2: Add VOF support for pegasos1)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reported-by: Yogesh Vyas <yvyas1991@gmail.com>
Tested-by: Yogesh Vyas <yvyas1991@gmail.com>
Message-Id: <20251108193717.DADA9597302@zero.eik.bme.hu>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 pc-bios/dtb/pegasos1.dtb | Bin 857 -> 1975 bytes
 pc-bios/dtb/pegasos2.dtb | Bin 1701 -> 2963 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/pc-bios/dtb/pegasos1.dtb b/pc-bios/dtb/pegasos1.dtb
index 3b863b25288a59bcede9459ff42afad713dde741..b776861602055ed068cac103ad8b2e9faad1e6e5 100644
GIT binary patch
literal 1975
zcmZuyO=}ZD7@lplwWzFuUaE&kE=9W9q^(VFE48#BXiz-$&~A1o>5~1*%%&xRwE8<d
z2%bHA@!}5<Jo*Pb3O#sG(Bk{d&Lr!$FT6AF^US<oGn38NtEWF0oBhZbYcVzx(Y!!<
zo%9+hiS?NHmBRjSv^1Kg`GU5=0beAw{e6*X9^56;TW#L+WGX>}gWhR81XT8An(ub9
z$V+Nlac6tX!*{*ndz-i|&DA!xpS5f4^pK18M(z1X<~)Y8m1aE2M5+K`<U?Pkj>V;W
zjZUMvOca|Uwfy~5@&vHJF^^L*a+efS_|KAU7rbIkZ##MqrXp50RE-kG9-PrGDa2sd
z=FG6(*I4;?y)cqqmtzwNd{l19Md;zCbe_x)-PTeeik-x_X$@34A8dnB4{{kiu>QPz
zQNpiJPY4z3xPzTz8jeUw;DZ}_YaRl~Qw)&fBCs|AmAs-62_b*A!qzbm6M5c)(_)3v
zbJq%B>ij@YbcQH{>HWTGl<;S=anEM`3!70H4F1O0{Lj+*_u|Q`{WplGyQH7PSuy@L
z)r3`pVVBPl=Zb`8{Wms{7(8G{3pXd&!reox;%?or*;V<mzk283u8`urQI4r!G~>*`
z(`?z=rm2(<sHo9uEv+=&@Im=aqgMDqD)HGKarixhN1X#w2r&6s^9oJY0n5GPEFjw7
zx=%LF3TpNFsFQjksMIq@YqnV<8v_4Q-)xVtsmt_@ybu*z<h~oOsWx?PW)p|?YOGBA
zfH$#lrV!&>?wh_-mK(^%a%<JmA&Z=O7<1u<EBbKZi+5@(9?{O`c8No-Y97@?H=rJt
zyXCvW9oWRvRPAH>gg6t+^nv`4bK^%@PVqY`SZR+<yzwcW`Sd3utMTzZA?L+6_l$Y2
z?gfG1QaV15BFO@N5c+&KA7z}yX}}{Uh>>BMu#KmWHn%pPEFSPANW~bcmoi2Hm%a$I
z91eo_SY3uMxsF};@$L1a)bBf8!3RU0_#@V8uC6;_l5-)3S?+j#KS>WG9`ra9Uee=|
zb%xSWCM!}qVW8`TW$J_NM;<z%x|tkyr25AJKLL{noW2&0jM7{(j85Xklxti_$)tcu
XF48FCg4M?xbW?sBXI>t5BF_E++M@cs

delta 53
zcmdnaf0Iq)0`I@K3=GVX3=9kw3=B+bfV2h>3j(nK5QD&4pm@nfjcTUJ$!yyIEp7@-

diff --git a/pc-bios/dtb/pegasos2.dtb b/pc-bios/dtb/pegasos2.dtb
index 29c35216ec2d77e4083a3ef618ca185925fb5d61..a6935a8c23d85e0251e7f424cf59c8fe54fe593a 100644
GIT binary patch
literal 2963
zcmb_ezmFU>6!z>v$dN?L@k2t8V$o5A=my<Sa;aDmP8X#JClI1Yk$64c-Qi|uCid)I
z79<E%bSY?&prW8dqNGS9{s0g)5*?yIA`%6WAmaNx_U_z5l!hmH=6%o4?|b&MJ@fsk
z`@acs;!`2Swh)WY;(Z2f3GE3qNb7wej{oe`qmRhL1-u{eI&H*{qP5k~l-^F;BHHtN
zdLV6K*Bf^By|Dh8vrs>QcD7e$GVkn;dKag5jz9k&<4?oB>+PKj7vJ3L>=lRF>|N-*
zHL;Z*F+fz5IxkJ(05Ew@p-uByS$la6n9@Rv)UdERpW%@n6=u?1b(VVkW6;~R-B}s)
zINBA5>PH=`99wUr57+AI93~8F$Nqhf-FQ>U`SI81{67GG8ZE^C1Ue<)&uTcuU(ez1
z=I{@|&3t|WW-cM#uU-%M9x(IvIAX1iH86AIdWHTMp>wSQ-h|FE0q;P6yn)|=&V3R3
zHT0zhE}%czz=zPEYT%EcGY7YxeVJxf_8Ei1n68#qn^b1b=KM;PcDGk+an>onXrqrN
zpO5RM9x&_MSg+_-^w$?}`+n@9=yNV^ko!S_k%K5VeWTvxV;Vd9@~$}fjmK`k-2~{O
zK|FtSr-ly0C;HK2zM|C1uBr{eAN5^o*6SA`K3;=M=)Vh{_d&pai(_sE9=E{p+#j?4
z)-!c^oIlqcXW|-O{}Ml5w2>1#1E$_sKX+b882DbI1H|L#miX`tI0J5Nx?aq+u4y-2
z@8f!_`{!%T7$?zqZo$#|6YsD$@ov2eOdraO?{p_%?90}rGB5Wo@2zaDa@FeGqwUqr
z^=|q~^UmNL+Rmen)!-G^VCTI#<ER~paTZ#ac%QB?=*-T1xvwaGoYNa?HGkK%-h~I(
zmMz-XlU^ZBGM6XMVmtIfr!fA5@(t@mUJ8Ai>$0)B;p~pnRH~bvbITHPZo?MFH91Nc
z!#)TctPRDFMeS>uawc|dV|y$1A?tZo=}4Pyy6KBSU+(v|v(Lsixw|lv>w!GJ=4-2U
zP&c=Jg1K$<Jxv%Z+OU&_u^Jo;zXJ!3FhAx+c^L1xCT~_&;O#k**;vtrJ;ZAAehcF~
zFV6+#VZ56SUe4Lgn|G!9pYF<qd)=>m9$3etcO?&}6YhMk-o~4a(s55W2hQ)xZ9F<?
zkT9=1&@npr9Jw3Ad={5wk{E4mtaO%Hk?4a|>8sVG)M8X5IuiyKn-;ma@W$&qyE~Ux
z4s@OrW(wV@nxaHoWzw?Z0HX(D*{1JlAA4Ex|9~I)_&^&M(*e5F<|MWF9h$^-7PU=-
zuZpdbd2D3m9knrqiL+u5kK_#y*-DxU2Lb;N`GJw6xUVZU^t!DIqs2g1F%Lmp^y5TM
zgq_1P9-)R>?Z^6tR$(GCiBb4i6?s1$h(nWBx@ib`tD!VfRob}dX`ZA?f?SmRPXlpZ
z*s;YAS|WyNPn(?cvF_h3Ho8|7l~7p$>b}v}$2wONVPrngR&1|tosZKTk<GZQVyX7?
z;xN<6Knv#8Gbz+KACC}K^u`uTg>j-TRh%ZiuGB(3sjEz~@~ATs>-kJzpMhBfjW1Vh
nv!b$s&p4MOBsR^-3RR3sS*5*9&#YXr$`o0Kw3es7en0#J=mwZO

delta 54
zcmbO%zLZzv0`I@K3=C{b85kHW7#LVi0BH>%76f7eAO-@)yFl>?8#PWdZ+7O`!~_68
C$qNtw

-- 
2.43.5


