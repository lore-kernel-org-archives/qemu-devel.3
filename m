Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07880CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnrB-00086v-TX; Mon, 05 Oct 2026 14:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqn-0007i1-9y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnql-0005oW-I0
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLwjc2207552
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 saDuWNjeY0tA6VDrlmMbvVPoUXshyWZlozRLdp5LS7U=; b=ViBF0QX79dbWN5at
 LBSDIfLJ0lesCde5PcyLadQ4JtLxviXGlNDI0Nwr3PRjUdm7hWFRhuaeH+Pxb122
 2jDF3YFpYdBJjJNnps6qBWUj3G4s6fg3SiaWZ+clx0lpsR0jIwWQKWejZOigVl65
 gCSSCKf6aplR36x9x6YL/znq7bBHVGwr6wwSzZaSWwB06zFtBideLNzmDzVjM4l0
 ZuFe9p5POfQfGK3BzLXAn3/3mrz0O9xMfPDnOXoyv8AS89LybHOSoRh+dUJgnlrs
 Z2zjamX9ukZI0a/3jijpNOfcqeYjeOZDsvDP4ovLrPvLVTudl/R71PxdIXL0l2oz
 nW59Ag==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4a7dswws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:36 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-147be78cd56so7700819c88.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226535; x=1791831335; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=saDuWNjeY0tA6VDrlmMbvVPoUXshyWZlozRLdp5LS7U=;
 b=Rdh15JtfqCfMQ9EPhoAdMdt+8HSElM/P+/MxsyJlato0pqO7QiqHkQraiXXRUPbyUg
 Xni6d2aPpEfeVpv8NoB9h7RLYaLa1JXZsggloIvN7nIb1bi1lqCcs9rTqUGNaiYiXIYK
 fSU7nyQWFkwvjOgtjUCOEaz/Ff04SqrSi7GbhYC6DaNXE2vLTTXK0bkScVUOG8oRm+BB
 FPuMrhSuPcQ+C/QbMj459v6Jf7gksA6WCb0+dZ44/Lk0LYp/be3OIgXQS9HLqVYXQl8g
 h2NodspHCKbXM/gOdO0ORMVAfaZATy07Ur4jK1Of/eibPkLmrICLCXaW9U5njFDHRksY
 EcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226535; x=1791831335;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=saDuWNjeY0tA6VDrlmMbvVPoUXshyWZlozRLdp5LS7U=;
 b=Zr0g8Mgcg42l/BxhVVnIBwsCZGiRhVoSHqMNeUYGg+kPZ66RBniy96h/j27qG5N2+A
 1o61vHp66XuRbLWszlVmdpjvBr3rjQnCjvEyweQ/6hNFaoA/u4z0KgLF1sfvc3bE8BC2
 eNVJrQZdhILvBG5rpOvhPK/gvW82e9wdFOwyLw3D5jF9QdPwPxYH5xudtlghw0Ko8W74
 6anhIXJ2QvLFLKGtdtgudRz7AvnZwpP+6v9qXjmAZxdAfaZfyroixqF5fZiJfdIEF81B
 xX6qqW7fEKpng6GTXTGtQhKUXbTvGw7BzWnlu1n0j5X6Nt/aYB5mCbhcyV1GmmOfTgG+
 6eng==
X-Gm-Message-State: AFuF++msNNIu89PmDvAvlQOUqkljdShZwZ8OaTiC3Zc3ZRXftdnazclJ
 8CoGrUWqM/B5yWQf5ZH5IHcrAWESuoOjXc/1Jc9DpJ9Y1lWOiOilLBTWEzqoPaHUNiIw6uoBOHk
 EeRmq/NZbEssUfdlfWSgRHBp/NsouWHpkbW/7trQKCN2HryN50OXoPAIVoELNfP86uQ==
