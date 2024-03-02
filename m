Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469C0C5478C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 21:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgXAS-0002iR-IX; Sat, 02 Mar 2024 16:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgXAP-0002gQ-Hx
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 16:45:13 -0500
Received: from bactrian.maple.relay.mailchannels.net ([23.83.214.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgXAN-0002jV-2a
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 16:45:13 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D16A4761EC9
 for <qemu-devel@nongnu.org>; Sat,  2 Mar 2024 21:45:08 +0000 (UTC)
Received: from outbound5h.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 272C476222D
 for <qemu-devel@nongnu.org>; Sat,  2 Mar 2024 21:45:08 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709415908; a=rsa-sha256;
 cv=pass;
 b=5aDig8BKFJX4GD7A2j8o5m/6DJlwwoIiM7DT1tZ0netrvhWDck7XUqyM1GryoieSNSZmQx
 RNu5/Vp89wXKYyqOAeXesxmNcs5Q0jFsi8aDC8irhirM5Cj6ydmYDrXDpOtAhcNEXSXE/z
 ow+rBPF//MW3uSp1c8+HZE2NcmipemRStvxE1PWEkLhWIpDLUmseZYWVXfthgA1kOZra2F
 Rfaf1gdP3QFKmrC+byg8SHwk1HdAp2Zs6uYORVigAc1eY3Gu9mvNeAHJra7Bli6LdslPLi
 kPM9q7V3N76pksZvG6PAqKlsmVwLn/SghETyBw6WPzLdWWjLUZbZ6/j087cM4w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709415908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=hyOHtKgXQOPyTvxNxneMckeebvz1U4ZABSpatlZQ1fE=;
 b=0aTjFPb3UKKQM/XI+kbYR7sOyVQZ5Np+bUKkYUirBHMMos1ZmNkiuuwDqv+eIw4NbAaju7
 mTYEoO1KtnZaQVxNLnUvL0YPmZZ5/c/1hMkuMYnCVOpa/lgKtFuO04DSD96AXIRLNO7y1p
 c3UC5ecJOE02An6Vthow65eWYJdr94TujNVQ6svi5l52nU4/puS6muqhRdpNfDxkaPJYzq
 3eh1SqOvhd3ZTPkfh/CnwxceZjopF31gPJOCJxvb1TUgnYQ14an/+SC+zdUJXi1Of8m6hy
 qy3ptzpcrqmDjy4NpaGPXTXFIes9JPVmcWidIbYsEk4WCX/1Sn6xTgYXhyicmQ==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-2hzk2;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Callous-Chemical: 215e06d9701cec0a_1709415908645_415222409
X-MC-Loop-Signature: 1709415908645:3290029914
X-MC-Ingress-Time: 1709415908644
Received: from outbound5h.eu.mailhop.org (outbound5h.eu.mailhop.org
 [18.156.94.234]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.52.242 (trex/6.9.2); Sat, 02 Mar 2024 21:45:08 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709415815; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=XmJbL7ycM1Ryy0qAHJ/+06MXVXBUJEojANMhHfUPPXhoqySroUkkUHBC6Sxwr4JMjNuSq7yKBzhB5
 laATBV20rHFp5lKDyht67foxY3Nj3dqlLollNCO9zlFkYaOo0viUFGeuiUxuM8H2WyQ1HxqVhXyVDw
 HLvA/kTRUh+nt6aPf9dEvLpgy2KTJDZ5ADqRhaQP0GDwuiZ6w2heKP94J5xw9bU15LRLA0SPezZf4P
 rabosC+TDMHes8nHLlE/8PHHTDQhk8Vs9Y7h5uamXiTfNTlGS6hcidFp5N2kp06mPc8z+o9Pe6MvNp
 G+8831G/BzVpz2Thsj/Iib+RRt6tg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=hyOHtKgXQOPyTvxNxneMckeebvz1U4ZABSpatlZQ1fE=;
 b=NOzrl74Qr/ngHbq7aXIAxm0mdclMY1h9YZg4e2UhAEMHj2AXqmOB6pCtkH1VnUntFIWQQDyVp5ys2
 1VTZeg6vBnbkh2zo8k18lurq7RUcdox4NbTPOdJRdg2BsM9j5y+cgcJJcWMssFU+ZQ0VxOHtIx6Scg
 KeBYP/Sgy+kft/tLdCTahu6YQZaTYZxlt2tMEeJvm1vp7PaU5zpwx1yrvjEvoNlJTKFrwNaLFuNrqO
 evm0zmiZfshT8vFgfcoCVoN4pyTXJ7Z53QlC0y8/wQIeExELSHZrl5f/MbG038msxfQR8U1h7VN+2C
 PnFQDiwNMy8NBC2LJIPzrjkPS0cBj7Q==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=O1Pm/Ahm; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=hyOHtKgXQOPyTvxNxneMckeebvz1U4ZABSpatlZQ1fE=;
 b=XR37sRCjVpYGEwGLCt99dkwjsyqYbrx9xp/8EkKoT4KhbwJW2Eg3tS4F8cpLP2pCaW9uY3vbT1fBC
 +tRt1ruXH4ClP0EakPP+TrNDElcrM0HTRg6Onfz6B7bpJB5sA3hNIVWojA3ew1DLTvJnCBGjXE0992
 X9tFpHvlzt8qCpkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=hyOHtKgXQOPyTvxNxneMckeebvz1U4ZABSpatlZQ1fE=;
 b=W0mRdjzDMM07QxqTxu2xm7Qka0flG94xo0ftwe71sEzvAQiPn/9fqPRi+6M9hszdrlyMiEnIVtNPP
 Nhx+acLlNhnuiAWMlYXq5P/AiOI72KNxAQSXq+x6LCVzs3KF6qRU9k9Gn4B0vzzasAFMFOEAwMH5A2
 4LPu0OdqGjlkDiTbLT57V74ExaBaqLLfvHtZYz1VBUMDddilfmU31rHAU8jYVgegeVKuDbLUkHi4QB
 oglJjPH76tsjVQTCphre1LHdrvi8mzQOW4O13xdEMNLqQhuZUcM2ejKhfSQIFzRYhnVKBM5yJQnGSc
 vq/fj4wLTbQPaETa9Oema8QckTWlm4w==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: e8c86e0a-d8dd-11ee-b685-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id e8c86e0a-d8dd-11ee-b685-9b9d9be6ef2c;
 Sat, 02 Mar 2024 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hyOHtKgXQOPyTvxNxneMckeebvz1U4ZABSpatlZQ1fE=; b=O1Pm/AhmNb+1dO6dz31SDwwbTQ
 LrTlBpLUXO+c3RRga9GJGDVXz3/td9r4ZXtkw5zL23UKYpF/PfrkTpc+ljuRmdZC6Lj+CDwp6DSYM
 IovAbUsE2gQ91l14yLJjW4iADLSVOA/BDzMbdnD1ru4CHhG6sAHgNGi0y7RkaCJfOFrU6EYzY8WNU
 XZZbh9bDvk52NipS4Ku2Yj8L+H2S8CB9xwTSAgC1owTPbc3mU+ZPMrv1J94PGJvMPPMOXKGE5PSab
 F1wKL0UL6DYoDh64unpG6yxpdrDHue/8uKLprma3bwlAyBd7ysIpOLRs5RRPh6IWBHxFhi2vHJkrA
 wxVBnKuQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rgXAC-000pgP-3B;
 Sat, 02 Mar 2024 22:45:01 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH] hw/scsi/lsi53c895a: stop script on phase mismatch
Date: Sat,  2 Mar 2024 22:44:53 +0100
Message-ID: <20240302214453.2071388-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.214.9; envelope-from=svens@stackframe.org;
 helo=bactrian.maple.relay.mailchannels.net
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

Netbsd isn't happy with qemu lsi53c895a emulation:

cd0(esiop0:0:2:0): command with tag id 0 reset
esiop0: autoconfiguration error: phase mismatch without command
esiop0: autoconfiguration error: unhandled scsi interrupt, sist=0x80 sstat1=0x0 DSA=0x23a64b1 DSP=0x50

This is because lsi_bad_phase() triggers a phase mismatch, which
stops SCRIPT processing. However, after returning to
lsi_command_complete(), SCRIPT is restarted with lsi_resume_script().
Fix this by adding a return value to lsi_bad_phase(), and only resume
script processing when lsi_bad_phase() didn't trigger a host interrupt.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 4ff9470381..59b88aff3f 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -573,8 +573,9 @@ static inline void lsi_set_phase(LSIState *s, int phase)
     s->sstat1 = (s->sstat1 & ~PHASE_MASK) | phase;
 }
 
-static void lsi_bad_phase(LSIState *s, int out, int new_phase)
+static int lsi_bad_phase(LSIState *s, int out, int new_phase)
 {
+    int ret = 0;
     /* Trigger a phase mismatch.  */
     if (s->ccntl0 & LSI_CCNTL0_ENPMJ) {
         if ((s->ccntl0 & LSI_CCNTL0_PMJCTL)) {
@@ -587,8 +588,10 @@ static void lsi_bad_phase(LSIState *s, int out, int new_phase)
         trace_lsi_bad_phase_interrupt();
         lsi_script_scsi_interrupt(s, LSI_SIST0_MA, 0);
         lsi_stop_script(s);
+        ret = 1;
     }
     lsi_set_phase(s, new_phase);
+    return ret;
 }
 
 
@@ -792,7 +795,7 @@ static int lsi_queue_req(LSIState *s, SCSIRequest *req, uint32_t len)
 static void lsi_command_complete(SCSIRequest *req, size_t resid)
 {
     LSIState *s = LSI53C895A(req->bus->qbus.parent);
-    int out;
+    int out, stop = 0;
 
     out = (s->sstat1 & PHASE_MASK) == PHASE_DO;
     trace_lsi_command_complete(req->status);
@@ -800,7 +803,10 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
     s->command_complete = 2;
     if (s->waiting && s->dbc != 0) {
         /* Raise phase mismatch for short transfers.  */
-        lsi_bad_phase(s, out, PHASE_ST);
+        stop = lsi_bad_phase(s, out, PHASE_ST);
+        if (stop) {
+            s->waiting = 0;
+        }
     } else {
         lsi_set_phase(s, PHASE_ST);
     }
@@ -810,7 +816,9 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
         lsi_request_free(s, s->current);
         scsi_req_unref(req);
     }
-    lsi_resume_script(s);
+    if (!stop) {
+        lsi_resume_script(s);
+    }
 }
 
  /* Callback to indicate that the SCSI layer has completed a transfer.  */
-- 
2.43.2


