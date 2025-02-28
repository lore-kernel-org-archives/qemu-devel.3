Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0A2C282D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4TB-0007VI-B8; Fri, 28 Feb 2025 12:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to4T3-0007JL-40
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:48:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to4T0-0005MA-NW
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:48:08 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43996e95114so17171925e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740764885; x=1741369685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I40sF1i9jFqYAyQf3qwE84BFM4SpyXkD56Y42KHQEPA=;
 b=SksizvwqlRoRwCX8PRqUlKl/Jr52kAaUnd4MGP/w7BGs4m8lQmHKuGK5uSOIxKiBDt
 Km3u3BB5YeRhg9moub0Heiluehg0zMpJ+ct9nvV9WAfEhIGfB7qImF/VxJ/MOXI4NKdH
 NqLIvExsJl2DPNxjbnBsCDsPZMLPLA9jZRVKR8BcNphxGQll+EGy6SyViplkOT39SCRx
 lProSni4Ann0R46dgFijyVmegtEnS8Woy8LHsrJnedFNO15GEmImvdSHhhlWJsYw6Ft7
 nD65hvCgwROd6UkNipzkN4Me/eijuQVrYcYPdhlXBxTOoDi5r4+Eff/MVUm3v4ojSmB9
 JdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740764885; x=1741369685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I40sF1i9jFqYAyQf3qwE84BFM4SpyXkD56Y42KHQEPA=;
 b=gculOVGnuQxwWUYT7aIKn6aeOWAV0iBq/q9A6ea3C4DZZlnsA6lRHnfIjshKKvmX5p
 A0uQOSBjY3nXGvUgCxt9utEVp+0bMc/BV4VLFSPb4VbLXoT1LnEdX0CTpi58gmC4fc1i
 8+u6ASw1nuTUXHFclSrEJxPj13DOZGhVmJ1Oc1oHA6lE0VmWudM0bmQfgdu8zbTXwbi5
 XyOIJO1sk6knqgB0Fad4QRH3HbttHmG4Q5MHLr1xNNrz1UV1GFpWajF8QMIIICaTUEl3
 eLtcJZuVkriLjmyuIiBMr6n3qWhit3rr4H0BAaMgQmSnVEtoQ8TgahGAKkJ/7B4GFPmX
 rHeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGkf0aKMpZQH+SMs0MF5tkfyf2cmZWWn0fz0LvtaIRBMOa8DZwcJDnHanehSBSWSi7dppzlDRnb91D@nongnu.org
X-Gm-Message-State: AOJu0YxEUT9KWMYdQbXMEAHoxwM+aJ7oXJ4bs/mG3IOxnu/vmaV2tAKU
 fSTguHypetaodhaZACuk541JfRLe5eLDmKK0biT+/G7hPTmbjmrTAZS+hlh7hEA=
X-Gm-Gg: ASbGncvZgAj/vDlEXxymRxahvc/tUy6cIXdoWJg9jeLyika1Cx4PLayMo5VH3Rg7vKX
 dmKLeN8ek0ijOgiOt12zaJFURB9TSfL8UVIxF2XkK5b/iVYRpBi6RFYayqJn3ar6Al4CU1d8GjW
 MwK2bkPvayIcgBx20gp9t+DAb9biLI9/WZ689YYeDX+i4AB7RY7FJOQI722EmTBbxUuDgZKTk49
 NWjyM6F0mkz/1ePT0nQW05jpDxSwaB2aax1cVkPzJDdr2LhpCDL+qZqoLc/HnOpQT7jbhFVX0eK
 4H/9XrDo0jQSa9ZwB7i7t5ady2xWUKeY
X-Google-Smtp-Source: AGHT+IGZn+6aMBeY3H7i3KP/BqADJlQ+4TA2TrEyEWeq7n9EdewanyRXHEDqk9dtTdRwLSQtJkJfBQ==
X-Received: by 2002:a05:6000:1447:b0:390:e904:63de with SMTP id
 ffacd0b85a97d-390ec7cda50mr3633989f8f.20.1740764884491; 
 Fri, 28 Feb 2025 09:48:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795da5sm5979556f8f.15.2025.02.28.09.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 09:48:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/3] hw/net/smc91c111: Fix potential array overflows
Date: Fri, 28 Feb 2025 17:47:58 +0000
Message-ID: <20250228174802.1945417-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

This patchset fixes some potential array overflows in the
smc91c111 ethernet device model, including the one found in
https://gitlab.com/qemu-project/qemu/-/issues/2742

There are two classes of bugs:
 * we accept packet numbers from the guest, but we were not
   validating that they were in range before using them as an
   index into the data[][] array
 * we didn't sanitize the length field read from the data
   frame on tx before using it as an index to find the
   control byte at the end of the frame, so we could read off
   the end of the buffer

This patchset fixes both of these. The datasheet is sadly
silent on the h/w behaviour for these errors, so I opted to
LOG_GUEST_ERROR and silently ignore the invalid operations.

Patch 3 tidies up the existing code to use a constant defined
in patch 2; I put it last so we can cc the first two patches
to stable without having to also backport that patch.

thanks
-- PMM

Peter Maydell (3):
  hw/net/smc91c111: Sanitize packet numbers
  hw/net/smc91c111: Sanitize packet length on tx
  hw/net/smc91c111: Use MAX_PACKET_SIZE instead of magic numbers

 hw/net/smc91c111.c | 87 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 8 deletions(-)

-- 
2.43.0


