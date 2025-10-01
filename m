Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB13CAC5B8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 00:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3l3d-0002f5-RY; Tue, 30 Sep 2025 20:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3l3b-0002ee-HZ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 20:50:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3l3M-0004qd-H0
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 20:50:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso4952671f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759279836; x=1759884636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kUEo+hrvQAgMnvbdKMuh6yQpXWPisQlbjQ9ZybWFRUw=;
 b=Sg72g5wRZmh1g6Azid3tTbi/9K7smX0i39PP7NWGc3bYAejyhHwfKfPX/QZZPIWMPO
 LqRT+QmtCYU3Vm545Krby3Ab7c+tDsGnKqcI1NOUpwSoMHxEWvSu+R1DsnadRVBrvFdi
 gThUSs56JBWU+FXNIIzJfjlKHywtzeCD5BzdKnqxaGCJPxYhPn6LJMaPAAxPSXjGhGSa
 lCb1U2WXDrAUPJ3WBrQPFAFpHTZuqqmbBl8PI0TddOMAUxK5d5Yj2T2IWsbR/HR581Ux
 z++TBMA6xAR4nRKb58rUfV1gjyJ8ZnCqgPrqQa9RE4r1kbCJc5g8CIkgKt8DelivadsO
 kBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759279836; x=1759884636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kUEo+hrvQAgMnvbdKMuh6yQpXWPisQlbjQ9ZybWFRUw=;
 b=lkDsqARo7MbDXHrAZ4sebN6eu+j5tF/5XjNDCGBLnM+quJCHlosrTLGc4igpol2a5h
 QvDJq178tTcaDhpCIAIjL6bQNTO5gtG+SGffoZZtXlyRV12kPvK/daky+8x7w1TTKcPn
 drwY/rUB6sjgtvGRL3mJCl0ikm2fsejSZu8IcUQJweg4dhgLE4HKS/FZcKm7Lj/UuyV7
 unTnx0CGJUPKlujMIIjbEJmZFmrU6hFKxGdGP+g5/3V6VSWtvnCjSB2l1gLE2OGedcyq
 NmZhXgGzhwZ23ECgmSCLADY4aSF0rvh2FpyQWorqhXMi2ab+ecIZB3hqeOFgrmglB6fG
 INpg==
X-Gm-Message-State: AOJu0Yx800VMNjvVuFFRMEY2coyjc2RkO3yLFi3HLcNCtylX8O1dz3i/
 bRBcPtgPgEXNODr60BsdUaHCMGECGJbul623y6/PbM2ECeAQIFsjMGYt/vsXmfirK/65hw4jEnY
 rbCuLt01zHA==
X-Gm-Gg: ASbGncsyuHz/XvmjX1SFNNdPl3brifeCP3UY2G9q5x9Sc9pt/vonD51TgVGWSL5Tv9N
 m8hz+LB8v924GC9tqEqttEoPXgt6XBWb4wbdD16L71KGmr1GJjHk8yQzsqh8MRIx6orYTYrDYIF
 GEF8dccE1xMlvJmhxJzgMHRRhrAZiO09KywrWui18NbsHL08IQBdttTNnMpbCAgweT+rN01uy6S
 5Uo0FrFBx253qSxnnKp7uZ1VN3InJeTwNwf/PMaFscs4pYfp9P/BtJgJqUC1miXBCQGTs8t/5Hz
 hYvp0EKnzVDcodTJ06IzNw9lEJTxjN8FpbAV6Bc8Q1dv2Qa1vjNqpQAHjrzBGXANN24bBxSB5hk
 Ve34FNhXt7uCHD5wU3F81Qz6w7NlkLVd7cUrU7Kn/6ESvUbDBAcaLCPVBN/JdixIKbwxIwi+DOh
 DkUyJsZp35D0nEMQuEi9M/eWEjbjHExiYilugnYXXn5wU=
X-Google-Smtp-Source: AGHT+IHAYZL7LWRaMGB/reoGtE2pQA8iSZ/cBU7nVRckqZh2kCS+UmeuW+GWhVGMUpBn4UbZuAO1pw==
X-Received: by 2002:a05:6000:430d:b0:3ee:141a:ede5 with SMTP id
 ffacd0b85a97d-4255781eba6mr1189001f8f.57.1759279836046; 
 Tue, 30 Sep 2025 17:50:36 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b9c88sm14352805e9.22.2025.09.30.17.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 17:50:35 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org
Cc: Salil Mehta <salil.mehta@huawei.com>
Subject: [PATCH 0/1] Test email
Date: Wed,  1 Oct 2025 00:50:12 +0000
Message-Id: <20251001005012.3042057-1-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Salil Mehta <salil.mehta@huawei.com>

 Test email

-- 
2.34.1


