Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EAFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gA-0007ud-6E; Fri, 10 Jul 2026 02:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4g2-0007km-5Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4g0-0005pg-Iv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3moXD3629762
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RXcLWY+yYsC
 LQYkQGJiv/jJ+pGVK62vQuWDY7F2Hrr0=; b=czs2ABp/BDWNhnFxna9qQWAes+h
 85RANB/jEaFV22v30QX98prxoh+OlygxocLgI8R0kijEIcV4i04Vwl4oI4L+BNTP
 4oKeMQyQVRMZi/5zTlHKMjmQN2c6ueUobHzEbRxEzBpKyFcynS3sGGDH87aTSh2i
 16jKY5Ccj4cMbdG90lLqBKqNfEkdv/94r+KJ3j7E6CSoKJkPdgcbO1FF2QgPqt0u
 uecnfqWMqPjM68XhuM+41LPj3S+USOGZyR5yJqGqWpUZjz8WR1vSV7zkvcU7HdwK
 pKe9G01AbqiPSoxuM+ygTAkmppGfLl9ia+vT8+pql4/kivpvCyjOpWaUnqw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8hxku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc86a9ef97so10792695ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664730; x=1784269530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RXcLWY+yYsCLQYkQGJiv/jJ+pGVK62vQuWDY7F2Hrr0=;
 b=Z+5p/j0cFOj5NIHcGqK6NJN06QhkgOId8jQN0G9eJIqBrLjOYSBc5P9Ymf4o4eWZJl
 erOIEPvcLNBBezxe/bWWW7GxuzIoLatoEfsWeRpaSPkJhZyJ4df/ugfyxBgSn8CeHRZ1
 J4L2NalrFxjK993zp28l6m0ZJeD6n0wNQ8I4hsmY4y9fnfUoS/huLZ2PYsgv9+tLaHfy
 Lf09Glz/tbRM9OnBZTZ4hddJ7kFjqJybov1KPTLA/nRH/tqWVhqKU/gwYFB+e7T1RMcz
 I7GSMVqilqht6HD34huaqfreLAeDOYWbuH3HquyVNOkwTzWW5kBfC5r+9Zap9JOo4wYJ
 cozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664730; x=1784269530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RXcLWY+yYsCLQYkQGJiv/jJ+pGVK62vQuWDY7F2Hrr0=;
 b=RhTjK++44YKFJM0exTudpy6jWFEoev7DI8IqPKfBhJsx6zHNSptowWbE3FA+cnf1hS
 iQhd0KvUEoPTJqYpZmkjryvypZ+Gk/3qvt8yUPg4X8w3ax6DLYuxAPGomBVSfBwi4970
 JRfHZSUTzztDmg9dLj14Q1KxTu85HyoLs4UuJKieNW3kC89sHToPL45QZGJI5pvrn7cZ
 TgJ7fChUQko8Sv2vnST8C12MiMH81E+aIFZqKrAyD41hhPpN1fx+Q+CVj7z+Oq3oFeQX
 TS4uVu/uzGqQILZGsGXBPRU2fFTw198ej5FrvYcoJy1MjFDk07hjdLkhlzheFXridLv3
 JMmg==
X-Gm-Message-State: AOJu0Yw+W8rYJFjvozifFVCJrx4WDClGAm7tz0dqEHIxEfuk2vC9ayVz
 8pXEPtmdQQoyevSNEXaEe7sOANpvjlO+t9yXQ08cPXNELXCFo8nqCtiECXH+LoLF2uR0AsW81jI
 UTkJOqSDMONZAmf2W71wlhnONd6zKcyyfZ+ronU+MraDi8I2XqwtnQS1rgbz5XGvT9w==
