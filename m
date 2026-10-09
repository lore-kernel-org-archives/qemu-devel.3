Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F147CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF8U6-0006JY-8t; Fri, 09 Oct 2026 07:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xF8U2-0006Ip-Mf
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xF8U0-0004K2-I4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791544187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=24tljc/ou8F6cXiORt1Rv6xohs99S9vsUVPTcgCJQI8=;
 b=KwHhgfpz0JaYC+qeZSV46dNUg8Mlx6SndyPMWBd5QGZdHXLeXskTojUDq2nCJ0+e0My18S
 cq3ZNWPrIXxq5aEDs5h1RjuLUXhMGH/l3JhwwY1Zo9qXb0hae6QPtahmoml6Sm4kK3FX75
 chzbHBUJCv8/nEiCdBhQc/eNgVR3LUk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-suTxljnyOzmgkiq26TsXoQ-1; Fri, 9 Oct 2026 11:09:45 +0000
X-MC-Unique: suTxljnyOzmgkiq26TsXoQ-1
X-Mimecast-MFC-AGG-ID: suTxljnyOzmgkiq26TsXoQ_1791544185
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48af4046a3bso5318826f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791544184; x=1792148984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=24tljc/ou8F6cXiORt1Rv6xohs99S9vsUVPTcgCJQI8=;
 b=fzdpo3pCqXPOb68pK96wj1Sq17suFKVcMlscguYKuaabMoGlMMepjDo16aYRZVXZum
 EoSt+b6qL/qBsGIeV+gZM0/xw4lI6NBPiG96nlpfDNCqy8z9c87DOMcNNaPjBglg9lEb
 oARyRL4paBhaYb95bJx8SEpJ0AAvuPVQlhLfnSWf0GyudX+a7gPs7ABbxeJkFXlvVDwj
 gpG/KXFl4v3P0zTWTI7YYnpvw6cIKsN77xyCtZJtn6YdfyLxZDVQEIpUYwO47lz1YS3G
 dlFFKSPfXndNs0kno+ghB3Ct5pSLIIPDYnf5SGpC8ux7LWVgSn0I5HRFuxuy0dSEQ5CY
 P1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791544184; x=1792148984;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=24tljc/ou8F6cXiORt1Rv6xohs99S9vsUVPTcgCJQI8=;
 b=b3a8SrIkMU8I0BXcE7JjfLcyux7siKxlQfTPa9KAEad4EF3LSAot1M5gWt9h3GM+V4
 Eii7ER3Fth9igvnT6OeOo5/sLjYBp+DSb2+tAkGoFxEYCvB7yop0rc77F/ZqYFewJIZk
 srh+Z6BE5U7kuw8R4ratQGfbckBM/qHa5w4p8A9wqNM5M6VVbYr4Gl3X/8pKTTnbwK8K
 mvf5/wOb6RLY7f6GsZVbXO4DpkniKbO+AS5Ir7ufomc5OUr/o7EMlqFLZvOBxKxwO1Ch
 x0yE8C2NHzcepMqiwgPJSq94WInaX78NLF3nxEDI6LKBeVd4/a6RgEq0ZP5BDYMqZrEo
 +ErQ==
X-Gm-Message-State: AFq9FYIDGJNuIMjVSiYlcxIx+Jfq0LmwT06D4OhyLiuye6jWWv5pu1nH
 xS6MZJb8Hi6WXrcqInazvTzalxVF2IozDez1lj+sjLLIL7PaNYDn16Hn9k7AZP3UYb9o55vKoi6
 ZPl6bR6EjRq/iO0AaSfw77q8p10CKB/SSSvbfhknLCmZ5V3Dnnblr/QkwbfbhDEkjpamcpIqWDG
 sBYPLTBqgyERn7POSaMLSbS+2fbat8DH/JXZWicMBs
X-Gm-Gg: AYBFou2yqxsRTZKLvtNc0jk0kbOfRO+6DaBW8nO4S60mo0X5vA+JIp1o4b8KTvqAlYh
 +dduHrzCTURtctGSizEPo06OU85+WbcnHiOL4GMztFXBOPPNQrID84bAkYBpiV64oIMetBpOu14
 xcnegX8iFFke3rCfjMGuabARVcKKJvln+vi0/2NWyu1bpLyUR0Ote9ETSRsbWF/kcuyinR+rcyY
 o9V5TN0Glg/9ZJrQWXdKDQ8D2xIAgv6nob+PqJtBsEtHQKAqB2ZnyBGKKMUTUCBuzp+JvoQNOVN
 iWOEIGLotkVxh6J5CgSAQJVXQ0hEN4zq5OcYtX0Po40YX3lj1KzTYncU1oXUVtewQHVYS++ML7R
 Ldg45pUnlm++NaQCogRtjAF5Cd7GWnFAFb6oqGgkvnu5KossLyzAl5Dgp8AoWLf4GWsvO6S1Q4E
 kIXpMKYlGJWrESLd10ZDhfe8gc/EGbw+Gn
X-Received: by 2002:a5d:4b4e:0:b0:48c:6958:ad6b with SMTP id
 ffacd0b85a97d-48dbacd9de0mr2197898f8f.44.1791544184509; 
 Fri, 09 Oct 2026 04:09:44 -0700 (PDT)
X-Received: by 2002:a5d:4b4e:0:b0:48c:6958:ad6b with SMTP id
 ffacd0b85a97d-48dbacd9de0mr2197849f8f.44.1791544184029; 
 Fri, 09 Oct 2026 04:09:44 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e530esm3295680f8f.13.2026.10.09.04.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 04:09:43 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH v2 0/3] block/vmdk: fixes for stream optimized disks
Date: Fri,  9 Oct 2026 13:09:02 +0200
Message-ID: <20261009110905.905070-1-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

The stream optimized disks produced by qemu-img did not quite adhere to
the specification. This could trip up other software consuming these
disks. The goal of these patches is to get the VMDKs produced by QEMU to
better match the specification, the Virtual Disk Format 5.0 Technical
Note.

For instance, when packaging the VMDK up in an OVA archive (a ustar
archive containing an OVF, a manifest and a VMDK), errors occur when
importing that OVA into VMWare Workstation. Specifically the digest in
the manifest does not match the digest of the VMDK, because Workstation
reads (and parses) the disk contents and then makes a digest, rather
than making a digest of the whole VMDK file. Extra null bytes at the
very end will trip it up, as they are ignored in the digest made by
Workstation, but are included in the digest produced by something like
shasum.

Note that stream optimized disks, while not adhering to the
specification fully, are still useable by VMWare tooling, with some
workarounds where needed. For instance, VSphere does not have the same
issue as Workstation.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>

Sanne Raymaekers (3):
  block/vmdk: align stream optimized data grains on 512 byte chunks
  block/vmdk: skip RGD for stream optimized disks
  block/vmdk: add eos marker for stream optimized disks

 block/vmdk.c | 117 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 47 deletions(-)

-- 
2.55.0


