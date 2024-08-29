Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFDBC83F2D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 14:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjgNo-0004k4-Uc; Thu, 29 Aug 2024 10:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sjgNm-0004iH-UC; Thu, 29 Aug 2024 10:44:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sjgNk-0002Xt-NJ; Thu, 29 Aug 2024 10:44:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T3tp8M028797;
 Thu, 29 Aug 2024 14:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:mime-version:content-transfer-encoding:in-reply-to
 :references:subject:from:cc:to:date:message-id; s=pp1; bh=lm/xqo
 0YOm0rpItV0gioUtIUHn2Dn2MR5/oXQlllXlg=; b=jkDtsQlOut9n4bc9uKrsCc
 SD5B2HvGgRQUiSLx12aK5Cm/A+M4CcF+Eya/7aIj3lUhbSc1jfkaXi6H+63IUf8k
 ZMbx7m8WYCr77w5aY+pNY7xeKrsZHPtoneKCKwZGZ3JysQIKHLg/rFB3/0aNPeG/
 676V9FkRWJ4sbvLzVXSScEbj04j/1KcnNjIuponJKsP4OXWAcLUCgOSMOMcgaFkV
 t+T6qxoK1pf5tnwh7thTTUjUAPzw/zkYm5unQ6e8AkpLXprpvO0jqm08KaFb88gg
 2UPNnhsPH3XQT6ouknT/ttcA1+x62SMV7UkWcXJ/1UtoLhpOADmP0XvnG/bBDscw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8r0gch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 14:44:13 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47TEiDGe012354;
 Thu, 29 Aug 2024 14:44:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8r0gce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 14:44:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47TBJeak027960;
 Thu, 29 Aug 2024 14:44:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubnd18w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 14:44:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47TEi8tl50397460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 14:44:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B39FF20043;
 Thu, 29 Aug 2024 14:44:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8530620040;
 Thu, 29 Aug 2024 14:44:08 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.85.11])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Aug 2024 14:44:08 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA8dk65ByV+x6A0hapL_D-52Rxwk35bgG2YMfL6bOAbcPw@mail.gmail.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA-wVqbuW1aG2fd6O9BwMKrFXTLzcvuF4xd6j_4x5WUQ+Q@mail.gmail.com>
 <172493399778.162301.4960007495977124327@t14-nrb.local>
 <CAFEAcA_nXq91A79d0ROc54y=MFoTBETpMmSd_hvk4BzQ9A7=3Q@mail.gmail.com>
 <172493799281.162301.9447178356877601539@t14-nrb.local>
 <CAFEAcA8dk65ByV+x6A0hapL_D-52Rxwk35bgG2YMfL6bOAbcPw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw,
 cpu to three-phase reset, and followup cleanup
From: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 16:44:07 +0200
Message-ID: <172494264766.6066.36832168091845428@t14-nrb.local>
User-Agent: alot/0.10
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7DTLGPk3cvNh_mf_KUEYptEH4_pLh7N9
X-Proofpoint-ORIG-GUID: P7C3-FfNZ-1xbL1lL4Sk1ok9WXAZbafC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=957 spamscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290101
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nrb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Quoting Peter Maydell (2024-08-29 15:35:30)
> On Thu, 29 Aug 2024 at 14:26, Nico Boehr <nrb@linux.ibm.com> wrote:
> >
> > Quoting Peter Maydell (2024-08-29 15:09:44)
> > > Thanks. I tried this repro, but mkosi falls over almost
> > > immediately:
>=20
> > In the meantime, looks like mkosi is trying to create an block image, b=
ut
> > that's not what it's configured to do; are you sure mkosi.conf is in the
> > same directory you're calling it from?
>=20
> It is. I notice however that the manpage for mkosi
> says that it looks for "mkosi.default", not "mkosi.conf".
> Maybe it needs a newer mkosi than Ubuntu ships?
> (mkosi --version says "mkosi 12".)

Likely. I have mkosi 22 here.

> I'll use the images C=C3=A9dric has kindly generated.

Thanks, images by C=C3=A9dric look good, but I forgot to tell you that
you need a SSH key for login too :)

You could unpack image.cpio.gz, add your key to root/.ssh and repack the
whole thing to image.new.xz:
- mkdir xtract && cd xtract
- unxz < ../image.cpio.xz | cpio -H newc -iv
- cp ~/.ssh/authorized_keys root/.ssh/
- find . 2>/dev/null | cpio -o -c -R root:root | xz -9 --format=3Dlzma > ..=
/image.new.xz

