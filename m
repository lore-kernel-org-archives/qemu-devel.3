Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B44FC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUi-0000vN-Dp; Thu, 16 Jul 2026 14:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUg-0000uC-9f
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUe-0001VI-Ip
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSlHR3395667
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7vL7GOvmzf4
 GR2lrP8sRDhksG+QOV9mtUHkgP8VS2iY=; b=iyx32np0tg+J1Q//YRa6VIEEGgk
 0MSMFOLPwotyVXFpZxixj21KWrQrNWkXoOd6WHeY0EHZ1NVoeP8RvI5t1Vv7DFVZ
 ohsYd9BSV2YZ02aDolJtj5PG8HQXti/ThWBy8SwUpSKDQDNBu3H9nCiUV9cPSm23
 6PUv2WJUPHMFB2vsC5+rjMFBIAadpn3ufdP3dcJky2ugpMxi/i8rprfSOAaOwAXO
 zVUEDlKVqUDbVnisVH29Wm2qO84pyWDJj9XLU0vRpSLBXFgT7YG9ER0+iRQNtmwk
 CnEtzbQUEpkHlQ8hIvXUIY1B3Y9jqMeSfq9EN2TqPsv2D6GIGnxmby0WO3w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym19f33-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38869800848so10413762a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225250; x=1784830050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7vL7GOvmzf4GR2lrP8sRDhksG+QOV9mtUHkgP8VS2iY=;
 b=M8EiB61SivTRr1M1TJ3IkVeOyeaaGsLD/m3fAosmCL90wWwLwhpCPB398zg7AveCAH
 XnAtvwKcz4sRjnE9/VlL0qxEB0vtP3YLqBJHsDn4NnY1BhANEh3q5FPpVquY8rVgerKv
 OX63qUmFpfX9v8PlB4rd6vCnKZ34u+D6WFhmx4DCC7J89HNQNvRgvvzDPSpbTm2TofdF
 FAvBKFROPH07Z7uU2Mcxx7cktn7nksLx18ic/84xcdwLS2X09nO4MpfmhFOCw4zpelIA
 yvse0ismq+zEeCfW0cQAx+BdTE1ZSvlbPSsLm+ZQfRth10aQAD5tgx3t33kw+n/417Bs
 a6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225250; x=1784830050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7vL7GOvmzf4GR2lrP8sRDhksG+QOV9mtUHkgP8VS2iY=;
 b=buke1W7Er2Bv+WnAt5f8yEZ2g/fw4Ow8YJu0mP2XtOL+/F8AMX0HywAeLJ/V5o0HON
 6di5TbLy2KF8IOsoCeSaOAJTdcfyMkru4MYin69aSGxdHm5ht/vIm315GebFrr7RaeyA
 sJyKd2v973owRD7LeLp5z9Sp/G2ti//1BHDx5KBj2rykQ3/UFiQnEuPCDWzsrxqneIcf
 X+GDjss5GUNAr8qAG440ex4rsQ9k7tl38Vr+bYfC5SBJxSggXmLesImobC7XTvw3QwDS
 EMKI2LnOZc8nZiev6Kew3dO+z0voOsHlqWIScDBDlR5CNj1R/f9+WZ7AVZdyWOLQvqER
 kwyg==
X-Gm-Message-State: AOJu0YytWeGqKrAwros/fGCShoOg8sqHnQDG9jbzEXhsKlEkvTJvVaqp
 sbZgUDITdQ70vIixeNJstqbyouanWDLMgdrzLQAMFGccQNSYp4ESlL5Jc1EQzqYu9H9abArocW+
 ZUWTyLfvYlsM+i4OwBNtwp36NRs59VYCJF88eBtw/+0SNuobeqRbnLsskdxTGuYCugg==
X-Gm-Gg: AfdE7cmxxuyur52RRwBm1frosSUiakUVlRjR87HJ9ekmQ/fc7NhMTNWO/6rVT1HfmfN
 gOUBqaDbDALc1d/OPvHFKphPyG0V+5oeMdW8ZdrMSA5dCbu0X0MNXsA7aJ9pBz2glXkr0bHL95G
 9uXJ6MN4C2LofkLaFSqkEubYoOxLbNghS6l/pR+d4sOmWGpMppTlZltFGmd5QYQjjU2riO6VVOM
 LTThsk/5fw7pA4AWAzy3upKtOqwxQSn0Erz1x3MZvzvZ8YL7rmzyW7KX/1l4pzD0ZmXfk0F8+UL
 l49RiOnTdYRXU8E3V7Ap6VU6SK5cVxqfiIhZCqGv+p6rk8wdf+0aefX5X+lh8w2WWR/1vDyYPPv
 2gn1jw+qNtiFyWRmM9ekGYdyOncogD+JsY9MM8PDF9tZ2ixok5esUO/Yg267ryms=
X-Received: by 2002:a17:90b:554e:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-38e1add8d8emr11346230a91.2.1784225250374; 
 Thu, 16 Jul 2026 11:07:30 -0700 (PDT)
X-Received: by 2002:a17:90b:554e:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-38e1add8d8emr11346185a91.2.1784225249759; 
 Thu, 16 Jul 2026 11:07:29 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:29 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 06/14] semihosting: add APIs for chardev-aware guest fd
 routing
