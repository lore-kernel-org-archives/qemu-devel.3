Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65460CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWrj-0000kC-98; Mon, 25 May 2026 11:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWrh-0000ix-MQ
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRWre-00012z-Ot
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779721508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oEccc61KJRL0zGCF9LdUGokj09V7lLeK+5cqo65gnfc=;
 b=gTIaiag4j+vnSx1g4UgTh/QmxI7MoMEfki6ZWZBnAVzmtzFWkGgd5CwbfylTRRM6fvDCjY
 a6n1IY/efU7IU3J9jrLO1QrI5gLUrwPA6ENFjP1dEhexOK/4MjitfF1hoL49ZgS+QWFQpi
 0Yn/qHUYWOi0PiM5HYj+pHVUbrRf9I8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-YUUccqOVNdSdtOyfJk8cOA-1; Mon, 25 May 2026 11:05:07 -0400
X-MC-Unique: YUUccqOVNdSdtOyfJk8cOA-1
X-Mimecast-MFC-AGG-ID: YUUccqOVNdSdtOyfJk8cOA_1779721506
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48feb0298d7so76351035e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779721506; x=1780326306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=oEccc61KJRL0zGCF9LdUGokj09V7lLeK+5cqo65gnfc=;
 b=RA7+2g5TZCtomhsan00ZviMJ2MyAPL2sGzjEum/0StEuj5mi/PnS6pN4xDmrElq5ls
 dl6Qo4vyfxoORfSZ9+9hoQ3bixCyrQrMF7lyKIFvopIuKNJl0n6rQbRSpMv0Ds9VAMSG
 KJOVaZUXp3QL2Y8u8kFmRFCtoQCvFEqeicC4odGFZOqxHtohY7Zq9/MGohx4JRcMmI3q
 t9svR28qePcDStFMihk+lIhMQhJ/5BNpSN7lxxytTlwQ+yRN8EYMYiayu7ywS8hxRytw
 Xd3w+SEDAoZB8X8Zwb/FkmfY9LKXvZwWXb+k+K5b4eXtXRiMPA5/MDBg5W7FF6kdR/wi
 kP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721506; x=1780326306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oEccc61KJRL0zGCF9LdUGokj09V7lLeK+5cqo65gnfc=;
 b=idJ59ax3rTKaj3zzGBMDxipaGfIzjILrtgFR3BbvyUscBSaEY8pc1ITS+xpsMV2KjC
 q8ZiYXxtHWnDW6qaFqwvGetMOmhAP1lwnjScudR146tFKeZzTAt+GZPVofU9Rp+DFmun
 GrNTlO897N/PXHbf8x4h4GOF3Fgqnht1paV/YkrnV/JK/SBelFWj5nFOQjwemhiiU4+M
 WWCA51/DFWWekTElqdqfMOI+FnkmbiaUrriF74SVRRqR7YkGF6Vq6W6gPneONzJKXwyq
 dAgoPj29hHf2ZblVqfDlK7YJmF/Sp/25aqI7Gv+MFj7Rmt0qXbfxmG61vjOkrWHD4uuw
 FeFQ==
X-Gm-Message-State: AOJu0Ywd7shofYWqQ3jPOKrrDUzqPOG+e40Nh6QXBjk2WTwYCOdEdwJm
 6oHzVFZezCdPMr16USNXfSDWUz4xXvinf3Dvd0qhGshjl6DVBEYQ9qSN+9etrDojsCEabN/eTw6
 1+aP+L+wbSsKGQGdsm2Wu2zSwcc9s57lbFJtkc5mAAvjuk8ZWNpHpliDG7fB9kW1FCB1qQOy5xb
 TY0zs1Pier2qNLQKOplrV9yRj+9yWeNvtMzacaSFtU
X-Gm-Gg: Acq92OE7Ww+UxCyqn6gxdw2bYPzCvdxJUwFXRsSOEYeicPaIGHkvCU/T45m3oF0PywA
 T1vvAM59VYITlNUdWoCGG2f46CnlasqQWznYRTv7RMtmwjFWjgP8SuTZx7B2pw51MO1S7wSQbgu
 ZDR/c3nFg8f2gv5hLKoW0lvN0BDGVWB8r5LBW+CeRsK1MkoJuFfKEI51kU8IlfgAuoHMjTxgHxo
 QRRuUMhI8k4GPtsnFdDmBA71RDWbk8w/M4I9hl+PqdPyt8s4dwPOOFaV6MvEUTYa3vrak/RMfjT
 KBYcvRh9jTTCnPMBOZ0yn0duWJM7BuV68O8H7hxzf5zKA30tazq301gk9DIFp2LSmOguZUq/PqC
 NUOJlONbOBqvgwL+9Zfr+j6T/9NR1FN3eW1GoQwXxTYIX2KeQ1H0r2xwKZsS6LtM1gEbNn2fcZY
 dAPDlSv+GtVdUxlZ4SyH9paLjBXZi8
X-Received: by 2002:a05:600c:3b9f:b0:48d:35e:82cb with SMTP id
 5b1f17b1804b1-490428e93d6mr266057335e9.28.1779721505832; 
 Mon, 25 May 2026 08:05:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3b9f:b0:48d:35e:82cb with SMTP id
 5b1f17b1804b1-490428e93d6mr266056275e9.28.1779721505136; 
 Mon, 25 May 2026 08:05:05 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428d3e9esm115283545e9.7.2026.05.25.08.05.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:05:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] qobject: switch JSON parser to push
Date: Mon, 25 May 2026 17:04:56 +0200
Message-ID: <20260525150503.393743-1-pbonzini@redhat.com>
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

v2->v3:
- accept interpolation for the key of a dictionary

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
 qobject/json-parser.c         | 580 +++++++++++++++++++---------------
 qobject/json-streamer.c       | 120 +++----
 5 files changed, 415 insertions(+), 325 deletions(-)

-- 
2.54.0


