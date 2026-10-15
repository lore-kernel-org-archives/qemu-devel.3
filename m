Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848EACC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHEh-0007L7-Al; Thu, 15 Oct 2026 04:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHHEd-0007GB-5l
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHHEb-0001ec-Nu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792054483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rEfyXHrvdkMi9wkRqvydEYxStp6/kAykWvrSNH57z3Q=;
 b=dS3KAOakWG4nXpag3qBTGHBh9ES7CK0Dtg46/kX1LyB8Nrh5k2+lvJVdee7tWTg3cMQXgq
 w8qJq/2U60420fK1dOmU3IL3SsLaEhxiXxQPA6g3u6ybmkPP6I+QfX1HpBHtiYpmBs/iDY
 nJNpmpafhKysChlW6Xym7o2RKe1+Pbw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-UjbQn0vTOjy106NkZv8Q8g-1; Thu, 15 Oct 2026 08:54:35 +0000
X-MC-Unique: UjbQn0vTOjy106NkZv8Q8g-1
X-Mimecast-MFC-AGG-ID: UjbQn0vTOjy106NkZv8Q8g_1792054475
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a16fefb7acso39475355e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792054475; x=1792659275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rEfyXHrvdkMi9wkRqvydEYxStp6/kAykWvrSNH57z3Q=;
 b=ibnwxq654HFla06c+YaYYOGBSj0IWV1StvbE2IzQ5SScFiQg+04LzUbqvqROxGFYie
 FknGX8Ez/ZyXD7Me+oJZjjJxA29E/fJ6bobuJUabWy0FhOkYyqgWg5gSO6vw/TEXALt5
 Tn0o78/xc69LyG2c45ybGRtFMVsqhcVFI/Ij03XE0vWGdgcP49aznD9K5fdiAXR/lgPE
 NsqJtmJybzcanNq4Tb0RNhYqlfUWrVR5rDtkMyBUVz290KO42FqxjlszsgV5a6tVH9Qy
 jqg71iLowpy6Lfm0HQ1CqQEcaTxN76gFuzfh9L/iAIKV1PDObzDs5Y+TkZhkRVVTeAQX
 P6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054475; x=1792659275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rEfyXHrvdkMi9wkRqvydEYxStp6/kAykWvrSNH57z3Q=;
 b=PhspUdW2ryiULpFE+gh8D7YwCeimxe9IURHw3BIom5UD/SJehwkCQJh3DM2YSkWNx7
 SReFkT2Bi9/V3p44nJlIALVXiWXQMiKlJHHjytwhCxSUfoK7QNV2eFBp9v9CCkYArJpl
 uBynRCRZUqo+u+BK0kIZI+w8WeMG2H1at9+k6IopzX2SD1zf9aSUfbZ4a6qENWZmjx2J
 uNPryQQL+XqSSz/nKb9OYye3+bP5hyuzdbMiXVtAHgxQqB7JDsBFh3YeMZls8irqFWaZ
 kZ62X+FvjyhEWZlpDs5x8UpJcuqoL/r26pfMeNvrzD05IKjmVhC0a28as4+3XWjdwcTh
 U34A==
X-Gm-Message-State: AFq9FYK4/NwbR1Ttw+yxkZubrU27FChxg+cJe3Z74GBEwkfxmRrsPs+X
 Fjt0LrS7Mp88n992+WvCMc//LOvcCwmoKtno8LIn2pH9tDcC0LwNEc9uIiyXcesGaRKvLvJcYsH
 f51JgLIItIHiyFUWlqJAm9Ieuo/aBFs4zqbhFYaaaElvak+eTEIt4b/ycCMYcdSJ+At0q6eD0SH
 xLHHRk2DYaUWLscvjp77U2S7wTbF5/NECTZqb6cev3
X-Gm-Gg: AYBFou1H5jCWG24uiBhFTyEska1a0EjyDMm1hLQ2V98b7tpu/emCaWBVhKIEEjcO3II
 iRhVf7JyiUlzpBinrXpsSt7w6Kd1t1rJc0By8VrO3OZGIzwKH6RYiDac9qJQ9tuO7JbcXOuAB9D
 tkpMD3GaLEGzBGXW58dnmpRZXDC3fyWwgF9Q86RcsIxF8dBesTHyK+Qjl4zaXzD/gvRg2OHyiVz
 kIRGs7x4NWWgibejl0lWALjkldU6y8Gh07cN3XKQJv/PHrdLrvxLYOHfUaJYpcLEfFoiupD9RVM
 /hsabmZbwDo7HijdrDBVq7RNX3kPZmNIsmh4Ct7eWLemQOzNXhgv1QukSBwOTWB6L0gnkNpT0xe
 MGcVK3k4JIoO3WnhxH3X+AUn6nIMLwefJONLrlWX4usapOdyp2YzIfGUpCSO+dfC/5TNbRY32R9
 XNbYhf
X-Received: by 2002:a05:600c:3b87:b0:4a0:1b15:8852 with SMTP id
 5b1f17b1804b1-4a18e4a977fmr462125045e9.16.1792054474686; 
 Thu, 15 Oct 2026 01:54:34 -0700 (PDT)
X-Received: by 2002:a05:600c:3b87:b0:4a0:1b15:8852 with SMTP id
 5b1f17b1804b1-4a18e4a977fmr462122975e9.16.1792054472898; 
 Thu, 15 Oct 2026 01:54:32 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c10fe9d3sm34685355e9.13.2026.10.15.01.54.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:54:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/i386/tcg: remove unused operand types
Date: Thu, 15 Oct 2026 10:54:29 +0200
Message-ID: <20261015085431.803961-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Two trivial patches, sending them directly in the next PR.

Paolo Bonzini (2):
  target/i386/tcg: remove unused X86_TYPE_L
  target/i386/tcg: drop X86_TYPE_A

 target/i386/tcg/decode-new.h     | 2 --
 target/i386/tcg/decode-new.c.inc | 7 +------
 2 files changed, 1 insertion(+), 8 deletions(-)

-- 
2.56.0


