Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D5C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1R8M-0002eS-Qa; Tue, 01 Sep 2026 12:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1R8L-0002dq-Nm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1R8K-0004HZ-7h
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788279287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNnyAvMvDbdYWK+1fPT52QCL4l6vn04XdrMdHHfbBsk=;
 b=CLLkrBEuPwSaSHeLEo9SPJPkD7OX4G0v/AtyaTEOERZBSvsBxdAFUb9w/5J9hQbMbQlxP/
 dE4QD/oAAgrtzyIQJ1kdrR6sm9IOjjBOybsgCeX0yVlW9xTpQcJ+zDjjtwW9TAe4Po0oSJ
 xjVsIALGCwrONkpSqFDyjDbagV/TJhA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-XFdLKO1SOBGSF3O46FecMA-1; Tue, 01 Sept 2026 12:14:46 -0400
X-MC-Unique: XFdLKO1SOBGSF3O46FecMA-1
X-Mimecast-MFC-AGG-ID: XFdLKO1SOBGSF3O46FecMA_1788279285
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49545071724so9520485e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788279285; x=1788884085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eNnyAvMvDbdYWK+1fPT52QCL4l6vn04XdrMdHHfbBsk=;
 b=XFywyf/8X3i1hOUanRhuZxqnD6WVhfD75NFObsSn38szZyiQ9l+CgXqM5ooc3ERvnI
 sjrxaZlNAbnrzgS8kA2wysSClEYMYkYg7+NGXgvgudntcMuRiyCPYi3cV5t+f0Y7N1/O
 0W6cqakYulh5lM2ei2z4weESrq27cfj00qG1GFr7uvh35q4le4Eaq9++VVPHTmqSObh+
 UgeXwuTJtdjy7NNpuLe4+K0TI2urPHn5K4v5IZkucBZ4qA0jp6S489Wy+S20tgK/rPm/
 p/xYQ60ZlQs4lYuOwdlX4D/A4glgeFvxgDMaATd6ByFjJmbwLy5MOWtn9oT5NspDiQwS
 /98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788279285; x=1788884085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eNnyAvMvDbdYWK+1fPT52QCL4l6vn04XdrMdHHfbBsk=;
 b=NYtRM8/Yw6ahM5T9TgZdZzsXhlIy//nlt2fA1ejK0byLlMWwWtOz+5P5RAKvAHrN98
 ve/GquTN9VZnpX5zvsmfvhO3Mgs6OydstCka/uCleJ7LBjMxVPBSdvlQ4iVn3FLPGGUs
 1tbYluVQDe1RgFmVHOA/aavLZaHQCxeMeCQgVmHUK1VpealXindCcg82NCn7H6GZ4jD3
 r7SXusvaf/TyayqYjIdQHyZwdUwzoj09vTJF+t0P+nwByaiPwGgZbnjkEyB3upPp5dtr
 2QjUnzg3F625RUV43b8vfyRer5WjhNRRwQLCyeM7BMkURiGEdixQPBhNUGsu9Ml72HiJ
 jL8Q==
X-Gm-Message-State: AFuF++lBtaRM7HD0xFY8BvHB7elzdg8u01RIMZtjT//xwZqjG6MgfjJg
 XOFSyivBv9zZ6ZwZnKZaqYaJWZYavoFaYwUHS1rJ9EyEfipvhVb/boCZ0d0pjnb/WOWYO15+tbx
 r05NTWR8gJDKl5b6xCHVZWDQPCf0T1jA2Qla2FJQpiEF5CY6UoLjMKWHr9HbL/UrH9RID+QX8+0
 dmSMF4fp1NrzU4DJynFeYBn6ChygTwhrJHNUPNzhFA
X-Gm-Gg: AR+sD11FKcuAP8kr/NS8ZIWvVKaJC18ib2MgPpTSgB/ohjDz5F2l4U/rErZtEjG+ifD
 LGn9EwiUhITNHkKbvtvvZlAcge8vA/KLwtUFi8v/NxgS+QXc/1JhjA4z2uUvaNYxocpx3m6Q90Y
 kjWDuAufwQXkQ+iHaG7SKQ7dXlJX7pMxJ55Q1f2Y93i8nFAQt5f6d89QjtOBg+Hwb0HN0x/L391
 TVDBOD9qZYXXV4ldxG5ej1GuFC9pfZyquuRWjc0F+ge+4AKg5VG+uf8NV41WVrusK3dJbKHqn3e
 gUf4341tgQydAyMLh2ZIe09XXiJAZS++zbRnn71UXmqBInkillqbepjez2EqcTyFDWB1dUrOJVB
 n47X08jxkf8w99hzgQTN0V9s467C2NE4CdDYUEubA5lWLCpRyA+34f5nFrEA+jYFIPf/upnkuc3
 9ZX6A=
X-Received: by 2002:a05:600c:4445:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49b91c44fbfmr492044315e9.9.1788279284844; 
 Tue, 01 Sep 2026 09:14:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4445:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49b91c44fbfmr492043235e9.9.1788279284397; 
 Tue, 01 Sep 2026 09:14:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cd8148fbdsm89996255e9.3.2026.09.01.09.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:14:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
Date: Tue,  1 Sep 2026 18:14:22 +0200
Message-ID: <20260901161422.314581-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901161422.314581-1-pbonzini@redhat.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Claude Code and Gemini CLI do not read AGENTS.md.  Reluctantly advertise
them to facilitate following the rules.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 CLAUDE.md | 1 +
 GEMINI.md | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 CLAUDE.md
 create mode 100644 GEMINI.md

diff --git a/CLAUDE.md b/CLAUDE.md
new file mode 100644
index 00000000000..43c994c2d36
--- /dev/null
+++ b/CLAUDE.md
@@ -0,0 +1 @@
+@AGENTS.md
diff --git a/GEMINI.md b/GEMINI.md
new file mode 100644
index 00000000000..43c994c2d36
--- /dev/null
+++ b/GEMINI.md
@@ -0,0 +1 @@
+@AGENTS.md
-- 
2.55.0


