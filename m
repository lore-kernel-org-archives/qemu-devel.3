Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6AFC83F0A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sje8L-00069w-MK; Thu, 29 Aug 2024 08:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sje8I-00068K-9h; Thu, 29 Aug 2024 08:20:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sje8G-0008OI-9R; Thu, 29 Aug 2024 08:20:10 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T1xVg6032371;
 Thu, 29 Aug 2024 12:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:mime-version:content-transfer-encoding:in-reply-to
 :references:subject:from:cc:to:date:message-id; s=pp1; bh=uVycpn
 gdC48HsBpEtwrW5i/EJXnfgl9rxxUY5kGlcUU=; b=ePpUCcixQv8/DEUzr4vVSA
 gFOVarOkEJYe2MGqoL7A0OR/VO1nszNKXhYhd+VLkowUAKkPEnp9xPw2SAPt9vy1
 nkp/5nD90Ip18zt3jeRhY93zs7jr1C10OE1z7HNxJ5nklL0g7jcUe0gXStgTBYOI
 GjTAe6Ylf6nIc+nJXfbdnn/KeII0mbQVM2owzMvdpQUQ7JXjDqgBaoySpsM7zQPB
 tV0gmK1XmTDiGhO9FkbTzCBRLAN/nNMs62uauGK6/US742h/qtx8NmCXU6P6Y44I
 QHD/5A+IVHEKu+s246iDVsQEe4+dj6SQ4BtjOLkg50RqC+14OqIM7K8maKFpcgoQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8u7u1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 12:20:03 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47TCK3mH027275;
 Thu, 29 Aug 2024 12:20:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8u7u1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 12:20:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47TAMuQ7030991;
 Thu, 29 Aug 2024 12:20:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417t814pdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 12:20:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47TCJwPB56295934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 12:19:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D898720043;
 Thu, 29 Aug 2024 12:19:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEA9220040;
 Thu, 29 Aug 2024 12:19:58 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.78.87])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Aug 2024 12:19:58 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA-wVqbuW1aG2fd6O9BwMKrFXTLzcvuF4xd6j_4x5WUQ+Q@mail.gmail.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA-wVqbuW1aG2fd6O9BwMKrFXTLzcvuF4xd6j_4x5WUQ+Q@mail.gmail.com>
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
Date: Thu, 29 Aug 2024 14:19:57 +0200
Message-ID: <172493399778.162301.4960007495977124327@t14-nrb.local>
User-Agent: alot/0.10
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j9MrIOpTuYjNFnE5NCDjN5TZ_87nr8YK
X-Proofpoint-ORIG-GUID: n6iIst2dKGox8ir2axfRnj2h1O_QuKZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290085
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

Quoting Peter Maydell (2024-08-28 17:46:42)
[...]
> Well, the series is *supposed* to be just a refactoring, not a change of
> behaviour, so I'm not sure. I don't suppose you have a reproduce case
> that I can run? (I do have access to an s390 machine if that helps.)

Well, it's on an internal testing framework which we do not release
publicly. :-(

Luckily, it's not that difficult to reproduce.  It seems like this only
happens when a reboot is initiated over SSH connection via vsock. Here are
some instructions on how to reproduce (with mkosi and Fedora):

1. Craft an mkosi.conf like this:
   [Distribution]
   Distribution=3Dfedora
   Architecture=3Ds390x
  =20
   [Output]
   Format=3Dcpio
   CompressOutput=3Dxz
  =20
   [Content]
   Packages=3Dopenssh-server
   Packages=3Dkernel-modules-core-6.8.5-301.fc40.s390x
   Bootloader=3Dnone
   MakeInitrd=3Dno
   Ssh=3Dyes
   Autologin=3Dyes
   RootPassword=3Dhunter
   Timezone=3DEtc/UTC
   Locale=3DC.UTF-8
2. Generate SSH host key:
   mkdir -p mkosi.extra/etc/ssh && ssh-keygen -t ed25519 -f mkosi.extra/etc=
/ssh/ssh_host_ed25519_key
3. Build image:
   mkosi
4. Boot with QEMU:
   qemu-system-s390x -machine s390-ccw-virtio,accel=3Dkvm -nodefaults -nogr=
aphic -chardev stdio,id=3Dcon0 -device sclpconsole,chardev=3Dcon0 -m 2048 -=
kernel image.vmlinuz -initrd image.cpio.xz -device vhost-vsock-ccw,guest-ci=
d=3D3
5. In a different terminal, run a reboot loop:
   i=3D0; while true; do ssh -o ProxyCommand=3D'socat VSOCK-CONNECT:3:22 -'=
 localhost -l root reboot; echo $i; let i=3Di+1; done

After a while (10 minutes, sometimes longer) you should see the quest crash
either with "Attempted to kill init" or "Unable to mount rootfs" and a mess=
age
about corrupted initramfs:
[    1.599082] Initramfs unpacking failed: XZ-compressed data is corrupt

I had this run without your series for 45 minutes, while with your series
this crashed within ~5-10 minutes.

Thanks!

