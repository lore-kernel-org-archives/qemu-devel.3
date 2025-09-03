Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4207CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 20:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uttfC-0004J2-Jh; Wed, 03 Sep 2025 16:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nguyenlienviet@google.com>)
 id 1utrL4-0007f1-T3
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 13:32:07 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nguyenlienviet@google.com>)
 id 1utrKz-0003gD-MO
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 13:32:05 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55f69cf4b77so83084e87.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756920712; x=1757525512; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=F5aamagNNyU52hmoACc1BOq8E1Go2hm2HxelTcAlvC0=;
 b=w0ihv1oyS/v1+m9/wS/6SF+j8notTIqrG0Yc8p0d+VzRMsnOQ/1/5qMt0mCObRcLfU
 7Ol1TbAxIBn/u83ZcZX+9uAtFmFf54IO/e+M8IWnoavb76QEPhuDRUeHwwtRxNYGEOhH
 W/3fCGr/KaOqgTuzA5DiQPgvQFlnDN5cjWQNRXR+y9P+6NerrLV4W1Xb41Rs9kdVEhP5
 2woMNb9QlQbr0Kh0x8Us4C4cm1RbsqApTN4qYbbafx2DCYVwnCCwHTVmlw6v8Na79s6F
 nlTgygIVrOlLfrI/mpWbdmOVY5Fj2z49Q/kwP3d+FdafUJZCTcsDQcIODdl4lqYOrrbl
 FDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756920712; x=1757525512;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F5aamagNNyU52hmoACc1BOq8E1Go2hm2HxelTcAlvC0=;
 b=B6230c8VnqX2AVYE+RGvL8vqI8WXvQhUtXmjW3eXyy7YyAB9itJIF8KGb/b+WwPt7B
 VCpMY7AYFj1zZIHuoltVbfXzHA2cU2UXk9uHRToWM5k3eqpN+bi2fjka74o0h0UEYrp8
 fBcjsZrkjTr3thOQqUNXnFOG9r/OTOnKnfBDcWU14bggEx9U4bsSVxE6xFWwppUYZKIt
 999Qlu8jGahHfTFwgkwo11Rk5iKQZLaICfWLihCnL8fNfG/8Nh9ShIVIJLs2QedgDUil
 uPcCOd5du1un9zptQA2ie5N3CQJaym6YlV9VnzH0tAmxxfN+K+/3RVqFNkqPZDvok3LM
 3G/g==
X-Gm-Message-State: AOJu0YyagGcraZGKpcPmuq2aUflQmQLh7ec5AUIJdfMBj/FYTLkeTFbG
 IHMnTFxwkZA18w/MEDcLQneqi0nMWwSjk/1bN+e8scKduUljqvSz3KPjhv3ND7Oib5XJWfW24rE
 0DndC5JDribL9NHZkcSQfUuN8ch11E+LUg0gpPLt6sAA8D6V8dThyBLkhrw==
X-Gm-Gg: ASbGncuZ3hlwozaLbdX/ot+G7cBthugfAamd9QRWaapAjr02jnJ4r28JzU8MKpwX/+5
 xZdLEsgF1MFS5+NJDPyowOb5ejnHp5dqH0ab/C54gbr3y8v7KtH2vH0L4L1ydpr4n0VCHjsEyJg
 +dfNWMYYQre7luCCUxGCm9F29lGw88UlL7fs0FIjTP9l0yYYwypLTY+p/l+l29CFXtmVKysZfn+
 8FoaLzwDlvYOOT1Gp9HXD1lBFqAx866+x521xnd/Kg=
X-Google-Smtp-Source: AGHT+IGik+v5qnGJB4PP5Fij5YtmyBUWqGqbSQN/vDb3Hh7SjkhUJM27pJ/8D661kKp7Qlt7vEhC47DEBAtBX2sNFDU=
X-Received: by 2002:a05:6512:258a:b0:55f:6fcc:6f4c with SMTP id
 2adb3069b0e04-55f7095249bmr4801628e87.47.1756920711411; Wed, 03 Sep 2025
 10:31:51 -0700 (PDT)
MIME-Version: 1.0
From: Viet Nguyen <nguyenlienviet@google.com>
Date: Wed, 3 Sep 2025 10:31:15 -0700
X-Gm-Features: Ac12FXzouWikuDcAQBMpLwUVhV_sRq1eBMeKo3LPkTQEjR3KucUkUCibNu4w59U
Message-ID: <CAO4PGyruuYU9HC_t1ASAEBgAOW=fzDoJn_m58+QjbJNsjugJ8A@mail.gmail.com>
Subject: Support for Big TCP
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e769fc063de8faa7"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=nguyenlienviet@google.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Sep 2025 16:01:01 -0400
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

--000000000000e769fc063de8faa7
Content-Type: text/plain; charset="UTF-8"

Is there some plan to support BIG TCP for virtio-net/vhost-net?

--000000000000e769fc063de8faa7
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Is there some plan to support BIG TCP for virtio-net/vhost-net?</div>

--000000000000e769fc063de8faa7--

