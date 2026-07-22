Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF72CC4452D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmRYe-0005Np-Cs; Wed, 22 Jul 2026 03:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYc-0005Mx-0D
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYY-0000SC-Gy
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784705993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6wcSGOl6+JpWJlabTA7eh1hIi2KvCsfaAgTtOegcmFc=;
 b=JGMf1w2K7N68Vf2Zv4cmLZufNjWb5qa7NbE5IMfdRvfzqlEhj9kMTWgiyWFCGIP+SIMpf0
 Q1Uo/vIhYRsvQ2FAQS6yOtZV4dUr1gPSslWlRA/KtcQbOfcYuJP+Ov5LTctP4gLJmgrsfy
 0fBnQr1mXVzYwsJLTDp1wNQr4I36BYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-VnO4jH9ZND2ZizPJzR4oIw-1; Wed, 22 Jul 2026 03:39:52 -0400
X-MC-Unique: VnO4jH9ZND2ZizPJzR4oIw-1
X-Mimecast-MFC-AGG-ID: VnO4jH9ZND2ZizPJzR4oIw_1784705991
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47485fde05aso7258305f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784705991; x=1785310791; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6wcSGOl6+JpWJlabTA7eh1hIi2KvCsfaAgTtOegcmFc=;
 b=TrZjcFtwV7oSXBoJf44+f+Sw9L07CWZHxHccgKjFEKOnWWp6vl2O2f8yQjSBUlZZ1n
 ehrnCHl+84cD3uJ7jSwcPE7HchmZln8cY3YpFMsz9L8M8Q43CVn9+kYpr0jsRwoRY1u/
 UuKJCRpEMK+zh94AqDzB7RsiEdg+sicD0iecI2vrlipX/3+h+1ThQyOCx2SX6b34h3tZ
 MB8LpGkQQqJ62B++kL3H8vQFVUolFReR7cV7fKPVMfhdSDm19GQyyrZI7kLnSJ6YSdF7
 +FJdxif0FfbpWdUMlmjyEoFKsYV30sPx+UvVMN50wO9VpXVW9ZUhRJ78MdfOJxD7rcw/
 GoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705991; x=1785310791;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6wcSGOl6+JpWJlabTA7eh1hIi2KvCsfaAgTtOegcmFc=;
 b=J9lVb4c5NCWDAE0doAUkNNO/xHSXPoBL3SbZcgDj+9yU+n2pnkQ1Uc8baWotjzuqX4
 apeBKHwFWoIgCU0KYB46Ph6Xr1yJdaK7Xi6Iv9GorUPOVx72NCiOwqe31UTZYLvmLp7K
 0+o5vZG8AHHnPtw9dp/N+L62WphdpVFVlqpNEhSSuw1BhvDqsUo171qyNr4lDKJ62LT4
 8LryHfEnax4ZzHGfjJbV64Nx/F1ymSeh7aAJxUSYIQKZqXjtQrB/4hPNXWkPPSVC3K8e
 uU3qdRfErOIbktg/FPnVA+Ce9LXKIFo4PdiF8j9AKfRzwmc7Hn9Tkza3gHsWZkYFzZ0s
 XpRg==
X-Gm-Message-State: AOJu0YyGNX6i/HsZWdhDteCw7xa+Zl2Y1ogUL0fUqpAR1Ae8lFvzsXIf
 YBP1HtnM/sLJaCSO6QXyZGyFts4RI5CP9HUWk5yEcyrjl++FzmfuZBg838kQKsAh3u8ehKj5qKz
 3ggxC2Dh223Mi7zSQOv4Wnmr3NGKmVFuE3wl1FbNSC6nXgBG6hItr7b/z9LEjBnqCieGRniW1mG
 A6qGgYW0Fsrq+4bqVEb+uQ3b/eK+qNWXENryj+RfLl
X-Gm-Gg: AR+sD11pjjcNsTkBuPRhScoxZudLnKTdZH/18+f7PbWic0XN7I1wGV5gVoRmdKwjjn8
 kHmxDFXzlS3lTV87JQuK3UQUg32g41jrmrNvD+6bg00bxcvX9X40DXsqWiyEJi9uG8mFhpjQ0sB
 QnYlrAo01BSEM20pylhsjd6AeipkBz1E7//RE+7pccwuE0r6xbJiWLJ62LabtV5Xq55SGZCDsLI
 8iz+T9ebxkvDsYkZfNp4F6P6E1DxjQJXg+EXMr0hbqwyaNnFaoDvoJiKAkJMQqd0KbfGsJAnYFs
 3WLjMbWDduIfLyJVr6+RQsXogvQbLBCZUj9FfAj1p4m3sBXUBulQrhqN0emSb3A5qrPnSUxx/wp
 k25KL8VjZiD4NJOgTPRZuBy9Dh9NbMPQLZh1RHKLBue1nPM4KirDpU9Zc3X2t8/TokyIKerBOnw
 882GG2
X-Received: by 2002:a05:6000:2583:b0:47f:79ea:6e21 with SMTP id
 ffacd0b85a97d-47f79ea6fa1mr13615084f8f.7.1784705990677; 
 Wed, 22 Jul 2026 00:39:50 -0700 (PDT)
X-Received: by 2002:a05:6000:2583:b0:47f:79ea:6e21 with SMTP id
 ffacd0b85a97d-47f79ea6fa1mr13615049f8f.7.1784705990145; 
 Wed, 22 Jul 2026 00:39:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c532d4sm3383299f8f.22.2026.07.22.00.39.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:39:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Misc 2026-07-22 changes for QEMU 11.1rc
Date: Wed, 22 Jul 2026 09:39:38 +0200
Message-ID: <20260722073943.396872-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=pbonzini@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit ad14439be5731e872d8448a04664a9c0e66624a8:

  gitlab: remove gdb from MacOS jobs (2026-07-21 10:09:47 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e2da3d92744d12b0c2e554ed533a4c9011dbd975:

  scsi-disk: fix off by one in assertion (2026-07-22 09:36:02 +0200)

----------------------------------------------------------------
* meson: propagate qemu_ldflags to Rust link step
* target/i386: helper_sysret(): Check that RCX contains a canonical address when emulating an Intel CPU
* target/i386: tcg: remove FIXME
* scsi-disk: protect against guest sending truncated data for MODE SELECT commands
* scsi-disk: fix off by one in assertion

----------------------------------------------------------------
Andrey Polivoda (1):
      target/i386: helper_sysret(): Check that RCX contains a canonical address when emulating an Intel CPU

Brian Cain (1):
      meson: propagate qemu_ldflags to Rust link step

Paolo Bonzini (3):
      target/i386: tcg: remove FIXME
      scsi-disk: protect against guest sending truncated data for MODE SELECT commands
      scsi-disk: fix off by one in assertion

 meson.build                  |  3 +++
 hw/scsi/scsi-disk.c          | 23 ++++++++++++++---------
 target/i386/tcg/seg_helper.c | 17 +++++++++++++----
 target/i386/tcg/emit.c.inc   |  4 +++-
 4 files changed, 33 insertions(+), 14 deletions(-)
-- 
2.55.0


