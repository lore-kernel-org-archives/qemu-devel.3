Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A882DEA3F13
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpiZC-0008DL-WA; Tue, 10 Feb 2026 02:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpiZB-0008BU-GG
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:53:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpiZ9-00072r-Qx
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770710025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=R7eF2h9SbKKKgpeMskN78d2WwiTU1R/YQ1fH5t7CXXFRGnRbynVOMqvmrBsoXSyObXVbps
 Iekfmgi69TFZTO1UA2x+HbXtapSEvTH7/Cz0DP7WC74LgAojDBaNkzLWPg/sk5iXbaAC2g
 RK+lcOjqj6XJ34RHeg6W7akjxt62yfE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-0yQ-J6lsPaeE_Zl4BrZeeA-1; Tue, 10 Feb 2026 02:53:43 -0500
X-MC-Unique: 0yQ-J6lsPaeE_Zl4BrZeeA-1
X-Mimecast-MFC-AGG-ID: 0yQ-J6lsPaeE_Zl4BrZeeA_1770710023
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4803e8b6007so3655715e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 23:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770710022; x=1771314822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=NN22878IWQ44QfGhb88iad/YbvlcL+WiNvQCM3gihbBR1OYwdCNQXufdnifK+x0w7q
 cSg2k3UuQGbstSWAAb10RK73ZfEnsSDAbWHLRMrXyN3Lz2MhAnkF7ejAmw5sNYs5ykd1
 3yJtt2K32YM7wU7MPOsaYLzd3WRJ6BYdBCMqFZx43kl0F9a3gYOWZk0WZimXS2AQP4w+
 2dNSm9pjPr5vpZikjMQLAJw6dls/XN2ObVZy932VGgu9J2FBMQGOF980scfutUIywlVw
 bMGuav1BEWBrL3YPrQ0Vl7u5NGqO8p6QFgRGJJ9sFkt1aR6GVaigGig2MtVom+129/Ve
 vwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770710022; x=1771314822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DCuwYA+1a61nlmabrIiCD6UpSahktjsZYCN72Cpjs2f4E64yDHgXEng2QPl6CujXCl
 IPpKCyAVwnOGd9SiBooBEOLZTnvNVe9AQukVzScCp2MEhQFIArDukAuW28TwWhh+j9t+
 p6aNZrN3s/6pjj1ejYk0UUsMqZUtQniJXyX82SRIL7Scxg9CIB7YzjHmPF1RHP/5Esk2
 Aw8IVPTHm7/bx3HUx+2yY8kVRy12CgjGZG9I6HTz8jI02Ja1X1eQ/lufXP/f756HWiZZ
 tc++JfxzVjpoiBip6WWLXQR2zR73mLMHzTdim/j6xDsFCAkh0banoxJOP5NLT6Xl5J7P
 AINQ==
X-Gm-Message-State: AOJu0YzXyM1CfkUjzeXhzeynpADcBURzpm46oMR0aZG5m2U24VX/FNf/
 KDmulvUbv5Ml1c6Mf2jrqObiYZYAcxKUy7WrENeECn9NX6efXwQp6llYbqlmFoPPW2d1bjh54Ss
 HDd2zYrDBdnW3kNDNuYhNzV+TAP8fAkzF3vN9J3Uzj3LXCVvel34TqqpS
X-Gm-Gg: AZuq6aJeeosHzKp9aFb1eQxHI00fQlj0ySWrn8tze8/6R+O1BdAMDtrcues1VDE0t2/
 nJMmSw+WYULLp0JEhFYkISKe45V+82WS9zrtpmMekei0NKI9tmZ67FseJbMAMwtOBDv9dwwEa//
 +QM/mdz3Ex4javqRdyPyUtKdLHfwjdSBSB5BJrRYxAMWdlOcmTCdaKWrvApo2VA1O4z9B849XfU
 TMFyGBNumXJloff0ha150w0UBeGuvaC7qkwiwz5fs2jLbZ1KmGUf9EjJIy6zC5qjSqPIXTY+FL2
 Oyul7z2CvsFkxKc+GfFIOP5ZdgRZZae5kQPHkQogvG0Lu41jnUzO1bCI9+2DPgzwaL9qgK5ASJs
 VxH7IxSJBPpGhQxgD1lPkLm+rt1GjAgWQVtHE6IxPE4/1QD9bb5s6V9uWRuBe10+oARTUxniulI
 Qk6Ywh5AX7MdEqRHLFn5hOAh4ABA==
X-Received: by 2002:a05:600c:3509:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4832021604amr177044685e9.22.1770710022604; 
 Mon, 09 Feb 2026 23:53:42 -0800 (PST)
X-Received: by 2002:a05:600c:3509:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4832021604amr177044505e9.22.1770710022284; 
 Mon, 09 Feb 2026 23:53:42 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209e0857sm107816285e9.16.2026.02.09.23.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 23:53:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Chandan Somani <csomani@redhat.com>
Cc: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	marcandre.lureau@gmail.com
Subject: Re: [PATCH v2 0/5] qdev release function cleanups + unit test
Date: Tue, 10 Feb 2026 08:53:38 +0100
Message-ID: <20260210075338.858509-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108230311.584141-1-csomani@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


