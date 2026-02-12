Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668A8EE36B0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqahE-00086O-00; Thu, 12 Feb 2026 12:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vqahB-00085d-LU
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:41:41 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vqah9-0002TK-Va
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:41:41 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-40ee8b4f925so38870fac.3
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard.net; s=google; t=1770918097; x=1771522897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IploKCCuobBhDWor/1HNfTvVN7xQb8VE0fChRXGQFpI=;
 b=Pwl8At/vQoYEstBK6aJegy/YHSXo91pMeRFSFsUgs5uREkvUJ6W96h//8O8T0eWLPs
 kKhVNz/h0lTcQghia7Jt0qQvD54KzodI0BgW7GH6MtX/PrIAvKFFaq2hDiyhbbt+mcZH
 bOhASY2Rs2p/qB8X/mUSvLbBgiI+eCtC+F83J24Gti8SbIdYxft7Tf6waK3bUIhVa7D6
 wxtlQsueeZL4O2EnqvRtxj++6PN9a4IKftZ7JZrXovXhljPj49t1eqKAyJK5QUIxNihH
 mrKzek1ra/82KY4N792om4Ot2PyAqwHwOmRF3a3DTP1XMRR6yYH7kdNjQ+TJTdd3x2t0
 i9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770918097; x=1771522897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IploKCCuobBhDWor/1HNfTvVN7xQb8VE0fChRXGQFpI=;
 b=QmbfeARSV0TZxFmm24XK0IIbeCb9pYLXXJjLJS5iWin0H1rLd+n7Y3jEPOEnqDmtMS
 5VRRNNUgPWHF0KKr1Mnq+zXsuh8HoQyTGyxOIjWwcuSlHSD00Rvs4i7N137di3DzyA59
 Nz++v70bDE4AWPvZaoRdW7pZVSBNh1s+AIRKqMqzN0cO2c18vIT5GYTRjLbUL1m2zTdk
 FjLGXxvznN3HVkUkk2qAG+EfucZnOvYXqtSzpMh1dhvZ6sUdISlNh/7vhHk6kTsfwK7v
 uxsTQ+Og6N2nwHAOiNZ8ttONqYGaBrJNMQb6pZvmjMJ81J21Nm0GY/xDB/UCTImEu7e7
 29kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWHgntP9zMxb6r8eGN8/i05H1yeayaviLwiCDS0ouwOskf2P8DomJnONJGyo2VxJoRSgumq+qljpxb@nongnu.org
X-Gm-Message-State: AOJu0Yxmlr+M7KytFncW3wFgs/W2TqtdMM5j1FtPAw4Zos01oTV9s4zf
 Ed6CZpmEk+t9IGqP3U/thOA9WoVqWq6FzfHx3FJ9eAabVYHRRmIXDtmWx+bLlbgdFBc=
X-Gm-Gg: AZuq6aK6NvD9S5G6zuEjuYjuE7gvvqR/KsdBPJKzWVkpbyGFBeRz046lvt7jueubeEf
 x7wpR8Fyjjx+riVjuf60ClX3e32f0lmObFiq1YaxNM9AlXc3B6+eo+YNeY/uaQlMGiXlxwUR+fd
 u9WWtLYn8WUlD7nOcPUaps3t5pMo2urBMwgTYkxlziVKHBxACMW9NF7iaZAE+HCZmlmNqOYisco
 EBImZLMiTgCbyFuxhtlug9r1pM6XVpCSgkRWKLcsuFh17p8+YDOtNcn3p7NedL15wLCXbrrGltF
 Oto/8Wimg/2323TPvNH3rVaHnPssCB16E+vzZVbJSIeiukbd0dDKli3ht/+KEXfd51/+DraFxKk
 +wQVTkMFTahYGgmI0qfhiv9fG6fnuEkOYhhhdLeBJfU8Dc66mkIz8x+vwqJrMHiUl6NynL9FyuB
 Ld/2XQ0i+EQD0uDx6WW4ro2YN7Ixo0EUPk4DkTmP5V6kdFGr82BTKOPJMsQ63f1F+FL+EFwKscW
 3SrhA==
X-Received: by 2002:a05:6871:520e:b0:3ec:2fc8:97a2 with SMTP id
 586e51a60fabf-40eca08aa2emr1500957fac.19.1770918097454; 
 Thu, 12 Feb 2026 09:41:37 -0800 (PST)
Received: from localhost ([2001:470:b8f6:1b:ac4f:9c7a:97e9:f745])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-40ee62b6f61sm423253fac.10.2026.02.12.09.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 09:41:36 -0800 (PST)
From: Corey Minyard <corey@minyard.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Corey Minyard <corey@minyard.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Yunpeng Yang <yunpeng.yang@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
Subject: [PULL 0/2] Add a fake IPMI LAN channel
Date: Thu, 12 Feb 2026 11:40:48 -0600
Message-ID: <20260212174103.504520-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=corey@minyard.net; helo=mail-oa1-x36.google.com
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

Apologies for not sending this in the right format.  Hopefully this is
correct.

The following changes since commit 159107e390609f71b78268a4888563dcdce6ac65:

  Merge tag 'pull-hex-20260102' of https://github.com/quic/qemu into staging (2026-01-05 07:35:40 +1100)

are available in the Git repository at:

  https://github.com/cminyard/qemu.git tags/ipmi-add-fake-lan-config

for you to fetch changes up to 75c15651af1b2553ff292553545f7a6a56c32932:

  hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config (2026-01-05 13:07:23 -0600)

----------------------------------------------------------------
Add a fake LAN config operation for testing

Just add the commands, the proper data that can be set, and some tests.

Submitter ran migration test.

----------------------------------------------------------------
Yunpeng Yang (2):
      hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel config
      hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel config

 hw/ipmi/ipmi_bmc_sim.c      | 412 +++++++++++++++++++++++++++++++++++++++++++--
 include/hw/ipmi/ipmi.h      |   1 +
 qemu-options.hx             |  26 +++
 tests/qtest/ipmi-kcs-test.c | 143 ++++++++++++++++
 4 files changed, 572 insertions(+), 10 deletions(-)

