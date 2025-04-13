Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D610C3601E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Apr 2025 17:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4135-0003MP-Ds; Sun, 13 Apr 2025 13:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4134-0003MC-3k; Sun, 13 Apr 2025 13:23:14 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4132-0008DA-J8; Sun, 13 Apr 2025 13:23:13 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso2928141b3a.1; 
 Sun, 13 Apr 2025 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744564990; x=1745169790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B6r3JOqX0rcIOcKKbyD5aOl6OOJA0RRWKsrVkEzoHaE=;
 b=OPQIoLW+T7ScpOK3g1FiSrhiJ353QYKLrV1QlJcc9IKQa8BcxgL51b92kikLrHo/hm
 q4N/Zb5UI/bXoKXzqOYzpD74B7MP0DrCo98Ltqm4NIJcR9kmgS+1eVkcrmYhAKGekKw5
 NNZJeofkmSv3UCcYfUYpc3GMrDEkzZPqoGgQOO5x09+QFLK6PE0qBGwNuw/gNaS5+ROw
 cm/ADze4OMJJvinN6Jp4S1Z+Xu+KTLPSySvUSpMjPBR4q90LmGZaGkxNHSudCB8sKvC0
 lvluuIRaFlWa0vS2f82KRrktBgS73N8wm2lMeX9ffmJsy0mCd7WQErUbiXAusFrR8/f5
 fV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744564990; x=1745169790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6r3JOqX0rcIOcKKbyD5aOl6OOJA0RRWKsrVkEzoHaE=;
 b=VrWgWYhAvItPyeKe2z7TWVTb2ymajJVj9ZtDhVec6ne1KDc7YKTFy8bijH2J3DaDRE
 og1ntUEKyyFSMCsosfcw0DvVhYSzcYkIxoniU3w53/Wh+D9RDpwYny+ajTs6rjmBr90p
 0/zixIC92ej58N39EylN14hyeTU9f/MS6N7WQcifasRmVcMygJd2RSVnMbhY+esgmBeQ
 z456pYHmPvHMBGl9N1Q3W2/TZKZEOsQY2bX+xADPp2zCDHDHOWezP5Yg6q9kMGOXy2A1
 FSWTd4gDsOE2axdJbxr2vw1fRUuc8UA/VxUWuT4tNibAu1ySn+WfW776JO4dBo3kZdfJ
 iljw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEOEy7QZRl1YJzllmm0A5NFYj2iyoCNdB+kwSLZtpFl+uiIfb8BDvP+QteXuEUVH76r2z7INn07MVz+bU=@nongnu.org
X-Gm-Message-State: AOJu0YyjfAVmrj3X347N5xTssarMZXWyLzmqkLA8Z1ulhqttnZ7fXFS5
 vzRg2eKgVLBUbdwzvAdKO6tC4GIvNe5sm6o+xNqDqCfPWP5FYgz3syXZNQ==
X-Gm-Gg: ASbGncs8861O5dh8qxrxUnXgYfI88+7p7rsBeVGSO+de072PSqhgyiNLCpXBcwGagL0
 7yU+ha7luXIKiOM6pX2d85DGgvDwkvYw4eMaN74jwhKYkXKEKgNW8qrGvEzbIZT+PmFtNrirwpv
 gMXDZBEUSA2CptmP21Ns693aLX5ZX3oZ/v0ZxjXVwHYXqV0I+lm3w7PvMJ/S2bA3wNXciLbVh62
 yelow9w6myuWmHUw6bUKIwiGw+XeiWWlR4E11HxMty2LM9hDHOHFqJtzd4r33lWc1GfHyHV156K
 OZ5JXw/hE1BqeAga9k7JTqWpZ4GQdE42Vwf9gRg+
X-Google-Smtp-Source: AGHT+IHJUgUiwWXAiEOLjPFWub/8H2tExGNFZM1etrv97FXh9DHrou5LdBorOUCsaIpWcRwLQuvTvw==
X-Received: by 2002:a05:6a00:21c4:b0:736:ba49:97bb with SMTP id
 d2e1a72fcca58-73bd11a8470mr12321671b3a.5.1744564989730; 
 Sun, 13 Apr 2025 10:23:09 -0700 (PDT)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e4adsm5381989b3a.142.2025.04.13.10.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 10:23:09 -0700 (PDT)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: ziqiaokong@gmail.com, qemu-trivial@nongnu.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org
Subject: [PATCH 0/1] Fix endless translation loop of riscv
Date: Mon, 14 Apr 2025 01:22:41 +0800
Message-Id: <20250413172242.3430944-1-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pf1-x434.google.com
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

Hello! I'm Ziqiao Kong, the maintainer of Unicorn Engine, a fork of
QEMU. When I port Unicorn Engine to s390x, I notice there is a bug in
the implementation of RISCV MMU. It uses qemu_map_ram_ptr to get a
pointer and reads it directly, instead of bswap or address_space_ldl,
which causes an endless translation loop on big endian systems like
s390x I'm working on. Therefore, a quick fix to this is to call
cpu_to_le64 for cmpxchg as this patch shows.

This patch passes our unit tests and the error is somewhat obvious
(unhandled endianness discrepancy). Therefore, I'm rather confident
that QEMU aslo needs this patch. Given the changes are small and don't
impact most popular little endian platforms, I think this fits into
trivial patches.

Ziqiao Kong (1):
  target/riscv: fix endless translation loop on big endian systems

 target/riscv/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


