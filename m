Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECA3CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjDx-0002z2-Tv; Thu, 28 May 2026 18:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDw-0002yA-Lq; Thu, 28 May 2026 18:29:08 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDu-0006xX-Qj; Thu, 28 May 2026 18:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007333; x=1780612133; i=deller@gmx.de;
 bh=ad8r06B1vPYIOZI6F5rInQPKgaCFRMO9XHzi1cEsym8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mNMhXXgI2Mlr08x+10cyKnsTml6+L2ZM21e7gaBYWCagEdv4wHwTHI7OYTaIQ3H6
 ekIxyFiYtawJbmH0AdGh2UrFh4FJ+hb1+yVKR5F4GJBPfe40PoIHim/4ImcEkWsTW
 eoKmsFWmjws+bVatvFrMuai0XX65n21KtUQCY+Df1xF9RKdRFE/2Y91P+xueq8qzv
 PNEN7kxhHoO7thPmhqWugYYnEMvTA+Q3tdojHtr3ZV3woz/0VdHhp8IrIOLqPXEzY
 Ui9tyjf5seZEc3PguL0LHttwy+t5x1WRmURWP2IPFMK3kIE9NzZckKZwZPRxnvVaL
 kNQcbbquOFQuW2Jn+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1x4sFr2tnH-00iY8j; Fri, 29
 May 2026 00:28:52 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL v2 07/10] linux-user: Implement finer grained madivse() syscall
Date: Fri, 29 May 2026 02:25:44 +0200
Message-ID: <20260529002548.19293-8-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FQwbgjNoHHmka/u919GFm9rRuBH4IuDGD4LB9e5fbrorU9cIsI
 8ISVncs5LSGPMwKo9l97k+/qQktyb3TbyJQTiO3jRc37pKocc1srDjiuL27hPgl3+ATKrGF
 THqT43bfb+chb5cBX/vaF/eldBuqZRMOvkKrBDiltWHREKpvH3Ol9evWX/++V1XD1nFOYaT
 CpNBIIWP7mXeMxkbg9CXg==
UI-OutboundReport: notjunk:1;M01:P0:vQpJKCBSeAQ=;GZK8iKvV+B04IvsVWoRI/HSXNFS
 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
 Ahs9mdpbxOb7d7ZGxWOSBkd91MHT2EUk9q5YdyX
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Although most madvise() values are hints, some are important and are
checked by userspace, especially by security-relevant applications like
BoringSLL.  So, return -EINVAL for those functions which we don't emulate.

Signed-off-by: Helge Deller <deller@gmx.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3489
=2D--
 linux-user/mmap.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b4b7b3e5cc..50916c29a5 100644
=2D-- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1282,7 +1282,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong l=
en_in, int advice)
     case TARGET_MADV_KEEPONFORK:    /* parisc */
         advice =3D MADV_KEEPONFORK;
         break;
-    /* we do not care about the other MADV_xxx values yet */
+    /* all other MADV_xxx values are the same across architectures */
     }
=20
     /*
@@ -1307,6 +1307,19 @@ abi_long target_madvise(abi_ulong start, abi_ulong =
len_in, int advice)
      */
     mmap_lock();
     switch (advice) {
+    case MADV_NORMAL:
+    case MADV_RANDOM:
+    case MADV_SEQUENTIAL:
+    case MADV_WILLNEED:
+    case MADV_DOFORK:
+    case MADV_FREE:
+    case MADV_COLD:
+    case MADV_PAGEOUT:
+        ret =3D 0; /* OK */
+        break;
+    case MADV_REMOVE:
+        ret =3D -EOPNOTSUPP;
+        break;
     case MADV_DONTDUMP:
         page_set_flags(start, start + len - 1, PAGE_DONTDUMP, 0);
         break;
@@ -1324,6 +1337,23 @@ abi_long target_madvise(abi_ulong start, abi_ulong =
len_in, int advice)
                 page_reset_target_data(start, start + len - 1);
             }
         }
+        break;
+    case MADV_DONTFORK:
+    case MADV_MERGEABLE:
+    case MADV_UNMERGEABLE:
+    case MADV_HWPOISON:
+    case MADV_HUGEPAGE:
+    case MADV_NOHUGEPAGE:
+    case MADV_COLLAPSE:
+    case MADV_POPULATE_READ:
+    case MADV_POPULATE_WRITE:
+    case -1:    /* BoringSSL uses -1 to check if the environment is broke=
n */
+        ret =3D -EINVAL;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Unhandled madvise(%d) call.\n", advice)=
;
+        ret =3D -EINVAL; /* not yet known advise */
+        break;
     }
     mmap_unlock();
=20
=2D-=20
2.54.0


