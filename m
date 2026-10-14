Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79867CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6xU-00008B-6d; Wed, 14 Oct 2026 17:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xH6xM-00007J-BA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:56:16 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xH6xJ-0005JX-0a
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:56:15 -0400
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 39E7A3F78C
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792014968;
 bh=cMNXU8y3tO4uDY63RgNb2NbWn/L3oUYGyne2hUkzDs4=;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc;
 b=HHyqimAgknzrX2/Y4XEdx4csohwIFCg5oMN8m6u900/4NtSnfPEZzJD1mqvqO63iy
 ua8O1O3BqyHUyRFK8QJyfckBOPn31tTk8SLjjswvrSmuPDcaCF4xfc3snYiOdVuF8K
 r5dWnRWgieMrU/vzopFDPRt6td/m7EsfZitm0Mr++Y21coYrrMYKLsICgY2WFIpuKg
 OEbOMFa9Q6L16c+vf2ppEjSKCcdthJzD/FFOdQjHc2ufnh5FfWs+3bG6VQkbwD88VZ
 TzeHLQjyTF3FVop7ojDvu+hVR/exeJ5qAexJN2dhayceQgSVDkhXUXKO9+dBXd8MxP
 qiy17OsqqSY0iGQNrTfWV+Wxl1XyLWa/wltMDFqBbQXphuAEJ41T9iwOIdWPErEA/R
 yMiSiWWH1z9SZN2AZjrsfLLbuiRyB4aJU5nUAuybbl1VscvFbxBHQe0P4Zy76tU2SZ
 X3RgS9HK1ZatxRuicNvXC53EJGBWABhVryT7Ldvhvc4I71cOKbZaz2E+PfV2bHxOMp
 PZznqhYCSzKUKP6Biad7OnPxow50DUug0CXlifAOlh29TIZHnYqKBGjYDBpCNUhHwn
 FN2SfijvFNH//5Y3D32kA6z/xAjStsJlIqbAKvOMQOtPpXNDLn2chxXPfbODXidzZT
 aeVAjQicogasYgm/af2+ymsA=
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6768601940bso8366209d50.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792014967; x=1792619767;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cMNXU8y3tO4uDY63RgNb2NbWn/L3oUYGyne2hUkzDs4=;
 b=nBJyx4pUzJK27cnAM/sn+ld/GkFHZDElOOjLCRD21Qk9wNsOLvHdbcZqsNsw+qCPeu
 SyruiJSfSkjPSDqkx5NquefKoVXmvXGZnv9QZyEQGckzD2yu1mcE31HsfKm+/CG1yHTo
 XZEJ0zUmhPF3lFVxuMWU+iGFAXs4RoMzVbMoCrad4LiOI6+GP2ld1wlIXydbSvCTy20/
 DyBYGozssTc46H39tNoiKI0DxjU15EjJt0YhaqracLeWitAOZtBrwv1HMtSM9F2ulm5M
 dd4i4Flq6bL2DN+NlM3nx+ndFD5dtDJ0Kw2w0U5o7c88sUbYzi/+cwUd2PuM2h4TMs32
 UHVg==
X-Gm-Message-State: AFq9FYL8pPk/fyDBCiGc0FEKG9/MWknxQVb60sZ+pOyeRvBjll6u3m4A
 zr6P2M3eoWcKYNs5piNruSk7167Ue4WsNq7/0Ammo2QOwuifjfF3xObjG663ExGvopuaPdWMC3F
 K3ZNaNf/tZIkRUKzYE3HT/ScBdCcJBe5vzOS10oSmOMer2pZqEVoMWdoq4nmyY7It181n1s1D
X-Gm-Gg: AYBFou2Vx+iCYvc0tibXGZKu8ftAf+z3NAB5E1L1glF8r3JPptdsT6aDzRNzcgw9NlX
 qlV+yHDZynAZQAAr+9vZcYSxqvaGPq/usMQop/CwQt18IahqRv82P10HTmgVF7oYB3R1hDI6rMO
 +IWrA1YXa9GpkEdZobgjKpLah3eLshMpB3p2RvxMPXIFDnkJDBUNVi6BIFvMaf2bRlQTn5bgbGv
 T7txTasJeOolYRhl/+9f99NZLbvWYioOuAkyvyRJBCczkglKEfAYJWdwBX7PyvyvmOdRe8AXFDc
 fnsHwNTb5Zealk4GYTUND4eVFrkSHEGpS8zxfrd/oAsJPLDxU7phBxt/DGiDeBNmF+voKEO0sNX
 T7M1A/QS3Bk9TqHyFvoejkNwp6UbrdgwwK7oXP4Fo8qVUpUhmfpSlnw==
