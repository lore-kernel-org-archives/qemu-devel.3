Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEA0C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1truZE-0003Kn-6w; Tue, 11 Mar 2025 04:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1truYz-00036v-0D; Tue, 11 Mar 2025 04:02:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1truYw-0005Sw-1x; Tue, 11 Mar 2025 04:02:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22401f4d35aso90896455ad.2; 
 Tue, 11 Mar 2025 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741680122; x=1742284922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ONA1d2E4XD10msW6tevAx1vCLi9ZpK+6zF8BvUMrC8o=;
 b=kB2MjcPoP21Qo9ui+O0Y9vczf4qjeGLSPgR/X/Q93aG1TeAF33hBpsPi1yljoMS+nt
 x2c4uMBsNhVRpjjM6kfW3LycYmcwJuRE0t1rU3ntE1m2uRH8rCuX5T6rtVKeeKVaqbBI
 nf06F5miX3B5f76wJltIAzhhzTB/WLUbD6jRlbfK7hKcajV9b/X31++dIFbuIE/fFrM7
 CYusaV/QvojI04YYXlgHL/m7iMaoEvPH50jdKYCAnnN200UtRqveB89ur2BZ/x7liFaR
 PsO0w8l5/dOm1ur1DLzN9TW72tatgY11UoD9IyzMLqG8qwKxgEJ2OIXrs/RNsDSa7TZ5
 xMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741680122; x=1742284922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ONA1d2E4XD10msW6tevAx1vCLi9ZpK+6zF8BvUMrC8o=;
 b=Z1Ggn4EBSenBDroE3aYRHT2WcIAMC+Eto3djKMMmZ3chK/VozyT3MKmIUw8B2P9Vhc
 eSDEtYhNweBzDH/6X0SBfLkgJE620OQxRaPBSfd+Q/uwjcMCPoenGRtpkZD5dkOUmFy2
 ieMSyDTlK76jaTZxGjFhRWNgSrGHmla/JUbynHpHxMWOCS7wTKgmODGjYpS3BAS1Gl7I
 zv+q6HXdRjwdKsEw2lMiF3w7US6c4AmoT4fo8+2fUZ0xIno4J9jiJN5PPjBcnNsl0JBz
 O8XwCNTXkCKYwmuhco6VFq+y/gO9NnkwAGtaberx5rLcHtjsKgofO8ngD9XpUoQEtbOJ
 O0yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/rA1LSO5frtmakMlZMaY/05FjVI89zLK1JJzHylyXvRZFiouyMmMh9WzZLNsXnE8DjYDsKf67EHOg@nongnu.org
X-Gm-Message-State: AOJu0Yyu2ZFEeGQUKlvXZYVHydMuAk/aJnuO0fJuJzhdhgcHBRcFbQ5L
 hQft3g1uJTuPuXlksHT9l6VWBzkDOoHmVeSbaYE1ZbFjEVfpgUTwKui19A==
X-Gm-Gg: ASbGncuB9PG35HLw3w9n3pgoFi7fw6wDv8exEJEeBsW+u7qDQ3KRpov0rViVMHQj4kx
 P37zOoNKCH7fhn/7FwGjS7H+HIKaOSZRjsTb0vitZJl/jlBi1p7YAakyMaVa0hkA0Ip7RP0uK+Q
 ++DjwAPykI18ddJ3kt5HL4Hsv/mfVg2Nso576Xb6kJVXbO3tj/tA8FP0KmRQXl1rPZSLnoE+1ok
 gY6XHQF+FlSwms5vYJOjbjOMQ7qcn7MaCSWiKWqqWdpPEc7mYWPs/GNEALJwwAWi1BT00h2zLJh
 h2VPDM5ItXySxTvrfC78C9yfaBe/Tb/SaWKbrlqYsZZxWI0xffc=
X-Google-Smtp-Source: AGHT+IEzcUjRzkYJ3INRdTLeeroE4V4XZtP7oYFz3VRc6O84zQcXGf/nknKTtWEzbXYHP2hPn5D0wg==
X-Received: by 2002:a05:6a21:4606:b0:1f5:8c05:e8f8 with SMTP id
 adf61e73a8af0-1f58cb422a9mr4148626637.25.1741680121876; 
 Tue, 11 Mar 2025 01:02:01 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736982065dfsm9728481b3a.30.2025.03.11.01.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 01:02:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PULL SUBSYSTEM qemu-pnv] ppc/pnv: Update skiboot firmware image
Date: Tue, 11 Mar 2025 18:01:42 +1000
Message-ID: <20250311080142.897437-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 223c7908fe016d3fc79ea9b14f95c3e35c8c1436:

  ppc/pnv: Update skiboot to 7.1-106 (2025-03-11 17:49:03 +1000)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git rom-skiboot

for you to fetch changes up to 223c7908fe016d3fc79ea9b14f95c3e35c8c1436:

  ppc/pnv: Update skiboot to 7.1-106 (2025-03-11 17:49:03 +1000)

----------------------------------------------------------------

