Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B25CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZC-00024G-L4; Wed, 20 May 2026 17:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZA-0001zE-Uz
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZ9-0007Mh-G0
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TylKlVXWNtUVl8Uzn5nHhOOFc5t1shMCS/NhQwh3Ug=;
 b=aCWJRuJMB0UnmAn5RV1ofAC6Z3xAllAwAW7NoQh9rF9nE4Qdc0wA64gmFu4TVXHc2ZT/x9
 Lw/rqzxtClW26DXeSfYgCW9EbHj5aHmcQmFL0nszsRXrPU1tQGDi0uA2Flr9q/54lfSA8W
 nU5W/OeuXEjI8e/WqWajBDLpScvVvDw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-VJxM0GksMRSh2WAJG8c1cA-1; Wed, 20 May 2026 17:34:57 -0400
X-MC-Unique: VJxM0GksMRSh2WAJG8c1cA-1
X-Mimecast-MFC-AGG-ID: VJxM0GksMRSh2WAJG8c1cA_1779312896
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8acb85a973cso23117546d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312896; x=1779917696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TylKlVXWNtUVl8Uzn5nHhOOFc5t1shMCS/NhQwh3Ug=;
 b=ZIHhxV0cO+qhwxCCU53YS9k1WGYNLrfwje9+KOqUEkcuqlprpEdKxnnxP9RVv/VrRr
 bkko4BJeEAKO9b0knlFV20lwhP1EOfScPE5sSoG8kmFq0B/dx+NeLgSZrZlXH4RWI25w
 tpisCR/JMn8aO/ZM/nPPcSURQpNBalKADpbq/fkUlMhzaElJ+0vDxLkEtzpDhq3N4Ahf
 djRvB9WIlpL27y/eofHsQBXKYpN0ynONboiTIbwCYPrydKYpljrUs43BiXuW0y7iAeAk
 +SeCwKi29oaG4bjSg9gZ4v9xsq7l0seovyeWLHaRgwh7YREppNcTud5QRXWJEERvlJcc
 HYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312896; x=1779917696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8TylKlVXWNtUVl8Uzn5nHhOOFc5t1shMCS/NhQwh3Ug=;
 b=Dx2RwclSIjB9CXd79lIxZHPzm3WsBSxHNWN/jASK2rxycjlBMaN44noUfhp8jge3Xb
 sYbuobdovKk5NAV6VsOL0GTrxllZX6knNUyMHvC3caV7oID0ZWhDNzz40WQwMX6NMn3q
 iGOeBrpU4dbAN+K0kXY+UTgdVHZwBhHV+ArFR1fta9bGe79U4j4jpkp9wBi0/S4GROeD
 BAdFJHpkOyAwy5uWbiMDEPCobJPUpqBuBVpCzXPBVTT9WhDGScAJI0S/45be578xpiYU
 JtyoUPjTaWqK2JnOPTSmpDtoE+oshAe21pUhERQ6DoJHes9WdK6I8sP/bJzMHB72OAcX
 sczA==
X-Gm-Message-State: AOJu0YwQZqmb/54Fl89049K+1MAe+aPbGzVbNVbOoe0YRcz2NQMWIlqq
 1obfnB0zlSh30EkSB1kxG+y10WXrkYbHTlhBOhMzc9UGy6pIktWBpX8IZ0f+ACb9doLUS4THkHq
 rAzUekcBEF95409huonEk5G8TQLS9a/Ygn4XqAnJG6w/lsK5Cndy6Fp7KDpycOqvQ1cRRcFtqrm
 OmY8iS74UX35eM0l4F9l8hn27rWtFHKf0FyxfIYA==
X-Gm-Gg: Acq92OHqTe4NYwZdArJqa2asKL4ubTP82T3WyOEdclrmu8CJIvRBH+FizyGRuC0qgQ6
 7YnufEx06KGJosmwNdnm64tQP+sIwvwqGLdODUEqCd+CcZzO6vLNPAcTkEXPAjQ9pW7aoEPiTbb
 zbge+54Ps0IAVLKRXtUn8g+/EUDRerAGO6kzgij8KJO8RdcGrn+jWA/tljdIvWHwRnbo234wFC/
 L0cYAa05q/SvMXlGnqKCReUDHj1kkzuKx37FJnw89odpxkC9UeVM0i5LYLD6wqlsCrlkVHNYaXv
 vfW2RonNYpWtfV8gQwzTWqyteclrGcwUntjnfcYhyEWGeK7F078Gu8puGm3csdCUX3ZSePZUomz
 mDTOKuMBy3TKLwVEYpbOydouZfuKX+6XiZUmmNgmcomuJ
X-Received: by 2002:a05:6214:5094:b0:8ac:a744:7789 with SMTP id
 6a1803df08f44-8cc6e2d3304mr4755486d6.5.1779312896525; 
 Wed, 20 May 2026 14:34:56 -0700 (PDT)
X-Received: by 2002:a05:6214:5094:b0:8ac:a744:7789 with SMTP id
 6a1803df08f44-8cc6e2d3304mr4754986d6.5.1779312895913; 
 Wed, 20 May 2026 14:34:55 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 22/29] migration/global_state: replace strcpy("") with explicit
 NUL termination
Date: Wed, 20 May 2026 17:33:50 -0400
Message-ID: <20260520213357.40646-23-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

From: Bin Guo <guobin@linux.alibaba.com>

Drop the unnecessary strcpy of an empty literal (and its spurious
(char *)& cast) in favor of a direct NUL store, which avoids the
libc call and hides no bugs behind a cast.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260518110112.21395-3-guobin@linux.alibaba.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/global_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index c1f90fce0f..91fefdf525 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -148,7 +148,7 @@ static const VMStateDescription vmstate_globalstate = {
 void register_global_state(void)
 {
     /* We would use it independently that we receive it */
-    strcpy((char *)&global_state.runstate, "");
+    global_state.runstate[0] = '\0';
     global_state.received = false;
     vmstate_register(NULL, 0, &vmstate_globalstate, &global_state);
 }
-- 
2.53.0


