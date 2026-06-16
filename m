Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E23CCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJAE-0006iu-FI; Mon, 15 Jun 2026 22:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJAD-0006ia-44
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZJAB-0007yJ-Cl
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:04:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G20GQm1801121
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wEjg8+U/42yccFbZy9d7OftFpIh1aOtbljZ3CkytmxI=; b=hliu5hNV2iKk2bRi
 Siye6o7ECHgdUkDwAiIWOH1r8wiqBDfUgfo1z38sS+Bn+ps5ytdLVeNqNuu0/wWV
 uTHLQPOgL8lRTFjnNxAptAAsEPHjmHifZyFTdwqx5+6IrVkep8PvgKjHUk9NSSOx
 wbIFpVmq4eZgvsTWf8yQpL9onAPbBfWhJPhKSqudMg1EeN1u6rpxTj1t925YLBeJ
 Tl72gU2JrxRWQGtMnDZK8lb1x1uDzvgYSZT/DXB0GN9sbkm8W1yc572dFseAEEK8
 KMX2Q5BB52Wuu/yUGWyTfaisCGEimQrXnFeWwTa7ssOXgp7fQFWcyRj872hS/SOw
 4oHDKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa741s8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:04:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157f453a27so582035885a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781575465; x=1782180265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEjg8+U/42yccFbZy9d7OftFpIh1aOtbljZ3CkytmxI=;
 b=JiienHjwnc8YqnkyB7+hbzQ3Qno72h2p/kV2GvjxrjZ7zpSi972cRgkA8DW6/XFK8C
 2v8U94BW6ZQJA8mNahsdMoRbAMp4tNpSYkZbLJWgLu6D+AfpmSh8B/rB/pVhvZtS5d11
 uSm9tUZ1p9Anmm0F7dZRXOmyK8BgTRzpg11q1LoIANRx6/Owb+aabBaBmGwIuqonzuHC
 ki7Rif/b27B8LxBWVXT/RQleA83loRaIvXH6ZGSyP00XEfC1t9NpAl0F8BJNhewvVvBk
 ICeybRkhSEF0KXW+A1wpketM+mSv8EXB3KsEgvn6IlE8LnBVBnDVCKTCu8ivKyHjWbHk
 dxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575465; x=1782180265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wEjg8+U/42yccFbZy9d7OftFpIh1aOtbljZ3CkytmxI=;
 b=L9A/4IB2qzZjO2iaPMSyz6DMd74jU+4VyteXfD/M/MJRigPf4wHVjr2qv9Sh6UhJAt
 cp2UZds0foTd4GhnHLK5irCrXRwxsyrdOgwJ69fGzodgvqQokHXdVZh6XTy/Kijq7urc
 Y5T8k4KwEVKKTIrq9zUWGNcZhYE//5hNyfrWxvPZJmv2t2H4GdfMxAaczfQ4lqWVn99C
 zGc4xTfcNUdJEFzgahlMMgEf3vSn3v6WItg8SC70KSWMRC16tS2OkN3S1jdJvyI87weZ
 yHEQ3ropDFsd0Lo7rhb+7JoGlH/zOswr3A6UCsQvwmzUjJ4dw30zEyEIauzxkWXchMoV
 U4wg==
X-Gm-Message-State: AOJu0YyXcE+rP1A/LLKqmh46MXVDD8uRtFT5pYWvZ5lg1APRv49D0gRH
 bFr1GZDKsiRQXuYA0ngFD0y/MkHcMLLBT4F9M8Iw05qHU75P2ZW7RQKvzB3c97FbKvVf3nv5YKn
 iqjEUhrOZwPOnAzCIg41ylO7CgR2R+I7yXFUI63ukOshnuEKd7Oz6oe7SYTGDd+Yl/w==
X-Gm-Gg: Acq92OFunfgxgq/HNaD00IxT7VYKgomkJSOsqKaJS6n9yMkqE9BLeFpEwSsqr4BMdvG
 Q08hua9WEeH/Pch1I2z+/DJGmoDZ2mRaNuJWmchPy6i/g2vDzgzfOjTAfYUbli6reGmhqIvl8j1
 ZcckDrpKeGAdCq7y1ne7tcNB3vkn5gB2OdzP+Nj/kgOP29madcU4F5UYz2l2LimON1sVvolt3KC
 456QCOhgBtfxteQvK4QLxuE5nA01uewdmu07x1xeWyzBfEVoAQZZsyxw2m4Ctsx+mQxMGx/yfeW
 XTHM+/tZ+dH7iIq3YY2SPGb7l8/y5Tx3vHR8f9wieLX8X9H9gxrnE6vYrxWyUijh5XF6Gw0T52f
 ELByP7OLbkDrmx+eGpzdLdWr9Kr/CWoZe085BNQyQ7jWhSOmH+RQ/F3Mo2hfffdd+1U2vfbr+sZ
 h7UUA=
