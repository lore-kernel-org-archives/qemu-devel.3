Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1548CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiOU-00085F-JU; Tue, 13 Oct 2026 15:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGiOO-00084c-Fr; Tue, 13 Oct 2026 15:42:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xGiOM-00016h-DA; Tue, 13 Oct 2026 15:42:32 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DEAKtC1893086; Tue, 13 Oct 2026 19:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VQNMr8
 CSe93LIdM/Hm1GQZba7Hwg0hS3FE/Md7hwmp4=; b=HhhXnHg61zsbAEF2KyJB6v
 5nHpMmABbgPRXd5lQvYqJsndmv23IqHNZ58o+DwzFJ1jCaSP0MuV8hkOphKB90Ge
 UB3RUi7HjWG+v/E9sqzlBVI1RfndrzV2g4IowJCIE0EBM07oYKLIsqywNWI5YZYz
 5rGW0PkpkldzXcSayI3cdAM7GJMzmveDhwKHwJx9uHzPJELiNPZvdsjxPMEED35h
 DW4MZeTwEO+h4kWytQjsLU4dvWKTrNGN5YquunAMSzACuf61tgn16z/xIA3jDP2L
 GNyTKlBfCYf15IwgXCzB6sZf25Prt9hingy9/JP/XmQhLemCaFeLuKjswlN79pPg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3ghcd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:42:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DIKlBa2667224; Tue, 13 Oct 2026 19:42:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vv38e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 19:42:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69DJg5Dx24183440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Oct 2026 19:42:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 311DD20063;
 Tue, 13 Oct 2026 19:42:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B9DA2004B;
 Tue, 13 Oct 2026 19:42:04 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.59])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Oct 2026 19:42:03 +0000 (GMT)
Message-ID: <9898cc36-2438-473c-aed5-eb1a5671c2d0@linux.ibm.com>
Date: Tue, 13 Oct 2026 21:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] tests/functional: add tuxrun kvm gdb test for
 s390x
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Xu <peterx@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-17-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IYCeVY6mSRkL6zLmp1I7zC3r1DYjscxU
X-Proofpoint-ORIG-GUID: IYCeVY6mSRkL6zLmp1I7zC3r1DYjscxU
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ace8992 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=tZD6s3AVAAAA:8
 a=KKAkSRfTAAAA:8 a=WP5zsaevAAAA:8 a=MrYfVH7qMJZ5kWDhDHwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=DklORoM8RNzucgFJxVk_:22 a=cvBusfyB2V15izCimMoJ:22
 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NiBTYWx0ZWRfX91LGAtb/4u18
 2uOfbXyQJnMcwtmEGLk2onltNjtWUDF/MgM/jwbFe8OdXisDW6u5FT3sfp7xGA6+XQcSl5vqXab
 KD2P2n0/DqoYAPinzf7/nWcCBN3Kuzs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NiBTYWx0ZWRfX6kHVBwpxvLy6
 4SZkEE5mPSjeVnlGu7NujYUdbcmfMvu+H45QzbVWjfj7UnupK8ReLxf48lC2/gjYuNbn8KvKoCQ
 0Qh+vZ/2lxKBz3CV+6xnzGIxBxt16eWsnlEJaRiOuHFeGvjmud2Fn/8Gb15dt9pMreLusr7wvde
 JhivUBXHBzaI1MY4C9IGtuSh+2QJCBTOP+5sRrwpn7EOlVcgRFVGhgdq5CCG+0R+1tADN5ZVvII
 vbO7jkTB5uVx3i3jPraM7yLRPAxCCnFYTzITe7Cizj7s8MaLSS2oi770nd6LIueQ/7prcHfFewN
 +4NPaDJN4+UfUleD1sytDolQPvT6C7ND4bCkZh0ZNXq4VbKISJswOKpRLghDoDUcSw+rLuWFac2
 J5774GyHqMFPV77ZqbhWegj571MeqfO02V+Uzjz3ckpuXPHZqrgJxrA36/zbEmAnFuG/X5j9jIg
 7/n4YR0j/r2U3o39Leg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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



