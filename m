Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9E1C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPLw-00067W-56; Tue, 05 Mar 2024 02:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLl-00066z-6s
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:33 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLi-0005q1-MW
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:32 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6e4da29904eso1265500a34.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624189; x=1710228989;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KgfzL5pYJep5A/2NXQ0zRVwGA2UigqjRkReHdGdJul4=;
 b=1Swr4Z0D2pv/wEYx8FAQg37sLfQXeQmSccN7pme7eh/M8+oStU5FO+1gJbL/z9/iFl
 NsfkHZC+9Ch5IJT7lnLrLbk2BXwLWzr2FhF89Q03q2ZFozhLL54/Wcan+cyiQCLOAkoO
 P4djOkJcYYmRZv6O9XyVKErf8dHAED4gFxDob1GSlt01ULMaChZCAFy/CAQZ3hHRNHBZ
 /gKmhKQ9hgYaJu4VNUDpeZLiFzIVtTzBF3onN2EN7pCyb541gDzMz3dor59V6PTXYQ3V
 RCE4/yFU2+3kaBH0/QYTn1325q0/fcy2AVqGmlaSUNpQNoDvMEcjyuvisHLQI7f7bM//
 OfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624189; x=1710228989;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgfzL5pYJep5A/2NXQ0zRVwGA2UigqjRkReHdGdJul4=;
 b=m+XCSJJEUhz0HpYV0riTwJMFwazqQCZhBZbtm792da6oRISXdjn3+S3StEMpVLnDyE
 6bJwZwp1zTTHNmHJspu9/I7kHmIJ827yneH7cc3BWJeXaX4PgorWHdXHLsfZI0EOhq/y
 grE6ssjjO/i33QTPHdxgSU+kEtOxXWaRL+cMWt+s0IagG7QamT7vaexmmj+GvNKr203A
 Sg2IBqkbyUVmN89AapydVqtHBq/4tnIXAXahsKHK5C3m4GlJfCj/mi3UG2QS9WnjamhP
 kwqqe2XSTXLbXOTy4/aM/qRpXHoVCMrgW3oRkbhBAU/DG1T86ZWbAAw78yhJZWA/DSNJ
 DjmQ==
X-Gm-Message-State: AOJu0YzFZZ6p9NDU7+bgyTE51vBv118iA7edT9g4PRFIEelkV2xCIeGm
 Mz2difsAE5GFb1+1Voj+VVfGT5FKsT6/eekhprffB/ilC0Zpo61bdOXPKcE6jzJNaoIGabxtTAF
 l
X-Google-Smtp-Source: AGHT+IGs3uutnmc+1044oxQvowwRwIfomNSr+2vFTI8pHKjNy/HEfp0GfYK1IEcjLOgm0EGMiz30+Q==
X-Received: by 2002:a9d:7dcb:0:b0:6e4:dede:37e8 with SMTP id
 k11-20020a9d7dcb000000b006e4dede37e8mr1150768otn.23.1709624188767; 
 Mon, 04 Mar 2024 23:36:28 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 h11-20020a63210b000000b005e2b0671987sm8437648pgh.51.2024.03.04.23.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:28 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 00/13] contrib/elf2dmp: Improve robustness
Date: Tue, 05 Mar 2024 16:36:17 +0900
Message-Id: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHL5mUC/z3MSwrCMBSF4a2UOzaSRxvUUfchHcTmxl6wSUkkt
 JTs3VjQ4X84fDskjIQJbs0OETMlCr6GPDUwTsY/kZGtDZLLlisuGL6ctPPChNGm64S7aK2gvpe
 IjtZDug+1J0rvELcDzuK7/gz1N7JgnD3QaN1eHSrUvTWbp/U8hhmGUsoHA4E6b58AAAA=
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x329.google.com
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

elf2dmp sometimes fails to work with partially corrupted dumps, and also
emits warnings when sanitizers are in use. This series are collections
of changes to improve the situation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Added patch "contrib/elf2dmp: Remove unnecessary err flags".
- Added patch "contrib/elf2dmp: Assume error by default".
- Added patch "contrib/elf2dmp: Conform to the error reporting pattern".
- Added patch "contrib/elf2dmp: Build only for little endian host".
- Added patch "contrib/elf2dmp: Use GPtrArray".
- Added patch "contrib/elf2dmp: Clamp QEMU note to file size".
- Changed error handling in patch "contrib/elf2dmp: Ensure segment fits
  in file" (Peter Maydell)
- Added a comment to fill_context() that it continues on failure.
  (Peter Maydell)
- Link to v1: https://lore.kernel.org/r/20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com

---
Akihiko Odaki (13):
      contrib/elf2dmp: Remove unnecessary err flags
      contrib/elf2dmp: Assume error by default
      contrib/elf2dmp: Continue even contexts are lacking
      contrib/elf2dmp: Conform to the error reporting pattern
      contrib/elf2dmp: Always check for PA resolution failure
      contrib/elf2dmp: Always destroy PA space
      contrib/elf2dmp: Ensure segment fits in file
      contrib/elf2dmp: Use lduw_le_p() to read PDB
      contrib/elf2dmp: Use rol64() to decode
      MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
      contrib/elf2dmp: Build only for little endian host
      contrib/elf2dmp: Use GPtrArray
      contrib/elf2dmp: Clamp QEMU note to file size

 MAINTAINERS                 |   1 +
 contrib/elf2dmp/addrspace.h |   6 +-
 contrib/elf2dmp/download.h  |   2 +-
 contrib/elf2dmp/pdb.h       |   2 +-
 contrib/elf2dmp/qemu_elf.h  |   2 +-
 contrib/elf2dmp/addrspace.c |  63 ++++++++++--------
 contrib/elf2dmp/download.c  |  12 ++--
 contrib/elf2dmp/main.c      | 159 ++++++++++++++++++++------------------------
 contrib/elf2dmp/pdb.c       |  61 ++++++++---------
 contrib/elf2dmp/qemu_elf.c  | 142 +++++++++++++++++++++------------------
 contrib/elf2dmp/meson.build |   2 +-
 11 files changed, 226 insertions(+), 226 deletions(-)
---
base-commit: bfe8020c814a30479a4241aaa78b63960655962b
change-id: 20240301-elf2dmp-1a6a551f8663

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


