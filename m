Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68162C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 16:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seH7e-0004eL-Fa; Wed, 14 Aug 2024 12:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1seH7Y-0004d8-RF
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 12:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1seH7W-0002YY-Au
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 12:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723653909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=86kTOEpzq6QVcCJjR3HUt7SFgzK/i3BLkIE6ZWX13Us=;
 b=Gq1kwTeuNuBExonZOfz+Inhh3JR24L44lPsO+D65OS93fxuXeTRvWIQ8EKbSNeyA2CwesO
 AGa1a6CLeR2UBg8ZgIlvYcnl7T3DHy81KDNXmDG7Cdv1jAMjemxoLRcbfuYz2oB3g2KEN6
 ENEm6jTMWg1HLtHXupBpkeGg9jnnWM4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-6o8hrq3mONGHv0z-FlSA0w-1; Wed, 14 Aug 2024 12:44:37 -0400
X-MC-Unique: 6o8hrq3mONGHv0z-FlSA0w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3717cc80ce1so66967f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 09:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723653875; x=1724258675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=86kTOEpzq6QVcCJjR3HUt7SFgzK/i3BLkIE6ZWX13Us=;
 b=NHDPnCfTI2VZGxDwWm9eJVVDrgxtzcOrr9tSwbOOi4HZdJ9ZCjZHvL2lpESxLrkgt5
 vCa0Z3mR4igmQogxW40VxGjkt9d7KtkSTLVBGYXrZ6lvHGozKPiyEo5rjtHez1q/mLa2
 gwbdpnTGB0w451A5QNSVqRyrBimIu0JRYjm+tiERU6rNRbzi1Ec+/UNfHffH2aWpfkXI
 8iiCC1Qt1Vb6dONAW1xAwl82NVUekSlfyjytOjzgnsezaqit71spC/VhpJ5e9C92/csC
 5JAVi0zcGeoG7LCpUyLB/weq7lWLvYfGK0+TLoC9031pe30e9ZTJQyO/A/0KxBzhhBrg
 902Q==
X-Gm-Message-State: AOJu0YwYa5jIB9/+n0XCeVTtLUraYgKaBsE8eeNOySZTilCKPdvWV6vf
 k1UMWFzmcEDc3F5ck6FfdL+oJC3Sw2Td6NmHck6JjdpidM41kXdrMh5PJEGyuSeHJ+XTwG+bw6k
 eRu5Lnxza68sfgJQwUJfABAJtWZdOY5v+76i524nmoOhXvRClk4nAXxCIF+hGAeNCv9G8IQrR6P
 Ck8lW/NvMu81TntMNSDeWOJygtQ8ey72pHL0ZF
X-Received: by 2002:a5d:5603:0:b0:35f:122e:bd8c with SMTP id
 ffacd0b85a97d-371777712c3mr2276613f8f.17.1723653875438; 
 Wed, 14 Aug 2024 09:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/vcBjmffGoDmp1tMUkLNdg+qFHma0Jr9hFTeqyB35jrl4qQcF8MxCHmqCP/vHrL3BXaNlpA==
X-Received: by 2002:a5d:5603:0:b0:35f:122e:bd8c with SMTP id
 ffacd0b85a97d-371777712c3mr2276591f8f.17.1723653874731; 
 Wed, 14 Aug 2024 09:44:34 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c93833asm13370183f8f.41.2024.08.14.09.44.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 09:44:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] target/i386 patch for QEMU 9.1
Date: Wed, 14 Aug 2024 18:44:31 +0200
Message-ID: <20240814164432.271179-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
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

The following changes since commit 3ef11c991e501768f2fa646e8438f075be1cd2f5:

  po: update Italian translation (2024-08-13 19:01:42 +0200)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to a6e65975c3fac1b2f067fef8eeed92584d773f06:

  target/i386: Fix arguments for vmsr_read_thread_stat() (2024-08-14 18:42:19 +0200)

Sorry, this one fell through the cracks.

----------------------------------------------------------------
* fix RAPL computations

----------------------------------------------------------------
Anthony Harivel (1):
      target/i386: Fix arguments for vmsr_read_thread_stat()

 target/i386/kvm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
-- 
2.46.0