On 10/12/26 19:03, Alex Bennée wrote:
> As with x86_64 we now have the bits to add a KVM gdb test. One minor
> wrinkle is the s390x only supports WP_WRITE watch points so we skip
> the other watch point tests lest we get confusing messages about
> failing to insert HW breakpoints.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/gdb-scripts/kernel_gdb_test.py | 10 ++++++----
>   tests/functional/s390x/test_tuxrun.py           | 14 ++++++++++++++
>   2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/functional/gdb-scripts/kernel_gdb_test.py b/tests/functional/gdb-scripts/kernel_gdb_test.py
> index 2d62fe01f10..56f0514c943 100644
> --- a/tests/functional/gdb-scripts/kernel_gdb_test.py
> +++ b/tests/functional/gdb-scripts/kernel_gdb_test.py
> @@ -107,11 +107,13 @@ def do_one_watch(sym, wtype, text):
>   def check_watches(sym_name):
>       "Watch a symbol for any access."
>   
> -    # Should hit for any read
> -    do_one_watch(sym_name, gdb.WP_ACCESS, "awatch")
> +    # s390 only supports write watchpoints
> +    if "s390" not in gdb.selected_frame().architecture().name():
> +        # Should hit for any read
> +        do_one_watch(sym_name, gdb.WP_ACCESS, "awatch")
>   
> -    # Again should hit for reads
> -    do_one_watch(sym_name, gdb.WP_READ, "rwatch")
> +        # Again should hit for reads
> +        do_one_watch(sym_name, gdb.WP_READ, "rwatch")
>   
>       # Finally when it is written
>       do_one_watch(sym_name, gdb.WP_WRITE, "watch")
> diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
> index 8e0261e2b7f..528af3c08ff 100755
> --- a/tests/functional/s390x/test_tuxrun.py
> +++ b/tests/functional/s390x/test_tuxrun.py
> @@ -19,6 +19,9 @@ class TuxRunS390xTest(TuxRunBaselineTest):
>       ASSET_S390X_KERNEL = Asset(
>           'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
>           '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71aec')
> +    ASSET_S390X_VMLINUX = Asset(
> +        'https://storage.tuxboot.com/kernels/6.18.54/s390/vmlinux.xz',
> +        '5bbd4d34e0950f88053a9bfd16078896df4b1ee1696fc2ad62488e681a6bdd8e')
>       ASSET_S390X_ROOTFS = Asset(
>           'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4.zst',
>           '5ba18c4d18831c50a0c743990f7bdee1d3b520629d423c55b668d8fbbac9c6f5')
> @@ -42,5 +45,16 @@ def test_s390_kvm(self):
>                              haltmsg="Requesting system halt",
>                              accel="kvm")
>   
> +    def test_s390_kvm_gdb(self):
> +        self.set_machine('s390-ccw-virtio')
> +        self.require_accelerator('kvm')
> +        self.wait_for_shutdown=False
> +        self.common_tuxrun_gdb(kernel_asset=self.ASSET_S390X_KERNEL,
> +                               vmlinux_asset=self.ASSET_S390X_VMLINUX,
> +                               rootfs_asset=self.ASSET_S390X_ROOTFS,
> +                               drive="virtio-blk-ccw",
> +                               haltmsg="Requesting system halt",
> +                               accel="kvm")
> +
>   if __name__ == '__main__':
>       TuxRunBaselineTest.main()

This hangs unfortunately.
You need something like the following to compensate for the difference
between vmlinux ELF addresses and the actual nokaslr load address:


diff --git a/tests/functional/qemu_test/tuxruntest.py 
b/tests/functional/qemu_test/tuxruntest.py
index 8e940fd7738..1d67496cd73 100644
--- a/tests/functional/qemu_test/tuxruntest.py
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -160,7 +160,8 @@ def common_tuxrun_gdb(self,
                            dtb_asset=None,
                            drive="virtio-blk-device",
                            haltmsg="reboot: System halted",
-                          console_index=0):
+                          console_index=0,
+                          symbols_offset=None):
          """
          Common path for LKFT tests under gdb. Unlike the common_tuxrun
          function we need to launch with the gdb test script and deal
@@ -204,6 +205,8 @@ def common_tuxrun_gdb(self,
              "--test", str(test_script),
              "--gdb", gdb_path,
          ]
+        if symbols_offset is not None:
+            cmd += ["--symbols-offset", hex(symbols_offset)]

          self.log.info(f"run-test: {' '.join(cmd)}")

diff --git a/tests/functional/s390x/test_tuxrun.py 
b/tests/functional/s390x/test_tuxrun.py
index 528af3c08ff..4751b6aef2f 100755
--- a/tests/functional/s390x/test_tuxrun.py
+++ b/tests/functional/s390x/test_tuxrun.py
@@ -54,7 +54,8 @@ def test_s390_kvm_gdb(self):
                                 rootfs_asset=self.ASSET_S390X_ROOTFS,
                                 drive="virtio-blk-ccw",
                                 haltmsg="Requesting system halt",
-                               accel="kvm")
+                               accel="kvm",
+                               symbols_offset=0x3ffe0000000)

  if __name__ == '__main__':
      TuxRunBaselineTest.main()
diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 0c7cbd137ef..5892edd88bd 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -29,6 +29,8 @@ def get_args():
      parser.add_argument("--binary", help="Binary to debug",
                          required=True)
      parser.add_argument("--symbols", help="Symbol file for binary to 
debug")
+    parser.add_argument("--symbols-offset",
+                        help="Offset to add to the symbol file's 
addresses")
      parser.add_argument("--test", help="GDB test script")
      parser.add_argument('test_args', nargs='*',
                          help="Additional args for GDB test script. "
@@ -117,7 +119,10 @@ def log(output, msg):
      gdb_cmd += " -ex 'target remote %s'" % (socket_name)

      if args.symbols:
-        gdb_cmd += " -ex 'symbol-file %s'" % args.symbols
+        gdb_cmd += " -ex 'symbol-file %s" % args.symbols
+        if args.symbols_offset:
+            gdb_cmd += " -o %s" % args.symbols_offset
+        gdb_cmd += "'"

      # finally the test script itself
      if args.test:


