Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA28CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57n-0006H6-VQ; Fri, 29 May 2026 17:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57m-0006Et-4W; Fri, 29 May 2026 17:52:14 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57k-0007d3-6Z; Fri, 29 May 2026 17:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091508; x=1780696308; i=deller@gmx.de;
 bh=tWtETPRygSgQZR6Gi7khNDjEaydj/eYgQ525rIOuE8s=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=j4nAADFUtSZmKfZMVepqrvbJ/IdbCUFAY5J6+CO1xqnWWicsab1+YnO5K1Wvhi8T
 Q7igjP4VEASoLJ3RaTtxUGrBFpjEXAUBwWwTyE/LoFR27hoau2rEOt0JFHbdiJE+s
 gFL7XSFpSaSt4oYavuSr9KVX7srTdpGiZBZjOxq8ErZtQ2NI+3swnui02NmrNOZ2+
 sSf86ryOA5jdBj8f8auDWywBZrmvjvyFdcrX9f39XK797zjH9R+QqOBkuE67nhPrS
 +i+dvwEEcjdTYiHmUbTqNdJfWKlLgOba8lQ33xn1nuRA3uOB2iTpIya6BL8it1ajX
 jGM0Wc+Vvvo5G3O1Uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1wvpIB2mKG-00ZVbn; Fri, 29
 May 2026 23:51:48 +0200
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
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL v3 07/10] linux-user: Implement finer grained madivse() syscall
Date: Fri, 29 May 2026 23:51:16 +0200
Message-ID: <20260529215119.73244-8-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wmlpb/kGI+HNK6WM1ZmHa/AlODTa4ABnc1rBCZnKYEZA740eIib
 vmhtAM8YoGwXwNWGv+ENLRnD8bj8vgwkoV0M554/Bjhidp4UAAhWF2d1N27PLvxBE+FwtdW
 hGwPFYlWnUSd3E+3YNS1zfYlJHYSASip5cxv3NlkD3aN1Twk/frw11ESerCNtqhTbS1n6Wb
 y71e0J7qaL0DGusaak5HA==
UI-OutboundReport: notjunk:1;M01:P0:0nwH2VksTJs=;E8cxT1jGyUsAulPv+KFAe46Uoiu
 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
 BvQEcFcr9Y0SgAiY3tXkrXau6y6/x2pR9mbGMKV
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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
 linux-user/mmap.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b4b7b3e5cc..55277f7c3e 100644
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
@@ -1324,6 +1337,25 @@ abi_long target_madvise(abi_ulong start, abi_ulong =
len_in, int advice)
                 page_reset_target_data(start, start + len - 1);
             }
         }
+        break;
+    case MADV_DONTFORK:
+    case MADV_HWPOISON:
+    case MADV_MERGEABLE:
+    case MADV_UNMERGEABLE:
+    case MADV_HUGEPAGE:
+    case MADV_NOHUGEPAGE:
+    case MADV_POPULATE_READ:
+    case MADV_POPULATE_WRITE:
+#ifdef MADV_COLLAPSE
+    case MADV_COLLAPSE:
+#endif
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


