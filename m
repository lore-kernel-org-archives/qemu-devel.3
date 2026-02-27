Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4E7FEFB47
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxF9-0006sa-7G; Fri, 27 Feb 2026 07:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vvxF6-0006s5-IC
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:46:52 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vvxF3-0001eG-6P
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:46:52 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43992e3f9b8so2009971f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 04:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1772196406; x=1772801206; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PN5rTKxYIAbasXZtlK6hb2TsV0l5NBb2t6kkv2iW9fs=;
 b=Mv4+7d2FX1kMwT1wa3cxDAlaqXJTn7ndFKIoMDwWn1IXm/Ftcr13UwnE7mxiVlP4eP
 DioJ1e+CaujKPL/YSmCuyivMBiUl8CLDbX/vtr5fZmo4oTF9XpElD21JbGRJsVFs+He1
 nENgpTwOYGDNdWSS8jnaZWSEGaWfv2GqWBZFAT1XWg9uvxl/hxAvYJeR1cDdSCW46kJ1
 J9ZrWeGuul7BA2ytYPyc17QUyUSuDtbnZANEizKils00PJKKr7miMo+zPcuuQVnVymMo
 on7/tq0TjnUTMwMoW1YJ6EHiEsDHsGHVuvBGtdeSdbL6Mi0hhLUarHGPdhttMHDJzgeB
 x3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772196406; x=1772801206;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PN5rTKxYIAbasXZtlK6hb2TsV0l5NBb2t6kkv2iW9fs=;
 b=RwfNi5a3jj/sbqMOLdXQmjAH1x8kGP8zh7sfKkS/87VpocjldfGpr0c+6Om6RY8Zgk
 Hpe5nfK059+0cz9lLwV4aBXWEcm/DK0Nx8bNyZo4BkxWqDUUFb+GYVq66X3nJgAL5Smk
 85grsK3M9R1fQaLHnTAf4nMAi4AotQ72unDiTQ8oreWf6j6OKBgRWKkWWJCbaee4rq++
 ypDF3Gw0DnaMmAlmlIRRD/FG334lRRI5CvZmE8DMrcpQ0QIbDKkTCVQW+ZLg0nHog4Hf
 yjQteqfZkxlmSf30AsSgBb6+ISijkf++BMUGo9yr9565qigFYrnK+lRXWLeeqFdRVuMM
 Nbfw==
X-Gm-Message-State: AOJu0Yx+z52CAWCZeUzwHBaUFg2BSoclVSPNgQhPS+3Zvyvrfzo7BcyN
 E4tOD15mG87Yqq0ZOFvRsNZmZhpZRY+DaD2Whdi1kka/mvtgkf3U1vX5LIEA9Bv+Bj4=
X-Gm-Gg: ATEYQzwh+Q+gwAet5YJmJni9BW4IjxBv9ZGDYbkNcmvHMUi4ySg8oYrrHP4ePPV67PI
 j2jV0gV9zmLvdy9o2Wbj565N/79gs4HdqViE43K+sAmdGrlOj8bLH4WyoLVZhqXopZt3LHN5WNA
 s7cLqyB7dAcukqjahrGE1EcUJMeudYgLwl+W2ssN/sHMwbITGRe5WMU5hSuLr/6RMpODLatUnOW
 QhPo+TARI4uFGOlO9v8x599pCl8MpNJ+RhAq70UP6b5gjDcHBcFzs9GDGULdGTgaN9x+tgo++Uu
 4QqmWSXGAlYEQBQcvmavIHWDyWpVkgLSOOA/LyzftIAUKLD4S/dXORr+iSFlFifi6KE+DRNgrBn
 R6vnqlPFwxg5hNStYdkdWxlZ7f9BTDxxnMW9R1bSCp1WTTGLDwsbBHxH7uNKqUlcRcAFLfAfxvu
 CmD7XoWEkUtjdK5z1sJGzXhnoeqE3jpFofU/0DBwGafE7DGblG
X-Received: by 2002:a05:6000:2dc3:b0:437:6758:ce80 with SMTP id
 ffacd0b85a97d-4399ddf8aa4mr4585934f8f.25.1772196405477; 
 Fri, 27 Feb 2026 04:46:45 -0800 (PST)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c597578sm6379341f8f.0.2026.02.27.04.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 04:46:45 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
Subject: [PATCH v3 0/3] block/curl: fix S3 presigned URL support
Date: Fri, 27 Feb 2026 13:45:50 +0100
Message-Id: <20260227-fix-curl-v3-v3-0-eb8a4d88feef@scaleway.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNz3bTMCt3k0qIc3TJj3cSUVBOjRBPTNDODJCWgjoKiVKA02LTo2Np
 aAOx1Z+pdAAAA
