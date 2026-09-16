Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADD5C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xJ6-0000jP-47; Wed, 16 Sep 2026 17:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIW-0000hb-Nh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIU-0007ZQ-Gb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789594565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wPV+wuNkzUmdU7WghaCopt4Hj0ZBZYJ3tieB6qqgFNU=;
 b=NA8fBQYTuyEucgkHrZjztftu4UrPcr7W6/B9u5lgwizWs8SLKzGTszfXO2IZ0FKUWzCb36
 xBjpXKfg0YcRABQCmVcdf1JiWs4CeASdJ6O46P2UEpcnSKqfXIKpoioWBNoMclHa8A7AIt
 il/u7o0g9/YgcezwhHKHeckR4eULjhI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-GRajgwkGOO2MQ6x2991iLg-1; Wed, 16 Sep 2026 17:36:01 -0400
X-MC-Unique: GRajgwkGOO2MQ6x2991iLg-1
X-Mimecast-MFC-AGG-ID: GRajgwkGOO2MQ6x2991iLg_1789594561
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91219341db7so2722756d6.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789594561; x=1790199361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wPV+wuNkzUmdU7WghaCopt4Hj0ZBZYJ3tieB6qqgFNU=;
 b=GBWRMSxcR3TNnUj7URx4rlcWqaeiEkbM+ojVw5+aHmacWvI0p/ubUsrIttAw9TYzT1
 DW09cC1Uq6bG2RlyFyFAkdbaBGbCcXJDuGq70YDFYKkld5ZTul/qEn9hb+AzTPlsm1ay
 wqLIFLiw7FkVb+oNiv0nexBnRrUqjMKsSLbkdXqe3x6EPes4VXAMlxxC41bRg6zTZi4N
 W/9PGDIeTvniux5BJjWpzuIebtUKBE3GtBC+/mmERR0V3IGIbX/MJGtmheV1eDfNjQEx
 nkOh1Qcz5Iy5833qvDoypOoaedJHiaJRefb1FF/v17vODrN4Ur6Kw9DRkF0nrZOu7rO6
 W1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789594561; x=1790199361;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wPV+wuNkzUmdU7WghaCopt4Hj0ZBZYJ3tieB6qqgFNU=;
 b=2qyFzQ9bSLm5WV4Oon+wOzVMsu3yVkosz8jSuFfVyuqT56b8wTyaFR4WijAeI4UYtu
 7f9yAW3v8qLn57x0JxYK4dyWJ/LA1IDW4gltzE3y7/rXT2y3yJjwxFI1EZ3eYCB/IRIz
 +09A6T8w2khvovqq5fsKMiLRQnGG8R1dK97PUPBoi+4g8+tBQHTXp68LI3hnFSF+5nQd
 QMDKKcb15sbkSNwLD2WdGdr92l26oYi9trizmJBJH0g02fY0LeJKi6oao5HSFrB4zopp
 sNoc8w5re2zbKY6juT3OLeFsuXUvHMIXidOjrcGvyRLX7IExhOZrg3rotKXicTygm/YJ
 4paw==
X-Gm-Message-State: AFuF++nPGB8I75Upqxsprp0fRB3DxAwkKjvdOm6C2r84Gz3cL9CukUN7
 TYQJE9FP6miby8OAfg4rzlm6PvT0L8tKULq3m6twOR5UBCv1SP0EP5A0IhuOciNK6JMXZtdtjXt
 dgs/xUBWJvCR6vBWu/9oY+H4XVjKnbwboVRZI3h7TQV8kN2W/iNMT9zIQR37DeBioOb7pLEfOZv
 kJp/Bz+Su9tZ/f/ITFKHLK9BCY7cDwm4v3wYFng+Ky
X-Gm-Gg: AYBFou1kpjYciGi+qrYiKwBX17HYvYc8kSjt/Jf+zDAI6n86eomo/6CHl7mVF5WJFiK
 m7em7kQJDb00/K1dEIefo0tjt4fU/iMD8bfo7+KNvUspzHg4FspDrj6jSrzPnAv/VZb8VX1YOZ/
 op7hLPo5h8/OR2uieiYPhZ1ukw1W4yedyoJJSi+KWwbNwAXx6Zn/GFHU5OWREg0w40taxuaNg1A
 qVrZgSU+zcqe5o8h8iEIKeumjvwprxCxtCWzRUx5WuuLc8NvLVBR8lETbz274JLca4ylNI97Lzx
 0NHxyy+3zlYStYX9pTrzAUuOMQ0aNz0Blz5rmLz19j0n1OAyU+OkoaNJtG97o2wrhlaRtBpsduI
 wkspdKi6OeB44NOGU89OVCv71v/sKKCaq2bCEBWj9zO96R3QMMFyCYtU+B5U=