X-Received: by 2002:a05:690e:d4e:b0:677:ab1e:928d with SMTP id
 956f58d0204a3-67938b398d4mr4458539d50.48.1792014966858; 
 Wed, 14 Oct 2026 14:56:06 -0700 (PDT)
X-Received: by 2002:a05:690e:d4e:b0:677:ab1e:928d with SMTP id
 956f58d0204a3-67938b398d4mr4458525d50.48.1792014966490; 
 Wed, 14 Oct 2026 14:56:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:6c45:3000:1420:7d2b:a0a2:5b86:60e4])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6799df67495sm201283d50.0.2026.10.14.14.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:56:05 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Subject: [PATCH v4 0/2] util/coroutine: Reduce default idle pool max size
Date: Wed, 14 Oct 2026 16:55:44 -0500
Message-Id: <20261014-set-default-pool-size-v4-0-a3aff89b94f0@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ6CMBCF4auQrh3TdkgBV97DuChlKk2QkhaJS
 ri7haUxkeX/kvlmZpGCo8hO2cwCTS4636fIDxkzre5vBK5JzSSXSnCBEGmEhqx+dCMM3ncQ3Zu
 grGVhuDW6JGTpdghk3XNzL9fUrYujD6/tzSTW9Z84CRBQ1CSqnEttlTkb3fveGd0djb+zVZ3kL
 kkCB5vbRlmpETn+knCXhElqUFFpUNhKq29pWZYPTLKg8FIBAAA=
X-Change-ID: 20261013-set-default-pool-size-8b27c0fca8e3
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hector Cao <hector.cao@canonical.com>, 
 =?utf-8?q?Alex_Ram=C3=ADrez?= <alex.ramirez@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=VPD6fE8mB37G4bL25L08S8z2Nq5WDDPsbXvkUDD6eng=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBqz/p0cFuwA7c5sC+Mw601o7WQGTLL6h2oF90Fv
 t/9b8iz1FGJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCas/6dAAKCRD5KICs4jod
 uUsNDACBHYOQGl8qn2v2xkVeGOrYsrQtMvdTyhj8J86sSxXxzeGeEhUZeMli+trZrwlHFF5INz0
 EvXAamFrTmUpTOdTpdAhQMPbgV7//JiiwIpEXJbek8Yd5bTcABR5zJsqaO/IKkunFGCDArJAG9x
 +ICNbMXWy+Znpjpa/GaYSohORF5NtuJkYOwCZvaRo2mDSsTiWHOAl3Zm2cOAspkDqowELAYk9XQ
 4Z8IZiJNMQyAiMJ7PfS17uEYTGH8rj2e0wU7TRNQfhK38TmRUkGZsw8XsWXZeGrkpHQ0AkOHWaM
 FLyNLEn7Q0nn3hsYw+0Ikx2C3OZg7Hm3Wlk9QvMMQvrJ52AJs1ziphnsj57XfW0KXVyXevuHA7F
 BZzy5yiXQgncmulRfMuvMlXUK3XEBMuhQv1D26jq0kJov75DYCDvlm9TBcpPMYazXyA6tbKqAoN
 FN5zv9jA9woNZzEKCJ/vt5XtvJ8seRdMTCinzestpNwKV00UhOUMHsHXm3qoBXgEOzAfg=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Adding Hector's patch since mine depends on it; please let me know if
a different approach to sending this would have been preferred.

Thanks for the prompt reviews!

Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
Changes in v4:
- Return DEFAULT_MAX_MAP_COUNT from get_max_map_count
- Link to v3: https://lore.kernel.org/qemu-devel/20261013-set-default-pool-size-v3-0-d36e8c31f9a6@canonical.com

Changes in v3:
- Use Daniel's suggested implementation
- Clarified comments to drop "LSM"
- #define DEFAULT_MAX_MAP_COUNT
- Link to v2: https://lore.kernel.org/qemu-devel/20261013-set-default-pool-size-v2-0-f4fd6f2a3303@canonical.com

Changes in v2:
- Rebase on Hector's patch
- Link to v1: https://lore.kernel.org/qemu-devel/20261013-set-default-pool-size-v1-1-7be19402af6c@canonical.com

---
Hector Cao (1):
      util/coroutine: trim sysctl's max_map_count newline before parsing

Wesley Hershberger (1):
      util/coroutine: Reduce default idle pool max size

 util/qemu-coroutine.c | 73 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 25 deletions(-)
---
base-commit: 8ee6c77176cfee03be0ec7665b6652b2f31f1531
change-id: 20261013-set-default-pool-size-8b27c0fca8e3

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


