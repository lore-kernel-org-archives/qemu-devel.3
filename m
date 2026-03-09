Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1E3FCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPH-0004kY-MW; Mon, 09 Mar 2026 16:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP9-0004gS-Kr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP7-0007mY-9p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3uE0Cza8Sev8WzpzBMRzQgJnwUI7D6cI8Y40IS2isk=;
 b=S1TL6/vS1mUJp+FUAeewrPu7K9eeiqguZvYDbLk64Z+96LiNNSCadd/sJJpwm3pMlKwo/V
 l3oKxp74iewiLED7RE9l5HrEmVM0fI4juxDnUxLtHaPdREGhwTSnu+raz/yFZda9ASibhu
 a2/QyT1GIKbJCkQCc2T0A3gyU+d4J50=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-4SCYGUxWOWuEbSyo_juqhw-1; Mon, 09 Mar 2026 16:40:37 -0400
X-MC-Unique: 4SCYGUxWOWuEbSyo_juqhw-1
X-Mimecast-MFC-AGG-ID: 4SCYGUxWOWuEbSyo_juqhw_1773088837
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd7c4ab845so906668885a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088837; x=1773693637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3uE0Cza8Sev8WzpzBMRzQgJnwUI7D6cI8Y40IS2isk=;
 b=dy9gZUifij5p2criAoJXQ4A1JXvrepXTYgirlHak8eDmfuvAqFVbd2b+NMhhLrDYhZ
 sRp7/nJVWgZYExfwstO+zKjmdpfBpjjjC9z1QIiQZ8M1KHFbtHp9jWQhATovxcCjOmed
 bNCF6cFuMKuqzjc08xmieHujnoGNyztHMNrQpJ1dqCIEm5uzwZqVAeb8JsvF79ceBP3B
 XO6Ko5YnwaKaJZi/RkPPLeis0xMRTjE+/DIYr5RZfHONU5lX7KgEKPMG67pK9NHJo2O6
 kVbhcUlKSgZYNHzavS0p3tZTZsxJJdfN4O/9xYD4WgXOYi3kRDOLh5HooxX/E8lrq0R3
 UBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088837; x=1773693637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T3uE0Cza8Sev8WzpzBMRzQgJnwUI7D6cI8Y40IS2isk=;
 b=lcwam0kzN1J9aiHTSSpAxb0Wqv1J+x9J4Gk1qHrR4vCHf3SRI6ZnDo2STbV6c8sEb4
 kkG7s0c1A95ciQivXhAFt7iqbevqi6aDkUiwx7o6gnizs68E9RmKJcZRqfijhZX52RG1
 oVXxrMfLXqMESFct8liKKCsW8FFDNjQtcWKuB+etI1FFQwZuuvF++eOJ+vYtGl1EkXip
 e8cXuXTZXOTyTmK8i6w+x3u8K3S6Ef1O6TrOw4veLGuIJNnqb2stFiWy9sKb5qUqgp41
 l9Qy1iJxcUyzC7wRvxKAOInFXVdG1Ykpzji81SINfVWjiTQSxsnojmGCSAjmdd5oiJ/T
 aPLw==
X-Gm-Message-State: AOJu0YySgXS8olH6+kBiAwJOIq7pYxqB/e5+z3esGmRFXReH4O1cFa4B
 LRhxRbeUXIN3jFewFFYh5Fb8gjIMTHvMHNed2WaincqV+yOmsmI87AUdq2Ctzry/40OLcVRHU1K
 iJ6QQPaIEPTFDD5GdtGgw9WNpddtrrLviyz3NyCb/ieuNT3Pabj9LdovRruhkz5gl/N21/gs10s
 hTx9VIh5LpS28XHBZqqzIn8h0gtrarLD9vuPs+9w==
X-Gm-Gg: ATEYQzxCazBSfqczrOdlmvkn2a5fKJIsQxuMKtucsXLcIq8uQUOFm258PY0pidsod4T
 1QTzCMOx2IX7FuM0NW/4SLQiPih3sxgUy5dDykMx3GSs4ZRSI0YocQ2qaQdZ5Lu9aen8K2ELXQ+
 rCz3Kkm/wrdcdfsX5oUZg01zb19g/S/QVfRMQxgzvDrfe6+OctuLQFz3Lbpi8j7GnoF42PnJHwX
 90O4gg/RVhgjQ2nqfz1Jqze2Fkro/r6HB3+1rDQzm2y+GsAFP3BHsaC2LTo88IBDc2YTvIYV7W8
 NyeZoO3Rxl2csdSy8GSMaOJvFOGMBv4UTiYlEbFMmNlVq4+PWcDJ9i9J/81bNs3v8aQlT+jb8+T
 QLoIvX9Uim9PVGdV7PUCfHtrrgwaB/LxlBlkNNJLhfr9/j2spxPQYoqkc/vU5dmJYg1uwqglQ+V
 HA/JK00w==
X-Received: by 2002:a05:620a:290e:b0:8cb:d9a2:1347 with SMTP id
 af79cd13be357-8cd6d464c4amr1512522685a.57.1773088836671; 
 Mon, 09 Mar 2026 13:40:36 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8cb:d9a2:1347 with SMTP id
 af79cd13be357-8cd6d464c4amr1512518485a.57.1773088836009; 
 Mon, 09 Mar 2026 13:40:36 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PULL 13/18] system/memory: minor doc fix
Date: Mon,  9 Mar 2026 16:40:02 -0400
Message-ID: <20260309204007.1709441-14-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Link: https://lore.kernel.org/r/20260226140001.3622334-5-marcandre.lureau@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index d6b5ca13c2..a9b0e19be8 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -574,7 +574,7 @@ struct RamDiscardListener {
      * new population (e.g., unmap).
      *
      * @rdl: the #RamDiscardListener getting notified
-     * @section: the #MemoryRegionSection to get populated. The section
+     * @section: the #MemoryRegionSection to get discarded. The section
      *           is aligned within the memory region to the minimum granularity
      *           unless it would exceed the registered section.
      */
-- 
2.50.1


