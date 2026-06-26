Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2323FCDE014
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3cu-00069t-8G; Fri, 26 Jun 2026 06:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3cs-00069h-TR
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3cr-00051K-68
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xreIHyY5+7ya4HHSXUscLpuskjdoKxa3izYUHOYUGLw=;
 b=HH6c8n8FvMImP1YhEyRUx5VC1Fj9lHyWWOumeN/8tnRHj5Oc5I5xOP28by9kBpzUAwmfxL
 6PbeOllyLg0AQRvR7n/32x8y2rZ0MvmLJ7/MuCFN4emi4IBunjwGEnwPmG9oCEhvyne6lw
 V9YvlJwXEd0TknRmwYX4MASbXd27hOA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-JD0O533NMXaHrP4M7tHBhA-1; Fri, 26 Jun 2026 06:17:30 -0400
X-MC-Unique: JD0O533NMXaHrP4M7tHBhA-1
X-Mimecast-MFC-AGG-ID: JD0O533NMXaHrP4M7tHBhA_1782469049
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46fa65abd21so41192f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469049; x=1783073849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xreIHyY5+7ya4HHSXUscLpuskjdoKxa3izYUHOYUGLw=;
 b=l8DQ3IGQiKE0zRvJbhpDywxjxqf6e8cLniEhr4JgCvW1kXR03sfKqO5gfD+b+GH+x0
 ACKb1PJLBiaWOrNXXckjZNZ+SOYduKvfM/icnkOYlBobyQSQ4hh5O6QO6Rw4OE89wKu7
 5qKE1+RnYSPt54eVffRCCJdIogdFUfscXp99t16TotwZZS6UQZgGLaRcDQFv45kbTetr
 ceM3DWN4SMTxc84e/OwfZtPu3/wjGXDVfqQKASBTd+OvVsr+/zWLQNydUTo6++SWADBg
 v9LwI9BcBc+2RW4aDvvyPbTWnRLaLHK+Gsd+RR7RCyeEckJtp30Gk2/BIFXT2C95ntPT
 GAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469049; x=1783073849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xreIHyY5+7ya4HHSXUscLpuskjdoKxa3izYUHOYUGLw=;
 b=EaYWHObVbYxrLqzfg/hFHJsmyuh94dAUO/kbUC8AqLUFDEoziuX6rppgiqK4VVgHQ/
 Zi3ubS3+DOZdwWCossQONlPLdNPq6Td6EOy+7fRz+PJAtPysnId/iVqS4fwTLoSCXkSE
 92qsS6EPTL06aXl+y6TulfaFdSxYL0qvFyNK7hy/EHL/AU1uH2xeToeeEJ20nVgsO9AP
 yM6NXch3Lwyst73YjoyT16vWn0cqbAyGA5hUrNV70siuPjxYRtOViZSrsUdofJYhFW5n
 tPsFpEGwycouso9QQeFflAsKrbHDLL6+rhXC1Xw9FftkFE+oC3sK4RuS44igrngi+qbs
 eZnQ==
X-Gm-Message-State: AOJu0YyWNTSu77tQW69hwwFZmZcbJBKcseqOMi/7JcAf/hB59jq4TShh
 DJ2/kO2TqtiRoAsEu6yaQIZkWAab6BygsmEgMYoH9vXDnRrelMfSUwywkgc3Z/ljf/TDfR070f+
 +FjRcAGQg5tNMB+17frYcby2dep2hzn0vx7erE4mapvU3hGlcYw7FvgYc2gYa//IOHaTJTblXTa
 +PxN4VR1zPjwsq08+cgXBIAznun19FNZam4aKyqOyt
