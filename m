Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5345C48285
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 07:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTzOK-00037n-Kj; Sun, 28 Jan 2024 02:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rTzOF-000367-Qy
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 02:15:40 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rTzOD-0004AK-IU
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 02:15:39 -0500
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7bfe5aa702fso27525239f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 23:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706426132; x=1707030932;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wMk2Dn5lu3F9Qa7EJOP18lOhECpVX5h3SFHTrT99Ous=;
 b=DM/C7ONF3TvP8OYBNXZ7d7QWrihAwYE5EJLCcfZQDye7Q0vEFnNTjEdvJDKYffmacB
 +r8Ss+31rI2OifaIzcpSztPtjLe+yp4AU4uMM/72J5EaouVRUQ9yOtd2pTNdZwMzqfsY
 FqZA98gpmRFexEWKNWDfHDLjj5z2cjdsvFlnf7TyNftco6D4M2P0c1GyPdGd9AiAMmO3
 Wy9z8FySQzh3b2V4fMRXKl6GtApIZdfpx2hNzctzXU0wggGsvOF7KWn6ET49iiiIWP6J
 v3O9PJB7cpwrEYjdYQtyWfna9qWAWFed06qaspmcP1nYsaLcsJeLaC7tjpHYBDOhRYNI
 uV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706426132; x=1707030932;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMk2Dn5lu3F9Qa7EJOP18lOhECpVX5h3SFHTrT99Ous=;
 b=bfvoY/cD7eeScFnn5x+BbT8r9RekqsxCmF5oF1+Az/zncqzL3loxgusZDfVDLbtgaH
 e0aTYmXVfK7/TCHWV4YkM5w7AH3egGw4SDDBJOQiWOHEoItgFOzfuJM38/mUrQg8b+oy
 Ljq5KUhzltWoH2o8KOAvTJfhBtllw1eHr6u0RkAoguvKdBteEOocTbRdX0C004QHZpIh
 2mgPEX1FYy3RHVkBXzqKUJp9y9EHXJ80WJbxRH8/jWHiNqHLiSpZkg96AYoNLzXRlW8D
 +Iry5jq76BPjpuo/z6t9b22KcTZs/XTCXxOO/sw9DBlL3RxTuWv3uBcWy1pDRrd6lE4o
 Rl1w==
X-Gm-Message-State: AOJu0YzpvQAyMjXICSybxRNhvRzmpEu63zmqYd9Fx8wn2SHNO8/hPeer
 BCeLSVqPgIXNFqO4Amf27xdBT2TUl0vy8GaO3syFNBMnUKTtWg8CzwmDzopqjtg=
X-Google-Smtp-Source: AGHT+IHQQo0AhH3bBVxNhcrJpMy7N2/PQInijOqWNbkRBfYHb48CHSskOlkwjXLptFSxXCG2N/5EEQ==
X-Received: by 2002:a05:6e02:12c7:b0:363:7b5e:1378 with SMTP id
 i7-20020a056e0212c700b003637b5e1378mr1084080ilm.31.1706426132016; 
 Sat, 27 Jan 2024 23:15:32 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 by36-20020a056a0205a400b005ceb4a6d72bsm3106667pgb.65.2024.01.27.23.15.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 23:15:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] hw/smbios: Fix option validation
Date: Sun, 28 Jan 2024 16:15:27 +0900
Message-Id: <20240128-smbios-v1-0-c3a50499baea@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA//tWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyML3eLcpMz8Yt2kVNNkYyPDFHNDUwsloOKCotS0zAqwQdGxtbUAftx
 9iVgAAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This fixes qemu_smbios_type8_opts and qemu_smbios_type11_opts to have
list terminators and elements for the type option.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      hw/smbios: Fix OEM strings table option validation
      hw/smbios: Fix port connector option validation

 hw/smbios/smbios.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)
---
base-commit: f614acb7450282a119d85d759f27eae190476058
change-id: 20240128-smbios-be5c321d7158

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


