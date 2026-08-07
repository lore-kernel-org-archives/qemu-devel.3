Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CE6C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsLlf-0006dL-AX; Fri, 07 Aug 2026 10:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsLlb-0006d6-Mq
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wsLlZ-0006XG-13
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786113702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LDYtlMCTkEhmB/qluQ4FISnw32nxUYus4wFiWpQjitY=;
 b=YNZGVBaJDrxrIWYjZTirMqzdNomX3tm5+aDdnViL7rseWdfVwLmLfWstB/P/jE95SdVDUy
 W4FNoomNIqmBMNK3kNXut6obQYemFjkXR0qDW5uoGRn7inyKAGcWl3+ZexXUBcrJVFkgSb
 QI0mJuYPXZAm3qcFgyCZBMGUQQWGnK0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-O3Kf5HjrMEibogIos0lQEw-1; Fri, 07 Aug 2026 10:41:40 -0400
X-MC-Unique: O3Kf5HjrMEibogIos0lQEw-1
X-Mimecast-MFC-AGG-ID: O3Kf5HjrMEibogIos0lQEw_1786113699
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47fd4ee0ac0so2636356f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786113699; x=1786718499; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LDYtlMCTkEhmB/qluQ4FISnw32nxUYus4wFiWpQjitY=;
 b=eVMcsd7GUuEyn04pDXQ7PscHZkvxAA5C1mtsUNj07sl+w5QBWudQUXCZu+t8YPrSfL
 24a6jXAcnjVXp5BjZtTJ6Rk25PqEShdeaFIsOEmBnmRHO/NU5/gMIKUncraOMLN1yfHe
 BIJA6qFUMWh1qiAIqjoWxtH2SEiZ/tKP9wGM7p2WW0Hn2zZl0N+jMLDy5rejG6weLeiL
 XdFT8AJgKLlwxOSKbO1aBxCZIzbUBYjZGugCcsna2nYUcR6LHFZQ/2J3ECHYtZ2Bktq7
 dbR+M8EucrUiVbNC9NmWnmOVh/44FVjkjC5BgxRJYpW/63LK/7dKekNMPSCJJ3sJzX9Q
 3jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786113699; x=1786718499;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LDYtlMCTkEhmB/qluQ4FISnw32nxUYus4wFiWpQjitY=;
 b=k85C7WSpPQxT0yERNelrS9nAfR29cMcnnXp41TRTAeq9DQQMOasUgkU7Lsd+t/tZyR
 smiR+ydvpIM5Hz0Wo3eKrgImKtUORwI1DgcdDAeZ9H8cxZ4jamep2Rda2GvfMd1wkxly
 mYELLXyAMtEPMxy2dcS5kdcY2krTYIrNcx7mKLtJrcWr3tEkb7xIKpAG94a6cm4KzYSU
 94sZTlIQ9Ch7frNPtjyRoQ41LEiK7LFFdGUob/316UMDL43/CIqXxOX07Jn4dWBCsuiZ
 xEYph17skUoXMHUuzR2RDmZpRCNtXb0A6BF/29ivR9G5mfpP0ECUaTD464jKyrgQQjiJ
 zp3A==
X-Gm-Message-State: AOJu0YyUX2XZ/CaxB1T2gH5KXmSeQJdE/BUSJgodMYEEav9IBCp+db5w
 OzbMk7D6MzZa/+jKlo0vjIj95yopXKoVAXQmFP94aqmafdMvvcn7zDsM3kw/gSTOBrbMgqNJLQi
 ULj89Nm9T7slSViti0rSenyCiTbvmtMcuHCz9Pi9G8VBBIbuZVzeUJ1EymWg6x4AGsjzwvkGgrn
 MU4EO2XmvQ5wPMO1UaObL2lrEBpRoO2fY4Tr21MM3O
X-Gm-Gg: AR+sD12tHE0HtQ9D8vhKWIaLG5JgijAd/ywG9RdsvkJuQUdaHUngJEyYpSKG8+3jxMb
 +HP5pDD+NVahT4151vbaxlowlyt8xp6vVnhyAn6m9kObZhkweVetIKJsbMhCPdrWCrYa800s97g
 /d7CYlDqhUzxTwT4A95/mwAhB+kzOoR1WPmHeb7DjLeD+afnrYXNk+0pKBG7/nVMrW+O/0yZv0x
 V4/JHePbrChJJC+OoUbS0g1ReomDygGPSPx+/uzYOFkRBifEVzaSnGnZF0/vrdurxVOlZVCux/r
 7gE9zVh7tOANQ/xjX/FjLZ+vFznlwDszOWdS/vS0wAU9buc8X6szt/cdaSf8Xc8b9/IutmbnOQ/
 V+sQ9lKngUdZ7wMRRiXm84rFSzspxtVBlfO5f77TSdm5gC9QYXP3CL+gQJtHW/+FnWFVaWjKEOE
 goocE=
X-Received: by 2002:a05:6000:3113:b0:47f:80f0:8d33 with SMTP id
 ffacd0b85a97d-47fec6457camr35001688f8f.30.1786113699486; 
 Fri, 07 Aug 2026 07:41:39 -0700 (PDT)
X-Received: by 2002:a05:6000:3113:b0:47f:80f0:8d33 with SMTP id
 ffacd0b85a97d-47fec6457camr35001618f8f.30.1786113698954; 
 Fri, 07 Aug 2026 07:41:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021fb89bsm6115659f8f.30.2026.08.07.07.41.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:41:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] target/i386 change for QEMU 11.1-rc4
Date: Fri,  7 Aug 2026 16:41:35 +0200
Message-ID: <20260807144136.2637416-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The following changes since commit b428fe036233cbd15d37e3c027ab6ca4d3661a80:

  Merge tag 'pull-target-arm-20260731' of https://gitlab.com/pm215/qemu into staging (2026-07-31 16:19:04 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 01b4e06b5225787139dae760e8b4fe0c39e5c04d:

  target/i386/kvm: Fix CET SSP MSR read feature check (2026-08-07 16:39:22 +0200)

Sorry about the late pull request - I missed this patch from the list,
and it fixes a regression (albeit one that was also in 11.0).

Paolo
----------------------------------------------------------------
* target/i386: fix typo in CET_SHSTK check

----------------------------------------------------------------
Saul Freedman (1):
      target/i386/kvm: Fix CET SSP MSR read feature check

 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-- 
2.55.0