X-Gm-Gg: AYBFou0hEBzqRHCTTAAiYn7qLlt+qZI8PZIQ41bDxd6PhiDDLv9G8XggG+0Uj8VuqDp
 x/rgLfEvBCmlRbV8mETO7EP4n0/bQGCIahc85usfroZyDHI3YmUYFL6J0vEd2MOmDmiH4kyagLQ
 3+9/LxkL4beirQs04jT25kgt/MbFe0WeiPHzIu3H5pUBzDJUMqZx74SULo9Zmg6o3XbOEhXbMjj
 4HwG+7AQ4qtMGuB5hLLahSLYAga415ATlDbTyXRgXbQ2LAXWisUqZlgnm5Y53b41FncsqOLoPmE
 vJd5UHzP1vW0N2NKvdLJ2BcXF2FyXm7pRAMbGSwzkL/PzWIkKBm7MhOqJMUeIhpJOOn/28K8iby
 NK8HJB8arh5w8zU+CP7IR+tpdjWzmXQHJSgO0INl0o47kKQ06v9fejAst+O1d
X-Received: by 2002:a05:7022:b058:10b0:141:4c37:a212 with SMTP id
 a92af1059eb24-14f58fd0f24mr15207298c88.2.1791226535303; 
 Mon, 05 Oct 2026 11:55:35 -0700 (PDT)
X-Received: by 2002:a05:7022:b058:10b0:141:4c37:a212 with SMTP id
 a92af1059eb24-14f58fd0f24mr15207248c88.2.1791226534555; 
 Mon, 05 Oct 2026 11:55:34 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 17/22] meson.build: add tricore-softmmu to multi-target
Date: Mon,  5 Oct 2026 11:54:53 -0700
Message-ID: <20261005185458.405929-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX9SpZ0Xmf8QSU
 7aaMBtfIbnYh1SPNW/2NwdrUs2Aw8otWXDNHot4veG37N0AAL5rfNy/jFfMfKNqH/CTha6apxpy
 tepm2CasGdIiUVbYOM+heBZH9Pp2VSQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX/o12n/LBhT5Z
 85hAcZXFgvAZ5LMSiB0MS/0y01V8mjn83ZkbFToxYaw2x9s01kB7gt0R+1nvEMLRN5yKeBoizA3
 pZ9mfBvDzZRGvoGj96KFLcpeQC9X02GFj0bJ/itwVohiCS44IvpSi/fKfTxCD2/FNmab8gYxddZ
 f8ZIC50zsmE4mW9XUeV9xjMiTNNlTKZARjhw/0Gvqq4ZY2rIfC1bpi3j5zLUgW+o02PeoSGgIK3
 dA43RasNXgLkEreKrLYUx7Iq2BrWFIAeYQ+2lP3LVWgmemSoYFUwqJ/pHp9cdNX+g11+N4CwRG2
 rZ12deavAg0LvPMwU336rhXvZRWyHNW+Zmbe+ER8Dxwd4NWgO1X4TqgOPCFNo3VlUvJ160ySdiM
 jukjB8480vgJpHOEuOvi/BkMlHPibcjHw1x7qOgZMaQOGfqL0Bq6FNLKm9zQHFLY889rQZCBU+u
 01V9eSt9FYwUMd/UcKg==
X-Proofpoint-GUID: WuJmUI6HNCUMdUIADB6Km1Q5Fuo3b2lk
X-Authority-Analysis: v=2.4 cv=SvwFe/O0 c=1 sm=1 tr=0 ts=6ac3f2a8 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=ORgI8T0eWTKedyQ7sHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: WuJmUI6HNCUMdUIADB6Km1Q5Fuo3b2lk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-18-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 487a5d6f7be..335d3dcf772 100644
--- a/meson.build
+++ b/meson.build
@@ -4270,6 +4270,7 @@ multi_target_supported_targets = [
   'm68k-softmmu',
   'microblaze-softmmu',
   'rx-softmmu',
+  'tricore-softmmu',
 ]
 
 emulators = {}
-- 
2.47.3