X-Gm-Gg: AfdE7cnwR/bltYV0RBsroZzjU5LsaBc0po83AHN5XzHe3pCddjVFCli3Suy6xVGVOn1
 dzlFULCXRrvg8IfRewZMFwnQT3r6/KIGOKGpTWV1Nal96L/rlhMf6RSyo9H1RlKgrFcuGq/ZCq5
 qZzZHYkphx+K5ZafMrqN+JQfJLEm2XWkOcuaCVNRZ9TBp110oJHQeBi7tQsytZaIaoXlQCCg9BJ
 ItGzYlQEgnDDwdcVor6UXbjgZfZyPdAn9nkdyr6I+FnH79BEtX4eveXiN1v4W8kv7ikIYouFWnp
 PMZIOh/4f7SdYdtfkLyFLcjdhzelAIpQJYEexaOTTm427CA9CPU36Ykdk/sxMuDKeQQ3KLJK1b2
 3dOYOfoFacnbAVkK7AbE8wzjPhUDeFqEtMTHxyPk2K9XaHwQ+QnahJk2dbjhtkQzyHntdrrhzWv
 xPZd7lHQ==
X-Received: by 2002:a05:6a20:431b:b0:3c0:9c1a:893a with SMTP id
 adf61e73a8af0-3c0bccbc5acmr12815031637.66.1783664730024; 
 Thu, 09 Jul 2026 23:25:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:431b:b0:3c0:9c1a:893a with SMTP id
 adf61e73a8af0-3c0bccbc5acmr12815006637.66.1783664729521; 
 Thu, 09 Jul 2026 23:25:29 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 53/97] tests/tcg/i386: system tests
Date: Thu,  9 Jul 2026 23:19:31 -0700
Message-ID: <20260710062016.1818125-54-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EEfwjXILH_CG3_rHHvb2ipXzcFRnaNlS
X-Proofpoint-ORIG-GUID: EEfwjXILH_CG3_rHHvb2ipXzcFRnaNlS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX/2H8pIXku5WW
 kZ+IotpzK2Xi+RU0WXSIowl7Q2qun/Fdp2kztIuat4uzjnVyCXDAO3wW0a+hDObA0QSG52KoG5p
 sMdfBBa38SpVDI6yyat7qHwJ6NilI00=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a50905a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=B10MwvMbzDGICZWKPU4A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX48++7ZssSscD
 iCsvTbZFPgWE7lXeZP5NkhB0tzYq1lxeQUTP7lEwR88xlHlslN81UPAJ3C6IJF+j6cqREp5xR6V
 tWEnjmpiA4EpdaF1YmP/s86HMBXElO1OumgyqMuakHdNnUhunNVLhqogM453ubd9R+GvbHYEdqk
 ZJu3JsAS3Mvle2bv4CXxmT2+XFn6mswfRY9Fitt+KCnsY4kwSEbPNICtIbAbdmx0PSG/UjHZYiG
 HewK5R21Sm5Mq3St30VjtUYFHtWQ7sTvyMfc8Ws1ja68+8kZlNAqxeSytb4z4y69hIIvteDQ6xK
 GT0hf3K7jVJsnFXSADsdfMdKHzUQDMwqnIKE8CBgFDqyz4/aHoh7sdVNXOFYIjnV3emRlMx4qKl
 DnDmK8qGHmh3IS1rSsTFSg2kwHOfsmydVOQOY+0A2jf6h5RaTedpk6c9fEahy3npVJAZCjaTiEQ
 PFg/JiGMY1V/7TCI/Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/i386/meson.build        |  2 ++
 tests/tcg/i386/system/meson.build | 48 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tests/tcg/i386/system/meson.build

diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 62074b86c9e..5cda03655fa 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -2,6 +2,8 @@ cc = 'i686-linux-gnu-gcc'
 cc_dockerfile = 'debian-i686-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
new file mode 100644
index 00000000000..482a400555e
--- /dev/null
+++ b/tests/tcg/i386/system/meson.build
@@ -0,0 +1,48 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-Wl,-melf_i386',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-device', 'isa-debugcon,chardev=stdio',
+                 '-chardev', 'stdio,id=stdio',
+                 '-device', 'isa-debug-exit,iobase=0xf4,iosize=0x4',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-i386' in emulators
+  tcg_tests += {
+    'i386-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'i386/system',
+      'gdb_arch': 'i386',
+      'qemu': emulators['qemu-system-i386'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


