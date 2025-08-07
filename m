Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26863C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 13:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk0Gt-0002WW-7I; Thu, 07 Aug 2025 09:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uk0GE-00028Z-OW
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:02:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uk0GB-0006tK-2p
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:02:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-458ba079338so7010235e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754571733; x=1755176533; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8NoMq7kZI+n+JBaqlMaDxPf/rsbZfqdBGF8kGOHbraM=;
 b=QyXA6YUBMObPFupn92PN/l5oFWAnfZVdlKrnF+zPXyFbi+BfFnFOfZMQZlij1YrrLT
 GC9wAtRUQsKB99Z+q38uoV43SnSkNrSROdO0T+HxA2wDE+bq6qELOhejKHMjfq4NrOKz
 tj3c1VMhbn5eecYjiXvlod60CUetBoS3Pw6zYCQ6PZnIitarCxcQXZw32mg3Z2EV4I4V
 7qvzXluVgzh6N8/G0nQCXt34Xeaa5c3274eF6EHgadc32fwwXoCJg/pwQUQuNSrE3cPp
 BYedmxzY/sGR6s000cIz3JQb+UMCNCX7ENSICsxXdhcq3kQqZldR4X3N0O5D3uwsDfdb
 gKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754571733; x=1755176533;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8NoMq7kZI+n+JBaqlMaDxPf/rsbZfqdBGF8kGOHbraM=;
 b=xFZgcRG8RInYA16GMsygfJh/NDOHYnT3QkXH/esISlwMUdtKXBk+sFaXteZ2GSDg39
 FfeB/J8VUVIMC99onYYgvz/wr9ZaGPjgAcFULzAMAX3KvGSZjx/FvLJHWkDgFaD4YuMx
 WRcF2hCUCxoEGb8IwTKkUQAmwOh3xrLyYRsml3TiYftaG269v0S8pZuCHNivvJW/biW/
 sVyUoojxEB2+LaBIo844mS8d75i/hVhXB2LNQLZMDsSgvnutYJCt7qhlIidTazgQ9K+3
 8pYTkQCxhdrcsvjXEyx8uCl85Gpw2febUKNSp7P+LLkJ090KiEEfpPvDBFo8KPBGuYeV
 OZDA==
X-Gm-Message-State: AOJu0Yw5xjDE2vPMNZ3ar+NoE64trPXxdS9aMlwZ7UlUltFccVIvVNg5
 Ot8PKvxZEFujB4VKyX1k6GMUad/b43YN0apawaO9sG2J1GhS7+4S4tsGtOn9EU6xVUM=
X-Gm-Gg: ASbGncuviLyaB1H6UdbNAC66HAD0ZGcxhoZrge9iEwkhotJBJ+cgeWl0NhoGo4vLbr6
 je8JoXML8jceHTnTX/nammsfNxkmsbbmwsNPWHSt8LZ58hUUTvh/CGjIyVAde9mj7Vn1AAadI/I
 SLkytbfxPBFl2PthKPoXig1aZNi4OY1ko6G0VtlN3viGh9pz5gjq8EOhd7T4f1Kx4p4wuN5EQMZ
 8gPnDMwl6igmUyhk8xElR4RibG0xNc04nJvWohG21i6jOZz7s5bJV6NO8QmcJDGQXIiq79ruJP7
 ML5gOt+b1opYtCtTfq2GoYzYKtiY+bsNad7aEx41wd53YLoVO+pBp7gBYNTKD/oCvPS2PSyVrHC
 3BVd/JSGfPaqd0d3Ur/QwXCup8jSS8DprF4dymgfI0YKwKWAvrVYvfgCv+9fyEGuRItag
X-Google-Smtp-Source: AGHT+IFXoOZpo1zqGbmZd8wckvRvqxfbWvNGRsorArlLkd7Sg+FnrzdVD5P+HNsiVe8YPcGRF7MEVg==
X-Received: by 2002:a05:600c:a31a:b0:456:1d06:f37d with SMTP id
 5b1f17b1804b1-459ee0db219mr25998475e9.16.1754571731798; 
 Thu, 07 Aug 2025 06:02:11 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440194.home.otenet.gr. [79.129.176.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5879d76sm101024775e9.24.2025.08.07.06.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 06:02:11 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/2] Misc trivial Rust docs patches
