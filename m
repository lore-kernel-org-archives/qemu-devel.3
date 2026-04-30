Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C67FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6M-0004kq-Ft; Thu, 30 Apr 2026 13:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6I-0004jZ-Fk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6H-0004M3-1E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJi7d6kHNwTM2v2NfPDK0qijysu3iQN9L8nEe3bv5og=;
 b=TVo9nyFLb93C5cIku9ibmLgfTU4FUYAQsDaJR4DKh2x2fPv/H7P+an5GBNmRb5VY3ZaQSr
 s5mrvbSkRM4DHLafI5UXp+QQlbHcZTDqHYtNEUKEMy8uqu7ChmkRHPj1G4baILYEMegOPa
 V9//DGDzI3ZW+qsnK8a3Pjha95uFisc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-hVHB8jHQODmBOe-MjI2fZQ-1; Thu, 30 Apr 2026 13:22:55 -0400
X-MC-Unique: hVHB8jHQODmBOe-MjI2fZQ-1
X-Mimecast-MFC-AGG-ID: hVHB8jHQODmBOe-MjI2fZQ_1777569774
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eb9f8bbbb3so675082985a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569774; x=1778174574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJi7d6kHNwTM2v2NfPDK0qijysu3iQN9L8nEe3bv5og=;
 b=lIHAouhCqm0nVuNws6glaspBt7GenAekpg+1TcshRyu0vmZVvnvygp4SXJBWZHR2It
 aRvxej5yDI2EMXJujsjTALtqio6iDB/JHJPrjvGQSh7C4KWZZgF4Zzs7DvgZgsmrtDhY
 2epBnZLwiCg0XD+ZErfY973OZjmnc2AbwiERClKNNS8oa1PbqoVy/qD7okk3hambNbmK
 E0gpX6ykwv07+W06KV9OEhYnDCrazLD39da+grJmYcNhYU9W+MG++TOddse38qqXctAQ
 cIzPZrVZNJxUIiuUASnTy9uRC1CAY7jZRlRF5oKfN+r1LsBkH0VTZk3O8PQyJaO/ZygE
 s+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569774; x=1778174574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kJi7d6kHNwTM2v2NfPDK0qijysu3iQN9L8nEe3bv5og=;
 b=QtRumxXtja3877p7Plw5RoVmSipHP+jacj7Z8rHZCD4Is6DQp6H6f23QLrJd2LLbjg
 0GHkMAeCIvtDrSECaekBeRAxTnvK6zcqZCnRTzZgM69SWYmfN+bSfwvsdM8f6N9GD2js
 Dq3eZLjhYKqaZv64SH4CxP2XwwSUJfxat7BylsWPbADtjU1C0YFxZB3z8WPRWcJWHB7Z
 6DpdvAC3SgusuF0nZXHM8U+QBKyCr/7p0I7m1GgRU7SRd0LmJsimVr0MoJOvFVN/fB5d
 NuaZe5TqfahWIEasI30stMChOohSKR4U5/h9SdQ/XV2ESPe2yxOoi/BHJNIPPwkTLLN8
 Lb8w==
X-Gm-Message-State: AOJu0YyB3Qn19vCLE5O1yYhT35t9rUQezN1gfRvJrGahAWQQwkakAiBr
 SvgvjKklE67SBKY2LPBX/N4GeRoxLsjc2PKS3vedlwmo7yTHDI/6UnbEy47rQtzc8PmYaeVHoku
 srgjvBlPi2d9fvqzRxRXyrAIZY/U/7z4hp6QiJJTsz1F3sAynIEbHaU+hInKnu5KgsXGnl2c179
 lZvwvhX7ui8xEDOdULTPYgWdlljDc+t/EjDlet/lTk
X-Gm-Gg: AeBDietosUrKhFQ7xXpDr/DRWUTSMVzX2m5AJ0HOROYiWeB4e5P79co+z4dyomm7Vep
 Gy+uKbzHiyBM443ratj8BR1MaKZ/WuS9dcdScR2ND0a7WlhWUQIpZMsD1hovGfJadZPNDlltTwi
 Tke30k7UODnQkxpg6fvtZzFMqEXprsJCJg+mbLtP93oAjGjIsYuqX5lwT81ICD7BbxmyMHAgOfC
 ZPX8XuYwmcSGQRP3La8dXwNBN/fsv+oVKxI0xbGVh6zvUWA8w+prsQm/M49whjfQeWWdl+St7rU
 JUj/WeEQLZzz8t+VC1P3WAk6u4Q/lGU01lai+N8q2A1KUw75bepff0a5Fp8zAlpXm9bXY13CMEq
 a9wLcZTnRUNBWB3fTnaeMSP86IdIowF8hRxeNpSBPuS2O4kSx0oZ8iEQkvD3ZN/hyS+rZfxH/4w
 DSbQ0Og6LkH5ubqqUF14bwO2aPAmtdxOsnZC4=
X-Received: by 2002:ac8:7f8c:0:b0:50e:5eac:cf7d with SMTP id
 d75a77b69052e-5102d1d0c3bmr40928431cf.25.1777569773895; 
 Thu, 30 Apr 2026 10:22:53 -0700 (PDT)
X-Received: by 2002:ac8:7f8c:0:b0:50e:5eac:cf7d with SMTP id
 d75a77b69052e-5102d1d0c3bmr40927971cf.25.1777569773351; 
 Thu, 30 Apr 2026 10:22:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d2f63dbsm287131cf.18.2026.04.30.10.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 14/58] minikconf: pull main program into a function
Date: Thu, 30 Apr 2026 19:21:20 +0200
Message-ID: <20260430172204.1006673-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Avoid pulluting the global namespace.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 7f0b64b1e08..d728fd867f3 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -666,7 +666,7 @@ def scan_token(self, ch):
 
         return None
 
-if __name__ == '__main__':
+def main() -> None:
     argv = sys.argv
     mode = defconfig
     if len(sys.argv) > 1:
@@ -712,3 +712,6 @@ def scan_token(self, ch):
     for fname in data.previously_included:
         print ('%s: %s' % (argv[1], fname), file=deps)
     deps.close()
+
+if __name__ == '__main__':
+    main()
-- 
2.54.0


