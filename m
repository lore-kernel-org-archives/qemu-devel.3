Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0147DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lh-00012D-8k; Mon, 03 Nov 2025 16:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1ld-00010n-O0
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lO-0005Jc-Rj
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdnH+0u+VOkpdCmJkp69LW5DtXy26by2TmG5kvQNIqo=;
 b=Qk+lPBW51zl+mcaFWT5IpX27M5eU6R5lxpDIiI40hhBqrhcLWX1l1TAhyQgo0IQwW1uJ6b
 oPskZF49TCTIBxkPeGFr8kYSNyINcy6QCSSEWBdMLckApl3Mv7PZGJyALK0KQyTRpr6ac5
 YIJNv1uUw2BRLb55tB48+d6bwBWumrg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-CSlIgo-JOXK8ZuXJgj6KJA-1; Mon, 03 Nov 2025 16:06:49 -0500
X-MC-Unique: CSlIgo-JOXK8ZuXJgj6KJA-1
X-Mimecast-MFC-AGG-ID: CSlIgo-JOXK8ZuXJgj6KJA_1762204009
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-89f7a8b9775so1407352785a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204009; x=1762808809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdnH+0u+VOkpdCmJkp69LW5DtXy26by2TmG5kvQNIqo=;
 b=O3I+Gy6g7zLJnXGNeGE1uhS1msAyzpvtL8IeaNPURsEczIzPLdN0yxI0cKOalk2W7C
 VVWaGNH2miZSFH+N/p0+VmFEYAjIZa87e6IQVstG7nFHnsnG6/rXPwMuDg3M8fIf10Y1
 qcUsaOVbNpQGGlO5F/ebKdcolx/e0MIm1QaXmktebj+8EUdd5yA87QtXfziE2GVKQr9q
 ZdUZZqOoIplYgprBdAH8vRiZ/vAmPKONV2v4frvJZsA2md4XMBhq3DlIhffNTt6GF3SC
 X1jp0uQ4Ub9HWXcMFfizGiE/HxKI/cTIhHKU+4bLnKIGiUswVBeK8JKthYBrtSzaF4OB
 RKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204009; x=1762808809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdnH+0u+VOkpdCmJkp69LW5DtXy26by2TmG5kvQNIqo=;
 b=FCZTjl6DZvrPRR7TqAuwAgKIUfwZN7rCKMco+8J15kUbw1I0SqQu1Ls0HIyCQoqNlp
 3zSfi1kFsKU0bwrwBlFu4U65dJQYo43xpIeqNA3h5qisTRRRhDcY8WmI8Zk/97ECZFgC
 mzKe8xKmGeaZpCvXuNX6Ct3L7FtqXKgnv13aZyIdEuj/I24YtF3wsIL3EcpPRNGWKDCM
 pt7myx0RmeTOQbupC8PuFUkKW9ZvY/nHopMBHIzW7KfPFWD8vd4OQSQvIE55Mg922SuX
 +x2l2nlWRBkeJaqeDMi1GcRnr+KXaj3pzPtb2vSzIkBks2+9b92iTQRgBsNjtTSsY5if
 sNrA==
X-Gm-Message-State: AOJu0YxiYnA0VaycuAxANcp84+PTK8ymCoyPPUmC7aAWevwkQsPLpHo/
 gdFET0ofVEgO8y3mk5vOKOzQ5GjpXzbCs6MpeWI9apOwZ9U7507XqZN0tHyd6S+R1E1lZk6+Lu6
 AGBE05uPa7B19a6ZokkMvfy8PwH62sEgt590WRQ35a67gBVms+Gv4WMCE9y7mBXG08EhMYHEq2T
 dz9JAt4Ec6FX6TdQsjyxXD5Cnbs8PASY9qL6qxuQ==
X-Gm-Gg: ASbGnct7xXtpEnXGT1CV2goDDTrARGxws6HsCYEmRa1KZ6k9WL9YuFgwmrISIjS4fKa
 DVxh9Sj8NyN3HUTGAhQ+UpFaWGigPFl4jw0ZQeDISyZeCt1bJXR1mxOFVeqXOTV2d8af05n4VEE
 5ZQ5b/jZ+5tnBQgshbNjC0/n7FTRH0CZaCR0hWJ78zmZlNIb0rtoS5AaYh6eeEbu6MjIarqe7tc
 fDjGH4fdGskC6RUYFA82G+ytrz8AmlK/lu9R9wnDVQEk7KfCfo2HrbP8B2TD6JtGfpuoyEUeLDd
 2mTXbBYIvHiTDQ3cc0urVFbLfs7nYhMd4jB8UQUXGr/iu/N2DZ64DJPMWlsukewz
X-Received: by 2002:a05:620a:19a1:b0:8a4:4156:16e with SMTP id
 af79cd13be357-8ab98eb5107mr1706570785a.20.1762204008777; 
 Mon, 03 Nov 2025 13:06:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzbrhWMdqMM8AavhOkeM3h2dnzUKJp4HuGM6ceihOq2qFSFt8epdtML9/HoSb+Q2D0583Elg==
X-Received: by 2002:a05:620a:19a1:b0:8a4:4156:16e with SMTP id
 af79cd13be357-8ab98eb5107mr1706564485a.20.1762204008197; 
 Mon, 03 Nov 2025 13:06:48 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:47 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/36] migration/cpr: Document obscure usage of g_autofree when
 parse str
Date: Mon,  3 Nov 2025 16:06:03 -0500
Message-ID: <20251103210625.3689448-15-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

HMP parsing of cpr_exec_command contains an obscure usage of g_autofree.
Provide a document for it to be clear that it's intentional, rather than
memory leaked.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Link: https://lore.kernel.org/r/20251023161657.2821652-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 847d18faaa..79426bf5d7 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -734,6 +734,12 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         visit_type_bool(v, param, &p->direct_io, &err);
         break;
     case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
+        /*
+         * NOTE: g_autofree will only auto g_free() the strv array when
+         * needed, it will not free the strings within the array. It's
+         * intentional: when strv is set, the ownership of the strings will
+         * always be passed to p->cpr_exec_command via QAPI_LIST_APPEND().
+         */
         g_autofree char **strv = NULL;
         g_autoptr(GError) gerr = NULL;
         strList **tail = &p->cpr_exec_command;
-- 
2.50.1


