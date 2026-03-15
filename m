Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDB4F30283
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ruO-0006Os-8E; Sun, 15 Mar 2026 16:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1rty-0006Kb-34
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:31 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1rtT-0002LU-A6
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5E044807B2;
 Sun, 15 Mar 2026 23:16:56 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sGRqAD1Aa0U0-HNLIZB86; Sun, 15 Mar 2026 23:16:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605815;
 bh=jOMI1rm/2uKnoQVaHUeJqXthwEPeLhlp323Z0MBmgKU=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=uk5xkvYqVQBdPH2B8IT+LFpJ/O0cm0J+CfJ77mJimQ2hXonrPopoL++NTiJ37N7m7
 JisLaq4jAQnEscP8zXRG/Bi0lsDw96cKOraCb5MefvLYtGF9u8mBk5zU7UPaielaVI
 TWCn6Y3z6C08NE70/aL5MoWnt6/lg7Q7PjZG1ex8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH v3 03/11] tests/qtest: remove -audio none when configured with
 --disable-audio
Date: Mon, 16 Mar 2026 01:16:38 +0500
Message-Id: <20260315201646.96862-4-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315201646.96862-1-heifetz@yandex-team.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It does not matter much whether `-audio none` is passed. In the future,
support for `-audio none` with `--disable-audio` will be dropped, so we
should remove it beforehand.

(We could preserve `-audio none` with `--disable-audio` for compatibility
reasons, but we choose not to because they have different meanings:
`--disable-audio` will eventually mean having no audio backend at all,
while `-audio none` means using the `none` audio backend.)

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/libqtest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 051faf31e14..a59fdaf3973 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -464,7 +464,9 @@ gchar *qtest_qemu_args(const char *extra_args)
                       "-chardev socket,path=%s,id=char0 "
                       "-mon chardev=char0,mode=control "
                       "-display none "
+#ifdef CONFIG_AUDIO
                       "-audio none "
+#endif
                       "%s"
                       "%s"
                       " -accel qtest",
-- 
2.34.1


