Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04C0C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 21:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfRDl-0002lu-U4; Wed, 28 Feb 2024 16:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfRDj-0002lO-Ja
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 16:12:07 -0500
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfRDh-0007CT-By
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 16:12:07 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 5469E81DD7
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:12:03 +0000 (UTC)
Received: from outbound5c.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 5E10481F74
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:12:02 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709154722; a=rsa-sha256;
 cv=pass;
 b=5ktkBITgyzobefFYo2+ACH9FQkcHeQDW1mM7zPYcQIa4RAi/Limak4JG97ZBX+eXXoqP2J
 aiizqqDVev2O32XT8eXkBglQP2vTvu+yIo8DLjS9hAP7S+VkrS+m4Gaqj5jC4slUvkyw45
 qj1GEiyW3WGQFqnGmw3smEMm0MVGSod8rceKlRM5k3kr+YeUSu42GyAGo6lEOZkZ6BPW0M
 MO0azny9uRyFBZGXVwEiSi2V8fdLPSyJVjVNJUAgQAPOS7C6UOqZGtzqzQKZP5zUuPUYyV
 YUU2FFZQTvJDmf0bKqMxfdrn7q2/6alGcwkMd4dBc4YCzTOb43F2U4wbsskXgg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709154722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=gTzT/twa5H3YQV2QlnLJvOosc2pvMMPAeQaUSq60Ihc=;
 b=Ftk3hjRt/Q90vRM6z8gCq/aOtwvTUmQ7/rEvvqBIwwtQfXeLadtilf2roxKQ19nCXLUWRd
 53BbW/S3zRVi926e6bpj3zxZFdkJSzWF+v5ZOZcsfs0tar/qsxPa7rtFLd71Iip1tn0umm
 o+M7Ntk4wnuEuui+y+Vm2lSBpP35pruply3iTy/iPiBl3Z1C6LTs0I2+y5Qu+ukmYZLOCS
 A4wMuupG0e4ojQFGKItesUFjprVifjBMX+EiKiZ0LueEmF7u6XwrkpQ39zrj6omytt/6Fg
 WW/Ga6uVU6lHwWChqbyBQ00LP6Ht/nRRf+rU2Z1G5bJ18qu1DgOPs+/bE8thOg==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-vb5pv;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Versed-Eight: 3b3beb6e5eb0dba3_1709154722882_2672629435
X-MC-Loop-Signature: 1709154722882:549450154
X-MC-Ingress-Time: 1709154722882
Received: from outbound5c.eu.mailhop.org (outbound5c.eu.mailhop.org
 [3.125.148.246]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.58.46 (trex/6.9.2); Wed, 28 Feb 2024 21:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709154696; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=PX4oBjRJgBaySeI6aPuhHajKrNnKZSLw56CaPgvS0SUquxEodI/qq34iO2s+gUZGtc77u/ZVT2jmT
 eodyQ6BYTSzQuiLj8UEKheWjanWBiUBEmxvtPUueJ6/AOcBp/gDpOivrSviF9PBdv7/ffBpUpvM+iG
 6QmdLWvAs1edPf1aXWqvBclNJjqabp+fsNCUWdo001YorFiSYMOiJ3JCg6cEFSAwkrgznFzKsinkqN
 acBj9UkRnmEoQE/eWRQfmD4xJHegD/yCiZEcnJSiW/u8GK90yhiZ+s+ySUqg3qNBOS7J84aHlJK1qG
 hFy4R489Yh4rkfr3zNFV3ZUv4eXzzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=gTzT/twa5H3YQV2QlnLJvOosc2pvMMPAeQaUSq60Ihc=;
 b=GusIiTnll8cbifKnGdh8SKWW41/IaDshZY5QbEIjt6u4m46GKt+LXYfXXrVEUQA0++NdhjSGBsJTe
 5HlYIjkhh+QjjpcN0pz+wUVzuDqSMlIGSwsPWVRqDV/UmktsWST2V5FneIzfesjgquDFVKCVeHccUB
 KacBJptHyUF9iEhJW8Q7ibQbCjcgZHmuvZfVTUE9Fm7ANsbrxeiVFzh4HrX09sROX4U0MIrMF3101e
 GGevbynDEIK7cPCNinL4SARZHyX/r+60rYyPNYpjw+DoPWPfA9ohmwJfbcLrC1m2ZdQMR9jfB3rdym
 e3kjvILbGGlsiPMI/7xCf86JgGwaL+Q==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=llocov76; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=gTzT/twa5H3YQV2QlnLJvOosc2pvMMPAeQaUSq60Ihc=;
 b=bsPt3n986f55ZyXxwYwkT4UeieL7QH9zcq8zo148f/Z0uWKrqzBK9G3Fc8jq5pwL1bak+FrSTGrTK
 Ed1rOiezX874efh2E3keHhGSXlfS4L6TlaPZfIyTiqBH3xJ2zXBZ8A1Xn1d/Vy6N220T4Fdd25zrPK
 Gb2VfX+e0CMl4VqI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=gTzT/twa5H3YQV2QlnLJvOosc2pvMMPAeQaUSq60Ihc=;
 b=iRqrnRAjCTP68d6rkRjJGok0L5pAmHvXxIAQVimb4yN1KkVBtWT+IWxc0o428WJzTAxia+WvHdZsp
 QOpuV6yb/rKFvXpvQDLYPfrk4l8zcBFxpQs5Z0IU7sI6XdidT6CKoWy7PCGAMsM+xCrykvZVPuTtwp
 +wXo9uJj5o4NL9/OtbO7pzHLU9NpQChKy5p+o/cQ9yjx4rKmh7mlrzJnYwBWCO4ebnfjxXBSgi3V3U
 atdtwPNh27KdVvoMKR73txPmZx7MxWnHmU8RY1+lJu5TPpahnWTIoqzSEIcXSfjMKacpgetyy4UmGY
 hMULsxxppjZ0DcX9fYOMXQUdsRGQzaA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f2c58600-d67d-11ee-af95-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id f2c58600-d67d-11ee-af95-eda7e384987e;
 Wed, 28 Feb 2024 21:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gTzT/twa5H3YQV2QlnLJvOosc2pvMMPAeQaUSq60Ihc=; b=llocov76Tk0mNAwVIIWSSqXHG1
 edqFiSTQOov783ZLR7PzNIZMSeb+EXAaJNhorsUe1Y2tYtYlIa40KW2+vpvP7+DgsWAn0iOkWLfz+
 WOuy0bo6t3Z/A/HBtDKmA9UI2t1i4IIUW7jYZ0QibgdtkS7NfKWJwBPCuCLGHyxF4iozAwj5o7Tkl
 EgB75bOApXM8huqDdXz6zSQLwjyR1Cbk/oXr36aqppNS8PlwRoT3vdHJ0MwLbiU4dbC70OCvj8GWH
 ue6ZFHpgEXD3jll8dQKwyLTG63YF/OFlU68TkzOYEBC8ENkWUHvgX+AFfmoDkk1p1GpryjhYpaTEc
 HB2/dEHg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfRDY-000EKk-0T;
 Wed, 28 Feb 2024 22:11:56 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Fam Zheng <fam@euphon.net>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH] hw/scsi/lsi53c895a: add hack to prevent scsi timeouts in
 HP-UX 10.20
