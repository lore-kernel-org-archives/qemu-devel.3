Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E48DFF8871
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSEz-0005ZW-La; Mon, 27 Apr 2026 16:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHSEK-0005U3-Qj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:06:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHSEI-00058G-34
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:06:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so181005175e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777320412; x=1777925212; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bF8gr4QyMcKuzR0D27aXlhf/i+eyndlpKkTT6jnhiHY=;
 b=szbDgQCB53SW/wKtb5PA/LAc/MV3xsJ6KWD3ERvN52xB5fsw1aLHG+QSib89jX4fBm
 te3XlP9eveOXsvV+hLelhohOxUQLe15UYEINiWq2nw570Xf9PS1pq5J8+vylWGO+FvoA
 5KzS9R3DChlVxfkTrDW6D2q1+M++OHqMNAhMWyz+lqNHAZoxekQCPaufi9GhDuA86Mo3
 YPsnnI0ttcUP8BXURlHK1FqWrnjAPnBh+pyMTWYlGk3wXEMWdbS2dH+vCPcBzFg3iV0l
 FkDo+DbM4AsQVY392+yxoI11ggoC7rl2V1JVfmsw4wFzNIm2qF4fW/bQGkHRpy0iqDg4
 nRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777320412; x=1777925212;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bF8gr4QyMcKuzR0D27aXlhf/i+eyndlpKkTT6jnhiHY=;
 b=Dj0pJLBIvK3FaKGpUecp+BsQT51CI5nMpTshX11Miel/K0aX10bGrwkj2cmNGH1s0+
 3WmylVejUaEiI3XVrgwZmw2kQebAyXajFRUIQ6Kxc4+iPQQV8oSYVvubN86fes8K5Iv5
 MGhNo6eU51uBQo1ncz4g9ykhgRc9PGU5oW9jij8C0xPHYmzTShCHnCaPSrU3NSO5auIk
 UWEyU1SbM2nBBlcq4A2Jqh7aPMLNM0mo9oUBhKrhcXaN3F+/CucJxBnYgC9cnO5PUnIm
 hQfpVa/Cwxf1SNAlg5a4ez3YoqIn8T5MsXyx2PxeYp9tPxhd+UHPXV8XulB0TIrPF2fn
 n2Sg==
X-Gm-Message-State: AOJu0YxBYJAb6CEvAFdkVzsBW95KAmt7fxTw02ji2JWA8drW2kk3yV8j
 X6LT664BC7w7unRZSIz8K7JavotsI9eSeBZYzhXoYY0yxHRgDe0iyl09
X-Gm-Gg: AeBDiespBdqlWpAGGDZAoxF6J9B/ZBuTEZSlaClCUhye6aPnGTQRjYb6kBp+gNlPcdz
 Ck6kpq1hDOw3aU0sr7SdTg+DlbrLDA2h7V3g52SK03O0T9WqCnWBLlvNWKRiv2jT76oP3Pto+t2
 nUH57lSlFmh1vMWbaL+NtpRnLLK8k6G4t48EceKSoms9gqWsIUHHQosNsM0tR2JaJFJhbZWmr8Q
 AUcZ32Up/aIVbTR2bWg8/xTdy3m4slpzrPrb16dtVNa4G7XaF/7xdjYn5Fid8HK9yAgrZhP4XUU
 ToS0TUasWQq2RnJnEHOujtyZi3aPby5LhPGLbIGDK/jedgQVtbiEv8LlZTHONQ1t/cBNsBGiwxX
 vADJvWsNuwZhVw7KZWxtL22QyqPCuWiL8dt/i6cxUh/ynErEGO1QBSSFiV+/hkTmvhIqbx9Xxon
 f9aOrlH4mxbdWOrcxT2izy04LLqB1PZ3N+OWt7oGQ=
X-Received: by 2002:a05:600c:c491:b0:48a:65a5:750f with SMTP id
 5b1f17b1804b1-48a77b19ecemr1643455e9.21.1777320411528; 
 Mon, 27 Apr 2026 13:06:51 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773efe38sm12767755e9.13.2026.04.27.13.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 13:06:51 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Subject: [PATCH v5 0/2] Fix and re-enable GTK clipboard
Date: Mon, 27 Apr 2026 22:06:42 +0200
Message-Id: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANLB72kC/33OSw6CMBSF4a2Yjq3pgxauI/dhHJQ+oBEoKYRoC
 Hu3MCIYHZ4m3387o8FGbwd0Pc0o2skPPnRpiPMJ6Vp1lcXepI0YYZJkTOBqfGLd+L4MKhrsjAM
 wJeVKE5RMH63zr613f6Rd+2EM8b3lJ7q+/ipNFBMsSwNgc1JYmt2qVvnmokOL1tLE/mqWdEmgc
 Fw7CVofNd9redQ8aQJCCKWsUfzrdrbX+VFnSdNcqvR3CsDpXi/L8gFx8zJUZAEAAA==
X-Change-ID: 20260425-gtk-clipboard-fdf99db13ac0
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x32c.google.com
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

The following patches change blocking clipboard retrieval function
calls in gtk-clipboard.c to non-blocking variants using callbacks to
avoid UI lockup. It is a follow-up to the patch proposed in the GitLab
issue

https://gitlab.com/qemu-project/qemu/-/work_items/1150

This version adds a similar change to gd_clipboard_request that also
uses the blocking clipboard API.

The second patch removes the gtk-clipboard compile flag, keeping the
GTK clipboard always compiled in. By default, clipboard is off,
can be enabled by -display gtk,clipboard=on .

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
Changes in v5:
- Runtime option added, clipboard still off by default
- Link to v4: https://lore.kernel.org/qemu-devel/20260427-gtk-clipboard-v4-0-176ad9919931@gmail.com

Changes in v4:
- Replace gtk_clipboard_request_contents with
  gtk_clipboard_request_targets which can utilize GTK's target cache
- Link to v3: https://lore.kernel.org/qemu-devel/20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com

Changes in v3:
- Use gtk_clipboard_request_contents to avoid text conversion
  when we only need to check if the text is available.
- Link to v2: https://lore.kernel.org/qemu-devel/20260425-gtk-clipboard-v2-0-b098f3cf69cc@gmail.com

Changes in v2:
- Removed forgotten gtk-clipboard comment in meson_options.txt
- Link to v1: https://lore.kernel.org/qemu-devel/20260425-gtk-clipboard-v1-0-6bd99e708e14@gmail.com

---
Jindřich Makovička (2):
      ui/gtk: Use non-blocking clipboard retrieval
      ui/gtk: Turn clipboard flag into runtime option

 meson.build        |  4 ----
 meson_options.txt  |  7 -------
 qapi/ui.json       |  6 +++++-
 qemu-options.hx    |  9 ++++++---
 ui/gtk-clipboard.c | 53 ++++++++++++++++++++++++++++++++++++++++-------------
 ui/gtk.c           |  8 +++++---
 ui/meson.build     |  4 +---
 7 files changed, 57 insertions(+), 34 deletions(-)
---
base-commit: aa15257174da180c6a8a9d58f87319cfe61c5520
change-id: 20260425-gtk-clipboard-fdf99db13ac0

Best regards,
-- 
Jindrich Makovicka


