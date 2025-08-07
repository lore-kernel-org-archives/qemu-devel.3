Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C77EC87FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 00:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujo9Y-0007Rk-7F; Wed, 06 Aug 2025 20:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ujo9V-0007Qy-Ro
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 20:06:38 -0400
Received: from skyblue.cherry.relay.mailchannels.net ([23.83.223.167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1ujo9U-0004js-2W
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 20:06:37 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C65B31A5024;
 Thu,  7 Aug 2025 00:06:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com
 (100-98-216-71.trex-nlb.outbound.svc.cluster.local [100.98.216.71])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 56BD51A4DD7;
 Thu,  7 Aug 2025 00:06:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754525193; a=rsa-sha256;
 cv=none;
 b=wKe4hBTT/6o7ZdgUirjUChtfmEYLEQOcEeu7tzmTNkONMIFDT3sY6AvgnmPfSOaHKZ9h63
 fyXZl/D0pJMNeev4eKjYRBLV8IH7A/LCFU1uFeE0l0EtJMtcCFJY0J2l15dI87okjHp74X
 zMsjPJZ+K+Ixl2T601yU8Can2IfwJ/bXfTjrvtRXKKVfTNROJJMiQHfeboaFMhXDfBWFvu
 3WLkFf+zBCzjlKOzpOpX2ZJfluTUZGgrEmGDgVHMgarffFXxd0OoDNz3cSkgpxbiFzqpBo
 DfkAgU/MAYrvr/fQgmXVkFeViiUGCTPOse1By60gsuxuGcE0xJwHHUdpsCoKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1754525193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=lC+S+PMJ0IPLx3hpttP4fsD+ikeDBNPckxX0HDz441I=;
 b=m2H4hsz6AFWCYcjBtmk/IPxhqFvkWbkwnwyFLlO85mxSW/7Gb8kINDxzjr3ffIpqCBcrTK
 GLh+6PmR1BJiWRgNSpjcE2QzgN0AtPS7d4BZ8JNp+yIhPz45IJ6+GfAC7WmII0j7+Ql0lu
 HUpVSoy8n8+vRlTP4RITHU6/daKBZdjNLDVqNJjwcaf5/7MfxMfQeTixRw6EeenhDpvLf8
 nFZcw1uTzPw+R4CdqS/a8swqFSjPgBs2+6KD9/SCv5kE2dl+ZEgXvy4FL7XELFFjtFX0oK
 hpFJJUeH2KMAZdGn99HEA918WkS8dqB7QE/68n1CpIAyHuoqa0HsCmdhBXqz3g==
ARC-Authentication-Results: i=1; rspamd-565df7d78-rkwqc;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Bottle: 6e5936080bf291ed_1754525193604_1346270259
X-MC-Loop-Signature: 1754525193603:634501519
X-MC-Ingress-Time: 1754525193603
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.98.216.71 (trex/7.1.3); Thu, 07 Aug 2025 00:06:33 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4by6s45jSYz4w; 
 Wed,  6 Aug 2025 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1754525193;
 bh=lC+S+PMJ0IPLx3hpttP4fsD+ikeDBNPckxX0HDz441I=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=JyUSpzjkAV8zv1fVt7e+S3xHg5yS4W4UbslmT17xiWzCzqlEVjXsLCgxM2yMhdE1O
 v4P2Do564v90Ndp6iJ+DtY6NEUlvVT5j0GOi+V01vFS9LS3R9BC+SACproz5Jh1hu8
 FXjlavz6CX+fG2JmfdeWxRQI5MRUQ0jXCbpwsaJoTo4Iv3ymM0tWlmDFaIKQZ9jaAs
 MIMjdehoh5iOHXev7DuNTn/hp4QEhxzTkjyVMUnEOr1PuBWD5CElaEKq42KCl3Ak5H
 1j1hm77ZM+RhJq2+HgC1Qa2hqmVv7Fr/XsKdsBHQdeLOS00LhfQyfGSci9hDtKl5u4
 oEWB6+g7qPeHw==
Date: Wed, 6 Aug 2025 17:06:30 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com, alucerop@amd.com, a.manzanares@samsung.com,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] hw/cxl: Allow BI by default in Window restrictions
Message-ID: <20250807000630.w5k6kzc3sahup6vr@offworld>
References: <20250806055708.196851-1-dave@stgolabs.net>
 <20250806055708.196851-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250806055708.196851-4-dave@stgolabs.net>
User-Agent: NeoMutt/20220429
Received-SPF: pass client-ip=23.83.223.167; envelope-from=dave@stgolabs.net;
 helo=skyblue.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 05 Aug 2025, Davidlohr Bueso wrote:

>diff --git a/qemu-options.hx b/qemu-options.hx
>index 1f862b19a676..ef6072bd8b59 100644
>--- a/qemu-options.hx
>+++ b/qemu-options.hx
>@@ -142,7 +142,7 @@ SRST
>             -machine memory-backend=pc.ram
>             -m 512M
>
>-    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
>+    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity,restrictions=restrictions]``
>         Define a CXL Fixed Memory Window (CFMW).
>
>         Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
>@@ -168,6 +168,8 @@ SRST
>         interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
>         4k, 8k and 16k granularities supported.
>
>+	``restrictions=restrictions`` bitmask of restrictions of the CFMW.

hmm so there is a doc build error I missed:

qemu-options.hx:212:Block quote ends without a blank line; unexpected unindent.

------

diff --git a/qemu-options.hx b/qemu-options.hx
index ef6072bd8b59..da642642eafc 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -168,7 +168,7 @@ SRST
          interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
          4k, 8k and 16k granularities supported.
  
-	``restrictions=restrictions`` bitmask of restrictions of the CFMW.
+        ``restrictions=restrictions`` bitmask of the restrictions of the CFMW.
  
          Example:
  














>+
>         Example:
>
>         ::
>-- 
>2.39.5
>

