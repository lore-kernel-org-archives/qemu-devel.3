Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38883CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ7y-0003TD-BK; Mon, 10 Nov 2025 06:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnb-0004yS-2c
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:11:15 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnX-0004Kq-A2
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:11:02 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c7060a2a53so329805a34.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762773058; x=1763377858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PDJij+lprVMROFEDVhRUxnDiwgjAkm1Tbin3Q0oIJM=;
 b=BHYVpHKN1371/q4DpNwwclZlsBAGnh3f6Cz5eOE/sDFwf9ODzwagEGk9jXtG+IYw1q
 fyTa3v4pAMFn5cM/mhD/RGUZR003KenP7qpUTk/hUQa6zUVlkL3O7ZSh3OnML9CF/qBv
 0j6newGBTWLqIhHzIFyyVhGTD3dO9vb+64gRqmmvj3uJD4AgJZD45bGB9kftZQ9TDZ7T
 WK4Odr9wozIfw41Kb5CteUGmtdU6Wj2mSEcNkONn/p/MHUJA9P1v1ZUvV2qLC7WdniB6
 dJblUNGLuATlyKm/X+CIX5T1gV8dtchVnyBS4okcM42EJU2w/7HYxpxwHXVMriK9J4gb
 A7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773058; x=1763377858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8PDJij+lprVMROFEDVhRUxnDiwgjAkm1Tbin3Q0oIJM=;
 b=VQ0HBNTAhZt2vlH3c54E4wHe5YyLBKIkeMDoCc4Imer+E3EQp29kZNs/xWiUdhGYmS
 XOT36Bl6rUdLI9ISEPTphF+KP8uryDh9IKpFFOGF3OvLA1DFFxvQcySJGUkHT4xljLJW
 LuiBmjYGd3JIudoVH2oSJyRs6kDjq+Lx0c02wC7kQy0Z1ZefhtA1/DVX2ahjdZn0MZTf
 m3AC+nbM2IEPqCaQwIJWBzo5d2vNpgdZ28s3U0AKo6aeSPzm0YAv9P86kTPotKFFff2n
 8o/KM2WZCEJm5+vBhpUS4NHOHuWr/Zam0joaUqbwEdH9kNUhBos86EJe0VD6ybi+PaIH
 VXdw==
X-Gm-Message-State: AOJu0YyJ/m1EkmlJxitCIw40hbP/SZGP9LUJ3u23CHG9wf8gC9TWFC95
 aPH4VKgSeAn9vz3U4/LP3kYKi1JPmNQFonfRYi0Joe2TCejWnlhY4dWMtJ7WEMPC0X9QAGROsDy
 rDbyu
X-Gm-Gg: ASbGnctrawON+ny3UmuDFZxC/o9fq4vNpf9afp5var5DvZdti/vQZh3K/CTCtWJNaXI
 jocMtMhS45z+Dnh08gC+nrT+wimUDsnuWdkT8WLEDz6DXJmJiu9xqSe15xzUw0+PK3A9iqa/ywm
 DtVtCzwqCu+UGOFnv5BOGCFZfWvZbk30d5HgE7Q1gesL/vV4AgJia+V2EToinjWeV8e7gULGcEy
 TNgx6cmiMZhPlgscbfWOXl6imJViZ0lUNPCtlzCpP6NKeVJjJPjXn5kDsbrSxORfCYi/hFkQlY+
 KC7R1F05HJjxo0eC8gL8pDf8GV6IIGJNt3aUvBp988TWW923S8GcfttLpWtdgEUO5qyZg6EEgmf
 mnTYod6yRHNGVw47efFyw0NOL9SUR4o3pnCj2YqhwJ/nVqmu2u+OcMsqIaLbvOdsB5Yqpg/SzVz
 2uGioud4sNZ8E5qd5tn+vsfZ4hn7ZJlXYYloXjzXuYjn98BKGucHQ=
X-Google-Smtp-Source: AGHT+IGAghpgLGQscYtdjsAwKnv7bFpYppTdkeAOsStGcNge5i7ssxg4grAYqHxl71vvSAOZtGseyw==
X-Received: by 2002:a05:6808:6f91:b0:44d:b8b7:fbcf with SMTP id
 5614622812f47-4502a1bef92mr3955598b6e.21.1762773057998; 
 Mon, 10 Nov 2025 03:10:57 -0800 (PST)
Received: from stoup.. ([172.58.183.226]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450426be56dsm1603412b6e.18.2025.11.10.03.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:10:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 3/5] qapi/parser: Mollify mypy
Date: Mon, 10 Nov 2025 12:10:43 +0100
Message-ID: <20251110111046.33990-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110111046.33990-1-richard.henderson@linaro.org>
References: <20251110111046.33990-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

From: Markus Armbruster <armbru@redhat.com>

re.match(r'^ *', ...) can't fail, but mypy doesn't know that and
complains:

    scripts/qapi/parser.py:444: error: Item "None" of "Match[str] | None" has no attribute "end"  [union-attr]

Work around by using must_match() instead.

Fixes: 8107ba47fd78 (qapi: Add documentation format validation)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251105152219.311154-1-armbru@redhat.com>
---
 scripts/qapi/parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 1bb1af7051..c3cf33904e 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -441,7 +441,7 @@ def get_doc_line(self) -> Optional[str]:
             self._literal_mode = True
             self._literal_mode_indent = 0
         elif self._literal_mode and line:
-            indent = re.match(r'^ *', line).end()
+            indent = must_match(r'\s*', line).end()
             if self._literal_mode_indent == 0:
                 self._literal_mode_indent = indent
             elif indent < self._literal_mode_indent:
-- 
2.43.0


