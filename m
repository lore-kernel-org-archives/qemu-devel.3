Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C992C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcBf-0005YF-6l; Tue, 19 Mar 2024 12:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBd-0005Wp-8w
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:37 -0400
Received: from ivory.cherry.relay.mailchannels.net ([23.83.223.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBb-0004AC-Lb
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:36 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 661392C3041
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:33 +0000 (UTC)
Received: from outbound2.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id B7FA82C2D8D
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:32 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710865173; a=rsa-sha256;
 cv=pass;
 b=B3aNSDCU8LME82PqEDxlmT6RomoV+OcY/41+jScKZLKirhe+Qu7jJ+PWFAlHPqA5tCqcji
 VLnPuS5kjXTB8a72hOQiZfcMqPdvBi9t3RfPoHpjLqqv/R+iEMBPFy+bb6rLciZ5whfkau
 0ZcisgQAWjEusb1nrZwizkfk3vuR4lfKCK9q66CPw3aonjMKbHPUPSuyIsvtl9rh0wZuw9
 AMhv7PbHQrFGvli1eRJbZ5u3kxQZ3Rs2f2hoFVyGXSGyFV0eGUX0vGg4W4+61liepW+Knp
 8717KVWbGYK2k95fmyiQtlRyla+wfg9zqmtMbyMO0Y6GKsLSqdFwPQyCy65PZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710865173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=DipQ3AMaAdAtn5EwnSvutFf3vANlprVUYGAtGwQ8xJA=;
 b=RMPMtlNINOFqwWPXhjrPQHRSnEsszlLHKhXmURFYkhuG6dQhV2WZaht+At22hfkLVKftbL
 9YZvreW8SUe8+4Igrq1dBqM04JiJtoke6UhxrrZmZVLVtIW+zK3vxGsZnKjZskQYoKVYIG
 Ov51NQyVV9s3J8U+ntCkmW18b7qkfCI8xSG2Ldeye0ZwdUhcDzE+VG1f00joQ/siJJjvQ5
 vg11Mn5EdUXq9unQ1lFK9XrEkCsdgyqKzToawR1TRpikOVcbsnACVKNRlhEuF9RADc0uZ9
 sXENnuOF7JOLujiJSzgCrj4DZlIGMNvJ0GVRQMbt+OUj6ek2o0e8C25zad4hSA==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-jnsbj;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Little-Whistle: 16923f862ce836b0_1710865173276_1987288883
X-MC-Loop-Signature: 1710865173276:484894446
X-MC-Ingress-Time: 1710865173275
Received: from outbound2.eu.mailhop.org (outbound2.eu.mailhop.org
 [35.157.29.171]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.105.100.41 (trex/6.9.2); Tue, 19 Mar 2024 16:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710865057; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=wAIHBA+mMpqm3dAgW0MfJmWzS2bn93US6uYnZ4xL81PvuEGc6wFI8HlRi/l1x27kYm0SRHIqs5DIb
 m04edhKpVXrzzNUxH9yU6w5qrcgTOobO3z5QXAb60+OAj08A5fE6wQMOBOpUDY7y3Rx68FVCiVj4yf
 otvEofa0iHnljw2yZrjbBfm8Bq6P+6/h08mJMsNcF2mY+MxpOOFvhRRDHP2r1Cox09mPeQLexAwk86
 xarmLaVSr8RzEd2a9vwH/3PRHSqmDqYJ3h+RNhhlydeTICy/sVMECtSKndydNp8vnshuw2fN2e55p5
 5hWoz5taWDn/ItIa36hwaT/rY42WDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=DipQ3AMaAdAtn5EwnSvutFf3vANlprVUYGAtGwQ8xJA=;
 b=iHhB0xkAR/3COAq37SRKs2cQNxCecqscIgfKyeLGGPVuWOeYauSE2W0xaU7tY4AJkDa7IuKrxaava
 WLzVTgPUeriimrot0AjIP280nbpq81znmdFvxc44jU5qa3rr8yq1eTi95Am7x4EMj6Uv+bwBtt9tZY
 C2rfNPaMdJoH1UPa5M+SrVKLGaGM9kgnNofZc4ibei/uN5hfZQHrvlZMXz7OVa9eUAPbJbBOTBbx5O
 aNbaZodFl4OAuLeG9OqNs8R63vcFLVH4f/AVcHAAyCDqDT2rugqFRxOXQ2FhVjbCTOGpJ6cZqFMiDi
 fxCsOS17taN4+ZXh58yVXqwe/UAzQ1Q==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=c1a37i5O; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=DipQ3AMaAdAtn5EwnSvutFf3vANlprVUYGAtGwQ8xJA=;
 b=D52o95d7vzIUq1x0HXSdNPMfcIMZ6N8k4PBLkIFzFF7vM5c3qBCRH/LSqnlLH3JSBToF75VVGM5Vh
 2Ir6Fm62YKkezUrFJSu2Iep+Mwre9KBx3qiFDCzwZKWewU4czepLmzkfp6o9CS1hOYPfbEWyWhce2c
 Ktp1oTHALzCb8sW4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=DipQ3AMaAdAtn5EwnSvutFf3vANlprVUYGAtGwQ8xJA=;
 b=Jlo+pwFuyvNJmFZuGd7MbRX+GnaMYp4GACq9BPd+qi0zpOfH07/16pcjL0rNhazJBL7U/NwYZxq60
 P8xlA6YIuJwz7Yaado8NoBQIl3I7d50sFuAgSkC1bnHaS6gx5iHz41XbeWtu/w9SHdhgBZkXgBem5k
 bQLMyzML16PoEWVoI/Aq7XHhHREhwIzgcxFgQBm8HFtjovtHuLJxTQDeS0zWSiK6sCchY6t1fJUn60
 j6pA3rflmAcOAt+TICllKCdsY2El0rccji1IJbB/DQZQHUGPHqyZ4m/OVItrYP0vGF4RFwqMUlh9Ax
 kHz37CqMmVUDpLc9U83I9H7SAsfAwFA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 31e644c4-e60c-11ee-b7d4-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 31e644c4-e60c-11ee-b7d4-9b9d9be6ef2c;
 Tue, 19 Mar 2024 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DipQ3AMaAdAtn5EwnSvutFf3vANlprVUYGAtGwQ8xJA=; b=c1a37i5O+1UVmk9Bbkb06hUQxS
 XMs5+dEJ5ag8lyaFaGTum5R1SDySbl/ZjuHwFEroALguH32nPitQzvHaO0vHHXEy1uliyZI/xNenK
 WdmLoN9k+1Ml1L7witHoo00I3/m6Yuub/QknlK1/v3TJBRiZ14w+BfeD0Qk2l7AQ5fvBVFub2g5BV
 ee+CRYlEoy332gLg5LvjQ2cL+/+m0uv9di/OW9bjv3+W7kVEk9PR/it0A0+4iYPBqsyDguYyoHqh5
 do0oNh0kZadei+QIopLYfLL4MZjg1+ysHmS7gClUOu8PAPNnHdZhheNp3K3zYF/q5Wo/l8oDDfkHX
 se7+DADg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmcBQ-004VVI-2o;
 Tue, 19 Mar 2024 17:19:24 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 5/6] target/hppa: mask privilege bits in mfia
Date: Tue, 19 Mar 2024 17:19:20 +0100
Message-ID: <20240319161921.487080-6-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319161921.487080-1-svens@stackframe.org>
References: <20240319161921.487080-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.94; envelope-from=svens@stackframe.org;
 helo=ivory.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

mfia should return only the iaoq bits without privilege
bits.

Fixes: 98a9cb792c8 ("target-hppa: Implement system and memory-management insns")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 46da546eb9..51bf1b06c9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1961,7 +1961,7 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
 {
     unsigned rt = a->t;
     TCGv_i64 tmp = dest_gpr(ctx, rt);
-    tcg_gen_movi_i64(tmp, ctx->iaoq_f);
+    tcg_gen_movi_i64(tmp, ctx->iaoq_f & ~3ULL);
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
-- 
2.43.2


