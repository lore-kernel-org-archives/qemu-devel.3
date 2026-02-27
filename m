Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C907FD530D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvspM-0007pi-0R; Fri, 27 Feb 2026 03:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vvspL-0007pW-2w
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:03:59 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vvspJ-0001qG-MF
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:03:58 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-899d6ad09c3so1672716d6.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 00:03:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772179436; cv=none;
 d=google.com; s=arc-20240605;
 b=EbCgXAH/M+DJwV42HDhBcVYD1YMLE3nGN8uvfHXrD9OQqdLYuIKSTGENGeTOiXTwLd
 UtOFikM5LZA2nnromPYy8XS6TLa86WVylUCDDb3Tidz7ltUrHB0uLCdGdIUlQkntI52h
 amqUys2oXXz35eEujgIxde7LrVZHMTVmhFe7AltlP8Pzakc/shEwYirwyRqyC7hcvpHL
 yHpUaPG7YvR48/DxkQzHmX3/Ml2aBoY21fy1+6irIhIzNmWBkkxQbTs1tZkH6F3Hq+un
 eHuSH/GqABwl28A30QosLfwQeihxaqpA6vZYM+qayl4Xm4G0VawLav4wO7fvnNhNIdOt
 K71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=JzyltN6/8DVzAMzNmQ+1UbvP7nTWKKsymfawUj83xls=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=AcvkqIzM+08A333d42/v1+TncrDnah0jXoe8xx7+aIuviUCPksi8PXP765s2rhA94x
 EF57KJTet5K4TVgqdJ3Fw6ScUTCEyKgf3gWRLYj3jT1Rv8870eXVBTfW0R0AteVKAaY9
 ALwCr+Hb+ZZYNkA72Mvf08bvARyinvJGkW7ozoO7octyWsSfsIQtOVd5cq8fsdSlqLlA
 NhUK6TaD025t5XDOKiomGhvFYxbtBi9AKZ9jMklWj912d8weZ+0YZiqWs1w1j7mII9e1
 pwabQduZHY5VaheZAMyFIZ6Vz8R4Gg5p2lGIr4Pqx85VJ+tkIeLrjnByjFjkjHni/8IC
 UC3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772179436; x=1772784236; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JzyltN6/8DVzAMzNmQ+1UbvP7nTWKKsymfawUj83xls=;
 b=cqlaY6+4+V4x3wrAjWkQtmpQAFMeFSKe5fDxa7EhFfBGPCoKmUeKvJM7rpTKVKLTa/
 JdMlzyf3qSlo42Lli53AY8fixrgZo0SQHyHi0i+nEtH8QtuZx7oyjmhiwOp5Rkm+xYfo
 5LFAn100h2TXUsF2dnm6sf+xrhd4PE5X9FGkg0ydWA0qDUNqT4beSM/Os6CVZRcfNwPG
 PZBZwYqs7j34C9X+p55R2nJmp7v4nOZgMvei0rXxsa6ewxmnk1AsJYVhcqG+Qo0GumnB
 4Hy3EvKd7FKx/b85P8M91kDjVr9HtQ4R467xWiUX4T1/apMUPyN34sGSxu7YjF2gFIfV
 abPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772179436; x=1772784236;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzyltN6/8DVzAMzNmQ+1UbvP7nTWKKsymfawUj83xls=;
 b=WsZP6HD5uzDzb84IheJUealP99jcuzxojbf/mzi1eccuR9rbp1h6oRVc0SxSxhTH2O
 ++FXKyJfdP9CbAYuG9oL2YRu2+5VI3uYGxzxfWYCUWuFbYlcC5GkIO6HcgIcKtQWGMTr
 CANU1MFN/jphPjyt2jwIHxk2cO+i2p+3JoAW+YnFqNDhFl3vVPFE31Xqujx5oJReMckr
 TOW0sQ95m8Xup55gvibjaiZI2L4F8oPyjBwVHLX9s3fQXOaUAofWOB1zdY8K+JnUperB
 t6Xs/Q2p55l1RvCjo56/ML2rq+h4xlrID2y/Ae8yk8BsBmRmgVnjdycnSsnEafMBbDK3
 0xjQ==
X-Gm-Message-State: AOJu0YwzUxZ1b6cSBuGTit1WynxAntZuil6x5Qn3cRzo9sIAuzqe1DmE
 +sQZ4QotIAeo/RFe8gd/bqaRlA0uGnOyT6qsYG9Q7OcrQ1vb1Ji6LfSeIp3cpbVNeDLchHgmHRU
 +kQuUP0wcaDUi0HuZQhS7jJuTEm0Lq270u+kDrjTU+A==
X-Gm-Gg: ATEYQzxj6u8oWR6DHditR+oyzqGjJnPewCQz1NDuQINGrDZTM+eCdOenzv3Y1FWyc8R
 g955HFt2AKBGHYlR5rSdxvDkXnLDe4hYKuIOEqUw/K5j3VEhzFhuWx9woDO5jBOk5r8ihkyhocP
 LHE5H0XAgQo1MvolAhds0cASIGf7P+zcIDaon/jtIxmAvcKBqUcI9JP/2lngQvZ7iiF/GMLm7an
 fKo+BABMGU2aTw2s6T24LcPffmiJfdjqsKTZi0g/XJOaFe3Bre0Xx7aRjZTqAcJs1sxfJTCnGuK
 22rrn340XKWr+zJvxrJKAoqsXg==
X-Received: by 2002:a05:6214:29cd:b0:894:8311:d3f2 with SMTP id
 6a1803df08f44-899d1e73d7cmr30135776d6.55.1772179435829; Fri, 27 Feb 2026
 00:03:55 -0800 (PST)
MIME-Version: 1.0
From: Choon Keong Teo <ckeong.teo17@gmail.com>
Date: Fri, 27 Feb 2026 16:03:44 +0800
X-Gm-Features: AaiRm5256r6lNAIyFfTYUObQTlHL9kveOIZSif6p2WpNqh3CFpOkqZQb5ogkvNo
Message-ID: <CAOkKuiOpVZwn7ZwPDPxJWmQ2SovUUTf2eLwg9dWFgEEhi3_NFw@mail.gmail.com>
Subject: [HELP] Issue running test cases in Qemu
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi everyone,

I=E2=80=99m currently working with QEMU, and trying to run the test cases. =
How
can I run the single individual test file only, or a single test case
only? Thank you so much!



Best regards,
Choon Keong.