X-Change-ID: 20260227-fix-curl-v3-ade42a45f60b
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-stable@nongnu.org, 
 Antoine Damhet <adamhet@scaleway.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330; i=adamhet@scaleway.com; 
 h=from:subject:message-id;
 bh=8hhqAiOwDDhfeJWkyUhcIf3tkgKxzkCypW0DlIqYANg=; 
 b=owEBbQGS/pANAwAKAdwJoy885Y8+AcsmYgBpoZIpwNIY2PC1+L3u7OY6IrjgxUHJfypRAB0Qa
 hooSGEoIE6JATMEAAEKAB0WIQQCubVZtDHYaY6x8XzcCaMvPOWPPgUCaaGSKQAKCRDcCaMvPOWP
 PkkYB/459Im7HKQsjSYeaaqy+ll6b/Rn/mq8A050kC+yU4rLLIFdpVm1+JvClpbP8R79pUyqazK
 FpDKxZr1cYXDu/Vy1FIYktaJa6Si6kCJ2OZFOsgpihYcH5yySie5MOtPNtg+hF2tPZQH0kFNlu6
 AtcxIfT8DnlP7e4lE51QG+7eAHCSakLMVj1UUL8YcS4jNrM7rdSe10cmlyQ7GN6ncKydXZJAlhN
 f5DJlW8O//q3WGezRycEdWlBxluSXKLFjhjOyhiLfKPUfPmoQx1kJoxKIrgGEEhdMHqyVF5N6yt
 ryvnErBOIYQExKNgjbdI1lyGn26G/eqmaefHmvMnovFBdpae
X-Developer-Key: i=adamhet@scaleway.com; a=openpgp;
 fpr=4C3AEF45D70C65052D3F37E02A5F5236CFB70DEC
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=adamhet@scaleway.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

This series adds the support for S3 presigned URLs that only allow HTTP
GET requests. While working on this I also stumbled upon a deadlock with
concurrent I/O and slipped the fix here. Over the years there was
already an attempt to support these kinds of URLs[1] and at least one
report of a user in need of the feature[2].

Unfortunately S3 only allows a presigned URL to live up to 7 days so we
can't really put an example with a stable URL on the commit message but
here is a presigned URL for the archlinux cloud image[3] that will
expire in ~7 days.

[1]: https://lore.kernel.org/qemu-devel/110120539.4133.de5ac8a5-69d1-4f59-9540-4a679771a547.open-xchange@ox.pcextreme.nl/
[2]: https://lore.kernel.org/qemu-devel/7b37cc65-1314-29f4-006f-70836bdfb4b4@linaro.org/
[3]: https://test-presigned.s3.fr-par.scw.cloud/Arch-Linux-x86_64-cloudimg.qcow2?AWSAccessKeyId=SCWDHE3XBQGZFV282QKG&Expires=1772798381&Signature=zUxbVAWQ9Tl%2B%2Bf1jUW6q3o3His4%3D

---
Changes in v3:
- Used b4 to handle the series (I hope I didn't do something weird)
- sync 'force-range' description between QAPI and man page
- Remove redundant 'Defaults to false.' in QAPI doc
- Regen presigned URL[3]
- Link to v2: https://lore.kernel.org/qemu-devel/20260224155314.1658988-1-adamhet@scaleway.com
Changes in v2:
- New patch (2) that refactors the http(s) QAPI types
- Specify and reword what happens when using 'force-range' with an HTTP
  server that doesn't support the feature
- Document that 'force-range' defaults to false in QAPI
- Fix a few typos
- Regen presigned URL[3]
- Link to v1: https://lore.kernel.org/qemu-devel/20260212162730.440855-1-adamhet@scaleway.com

---
Antoine Damhet (3):
      block/curl: fix concurrent completion handling
      qapi: block: Refactor HTTP(s) common arguments
      block/curl: add support for S3 presigned URLs

 block/curl.c                          | 115 +++++++++++++++++++++-------------
 block/trace-events                    |   1 +
 docs/system/device-url-syntax.rst.inc |   6 ++
 qapi/block-core.json                  |  21 +++----
 4 files changed, 89 insertions(+), 54 deletions(-)
---
base-commit: d8a9d97317d03190b34498741f98f22e2a9afe3e
change-id: 20260227-fix-curl-v3-ade42a45f60b

Best regards,
--  
Antoine 'xdbob' Damhet
Engineer @scaleway


