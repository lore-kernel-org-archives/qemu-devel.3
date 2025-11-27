Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D23D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObwH-0007YD-P7; Thu, 27 Nov 2025 08:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObve-0005Yg-2c
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvc-000273-4c
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Pepi6jeH9DfFFMv3XK3Bu8X8CyejOzTLvd3kGqRwko=;
 b=OpqzDL75wHrx/BHrbjmdu24LnElp/cSZiydpUnqos9a4aztvWzqhVQs2S59aDqrfYGodSP
 u1qIQsvoYKmr0o1qpwTMb9k9yXJh0whvqScmPxSH3bffeUtqvbkjJeLwDmow/EnI5Ohw1g
 8dgvNlcGCKIgoNIqNzpD8zUwQvZuKxs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-oWZv3z1GOBWJ2gyL7s3g4Q-1; Thu, 27 Nov 2025 08:20:54 -0500
X-MC-Unique: oWZv3z1GOBWJ2gyL7s3g4Q-1
X-Mimecast-MFC-AGG-ID: oWZv3z1GOBWJ2gyL7s3g4Q_1764249653
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b76eaf310f6so217326966b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249652; x=1764854452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Pepi6jeH9DfFFMv3XK3Bu8X8CyejOzTLvd3kGqRwko=;
 b=s00Btp5t2/XMnJ2bkjbvZuopObWund7Kz3bl7qfu7ri8K4tXqOQYYd19/VjJ0ckhUc
 oDSdq1Y9rAyqiOQej2hc6I0TKh1hkw4tcVzyJsy9jjasyCIjPhe/IBoPY38bVkrfKvHc
 cozbxzoMDSEVbWDfJjIVPEKUsF0q6pIFM004+7EN4i3M/jwrwT/F5LbGkZE8P4we4Ren
 YwcOGVzT6ShR75k7HTIQKcqgFrpzg6FW53GHRXrndFihkrVUclTkmZ3+RY34h6Cvi6eD
 YWnUz6jdxuzb1DyksHIguNOrdTzWaGGH3zCGwiRa1ipjYvczDoOC/g4JvmiGsFvogk50
 OZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249652; x=1764854452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Pepi6jeH9DfFFMv3XK3Bu8X8CyejOzTLvd3kGqRwko=;
 b=QGO7nf2W46w26VQAnYXEvEAGDd8ml+c5+f1yHnXGh/+9RKI2SCcnxjHLKIKssxQPx7
 OKMX8H4769EC+FuLaqr5ki6PytEK6QhnW7YK+yR33BEHw1B5zuckSwNUO/GKENeAr/T3
 tOoeF9KE77Ig4xdWzDlcXe19QJSZc5+7u1QOdz7PI1BFkQsmGyCwld/aUvr6iIB7IdjJ
 /kf2xd35nbX/Ub7aK96DJjIKzt8qBCif7zQR1sXmrYiNw5x85P9CzDfHSOguwI5g8AAt
 3d9yTY68pG9YVTG6Y44uflNl1CKOF0TbAErH9ys+t9cNKDeRIwCAygj8xZ+a/pV8ChsC
 USag==
X-Gm-Message-State: AOJu0Yx7wq+eTZnl6eIjXoS+am33XwOupmmW1DWFk14qZvset5Z3F9Ss
 lXuy1RJguXIHc8pOHHk0zYt471yftz2EpwWBmKPDK2ajDb29pDuW2znDqbx0AUTVm5pB1ANFkTS
 VH3QDURwOXhcEK4vC5kNGMyWma14OP5CqwUc1EmcbV7qrAZh+IBGaUurfODkLCfMRDajflK3cWx
 V7oMxE05up6F2meZ1x87kG1m/tGz1blHBTwvPoeudw
X-Gm-Gg: ASbGncu3SVKbQekk9vB9LbGYCNDzMp2xfeYqbP54aTr5moRttT/0hvnZEfsTXW+j/vv
 BM0CgVEUYhy/GUmZ2KzyJhmd75SzDHQqfvWujK4B99SfpwUr/XfVPHNFVP3PcbWAazZnswynXFu
 I4BvE0mo1XhLs3/Go1ZmNLGIyCLaR7VEPcRnuoVvanI678onYZ2+kFSwQhB4o3DKikfaz8kswNE
 tjo6jjqTi9DqtjE+MznnmCnZB58WJxeo2O0Cp5Y4QJBet//Zoye98CjEU9pK4xnzwhvpGw7bftn
 PR8V0/pqxJx8vs97cmpFHnI+51IwIULSFSGZpD2HHERSwmYnZQ/yow1JIQz6nmxJJD1W2XQZsiZ
 KbTfjKtm/jU8WgytOLtxim1wYhd2LFWUkXJuRZr1TVMCFTYklTVUHRsbw8jR2BuljBKmq1Tn8B0
 a5SlhzNLLGWLxF/ME=
X-Received: by 2002:a17:907:7f02:b0:b76:25fd:70e5 with SMTP id
 a640c23a62f3a-b7657172f39mr2965549366b.9.1764249652499; 
 Thu, 27 Nov 2025 05:20:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrG1KsgGUtAnUytaISRdYHjVYWool3bGVjcqpuHMouu1tGFNLcWGETNobColG90nPIVwj/dw==
X-Received: by 2002:a17:907:7f02:b0:b76:25fd:70e5 with SMTP id
 a640c23a62f3a-b7657172f39mr2965545266b.9.1764249652018; 
 Thu, 27 Nov 2025 05:20:52 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f519e2f0sm163084466b.21.2025.11.27.05.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 6/9] rust: fix reference to MemoryRegion
Date: Thu, 27 Nov 2025 14:20:33 +0100
Message-ID: <20251127132036.84384-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127132036.84384-1-pbonzini@redhat.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the wrapper struct, not the C one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bql/src/cell.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
index 8ade7db629c..435d6663ac4 100644
--- a/rust/bql/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -42,7 +42,7 @@
 //! references to an object and yet mutate it. In particular, QEMU objects
 //! usually have their pointer shared with the "outside world very early in
 //! their lifetime", for example when they create their
-//! [`MemoryRegion`s](crate::bindings::MemoryRegion).  Therefore, individual
+//! [`MemoryRegion`s](system::MemoryRegion).  Therefore, individual
 //! parts of a  device must be made mutable in a controlled manner; this module
 //! provides the tools to do so.
 //!
-- 
2.51.1


