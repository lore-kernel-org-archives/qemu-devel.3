Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A72C54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHhv-0006SJ-3Z; Wed, 28 Aug 2024 08:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhk-0006O3-EV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhi-00019u-Iw
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=scdlFnlSJAfzvpfuQmB5Otttz82VAGFP5HtdcXoVRgU=; b=Jr9J9rhiU5iuWPQ24a0cRxY+/3
 Q1Kl8A7EFOll6QrF1aLg2EbG4vCr8tJ8ir35cp1rvRKQV97e+HwuFNCWSDrmTN7BFutL6NQYo7MKq
 WCeLIGihmWL6ZmdEwW+H9Ld3YC9Id3bJ3K5WcbpC4vHXa+7CNbM12nn8uz0ufYyNfq45TCbibNf+g
 svZXRtycw1i+soK0Z9FjXNkBP8goyxx7VDUYcNVbKJHAui7U1gphKEV11l89FXUVuVsIMfmXRqMpn
 AKWLYlqEHBfz/4nzYgG42kvTd7rSOaNL1+vUXBT5aszs4Vxmou0KqdmC4pTrbMaKDgRHjIlyzMHJ6
 SyOFOGgwlav941RdX1ndS54iZ70pJ20RRdUMyw/4+n0sUO1JBnnf6IFPqHxG6SoGpEEDMKA9uJQsS
 QY/3ZtyA9IkGcBcPRmI8V4FJnCFJmdGnh/HIYjTV2jlcoGX7Qnh/eZtaAcr+pOdy3bgo29pVpbWEc
 wcGRU+JIQn9lVGaM8GjMNgpcen4Lsu8yyYvWzNs+16JexJ603mcFOIgmVUFOzlQSN2lAukJf97XNH
 /P41hwJpeLPmGeg2eSvNTt/L2LPQAChUw3jujLL8GZs3eqeTtb6ae7onhgmlKZFkBF7o7aorewxzA
 Bco/023n4SZsbreqZIQdtsFRXJVw5hkzdG8glWR7E=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhN-000B8d-8j; Wed, 28 Aug 2024 13:22:57 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:49 +0100
Message-Id: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/9] fifo8: add fifo8_peek(), fifo8_peek_buf() and tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is something I've had lying around for a little while as a follow on from
Phil's recent work on Fifo8 with a few updates, but also adding the missing
fifo8_peek() and fifo8_peek_buf() functions along with some relevant tests.

The reason for sending this now is that there are couple of recent series
(https://patchew.org/QEMU/20240819113148.3007047-1-alistair.francis@wdc.com/ and
https://patchew.org/QEMU/20240817102606.3996242-1-tavip@google.com/) which can
benefit from these changes: in particular the fifo8_peek_buf() function, unlike the
existing fifo8_peek_bufptr() function, will correctly handle FIFO wraparound. This
occurs when the FIFO head drifts due to not popping the entire FIFO content in one
go, which often happens when trying to send FIFO data to a chardev.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (9):
  fifo8: rename fifo8_peekpop_buf() to fifo8_peekpop_bufptr()
  fifo8: introduce head variable for fifo8_peekpop_bufptr()
  fifo8: add skip parameter to fifo8_peekpop_bufptr()
  fifo8: replace fifo8_pop_bufptr() with fifo8_peekpop_bufptr() in
    fifo8_pop_buf()
  fifo8: rename fifo8_pop_buf() to fifo8_peekpop_buf()
  fifo8: honour do_pop argument in fifo8_peekpop_buf()
  fifo8: add fifo8_peek_buf() function
  fifo8: introduce fifo8_peek() function
  tests/unit: add test-fifo unit test

 include/qemu/fifo8.h   |  25 ++++
 tests/unit/meson.build |   1 +
 tests/unit/test-fifo.c | 256 +++++++++++++++++++++++++++++++++++++++++
 util/fifo8.c           |  42 +++++--
 4 files changed, 313 insertions(+), 11 deletions(-)
 create mode 100644 tests/unit/test-fifo.c

-- 
2.39.2


