Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CE3C5B543
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 04:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLahX-0006wv-6I; Sun, 01 Jun 2025 00:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uLahT-0006wl-1d
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 00:53:35 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1uLahR-0002OS-Ba
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 00:53:34 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-742b614581dso3277911b3a.3
 for <qemu-devel@nongnu.org>; Sat, 31 May 2025 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748753611; x=1749358411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7GbGhbOB9H5NAdBvfDjuhX87lr92sjRsdqTZVxVH9jg=;
 b=lIuLPa3C/6MIjw4KwbbB66U+KZZl0rqzIr9MiDIjzb1CHK0Fx9qrAI2RV8yGDiB5Ok
 EKp1B66PCmZ9iXTmZN39BFWb25ub0uvhngvQDg7g+HMoUL9iPCTdigZ7oZqdYsi6S6o2
 hMwFw0/SCDRBxmmyvxxeHFUSaHKvQS2a0uZddY0S5KkZ9gQNEGnDzdNqmedQ0TdjAH3c
 H5mZJhBlT5/mxSrsorzeBP21YViwQ6rYOU5nldeuzcFTHrW33QQodMHCKORJaCI5a31H
 PGnWcs5lPIz9CiIaiuozsgcUosr8WKfRnMAh59/6idqwxjx0EaXRWLmaEv5iA+cKEBUr
 qbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748753611; x=1749358411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GbGhbOB9H5NAdBvfDjuhX87lr92sjRsdqTZVxVH9jg=;
 b=UvhCxWXll7ZnS3EmRuqFa4JpEt64LbTC5BdFrypMqy4n9I8XU01fRz8f7n7Ghuqn75
 Z+IcGP81zjIZZcxgZDKjZTfkE0N9nHKoET0FEPJSmRkd8psuiJow6tenPU/7elgPTSkt
 6ppojFHeFnMW2fHBJDRZ8IStH6KtxTq3DQLIik6wLj5SAmCMZiA1QF17zGNH2Ow9RCy1
 XsJAZyEzh9aYQT1jTYSI/5LHo7VW4DMaQTyIQBE0cjxgri5fm1VCyERXR/XTJl2eoxee
 EKwycaB/HZOR4nceBG//8IaUA8agW7tUEtHyjG/WwuKfNtYQHSjKpc0Mh75b2b+qxO5Z
 5NeQ==
X-Gm-Message-State: AOJu0Yza3dBZu1yxcCpc+CIJA8KfmrrvhUUPNLK7dvSqDFAV9kYTE1lG
 Lnlfsl8mr/nX1l7ZmP++zowUz79hlMarZz4X/taNN+tuzO1zodg/f7zqpG5b7kYABbg=
X-Gm-Gg: ASbGncsgK+NYKj5+qQj/iyHfalxvuob0hEF6pzA4QrI//oFOYilbcqoSP1PMQflOrZ1
 ZpitWf2AjHWdiCgB8moR/zQ6dr8jdkP6PN8UBYPXnHADGjMcCYAfy55YMJGMWXd8Qaj7rlNvsFK
 9/3iU1Lpn3VPs9AeEz3+xQTeD8xszaP4HW9l4BaDvyR3n9xyQDNcgugG325AKZro9d6lzofdzOs
 bI2W9VS2rnb8QZ86jVmdaztE9iDbkdTmZPwGFd6OhIOJUV2dKv2opxiU5MWbjiMinjoeZbh5BtG
 0s/Ugp+cnEwcUa+AtYob9W6xkUUAn5oYGlEEBl91gOCHSOPZRWw5dSJ+N2kY3xK26A==
X-Google-Smtp-Source: AGHT+IG6BqKrFk60UsQ2rIHh6QvSQwPacRNURC8C9dAHkp3Rkc+Kfe67kRoH82Hd5fz3jXY7SGb8tg==
X-Received: by 2002:aa7:8881:0:b0:73e:598:7e5b with SMTP id
 d2e1a72fcca58-747c1a1f6e6mr9836271b3a.1.1748753610928; 
 Sat, 31 May 2025 21:53:30 -0700 (PDT)
Received: from localhost ([103.192.227.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747affd4425sm5565793b3a.147.2025.05.31.21.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 21:53:30 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] ui/gtk: Add keep-aspect-ratio and scale option
Date: Sun,  1 Jun 2025 12:52:31 +0800
Message-ID: <20250601045245.36778-1-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x434.google.com
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

Add these options to give users more control over behaviors in gtk
display backend:

- keep-aspect-ratio: when set to true, if the aspect ratio of host
  window differs from that of guest frame-buffer, padding will be added
  to the host window to preserve the aspect ratio of guest frame-buffer.

- scale: allow user to set a preferred scale factor, which would be
  helpful for users running on a hi-dpi desktop to achieve pixel to
  pixel display.

Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@gmail.com>
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Best regards,
Weifeng

Weifeng Liu (2):
  ui/gtk: Add keep-aspect-ratio option
  ui/gtk: Add scale option

 include/ui/gtk.h |  2 ++
 qapi/ui.json     | 15 +++++++++----
 ui/gtk.c         | 58 ++++++++++++++++++++++++++++++++----------------
 3 files changed, 52 insertions(+), 23 deletions(-)

-- 
2.49.0


