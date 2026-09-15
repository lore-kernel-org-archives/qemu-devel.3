Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6276DC88E7B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RZb-0000hW-Ge; Tue, 15 Sep 2026 07:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6RZL-0000fD-Qj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:43:24 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6RZ5-0005Q0-I6
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:43:12 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485b1d2874fso994231f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789472585; x=1790077385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cFMp897/2LhAMY3XQX2UH5MPXIwRH5TBMsVmASGwDU=;
 b=koD5z8u+Fvb/aXoYJOmxzCMsqe48cKxHVazvkVepbvAi/0ObG1yhT1r0r5jIlhdWC7
 xzYZYg8WYGql0Mqm/JcAf5B5W4jBSff52Yi2geaGRt/h33hBQ7sETMUtAp+DeI8bIkI1
 wUGyUkqwRJYh7usWHGwQpR29iseif6sFoEpB3M2tqyG80GRDFpL7wOwWgP3X/zg3Z0/i
 S6LTklIbWMVvVzZWpQ0MAsaiwBA7OY0LZ95t42gn3TORlxTCAT5FAgHsK5zCuYSEpk6Y
 fpdqd2L7TIz2i389BBUAZHZNVKeZHtKAZ+e+bSSo5MnuHnSeXXN55tLVabGEhRFiygDI
 mwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789472585; x=1790077385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0cFMp897/2LhAMY3XQX2UH5MPXIwRH5TBMsVmASGwDU=;
 b=bMvp/1iDIi99yjNZ+tuCvQ0nOm1hgma6BYAhCUzW2sK0EKVjlrhRm9of6GzGzUSO1l
 CDaHGthPGxKxSL0/KRg3lSzCxBYBF1hfqWfwbOTq2hg5oAgtYiwO5ktBoiUAUAxvORQ7
 OQBad/2R/CshgE6J9irl7NlOVUG8LxQgU3TjfOfOWo7ngIOzjoYmKvPjXFiRwA8ShJZ/
 RBl/gJuLak5YB0tFGFJNHiEUj4HrigStzZavwgFB/iDErk6xkyCKNw1Mi2YDhkKvW/v7
 1MEjdEscPhw0V3ICj8nKHEUaGdykjLGiOSGGCbAfc2uwgUlpMK1WpvM7Na4cbMbucCi2
 Vv1w==
X-Gm-Message-State: AFuF++nkeKbGnGsXNWmrYoFWxoKeZjvLRHfioTi1uKd7CXelTLFvDYkE
 NTI3BwOM7iKRexR70xPQkklfzVu1Psg+RilaNdvsWfL3OUwf1cAIBFuwEVF+liJLMoXpzs2dIN6
 yKByJ
X-Gm-Gg: AYBFou0sbDbAaTYxsYexe4ZPRNg9dkNHHr3J6MYghRG0udfmovFv1fN5MLF+2xLAVqj
 dTq8nMrtjpzZcBwfzCdaWWqxtrJIWGjR4lSIUVR1p9yf/xQ3+F7DpyB6ZzlKX//5ervGwcR9MVF
 tBwoUBqnHeBxITIRduawT3vIcn/aC5SYZwYxzLRDPydEgP3ENBxSX7wQ99otq7d4pNkaGzcWE9R
 cBFxRtII6F/xGITg7ymvKxrQM//5n4hkwozK8+ELubbJmdrWQJX0Si/yAp5r5kVAg3cIRctMn1A
 ae9VMSzenyp9l/KpWwX4wCXYhxi/t1zCCEBkQtQnz8WVMHDDwQkh6p3reiJ1Qr7LP4iHq4A+twv
 9AbmoXXuoR5s1UNSAI1f+EFUatJD7CLz5+5HXhhR7RzDsIb/YS3BJvQQuENvUM/yg7wH8Djdsu/
 eOTztRNq548+chsRU+SI0QX8utvxSSZskzsDe8J0C5N4LCBGoC3rxztUlx508H1LZN5KXIy06IH
 nMC6uQ=
X-Received: by 2002:a05:6000:41dc:b0:487:a87:24c9 with SMTP id
 ffacd0b85a97d-4870a87263fmr963470f8f.3.1789472584879; 
 Tue, 15 Sep 2026 04:43:04 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:33e6:6107:4678:322f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e4b5sm33648081f8f.22.2026.09.15.04.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 04:43:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/3] iotests: cover the qemu-img bitmap operations on parallels
Date: Tue, 15 Sep 2026 13:42:58 +0200
Message-ID: <20260915114258.3862446-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915114258.3862446-1-den@openvz.org>
References: <20260915114258.3862446-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