Date: Thu, 07 Aug 2025 16:02:03 +0300
Message-Id: <20250807-rust-docs-add-128bit-mention-v1-0-1d8a1ece3a51@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMujlGgC/x3MQQqDMBBG4avIrDsQA2LsVcRFmvltZ2EsmbQUx
 Ls3uPwW7x1kKAqje3dQwVdN99zQ3zpKr5ifYJVm8s4PLriRy8cqy56Mowj3Pjy08oZcW8hYgTA
 kP0UItcW7YNXftZ+X8/wDCPhVmG4AAAA=
X-Change-ID: 20250807-rust-docs-add-128bit-mention-efee85c29aed
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=466;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=C3vTuTFbDdZUK6Hno0DZJBxpF9DE1UQm80sV9HrBIYM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9sS1BTdTdKK1A3eEgrYWFmZnFGMzJTNXFDMHNNCmo5VzJkYk9lTFpNT3hpbHFC
 TEtKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpTajBnQUt
 DUkIzS2Nkd2YzNEowTnlYRC85eklheURLbndPa3BDR2tNb205dFdUc2JkWUtBUi9na0FHaDhOKw
 p1WW90UitXc1BuZk1VYy9BOUUwa0g1QjZFUjVIVU5QYjJ4TDFoVWxxcEE5Q0dPSk41YW9DVlBJW
 mc2K3RCZmRHCk9tc3E2eDVhRkdCb1NDU0R1TktkN2NXb0hXWld4c05zNFptTER3OEFIQnVOeXRv
 eCtWZWo5ZXhxT203YmI1cm0KZ2x3ZDE3S0xtTEF6VVlTMW1NMWpoN3E2QzhidXRYVXpXb1Z1elJ
 5VDducU5pa1NET2JJcXVVTHRUdElGNlIxVQpwOHRzamdFVlk0WGVCSGk3d2IrU0lrOUdYS21CcT
 VQTEgxYUdNNHpkV0wzMDZnaHdacS83MVo3Z1FtYU1pRjlYCkM2OG85T3dyTktBNHpxWFZobGpvS
 kZEbDErdi9BalFZZmNTVUJNcHEzME5MVzQ0ZUxBQ3l2cWZQSkhyK2JSZk4Kb3dHZ1JxUGw0azJz
 U29YMnJwN25rUC9IdUJBR0l1ZTR3S2RqR2piaG5HMi84eUtTV3ZSUy9Lc244NDhITGZWdgp0NHV
 5VUR5MHdtcUlYTThTdVc5TU5LVUFSU1NFSDVsOUk1STZ3clBjR2EzaUVyZFBKdUNMaFZMaVFvOU
 l0OURTClFtTWNDbTNhTmpHQVBEaWJ4ZnE5MUF6VVFBOWdacTRmM1BqazRPcTdaR1IyaUdzaVp2a
 nhMUnMzb3F6OWgyOE8KSk1xM2NYeFREMjl4QXk2SDBXeXBMbnluT1ZodkZyYkFNNEJQemNGTXlV
 RGFpRGJhRmdIeGJaQmFJU2hSSnExNQowdXZlZjNrNHpOZWtDVHhoRUR3MS9OalpQbEpUZDIwS05
 OVEVuS2RJNU4wWVZOYjBMT2ErR1NENXptNTBWRUJjCnVsWGlBdz09Cj1HZ2VxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (2):
      docs/devel/rust: Add mention of 128bit integers
      MAINTAINERS: add Rust docs to qemu-rust entry

 MAINTAINERS         | 1 +
 docs/devel/rust.rst | 2 ++
 2 files changed, 3 insertions(+)
---
base-commit: e0006a86615baa70bc9d8b183e528aed91c1ac90
change-id: 20250807-rust-docs-add-128bit-mention-efee85c29aed

--
γαῖα πυρί μιχθήτω


