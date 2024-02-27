Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D019C54E51
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2VP-0006VR-Gl; Tue, 27 Feb 2024 13:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VN-0006U3-62
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:41 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VL-0001SJ-J6
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:40 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6e4b03f0903so333957a34.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059717; x=1709664517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e9+eTESZCMSFYJ8iDTWx5tX4AIfT8tMIe2dsYwY0Y98=;
 b=D6FFqtGUTmZOtYIH01UsW1J5kUk1pF/+ps3mUYxeCsZGODUPHb9huAVIH3+rmcQYCE
 6eS0zHcHNiB4CLO2AUlL/T5x80nwoFn/56+/N9e/RsPp7qfOX+cLQM0tatXKktcXobdn
 X2Jci+9pPRGSm7h6y9ErxWhESCc7qGUGxSc6PM/ZMQGPBXbbYtBoWkHp+xSM/ZclCSaQ
 ITUTz3AgN1CgR/N0y//WYtVJhvXIVLHnPcS1GcoiJ8kHfTWw5OTqtVTaFs/Qe66qB4PA
 vsii0DUjmUS6BvEZZM4kOAlWwUOh+byajXGjIBv2BGVTNkDB0DHHS305KNXRQ/KW3in4
 NNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059717; x=1709664517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e9+eTESZCMSFYJ8iDTWx5tX4AIfT8tMIe2dsYwY0Y98=;
 b=wjEXluAL55NcBMVBEvcFjSnPIDsRPCU8304tkLSJV1Gxxss8I8Ci8vWpB7Mh3GFHQ9
 raC8M/RlPg+uT/+U6zzx732oIAaBaNMUq+32AOZpCvLCwB/gfdhs8Hqify8qj7pLhIdh
 169Ihq8lhVaWimB3FV4uVY7/emYFBbLLTldIEFJlizbShBjCCIbN87zwDWR9YNyI0Gix
 VYiIkij3jk7P/9RuCYUL9XVc8elBxqvMP9seuG1KwFhippeZxAnRti0J7RLdxrs6Z64f
 uiU6bHy1li85mq03bYMWu4ddGdsH0qORzKef/nfUcPkpxp0TKHUokXjl+luqYwbKDLoB
 p9Xw==
X-Gm-Message-State: AOJu0Yw6bXge5n4SwFwrDDhIG2OjA3dBFCxSyRJiJlMx3be5KVek382/
 K4S6/vy7Fobsk5DJFrnPKQa0kaFDfRdksB57Cv02X9krqDbJ4SZTnGz4V+1a8IPd0SLjYcyAIOj
 2
X-Google-Smtp-Source: AGHT+IHsKY+BBkSh65E4ZG5d6LKa5HugdlTLKKO+/iIxi/8PBlSAxA6nP5+AParvG4/MlYNBbGibZw==
X-Received: by 2002:a05:6830:3495:b0:6e4:971d:942d with SMTP id
 c21-20020a056830349500b006e4971d942dmr9351352otu.3.1709059717106; 
 Tue, 27 Feb 2024 10:48:37 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 00/14] linux-user: Rewrite core dump
Date: Tue, 27 Feb 2024 08:48:19 -1000
Message-Id: <20240227184833.193836-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This started simply to remove the two page[TARGET_PAGE_SIZE] instances.
These turn into variable length arrays, when I start to allow the page
size to vary for linux-user.

However, the first thing I noticed is that it is silly to write out
target memory to the corefile page by page.  As I started to clean
that up, I noticed some actual errors in the writing of notes.

Finally, we can stop creating local data structures to represent vmas
and rely on the ones over in user-exec.c.


r~


Richard Henderson (14):
  linux-user/elfload: Disable core dump if getrlimit fails
  linux-user/elfload: Merge init_note_info and fill_note_info
  linux-user/elfload: Tidy fill_note_info and struct elf_note_info
  linux-user/elfload: Stack allocate struct mm_struct
  linux-user/elfload: Latch errno before cleanup in elf_core_dump
  linux-user/elfload: Open core file after vma_init
  linux-user/elfload: Truncate core file on open
  linux-user/elfload: Lock cpu list and mmap during elf_core_dump
  linux-user/elfload: Size corefile before opening
  linux-user/elfload: Write corefile elf header in one block
  linux-user/elfload: Write process memory to core file in larger chunks
  linux-user/elfload: Simplify vma_dump_size
  linux-user/elfload: Rely on walk_memory_regions for vmas
  linux-user/elfload: Unprotect regions before core dump

 linux-user/elfload.c | 721 +++++++++++++------------------------------
 1 file changed, 221 insertions(+), 500 deletions(-)

-- 
2.34.1


