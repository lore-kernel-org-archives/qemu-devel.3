Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42245C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4S-0005AU-E5; Mon, 24 Aug 2026 11:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4I-00057f-J3
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4F-0001ki-ML
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFnMnF2956446
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=C71ZqtJEtpy
 9h/1ghTM05rDegvSURFCI0x+7CkYcLYM=; b=W0p2eAafMnJi2lQxMH3tEoGw3Yr
 FCnVL2rH40FhHLlBBGq3gkU42zVA6VAkv4I36bEJRtLptF7SX39/FjaBmI7r5Wkm
 IkMIa76DKgpeYeY//CGPmVrnNHSWq/8MebeDPBFU4GjzO5zAZ2UF3J1mgMhZYNsc
 d/V1cXYXjak7vsA5qrg4FtTfuOjwq8UiB40BDlE4eLX/ipDynlsBeLxr6mj3oBSa
 1eJBKtGlrLdIuPW8gaXz5XhJkPqWWjYUXtVSMfbdfEdnUmPBaDCp9v8kr7LXjMUw
 GIud574BQ1h8fyy8UeQJZKIjBCv48JkCgy6TQiKSKodmeZaqMC+7AseAvUQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdsjg3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8487eb67173so6261439b3a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587114; x=1788191914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C71ZqtJEtpy9h/1ghTM05rDegvSURFCI0x+7CkYcLYM=;
 b=ZyaP3EgLHGntcEI8dtnwAmF4Pe1ELgoFa1wJMhwrMaOqajJktfGvng5IzjirenEmqB
 Ykvcmlk+8QWCUIa8VV5MIxzll5fjgg4kXUI9C5yQqufxI7prERbhofoe2FpfL7OtfrDb
 GkiHUuls+jf7v0tF1BC+B0QRdncbsFL/KRKQUXPlHhApraF/9KWtRcBPZbDsUgWfrWoO
 GZCGUZfIYFVZ42748gCRKHoM/VI8nQGlwAk7bTbrc0O0Em2Cf3s2xY2Y+SqwYzE/Og4o
 EvUPcdCX5CbLKQbdXXtvzbjDNK0c2R59e6aNCjrZ34L1iwNeGpjZPbHXhLJXMWD4hW/1
 r+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587114; x=1788191914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C71ZqtJEtpy9h/1ghTM05rDegvSURFCI0x+7CkYcLYM=;
 b=ZhQMZv7XExd3i4+zvSvHCgdHsiFGroZlZP9eIL3WcKutCuFMHkxV97GAx/taOdOr1n
 f+fAfcLCbipQEAtv0Wc/XRI5VjpCkMhrapneuD6UYMvip315lt+WgjuLBX6nKJ0qDgkA
 +1Ruif4/inpEoYUsq/1MiAb20vseUl1P+htEpOKsrzaeFpH5o2+OJONYeMsaSilDkYB2
 09rKWgU7kmfeGl6TuZYFsBJwYTKYPF6fM2ez48HEvgv/l8We37DvTTNz9v6V0+z0lQ4+
 H8NGHhcl7Ku5RUjNvs9NIgZHmxWDhkFowBE47zDzm78V8bDrj++stXL625xO4wesDzzd
 nylQ==
X-Gm-Message-State: AFuF++kdLGvMx/OTqVNo6MhJkEtyNfeDp/NgY/21h6Pj1tPzA2VqZKXo
 9ztYFjUp5HcbSWZhRD2LaNahipTVj5sUms6cC5idcDam5Or8UMrZKH0BTU+rOg/P+zLw/eXqo11
 Hb3OyQyvrLxDwHZFQPB21T5DJsqME6tCZEAtg6kpYeTjocvaYDHOfW8gYKI52Bem38ebL
X-Gm-Gg: AR+sD10R3yYIwPgRvTZtnl9BMOLqigkL94oOvKmB6nMt4NgT6yHhFOVSNsxmW1m+JJK
 kKj6rHl5H+5mttwST9Mp0CgErNm3pjb3V6Y+b6jmCoXcHle/jGQOKl4EHj/Vv7lyJRM3XyKGKkp
 /0xVIh7ntfqzjNZRvCj6V7fwii/vwAOxMTw/bDJEJj3LJHtPgikovesmxMGVJeZd6MyPw7PQF/5
 BLRfbnxJy5bHmp3Sj3yBrJPT/L6wjksiW0H3tIaii/ypUPXWFmsoGxtv1+SaOeGyIjLN3kX2COm
 8tF2heyG9w/cn9Z6elFjpdllrJ7ShPaEqk91f4z7R5BOT78NUmjoHQ2g2OXY/4a+pry5R0YvwXZ
 VqW0fY5MGL0qzNeUjA8W6xyn94zlG5BfdMkMcX2PqgOqXfzNmP3MbHI6ki3fyTCY=
X-Received: by 2002:a05:6a21:138f:b0:3c1:fbf:1e2e with SMTP id
 adf61e73a8af0-3cd3008bf4bmr45472632637.10.1787587113665; 
 Mon, 24 Aug 2026 08:58:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:138f:b0:3c1:fbf:1e2e with SMTP id
 adf61e73a8af0-3cd3008bf4bmr45472540637.10.1787587113210; 
 Mon, 24 Aug 2026 08:58:33 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:32 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 06/14] semihosting: add APIs for chardev-aware guest fd
 routing
Date: Mon, 24 Aug 2026 08:58:15 -0700
Message-Id: <47eb2ef70ddac371aa403ea94a516cb795983189.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zulK3WsdcmynmdS_4ChbEqICYlZ8Xbzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX3Ecvw+g/+1e+
 1qsmL59SnALmkJGic9QN9hvh0H5RQpjL2QdzpOeGhG08eaZxnmRADoPbvsY75dllQNJEhZGMGkg
 rV9OAj2uX8it1KdC0/YpZRhsAtPpQEoHzQobDicyl1pLZHRgFJ4Y43fmwb4tGmPLhLSclIobtA6
 gP3L1TjmoVbcCCiqTSVczpt+JWIkyEvNZuGJLrfPAkyU+dCxRfxdcwyM1dBX4bcVsfp/JArDgkh
 eNuBCXJJYyjFCuRmCzrThTvAFTxkKx9Lr3gr4yOHIvfhIh1WTPBHQEIArpArOKlrMen2HOIOWow
 Uo8ybfmlrDIdnln6+5f7imzhrYo3EryaAFmLl47ez/NA8AQS+MvrKMfCV6cSRVpRBSvu+jZ95dK
 O1kd2Za4SFdVE3AJ9Obiut9zb5xUk4P/PlBtSIGA5idJQxKUPZxKt9iZ1DYbDgqzWjwOs9ZJ8b3
 c6vHyUfgDR3A+lnvZgA==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c6a2a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=4trHgkiC9q-UxXHgwkcA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: zulK3WsdcmynmdS_4ChbEqICYlZ8Xbzd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX0QhM9p7KNvxk
 /DkQIds9xtRV64akL2d+bebg3hK28CvlaG2WqkvQ8ozQeUZV7f+kqH8pHTGNoC6Zi4mfQG6q37V
 PRvs7IBgI8opYMN/hV7cx9bKRabECX4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
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
index 1c12e178ee..d5f149e208 100644
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
index a7ea1041ea..76ca0fcf1a 100644
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
index 91e5d50d50..9d78683356 100644
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
index e8f236c690..8b5770bab0 100644
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


