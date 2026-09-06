Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CD0C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38dY-0002Cx-Ko; Sun, 06 Sep 2026 04:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dW-0002Bv-RN
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dV-0000k6-DG
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4f5Z2LkVc6py1w60vXSvnjw7X6VX7rH9O/0eXx9/3+4=;
 b=PKrFbrHkaAJ2yS/atOagjevcVvfeq4BJdnk5h+OYnCSP2Di0NDBm48a8fwaPGvPY6Afe7W
 UqnIhCAQGCaAzUzgkIGN+PBINZsbxujFqkD+NllBGYk4A14RH4p2y/IjNZb62Avu7dQMsZ
 7PzhqYBRntr1MaB+YGUit+S1pcp42sU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-t8cS4YIfO-SKGlMhtZ-bnA-1; Sun,
 06 Sep 2026 04:53:57 -0400
X-MC-Unique: t8cS4YIfO-SKGlMhtZ-bnA-1
X-Mimecast-MFC-AGG-ID: t8cS4YIfO-SKGlMhtZ-bnA_1788684834
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F0891956040; Sun,  6 Sep 2026 08:53:54 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 657E81956042; Sun,  6 Sep 2026 08:53:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:53:33 +0400
Subject: [PATCH 1/9] tests: fix qemu:func-hexagon-linters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-next-v1-1-2b21e63974f3@redhat.com>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 qemu-s390x@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NLhLcoKyivTY8mRtFMa1LO0BDK310UULp9uJ4cn/vqc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSoYqTwrsZS++8CPlP07v7ShliTIgOUzU7/d8
 Z7NtY8NWQqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0qGAAKCRDa6OEJdZac
 5dJRD/9X4KOJTJCqrnkaCQ39svDlUdvMb87z4tI70g0NBjvIjPMxSwib+yPECuKkd90483BibGV
 AW1SPLqgTnZ1x4+JOfT7xC5IWS76D5Uu1Nrku/k2KQj9ugkVHUJDONpSc7kSswipj1KP/YGC8wU
 4zpjhLliwuAD6ijaEbUrYBRVEDkSe91CZJcfd1Ot320W+8W2Fj1P5bTrjzzHJ9r+PLkGGVrhQjQ
 37w5k8uSFMvqjaERSgEZ36NSjGB+TbDnTvztqBPrEmV03g9V8Fk/WdRNXcuI1v7AlZ/l6e/8fZZ
 fA4WRh5QoBetzun6l2tMKNie2WK9c43ZN17zO6AcaykJ0qgkaC10g6DieLy9nei3vGAncohpdCO
 5FMxrvZDlNKtBp/STuq8kU3cYLWzW5YBCEmvV4rlcHLClEvOhtADKnktEm/Fh2oHSzLIIyLzBzm
 3lHZJC2yOISJVjc2lh0uDRbZuL5UOKzqLnWJIEwprFF3g7ZEdl4OCHswYnLpUll2wN6ZvA2zPfi
 dsLS+ncEEV1YjWu2WETORujZklE2EKHEFrpRgjHzEIUxWM/j23GdBk64oVIkk1fkRCek6cc652M
 pe0drBztNWEffVzNJdY2muhZ5DsEYAlb1si4zn/a7nfuiSiRolQE22QARcDzHF0CsIkZ7PM3VTP
 hVw7NJuJn/nG7QQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix pylint W1514: unspecified-encoding

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/hexagon/test_systests.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
index f36e015f5021..4b0546e7ad30 100755
--- a/tests/functional/hexagon/test_systests.py
+++ b/tests/functional/hexagon/test_systests.py
@@ -65,14 +65,14 @@ def test_fopen(self):
         import tempfile
         # The fopen binary has a short cmdline buffer; use a short path.
         dummy = os.path.join(tempfile.gettempdir(), "qemu_fopen_test.so")
-        with open(dummy, "w") as f:
+        with open(dummy, "w", encoding="utf-8") as f:
             f.write("valid\n")
         self.run_exit_zero("fopen", "-append", dummy)
 
     def test_ftrunc(self):
         """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
         ftrunc_path = self.scratch_file("_testfile_ftrunc")
-        with open(ftrunc_path, "w") as f:
+        with open(ftrunc_path, "w", encoding="utf-8") as f:
             f.write("valid\n")
         # Sleep 1 s so mtime change is observable
         time.sleep(1)
@@ -83,7 +83,7 @@ def test_ftrunc(self):
     def test_access(self):
         """access checks R_OK|W_OK on _testfile_access."""
         testfile = self.scratch_file("_testfile_access")
-        with open(testfile, "w") as f:
+        with open(testfile, "w", encoding="utf-8") as f:
             f.write("valid\n")
         self.run_exit_zero("access", "-append", testfile)
 

-- 
2.55.0.543.g5ebe2ebe4ea8


