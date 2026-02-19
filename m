Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFC8E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswUw-0002id-Nt; Thu, 19 Feb 2026 00:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUu-0002hp-Ub
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:44 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUs-0001V1-JI
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:44 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4c65d744cso351246a34.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478561; x=1772083361;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NM9g9IJv0JVXzMFpoTHoSUhIbp+4DUOEDdp9HuBQcWA=;
 b=XCe5cBo5sLs6T4EcsvjmBXhn9PibkeXqXwWISTJsn3vh5pOpnHDx+/qIbeGJjfXCgx
 dSSUiv0RLrj0lcjtAB+/h2tB+WsRwNRa15HW1UI7379aFQCFDxJiU7dQrhcxBZmAc8jF
 N7Ft6X6DQsnruHDJW3bNRzqkBtf++6PVo+cfAoPRWL5kGWYGeyfa0d1sygCtQzSR0AsY
 EVuH7eW1pOD8nOyiCN7jvaUaW2aFbNibTil+HxmArFhTBJByhNByNEFzQDhLOyQj3n3G
 q1B2Bs/eReYonRrfrU2ODv+QblKRaId4UAtpCS7iZATqHRvoJ9/4JtXhVSIuVgpkLTT5
 7hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478561; x=1772083361;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NM9g9IJv0JVXzMFpoTHoSUhIbp+4DUOEDdp9HuBQcWA=;
 b=wQp6WQdtMGCMpH1DnMT7v2yu4gA4mmtgZ3vhU6M6uiMSvccOQUoQqTsGpE12BBMl5d
 5vAC7ec/tdnVh3v2iwx4UzGAZHvzGG7lfJAZQ/Q9TkMN7JfkI4cGcYL+3xQyP7giebZB
 gB9w5f+7e/6XTh8SDEU/EYnbSf0G9krt+jyifE9TRGhSaD48d0u1o8otgTkoMzb5dD+j
 55s2UjRY+t6L3oQ1P5A5nQs04RlLnBd29NEiGzimHTiGzY+AsVusDeRnYzUublu1CKWn
 4YXGdv8iTv+sRt9L8S6yrDQBpjm00X8OnX7hHFZOivdm0jH9IRbbRhS6UZbcN0qJ1LSN
 5AAw==
X-Gm-Message-State: AOJu0Yz4a6dtVLNIxXCrdP/ewKaAKWARLU3MbW4voA/5DBAV6s8FCoru
 d1zQrdpx5rZiah5GVSaQDlw4m3o0i1lSTxA4HlIRvtTuJAewAIV94uyMybCfT2nt7PE=
X-Gm-Gg: AZuq6aIC12Gq5OLZ8BNFFEC0/++smqg/6Hzty+i884DOIUUiP8KBFsEOVYcxj/7MOgg
 4088pb33+ncti4eXrNfDpeqM8N1n+r/mvL3CEGtNNsdhXUasg2ldP/jbD9SNgTsgd1fXrsQVnP6
 Q6/eyDO2w/zGYeztGEDTDqgzAcW2gP5eATCfmz5WHNdEUDXgcIXMUUJV8X+LkaRx5ofl8i38GgC
 cWFWUd/n71dGZMKkwBGQABvYdQgga/kAyIJcQe3uYNWx2uS3WmO+OcG01jzqQbZ7AlenICPF37o
 GTdbho2bLdLnZQHssjsRhId5G2B1aqQQoSQcd53NoZTc2TmErwnhTpKHuN4MPs9t66TWd7Qrj/4
 zxqz2bVgfoHh2jB4ATMkS7djN/OYjnUgaQ025CUD/hZXmzAAZSX77AfQMD2ICjnBIXe+ug3TlrD
 v7HnfIXzuZGw==
X-Received: by 2002:a05:6820:a07:b0:674:62e7:190f with SMTP id
 006d021491bc7-679a71ba4eamr2421637eaf.17.1771478561143; 
 Wed, 18 Feb 2026 21:22:41 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:40 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:28 -0700
Subject: [PATCH v3 05/24] bsd-user: Add function declarations for
 bsd-misc.c conversions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-5-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=jMv8o/VOm7CxV+F9rGpvq+qe7MCeDgV1rt2GbfBrNoI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4r3lKkDAGQjjbMO4c+xFC6aTCOEoWbrZCAq
 O1wEe9DhWeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 AO7mD/96PXn+Ceu+8WK+G+WmD4OhKN21SJ3qymw9pVkjZjSaD3CZKggxVyTkQdEcQ/yNgR6C+ve
 kPGJgL8/1qIrd8K3noYyer155SQvDgPK/wdmemks2Cu7DK6qxCANfC82EzdmQvW/p7w9ew/h+n+
 +JlxLzSIsG/OV1Y9is/ZCclaMi6vmMykKP4ribe4fdMhnKop9ooq29FDb3Su/t7lZwwKbP6tkB0
 C8n7RIZbAFeHD3+aUO3TfQ2Wh+PzhY7cDbNLXSXRYBnVBRi+u+fyvixe7Ik5oTpcga2KSFo869Z
 q+pytQZSPywOt5c1978/9aOl3Jym77wR4/hhcEeuh43OHk5fTCngwlkCL8GeYhoyd+X6UtksxJL
 YKK8VR42vZ+azCcUfAjCUz96CLS7CGLWRFI/HT2edx47WR/tbNe7csIarAfoQqmxn+ZRCC6zQt0
 ynS3z13XIt0ogqlIsml069uztXYBBU+XB4SnvAFn5ve1ASh1poTpgqLLRUVZUURVTe8GCis0jGL
 jpAfxFln4HiZnwPYGpHWEsaHzeU8+d3iZWRfHQtzaFNFMEJDv+nX/fWCnu/2nrGYGLI0LaZvb1H
 aSfDgJvngbQUX9JShAAHEp80/iZYFN0g0FqG+dRCX//MdJqbInaOz0DP2rnmxfFBA0scUX6T8fX
 wFjhH8loaQmEg5g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add function declarations for BSD System V IPC and UUID conversion
routines that will be implemented in bsd-misc.c.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index 56affcd31d..b98d1d76b2 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -54,4 +54,19 @@ abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
 abi_long host_to_target_shmid_ds(abi_ulong target_addr,
         struct shmid_ds *host_sd);
 
+/* bsd-misc.c */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr);
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_array);
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd);
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr);
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md);
+
 #endif /* QEMU_BSD_H */

-- 
2.52.0


