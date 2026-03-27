Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931C510F2874
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Egr-0002lM-Ga; Fri, 27 Mar 2026 17:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Egq-0002l4-KW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w6Egp-0003Xi-4T
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774646758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/dXV9HGYi8lAaHLXfSAz3pkMnhFub8rBVpQuiBSK+ys=;
 b=dbfLWFB2BVZoWWpKelgmYNl32sO7yU/vhiBGD461Wg1jTKfSFKJWVMqbQUl5UzfvPSvV4l
 /cwZXD2OShYctHjdMAeonGHq+D3LHV8QiWFvmsqqr3QRJjcCf9z1jlD8djmSYD/O4iI7Rp
 BvkzFFUvDo2GIDeduAhwmQ4TPAyL4HM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-Z6nqWl6UOKmUkIwsYhw9rQ-1; Fri, 27 Mar 2026 17:25:56 -0400
X-MC-Unique: Z6nqWl6UOKmUkIwsYhw9rQ-1
X-Mimecast-MFC-AGG-ID: Z6nqWl6UOKmUkIwsYhw9rQ_1774646755
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-487228341a8so14976785e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774646752; x=1775251552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/dXV9HGYi8lAaHLXfSAz3pkMnhFub8rBVpQuiBSK+ys=;
 b=P/JrZubv8UDjxQvf04EIDhyoUY4AkT7jAcpKktGaiUUo9AH4dMYUeX2IFf0cIhVxr1
 5eHu7RQhUJ+Funhcyy91w9rG74B61dJzNfwNucOwsMJm7uSjXVexUAdNHZOnQXs7jWN2
 qKhUag0f08oYSkVZj8CsWaDe22rbQTwkKTTe2cbxWzEe/9ZhXtnIp+J/R8Ra+5oltiVE
 n8XWX8fCoF3aeMn5LRpm+z76hc2/ArqspjxNLk1V7at3/A9hOTy2KihUeHIs71bfzo4j
 y4U4zDlBUkQBrVSZFoctRW/d363/H29UJR3hG3ZIiJ3OQEd6oKckp83KA+kaTf8qFHOM
 l4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774646752; x=1775251552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dXV9HGYi8lAaHLXfSAz3pkMnhFub8rBVpQuiBSK+ys=;
 b=pgrGXt+hg0q19+kahK2nVpW0VDpmG9SyHAidu8UIgWrfdhXsXUyTBL/HKve01WPGWj
 HFmNJO5fQpkUcxTbFV4m0GxLdHXuIMYGrDqnlEVlKRJ04Fy2V/YQuF9EC9qs4dQd/3WV
 Fp05exZWxC8tDvgH3RTyYrC8gp8Yi7CwZU86j+ErNbtspK80i1J6taYk3vr/oNkF4f8+
 3BPGhD64Hupb8VbE1ayQrUouqEwBXshQSv/lzxHX+5lMaNtEK2iQURpaqZmaK5gdbOQa
 ANApXVJMmewgCPqdNrhPqME/xDaejTrwjAtd087LN1sVF7eCbN4IUFrHXIUToHywQUwI
 ro6g==
X-Gm-Message-State: AOJu0Ywvjwd3KkH8f2X+KDKBCR467rfQ0xvkRFDHY70yfNEDancDr1SM
 fr0qT/YiAYiSnmmqI3W4B+JAW7dVYpC6EuCE89o72Hm2vKiCTx+MubmIXyvJAlsbqaRYK/J4qsF
 kcg+o3hIGk0EIrBfu1zTeTCNI7X3srvQinSC1Os4rj/hE1RD1B2tkdkp+xoYkn8gVb5DqFXZEQU
 JKbzObTBOIDO2lh+7aKTRXPlti6rfHaZ6jXbddzBpq
X-Gm-Gg: ATEYQzyqZiLKW/WRJsxqxjtYMaLW1Vv6o/dlZ4T3feRuvjAc2eJQpuiGa88VuPZlGGk
 8BhS3PkmPp51mykJAE3yyKDPbUVdoGBLVZ95vvOaOpf4EuOP1chmoljwUSoqZ9oG5uegusStoWX
 9DBLPFg8lU53Vt6uqysxEdXSfYODS+DCMWdAMUfS7pUKlBjkrhLIiU1oOUzJBt9gUNkNut7lfdJ
 9H79RVACN/s5XnZ3+DXTtB/K8y+lu3RrPIId+eMZUGXS2EdtA7rCTQt1o6LXLE2lfd48BZ8w4kI
 l4UG+tMhOAgKaI9kq61gidUO2auWy3/dAQn/t6iFvjEsJYXfdJ/b2Jm/cbOr3dwn/xEafPY5epC
 lzIuN7qoIZLbeTVkt6bX/70RlRlX5rfRx37uGCtm861gxgHVLm4FReOTHFxrlBeWZm4ql6Zlx/x
 g6L1v6ZxvHXwh6WSqAMWXFnJZp
X-Received: by 2002:a05:600c:810a:b0:487:2e8:69c5 with SMTP id
 5b1f17b1804b1-48727e909b0mr61408675e9.15.1774646751773; 
 Fri, 27 Mar 2026 14:25:51 -0700 (PDT)
X-Received: by 2002:a05:600c:810a:b0:487:2e8:69c5 with SMTP id
 5b1f17b1804b1-48727e909b0mr61408395e9.15.1774646751124; 
 Fri, 27 Mar 2026 14:25:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c95041sm108301875e9.6.2026.03.27.14.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:25:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 00/16] Reentrancy fixes for lsi53c895a, and cleanups to ncr710
Date: Fri, 27 Mar 2026 22:25:31 +0100
Message-ID: <20260327212547.460420-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

lsi53c895a is one of the few devices that explicitly disable the reentrancy
guard, and the result is a lot more opportunities for things to go wrong.
DMA writes to itself or to the PCI bridge can cause resets or device
unplugs.

This series fixes two such issues.  Patch 2 is just a cleanup in the same
area.

ncr710 has similar issues, even though they are not fatal thanks to the
reentrancy guard. The second half of the series cleans up the two devices
to have even more similar code than they already have, so that the same
reference counting fix can be applied.

Note that I have only tested the lsi part of the series.

Paolo

Paolo Bonzini (16):
  lsi53c895a: keep a reference to the device while SCRIPTS execute
  lsi53c895a: do not do anything else is a reset is requested by writing
    ISTAT0
  lsi53c895a: keep lsi_request and SCSIRequest in local variables
  lsi53c895a: keep lsi_request alive as long as the SCSIRequest
  lsi53c895a: keep SCSIRequest alive during DMA
  ncr710, lsi: use same enums for command_complete
  lsi53c895a: always use enum constants for s->waiting
  ncr710: simplify ncr710_clear_pending_irq
  ncr710: reuse ncr710_clear_pending_irq in ncr10_do_command
  ncr710: remove weird p->req == NULL case
  ncr710: remove redundant req->hba_private assignment
  ncr710: clean up ncr710_transfer_data
  ncr710: do not load s->current in advance
  ncr710: remove dead message in actions
  ncr710: copy reference counting fixes over from lsi53c895a
  ncr710: unify two conditionals

 hw/scsi/ncr53c710.h  |   7 +-
 hw/scsi/lsi53c895a.c | 101 ++++++++++++++----------
 hw/scsi/ncr53c710.c  | 177 +++++++++++++++++++------------------------
 3 files changed, 146 insertions(+), 139 deletions(-)

-- 
2.53.0