qemu-img-bitmaps drives convert --bitmaps and every qemu-img bitmap
sub-command, but for qcow2 alone. It is built on a backing chain and a
rebase, which parallels has neither of, so half of it could not run
there and the format is left with no coverage of any of this.

Cover what applies in the parallels test instead. A copy made with
--bitmaps has to carry them, and raw has to refuse them. --merge and
--clear leave the bitmap count alone, --remove-all sweeps it to zero,
and --remove-all --add in one invocation leaves only the bitmap which
was just added.

An image which was not closed correctly is left out. parallels-checks
covers that already, next to the code which drops the bitmaps.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-bitmap     | 39 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-bitmap.out | 12 ++++++
 2 files changed, 51 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-bitmap b/tests/qemu-iotests/tests/parallels-bitmap
index be0ba8185d..8ae9314114 100755
--- a/tests/qemu-iotests/tests/parallels-bitmap
+++ b/tests/qemu-iotests/tests/parallels-bitmap
@@ -273,6 +273,7 @@ stored = file_path('stored')
 copy = file_path('copy')
 STORED = '9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69'
 OTHER = '11111111-2222-3333-4444-555555555555'
+MERGED = '22222222-3333-4444-5555-666666666666'
 
 
 def read_header(off, fmt):
@@ -434,3 +435,41 @@ log('--- and the image is still readable')
 info_out = qemu_img('info', '-f', iotests.imgfmt, stored, check=False)
 log('image opened' if info_out.returncode == 0
     else iotests.filter_testfiles(info_out.stdout).strip())
+
+
+# qemu-img-bitmaps drives these for qcow2 alone, as it is built on a
+# backing chain and a rebase, which parallels has neither of.
+
+log('--- bitmaps can not be preserved into raw')
+make_image(STORED)
+raw_out = qemu_img('convert', '--bitmaps', '-f', iotests.imgfmt, '-O',
+                   'raw', stored, copy, check=False)
+log('    ' + iotests.filter_testfiles(raw_out.stdout).strip())
+
+log('--- convert --bitmaps carries the bitmaps into the copy')
+make_image(STORED, OTHER)
+qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x11 1M 64k', stored)
+qemu_img('convert', '--bitmaps', '-f', iotests.imgfmt, '-O', iotests.imgfmt,
+         stored, copy)
+copy_info = iotests.qemu_img_info('-f', iotests.imgfmt, copy)
+copy_data = copy_info.get('format-specific', {}).get('data', {})
+log('    %d bitmaps in the copy' % len(copy_data.get('bitmaps', [])))
+
+log('--- merging one bitmap into a new one')
+qemu_img('bitmap', '--add', '--merge', STORED, '-f', iotests.imgfmt,
+         stored, MERGED)
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- clearing a bitmap keeps it in the image')
+qemu_img('bitmap', '--clear', '-f', iotests.imgfmt, stored, STORED)
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- remove-all sweeps every bitmap of the image')
+qemu_img('bitmap', '--remove-all', '-f', iotests.imgfmt, stored)
+log('    %d bitmaps after remove-all' % len(bitmaps_reported()))
+
+log('--- remove-all with --add leaves only the new bitmap')
+make_image(STORED, OTHER)
+qemu_img('bitmap', '--remove-all', '--add', '-f', iotests.imgfmt,
+         stored, MERGED)
+log('    ' + ' '.join(bitmaps_reported()))
diff --git a/tests/qemu-iotests/tests/parallels-bitmap.out b/tests/qemu-iotests/tests/parallels-bitmap.out
index 994c67390e..df6f676106 100644
--- a/tests/qemu-iotests/tests/parallels-bitmap.out
+++ b/tests/qemu-iotests/tests/parallels-bitmap.out
@@ -92,3 +92,15 @@ read 65536/65536 bytes at offset 0
     0 bitmaps stored
 --- and the image is still readable
 image opened
+--- bitmaps can not be preserved into raw
+    qemu-img: Format driver 'raw' does not support bitmaps
+--- convert --bitmaps carries the bitmaps into the copy
+    2 bitmaps in the copy
+--- merging one bitmap into a new one
+    3 bitmaps stored
+--- clearing a bitmap keeps it in the image
+    3 bitmaps stored
+--- remove-all sweeps every bitmap of the image
+    0 bitmaps after remove-all
+--- remove-all with --add leaves only the new bitmap
+    22222222-3333-4444-5555-666666666666
-- 
2.53.0


