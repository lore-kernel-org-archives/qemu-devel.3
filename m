Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ADEE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 20:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLT9b-0007Jm-Dr; Wed, 11 Dec 2024 15:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLT9Z-0007JN-8U
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:17:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLT9X-0004CX-K4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733948264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ioSy81jlwFDJiRoLG6VbJiujDhp2fFZqvCxUqEYproo=;
 b=X+fogID2nUgJqjYqBUbC47xB8NQxEz5zxjWq8Wx1zUZeOSOpNhHkkwR1xes0/mkgb/map9
 lpelUhTsKMlKtpNQ2qh8pTNjLYbA/5IBvdTQ6246c2/M0pwgLLSlTw+bU1IS//hYj1DvJV
 aDp7nys5BZBjhoVS2jCQVwhdYrNGQrA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-NoYdqUXTMqKiN-mwAOAAEw-1; Wed, 11 Dec 2024 15:17:43 -0500
X-MC-Unique: NoYdqUXTMqKiN-mwAOAAEw-1
X-Mimecast-MFC-AGG-ID: NoYdqUXTMqKiN-mwAOAAEw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d9135afda3so59875626d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 12:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733948262; x=1734553062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ioSy81jlwFDJiRoLG6VbJiujDhp2fFZqvCxUqEYproo=;
 b=d6snbQWem8uJSAI93Nf17dE9sLHPHFnaFFs0XlkxWXzQdCmE0fCeZPBQubNqmM7yz5
 bHXgg7LX7iesDN+9hCAMgTRRntKizMreR6L1GlY1UOX1TwR+ols+HpLbUOwrf3RiYPjR
 /HKCiQwGb+SGhOzYHmtq5+bQCmOlk14qbuP0suu3N0cJ3XfNBkeEEBNlWqxZ2THGF30h
 rTR1hAhWkmnfFNXNtRtNCrnUesVFB2mick7UUYNeVY4p2/zBvUI8ff03BGUOjzzIOF2b
 xtVRqCF/hA/pFwotEalTA2cZLtGUaJsVHrw0zcTPaMa42dDPFJYwnsPRqXygIiV0dyKg
 XrIw==
X-Gm-Message-State: AOJu0YxeHYC9DLx6tNv89reIYg7rE6gIT0FUQjdtp4Hd08PXOiWzXHI8
 zOu6ru8aPBUYI2dUMzWHNf2EiUqaLR71u2vifliVKedubQTNdcqtg3ym2GCHIpyd31p8g0aWETG
 4zoyccVst5IN87eHGRgem+KQ5Ki80bXDA1k4cMTs/j5w9M2Vl9UnQqu1gYb6q3rZMXwTWwiBOk6
 BbKKTbgCj7ROgfMSvLJQVJRAlxPk9otudcOw==
X-Gm-Gg: ASbGncubcMYuYlpuKQCKa80BlpDn+3rzQ3HGOHLfq1jojMlMdetT3f/u6ghFwoN5LnY
 OyLJUxEtbJkZot6PToE3EIufgsgzqYO4lqU9Af064A9fx7ZR93YD2Mnf/L64xbXGEpbBHcgvJAf
 CC3f93fsvbFLDm96DyWI6/PyDGmNGX9RTRqpwi0lR9eVg4i1DEdcjCOSjH3Y5zBS2+6qRjNurDK
 x6J/PS+Ljx7wHpkC5jDXMhbMmNi59xMeELt1WVycsffhTGpkvZBNCtcbdnCsJO3WTNgSQUDjBU2
 8zdcnTnzXUuj6g+eXW7ZEZ5emKVbzw==
X-Received: by 2002:a05:620a:1a95:b0:7b6:de65:9ee7 with SMTP id
 af79cd13be357-7b6f259189cmr105767585a.43.1733948262245; 
 Wed, 11 Dec 2024 12:17:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvfrJ+Ogjwv+m0jEVSVzCBuLQ6jLMib7MLtfB9Jj1vbTP47Mt83VaS4yQnty3JlciUKTEqNg==
X-Received: by 2002:a05:620a:1a95:b0:7b6:de65:9ee7 with SMTP id
 af79cd13be357-7b6f259189cmr105763585a.43.1733948261848; 
 Wed, 11 Dec 2024 12:17:41 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6c8c6425csm438857485a.100.2024.12.11.12.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 12:17:41 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 0/3] scripts/qemu-gdb: Make coroutine dumps to work with
 coredumps
Date: Wed, 11 Dec 2024 15:17:36 -0500
Message-ID: <20241211201739.1380222-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Coroutines are used in many cases in block layers. It's also used in live
migration when on destination side, and it'll be handy to diagnose crashes
within a coroutine when we want to also know what other coroutines are
doing.

This series adds initial support for that, not pretty but it should start
working.  Since we can't use the trick to modify registers on the fly in
non-live gdb sessions, we do manual unwinds.

Thanks,

Peter Xu (3):
  scripts/qemu-gdb: Always do full stack dump for python errors
  scripts/qemu-gdb: Simplify fs_base fetching for coroutines
  scripts/qemu-gdb: Support coroutine dumps in coredumps

 scripts/qemu-gdb.py          |  2 +
 scripts/qemugdb/coroutine.py | 73 ++++++++++++++++++++++--------------
 2 files changed, 47 insertions(+), 28 deletions(-)

-- 
2.47.0