Date: Wed, 28 Feb 2024 22:11:49 +0100
Message-ID: <20240228211149.1533426-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.32; envelope-from=svens@stackframe.org;
 helo=catfish.pear.relay.mailchannels.net
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

HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
under certain circumstances. As the SCSI controller and CPU are not
running at the same time this loop will never finish. After some
time, the check loop interrupts with a unexpected device disconnect.
This works, but is slow because the kernel resets the scsi controller.
Instead of signaling UDC, add an option 'hpux-spin-workaround' which
emulates a INTERRUPT 2 script instruction. This instruction tells the
kernel that the request was fulfilled. With this change, SCSI speeds
improves significantly.

The option can be enabled by adding

-global lsi53c895a.hpux-spin-workaround=on

to the qemu commandline.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d607a5f9fb..20c353f594 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -304,6 +304,7 @@ struct LSIState {
     uint32_t adder;
 
     uint8_t script_ram[2048 * sizeof(uint32_t)];
+    bool hpux_spin_workaround;
 };
 
 #define TYPE_LSI53C810  "lsi53c810"
@@ -1156,8 +1157,17 @@ again:
             qemu_log_mask(LOG_GUEST_ERROR,
                           "lsi_scsi: inf. loop with UDC masked");
         }
-        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
-        lsi_disconnect(s);
+        if (s->hpux_spin_workaround) {
+            /*
+             * Workaround for HP-UX 10.20: Instead of disconnecting, which
+             * causes a long delay, emulate a INTERRUPT 2 instruction.
+             */
+            s->dsps = 2;
+            lsi_script_dma_interrupt(s, LSI_DSTAT_SIR);
+        } else {
+            lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
+            lsi_disconnect(s);
+        }
         trace_lsi_execute_script_stop();
         reentrancy_level--;
         return;
@@ -2339,6 +2349,11 @@ static void lsi_scsi_exit(PCIDevice *dev)
     address_space_destroy(&s->pci_io_as);
 }
 
+static Property lsi_props[] = {
+    DEFINE_PROP_BOOL("hpux-spin-workaround", LSIState, hpux_spin_workaround,
+                     false),
+};
+
 static void lsi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2353,6 +2368,7 @@ static void lsi_class_init(ObjectClass *klass, void *data)
     dc->reset = lsi_scsi_reset;
     dc->vmsd = &vmstate_lsi_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    device_class_set_props(dc, lsi_props);
 }
 
 static const TypeInfo lsi_info = {
-- 
2.43.2