X-Gm-Gg: AfdE7cl/33kqiHzBdaZRSS8Kw+PHTTD87fe1j4yzijIRLtjoHYYrRyayr+/xXAr1gtA
 AwzH0uMzm8vPQk5MNQA7ilHKF3zg3SpXNo3mZslibQzpaE0alZ9p0HAom4ym4u1y9KFdpXZ5yqs
 NV65PjFkYDNBH/+8wBN3eMlTN109oI1VzcW9ckBUaNX+o36jj8/C05Qh5gHPwsL5otJpbwFB/8U
 YNhrx209p4SMOvnQ50+tzvPFt7dUioTLNG6V/ZaNNFnpGdq5t8E8d9Fy6VeeKONDu9dgG+MCCiJ
 JBE3x6AlvNEuHBzCzUsJHW98kpgyR85G0B4hL3GFPCsgSwfRJifJHwXtBZrmQK55z/47Hpa+WXd
 gKfroroHMk0Q6Hd7r5BPQo7Hvul8jUj0PuValuTGHCZTBG4P0Uh+FjprRJoDsZMpWRBNql65j6e
 ehk1/hkZ4Mw1xh77a0
X-Received: by 2002:a05:6000:454a:b0:46d:d5f9:d170 with SMTP id
 ffacd0b85a97d-46dd5f9d3a6mr6805389f8f.46.1782469049435; 
 Fri, 26 Jun 2026 03:17:29 -0700 (PDT)
X-Received: by 2002:a05:6000:454a:b0:46d:d5f9:d170 with SMTP id
 ffacd0b85a97d-46dd5f9d3a6mr6805351f8f.46.1782469049026; 
 Fri, 26 Jun 2026 03:17:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee0189esm24559489f8f.9.2026.06.26.03.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH v4 0/6] qobject: switch JSON parser to push
Date: Fri, 26 Jun 2026 12:17:20 +0200
Message-ID: <20260626101727.1727389-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This rewrites the json-parser to use a push parser aka state machine.
While push parsers are inherently more complex than recursive descent,
the grammar for JSON is simple enough that the parser remains readable.
There is therefore no need to use e.g. QEMU coroutines.

Unlike the suggestion in commit 62815d85aed ("json: Redesign the callback
to consume JSON values", 2018-08-24), I kept the json-streamer concept.
It helps in handling input limits, it performs error recovery, and it
converts the token-at-a-time push interface to callbacks---all things
that are more easily done in a separate layer to keep the parser clean.
However, there is no need anymore for it to store partial JSON objects
in tokenized form, because the current state is stored in the push
parser's stack.

Another benefit is that QEMU can report the first parsing error
immediately, without waiting for parentheses to be balanced or for a
lexing error.  Error recovery then proceeds as before (i.e., the next
parse still starts after balanced parentheses or a lexing error).

On top of the benefits intrinsic in the push architecture, it so happens
that it's really easy to add a location to JSON parsing errors now, so
do that as well.

The diffstat is unfavorable, but most of the new lines delta is really
new comments explaining the grammar and state machines.

Almost the same as v3, the only substantial change being to
restore the "expecting value" (actually now "expecting key") error
for not having a string or interpolation where a key is expected.

Other changes:
- Add some extra comments to json-parser.c
- Consistently use "top-level"
- Move json_parser_reset() right after the out_emit label
- Avoid <= comparisons for unsigned variables
- Add extra comments about error recovery situations in json-streamer.c
- Avoid double "JSON parser error, JSON parser error, stray '%s'"
- Spell location as %d:%d rather than "at line %d, column %d"

Thanks,

Paolo

Paolo Bonzini (6):
  json-parser: replace with a push parser
  json-streamer: reuse parser
  json-streamer: make brace/bracket count unsigned
  json-streamer: remove token queue
  json-streamer: do not heap-allocate JSONToken
  json-parser: add location to JSON parsing errors

 include/qobject/json-parser.h |  16 +-
 qobject/json-parser-int.h     |  13 +-
 qobject/json-lexer.c          |  11 +-
 qobject/json-parser.c         | 589 +++++++++++++++++++---------------
 qobject/json-streamer.c       | 121 +++----
 5 files changed, 427 insertions(+), 323 deletions(-)

-- 
2.54.0


