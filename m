Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714CDC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76BN-0001Lf-14; Tue, 22 Apr 2025 01:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76BL-0001Ky-EK; Tue, 22 Apr 2025 01:28:31 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76BJ-0007oS-No; Tue, 22 Apr 2025 01:28:31 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-301918a4e1bso4014645a91.1; 
 Mon, 21 Apr 2025 22:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299707; x=1745904507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLDEQ4UoxB4KfXTxMudZLa30Bn1KGXwL+PXWMvv39yI=;
 b=SkwpZzdwfHZt6L7nhhB06Cpr+bAvXCdMR6YaTTkUJZJ1EPlWbBOXdnFA/VquKnX1jJ
 1gsCqlgzjnEzE2PwCGf151lNE337Ze/Ddz6lqKr/H4LmWnTAsSc7SL8v1HvIZPCROEmQ
 72ijCK+gu6SCWaCR/4bd0HCLxX3+bzWOUDZSnXcHLXdPeL/RD+MG90WsnmR9/s9JiSLK
 +zry88IB62u4GrPzTE+sOPVGNUo9+UCLGyvU0aTBv2KL0JrZvoilUYNVgP8odhTUURMc
 NFIdzjJ1i3kueg9M4eWPkZ2SgF2J9R1Pr/cHDSFiqfqExJl1fzb/33RC6sUKTHvMyGw7
 oI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299707; x=1745904507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLDEQ4UoxB4KfXTxMudZLa30Bn1KGXwL+PXWMvv39yI=;
 b=X8Z0r++iDonXKJAvwNyrZy8IHiuDXWxtersAtmNWmQYidgMl0KAJJ+mj/knKOsMwrt
 EDcGzST2kpxMlnZregE6wu9jpwq1iR+xgWAVNH7w2+UVDD2S7EN85G5EGWQPILyWU2Cs
 aLQ+/xXso7i7VYFr4nXNK0h72IlIATkhhXgxnUiFmyvAnW0b/uXFoAX5SNJHLFAwCu3j
 g3J46CfDZcZekV5T2r6JCZh5/dpFbHzMQ/KTh96KObjG7999M9Dv6CM6g5Qa0oIfrkHT
 XzbGBYh0zoWusXvpNfU6vZkLTFG7z+S1+y+pwOXY1IytpXX/w2im/52f7UHeNdIfJQ4l
 E9dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVY/eW44rSYQeNA6ZHU1xvaBwXVWUfR9uX6nOQFzpZ/GQ5ThaWlLRmAXDuPupIEa5/EzJVDDnONw==@nongnu.org,
 AJvYcCWIobK9LzhIuOwZEVqm+XcHq5agEAxUvJf1iK6dAjHqFr0zPP/qgqk+Y+nLBxg05wtL0mSysTDPl/20FA==@nongnu.org,
 AJvYcCWuF/fP30vjv2Ah7+iqwLV3/VXEblzIUC0IxiSbEgcQM02NlakGJLHXUS0cmtdtPIH1sv4Ayz1yLq5tmg==@nongnu.org,
 AJvYcCXEjxb3NvgFdYjzvtAQ3EuWwrueHbUAcJ+zdKrKaaCxocwlDfmimvpBJqZcaP+AiOph1wjk6DsszlE=@nongnu.org
X-Gm-Message-State: AOJu0YzQpGe7y+uJuXs1pzSMWunZBYxaMiKVdqmYbF4fnfrQVipHpnQ5
 49weoZVsvM57IMp4eg7Lt0Aw0E49COINgJG4Tvz5CTRhfMI+8/EPGHJZA+z2
X-Gm-Gg: ASbGncsxA+8rwLvRv3D5BEFJ13urupIvLBFdxzU7yUhWZnYys381oT9t6flklEuXZGU
 wCzHeZHLgqfKS1udvixuyq+Hujt3SasSRFlG8B1qVLKUDuTPPY3lIYKc9bxS9qehdWHqrGFJaS4
 Y0dBZw5hW1aXpPbZMOf4Wl+9uQGnifLpnCm7SCakLjBlhmNt42nxrhAwES6lLlnxYlnilkMJQGK
 PNHd5P/bN5Tzq1HgFbBFIiyJRkTc9bBMjPwLVRADjUzc9u40PoSILi8hr3nkgrq/EtwSIEmuszp
 ntI0zc0QBO2AEDU3yhqzECot0L3Aw7d7inO6GYC9NItEarxsQFToX2SCeMIqyXESd3uxpw==
X-Google-Smtp-Source: AGHT+IHIGGhSXR6KJuuf/VKfP5bkoJ6cloNLfBSB2N/q5TArXIo4hjgZGBnttNj35T0H4joj0zPGFQ==
X-Received: by 2002:a17:90b:1f8c:b0:2ff:5ed8:83d0 with SMTP id
 98e67ed59e1d1-3087bb631d7mr23227589a91.16.1745299706596; 
 Mon, 21 Apr 2025 22:28:26 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:28:25 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 03/20] system/vl.c: Fix type conflict of GLib function
 pointers
Date: Tue, 22 Apr 2025 14:27:07 +0900
Message-Id: <e9a50b76c54cc64fc9985186f0aef3fcc2024da6.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102a.google.com
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

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 system/vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V2:
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

diff --git a/system/vl.c b/system/vl.c
index ec93988a03..8d89394b45 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1523,7 +1523,7 @@ static bool debugcon_parse(const char *devname, Error **errp)
     return true;
 }
 
-static gint machine_class_cmp(gconstpointer a, gconstpointer b)
+static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     const MachineClass *mc1 = a, *mc2 = b;
     int res;
@@ -1573,7 +1573,7 @@ static void machine_help_func(const QDict *qdict)
     }
 
     printf("Supported machines are:\n");
-    machines = g_slist_sort(machines, machine_class_cmp);
+    machines = g_slist_sort_with_data(machines, machine_class_cmp, NULL);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
         if (mc->alias) {
-- 
2.25.1


