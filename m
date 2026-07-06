Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0FFC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtx-0003PA-VT; Mon, 06 Jul 2026 18:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtm-0002yU-Gk
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtl-0005dl-4I
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE81i1654885
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iEw9+4qnpQG
 fC0w5ladnSWMt4gvdJXjxhPCDCCY+xyk=; b=g4V9ObGKEH/YcuBf79aAc8t4SVE
 D7h2HP0y382GNOfz/BxmWfrvcbjYAeh0gkvAWjWEcAK/sdP+I3wc5Qb+4o20o5EP
 NBWw1VfRVtOyp8ui5jMlcpJHaeBzfHuQsp86nhlO5N+SQSTYe2zKln6IFV4GIOiq
 1zBtfWuxphYet5rCXWfH4IF2bC+E3gV3EKjN7egxn2Dp8T/id06OfreXSwUA2EUw
 zgoPwvJSksc2yYz2SaZurULFEjYr+7ivWW15/LGgheLovPspyxSltH39p3NKVgQK
 h5vQHIIs8PrL15ah2ke2XbuarEsuA8yJLUFYa1BG+cejYfLsn/9sftLnQxQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpk8hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c860544c077so9728597a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377273; x=1783982073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iEw9+4qnpQGfC0w5ladnSWMt4gvdJXjxhPCDCCY+xyk=;
 b=bqMXC98Yl6fDMtHSi6xErpoeHgjICbDIjLPl1YKUOtM8H4Bz4mHE1pFXdhP509pb2W
 /RyVCmRFjO0JxAAUAmlgwwuErOkmfBWhPvle2dBv0uiAKproHq4yXT0CICPhTXNrulyA
 1zHYQQcatQVocmocnCo8KvaqYZwwie9hPBa5JdvU61Kt0MK04lK5bDZIGsHKsFl1V61Q
 BXPB/+bvIwuLRaHkJzUJB2ySyr7raPge3Ko7+awA/flzHLS5C2KSKWu8fhhcKbuMHoDp
 Kfq2wzhqLdDjic2annQZiD1AgLoz1OLgTr1fmb5PC4NzKw0gwHUtMqQ5DkSp7mG3VLyF
 7A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377273; x=1783982073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iEw9+4qnpQGfC0w5ladnSWMt4gvdJXjxhPCDCCY+xyk=;
 b=RpOwbyQT31FRoHpxnv5eHIyRFtfk6qPZM2S2uPaT4aO5B1YbZap4Be1tvyH1VmxT4w
 VDsrUfEuUyBYPhZeVVlLq7Z0zRZZ+HfSBYIciSZIbznUiQjjSxU26XKPIr1EHLeGOAqk
 /4LTj6dK/IbwvRmBDrcvcYysq0K42KEr2cI1w0Hg+lNWffG9Y9mtgMMoHAWY13SPJRRv
 3c3q7ZXMO1JGc+oK1rrCW6t85KQMB6QvnGdljeNLihYb3kb7XaGoZf50i3se6Ea5wxQu
 7nyhr0lVXRFIAH2FDYq5eim2XYRI6eOPdRvrYqamuP4Caxz8oK5uMqlIdWcfoA3E2Zrx
 Y3Hw==
X-Gm-Message-State: AOJu0YzK2D/zuU9kkLTY5LWdo8D9grcDu+btfXpKa3Dc2Kh2Ii9+FH/D
 vFmSYOKx0aN4Bfl3xBqqusc2Ei9UsnlfPytPYmdBlf4WmldOKTmh7hs1OhUSiyKQ1BsVxAlqzf/
 tE59XOtBG5xCUsAJdgJsn+HjsW/V797lIo8MvLIabW1XDdTNE8h/xSzG6Uq0K+0JMAg==
X-Gm-Gg: AfdE7cmb1yR7ndgSq5HCGeW+jinJQyTgTOgNcaNHrXE+e0Jbi9j/AYAXX4DkccpRlWK
 dNnLlw0bkEpOnxo96XkI2rxR243r4NmpisVpv5bWgitEDLErBqKsQQFYJnCtq9KgHMT9Wg+/cnx
 wvZ/2kJuWDIoGdV/+q/aOfndjaOgRcRC27TV3tIyISYWD1mqREYLM6yMaoTeTguotpDxFr3CBU0
 e8UVTaXibAZq0JV6NMSy8xEMrUIo+p6zZFsmdARx9IMbBv44C69b1u5ECqcN68iW0ozx/+wLmYT
 xRutN9IN8R0gL3U0yi9VHjuT2dAkJGGury2b+abJcaHmS7HLNIP8F6UgF1XEUAsz90kaoj6WJu3
 pw+0O9WDO0jjMEx1NJBN5rgFhoxOI7Hhafmujr8tadjpW4iaqbirG1Sq6KyP7X2QTtIoC8Oj0qH
 H/pkYrnw==
X-Received: by 2002:a05:6a21:6f0d:b0:3b4:7758:e397 with SMTP id
 adf61e73a8af0-3c08ecd5cc7mr3165437637.16.1783377273257; 
 Mon, 06 Jul 2026 15:34:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f0d:b0:3b4:7758:e397 with SMTP id
 adf61e73a8af0-3c08ecd5cc7mr3165406637.16.1783377272835; 
 Mon, 06 Jul 2026 15:34:32 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 26/91] tests/docker/docker.py: return error code if probe
 fails
Date: Mon,  6 Jul 2026 15:32:38 -0700
Message-ID: <20260706223343.988769-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c2d7a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=9pnB6j0hrbqWY5gff9MA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: B8G7n0Oams-VnEOTMnZ3HOtoGYkgcZ2L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX41iv3Tl9U1/b
 a24e4xXdUDDfUpyXBWQniuXCyivpkmWjkbziUUZhjykGYexRGJ6KHyYCAZ1Rp70wSV7KPZZK/AH
 0oZ6iJbx5UTNYTgQoFJXIbESMMR+/wzGxSjcyK20DhbYFw85iRlaJRwpvx5SSYB0gYdeC2GILqm
 D5pB7JpmycprAmvDQKRMLKBybrhCOk52jVyjRAA8ymPd2+J9pOqryyjrtLMdMtiVtcoyrrxqrGw
 riFyxBLH1DtjtDq9KYxNIcUJp8/JvildvKURNx74rkNIkYpAqCJJDLYX+F0UYME7miPL8XnQG+2
 arGAWn+s8mANhBu8mJGELlgfP1E5/KEjdGqyzuovfeGFLKsUqPO5moBcmdfwNoPdjAhbamp71tr
 Xrx4sEwyTeUZkJsMNTB4qFuO+3JIoSVl0uR8cMPT9K1U+xoxIo2vxvFqx9uuhr8f4kBqs8RkdS+
 5c1dLmdwlAqBx7Ixdlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX/fuLvD+PzNBb
 8ad1HwZMnErYnLVy5hg86TKi/mznGSyPYru+pyvbKngakMLmmU4jewLKjEYfVv/Nso2nTd72sau
 KblToqOnSZ8KeLUxov33PpAtubVvjdg=
X-Proofpoint-GUID: B8G7n0Oams-VnEOTMnZ3HOtoGYkgcZ2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

We are not necessarily interested to know which engine is available.
However, parsing "no" as an answer is not intuitive, compared to
read an exit code.

Thus, exit with 1 if no engine is available.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9e18b984f45..6640cebfbec 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -623,6 +623,7 @@ def run(self, args, argv):
             print(" ".join(docker._command))
         except Exception:
             print("no")
+            return 1
 
         return
 
-- 
2.47.3


