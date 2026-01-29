Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBD6D46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtG-00008D-PG; Wed, 28 Jan 2026 20:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsy-0008Q6-JO
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:53 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsw-00037j-TH
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso2518955ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650309; x=1770255109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sp/+2zkNN70VNo1bVArEQB9Y8epLsWsx9UzXKYDY3SE=;
 b=dGh+HTjcnyufXthst83+duj/H4TcOYfIA7WaBY+dUO/k9jcBOFkx12ce48Ow8jg81s
 Y/VTrgNG00dL1FZ3C01vzYD4+Ah1gZx39FEIxpZOZ07tcnHqJ600Ixmralhh+t51u5zM
 ont+lPWvK+zVGzrW8nhVLn3nlcnwGIAEkU6FSQdMLxYS3nTXLrnRx4t3tljvyfXexsjg
 ezBfoyQZyDm75/uHe5q/xxQVaSmMe55MkjMimMXg60g3ep+54K/Aj/uOK52QQwDmPoFS
 j7TTqDq3GUsYg+bUZbfmP9mDu2OEToUoou35mYu859Lj9GcQpgPMTeIZ854X9oMmKKdu
 q6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650309; x=1770255109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sp/+2zkNN70VNo1bVArEQB9Y8epLsWsx9UzXKYDY3SE=;
 b=KnrVuP4daGVbRwHK0TpV/EHKY/QLKsLEaHW69rYd17+f1/TmwLLoQIxAMPyQ+5KJK8
 kSluDMmdi/4YN5doivXpcRotmDANOO3vaxnfOgu5a1FU20HLJQ5PbT8uAJgQ3zep5s0/
 Z7LE3h/G8rOARX/fWl4EUUKKwIiXWRDUhK+MXyO02JANogL8JNeVOvKqvySRMzF0ZTXG
 LM5y+V2g7kD58vCbkwgXyOVN+St02+9P6cnMuvyoHyB+pjvXRaxJng7IlS+UeiPdruck
 OtYbhsdQie0J2gTycpPPkwp2tuAz6D/Eq9J4Z6NWwq2oFqNeA51falpFyfOPM2+upQwj
 dWNQ==
X-Gm-Message-State: AOJu0YyO53gIbacEoP1N5A747oDmVG3xrieeWQGTRHHV/B8RvDvydM6b
 g2YF1HjRP2SXjCPM0NJQRaepvhip+pRhV7fIombkHfRZL0pdAvt9W+y1LdRk+uXhNqWFRWmVm/u
 S5cjg4fw=
X-Gm-Gg: AZuq6aJkruOmLAgn03bIcvsFyCFPhqm7nePfrcgTnBtOIlvY/bepQ0HX70Yl+NTbxJ3
 aJW+h4teeWg1ZVTRTxuUOs/BcPfF0dLWRjbDQg2rma9yB7CrS2SOCcMWOjJtfzgMnCa7KPSNucP
 HPVRh5dlXq7FK3zQqIK/ubTsZBWMMUZdxC+C/Zvi+L7YdqwHd91W0qqNR+0uaWvn2oL9K7QGQg8
 exhcgW3GPFlIh9EFQ3lkEjMExFuPCKMfBWsPfSngR/ntnCkVO4gz7v6XJ7MbMHmkOx0/6OXmy5D
 9buCqp5LJFEIVryWjL0OUgjsXySoIKPtKIKkNd9FZDJXuflfyPFIs2xno+vyudQn+1I7HemFk6F
 TzYvolBoHmd6lsRxTHj7Hu9OKdpYOtuOBTwz3ypSvzgn49cOoKgf6aj0YuFL/6GuI5W85+C/Jvk
 AOtj+idTzMEH+LQ5kfSuIniBuUYKYqVma0Y/q+8HJjZTPX7VSZLQaUp/6tpZ8Iy2ZE
X-Received: by 2002:a17:903:4b08:b0:2a7:6114:4865 with SMTP id
 d9443c01a7336-2a870dfbf3emr66263235ad.61.1769650309035; 
 Wed, 28 Jan 2026 17:31:49 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:48 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/20] docs/about/emulation: Add documentation for hotblocks
 plugin arguments
Date: Wed, 28 Jan 2026 17:31:18 -0800
Message-ID: <20260129013134.3956938-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Alex Bradbury <asb@igalia.com>

Currently just 'inline'.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 4a7d1f41780..543efc4d7dc 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -463,6 +463,16 @@ Example::
   0x000000004002b0, 1, 4, 66087
   ...
 
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Hot Blocks plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - inline=true|false
+    - Use faster inline addition of a single counter.
 
 Hot Pages
 .........
-- 
2.47.3


