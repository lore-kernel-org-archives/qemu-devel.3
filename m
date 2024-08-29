Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD88DC83F16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjfAn-0007ea-Hy; Thu, 29 Aug 2024 09:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sjfAk-0007dN-FO; Thu, 29 Aug 2024 09:26:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nrb@linux.ibm.com>)
 id 1sjfAh-0000an-W5; Thu, 29 Aug 2024 09:26:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDMkDf011867;
 Thu, 29 Aug 2024 13:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-type:mime-version:content-transfer-encoding:in-reply-to
 :references:subject:from:cc:to:date:message-id; s=pp1; bh=hvuydx
 XkEY9v9OsZlUMXaucx5tv2vOsns21zd4hwEYk=; b=gSoYvoR9aeZ9m9Pa7W5lwS
 eIZIcYicsEAuTlAZvyTbm2lV14Ot1x+LTkLTjc0Taq5MYFYrkN5qPqq6ZPbikIpD
 r3SueCDs6Bg65lBDQRDzUnkyz//WC3geMjT86qJoKefkvKuny9IQkirgniqJ+jsP
 /Qp38C+Qo54yuexWwdKFDlWF6+wEBDhVKPYb8CEiuRDSK+PQXOlOn9CPIy28lZ9W
 y4obH6zY+ll8BDqOQ23hVoyhHZVyCZyj7H8N1/qsRFGg0MuhiRezcY5t/b0QO2Lq
 ImHUcYZvpBF9mIcrgXXSaBTkbknVSBu0s77ew03sthO3wZrtHRYa33EgEW8EkExw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8p0dwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 13:26:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47TDPkXp025533;
 Thu, 29 Aug 2024 13:26:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8p0dwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 13:26:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47TAvOBO003161;
 Thu, 29 Aug 2024 13:26:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417tuq4u3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 13:26:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47TDQYvE53150104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 13:26:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00C6B20043;
 Thu, 29 Aug 2024 13:26:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCFE020040;
 Thu, 29 Aug 2024 13:26:33 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.78.87])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Aug 2024 13:26:33 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA_nXq91A79d0ROc54y=MFoTBETpMmSd_hvk4BzQ9A7=3Q@mail.gmail.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
 <CAFEAcA-wVqbuW1aG2fd6O9BwMKrFXTLzcvuF4xd6j_4x5WUQ+Q@mail.gmail.com>
 <172493399778.162301.4960007495977124327@t14-nrb.local>
 <CAFEAcA_nXq91A79d0ROc54y=MFoTBETpMmSd_hvk4BzQ9A7=3Q@mail.gmail.com>
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
Date: Thu, 29 Aug 2024 15:26:32 +0200
Message-ID: <172493799281.162301.9447178356877601539@t14-nrb.local>
User-Agent: alot/0.10
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BpODEx2NoeCvvcQrYJX58HOmu8RWj73k
X-Proofpoint-ORIG-GUID: 0H3CV6gl928Jjzi2kNqkKlsbwAVW2JQq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nrb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Quoting Peter Maydell (2024-08-29 15:09:44)
> Thanks. I tried this repro, but mkosi falls over almost
> immediately:
>=20
> =E2=80=A3 Detaching namespace
> =E2=80=A3 Setting up package cache=E2=80=A6
> =E2=80=A3 Setting up package cache /home/linux1/s390-failure/.mkosi-htsau=
2ot complete
> =E2=80=A3 Setting up temporary workspace.
> =E2=80=A3 Temporary workspace set up in /var/tmp/mkosi-tjc0nror
> =E2=80=A3 Running second (final) stage=E2=80=A6
> =E2=80=A3  Creating image with partition table=E2=80=A6
> Disk /home/linux1/s390-failure/.mkosi-ddkx5xpb: 3 GiB, 3221266432
> bytes, 6291536 sectors
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
>=20
> >>> Script header accepted.
> >>> Script header accepted.
> >>> Script header accepted.
> >>> Created a new GPT disklabel (GUID: 14CF3B05-D072-0A45-8EE4-3219112ACB=
2E).
> /home/linux1/s390-failure/.mkosi-ddkx5xpb1: Created a new partition 1
> of type 'unknown' and of size 3 GiB.
> /home/linux1/s390-failure/.mkosi-ddkx5xpb2: Done.
>=20
> New situation:
> Disklabel type: gpt
> Disk identifier: 14CF3B05-D072-0A45-8EE4-3219112ACB2E
>=20
> Device                                     Start     End Sectors Size Type
> /home/linux1/s390-failure/.mkosi-ddkx5xpb1    40 6291495 6291456   3G unk=
nown
>=20
> The partition table has been altered.
> =E2=80=A3  Created image with partition table as
> /home/linux1/s390-failure/.mkosi-ddkx5xpb
> =E2=80=A3  Attaching /home/linux1/s390-failure/.mkosi-ddkx5xpb as loopbac=
k=E2=80=A6
> =E2=80=A3  Attached /dev/loop13
> =E2=80=A3  Formatting root partition=E2=80=A6
> mke2fs 1.46.5 (30-Dec-2021)
> The file /dev/loop13p1 does not exist and no size was specified.
> =E2=80=A3  (Detaching /dev/loop13)
> Traceback (most recent call last):
>   File "/usr/lib/python3.10/runpy.py", line 196, in _run_module_as_main
>     return _run_code(code, main_globals, None,
>   File "/usr/lib/python3.10/runpy.py", line 86, in _run_code
>     exec(code, run_globals)
>   File "/usr/lib/python3/dist-packages/mkosi/__main__.py", line 32, in <m=
odule>
>     main()
>   File "/usr/lib/python3/dist-packages/mkosi/__main__.py", line 26, in ma=
in
>     run_verb(a)
>   File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 7809,
> in run_verb
>     manifest =3D build_stuff(args)
>   File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 7227,
> in build_stuff
>     image =3D build_image(args, root, manifest=3Dmanifest,
> do_run_build_script=3DFalse, cleanup=3DTrue)
>   File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 6941,
> in build_image
>     prepare_root(args, encrypted.root, cached)
>   File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 1308,
> in prepare_root
>     mkfs_generic(args, label, path, dev)
>   File "/usr/lib/python3/dist-packages/mkosi/__init__.py", line 1031,
> in mkfs_generic
>     run([*cmdline, dev])
>   File "/usr/lib/python3/dist-packages/mkosi/backend.py", line 699, in run
>     return subprocess.run(cmdline, check=3Dcheck, stdout=3Dstdout,
> stderr=3Dstderr, **kwargs)
>   File "/usr/lib/python3.10/subprocess.py", line 526, in run
>     raise CalledProcessError(retcode, process.args,
> subprocess.CalledProcessError: Command '['mkfs.ext4', '-I', '256',
> '-L', 'root', '-M', '/', '/dev/loop13p1']' returned non-zero exit
> status 1.
>=20
> (My s390 box is running Ubuntu, in case that makes a difference.)
>=20
> Maybe you could put the kernel and initrd somewhere I can
> get them from?

Sigh. Yeah, I'll try to find a way (may take a while).

In the meantime, looks like mkosi is trying to create an block image, but
that's not what it's configured to do; are you sure mkosi.conf is in the
same directory you're calling it from?

