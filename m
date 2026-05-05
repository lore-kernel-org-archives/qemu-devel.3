Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E792CD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK9b5-0000Ap-9C; Tue, 05 May 2026 02:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9b1-0000AJ-Vp
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wK9ax-0005lo-Vk
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777963765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tOPWf0cEZ+gIOqvbyelND9EvW2BUIbr4031aduoHrS8=;
 b=gFJWiniCyMXHeD8H6MtT75ummdG78pXhvHv9cQJAwojfAYVXuH9g6UIuL0TiKuxpDEFsaj
 U/OhCaNDunlZzVzrpVfKo24ikDCW7bToMTLzWQYnzZN+6ySzz3yPfKend46gSG9WdcREbn
 9sLESSqzwTeO/9ghMcniaW4hMOVkh8g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-5MIimgddMf2hgntoUfNEHA-1; Tue, 05 May 2026 02:49:23 -0400
X-MC-Unique: 5MIimgddMf2hgntoUfNEHA-1
X-Mimecast-MFC-AGG-ID: 5MIimgddMf2hgntoUfNEHA_1777963763
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488dcaf2f2fso36807355e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777963762; x=1778568562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tOPWf0cEZ+gIOqvbyelND9EvW2BUIbr4031aduoHrS8=;
 b=p4qAwyeMCrfNBEMZRMQefXnSjsuI1MWVq2Yep0+t01lI0Q36BwLegagfCDwB1SuW0/
 67ZngeY1YqKi1WfavdEjw/0D/86s/gf0hmTtLQ2OBnl5h0CGZe5HKKhJAv671ntvdWXu
 t5YyjaqA+Ptn82UHyAcTZ4HNpCIqTWcJoGucLBvD6rZs2YLg/aQ/871AiB0yzyt6wweM
 tywfCQWEE0LQiCEw28mbGyViKs31VFQJr4osPdWlFEalJ3xg4oPnrDyGM2CjFi3Aa405
 GYII+j4IOHFKW1iMKQvqzBASdsRyHOxwBHl0Pm3LPegZCXn9qsmyUodG3BvJ3MHn20iY
 YlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777963762; x=1778568562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOPWf0cEZ+gIOqvbyelND9EvW2BUIbr4031aduoHrS8=;
 b=tJsTxnRH7iT4ztrKmYYJWv1RzMu7xW2dCrsswxrpG+AkeoVqCLbBpe46nd6BBq82M3
 iC4oqUzEN+PG+ASWpPdDa9Y7U/eMrUymH1L3/38riDwAnYqhydrTwwcJnkIgsPgUKm+U
 s4KunWmP+3zLQcKahOjYpa0rE6vWmTZs8gGCAqY7Tu5eYIN7lyUpCkZoJI4cfRcKbK4Z
 jilu4GxpTqllalZJoT9Tc9+qnbuZ0txKtFutz2g8Ulib4RwrcvztsggHZzOfekadLOdc
 TrwKIyx24roJSs1u9E63pLYil7OWSebvaEvt463dtTJ0ifT3T/tPoGfgc29JLH9g2Z6p
 Cz9g==
X-Gm-Message-State: AOJu0YwsCDL9Pt1+KJEsuRDlnW/BIrUehu9InxIJSuP8WBQGqLKQ4JX8
 9SLRIWwjOmsyzqMYKEGi2YBDVR7VHXjWjJOxsMH3gmi6rYAwpxlUK1XAw9Y4suI6jIXlzfm+Iju
 kqfnrL9MGFK34aLyBQG1XUCu3oCw9zvUWyKXacE36RRkABpgjIurYDdbofuMo2Vb9EBLiEbxekM
 SDBvxHD2HBcfUgicq82by4rSoOQwUd7qeYgK9mZfEK
X-Gm-Gg: AeBDievmGbGTo1v1mPrqWHWF0xWKaljuM/1OUBuPuvmmVlrWzNXNwMegoGsa4+MfG60
 eu+QWyhLnGbfgvdoLeaQ0n51619TekFevCIlbutj3xoKRtXtllNSDZcl3lDTsE26q8etcDoLj7u
 CFLl8/RrGE30mWxhGEM0SmNW80KPrIlz8XLCDq4FdslOvD5yTgpiDgxog2RM+8zj2e8k3pRUOTW
 /DFI9jchjWFsxefgy9AuHQ5qZpcxU/FvYbZFs9UrbUkrixZ1X09JrB4jYaocogwGeD/F66hzRvF
 hkRQSLbsROCKZNBJOZHfl1pfIKlD1+6c6F/bjd7QWnpG+VSQBG3mZqjRwoNZL0rrhkk8Lk5l5/S
 Hy+f/t48+9GXqPy/aVUabos32kRgg1UGtlxvtJxeVcWJ3O+4HUEPDduMgZM6LBQjsMReQpJ1cGR
 asZThYAUAAI0kHCmjAl7rtQ2DpTiyK90ObvUG3CG0=
X-Received: by 2002:a05:600c:a08b:b0:485:7f02:afd5 with SMTP id
 5b1f17b1804b1-48d18be5a4dmr24839165e9.13.1777963761719; 
 Mon, 04 May 2026 23:49:21 -0700 (PDT)
X-Received: by 2002:a05:600c:a08b:b0:485:7f02:afd5 with SMTP id
 5b1f17b1804b1-48d18be5a4dmr24838915e9.13.1777963761263; 
 Mon, 04 May 2026 23:49:21 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505558e213sm2132188f8f.25.2026.05.04.23.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:49:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH v2 0/7] qobject: switch JSON parser to push
Date: Tue,  5 May 2026 08:49:12 +0200
Message-ID: <20260505064919.177855-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo

v1->v2:
- remove part of the patch to pass around the lookahead token,
  it was hard to review and added little value
- separate patch to reuse the JSONParser
- separate patch to make brace/bracket count unsigned
- add comment with the structure of the stack
- add big comment with the grammar
- split long lines
- remove QObject **value argument to pop_entry()
- add assertions about the type of the top-of-stack
- change error to "key is not a string in object"
- split out json_parser_reset() already in the first patch
- rename json_parser_parse_token() to parse_token()
- do not use single quotes in commit messages
- move initialization of JSONToken close to usage

Paolo Bonzini (7):
  json-parser: constify JSONToken
  json-parser: replace with a push parser
  json-streamer: reuse parser
  json-streamer: make brace/bracket count unsigned
  json-streamer: remove token queue
  json-streamer: do not heap-allocate JSONToken
  json-parser: add location to JSON parsing errors

 include/qobject/json-parser.h |  16 +-
 qobject/json-parser-int.h     |  13 +-
 qobject/json-lexer.c          |  11 +-
 qobject/json-parser.c         | 577 +++++++++++++++++++---------------
 qobject/json-streamer.c       | 120 +++----
 5 files changed, 412 insertions(+), 325 deletions(-)

-- 
2.54.0


