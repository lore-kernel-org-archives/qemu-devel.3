Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE75FCFB440
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 23:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxaw2-000263-I3; Sun, 06 Oct 2024 19:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxavx-000234-FM
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:45:05 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxavt-00086T-Sg
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 19:45:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728258290; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kcvGgxtg3tyURfeAanBfRh7q6ZOrDS1NmHAtrxRjwc1gFPVpaGlAvtA3g6OIYdJIJhxDACaQ7J6b1jfMtRKTiOGA6r5utnp2OYuNTi33fEf5QrrSc+Z0+EPTFEnYt6WKuTRugK4TB0FF5m2xGWTtkJdiQGdMpn5n3lGpk9ICN1A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728258290;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Hgzra89aRG5wb9GfIp6fQ3qK1aK2bYiVyJwaD2dciVo=; 
 b=kGv6+Xd9fKRU8kJ4OdcKZgRDLOK80h+dEQ9DkV2EvBjtp2frUMb8EJ/l6b2YEWdqH8Gz4MprOFu6iLLBv7gWU1NQSAdalRiOVfM0yPDED10GiPoVGZeU1Bh0M2ebQOJXBwdk2WrdRybRUvUBG0Hp4v0Baou59uJ3NHQhaHzO2d0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728258290; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Hgzra89aRG5wb9GfIp6fQ3qK1aK2bYiVyJwaD2dciVo=;
 b=d/wxiPvy65I5LILraBbVDEmmB5isex0RIDeQPtXWMvu2R/6IErr2j1PWQLKj5mDQ
 2OKEpKCdTlig3aHNcSNAFiRX6plVAdEobcp/WsFN8SSWVQ8nALRWgQ/Leh3PcV38jA1
 9Atel+Dj9p4w8ZqNUleZhSnGZ6ZcB5bFv4EWyRw8=
Received: by mx.zohomail.com with SMTPS id 1728258288162848.9828603187702;
 Sun, 6 Oct 2024 16:44:48 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 0/2] GTK/SDL fixes for a black screen displayed by
 virtio-gpu
Date: Mon,  7 Oct 2024 02:43:51 +0300
Message-ID: <20241006234353.3201037-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This patchset fixes black screen displayed by Qemu using virtio-gpu.
There is a race condition bug with a timer that disables display output
after it has been enabled by virtio-gpu. The problem is reproducible
by running Qemu with a disabled GL vsync. Note vsync is disabled for
SDL display by default.

Dmitry Osipenko (2):
  ui/sdl2: Don't disable scanout when display is refreshed
  ui/gtk: Don't disable scanout when display is refreshed

 ui/gtk-egl.c     | 1 -
 ui/gtk-gl-area.c | 1 -
 ui/sdl2-gl.c     | 1 -
 3 files changed, 3 deletions(-)

-- 
2.46.0


