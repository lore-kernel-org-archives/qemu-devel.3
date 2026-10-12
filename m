Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A2DCA9EBB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 03:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG76b-0006wa-0Z; Sun, 11 Oct 2026 23:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asdfkwang@gmail.com>)
 id 1xG4bU-00008I-Du
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 21:13:24 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asdfkwang@gmail.com>)
 id 1xG4bS-0008Kp-NH
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 21:13:24 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ab33730821so697432a91.3
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791767601; x=1792372401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CyBAi07xKL3F76J4hKkaiJ9rZDEK3TAuDFlzJIZ6eW0=;
 b=sARYvTcqCMJdXHZIduLNY5JRLjmmQL7s61IMr2wag8jDu5Lmgb5rKKu0clqqZjhd2M
 6MS3TL6hMowglRHTSx1/BadlHMDB3igvMJIW9jzPm5AwSSQ8Kh9kJiZuRdWaQK9nSyVj
 mzjYzjh7UxXEBQYbF7Ykw67nR0TZtwDWkJbswXcN+5hv3221rOobnIotsKhYxJemv0XQ
 OWxBPvgGhfURJ5ad/dUR05Fc6wyladOGGxBXoP6Fvymq1KSnszPk9rYzseQGO4pYJIvC
 D/rSTVZZbAnLXwfvVTxQpIoWvPKWVZxn9u+gHmijwHh8OZgqrERbmhE6yGs7HYc3zfTs
 O+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791767601; x=1792372401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CyBAi07xKL3F76J4hKkaiJ9rZDEK3TAuDFlzJIZ6eW0=;
 b=fkuLvaBEjLgn2ekfHOHfbVHqPFktbXLXPAN7IZlovNoB5wIu6JF7hQ3hSYCGsVdU/W
 GqQYV5Dv4QCDlsfDasCUk4076HLPKJlj6K8FYEaW9gY1T6iOEM5BRnWntpm3t1/vS9zL
 +uxxxaUpKmQEdIQ6dTx3vAN1MLfOMTVMq9Ykhfg1UWNxb4Geq0VK1mD8L2/tdkPX7ONu
 zhB9tgGj2tOUdy3Wj0swIlcWAYOoFMx12Fwvoez6WRl97LEv6YCJvyD1VbLnNyFTKLwO
 jQ2tc5NMeefFGDblnI9/UskqkAR9WzFQ5+d0E3xzykOcuSvHD7WEfxYHlcOiNcDX9yDB
 OCmQ==
X-Gm-Message-State: AFq9FYJzzxjp/EZYwo8iqsclrs0bcOlrblXnM2iZlv8XJxt5+nhtaHiJ
 qpjrB+nHDHfYlZ5/EstfYu8P2e4Q1jqUMBFtUUtE2Dg7CUAF902KhH0e
X-Gm-Gg: AYBFou1SEkIdQsXKBN5lRGYWF4LOQ9GNYYFqMX8qLRVNamEQFgeppskIA9/u1H0fzIO
 SCdIpLxyUb2K6/C9LJeFZeEo/YI7yfgE8SpCiFYrSow9VYSKgqJEQQRNtObZJccHnco9FXOOldV
 4qip6xtfnwJ5Xc9M96VqCkPsl9S/vMdLE+wjWOs8QE7gg5ljm7lFiZUsxh0is2Go1OWCMlL/C0R
 QLJLfPxhM7p7sE0CmbMsByhJVfoMcCLYKsWWrlQJDyh+OvndTh2MPk7wM9t2jpLvNO/fuZ+VlPE
 isekdTLimTPDBbAIcFCUWFQ6kCngV67HcJ9BjzeMOSZ/TtmSKwNL9ORwlTb8e6rVpDC+e4rtClZ
 4K2Ryulr2T2/nTVKdxN3Ujyy56hvD/AnWa+OlJgF99/lXWQpA/xlj+0DAlKq7N+EeAv+InIkKDV
 58vIESGnntTGrfvpTO6WQM0loZjFBAQIAvUN9xWHIJ9oNBd9+cvwTsLD1ZRdWnSkyKiPG6+ZShH
 PH7jZK1H/o=
X-Received: by 2002:a17:90b:384c:b0:3a7:aa1c:476b with SMTP id
 98e67ed59e1d1-3ab3a747d90mr7878195a91.31.1791767600514; 
 Sun, 11 Oct 2026 18:13:20 -0700 (PDT)
Received: from localhost.localdomain ([169.211.140.146])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3abdd5d09aesm3785362a91.7.2026.10.11.18.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 18:13:19 -0700 (PDT)
From: Kwanghoon Son <asdfkwang@gmail.com>
To: qemu-rust@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [QEMU Rust] Looking for beginner-friendly contribution opportunities
Date: Sun, 11 Oct 2026 21:12:25 -0400
Message-ID: <20261012011235.2947-1-asdfkwang@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=asdfkwang@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 11 Oct 2026 23:53:39 -0400
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

I'm interested in contributing to QEMU's Rust development.

I have experience with Linux kernel development, embedded systems,
and Rust, and I'd like to get more involved in QEMU.

I've read the QEMU Rust development guide [1], and I'm wondering
if there are any beginner-friendly contribution opportunities or
a TODO list that I could start with.

Any suggestions would be greatly appreciated!

Thanks,
Kwang

[1] https://www.qemu.org/docs/master/devel/rust.html#writing-rust-code-in-qemu