Date: Thu, 16 Jul 2026 11:06:50 -0700
Message-Id: <90074658cf531e6af28e4857e44dfb6495efeb47.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a591de3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=4trHgkiC9q-UxXHgwkcA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX+O916wtXKqAN
 H0PWCW5C0v0k4b39GYXGfAGFdtRxiGs4YdrKRC1aKmINsdzf5yj2d+ve6W9fnA7wPG4m0UPGYlG
 2Yl1mXQFVIitbyZCbmkBzGfcIB2FgIyP7ckkNVr0F5c/B3SeHRRYYa+QH+48OedYKLXuLWXPj+B
 Ivv3tyOWfyx5mSI/RYa9mtvGOnuOcKkuyTfiBHukspf5PcvokurJ+4MhObnGdwdsDWIsHrKpLGJ
 yrR1DjXWa+Lyqhdr7z+vKg+IeP25shX5kt7D228PuekG0zEArywwX1IvvWtRfY9AI4MMG/tr1va
 TwpXnhZ+WY6MqnyH2Q48ePksl9hZ5EabxpbgtV55lBjxaJJUtZQbByg6BPaB1lkICbUf6daf7fT
 CKKRX5s4Fx3m2sZUA+ve0dKcZAybqe9twLlf/f4QVdltCNW+y+cK9Oq7G14zOk05Zy9hyNY7Dgc
 kRWOKC1+hHhpScemm4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfXyzOGzEIl45P6
 hXkY9PQdS8Z3TL2C4FnBGiuThHoyOVrOcBh/tTUAMc+oacpDrvxQsPqmp63gn1Z//1TIMmMDyA/
 BdvAzMj+fqfV99FkrWm5aZAlE6Mqcjg=
X-Proofpoint-GUID: xG5kH-cWrbSLyGGTv8S7kQzjqX-hw734
X-Proofpoint-ORIG-GUID: xG5kH-cWrbSLyGGTv8S7kQzjqX-hw734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Add qemu_semihosting_console_has_chardev() to query whether the
semihosting console is backed by a chardev, and console_guestfd()
to initialize a guest file descriptor as GuestFDConsole.

These APIs enable callers to route semihosting I/O through a chardev
rather than directly to host stdio.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/semihosting/console.h | 9 +++++++++
 include/semihosting/guestfd.h | 9 +++++++++
 semihosting/console.c         | 5 +++++
 semihosting/guestfd.c         | 8 ++++++++
 4 files changed, 31 insertions(+)

diff --git a/include/semihosting/console.h b/include/semihosting/console.h
index 1c12e178ee3..d5f149e2088 100644
--- a/include/semihosting/console.h
+++ b/include/semihosting/console.h
@@ -54,4 +54,13 @@ void qemu_semihosting_console_block_until_ready(CPUState *cs);
  */
 bool qemu_semihosting_console_ready(void);
 
+/**
+ * qemu_semihosting_console_has_chardev:
+ *
+ * Return true if the semihosting console is backed by a chardev.
+ * When true, console I/O goes through the chardev rather than
+ * host stdio.
+ */
+bool qemu_semihosting_console_has_chardev(void);
+
 #endif /* SEMIHOST_CONSOLE_H */
diff --git a/include/semihosting/guestfd.h b/include/semihosting/guestfd.h
index a7ea1041ea0..76ca0fcf1a7 100644
--- a/include/semihosting/guestfd.h
+++ b/include/semihosting/guestfd.h
@@ -70,6 +70,15 @@ GuestFD *get_guestfd(int guestfd);
  */
 void associate_guestfd(int guestfd, int hostfd);
 
+/**
+ * console_guestfd:
+ * @guestfd: GuestFD index
+ *
+ * Initialize the GuestFD for @guestfd to GuestFDConsole.
+ * I/O will be routed through the semihosting console chardev.
+ */
+void console_guestfd(int guestfd);
+
 /**
  * staticfile_guestfd:
  * @guestfd: GuestFD index
diff --git a/semihosting/console.c b/semihosting/console.c
index 91e5d50d502..9d786833564 100644
--- a/semihosting/console.c
+++ b/semihosting/console.c
@@ -108,6 +108,11 @@ int qemu_semihosting_console_read(CPUState *cs, void *buf, int len)
     return ret;
 }
 
+bool qemu_semihosting_console_has_chardev(void)
+{
+    return console.chr != NULL;
+}
+
 int qemu_semihosting_console_write(void *buf, int len)
 {
     if (console.chr) {
diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
index e8f236c690c..8b5770bab0d 100644
--- a/semihosting/guestfd.c
+++ b/semihosting/guestfd.c
@@ -117,6 +117,14 @@ void associate_guestfd(int guestfd, int hostfd)
     gf->hostfd = hostfd;
 }
 
+void console_guestfd(int guestfd)
+{
+    GuestFD *gf = do_get_guestfd(guestfd);
+
+    assert(gf);
+    gf->type = GuestFDConsole;
+}
+
 void staticfile_guestfd(int guestfd, const uint8_t *data, size_t len)
 {
     GuestFD *gf = do_get_guestfd(guestfd);
-- 
2.37.2


