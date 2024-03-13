Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D54C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 13:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkOdq-0005Ax-DA; Wed, 13 Mar 2024 09:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkOdk-00057s-R4
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rkOdi-0003v4-WB
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710336445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i2FoqMaQzo/GdLSMIY49hQw5PLAPkceJeTzjFWHlnQE=;
 b=Y9bkdit/OnQ//KLh6rF99b/UEx8I46l5/yJ/aaAsGT+SjuG7y8XS87OlVaXqOz8Al18e4A
 JdTn+OogdvypvENp4KwUyeXvz6ndCQZ/WFz6PcDBu8AAFnQmLDi3IJp0lHdq/84HzlBTJ9
 i9YUNpJcWPTiIJIEtI47VjsXLDIIeZQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-LKxLcRygOjS1Ym_E__tHBw-1; Wed,
 13 Mar 2024 09:27:22 -0400
X-MC-Unique: LKxLcRygOjS1Ym_E__tHBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21388285F99E;
 Wed, 13 Mar 2024 13:27:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E77716A9C;
 Wed, 13 Mar 2024 13:27:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6F06018009A3; Wed, 13 Mar 2024 14:27:19 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 0/3] kvm: add support for guest physical bits
Date: Wed, 13 Mar 2024 14:27:16 +0100
Message-ID: <20240313132719.939417-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The matching kernel bits are here:
https://lore.kernel.org/kvm/20240313125844.912415-1-kraxel@redhat.com/T/

ovmf test patches are here:
https://github.com/kraxel/edk2/commits/devel/guest-phys-bits/

Gerd Hoffmann (3):
  [debug] log kvm supported cpuid
  kvm: add support for guest physical bits
  target/i386: add guest-phys-bits cpu property

 target/i386/cpu.h         |  1 +
 target/i386/cpu.c         | 14 ++++++++++++++
 target/i386/kvm/kvm-cpu.c | 32 +++++++++++++++++++++++++++++++-
 target/i386/kvm/kvm.c     | 14 ++++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)

-- 
2.44.0


