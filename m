Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B744CCA474
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmj-0005rG-BB; Wed, 01 Oct 2025 04:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmf-0005qg-0Z
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmB-00067s-Tu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBV2+VUG7I4eiMBuAImYuaKckuDbq+FYw4y9UTZE5Xs=;
 b=FMreVwOYgvxBFPRwDwoTsb0HNIfydI7zY3i0ed6QIjPZFHOCcUqlG9kn5lQP1JY76i8+dy
 nh/xQI6p2a24FRCXuPF3dJmWg4vOF2p2X7VEH/vPax2J4HCq3KicqLX5eDa/puGr5Wv+QN
 LKiTEzSqN8wD8tIw+WwOW4tTbptjwIY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-C7clCZkUO_O8LkD8Qm6clQ-1; Wed, 01 Oct 2025 04:01:22 -0400
X-MC-Unique: C7clCZkUO_O8LkD8Qm6clQ-1
X-Mimecast-MFC-AGG-ID: C7clCZkUO_O8LkD8Qm6clQ_1759305681
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-632d1317f48so8004153a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305680; x=1759910480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBV2+VUG7I4eiMBuAImYuaKckuDbq+FYw4y9UTZE5Xs=;
 b=Cj/5FhLJYqlGJiwZOucz/lhvU4KaQ/SDepCUOm08iv2y7fUH+c/uZ2BFvVLgCg71vQ
 TRXYf3ueavgXSBZpmGR5Q/k7+Wko1EbdZGqEredg6AbDovBE4rssaqgx/gzMN21AEtns
 +k+D2cj2RR0x/Z+YxurYbcni5vIBTcoYUU+n9cWWzNtwYBpuyxXOo/aLvSY0uXBkk3kW
 dxN7qD727IAkuL91QnS+BO4ZDOGefjzQFK6isJnkpKLg3+kX/QxxHm1YkmxBWZwPG/Ta
 4xjcNoJelOpl53h291RwCzrdK+y5ppsYsYYiI6fSNJ5qLv/EP16Fh0RDW5ByNEi8uoSZ
 0ARg==
X-Gm-Message-State: AOJu0Yzn8J/3WMZUP45hZu+kqXiWXy/t979/5t+086igXKItkCxVnWVx
 bpAIy4afvtOip1Jek4FKwP4XDnOS45mca2meIwAHl9Bj/qtKyYTALi4AUyrfUJKQPBeCNa1k+Q4
 f36U+5eOzDFDpgCcMAvVbFgegAqN6vSffxiyamCK3+fTHNY5Fa4pm8cN1qFt84UYN/nKYPllD3M
 MTcaj4K/bexaq1Nppyi0u7eNI+qiejQhaLmVQBE0H9
X-Gm-Gg: ASbGncsIJmymzMawcz48V1U1+fSyFuMxs1ELJBxTeL/iHgqG/NBdw6OscNhhIBxlwuU
 Eu/0o7Z46QfT/RSA/tD5nB+c8CBhbInC9J+9JMynoongxZ96yiTq63aa7S/izZcgJi+I9pkqakF
 8+/qWyPQOmH5dtaiNDvG3iI2m0Lsmc0V1vaxWVVGPbgevD2qZRDwKEgB1tf4weKLT7bZYoMY+1r
 Zag0O2rOwLPnV94rTAt1PRwAPcCZydlhOeeaxwAHJEzb3Rz4TSAi4EQiq7RQ2Vtnj0V+YJJ3n3a
 OpeSXeqr397ll/2J2yA0UF4yX1PCj3EvGysTG+sRN40QUXqp32bSqVeNEEMm5S9jMC//ezHqhKl
 DdUcgD1I97S6x5Sx9B4i0FxO4ig1GmjtKyvACOTYO6IfSgX+K4yU=
X-Received: by 2002:a05:6402:1ed2:b0:62f:26f8:fea0 with SMTP id
 4fb4d7f45d1cf-63678d17dc0mr2956891a12.33.1759305680169; 
 Wed, 01 Oct 2025 01:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8PHvbN/g5zE3FC0Re6MrrE8LISYk/O5fL4TgbzcfB9SPdymwICxoWP9rm7OKbfkdScQO4bw==
X-Received: by 2002:a05:6402:1ed2:b0:62f:26f8:fea0 with SMTP id
 4fb4d7f45d1cf-63678d17dc0mr2956852a12.33.1759305679749; 
 Wed, 01 Oct 2025 01:01:19 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3629cbdsm11315900a12.3.2025.10.01.01.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:01:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 11/14] scripts/qapi: strip trailing whitespaces
Date: Wed,  1 Oct 2025 10:00:48 +0200
Message-ID: <20251001080051.1043944-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This help workaround a rustfmt issue.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20210907121943.3498701-16-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/gen.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 0c9b8db3b02..c9721545ea7 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -58,7 +58,11 @@ def add(self, text: str) -> None:
         self._body += text
 
     def get_content(self) -> str:
-        return self._top() + self._preamble + self._body + self._bottom()
+        content = self._top() + self._preamble + self._body + self._bottom()
+        # delete trailing white-spaces (working around
+        # https://github.com/rust-lang/rustfmt/issues/4248)
+        content = re.sub(r'\s+$', '\n', content, 0, re.M)
+        return content
 
     def _top(self) -> str:
         # pylint: disable=no-self-use
-- 
2.51.0