X-Received: by 2002:ac8:5e49:0:b0:51b:ecbb:206f with SMTP id
 d75a77b69052e-5327ef395d8mr73359421cf.32.1789594560644; 
 Wed, 16 Sep 2026 14:36:00 -0700 (PDT)
X-Received: by 2002:ac8:5e49:0:b0:51b:ecbb:206f with SMTP id
 d75a77b69052e-5327ef395d8mr73358681cf.32.1789594560022; 
 Wed, 16 Sep 2026 14:36:00 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123be946f0sm34844886d6.27.2026.09.16.14.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:35:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 0/7] migration: Fix multifd+postcopy break on qemu-7.2 machine
 type
Date: Wed, 16 Sep 2026 17:35:51 -0400
Message-ID: <20260916213558.587304-1-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

CI run: https://gitlab.com/peterx/qemu/-/pipelines/2855601505

Currently, upstream is broken with migration with qemu-7.2 machine types,
simplest reproducer:

      $ QTEST_QEMU_MACHINE_TYPE=pc-q35-7.2 \
          QTEST_QEMU_BINARY=./qemu-system-x86_64 \
          ./tests/qtest/migration-test --full \
          -r /x86_64/migration/multifd+postcopy/preempt/plain

This series should fix it.  Note that this solution will not work for TLS,
and due to the fact that TLS is not peekable (which the design of this
series currently rely on), TLS is not fixable.  But as long as the user
doesn't enable all four features (multifd, postcopy, preempt, tls) then it
will still work.  I have much more info in patch 6, feel free to read.

Patch layout:

Patch 1:    Added one more test for multifd+postcopy recovery non-tls
Patch 2-5:  Something I found either buggy or good to have cleanups
Patch 6:    Fix the problem on incoming side
Patch 7:    Fix the problem on outgoing side

Tests I've done:

- The qtest, concurrent execution of a lot of "migration-test --full",
  which I normally use to catch race conditions.  Nothing pops up.

- Test migration with all three features enabled (multifd, postcopy-ram,
  postcopy-preempt) on different machine types and binaries combinations,

  |----------+---------+-------------+--------|
  | Machine  | Source  | Destination | Result |
  |----------+---------+-------------+--------|
  | q35-11.2 | master  | master      | PASS   | --+
  |          | master  | patched     | PASS   |   |-----> 11.2 machine not affected
  |          | patched | master      | PASS   |   |
  |          | patched | patched     | PASS   | --+
  |----------+---------+-------------+--------|
  | q35-7.2  | master  | master      | FAIL   | --------> current breakage
  |          | master  | patched     | PASS   | --+
  |          | patched | master      | PASS   |   |-----> patch any side should fix
  |          | patched | patched     | PASS   | --+
  |----------+---------+-------------+--------|

- Manual test of qemu-7.2 binary <-> patched new binary with either (1)
  multifd migration, or (2) postcopy + preempt migration.  NOTE: qemu-7.2
  doesn't support enabling all.

Comments welcomed, thanks.

Peter Xu (7):
  tests/migration-test: Add multifd+postcopy test for preempt recovery
  migration: Add two more trace points for incoming channel mgmt
  migration: Fix socket listen backlog
  migration: Split migration_channel_process_incoming()
  migration: Dump type of channel in set_incoming_channel tracepoint
  migration: Fix incoming channel race with multifd and preempt_pre_7_2
  migration: Postpone the outgoing preempt channel for preempt_pre_7_2

 migration/channel.h                    |   6 +-
 migration/migration.h                  |  35 ++
 migration/channel.c                    | 453 +++++++++++++++++++++----
 migration/migration.c                  |  58 +++-
 migration/socket.c                     |  25 +-
 tests/qtest/migration/postcopy-tests.c |  11 +
 migration/trace-events                 |   8 +-
 7 files changed, 515 insertions(+), 81 deletions(-)

-- 
2.55.0


