Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCF7D41171
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLbf-0002Jn-7v; Thu, 15 Jan 2026 06:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbI-0001e6-Ba
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgLbG-0003w7-Tt
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768476792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DgQjpSyufcv7gMjkG7cl+yfZfnVo+cPP4RR3lBlMzc4=;
 b=Drtnc/grObYYKeLHRq4JtiTSCVn4hyKZKDW4TMX5jRf0SKYnsAq6jQ5U2kstu41PcOTeCz
 +lqvNBJ1VZLwvsFtic0mtHASUe9q8ZsM3XubB5coWcYfn3RBBOKy2TZ0iVLV7E196G9DZB
 NLyI8ByhgOAs9Be1z/ILnrIZmPdAiBY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-SkSpLLuHMDyc_IS-RJ_zDw-1; Thu, 15 Jan 2026 06:33:11 -0500
X-MC-Unique: SkSpLLuHMDyc_IS-RJ_zDw-1
X-Mimecast-MFC-AGG-ID: SkSpLLuHMDyc_IS-RJ_zDw_1768476789
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso7134865e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768476788; x=1769081588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DgQjpSyufcv7gMjkG7cl+yfZfnVo+cPP4RR3lBlMzc4=;
 b=Z92mNe16mUT914rNdL2DgLNlMgTrnEiSmyogAlnzbNnACs/CQDM5JXBNVhGmZCuskK
 49iYb9E3wJH5yLoABp4FDmE30LWfloADxT4tW8a9mVe65IVPmEOcM3/kDFIAGjuapVSl
 mFYkaizG2R9mVnh7e/AtGYXkTFAOSt0zBGD8DEOBkfHcUa/KizuyK139k91/gUzYaVrP
 Xic6bhrx+kGLA18pJZyupb3H3ZRm2LHdutQLb7xpnD1n1H5lAzipxGSjUlPdmkbnhHHu
 YhDnZJtyacE4UYjXAIn+hSpzljMP/xwx7bx95D0HjdairnTq6UdPpLD+PbUUI8s4GMyM
 bRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768476788; x=1769081588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgQjpSyufcv7gMjkG7cl+yfZfnVo+cPP4RR3lBlMzc4=;
 b=LVa+1x7KCvrf48zxWa6yjNOVQ6eXIxiemPM0Cz5M+QO69hdrzvU3+b/QZdyrUZ2lU8
 Xj1adhn0uDxj7kHku38edLUmS7GTvrpAE1ksI4Wfignu3r4eXyt1gEX+goiiDSPou/10
 kmNP5Af36prYd8vV2CisUaJ6AskgHF2/aeDNb4iwAJmFj2/iGBpN0i19EQOefulmLj4r
 V4+gn+L7zUflkx7AJXrwZ26+svxu2gkluZTsCQYPv8ZA64KCm8Za68sWi2fgw21DDlpm
 S/pwjCR9hKDjvYAzEthFhw+s6VNJfUlAe8SbgZI0SaC1xvHmK+E5rBPYfBMgO8EG1nkf
 yKeA==
X-Gm-Message-State: AOJu0YwsOJrHHTH/QazMiW4fB8jWlOcuD0mipoopcLJsDCoJ7zEi/w+P
 YnBib/Imn7kqF/7E9yviHb+UJFAETcDDP0pQbifzwWkdOlF2d2p0ri9+gwzzIcWf0p1k+XoV+f9
 /A4Nvf6sfpgiT5l5nGMOQHBkUhfy4ZzEtr8tEoEGURF+FIIb9523vcWkT/7l7md/KVhxRelZ6Uf
 Tr2Ss+lUuH/4RaNqza6e2CQCYL2Xf5JcKMVNMI6q8Q
X-Gm-Gg: AY/fxX5vjF2tYub5NgS/HSEWbsgJUZ3xkQ6RwkPveh8kmm0gOJYd1AkjOgdtmRivTWs
 si0AM2g4429VHRpj+xkM0aHykqRqrEGELWmTVtQgmGvQPpErltTuULFOx1hp+CyK0IeUUR0DcXD
 pClOSh1f51AXG9J5fJ4RyjhkolFxIOOIXbO38ovjrfHT1d6cLWO+Yh5WebuMBSjo7n/BXyWOGlj
 f7ZzkSSTPDvVgdPYq86d0gfoa0zp3somKS+R5WSOSZzepz0ch/k1BzrhUzjsaLrTmsUuupH9ocO
 nKgyjB3rjwBWXqxcyLzV/a75tIhEfxnmlQdRVzzlLprVFxG5lgRyh4yP8HBD9d929+5FkQgXE2s
 ZsHSKsfa8l/e3PDtTs8+ept+VHuSF26r7y8BAD1xnMVpgbR0TF7o5dEvhMas7CxVMNff7MuZWiz
 JhxSaPqz33K64VpQ==
X-Received: by 2002:a05:600c:5287:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-47ee32e07c3mr76394115e9.6.1768476788539; 
 Thu, 15 Jan 2026 03:33:08 -0800 (PST)
X-Received: by 2002:a05:600c:5287:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-47ee32e07c3mr76393795e9.6.1768476788057; 
 Thu, 15 Jan 2026 03:33:08 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428e4b38sm43122925e9.13.2026.01.15.03.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 03:33:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 0/6] Next round of target/i386/tcg fixes and cleanups
Date: Thu, 15 Jan 2026 12:33:00 +0100
Message-ID: <20260115113306.126905-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some fixes for AVX (accepting instructions that don't exist), and 
more code cleanups for both historic and new code in the x86 TCG
frontend.

Paolo Bonzini (6):
  target/i386/tcg: fix a few instructions that do not support VEX.L=1
  target/i386/tcg: fix typo in dpps/dppd instructions
  target/i386/tcg: remove dead constants
  target/i386/tcg: merge decode_modrm and decode_modrm_address split
  target/i386/tcg: replace havesib variable with the SIB byte itself
  target/i386/tcg: cleanup #ifdef TARGET_X86_64

 target/i386/tcg/translate.c      | 35 +++----------
 target/i386/tcg/decode-new.c.inc | 85 +++++++++++++-------------------
 target/i386/tcg/emit.c.inc       | 22 ++++++---
 3 files changed, 54 insertions(+), 88 deletions(-)

-- 
2.52.0


