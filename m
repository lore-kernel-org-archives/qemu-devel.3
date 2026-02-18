Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E466E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshgc-0005E4-AG; Wed, 18 Feb 2026 08:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshft-0004U7-ND
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfq-0006H5-QB
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nvY+FQXOEd7mADtviTKG5X4XDtAjCV+MockVMSjqaI=;
 b=Kl8V4gA4OjTWa6G4kTPK+SqYhkRyTouhOwW6L30X17eOaVKxYtcmLMQBq66fwyWIQ8nWtd
 t9HYGcEFQlEnWBwPwCBnDlUfvojCBAOAX5zFOswvHIKnw2sFD/NRw1ulVhpwfm4cAKtxsD
 Ph2ssED9FiySQo5H6mHUk4SRd4uY7yY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-WXunfzg6M0C4f8zHL_79rg-1; Wed, 18 Feb 2026 08:27:43 -0500
X-MC-Unique: WXunfzg6M0C4f8zHL_79rg-1
X-Mimecast-MFC-AGG-ID: WXunfzg6M0C4f8zHL_79rg_1771421262
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435a11575ecso5278815f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421262; x=1772026062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nvY+FQXOEd7mADtviTKG5X4XDtAjCV+MockVMSjqaI=;
 b=gGiBSUPaOBLnNRkKy3NlbR+893KG9NguU5f5bN5JNdyIfYFbfZno4ZLQB+p0rWOXII
 WHXg1DcRXilDykCDs4uBkLfRPotKR3dnl/0I8XNM/NNl6RMRZrhdeseYhOaHnZ71szd1
 tI9l602TkAinBUCS33fAjUetGcFLubVBFAAltD0xOok74qbv6imckGBHyguaL0ST9xjp
 EA5aaTGLykwsa2IOAA727sRTrRPeXNUQ6bdRym14zu0qojTCU8vrvGK3ffYuso6XFwxd
 6WFUtE30kPdsqyHcXs9DieeYOUZrH6AJy2x5kjhz4P93Cj+Ts86p3wZzEqJ2A3vWqHpU
 ipPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421262; x=1772026062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/nvY+FQXOEd7mADtviTKG5X4XDtAjCV+MockVMSjqaI=;
 b=kh1cG5qONPAvgk7yQu1dAzX62SY75F+EQy8UPwJYLmgZVYKXRMdE+w5LApVY1YQFAf
 MXd26B7hu/DNQkDbOmVPJbrYi3ByrSYzN3Qx0vQnmpgqasQRvCY2xerSrOf6ZB+jDEOd
 C2WgTdMc+Wtu8LdbEcJMFsxXlASrATg8VfAR62RP6DwxfwMtxuUip/KhSSq7SWJUtwDy
 5UBemodAH3VONGfkml6bRsqrBGKa+4xND53EbQJHrr605aUQvRaYE+j6taGbuFiV94j9
 QxB7kyzoVK7npbpPF2YZpXLgoVKZYC+gWjExw0pBYi7sOqkcomkBH7nzRbYMfEcZ2pQS
 9+vg==
X-Gm-Message-State: AOJu0YyjKkIk+pJYYCm6bbRNj83i+zFLoFLCYGYdBpDo9kgRZ/MxSXcs
 78Q3W7Rpr2bRevQtnBauFD5Ny8jc22aABPeF9HdAlsw3tyRYJRSfTBaPNlbkfCOfSD/zNcDK0zT
 DzjYxZT/Y/JOoWivMd3YP64aSGu96vreldzTN998oMF4TQryare/YJ7aI
X-Gm-Gg: AZuq6aLd6GB8O1Ezw1aDeeoAfTeGUU2/3/aZ/KcIiNbxTHO9/MlSgbL5oxoCoJF59h4
 JuRrk9mTbIcg5YC9dsBq7YEHonWGlozCMtlhwquotZmSKTeKwbrJG7Hw43Tvl9EefUKcGtwPOlh
 xKXpY2bZZuSPX1O4gMVEogAxBYB3yA6yBoBEqk4NxtiPtfhgqZMU84jTQmedgVsEZn5dh5qEx+k
 8HawRaY5BvdLPGKnSwKgmGgAtKHgdEA99ngsFFHvC0h95qm2KLGexog0kr6o4+/iW3mJwXrvmw+
 C32fxg+s9iLZQpzQBMoa1ielNUaqjUesGzvZNm1Ulv4SdkmK/+SsJpzp1WW/seS+BvC+VPzbUQ0
 ZsTc3PngOirLeiedJNRcwsEnpiIWoKA0m9O+EuSiQU5lU/B0KbmmwWzYl64QJ6CG7e5HQA0c79E
 x9/AsS
X-Received: by 2002:a5d:584d:0:b0:437:8f37:887 with SMTP id
 ffacd0b85a97d-43958e40404mr3159047f8f.36.1771421261774; 
 Wed, 18 Feb 2026 05:27:41 -0800 (PST)
X-Received: by 2002:a5d:584d:0:b0:437:8f37:887 with SMTP id
 ffacd0b85a97d-43958e40404mr3158983f8f.36.1771421261190; 
 Wed, 18 Feb 2026 05:27:41 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836cd7af87sm461122755e9.1.2026.02.18.05.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:40 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 23/24] qapi/block-export: Document FUSE's multi-threading
Date: Wed, 18 Feb 2026 14:26:32 +0100
Message-ID: <20260218132633.29748-24-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Document for users that FUSE's multi-threading implementation
distributes requests in a round-robin manner, regardless of where they
originate from.

As noted by Stefan, this will probably change with a FUSE-over-io_uring
implementation (which is supposed to have CPU affinity), but documenting
that is left for once that is done.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block-export.json | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 160cd2e3ca..dd724acf1c 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -164,6 +164,11 @@
 # Options for exporting a block graph node on some (file) mountpoint
 # as a raw image.
 #
+# Multi-threading note: The FUSE export supports multi-threading.
+# Currently, requests are distributed across these threads in a
+# round-robin fashion, i.e. independently of the CPU core from which a
+# request originates.
+#
 # @mountpoint: Path on which to export the block device via FUSE.
 #     This must point to an existing regular file.
 #
-- 
2.53.0