X-Received: by 2002:a05:620a:390c:b0:915:cf88:1e3b with SMTP id
 af79cd13be357-9161bf722a8mr2589454085a.47.1781575464635; 
 Mon, 15 Jun 2026 19:04:24 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:915:cf88:1e3b with SMTP id
 af79cd13be357-9161bf722a8mr2589451085a.47.1781575464131; 
 Mon, 15 Jun 2026 19:04:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c10sm40199342f8f.21.2026.06.15.19.04.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 19:04:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 3/6] system/memory: Constify various AddressSpace arguments
 (notify)
Date: Tue, 16 Jun 2026 04:03:55 +0200
Message-ID: <20260616020359.18627-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616020359.18627-1-philmd@oss.qualcomm.com>
References: <20260616020359.18627-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JpnK6zATV2VWJ3rWYRjCOpVtmRAusOAq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfX74l3mfnEoUES
 GduwzdMRc6Cw5kuA0uLBdsa3+Lh/77apYUo7fn4WBBe91T0S9dAa3H6BAQsKzQZstjTHxsWRfvG
 wc1KyCXL0EoVib9UbqdKBTnIwiixZ6U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAxNiBTYWx0ZWRfXwxXYuYwEj6yr
 UAyQYbFjj37xkM7QxKr2uwbrNrEba5wyf73dFH/ZNfG3yV4IJZJ2oD6Qo06hopXzSsqnE4ac11y
 ziqymrXJXAy9CqEJpVF92NCW8j8vMtAY14muVTSByr1EZJylj0GqmeuC9AUUuVYHch4d7xi+1Ua
 oyHjLpV0AQMZjkUu06uetKjYwN9VnV+SWyVhsCfhkASJz1FPxfvwbDs/cDjltAiM+kxkmVHpA/o
 1PworXLle8at40lAfjF+zDVBEV6lF8OZ5S5APt4cWoNZhU2/CePwARXpI2Kp4t9okIK0yAtuiRo
 /MOFgsKV5tBNutUeIayaJFhIgl7I1DHF1x019O4wk5SnSyU0tvOxANMn1ZegHzKtTLmwAUWRq2x
 +padRQa574MHQ3daCcHQIKkO5iu5ni3AsogJ5nMwrJXQmt46c9MvbcLBgFZIbY0xqc6QpukOi70
 jiSE7zmlqo15hWlSRlA==
X-Proofpoint-GUID: JpnK6zATV2VWJ3rWYRjCOpVtmRAusOAq
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a30af29 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=nR6OtcKYjoWMIbXoh8MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160016
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the AddressSpace structure const when it is only accessed
read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/memory.h | 2 +-
 system/memory.c         | 6 +++---
 system/physmem.c        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 5c525646193..fbb4166008a 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2682,7 +2682,7 @@ void address_space_destroy_free(AddressSpace *as);
  *
  * @as: an initialized #AddressSpace
  */
-void address_space_remove_listeners(AddressSpace *as);
+void address_space_remove_listeners(const AddressSpace *as);
 
 /**
  * address_space_rw: read from or write to an address space.
diff --git a/system/memory.c b/system/memory.c
index ea2ce80cf2c..f58fae67fa1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2985,7 +2985,7 @@ void memory_global_dirty_log_stop(unsigned int flags)
 }
 
 static void listener_add_address_space(MemoryListener *listener,
-                                       AddressSpace *as)
+                                       const AddressSpace *as)
 {
     unsigned i;
     FlatView *view;
@@ -3050,7 +3050,7 @@ static void listener_add_address_space(MemoryListener *listener,
 }
 
 static void listener_del_address_space(MemoryListener *listener,
-                                       AddressSpace *as)
+                                       const AddressSpace *as)
 {
     unsigned i;
     FlatView *view;
@@ -3155,7 +3155,7 @@ void memory_listener_unregister(MemoryListener *listener)
     listener->address_space = NULL;
 }
 
-void address_space_remove_listeners(AddressSpace *as)
+void address_space_remove_listeners(const AddressSpace *as)
 {
     while (!QTAILQ_EMPTY(&as->listeners)) {
         memory_listener_unregister(QTAILQ_FIRST(&as->listeners));
diff --git a/system/physmem.c b/system/physmem.c
index a0561177afd..e8a2c438c7d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3565,7 +3565,7 @@ address_space_unregister_map_client_do(AddressSpaceMapClient *client)
     g_free(client);
 }
 
-static void address_space_notify_map_clients_locked(AddressSpace *as)
+static void address_space_notify_map_clients_locked(const AddressSpace *as)
 {
     AddressSpaceMapClient *client;
 
-- 
2.53.0


