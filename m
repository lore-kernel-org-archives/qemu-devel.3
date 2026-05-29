Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259EBCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57k-0006Cs-Du; Fri, 29 May 2026 17:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57c-00067w-E5; Fri, 29 May 2026 17:52:04 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57a-0007Zw-Ry; Fri, 29 May 2026 17:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091514; x=1780696314; i=deller@gmx.de;
 bh=lt/Mmc+bT2vzqUqwyRnnOIgWS5pSwQouTPDb1uInhns=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ofafALPUWGOHTsj4UzQv87TLKgJIJGb7L9l5+BHpXlI38N/Fwp55z5Wt+8fXyEut
 QevZ50IyIo6ENvDHh9fwkxPsAoRm+A1QvZG0v13Tu3JXBR6EJqGnla4TqhYC7Hci+
 Byt7Wo7Dtm1Bp7r7E1l+V+Ysv+muq59k9Veq7DRiE6upFgW13L7DvT4M6/7UgKi7l
 vN68bs5ipuaLycnGeL+OrRc0rn73afRwnDnj1ytgr6Ux5AEoTlNYzpCOt3SGSSlCV
 hY+rrhyev65yDSsfJkaxyMMOgtkcwOTtvuwOKV/rf0zFXCZTW0ry0qF31yYINHuLy
 il1HO1saMt1A2HN21Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1wuxlH135h-00YKwg; Fri, 29
 May 2026 23:51:54 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 10/10] linux-user: Move cpu_copy() to user-internals.h
Date: Fri, 29 May 2026 23:51:19 +0200
Message-ID: <20260529215119.73244-11-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H3Jzhf91IqjxRMk3Y//3ZnLciB1ByYCtRw1srp0xq+ZM4DmMwrg
 K3ud9Cdn4wbCkz0laNe69Yy5oNP7mLoKASu2kjbkQsKqyTBZaRzeb+8vdTqEOHfjfTFBY5p
 ikA51h6tgKbbuSPqw4Zyb4lk+YQ0rzivgDXbg45ZvJb10JFRleRPViNk+ejHp0eMdcf09IO
 Bn/wWJzZsCgRDfONp6xgQ==
UI-OutboundReport: notjunk:1;M01:P0:oAqqRKppeR4=;Gi35a+aa/Noy8n9FKgZ1Ka2a+IG
 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
 5SWZmgu/jC+uBo5zUo=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

We only use cpu_copy() inside linux-user, so we don't need to have
the prototype in qemu.h available to code outside linux-user; move it
to user-internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/qemu.h           | 3 ---
 linux-user/user-internals.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 474489f046..07fe801628 100644
=2D-- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -368,7 +368,4 @@ void *lock_user_string(abi_ulong guest_addr);
 #define unlock_user_struct(host_ptr, guest_addr, copy)		\
     unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
=20
-/* Clone cpu state */
-CPUArchState *cpu_copy(CPUArchState *env);
-
 #endif /* QEMU_H */
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index fbfd12237f..0380d44fe9 100644
=2D-- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -209,6 +209,9 @@ static inline void begin_parallel_context(CPUState *cs=
)
  */
 void init_main_thread(CPUState *cs, struct image_info *info);
=20
+/* Clone cpu state */
+CPUArchState *cpu_copy(CPUArchState *env);
+
 /*
  * Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
=2D-=20
2.54.0


